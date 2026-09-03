-- chunkname: @/tmp/or_script/lua_compile/dm/battle/interactor/all.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "BattleDirector")
require(__PACKAGE__ .. "LocalBattleDirector")
require(__PACKAGE__ .. "RTPVPBattleDirector")
