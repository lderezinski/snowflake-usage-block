view: last_load {



  derived_table: {
    sql:select schema_name, table_name, MAX(LAST_LOAD_TIME) as last_load_time
      from load_history
      where status = 'LOADED' and LAST_LOAD_TIME > ADD_MONTHS(CURRENT_DATE(), -2)
      group by 1, 2 ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: schema_name {
    description: "database schema"
    type: string
    sql: ${TABLE}.schema_name ;;
  }

  dimension: table_name {
    description: "database table name"
    type: string
    sql: ${TABLE}.table_name ;;
  }

  dimension_group: last_load_time {
    description: "last loaded row timestamp"
    type: time
    timeframes: [date, week, month, year, time]
    sql: ${TABLE}.last_load_time ;;
  }
}
