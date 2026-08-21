-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/property/statehandler/BattleStateHandler_Sniping.lua

module("logic.battle.unit.comp.property.statehandler.BattleStateHandler_Sniping", package.seeall)

local BattleStateHandler_Sniping = class("BattleStateHandler_Sniping", IBattleStateHandler)

function BattleStateHandler_Sniping:handleStateAdded(unit, runningContext)
	local victimEntityId = runningContext:getParam(BattleCmdRunningContext.Param_VictimEntityId)
	local stateMO = BattleState_SnipingMO:createInstance()

	stateMO:setVictimEntityId(victimEntityId)

	local attackerEntityId = runningContext:getParam(BattleCmdRunningContext.Param_AttackerEntityId)
	local skillId = runningContext:getParam(BattleCmdRunningContext.Param_SkillCode)
	local animState = BattleEnterSnipingPerformance:getSnipingAnimationName(attackerEntityId, skillId, UnitAnimState.Aim)

	unit.property:setStateMO(BattleEnum.State.SNIPING, stateMO)
	unit.meshModelMover:mapBusinessAnimation(UnitAnimState.Idle, animState)
	unit.meshModelMover:mapBusinessAnimation(UnitAnimState.Idle2, animState)
	unit.meshModelMover:mapBusinessAnimation(UnitAnimState.React, animState)
end

function BattleStateHandler_Sniping:handleStateRemoved(unit, runningContext)
	local snipingDrawing = BattleMgr.instance:getSnipingDrawing()

	unit.property:clearStateMO(BattleEnum.State.SNIPING)
	unit.meshModelMover:resetBusinessMappedAnimation(UnitAnimState.Idle)
	unit.meshModelMover:resetBusinessMappedAnimation(UnitAnimState.Idle2)
	unit.meshModelMover:resetBusinessMappedAnimation(UnitAnimState.React)
	unit.skillAreaWarning:clearSkillArea()
	snipingDrawing:clearSnipingForUnit(unit)
end

return BattleStateHandler_Sniping
