/**
 * Render the placeholder of the plugin during the page load
 *
 * @param p_item
 * @param p_plugin
 * @param p_value
 * @param p_is_readonly
 * @param p_is_printer_friendly
 * @return t_page_item_render_result result type for the rendering function of a region type plug-in
 */
function render (
    p_item                in apex_plugin.t_page_item,
    p_plugin              in apex_plugin.t_plugin,
    p_value               in varchar2,
    p_is_readonly         in boolean,
    p_is_printer_friendly in boolean
) return apex_plugin.t_page_item_render_result is

  c_plugin_namespace  varchar2(200)    := 'at_image_picker';
  l_output_html			  varchar2(32767)  := null;
  l_output_js         varchar2(32767)  := null;
  l_result            apex_plugin.t_page_item_render_result;
  l_values            apex_application_global.vc_arr2;

  c_item_uid          number           := p_item.id; --uid
  c_item_name         varchar2(255)    := p_item.name; --P1_NAME
  --
  c_item_page_id      varchar2(30)     := apex_plugin.get_input_name_for_page_item(p_is_multi_value => true); -- p_t01
  c_ajax_identifier		varchar2(254)    := apex_plugin.get_ajax_identifier;

  -- constant values
  c_item_class		varchar2(254)  := 'image-picker ';
  c_item_div      varchar2(254)  := '<select id="#ID#" name="#NAME#" class="#CLASS#" data-limit="#LIMIT#" #MUTIPLE# #ATTRIBUTES#>#OPTIONS#</select>';

  -- attributes defined section
  l_attr_type_lov    varchar2(30)     := p_item.attribute_01;
  l_attr_lov_query   varchar2(32767)  := p_item.attribute_02;
  l_attr_lov_static  varchar2(32767)  := p_item.attribute_03;

  l_attr_hide_select varchar2(2)  := p_item.attribute_04;
  l_attr_show_label  varchar2(2)  := p_item.attribute_05;
  l_attr_limit       varchar2(2)  := p_item.attribute_06;
  l_attr_multiple    varchar2(2)  := p_item.attribute_07;


  function get_data_from_query(p_sql_statement in varchar2) return varchar2 is

    c_function_namespace varchar2(200) := 'get_data_from_query';
    c_option_div         varchar2(254)  := '<option data-img-src="#IMAGE#" data-img-label="#LABEL#" data-img-class="#CLASS#" data-img-alt="#ALT#" value="#RETURN#" #SELECTED#>#LABEL#</option>';

    l_output_option      varchar2(254)   := null;
    l_output_html			   varchar2(32767) := '';

    -- columns for query
    l_column_value_list    apex_plugin_util.t_column_value_list2;

    c_column_name_id    varchar2(255) := 'RETURN';
    c_column_name_image varchar2(255) := 'IMAGE';
    c_column_name_label varchar2(255) := 'LABEL';
    c_column_name_class varchar2(255) := 'CLASS';
    c_column_name_alt   varchar2(255) := 'ALT';
    c_column_name_tag   varchar2(255) := 'TAG';

    c_column_pos_id     pls_integer;
    c_column_pos_image  pls_integer;
    c_column_pos_label  pls_integer;
    c_column_pos_class  pls_integer;
    c_column_pos_alt    pls_integer;
    c_column_pos_tag    pls_integer;

    /**
    * Gets the number of the column position that corresponds
    * to the named field in the given result identifier.
    *
    * @param p_column_alias     column name
    */
    function get_column_no (p_column_alias in varchar2
                          ,p_is_required in boolean)
      return pls_integer
    is
    begin
      return apex_plugin_util.get_column_no (
        p_attribute_label   => p_column_alias || ' column',
        p_column_alias      => p_column_alias,
        p_column_value_list => l_column_value_list,
        p_is_required       => p_is_required,
        p_data_type         => apex_plugin_util.c_data_type_varchar2);
    end get_column_no;

    /**
    * Gets the number of the column position that corresponds
    * to the named field in the given result identifier.
    *
    * @param p_column_value_list  apex_plugin_util.t_column_value_list2
    * @param p_column_alias     column name
    */
    function get_column_no (p_column_alias in varchar2 )
      return pls_integer
    is
    begin
      for i in 1 .. l_column_value_list.count loop
        if l_column_value_list(i).name = p_column_alias then
          return i;
        end if;
      end loop;

      return null;
    end get_column_no;

    /**
    * Get single value from database based on the given column and row position.
    *
    * @param p_col_pos  column position
    * @param p_row_pos  row position
    * @return value
    */
    function get_column_value(p_col_pos in pls_integer
                            , p_row_pos in pls_integer) return varchar2 is
      p_return_value varchar2(254) := null;
    begin
      if p_col_pos is not null then
        p_return_value := l_column_value_list(p_col_pos).value_list(p_row_pos).varchar2_value;
      end if;
      return p_return_value;
    end get_column_value;

    /**
    * Checks if the given key or index exists in the array.
    *
    * @param p_values  apex_application_global.vc_arr2
    * @param p_value   Value to check varchar2
    * @return returns TRUE on success or FALSE on failure
    */
    function is_exists(p_values in apex_application_global.vc_arr2
                     , p_value  in varchar2) return boolean is
    begin
      for l_row_value in 1..p_values.count loop
        if l_values(l_row_value) = p_value then
          return true;
        end if;
      end loop;

      return false;
    end is_exists;

  begin
    apex_debug.message( c_function_namespace || ' @ begin' );
    apex_debug.message( c_function_namespace || ' @ runnning (generated) query: ' || p_sql_statement );

    -- we get the items from the sql query.
    l_column_value_list := apex_plugin_util.get_data2 (
      p_sql_statement     => p_sql_statement,
      p_min_columns       => 2,
      p_max_columns       => 6,
      p_component_name    => p_item.name );

    c_column_pos_id := get_column_no (
      p_column_alias => c_column_name_id,
      p_is_required => true);

    c_column_pos_image := get_column_no (
      p_column_alias => c_column_name_image,
      p_is_required => true);

    c_column_pos_label := get_column_no (
      p_column_alias => c_column_name_label,
      p_is_required => true);

    c_column_pos_class := get_column_no (p_column_alias => c_column_name_class);
    c_column_pos_alt   := get_column_no (p_column_alias => c_column_name_alt);
    c_column_pos_tag   := get_column_no (p_column_alias => c_column_name_tag);

    apex_debug.message( c_function_namespace || ' @ columns fetched' );

    -- Fetch data
    for l_row_num in 1 .. l_column_value_list(1).value_list.count loop
      begin
        apex_plugin_util.set_component_values (
        p_column_value_list => l_column_value_list,
        p_row_num => l_row_num
        );
        -- build up single select option
        l_output_option := replace(c_option_div, '#RETURN#', get_column_value(c_column_pos_id, l_row_num));
        l_output_option := replace(l_output_option, '#IMAGE#', get_column_value(c_column_pos_image, l_row_num));
        l_output_option := replace(l_output_option, '#LABEL#', apex_plugin_util.escape(p_value => get_column_value(c_column_pos_label, l_row_num), p_escape => p_item.escape_output));
        l_output_option := replace(l_output_option, '#CLASS#', get_column_value(c_column_pos_class, l_row_num));
        l_output_option := replace(l_output_option, '#ALT#', get_column_value(c_column_pos_alt, l_row_num));
        l_output_option := replace(l_output_option, '#TAG#', get_column_value(c_column_pos_tag, l_row_num));

        -- loop through the selected values (multiple)
        if is_exists( p_values => l_values, p_value => get_column_value(c_column_pos_id, l_row_num)) then
          l_output_option := replace(l_output_option, '#SELECTED#', 'selected');
        else
          l_output_option := replace(l_output_option, '#SELECTED#', '');
        end if;

        apex_debug.message( c_function_namespace || ' @ l_output_option: ' || l_output_option);

        l_output_html := l_output_html || l_output_option || chr(13);
        apex_plugin_util.clear_component_values;

      exception when others then
        apex_plugin_util.clear_component_values;
        raise;
      end;
    end loop;

    apex_debug.message( c_function_namespace || ' @ l_output_html: ' || l_output_html );
    apex_debug.message( c_function_namespace || ' @ end' );
    return l_output_html;
  end get_data_from_query;

