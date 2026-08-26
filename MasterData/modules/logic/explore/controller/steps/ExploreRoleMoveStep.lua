-- chunkname: @modules/logic/explore/controller/steps/ExploreRoleMoveStep.lua

module("modules.logic.explore.controller.steps.ExploreRoleMoveStep", package.seeall)

local ExploreRoleMoveStep = class("ExploreRoleMoveStep", ExploreStepBase)

function ExploreRoleMoveStep:onStart()
	local hero = ExploreController.instance:getMap():getHero()

	if ExploreModel.instance.isReseting then
		hero:setPosByNode(self._data, false)
		self:onDone()

		return
	end

	if hero:isMoving() and ExploreHelper.getDistance(hero.nodePos, self._data) == 1 then
		ExploreController.instance:registerCallback(ExploreEvent.OnCharacterNodeChange, self._onCharacterNodeChange, self)
		ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, self._onCharacterNodeChange, self)
	else
		self:onDone()
	end
end

function ExploreRoleMoveStep:_onCharacterNodeChange()
	self:onDone()
end

function ExploreRoleMoveStep:onDestory()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterNodeChange, self._onCharacterNodeChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, self._onCharacterNodeChange, self)
	ExploreRoleMoveStep.super.onDestory(self)
end

return ExploreRoleMoveStep
