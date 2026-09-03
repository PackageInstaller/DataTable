-- chunkname: @/tmp/or_script/lua_compile/dragon/behavior/init.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

local function export(url)
	return require(__PACKAGE__ .. url)
end

export("BehaviorNodes")
export("BehaviorNodeFactory")
