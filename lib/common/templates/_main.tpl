{{- define "common.main" }}
{{- include "common.eval" . }}
{{- include "common.configMapsContext" . }}
{{- include "common.configMaps" . }}
{{- include "common.deployment" . }}
{{- end }}
