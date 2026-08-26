-- chunkname: @modules/logic/explore/map/unit/ExploreSequenceCountUnit.lua

module("modules.logic.explore.map.unit.ExploreSequenceCountUnit", package.seeall)

local ExploreSequenceCountUnit = class("ExploreSequenceCountUnit", ExploreBaseDisplayUnit)

function ExploreSequenceCountUnit:onTrigger()
	if self.mo:isInteractEnabled() == false then
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

function ExploreSequenceCountUnit:onAnimEnd(preAnim, nowAnim)
	if nowAnim == ExploreAnimEnum.AnimName.active then
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UnitIdLock + self.id)

		if self.mo:isInteractActiveState() then
			local stepData = {
				stepType = ExploreEnum.StepType.CheckCounter,
				id = self.id
			}

			ExploreStepController.instance:insertClientStep(stepData, 1)
			self:tryTrigger()
			ExploreStepController.instance:startStep()
		else
			self:playAnim(ExploreAnimEnum.AnimName.aToN)
		end

		ExploreModel.instance:setStepPause(false)
	end

	ExploreSequenceCountUnit.super.onAnimEnd(self, preAnim, nowAnim)
end

return ExploreSequenceCountUnit
