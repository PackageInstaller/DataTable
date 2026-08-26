-- chunkname: @modules/logic/explore/controller/steps/ExploreSpikeStep.lua

module("modules.logic.explore.controller.steps.ExploreSpikeStep", package.seeall)

local ExploreSpikeStep = class("ExploreSpikeStep", ExploreStepBase)

function ExploreSpikeStep:onStart()
	local id = self._data.triggerInteractId
	local unit = ExploreController.instance:getMap():getUnit(id)

	GameSceneMgr.instance:getCurScene().stat:onTriggerSpike(id)
	ExploreModel.instance:addChallengeCount()

	if not unit or unit:getUnitType() ~= ExploreEnum.ItemType.Spike then
		self:onDone()

		return
	end

	ViewMgr.instance:closeView(ViewName.ExploreEnterView)
	ExploreMapModel.instance:updatHeroPos(self._data.x, self._data.y, 0)
	ExploreHeroFallAnimFlow.instance:begin(self._data, id)
	self:onDone()
end

return ExploreSpikeStep
