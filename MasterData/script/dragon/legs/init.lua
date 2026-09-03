-- chunkname: @/tmp/or_script/lua_compile/dragon/legs/init.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

local function export(url)
	return require(__PACKAGE__ .. url)
end

export("injector.Injector")
export("adapters.ViewFactoryAdapter")
export("core.EventMap")
export("core.CommandMap")
export("core.ViewMap")
export("core.MediatorMap")
export("mvcs.Context")
export("mvcs.Actor")
export("mvcs.Command")
export("mvcs.Mediator")
