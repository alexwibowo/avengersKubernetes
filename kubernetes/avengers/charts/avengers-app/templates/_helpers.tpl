{{/*
Expand the name of the chart.
*/}}
{{- define "avengers-app.name" -}}
{{- "avengers-app" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "avengers-app.fullname" -}}
{{- $name := .Chart.Name }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "avengers-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "avengers-app.labels" -}}
helm.sh/chart: {{ include "avengers-app.chart" . }}
{{ include "avengers-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "avengers-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "avengers-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "avengers-app.serviceAccountName" -}}
{{- include "avengers-app.fullname" . }}
{{- end }}
