terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.70.6"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_metric_dashboard" "otel_collector_hostmetrics_paging_dashboard" {

  project_name   = var.lightstep_project
  dashboard_name = "OpenTelemetry / Host Metrics / Paging"


  chart {
    name = "Usage used/free"
    rank = "0"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "bar"
      hidden     = false

      metric              = "system.paging.usage"
      timeseries_operator = "last"


      group_by {
        aggregation_method = "sum"
        keys               = ["state", ]
      }
    }
  }

  chart {
    name = "Operations"
    rank = "1"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "system.paging.operations"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["direction", ]
      }
    }
  }

  chart {
    name = "Faults"
    rank = "2"
    type = "timeseries"

    query {
      query_name = "a"
      display    = "line"
      hidden     = false

      metric              = "system.paging.faults"
      timeseries_operator = "rate"


      group_by {
        aggregation_method = "sum"
        keys               = ["type", ]
      }

    }
  }
}
