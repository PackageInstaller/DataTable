-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/systems/all.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "BattleSubSystem")
require(__PACKAGE__ .. "TimingSystem")
require(__PACKAGE__ .. "FormationSystem")
require(__PACKAGE__ .. "HealthSystem")
require(__PACKAGE__ .. "BuffSystem")
require(__PACKAGE__ .. "AngerSystem")
require(__PACKAGE__ .. "CardSystem")
require(__PACKAGE__ .. "TrapSystem")
require(__PACKAGE__ .. "BattleSkillSystem")
