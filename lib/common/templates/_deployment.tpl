{{- define "common.deployment" }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "common.fullname" . }}
  labels: {{ include "common.labels" . | nindent 4}}
spec:
  selector:
    matchLabels: {{ include "common.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels: {{ include "common.labels" . | nindent 8 }}
      annotations:
        checksum/config: {{ .Values | toYaml | sha256sum }}
    spec:
      {{- with .Values._image.pullSecrets }}
      imagePullSecrets: {{ . | toYaml | nindent 8 }}
      {{- end }}
      securityContext: {{ .Values._pod.securityContext | toYaml | nindent 8 }}
      serviceAccountName: {{ .Values._serviceAccount.name }}
      {{- if .Values._initContainer.enabled }}
      {{- with .Values._initContainer }}
      initContainers:
        - name: {{ .name }}
          image: {{ .image }}
          command: {{ .command }}
          args: {{ .args }}
      {{- end }}
      {{- end }}
      {{- with .Values._container }}
      containers:
        - name: {{ .name }}
          command: {{ .command | toYaml | nindent 12 }}
          args: {{ .args | toYaml | nindent 12 }}
          image: {{ .image }}
          imagePullPolicy: {{ .imagePullPolicy }}
          securityContext: {{ .securityContext | toYaml | nindent 12 }}
          livenessProbe: {{ .livenessProbe | toYaml | nindent 12 }}
          readinessProbe: {{ .readinessProbe | toYaml | nindent 12 }}    
          {{- with $.Values._services }}
          ports:
            {{- range . }}
            {{- range .ports }}
            - name: {{ .name }}
              containerPort: {{ .containerPort }}
            {{- end }}
            {{- end }}
          {{- end }}
          volumeMounts: {{ toYaml $.Values._volumeMounts | nindent 12 }}
      {{- end }}
      volumes: {{ toYaml .Values._volumes | nindent 8 }}
{{- end }}
