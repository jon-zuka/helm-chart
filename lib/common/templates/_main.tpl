{{- define "common.main" }}
{{- include "common.valuesContext" . }}
{{- include "common.eval" . }}
{{- include "common.configMapsContext" . }}
{{- include "common.configMaps" . }}
{{- include "common.deployment" . }}
{{- end }}
