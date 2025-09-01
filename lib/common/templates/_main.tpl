{{- define "common.main" }}
{{- include "common.servicesContext" . }}
{{- include "common.valuesContext" . }}
{{- include "common.eval" . }}
{{- include "common.configMapsContext" . }}
{{- include "common.configMaps" . }}
{{- include "common.deployment" . }}
{{- include "common.services" . }}
{{- end }}
