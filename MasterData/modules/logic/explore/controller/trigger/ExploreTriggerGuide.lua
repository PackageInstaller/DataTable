-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerGuide.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerGuide", package.seeall)

local ExploreTriggerGuide = class("ExploreTriggerGuide", ExploreTriggerBase)

function ExploreTriggerGuide:handle(id)
	self._guideId = tonumber(id)

	local guideMO = GuideModel.instance:getById(self._guideId)

	if guideMO and guideMO.isFinish or not guideMO then
		if not guideMO then
			logError("指引没有接？？？")
		end

		self:onDone(true)

		return
	end

	local hero = ExploreController.instance:getMap():getHero()

	if hero:isMoving() then
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Guide)
		ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, self.beginGuide, self)
		hero:stopMoving()
	else
		self:beginGuide()
	end
end

function ExploreTriggerGuide:beginGuide()
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Guide)
	ExploreController.instance:dispatchEvent(ExploreEvent.ExploreTriggerGuide, self._guideId)
	self:onDone(true)
end

function ExploreTriggerGuide:clearWork()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, self.beginGuide, self)
end

return ExploreTriggerGuide
