-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/all.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "basis.all")
require(__PACKAGE__ .. "BattleContext")
require(__PACKAGE__ .. "IBattleRecorder")
require(__PACKAGE__ .. "BattleRecorder")
require(__PACKAGE__ .. "IProcessRecorder")
require(__PACKAGE__ .. "CommonProcessRecorder")
require(__PACKAGE__ .. "BattleStatist")
require(__PACKAGE__ .. "simulator.all")
require(__PACKAGE__ .. "BattleField")
require(__PACKAGE__ .. "BattleCemetery")
require(__PACKAGE__ .. "EnergyReservoir")
require(__PACKAGE__ .. "BattlePlayer")
require(__PACKAGE__ .. "BattlePlayerTeam")
require(__PACKAGE__ .. "BattlePlayerSerialTeam")
require(__PACKAGE__ .. "components.all")
require(__PACKAGE__ .. "BattleEntity")
require(__PACKAGE__ .. "BattleUnit")
require(__PACKAGE__ .. "BattleUnitStates")
require(__PACKAGE__ .. "BattleEntityManager")
require(__PACKAGE__ .. "sdk.all")
require(__PACKAGE__ .. "BattleCard")
require(__PACKAGE__ .. "BattleCardWindow")
require(__PACKAGE__ .. "HeroCardPool")
require(__PACKAGE__ .. "BaseBattleLogic")
require(__PACKAGE__ .. "FSMBattleLogic")
require(__PACKAGE__ .. "BattleLogic")
require(__PACKAGE__ .. "RegularLogicStates")
require(__PACKAGE__ .. "RegularBattleLogic")
require(__PACKAGE__ .. "guidelogic.all")
require(__PACKAGE__ .. "ai.all")
require(__PACKAGE__ .. "BattleSoleIdProcessor")
require(__PACKAGE__ .. "BattleDataHelper")
require(__PACKAGE__ .. "BattleExtension")
require(__PACKAGE__ .. "BattleSkillAttrEffect")
require(__PACKAGE__ .. "buffs.all")
require(__PACKAGE__ .. "traps.all")
require(__PACKAGE__ .. "enchants.all")
require(__PACKAGE__ .. "skill.all")
require(__PACKAGE__ .. "systems.all")
pcall(function()
	require(__PACKAGE__ .. "BattleLogger")
end)

logging = logging or {}

local function emptyFunc()
	return
end

BattleLogger = BattleLogger or {
	debug = emptyFunc,
	info = emptyFunc,
	warn = emptyFunc,
	error = emptyFunc,
	log = emptyFunc
}

function Blog(...)
	BattleLogger:log(BattleLoggerUser, logging.DEBUG, ...)
end

function Bdump(...)
	BattleLogger:log("dump", logging.DEBUG, ...)
end

function Bcallstack(...)
	if logging.DEBUG then
		BattleLogger:log("dump", logging.DEBUG, ...)

		local stacks = {
			3,
			4
		}

		for _, v in ipairs(stacks) do
			local callerStack = debug.getinfo(v, "Sl")

			if callerStack then
				BattleLogger:log("dump", logging.DEBUG, "callerStack:", string.match(callerStack.source, ".+/([^/]*%.%w+)$"), callerStack.currentline)
			end
		end
	end
end
