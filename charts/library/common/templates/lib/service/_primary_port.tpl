{{/*
Return the primary port for a given Service object.
*/}}
{{- define "common.lib.service.primaryPort" -}}
  {{- $enabledPorts := (include "common.lib.service.enabledPorts" . | fromYaml) }}

  {{- $result := "" -}}
  {{- range $name, $port := $enabledPorts -}}
    {{- if and (hasKey $port "primary") $port.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledPorts | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
