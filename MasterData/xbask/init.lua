require("xbask" .. "/core-x/init").init("core-x", "xbask")

if lx_core_x.is_starter == nil then
	function lx_core_x.is_starter()
		return lx_core_x.start_task_thread ~= nil
	end

	lx.is_main_thread = lx_core_x.is_starter
	log.__log_error = lx_core_x.runstate_errorlog
	log.__log_writelog = lx_core_x.runstate_writelog
	lx_core_x.get_log_root_dir = lx_core_x.get_log_dir
	lx_node_x = lx_core_x
end

require("xbask" .. "/client-x/init").init("client-x", "xbask")

if lx_core_x.is_starter() then
	require("xbask" .. "/engine/init").init("engine", "xbask", (require("xbask" .. "/engine_name")))
end

require("xbask" .. "/alone/init").init("alone", "xbask")
require("xbask" .. "/gamecore/init").init("gamecore", "xbask")
