{{/*
The OpenVPN config secret to be included.
*/}}
{{- define "common.addon.vpn.secret" -}}
{{- if and .Values.addons.vpn.configFile (not .Values.addons.vpn.configFileSecret) -}}
vpnConfigfile: |-
  {{- .Values.addons.vpn.configFile | nindent 2 }}
{{- end -}}
{{- end -}}
