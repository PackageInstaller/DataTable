-- chunkname: @/tmp/or_script/lua_compile/foundation/ccext/init.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "NodeExt")
require(__PACKAGE__ .. "MovieClipExt")
require(__PACKAGE__ .. "MaskNodeExt")
require(__PACKAGE__ .. "CCUIExtends")
require(__PACKAGE__ .. "CCLayoutUtil")
require(__PACKAGE__ .. "ActionExt")
require(__PACKAGE__ .. "CacheSnapshot")
