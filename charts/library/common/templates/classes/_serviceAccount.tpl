{{/*
This template serves as a blueprint for ServiceAccount objects that are created
using the common library.
*/}}
{{- define "common.class.serviceAccount" -}}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "common.lib.chart.names.serviceAccountName" . }}
  {{- with include "common.lib.metadata.allLabels" $ | fromYaml }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge (.Values.serviceAccount.annotations | default dict) (include "common.lib.metadata.globalAnnotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
secrets:
  - name: {{ include "common.lib.chart.names.fullname" . }}-sa-token
{{- end -}}
