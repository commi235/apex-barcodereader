create or replace package body mtag_codereader
as
  function render
  (
    p_region              in apex_plugin.t_region
  , p_plugin              in apex_plugin.t_plugin
  , p_is_printer_friendly in boolean
  )
    return apex_plugin.t_region_render_result
  as
    l_reinit_on_event boolean;
    l_width           varchar2(32767);
    l_height          varchar2(32767);
    l_style           varchar2(32767);
  
    l_html          varchar2(32767);
    l_onload_code   varchar2(32767);
    l_render_result apex_plugin.t_region_render_result;
  begin
    apex_plugin_util.debug_region
    (
      p_plugin              => p_plugin
    , p_region              => p_region
    , p_is_printer_friendly => p_is_printer_friendly
    );
    
    l_reinit_on_event := ( p_region.attribute_01 = 'Y' );
    l_width           := p_region.attribute_02;
    l_height          := p_region.attribute_03;
    l_style           := p_region.attribute_04;
  
    l_html := '<video id="' || p_region.static_id || '_video"';
    
    if l_width is not null then
      l_html := l_html || ' width="' || l_width || '"';
    end if;
    
    if l_height is not null then
      l_html := l_html || ' height="' || l_height || '"';  
    end if;
    
    if l_style is not null then
      l_html := l_html || ' style="' || l_style || '"';
    end if;
    
    l_html := l_html || '></video>';
  
    sys.htp.p( l_html );
    
    l_onload_code := 'apex.jQuery("#' || p_region.static_id || '").codereader(';
  
  
    apex_javascript.add_onload_code
    (
      p_code => 'apex.jQuery("#' || p_region.static_id || '").codereader( {' ||
        apex_javascript.add_attribute
        ( 
          p_name      => 'reInitOnEvent'
        , p_value     => l_reinit_on_event
        , p_add_comma => false
        ) ||
      '});'
    );
  
    return l_render_result;
  end render;

end mtag_codereader;
/
