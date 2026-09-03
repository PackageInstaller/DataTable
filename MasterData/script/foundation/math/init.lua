-- chunkname: @/tmp/or_script/lua_compile/foundation/math/init.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "Vector")
require(__PACKAGE__ .. "Matrix")
require(__PACKAGE__ .. "ColorTransform")
require(__PACKAGE__ .. "Random")
