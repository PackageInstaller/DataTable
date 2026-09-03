-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/ai/all.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "AutoStrategy")
require(__PACKAGE__ .. "RandomStrategy")
require(__PACKAGE__ .. "WeightedStrategy")
require(__PACKAGE__ .. "SequenceStrategy")
require(__PACKAGE__ .. "SequenceSeatStrategy")
