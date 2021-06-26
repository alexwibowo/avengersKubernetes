{{/*
Expand the name of the chart.
*/}}
{{- define "avengers-httpd.name" -}}
{{- "avengers-httpd" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "avengers-httpd.fullname" -}}
{{- $name := .Chart.Name }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "avengers-httpd.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "avengers-httpd.labels" -}}
helm.sh/chart: {{ include "avengers-httpd.chart" . }}
{{ include "avengers-httpd.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "avengers-httpd.selectorLabels" -}}
app.kubernetes.io/name: {{ include "avengers-httpd.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "avengers-httpd.serviceAccountName" -}}
{{- include "avengers-httpd.fullname" . }}
{{- end }}
