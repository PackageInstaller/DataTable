-- chunkname: @/tmp/or_script/lua_compile/foundation/luaext/init.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

local function export(url)
	return require(__PACKAGE__ .. url)
end

export("string")
export("table")
export("bitop")
export("coxpcall")
export("exception")

utf8 = export("utf8.utf8")
