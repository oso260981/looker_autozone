include: "/01_metadata/sales_region.view"

view: +sales_region {

  # --- Dimensiones del Excel ---

  dimension: group_name {
    type: string
    sql: ${TABLE}.group_name ;;
    label: "Group"
  }

  dimension: director {
    type: string
    sql: ${TABLE}.director ;;
    label: "Director"
  }

  dimension: cm {
    type: string
    sql: ${TABLE}.cm ;;
    label: "CM"
  }

  dimension: customer_type {
    type: string
    sql: ${TABLE}.customer_type ;;
    label: "Customer Type"
  }

  dimension: category_name {
    type: string
    sql: ${TABLE}.category_name ;;
    label: "Category"
  }

  dimension: team_name {
    type: string
    sql: ${TABLE}.team_name ;;
    label: "Team"
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    label: "City"
  }

  dimension: period_type {
    hidden: yes
    type: string
    sql: ${TABLE}.period_type ;;
  }

  dimension: is_ytd_ty {
    hidden: yes
    type: number
    sql: ${TABLE}.is_ytd_ty ;;
  }

  dimension: is_ytd_ly {
    hidden: yes
    type: number
    sql: ${TABLE}.is_ytd_ly ;;
  }

  # --- Filtros ---

  filter: filter_fiscal_year {
    type: number
    label: "Año Fiscal"
  }

  filter: filter_fiscal_week {
    type: number
    label: "Semana Fiscal"
  }

  # --- Medidas Semanales (LW) ---

  measure: sales_ty {
    group_label: "Weekly"
    label: "Wk31 2026 Sales"
    type: sum
    sql: ${TABLE}.sales ;;
    filters: [period_type: "TY"]
    value_format_name: usd_0
  }

  measure: sales_ly {
    group_label: "Weekly"
    label: "Wk31 2025 Sales"
    type: sum
    sql: ${TABLE}.sales ;;
    filters: [period_type: "LY"]
    value_format_name: usd_0
  }

  measure: sales_variance_pct {
    group_label: "Weekly"
    label: "Sales % Chg (Wk)"
    type: number
    sql: (${sales_ty} - ${sales_ly}) / NULLIF(${sales_ly}, 0) ;;
    value_format_name: percent_1
  }

  # --- Medidas YTD ---

  measure: sales_ytd_ty {
    group_label: "YTD"
    label: "YTD 2026 Sales"
    type: sum
    sql: ${TABLE}.sales ;;
    filters: [is_ytd_ty: "1"]
    value_format_name: usd_0
  }

  measure: sales_ytd_ly {
    group_label: "YTD"
    label: "YTD 2025 Sales"
    type: sum
    sql: ${TABLE}.sales ;;
    filters: [is_ytd_ly: "1"]
    value_format_name: usd_0
  }

  measure: sales_ytd_variance_pct {
    group_label: "YTD"
    label: "Sales % Chg (YTD)"
    type: number
    sql: (${sales_ytd_ty} - ${sales_ytd_ly}) / NULLIF(${sales_ytd_ly}, 0) ;;
    value_format_name: percent_1
  }

  measure: gp_ytd_ty {
    group_label: "YTD"
    label: "YTD 2026 GP"
    type: sum
    sql: ${TABLE}.gross_profit ;;
    filters: [is_ytd_ty: "1"]
    value_format_name: usd_0
  }

  measure: gp_ytd_ly {
    group_label: "YTD"
    label: "YTD 2025 GP"
    type: sum
    sql: ${TABLE}.gross_profit ;;
    filters: [is_ytd_ly: "1"]
    value_format_name: usd_0
  }

  measure: gp_variance_pct {
    group_label: "YTD"
    label: "GP % Chg"
    type: number
    sql: (${gp_ytd_ty} - ${gp_ytd_ly}) / NULLIF(${gp_ytd_ly}, 0) ;;
    value_format_name: percent_1
  }

  measure: units_ytd_ty {
    group_label: "YTD"
    label: "YTD 2026 Units"
    type: sum
    sql: ${TABLE}.units ;;
    filters: [is_ytd_ty: "1"]
    value_format: "#,##0"
  }

  measure: units_ytd_ly {
    group_label: "YTD"
    label: "YTD 2025 Units"
    type: sum
    sql: ${TABLE}.units ;;
    filters: [is_ytd_ly: "1"]
    value_format: "#,##0"
  }

  measure: units_variance_pct {
    group_label: "YTD"
    label: "Units % Chg"
    type: number
    sql: (${units_ytd_ty} - ${units_ytd_ly}) / NULLIF(${units_ytd_ly}, 0) ;;
    value_format_name: percent_1
  }

  measure: count {
    type: count
    drill_fields: [category_name, team_name, sales_ytd_ty]
  }
}