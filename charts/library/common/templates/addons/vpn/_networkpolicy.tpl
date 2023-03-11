{{/*
Blueprint for the NetworkPolicy object that can be included in the addon.
*/}}
{{- define "common.addon.vpn.networkpolicy" -}}
{{- if .Values.addons.vpn.networkPolicy.enabled }}
---
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: {{ include "common.lib.chart.names.fullname" . }}
  {{- with (merge (.Values.addons.vpn.networkPolicy.labels | default dict) (include "common.lib.metadata.allLabels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge (.Values.addons.vpn.networkPolicy.annotations | default dict) (include "common.lib.metadata.globalAnnotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  podSelector:
    {{- with (merge .Values.addons.vpn.networkPolicy.podSelectorLabels (include "common.lib.metadata.selectorLabels" . | fromYaml)) }}
    matchLabels: {{- toYaml . | nindent 6 }}
    {{- end }}
  policyTypes:
    - Egress
  egress:
    {{- with .Values.addons.vpn.networkPolicy.egress }}
      {{- . | toYaml | nindent 4 }}
    {{- end -}}
{{- end -}}
{{- end -}}
