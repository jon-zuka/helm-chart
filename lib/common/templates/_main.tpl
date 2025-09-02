{{- define "common.main" }}
{{- include "common.servicesContext" . }}
{{- include "common.secretsContext" . }}
{{- include "common.valuesContext" . }}
{{- include "common.eval" . }}
{{- include "common.configMapsContext" . }}
{{- include "common.configMaps" . }}
{{- include "common.secrets" . }}
{{- include "common.deployment" . }}
{{- include "common.services" . }}
{{- include "common.hpa" . }}
{{- end }}
