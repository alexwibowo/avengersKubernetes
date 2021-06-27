{{- define "avengers-httpd.host" -}}
{{- printf "cr1-avengers-httpd.default.svc.cluster.local"  }}
{{- end }}

{{- define "avengers-app.host" -}}
{{- printf "cr1-avengers-app.default.svc.cluster.local" }}
{{- end }}

{{- define "avengers-httpd.gateway" -}}
{{- printf "%s-avengers-httpd-gw" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "avengers-app.gateway" -}}
{{- printf "%s-avengers-app-gw" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "avengers-httpd.virtualServiceName" -}}
{{- printf "%s-avengers-httpd-vs" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "avengers-app.virtualServiceName" -}}
{{- printf "%s-avengers-app-vs" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "avengers-httpd.destRule" -}}
{{- printf "%s-avengers-httpd-destrule" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "avengers-app.destRule" -}}
{{- printf "%s-avengers-app-destrule" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "avengers-httpd-tls-credentialName" -}}
{{- printf "default-lowtrust-avengers-local-credential" }}
{{- end }}
