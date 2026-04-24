include: "/01_metadata/sales_region.view"

view: +sales_region {
  
  parameter: p_dimension {
    type: unquoted
    allowed_value: {
      label: "Team Name"
      value: "team_name"
    }
    allowed_value: {
      label: "City"
      value: "city"
    }
    default_value: "team_name"
  }

  dimension: dynamic_dimension {
    label_from_parameter: p_dimension
    sql: 
      {% if p_dimension._parameter_value == 'team_name' %}
        ${team_name}
      {% else %}
        ${city}
      {% endif %} ;;
  }

  filter: filter_fiscal_year {
    type: number
    label: "Año Fiscal"
  }

  filter: filter_fiscal_week {
    type: number
    label: "Semana Fiscal"
  }
}
