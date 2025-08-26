{{- define "common.configMaps" }}
{{- range .Values._configMaps }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ printf "%s-%s" (include "common.fullname" $) .name }}
data:
  {{- range $key, $value := .data }}
  {{ $key }}: |
    {{- tpl $value $ | nindent 4 }}
  {{- end }}
---
{{- end }}
{{- end }}


{{- define "common.configMapsContext" }}
{{- $mounts := .Values._volumeMounts | default list }}
{{- $volumes := .Values._volumes | default list }}

{{- range .Values._configMaps }}
{{- $fullname :=  printf "%s-%s" (include "common.fullname" $) .name }}
{{- $name := .name }}
{{- $path := .path }}
{{- $items := list }}

{{- range $key, $value := .data }}
{{- $items = append $items (dict "key" $key "path" $key) }}
{{- $mount :=  dict
  "name" $name
  "mountPath" (printf "%s/%s" $path $key)
  "subPath" $key }}
{{- $mounts = append $mounts $mount }}
{{- end }}

{{- $volume := dict
  "name" .name
  "configMap" (dict "name" $fullname "items" $items) }}
{{- $volumes = append $volumes $volume }}
{{- end }}

{{- $override := dict 
  "Values" (dict 
      "_volumeMounts" $mounts
      "_volumes" $volumes) 
}}

{{- $_ := set .Values "_volumeMounts" $mounts }}
{{- $_ := set .Values "_volumes" $volumes }}
{{- end }}
