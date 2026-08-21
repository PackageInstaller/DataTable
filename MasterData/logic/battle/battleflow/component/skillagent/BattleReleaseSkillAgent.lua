-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/skillagent/BattleReleaseSkillAgent.lua

module("logic.battle.battleflow.component.skillagent.BattleReleaseSkillAgent", package.seeall)

local BattleReleaseSkillAgent = class("BattleReleaseSkillAgent", IBattleFlowComp, IBattleReleaseSkillAgent)

function BattleReleaseSkillAgent:onStart()
	self._unitMgr = self.flow.unitMgr or false
	self._sharedPathFinder = self.flow.sharedPathFinder or false
	self._netAgent = self.flow.netAgent or false
	self._forecastMgr = self.flow.forecastMgr or false
end

function BattleReleaseSkillAgent:onClear()
	self._unitMgr = false
	self._sharedPathFinder = false
	self._netAgent = false
	self._forecastMgr = false
end

function BattleReleaseSkillAgent:isValidSkillTarget(unit, targetUnionIndex, skillId)
	return BattleSkillAssist.validateSkillTarget(unit, targetUnionIndex, skillId)
end

function BattleReleaseSkillAgent:requestAttack(releaseSkillContext)
	local unit = self._unitMgr:getUnit(releaseSkillContext.entityId)
	local skillId = releaseSkillContext.selectedSkillId

	if not self:isValidSkillTarget(unit, releaseSkillContext.targetUnionIndex, skillId) then
		return false
	end

	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local pathUnionIndexs = self._sharedPathFinder:findPathForServer(unit, skillId, releaseSkillContext.originUnionIndex, unionIndex)

	self._netAgent:sendStepRequest(releaseSkillContext.entityId, pathUnionIndexs, skillId, releaseSkillContext.targetUnionIndex, releaseSkillContext.transportUnionIndex, releaseSkillContext.isStrenthening, releaseSkillContext.lookAtDirection)

	return true
end

function BattleReleaseSkillAgent:requestForecast(releaseSkillContext)
	local unit = self._unitMgr:getUnit(releaseSkillContext.entityId)
	local pathUnionIndexs = self._sharedPathFinder:findPathForServer(unit, releaseSkillContext.selectedSkillId, releaseSkillContext.originUnionIndex, releaseSkillContext.stopUnionIndex)

	return self._forecastMgr:requestForecast(releaseSkillContext.entityId, pathUnionIndexs, releaseSkillContext.selectedSkillId, releaseSkillContext.targetUnionIndex, releaseSkillContext.transportUnionIndex, releaseSkillContext.isStrenthening, releaseSkillContext.lookAtDirection)
end

function BattleReleaseSkillAgent:requestEndStage()
	self._netAgent:sendEndStageRequest()
end

function BattleReleaseSkillAgent:isRemoteMelee(unit, targetUnionIndex, skillId, isStrengthen)
	if not targetUnionIndex then
		return false
	end

	local tx, tz = BoardIndexConverter.unionIndexToCoordinates(targetUnionIndex)
	local fx, fz = unit.transform:getCoordinates()
	local targetUnit = self._unitMgr:getUnitOnUnionIndex(targetUnionIndex)

	if targetUnit then
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

		if skillCOWrapper:getSkillEffectType(isStrengthen) == BattleEnum.SkillPurpose.DAMAGE then
			local releaseDistance = skillCOWrapper:getReleaseDistance(isStrengthen)

			if not unit.property:isStateActive(BattleEnum.State.IGNORE_NEAR) and releaseDistance > 1 and math.abs(tx - fx) + math.abs(tz - fz) == 1 then
				return true
			end
		end
	end

	return false
end

return BattleReleaseSkillAgent
