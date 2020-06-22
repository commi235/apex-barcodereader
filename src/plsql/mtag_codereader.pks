create or replace package mtag_codereader
  authid current_user
as

  function render
  (
    p_region              in apex_plugin.t_region
  , p_plugin              in apex_plugin.t_plugin
  , p_is_printer_friendly in boolean
  ) return apex_plugin.t_region_render_result
  ;

end mtag_codereader;
/
