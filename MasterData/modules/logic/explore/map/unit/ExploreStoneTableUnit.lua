-- chunkname: @modules/logic/explore/map/unit/ExploreStoneTableUnit.lua

module("modules.logic.explore.map.unit.ExploreStoneTableUnit", package.seeall)

local ExploreStoneTableUnit = class("ExploreStoneTableUnit", ExploreBaseMoveUnit)

function ExploreStoneTableUnit:getIdleAnim()
	local anim = ExploreStoneTableUnit.super.getIdleAnim(self)

	if anim == ExploreAnimEnum.AnimName.active then
		local statusInfo = self.mo:getInteractInfoMO().statusInfo

		anim = statusInfo.status ~= 1 and ExploreAnimEnum.AnimName.active or ExploreAnimEnum.AnimName.active2
	end

	return anim
end

function ExploreStoneTableUnit:canTrigger()
	if self.mo:isInteractActiveState() then
		local statusInfo = self.mo:getInteractInfoMO().statusInfo

		if statusInfo.status ~= 1 then
			return false
		end
	end

	return ExploreStoneTableUnit.super.canTrigger(self)
end

function ExploreStoneTableUnit:tryTrigger(clientOnly)
	if ExploreStepController.instance:getCurStepType() == ExploreEnum.StepType.DelUnit then
		return
	end

	return ExploreStoneTableUnit.super.tryTrigger(self, clientOnly)
end

function ExploreStoneTableUnit:needInteractAnim()
	return true
end

function ExploreStoneTableUnit:onStatus2Change(preStatuInfo, nowStatuInfo)
	if self.animComp:isIdleAnim() then
		self.animComp:playIdleAnim()
	end
end

return ExploreStoneTableUnit
