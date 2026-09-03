-- chunkname: @/tmp/or_script/lua_compile/foundation/init.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "luaext.init")
require(__PACKAGE__ .. "containers.init")
require(__PACKAGE__ .. "math.init")
require(__PACKAGE__ .. "crypto.init")
require(__PACKAGE__ .. "misc.functions")

if url == nil then
	url = require(__PACKAGE__ .. "misc.url")
end

if cc ~= nil and cc.Ref ~= nil then
	require(__PACKAGE__ .. "ccext.init")
end
