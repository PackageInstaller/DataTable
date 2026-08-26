-- chunkname: @modules/logic/explore/map/unit/ExploreStepOnceUnit.lua

module("modules.logic.explore.map.unit.ExploreStepOnceUnit", package.seeall)

local ExploreStepOnceUnit = class("ExploreStepOnceUnit", ExploreBaseDisplayUnit)

function ExploreStepOnceUnit:onInit()
	return
end

function ExploreStepOnceUnit:onRoleEnter(nowNode, preNode, unit)
	if not preNode then
		return
	end

	self._isRoleEnter = true

	if not self:canTrigger() then
		return
	end

	if not unit:isRole() and not unit.mo.canTriggerGear then
		return
	end

	if self.mo:isInteractActiveState() == false then
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.UnitIdLock + self.id)
		ExploreController.instance:getMap():getHero():stopMoving()
		ExploreModel.instance:setStepPause(true)
		self:playAnim(ExploreAnimEnum.AnimName.nToA)
		self:setInteractActive(true)
	end
end

function ExploreStepOnceUnit:onRoleLeave()
	self._isRoleEnter = false

	ExploreStepOnceUnit.super.onRoleLeave(self)
end

function ExploreStepOnceUnit:needUpdateHeroPos()
	return self._isRoleEnter and (self.animComp._curAnim == ExploreAnimEnum.AnimName.nToA or self.animComp._curAnim == ExploreAnimEnum.AnimName.aToN)
end

function ExploreStepOnceUnit:onAnimEnd(preAnim, nowAnim)
	if nowAnim == ExploreAnimEnum.AnimName.active or nowAnim == ExploreAnimEnum.AnimName.normal then
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UnitIdLock + self.id)

		local stepData = {
			stepType = ExploreEnum.StepType.CheckCounter,
			id = self.id
		}

		ExploreStepController.instance:insertClientStep(stepData, 1)
		ExploreStepController.instance:insertClientStep(stepData)

		if self.mo:isInteractActiveState() then
			self:tryTrigger()
		end

		ExploreStepController.instance:startStep()
		ExploreModel.instance:setStepPause(false)
	end

	ExploreStepOnceUnit.super.onAnimEnd(self, preAnim, nowAnim)
end

function ExploreStepOnceUnit:canTrigger()
	if self.mo:isInteractActiveState() then
		return false
	end

	return ExploreStepOnceUnit.super.canTrigger(self)
end

return ExploreStepOnceUnit
