-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/skill/all.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "BattleSkill")
require(__PACKAGE__ .. "BattleSkillExecutor")
require(__PACKAGE__ .. "BattleSkillScheduler")
require(__PACKAGE__ .. "SkillEventTrigger")
require(__PACKAGE__ .. "SkillTimedTrigger")
require(__PACKAGE__ .. "SkillScriptSupports")
