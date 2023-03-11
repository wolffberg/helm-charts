{{/*
This template serves as a blueprint for Deployment objects that are created
using the common library.
*/}}
{{- define "common.class.deployment" -}}
  {{- $strategy := default "Recreate" .Values.controller.strategy -}}
  {{- if and (ne $strategy "Recreate") (ne $strategy "RollingUpdate") -}}
    {{- fail (printf "Not a valid strategy type for Deployment (%s)" $strategy) -}}
  {{- end -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "common.lib.chart.names.fullname" . }}
  {{- with include "common.lib.controller.metadata.labels" . }}
  labels: {{- . | nindent 4 }}
  {{- end }}
  {{- with include "common.lib.controller.metadata.annotations" . }}
  annotations: {{- . | nindent 4 }}
  {{- end }}
spec:
  revisionHistoryLimit: {{ .Values.controller.revisionHistoryLimit }}
  replicas: {{ .Values.controller.replicas }}
  strategy:
    type: {{ $strategy }}
    {{- with .Values.controller.rollingUpdate }}
      {{- if and (eq $strategy "RollingUpdate") (or .surge .unavailable) }}
    rollingUpdate:
        {{- with .unavailable }}
      maxUnavailable: {{ . }}
        {{- end }}
        {{- with .surge }}
      maxSurge: {{ . }}
        {{- end }}
      {{- end }}
    {{- end }}
  selector:
    matchLabels:
      {{- include "common.lib.metadata.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      {{- with include ("common.lib.metadata.podAnnotations") . }}
      annotations:
        {{- . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "common.lib.metadata.selectorLabels" . | nindent 8 }}
        {{- with .Values.podLabels }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
    spec:
      {{- include "common.lib.controller.pod" . | nindent 6 }}
{{- end -}}
