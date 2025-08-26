{{- define "common.valuesContext" }}
{{- $defaultValues := dict
  "_configMaps" (list)
  "_services" (list)
  "_volumes" (list)
  "_volumeMounts" (list)
  "_image" (dict
    "repository" ""
    "tag" "0.0.0"
	"pullPolicy" "IfNotPresent"
	"pullSecret" (list)
  )
  "_pod" (dict "securityContext" (dict))
  "_serviceAccount" (dict "name" "default")
  "_initContainer" (dict "enabled" false)
  "_container" (dict
    "name" "{{ .Chart.Name }}"
    "args" (list)
    "command" (list)
    "env" (list)
    "image" "{{ .Values._image.repository }}:{{ .Values._image.tag }}"
    "imagePullPolicy" "{{ .Values._image.pullPolicy }}"
    "securityContext" (dict)
    "livenessProbe" (dict)
    "readinessProbe" (dict)
    "resources" (dict)
  ) }}
{{- $_ := set . "Values" (mustMerge $defaultValues .Values) }}
{{- end }} 
