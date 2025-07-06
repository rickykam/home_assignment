-- macros/build_event_table.sql
{% macro build_event_table(event_list) %}

    where event_type in ({{ "'" ~ event_list | join("','") ~ "'" }})

{% endmacro %}


