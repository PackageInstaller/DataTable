-- chunkname: @/tmp/or_script/lua_compile/dragon/init.lua

require("cocos.init")
require("foundation.init")
require("objectlua.init")

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

local function export(url)
	return require(__PACKAGE__ .. url)
end

export("autoloading.init")
export("basis.init")
export("event.init")
export("legs.init")
export("game.init")
export("misc.init")
export("fsm.init")
export("behavior.init")
export("schedule.init")
export("timesharding.init")
