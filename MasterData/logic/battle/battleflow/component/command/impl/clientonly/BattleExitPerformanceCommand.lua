-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleExitPerformanceCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleExitPerformanceCommand", package.seeall)

local BattleExitPerformanceCommand = class("BattleExitPerformanceCommand", BattleTimingCommandBase)

function BattleExitPerformanceCommand:onInit()
	return
end

function BattleExitPerformanceCommand:onClear()
	return
end

function BattleExitPerformanceCommand:execute(battleFlow)
	SkillPerformanceMgr.instance:endPerformance(self._onEndPerformanceFinish, self)
end

function BattleExitPerformanceCommand:_onEndPerformanceFinish()
	self:startTimer(0)
end

function BattleExitPerformanceCommand:toString()
	return string.format("[battle exit performance command]")
end

return BattleExitPerformanceCommand
