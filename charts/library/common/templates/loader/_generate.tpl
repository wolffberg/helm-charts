{{/*
Secondary entrypoint and primary loader for the common chart
*/}}
{{- define "common.loader.generate" -}}
  {{- /* Enable code-server add-on if required */ -}}
  {{- if .Values.addons.codeserver.enabled -}}
    {{- include "common.addon.codeserver" . | nindent 0 -}}
  {{- end -}}

  {{- /* Enable VPN add-on if required */ -}}
  {{- if .Values.addons.vpn.enabled -}}
    {{- include "common.addon.vpn" . | nindent 0 -}}
  {{- end -}}

  {{- /* Enable netshoot add-on if required */ -}}
  {{- if .Values.addons.netshoot.enabled -}}
    {{- include "common.addon.netshoot" . | nindent 0 -}}
  {{- end -}}

  {{- /* Build the templates */ -}}
  {{- include "common.render.pvcs" . | nindent 0 -}}
  {{- include "common.render.serviceAccount" . | nindent 0 -}}
  {{- include "common.render.controller" . | nindent 0 -}}
  {{- include "common.render.services" . | nindent 0 -}}
  {{- include "common.render.ingresses" . | nindent 0 -}}
  {{- include "common.render.serviceMonitors" . | nindent 0 -}}
  {{- include "common.render.routes" . | nindent 0 -}}
  {{- include "common.render.configmaps" . | nindent 0 -}}
  {{- include "common.render.secrets" . | nindent 0 -}}
{{- end -}}
