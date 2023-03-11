{{/*
Renders the Service objects required by the chart.
*/}}
{{- define "common.render.services" -}}
  {{- /* Generate named services as required */ -}}
  {{- range $name, $service := .Values.service -}}
    {{- $serviceEnabled := true -}}
    {{- if hasKey $service "enabled" -}}
      {{- $serviceEnabled = $service.enabled -}}
    {{- end -}}
    {{- if $serviceEnabled -}}
      {{- $serviceValues := $service -}}

      {{/* set the default nameOverride to the service name */}}
      {{- if and (not $serviceValues.nameOverride) (ne $name (include "common.lib.service.primary" $)) -}}
        {{- $_ := set $serviceValues "nameOverride" $name -}}
      {{ end -}}

      {{/* Include the Service class */}}
      {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
      {{- include "common.class.service" $ | nindent 0 -}}
      {{- $_ := unset $.ObjectValues "service" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
