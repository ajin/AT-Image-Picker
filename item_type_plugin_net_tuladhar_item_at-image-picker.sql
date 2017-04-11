set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.4.00.12'
,p_default_workspace_id=>1691214649525975
,p_default_application_id=>108
,p_default_owner=>'PLAYGROUND'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/item_type/net_tuladhar_item_at_image_picker
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(29404500164653744)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'NET.TULADHAR.ITEM.AT-IMAGE-PICKER'
,p_display_name=>'AT Image Picker'
,p_supported_ui_types=>'DESKTOP'
,p_javascript_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#image-picker.min.js',
'#PLUGIN_FILES#at-image-picker.js'))
,p_css_file_urls=>'#PLUGIN_FILES#image-picker.css'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'/**',
' * Render the placeholder of the plugin during the page load',
' *',
' * @param p_item',
' * @param p_plugin',
' * @param p_value',
' * @param p_is_readonly',
' * @param p_is_printer_friendly',
' * @return t_page_item_render_result result type for the rendering function of a region type plug-in',
' */',
'function render (',
'    p_item                in apex_plugin.t_page_item,',
'    p_plugin              in apex_plugin.t_plugin,',
'    p_value               in varchar2,',
'    p_is_readonly         in boolean,',
'    p_is_printer_friendly in boolean',
') return apex_plugin.t_page_item_render_result is',
'',
'  c_plugin_namespace  varchar2(200)    := ''at_image_picker'';',
'  l_output_html			  varchar2(32767)  := null;',
'  l_output_js         varchar2(32767)  := null;',
'',
'  c_item_uid          number           := p_item.id; --uid',
'  c_item_name         varchar2(255)    := p_item.name; --P1_NAME',
'',
'  c_item_page_id      varchar2(30)     := apex_plugin.get_input_name_for_page_item(p_is_multi_value => true); -- p_t01',
'  c_ajax_identifier		varchar2(254)    := apex_plugin.get_ajax_identifier;',
'',
'  -- constant values',
'  c_item_class		varchar2(254)  := ''image-picker '';',
'  c_item_div      varchar2(254)  := ''<select id="#ID#" name="#NAME#" class="#CLASS#" data-limit="#LIMIT#" #MUTIPLE# #ATTRIBUTES#></select>'';',
'',
'  -- attributes defined section option',
'  l_attr_hide_select varchar2(2)  := p_item.attribute_04;',
'  l_attr_show_label  varchar2(2)  := p_item.attribute_05;',
'  l_attr_limit       varchar2(2)  := p_item.attribute_06;',
'  l_attr_multiple    varchar2(2)  := p_item.attribute_07;',
'  l_attr_page_items  varchar2(32767) := p_item.attribute_08 ;',
'',
'begin',
'  apex_debug.message( c_plugin_namespace || '' @ begin'' );',
'  apex_debug.message( c_plugin_namespace || '' @ building html code'' );',
'',
'  l_output_html := replace(c_item_div, ''#ID#'', c_item_name);',
'  l_output_html := replace(l_output_html, ''#NAME#'', c_item_page_id);',
'  l_output_html := replace(l_output_html, ''#CLASS#'', c_item_class || p_item.element_css_classes) ;',
'  l_output_html := replace(l_output_html, ''#LIMIT#'', l_attr_limit);',
'  l_output_html := replace(l_output_html, ''#MUTIPLE#'', case when l_attr_multiple = ''Y'' then ''multiple="multiple"'' else '''' end);',
'  l_output_html := replace(l_output_html, ''#ATTRIBUTES#'', p_item.element_attributes);',
'',
'  apex_debug.message( c_plugin_namespace || '' @ l_output_html: '' || l_output_html );',
'  sys.htp.p(l_output_html);',
'',
'  l_output_js := ''atimagepicker("'' || c_item_name || ''", {'';',
'  l_output_js := l_output_js || apex_javascript.add_attribute(''pageItems'', apex_plugin_util.page_item_names_to_jquery(l_attr_page_items));',
'  l_output_js := l_output_js || apex_javascript.add_attribute(''ajax_identifier'', c_ajax_identifier);',
'  l_output_js := l_output_js || apex_javascript.add_attribute(''values'', p_value);',
'  l_output_js := l_output_js || apex_javascript.add_attribute(''hide_select'', case when l_attr_hide_select = ''Y'' then true else false end);',
'  l_output_js := l_output_js || apex_javascript.add_attribute(''show_label'', case when l_attr_show_label = ''Y'' then true else false end);',
'  l_output_js := l_output_js || ''});'';',
'',
'',
'  apex_javascript.add_onload_code( p_code => l_output_js);',
'',
'  apex_debug.message( c_plugin_namespace || '' @ end'' );',
'  return null;',
'end;',
'',
'function ajax_render (',
'    p_item   in apex_plugin.t_page_item,',
'    p_plugin in apex_plugin.t_plugin )',
'',
'    return apex_plugin.t_page_item_ajax_result is',
'',
'    c_plugin_namespace  varchar2(200)    := ''at_image_picker'';',
'    c_item_uid          number           := p_item.id; --uid',
'    c_item_name         varchar2(255)    := p_item.name; --P1_NAME',
'    --',
'    c_item_page_id      varchar2(30)     := apex_plugin.get_input_name_for_page_item(p_is_multi_value => true); -- p_t01',
'    c_ajax_identifier		varchar2(254)    := apex_plugin.get_ajax_identifier;',
'',
'    l_output_html			  varchar2(32767)  := null;',
'    l_values            apex_application_global.vc_arr2;',
'',
'    -- attributes defined section',
'    l_attr_type_lov    varchar2(30)     := p_item.attribute_01;',
'    l_attr_lov_query   varchar2(32767)  := p_item.attribute_02;',
'    l_attr_lov_static  varchar2(32767)  := p_item.attribute_03;',
'',
'    function get_data_from_query(p_sql_statement in varchar2) return varchar2 is',
'',
'      c_function_namespace varchar2(200) := ''get_data_from_query'';',
'      c_option_div         varchar2(254)  := ''<option data-img-src="#IMAGE#" data-img-label="#LABEL#" data-img-class="#CLASS#" data-img-alt="#ALT#" value="#RETURN#" #SELECTED#>#LABEL#</option>'';',
'',
'      l_output_option      varchar2(4000)   := null;',
'      l_output_html			   varchar2(32767) := '''';',
'',
'      -- columns for query',
'      l_column_value_list    apex_plugin_util.t_column_value_list2;',
'',
'      c_column_name_id    varchar2(255) := ''RETURN'';',
'      c_column_name_image varchar2(255) := ''IMAGE'';',
'      c_column_name_label varchar2(255) := ''LABEL'';',
'      c_column_name_class varchar2(255) := ''CLASS'';',
'      c_column_name_alt   varchar2(255) := ''ALT'';',
'      c_column_name_tag   varchar2(255) := ''TAG'';',
'',
'      c_column_pos_id     pls_integer;',
'      c_column_pos_image  pls_integer;',
'      c_column_pos_label  pls_integer;',
'      c_column_pos_class  pls_integer;',
'      c_column_pos_alt    pls_integer;',
'      c_column_pos_tag    pls_integer;',
'',
'      /**',
'      * Gets the number of the column position that corresponds',
'      * to the named field in the given result identifier.',
'      *',
'      * @param p_column_alias     column name',
'      */',
'      function get_column_no (p_column_alias in varchar2',
'                            ,p_is_required in boolean)',
'        return pls_integer',
'      is',
'      begin',
'        return apex_plugin_util.get_column_no (',
'          p_attribute_label   => p_column_alias || '' column'',',
'          p_column_alias      => p_column_alias,',
'          p_column_value_list => l_column_value_list,',
'          p_is_required       => p_is_required,',
'          p_data_type         => apex_plugin_util.c_data_type_varchar2);',
'      end get_column_no;',
'',
'      /**',
'      * Gets the number of the column position that corresponds',
'      * to the named field in the given result identifier.',
'      *',
'      * @param p_column_value_list  apex_plugin_util.t_column_value_list2',
'      * @param p_column_alias     column name',
'      */',
'      function get_column_no (p_column_alias in varchar2 )',
'        return pls_integer',
'      is',
'      begin',
'        for i in 1 .. l_column_value_list.count loop',
'          if l_column_value_list(i).name = p_column_alias then',
'            return i;',
'          end if;',
'        end loop;',
'',
'        return null;',
'      end get_column_no;',
'',
'      /**',
'      * Get single value from database based on the given column and row position.',
'      *',
'      * @param p_col_pos  column position',
'      * @param p_row_pos  row position',
'      * @return value',
'      */',
'      function get_column_value(p_col_pos in pls_integer',
'                              , p_row_pos in pls_integer) return varchar2 is',
'      begin',
'        if p_col_pos is not null then',
'          return l_column_value_list(p_col_pos).value_list(p_row_pos).varchar2_value;',
'        end if;',
'        return null;',
'      end get_column_value;',
'',
'      /**',
'      * Checks if the given key or index exists in the array.',
'      *',
'      * @param p_values  apex_application_global.vc_arr2',
'      * @param p_value   Value to check varchar2',
'      * @return returns TRUE on success or FALSE on failure',
'      */',
'      function is_exists(p_values in apex_application_global.vc_arr2',
'                       , p_value  in varchar2) return boolean is',
'      begin',
'        for l_row_value in 1..p_values.count loop',
'          if l_values(l_row_value) = p_value then',
'            return true;',
'          end if;',
'        end loop;',
'',
'        return false;',
'      end is_exists;',
'',
'    begin',
'      apex_debug.message( c_function_namespace || '' @ begin'' );',
'      apex_debug.message( c_function_namespace || '' @ runnning (generated) query: '' || p_sql_statement );',
'',
'      -- we get the items from the sql query.',
'      l_column_value_list := apex_plugin_util.get_data2 (',
'        p_sql_statement     => p_sql_statement,',
'        p_min_columns       => 2,',
'        p_max_columns       => 6,',
'        p_component_name    => p_item.name );',
'',
'      c_column_pos_id := get_column_no (',
'        p_column_alias => c_column_name_id,',
'        p_is_required => true);',
'',
'      c_column_pos_image := get_column_no (',
'        p_column_alias => c_column_name_image,',
'        p_is_required => true);',
'',
'      c_column_pos_label := get_column_no (',
'        p_column_alias => c_column_name_label,',
'        p_is_required => true);',
'',
'      c_column_pos_class := get_column_no (p_column_alias => c_column_name_class);',
'      c_column_pos_alt   := get_column_no (p_column_alias => c_column_name_alt);',
'      c_column_pos_tag   := get_column_no (p_column_alias => c_column_name_tag);',
'',
'      apex_debug.message( c_function_namespace || '' @ columns fetched'' );',
'',
'      -- Fetch data',
'      for l_row_num in 1 .. l_column_value_list(1).value_list.count loop',
'        begin',
'          apex_plugin_util.set_component_values (',
'          p_column_value_list => l_column_value_list,',
'          p_row_num => l_row_num',
'          );',
'          -- build up single select option',
'          l_output_option := replace(c_option_div, ''#RETURN#'', get_column_value(c_column_pos_id, l_row_num));',
'          l_output_option := replace(l_output_option, ''#IMAGE#'', get_column_value(c_column_pos_image, l_row_num));',
'          l_output_option := replace(l_output_option, ''#LABEL#'', apex_plugin_util.escape(p_value => get_column_value(c_column_pos_label, l_row_num), p_escape => p_item.escape_output));',
'          l_output_option := replace(l_output_option, ''#CLASS#'', get_column_value(c_column_pos_class, l_row_num));',
'          l_output_option := replace(l_output_option, ''#ALT#'', get_column_value(c_column_pos_alt, l_row_num));',
'          l_output_option := replace(l_output_option, ''#TAG#'', get_column_value(c_column_pos_tag, l_row_num));',
'',
'          -- loop through the selected values (multiple)',
'          if is_exists( p_values => l_values, p_value => get_column_value(c_column_pos_id, l_row_num)) then',
'            l_output_option := replace(l_output_option, ''#SELECTED#'', ''selected'');',
'          else',
'            l_output_option := replace(l_output_option, ''#SELECTED#'', '''');',
'          end if;',
'',
'          apex_debug.message( c_function_namespace || '' @ l_output_option: '' || l_output_option);',
'',
'          l_output_html := l_output_html || l_output_option || chr(13);',
'          apex_plugin_util.clear_component_values;',
'',
'        exception when others then',
'          apex_plugin_util.clear_component_values;',
'          raise;',
'        end;',
'      end loop;',
'',
'      apex_debug.message( c_function_namespace || '' @ l_output_html: '' || l_output_html );',
'      apex_debug.message( c_function_namespace || '' @ end'' );',
'      return l_output_html;',
'    end get_data_from_query;',
'begin',
'',
'  apex_debug.message( c_plugin_namespace || '' @ as'' );',
'  apex_debug.message( c_plugin_namespace || '' @ p_value: '' || apex_application.g_x01 );',
'',
'  -- retrieve selected values from parsing string',
'  l_values := apex_util.string_to_table(apex_application.g_x01);',
'',
'  apex_debug.message( c_plugin_namespace || '' @ building options'' );',
'',
'  -- TODO add static, see revised version',
'  apex_debug.message( c_plugin_namespace || '' @ menu query: '' || l_attr_lov_query );',
'  l_output_html := get_data_from_query(p_sql_statement => l_attr_lov_query);',
'  apex_debug.message( c_plugin_namespace || '' @ l_output_html: '' || l_output_html );',
'',
'  -- build return JSON value',
'  apex_json.open_object;',
'  apex_json.write(''content'', l_output_html);',
'  apex_json.close_object;',
'  return null;',
'end;',
''))
,p_render_function=>'render'
,p_ajax_function=>'ajax_render'
,p_standard_attributes=>'VISIBLE:FORM_ELEMENT:SESSION_STATE:ESCAPE_OUTPUT:SOURCE:ELEMENT:ELEMENT_OPTION'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>'Image Picker is a simple jQuery plugin that transforms a select element into a more user friendly graphical interface.'
,p_version_identifier=>'0.3.1-170411'
,p_about_url=>'http://www.tuladhar.net'
,p_plugin_comment=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'AT Image Picker utilized image-picker jQuery plugin by Rodrigo Vera',
'',
'version: 0.3.1',
'homepage: http://rvera.github.com/image-picker',
'authors: Rodrigo Vera',
'description": Image Picker is a simple jQuery plugin that transforms a select element into a more user friendly graphical interface.',
'license : MIT'))
,p_files_version=>17
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(29404931403668957)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'List of Values Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'sql'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<h3>Type</h3>',
'<p>Select the list of values type.</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(29405223364671582)
,p_plugin_attribute_id=>wwv_flow_api.id(29404931403668957)
,p_display_sequence=>10
,p_display_value=>'SQL Query'
,p_return_value=>'sql'
,p_help_text=>'The Dynamic list of values is based on the SQL Query you enter'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(29405848323697256)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'SQL Query'
,p_attribute_type=>'SQL'
,p_is_required=>false
,p_sql_min_column_count=>2
,p_sql_max_column_count=>4
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(29404931403668957)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'sql'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'SELECT [fields] FROM [tables] WHERE [...]',
'',
'<pre>',
'select ''http://lorempixel.com/220/200/food/1'' as image',
',      ''1''              as return',
',      ''foody''          as label',
',      ''t-custom-class'' as class',
',      ''extra info''     as alt',
',      ''extra tag''      as tag',
'from   dual',
'</pre>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(29407843737218619)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Static'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(29404931403668957)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'static'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(29408128790225137)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Hide Select'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Default: true, the original select item should be hidden or not'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(29408460547228500)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Show Label'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'Default: false. If set to true, the text of each option will be added as a paragraph below each image.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(29408744403232965)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>80
,p_prompt=>'Limit'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(29409017666235499)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Default: undefined. If it''s a select multiple and set to any value, it''ll cap the selectable elements at that value.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(29409017666235499)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Multiple Select'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(29449985422001725)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>25
,p_prompt=>'Page Items'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(29413966634382093)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_name=>'at-ip-initialized'
,p_display_name=>'Initialized'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(29414266854382093)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_name=>'at-ip-limit-reached'
,p_display_name=>'Limit Reached'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '756C2E7468756D626E61696C732E696D6167655F7069636B65725F73656C6563746F72207B0A20206F766572666C6F773A206175746F3B0A20206C6973742D7374796C652D696D6167653A206E6F6E653B0A20206C6973742D7374796C652D706F736974';
wwv_flow_api.g_varchar2_table(2) := '696F6E3A206F7574736964653B0A20206C6973742D7374796C652D747970653A206E6F6E653B0A202070616464696E673A203070783B0A20206D617267696E3A203070783B207D0A2020756C2E7468756D626E61696C732E696D6167655F7069636B6572';
wwv_flow_api.g_varchar2_table(3) := '5F73656C6563746F7220756C207B0A202020206F766572666C6F773A206175746F3B0A202020206C6973742D7374796C652D696D6167653A206E6F6E653B0A202020206C6973742D7374796C652D706F736974696F6E3A206F7574736964653B0A202020';
wwv_flow_api.g_varchar2_table(4) := '206C6973742D7374796C652D747970653A206E6F6E653B0A2020202070616464696E673A203070783B0A202020206D617267696E3A203070783B207D0A2020756C2E7468756D626E61696C732E696D6167655F7069636B65725F73656C6563746F72206C';
wwv_flow_api.g_varchar2_table(5) := '692E67726F7570207B77696474683A313030253B7D200A2020756C2E7468756D626E61696C732E696D6167655F7069636B65725F73656C6563746F72206C692E67726F75705F7469746C65207B0A20202020666C6F61743A206E6F6E653B207D0A202075';
wwv_flow_api.g_varchar2_table(6) := '6C2E7468756D626E61696C732E696D6167655F7069636B65725F73656C6563746F72206C69207B0A202020206D617267696E3A2030707820313270782031327078203070783B0A20202020666C6F61743A206C6566743B207D0A20202020756C2E746875';
wwv_flow_api.g_varchar2_table(7) := '6D626E61696C732E696D6167655F7069636B65725F73656C6563746F72206C69202E7468756D626E61696C207B0A20202020202070616464696E673A203670783B0A202020202020626F726465723A2031707820736F6C696420236464646464643B0A20';
wwv_flow_api.g_varchar2_table(8) := '20202020202D7765626B69742D757365722D73656C6563743A206E6F6E653B0A2020202020202D6D6F7A2D757365722D73656C6563743A206E6F6E653B0A2020202020202D6D732D757365722D73656C6563743A206E6F6E653B207D0A20202020202075';
wwv_flow_api.g_varchar2_table(9) := '6C2E7468756D626E61696C732E696D6167655F7069636B65725F73656C6563746F72206C69202E7468756D626E61696C20696D67207B0A20202020202020202D7765626B69742D757365722D647261673A206E6F6E653B207D0A20202020756C2E746875';
wwv_flow_api.g_varchar2_table(10) := '6D626E61696C732E696D6167655F7069636B65725F73656C6563746F72206C69202E7468756D626E61696C2E73656C6563746564207B0A2020202020206261636B67726F756E643A20233030383863633B207D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(29409845306266223)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_file_name=>'image-picker.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2F20496D616765205069636B65720A2F2F20627920526F647269676F20566572610A2F2F0A2F2F2056657273696F6E20302E332E310A2F2F2046756C6C20736F757263652061742068747470733A2F2F6769746875622E636F6D2F72766572612F696D';
wwv_flow_api.g_varchar2_table(2) := '6167652D7069636B65720A2F2F204D4954204C6963656E73652C2068747470733A2F2F6769746875622E636F6D2F72766572612F696D6167652D7069636B65722F626C6F622F6D61737465722F4C4943454E53450A2F2F20496D616765205069636B6572';
wwv_flow_api.g_varchar2_table(3) := '0A2F2F20627920526F647269676F20566572610A2F2F0A2F2F2056657273696F6E20302E332E300A2F2F2046756C6C20736F757263652061742068747470733A2F2F6769746875622E636F6D2F72766572612F696D6167652D7069636B65720A2F2F204D';
wwv_flow_api.g_varchar2_table(4) := '4954204C6963656E73652C2068747470733A2F2F6769746875622E636F6D2F72766572612F696D6167652D7069636B65722F626C6F622F6D61737465722F4C4943454E53450A2866756E6374696F6E28297B76617220742C652C692C732C6C3D66756E63';
wwv_flow_api.g_varchar2_table(5) := '74696F6E28742C65297B72657475726E2066756E6374696F6E28297B72657475726E20742E6170706C7928652C617267756D656E7473297D7D2C6E3D5B5D2E696E6465784F667C7C66756E6374696F6E2874297B666F722876617220653D302C693D7468';
wwv_flow_api.g_varchar2_table(6) := '69732E6C656E6774683B693E653B652B2B296966286520696E20746869732626746869735B655D3D3D3D742972657475726E20653B72657475726E2D317D3B6A51756572792E666E2E657874656E64287B696D6167657069636B65723A66756E6374696F';
wwv_flow_api.g_varchar2_table(7) := '6E2865297B72657475726E206E756C6C3D3D65262628653D7B7D292C746869732E656163682866756E6374696F6E28297B76617220693B72657475726E20693D6A51756572792874686973292C692E6461746128227069636B657222292626692E646174';
wwv_flow_api.g_varchar2_table(8) := '6128227069636B657222292E64657374726F7928292C692E6461746128227069636B6572222C6E6577207428746869732C7328652929292C6E756C6C213D652E696E697469616C697A65643F652E696E697469616C697A65642E63616C6C28692E646174';
wwv_flow_api.g_varchar2_table(9) := '6128227069636B65722229293A766F696420307D297D7D292C733D66756E6374696F6E2874297B76617220653B72657475726E20653D7B686964655F73656C6563743A21302C73686F775F6C6162656C3A21312C696E697469616C697A65643A766F6964';
wwv_flow_api.g_varchar2_table(10) := '20302C6368616E6765643A766F696420302C636C69636B65643A766F696420302C73656C65637465643A766F696420302C6C696D69743A766F696420302C6C696D69745F726561636865643A766F696420307D2C6A51756572792E657874656E6428652C';
wwv_flow_api.g_varchar2_table(11) := '74297D2C693D66756E6374696F6E28742C65297B72657475726E20303D3D3D6A51756572792874292E6E6F742865292E6C656E6774682626303D3D3D6A51756572792865292E6E6F742874292E6C656E6774687D2C743D66756E6374696F6E28297B6675';
wwv_flow_api.g_varchar2_table(12) := '6E6374696F6E207428742C65297B746869732E6F7074733D6E756C6C213D653F653A7B7D2C746869732E73796E635F7069636B65725F776974685F73656C6563743D6C28746869732E73796E635F7069636B65725F776974685F73656C6563742C746869';
wwv_flow_api.g_varchar2_table(13) := '73292C746869732E73656C6563743D6A51756572792874292C746869732E6D756C7469706C653D226D756C7469706C65223D3D3D746869732E73656C6563742E6174747228226D756C7469706C6522292C6E756C6C213D746869732E73656C6563742E64';
wwv_flow_api.g_varchar2_table(14) := '61746128226C696D69742229262628746869732E6F7074732E6C696D69743D7061727365496E7428746869732E73656C6563742E6461746128226C696D6974222929292C746869732E6275696C645F616E645F617070656E645F7069636B657228297D72';
wwv_flow_api.g_varchar2_table(15) := '657475726E20742E70726F746F747970652E64657374726F793D66756E6374696F6E28297B76617220742C652C692C733B666F7228733D746869732E7069636B65725F6F7074696F6E732C653D302C693D732E6C656E6774683B693E653B652B2B29743D';
wwv_flow_api.g_varchar2_table(16) := '735B655D2C742E64657374726F7928293B72657475726E20746869732E7069636B65722E72656D6F766528292C746869732E73656C6563742E756E62696E6428226368616E676522292C746869732E73656C6563742E72656D6F76654461746128227069';
wwv_flow_api.g_varchar2_table(17) := '636B657222292C746869732E73656C6563742E73686F7728297D2C742E70726F746F747970652E6275696C645F616E645F617070656E645F7069636B65723D66756E6374696F6E28297B76617220743D746869733B72657475726E20746869732E6F7074';
wwv_flow_api.g_varchar2_table(18) := '732E686964655F73656C6563742626746869732E73656C6563742E6869646528292C746869732E73656C6563742E6368616E67652866756E6374696F6E28297B72657475726E20742E73796E635F7069636B65725F776974685F73656C65637428297D29';
wwv_flow_api.g_varchar2_table(19) := '2C6E756C6C213D746869732E7069636B65722626746869732E7069636B65722E72656D6F766528292C746869732E6372656174655F7069636B657228292C746869732E73656C6563742E616674657228746869732E7069636B6572292C746869732E7379';
wwv_flow_api.g_varchar2_table(20) := '6E635F7069636B65725F776974685F73656C65637428297D2C742E70726F746F747970652E73796E635F7069636B65725F776974685F73656C6563743D66756E6374696F6E28297B76617220742C652C692C732C6C3B666F7228733D746869732E706963';
wwv_flow_api.g_varchar2_table(21) := '6B65725F6F7074696F6E732C6C3D5B5D2C653D302C693D732E6C656E6774683B693E653B652B2B29743D735B655D2C742E69735F73656C656374656428293F6C2E7075736828742E6D61726B5F61735F73656C65637465642829293A6C2E707573682874';
wwv_flow_api.g_varchar2_table(22) := '2E756E6D61726B5F61735F73656C65637465642829293B72657475726E206C7D2C742E70726F746F747970652E6372656174655F7069636B65723D66756E6374696F6E28297B72657475726E20746869732E7069636B65723D6A517565727928223C756C';
wwv_flow_api.g_varchar2_table(23) := '20636C6173733D277468756D626E61696C7320696D6167655F7069636B65725F73656C6563746F72273E3C2F756C3E22292C746869732E7069636B65725F6F7074696F6E733D5B5D2C746869732E7265637572736976656C795F70617273655F6F707469';
wwv_flow_api.g_varchar2_table(24) := '6F6E5F67726F75707328746869732E73656C6563742C746869732E7069636B6572292C746869732E7069636B65727D2C742E70726F746F747970652E7265637572736976656C795F70617273655F6F7074696F6E5F67726F7570733D66756E6374696F6E';
wwv_flow_api.g_varchar2_table(25) := '28742C69297B76617220732C6C2C6E2C722C632C6F2C682C612C702C753B666F7228613D742E6368696C6472656E28226F707467726F757022292C723D302C6F3D612E6C656E6774683B6F3E723B722B2B296E3D615B725D2C6E3D6A5175657279286E29';
wwv_flow_api.g_varchar2_table(26) := '2C733D6A517565727928223C756C3E3C2F756C3E22292C732E617070656E64286A517565727928223C6C6920636C6173733D2767726F75705F7469746C65273E222B6E2E6174747228226C6162656C22292B223C2F6C693E2229292C692E617070656E64';
wwv_flow_api.g_varchar2_table(27) := '286A517565727928223C6C693E22292E617070656E64287329292C746869732E7265637572736976656C795F70617273655F6F7074696F6E5F67726F757073286E2C73293B666F7228703D66756E6374696F6E28297B76617220692C732C6E2C723B666F';
wwv_flow_api.g_varchar2_table(28) := '72286E3D742E6368696C6472656E28226F7074696F6E22292C723D5B5D2C693D302C733D6E2E6C656E6774683B733E693B692B2B296C3D6E5B695D2C722E70757368286E65772065286C2C746869732C746869732E6F70747329293B72657475726E2072';
wwv_flow_api.g_varchar2_table(29) := '7D2E63616C6C2874686973292C753D5B5D2C633D302C683D702E6C656E6774683B683E633B632B2B296C3D705B635D2C746869732E7069636B65725F6F7074696F6E732E70757368286C292C6C2E6861735F696D61676528292626752E7075736828692E';
wwv_flow_api.g_varchar2_table(30) := '617070656E64286C2E6E6F646529293B72657475726E20757D2C742E70726F746F747970652E6861735F696D706C696369745F626C616E6B733D66756E6374696F6E28297B76617220743B72657475726E2066756E6374696F6E28297B76617220652C69';
wwv_flow_api.g_varchar2_table(31) := '2C732C6C3B666F7228733D746869732E7069636B65725F6F7074696F6E732C6C3D5B5D2C653D302C693D732E6C656E6774683B693E653B652B2B29743D735B655D2C742E69735F626C616E6B2829262621742E6861735F696D616765282926266C2E7075';
wwv_flow_api.g_varchar2_table(32) := '73682874293B72657475726E206C7D2E63616C6C2874686973292E6C656E6774683E307D2C742E70726F746F747970652E73656C65637465645F76616C7565733D66756E6374696F6E28297B72657475726E20746869732E6D756C7469706C653F746869';
wwv_flow_api.g_varchar2_table(33) := '732E73656C6563742E76616C28297C7C5B5D3A5B746869732E73656C6563742E76616C28295D7D2C742E70726F746F747970652E746F67676C653D66756E6374696F6E2874297B76617220652C732C6C3B72657475726E20733D746869732E73656C6563';
wwv_flow_api.g_varchar2_table(34) := '7465645F76616C75657328292C6C3D22222B742E76616C756528292C746869732E6D756C7469706C653F6E2E63616C6C28746869732E73656C65637465645F76616C75657328292C6C293E3D303F28653D746869732E73656C65637465645F76616C7565';
wwv_flow_api.g_varchar2_table(35) := '7328292C652E73706C696365286A51756572792E696E4172726179286C2C73292C31292C746869732E73656C6563742E76616C285B5D292C746869732E73656C6563742E76616C286529293A6E756C6C213D746869732E6F7074732E6C696D6974262674';
wwv_flow_api.g_varchar2_table(36) := '6869732E73656C65637465645F76616C75657328292E6C656E6774683E3D746869732E6F7074732E6C696D69743F6E756C6C213D746869732E6F7074732E6C696D69745F726561636865642626746869732E6F7074732E6C696D69745F72656163686564';
wwv_flow_api.g_varchar2_table(37) := '2E63616C6C28746869732E73656C656374293A746869732E73656C6563742E76616C28746869732E73656C65637465645F76616C75657328292E636F6E636174286C29293A746869732E6861735F696D706C696369745F626C616E6B7328292626742E69';
wwv_flow_api.g_varchar2_table(38) := '735F73656C656374656428293F746869732E73656C6563742E76616C282222293A746869732E73656C6563742E76616C286C292C6928732C746869732E73656C65637465645F76616C7565732829297C7C28746869732E73656C6563742E6368616E6765';
wwv_flow_api.g_varchar2_table(39) := '28292C6E756C6C3D3D746869732E6F7074732E6368616E676564293F766F696420303A746869732E6F7074732E6368616E6765642E63616C6C28746869732E73656C6563742C732C746869732E73656C65637465645F76616C7565732829297D2C747D28';
wwv_flow_api.g_varchar2_table(40) := '292C653D66756E6374696F6E28297B66756E6374696F6E207428742C652C69297B746869732E7069636B65723D652C746869732E6F7074733D6E756C6C213D693F693A7B7D2C746869732E636C69636B65643D6C28746869732E636C69636B65642C7468';
wwv_flow_api.g_varchar2_table(41) := '6973292C746869732E6F7074696F6E3D6A51756572792874292C746869732E6372656174655F6E6F646528297D72657475726E20742E70726F746F747970652E64657374726F793D66756E6374696F6E28297B72657475726E20746869732E6E6F64652E';
wwv_flow_api.g_varchar2_table(42) := '66696E6428222E7468756D626E61696C22292E756E62696E6428297D2C742E70726F746F747970652E6861735F696D6167653D66756E6374696F6E28297B72657475726E206E756C6C213D746869732E6F7074696F6E2E646174612822696D672D737263';
wwv_flow_api.g_varchar2_table(43) := '22297D2C742E70726F746F747970652E69735F626C616E6B3D66756E6374696F6E28297B72657475726E21286E756C6C213D746869732E76616C7565282926262222213D3D746869732E76616C75652829297D2C742E70726F746F747970652E69735F73';
wwv_flow_api.g_varchar2_table(44) := '656C65637465643D66756E6374696F6E28297B76617220743B72657475726E20743D746869732E7069636B65722E73656C6563742E76616C28292C746869732E7069636B65722E6D756C7469706C653F6A51756572792E696E417272617928746869732E';
wwv_flow_api.g_varchar2_table(45) := '76616C756528292C74293E3D303A746869732E76616C756528293D3D3D747D2C742E70726F746F747970652E6D61726B5F61735F73656C65637465643D66756E6374696F6E28297B72657475726E20746869732E6E6F64652E66696E6428222E7468756D';
wwv_flow_api.g_varchar2_table(46) := '626E61696C22292E616464436C617373282273656C656374656422297D2C742E70726F746F747970652E756E6D61726B5F61735F73656C65637465643D66756E6374696F6E28297B72657475726E20746869732E6E6F64652E66696E6428222E7468756D';
wwv_flow_api.g_varchar2_table(47) := '626E61696C22292E72656D6F7665436C617373282273656C656374656422297D2C742E70726F746F747970652E76616C75653D66756E6374696F6E28297B72657475726E20746869732E6F7074696F6E2E76616C28297D2C742E70726F746F747970652E';
wwv_flow_api.g_varchar2_table(48) := '6C6162656C3D66756E6374696F6E28297B72657475726E20746869732E6F7074696F6E2E646174612822696D672D6C6162656C22293F746869732E6F7074696F6E2E646174612822696D672D6C6162656C22293A746869732E6F7074696F6E2E74657874';
wwv_flow_api.g_varchar2_table(49) := '28297D2C742E70726F746F747970652E636C69636B65643D66756E6374696F6E28297B72657475726E20746869732E7069636B65722E746F67676C652874686973292C6E756C6C213D746869732E6F7074732E636C69636B65642626746869732E6F7074';
wwv_flow_api.g_varchar2_table(50) := '732E636C69636B65642E63616C6C28746869732E7069636B65722E73656C6563742C74686973292C6E756C6C213D746869732E6F7074732E73656C65637465642626746869732E69735F73656C656374656428293F746869732E6F7074732E73656C6563';
wwv_flow_api.g_varchar2_table(51) := '7465642E63616C6C28746869732E7069636B65722E73656C6563742C74686973293A766F696420307D2C742E70726F746F747970652E6372656174655F6E6F64653D66756E6374696F6E28297B76617220742C653B72657475726E20746869732E6E6F64';
wwv_flow_api.g_varchar2_table(52) := '653D6A517565727928223C6C692F3E22292C743D6A517565727928223C696D6720636C6173733D27696D6167655F7069636B65725F696D616765272F3E22292C742E617474722822737263222C746869732E6F7074696F6E2E646174612822696D672D73';
wwv_flow_api.g_varchar2_table(53) := '72632229292C653D6A517565727928223C64697620636C6173733D277468756D626E61696C273E22292C652E636C69636B287B6F7074696F6E3A746869737D2C66756E6374696F6E2874297B72657475726E20742E646174612E6F7074696F6E2E636C69';
wwv_flow_api.g_varchar2_table(54) := '636B656428297D292C652E617070656E642874292C746869732E6F7074732E73686F775F6C6162656C2626652E617070656E64286A517565727928223C702F3E22292E68746D6C28746869732E6C6162656C282929292C746869732E6E6F64652E617070';
wwv_flow_api.g_varchar2_table(55) := '656E642865292C746869732E6E6F64657D2C747D28297D292E63616C6C2874686973293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(29410210373267593)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_file_name=>'image-picker.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '282066756E6374696F6E2820242C207574696C2029207B0A0A2F2A2A0A202A2040706172616D207B537472696E677D2070526567696F6E49640A202A2040706172616D207B4F626A6563747D205B704F7074696F6E735D0A202A2A2F0A6174696D616765';
wwv_flow_api.g_varchar2_table(2) := '7069636B6572203D2066756E6374696F6E28206974656D49642C206F7074696F6E732029207B0A2020766172206974656D203D20272327202B207574696C2E65736361706543535328206974656D496420293B0A0A20207661722064656661756C747320';
wwv_flow_api.g_varchar2_table(3) := '3D207B0A20202020686964655F73656C656374203A20747275652C0A2020202073686F775F6C6162656C20203A2066616C73652C0A0A20202020696E697469616C697A65643A2066756E6374696F6E28696D6167655069636B657229207B0A2020202020';
wwv_flow_api.g_varchar2_table(4) := '20617065782E6576656E742E74726967676572286974656D2C202261742D69702D696E697469616C697A6564222C207B696D6167655069636B65727D293B0A202020207D2C0A202020206368616E6765643A2066756E6374696F6E2873656C6563742C20';
wwv_flow_api.g_varchar2_table(5) := '6E657756616C7565732C206F6C6456616C7565732C206576656E7429207B0A202020202020617065782E6576656E742E74726967676572286974656D2C20226368616E6765222C207B73656C6563742C206E657756616C7565732C206F6C6456616C7565';
wwv_flow_api.g_varchar2_table(6) := '732C206576656E747D293B0A202020207D2C0A20202020636C69636B65643A2066756E6374696F6E2873656C6563742C206F7074696F6E2C206576656E7429207B0A202020202020617065782E6576656E742E74726967676572286974656D2C2022636C';
wwv_flow_api.g_varchar2_table(7) := '69636B222C207B73656C6563742C206F7074696F6E2C206576656E747D293B0A202020207D2C0A2020202073656C65637465643A2066756E6374696F6E2873656C6563742C206F7074696F6E2C206576656E7429207B0A20202020202024286974656D29';
wwv_flow_api.g_varchar2_table(8) := '2E6461746128277069636B657227292E73796E635F7069636B65725F776974685F73656C65637428293B0A202020202020617065782E6576656E742E74726967676572286974656D2C202273656C656374222C207B73656C6563742C206F7074696F6E2C';
wwv_flow_api.g_varchar2_table(9) := '206576656E747D293B0A202020207D2C0A202020206C696D69745F726561636865643A2066756E6374696F6E2873656C65637429207B0A202020202020617065782E6576656E742E74726967676572286974656D2C202261742D69702D6C696D69742D72';
wwv_flow_api.g_varchar2_table(10) := '656163686564222C207B73656C6563747D293B0A202020207D0A20207D0A0A2020766172206F7074696F6E73203D20242E657874656E642864656661756C74732C206F7074696F6E73293B0A20205F7265667265736828293B0A20202F2A2042696E6420';
wwv_flow_api.g_varchar2_table(11) := '6576656E742068616E646C657220746F20746865206170657872656672657368206576656E7420666F7220746865206D61696E20726567696F6E20656C656D656E742E2044796E616D696320616374696F6E732063616E207468656E0A2020202A207265';
wwv_flow_api.g_varchar2_table(12) := '6672657368207468652066756C6C63616C656E64617220766961207468652027526566726573682720616374696F6E2E0A2020202A2F0A202024286974656D292E6F6E2820226170657872656672657368222C2066756E6374696F6E2829207B0A202020';
wwv_flow_api.g_varchar2_table(13) := '2020202F2F24286974656D292E696D6167657069636B6572286F7074696F6E73293B0A2020202020205F7265667265736828293B0A20207D292E7472696767657228202261706578726566726573682220293B0A0A20202F2F205573657320414A415820';
wwv_flow_api.g_varchar2_table(14) := '746F2067657420746865206E657765737420636861727420646174610A202066756E6374696F6E205F726566726573682829207B0A2020202069662028747970656F66206F7074696F6E732E616A61785F6964656E74696669657220213D3D2027756E64';
wwv_flow_api.g_varchar2_table(15) := '6566696E656427207C7C206F7074696F6E732E616A61785F6964656E74696669657229207B0A202020202020636F6E736F6C652E6C6F67286F7074696F6E732E616A61785F6964656E746966696572293B0A202020202020636F6E736F6C652E6C6F6728';
wwv_flow_api.g_varchar2_table(16) := '6F7074696F6E732E706167654974656D73293B0A0A202020202020617065782E7365727665722E706C7567696E2028206F7074696F6E732E616A61785F6964656E7469666965722C0A20202020202020202020202020202020202020202020202020207B';
wwv_flow_api.g_varchar2_table(17) := '207830313A206F7074696F6E732E76616C7565732C0A20202020202020202020202020202020202020202020202020202020706167654974656D733A206F7074696F6E732E706167654974656D737D2C0A202020202020202020207B63616368653A2066';
wwv_flow_api.g_varchar2_table(18) := '616C73652C0A20202020202020202020737563636573733A2066756E6374696F6E2820646174612029207B0A20202020202020202020202024286974656D292E656D70747928293B0A202020202020202020202020617065782E64656275672E6C6F6728';
wwv_flow_api.g_varchar2_table(19) := '646174612E636F6E74656E74293B0A20202020202020202020202024286974656D292E617070656E6428646174612E636F6E74656E74293B0A0A202020202020202020202020636F6E736F6C652E6C6F6728290A20202020202020202020202024286974';
wwv_flow_api.g_varchar2_table(20) := '656D292E696D6167657069636B6572286F7074696F6E73293B0A202020202020202020207D0A2020202020207D293B0A202020207D20656C7365207B0A2020202020202F2F5F646F48746D6C282222293B0A202020207D0A20207D0A0A0A7D0A7D292820';
wwv_flow_api.g_varchar2_table(21) := '617065782E6A51756572792C20617065782E7574696C20293B0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(29414739773389690)
,p_plugin_id=>wwv_flow_api.id(29404500164653744)
,p_file_name=>'at-image-picker.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