begin
  apex_debug.message( c_plugin_namespace || ' @ begin' );
  apex_debug.message( c_plugin_namespace || ' @ as' );
  apex_debug.message( c_plugin_namespace || ' @ p_value: ' || p_value );

  l_values := apex_util.string_to_table(p_value);
  apex_debug.message( c_plugin_namespace || ' @ building html code' );

  l_output_html := replace(c_item_div, '#ID#', c_item_name);
  l_output_html := replace(l_output_html, '#NAME#', c_item_page_id);
  l_output_html := replace(l_output_html, '#CLASS#', c_item_class || p_item.element_css_classes) ;
  l_output_html := replace(l_output_html, '#LIMIT#', l_attr_limit);
  l_output_html := replace(l_output_html, '#MUTIPLE#', case when l_attr_multiple = 'Y' then 'multiple="multiple"' else '' end);
  l_output_html := replace(l_output_html, '#ATTRIBUTES#', p_item.element_attributes);


  -- TODO add static, see revised version
  apex_debug.message( c_plugin_namespace || ' @ menu query: ' || l_attr_lov_query );

  l_output_html := replace(l_output_html, '#OPTIONS#', get_data_from_query(p_sql_statement => l_attr_lov_query));

  apex_debug.message( c_plugin_namespace || ' @ l_output_html: ' || l_output_html );
  sys.htp.p(l_output_html);

  l_output_js := 'atimagepicker("' || c_item_name || '", {';
  l_output_js := l_output_js || apex_javascript.add_attribute('hide_select', case when l_attr_hide_select = 'Y' then true else false end);
  l_output_js := l_output_js || apex_javascript.add_attribute('show_label', case when l_attr_show_label = 'Y' then true else false end);
  l_output_js := l_output_js || '});';

  apex_javascript.add_onload_code( p_code => l_output_js);

  apex_debug.message( c_plugin_namespace || ' @ end' );
  -- Tell APEX that this field is navigable',
  l_result.is_navigable := true;
  return l_result;
end;
