{{- define "common.services" }}
{{- range .Values._services }}
apiVersion: v1
kind: Service
metadata:
  name: {{ printf "%s-%s" (include "common.fullname" $) .name }}
  labels:
    {{- include "common.labels" $ | nindent 4 }}
spec:
  type: {{ .type }}
  ports:
  {{- range .ports }}
    - name: demo
      port: {{ .port }}
      targetPort: {{ .containerPort }}
      protocol: {{ .protocol }}
  {{- end }}
  selector: {{- include "common.selectorLabels" $ | nindent 4 }}
---
{{- end }} 
{{- end }}


{{- define "common.servicesContext" }}
{{- $services := .Values._services }}
{{- range $services }}
{{ $_ := set . "type" (.type | default "ClusterIP") }}
  {{- range .ports }}
    {{ $_ := set . "containerPort" (.containerPort | default .port) | int}}
    {{ $_ := set . "protocol" (.protocol | default "TCP") }}
  {{- end }}
{{- end }}
{{- end }} 
