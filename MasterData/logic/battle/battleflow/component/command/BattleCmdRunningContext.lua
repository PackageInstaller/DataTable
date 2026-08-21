-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/BattleCmdRunningContext.lua

module("logic.battle.battleflow.component.command.BattleCmdRunningContext", package.seeall)

local BattleCmdRunningContext = class("BattleCmdRunningContext")

BattleCmdRunningContext.Param_SkillCode = "skill_code"
BattleCmdRunningContext.Param_AttackerEntityId = "attacker_entity_id"
BattleCmdRunningContext.Param_VictimEntityId = "victim_entity_id"
BattleCmdRunningContext.Param_DamageIndex = "damage_index"
BattleCmdRunningContext.Param_AdjustFollowCenterTime = "camera_follow_time"
BattleCmdRunningContext.Param_InSniping2Stage = "in_sniping_2_stage"
BattleCmdRunningContext.Param_CameraLocked = "is_camera_locked"
BattleCmdRunningContext.Param_TagId = "tag_id"

function BattleCmdRunningContext:ctor()
	self._paramTable = {}
end

function BattleCmdRunningContext:setParam(paramKey, value)
	self._paramTable[paramKey] = value
end

function BattleCmdRunningContext:getParam(paramKey)
	return self._paramTable[paramKey]
end

function BattleCmdRunningContext:clearParam(paramKey)
	self._paramTable[paramKey] = nil
end

function BattleCmdRunningContext:clear()
	BattleTableUtil.clearTable(self._paramTable)
end

return BattleCmdRunningContext
