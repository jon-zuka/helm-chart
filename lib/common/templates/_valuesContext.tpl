{{- define "common.valuesContext" }}
{{- $defaultValues := dict
  "_configMaps" (list)
  "_services" (list)
  "_volumes" (list)
  "_volumeMounts" (list)
  "_image" (dict
    "repository" "todo"
    "tag" "0.0.0"
	"pullPolicy" "IfNotPresent"
	"pullSecrets" (list)
  )
  "_pod" (dict "securityContext" (dict))
  "_serviceAccount" (dict "name" "default")
  "_initContainer" (dict "enabled" false)
  "_container" (dict
    "resources" (dict
      "requests" (dict
        "memory" "400Mi"
        "cpu" "100m"
      )
      "limits" (dict
        "memory" "1Gi"
        "cpu" "1200m"
      )
    )
    "name" .Chart.Name
    "args" (list)
    "command" (list)
    "env" (list)
    "image" "{{ .Values._image.repository }}:{{ .Values._image.tag }}"
    "imagePullPolicy" "{{ .Values._image.pullPolicy }}"
    "securityContext" (dict)
    "livenessProbe" (dict
      "httpGet" (dict
        "path" "/"
        "port" ((index (index .Values._services 0).ports 0).containerPort)
      )
      "initialDelaySeconds" 20
      "periodSeconds" 10
    )
    "readinessProbe" (dict
      "httpGet" ( dict
        "path" "/"
        "port" ((index (index .Values._services 0).ports 0).containerPort)
      )
      "initialDelaySeconds" 20
      "periodSeconds" 10
    )
    "resources" (dict)
  ) }}
{{- $_ := set . "Values" (mustMerge .Values $defaultValues) }}
{{- end }} 
