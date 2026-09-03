-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/basis/all.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "functions")
require(__PACKAGE__ .. "AttributeNumber")
require(__PACKAGE__ .. "VariableTable")
require(__PACKAGE__ .. "PrioritizedListeners")
require(__PACKAGE__ .. "BattleEventDispatcher")
require(__PACKAGE__ .. "BattleTimer")
