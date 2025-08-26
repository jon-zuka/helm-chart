{{- define "common.eval" -}}
  {{- /* Default values */ -}}
  {{- $ := . -}}
  {{- $depth := 20 -}}
  {{- $subcall := false  -}}

  {{- /* Extra args are passed (by user or with sub call) */ -}}
  {{- if kindIs "slice" . }}
    {{- $ = index . 0 -}}
    {{- $depth =  index . 1 -}}
    {{- if gt (len .) 2 -}}
      {{- $subcall = ( index . 2)  -}}
    {{- end }}
  {{- end -}}

  {{- /* Skip if already templated */ -}}
  {{- if not (hasKey $ "__valuesAreTemplated")  -}}

    {{- $original := $.Values | toYaml  -}}
    {{- $templated := ""  -}}

    {{- /* Apply tpl to current values */ -}}
    {{- with $ -}}{{- $templated = tpl $original $  -}}{{- end -}}
    {{- $_ := set $ "Values" ($templated | fromYaml) -}}

    {{- /* Execute next iteration if values have changed with templating */ -}}
    {{- if $templated | ne  $original -}}
      {{- if gt $depth 0  -}}
        {{- include "common.eval" (list $ ( sub $depth 1) true) }}
      {{- else -}}
        {{- fail "Failed to template Values, likely recursive values dependencies" -}}
      {{- end -}}
    {{- end -}}

    {{- if not $subcall }}
      {{- /* Mark values as already templated */ -}}
      {{- $_ := set $ "__valuesAreTemplated" true -}}
    {{- end -}}

  {{- end -}}

{{- end -}}

