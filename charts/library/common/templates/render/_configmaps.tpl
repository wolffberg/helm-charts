{{/*
Renders the configMap objects required by the chart.
*/}}
{{- define "common.render.configmaps" -}}
  {{- /* Generate named configMaps as required */ -}}
  {{- range $name, $configmap := .Values.configMaps -}}
    {{- if $configmap.enabled -}}
      {{- $configmapValues := $configmap -}}

      {{- /* set the default nameOverride to the configMap name */ -}}
      {{- if not $configmapValues.nameOverride -}}
        {{- $_ := set $configmapValues "nameOverride" $name -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "configmap" $configmapValues) -}}
      {{- include "common.class.configmap" $ | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
