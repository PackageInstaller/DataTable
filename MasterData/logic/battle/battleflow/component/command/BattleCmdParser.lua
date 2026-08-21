-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/BattleCmdParser.lua

module("logic.battle.battleflow.component.command.BattleCmdParser", package.seeall)

local BattleCmdParser = class("BattleCmdParser")

BattleCmdParser.Flag_EntityStep = "entity_step"
BattleCmdParser.Flag_InPlot = "in_plot"
BattleCmdParser.Flag_In3dPlot = "in_3dplot"
BattleCmdParser.Flag_AfterMain = "after_main"
BattleCmdParser.Param_SkillCode = "skill_code"
BattleCmdParser.Param_AttackerEntityId = "attacker_entity_id"
BattleCmdParser.Param_VictimEntityId = "victim_entity_id"
BattleCmdParser.Param_TargetUnionIndex = "target_union_index"
BattleCmdParser.Param_AttackerResultInfo = "attacker_result_entity_info"
BattleCmdParser.Param_VictimResultInfo = "victim_result_entity_info"
BattleCmdParser.Param_AfterStepEndedCommand = "after_step_ended_command"
BattleCmdParser.Param_PerformanceResultCollection = "performance_result_collection"
BattleCmdParser.Param_StrengthenStatus = "is_strengthening"
BattleCmdParser.Param_IsMultiRound = "is_multi_round"
BattleCmdParser.Param_IsMainHappened = "is_main_happened"
BattleCmdParser.Param_SkillTriggerAttackerId = "skill_trigger_attack_id"

function BattleCmdParser:ctor()
	self._cmd2Class = {}
	self._flagTable = {}
	self._paramTable = {}
	self._cmdContainerStack = Stack.New()
	self._activeCmdContainer = false
end

function BattleCmdParser:pushCmdContainer(cmdContainer)
	self._cmdContainerStack:push(cmdContainer)

	self._activeCmdContainer = cmdContainer
end

function BattleCmdParser:popCmdContainer()
	self._cmdContainerStack:pop()

	self._activeCmdContainer = self._cmdContainerStack:peek()
end

function BattleCmdParser:internal_clear()
	self._activeCmdContainer = false

	self._cmdContainerStack:clear()
	BattleTableUtil.clearTable(self._flagTable)
	BattleTableUtil.clearTable(self._cmd2Class)
end

function BattleCmdParser:internal_begin()
	self._activeCmdContainer = false

	self._cmdContainerStack:clear()
	BattleTableUtil.clearTable(self._flagTable)
end

function BattleCmdParser:internal_setCommandClass(cmd, cmdClass)
	self._cmd2Class[cmd] = cmdClass
end

function BattleCmdParser:internal_clearCommandClass(cmd)
	self._cmd2Class[cmd] = nil
end

function BattleCmdParser:internal_getCmdClass(cmd)
	return self._cmd2Class[cmd]
end

function BattleCmdParser:addCommand(cmd)
	self._activeCmdContainer:addCommand(cmd)
end

function BattleCmdParser:submit()
	self._activeCmdContainer:submit()
end

function BattleCmdParser:turnOnFlag(flagKey)
	self._flagTable[flagKey] = true
end

function BattleCmdParser:turnOffFlag(flagKey)
	self._flagTable[flagKey] = false
end

function BattleCmdParser:hasFlag(flagKey)
	return self._flagTable[flagKey] or false
end

function BattleCmdParser:setParam(paramKey, value)
	self._paramTable[paramKey] = value
end

function BattleCmdParser:getParam(paramKey)
	return self._paramTable[paramKey]
end

function BattleCmdParser:clearParam(paramKey)
	self._paramTable[paramKey] = nil
end

function BattleCmdParser:clearReusableParam(paramKey)
	local param = self._paramTable[paramKey]

	if param then
		param:returnSelf()
	end

	self._paramTable[paramKey] = nil
end

return BattleCmdParser
