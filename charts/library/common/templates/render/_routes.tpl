{{/* Renders the Route objects required by the chart */}}
{{- define "common.render.routes" -}}
  {{- /* Generate named routes as required */ -}}
  {{- range $name, $route := .Values.route }}
    {{- if $route.enabled -}}
      {{- $routeValues := $route -}}

      {{/* set defaults */}}
      {{- if and (not $routeValues.nameOverride) (ne $name (include "common.lib.route.primary" $)) -}}
        {{- $_ := set $routeValues "nameOverride" $name -}}
      {{- end -}}

      {{- $_ := set $ "ObjectValues" (dict "route" $routeValues) -}}
      {{- include "common.class.route" $ | nindent 0 -}}
      {{- $_ := unset $.ObjectValues "route" -}}
    {{- end }}
  {{- end }}
{{- end }}
