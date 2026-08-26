-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionFightVictory.lua

module("modules.logic.guide.controller.action.impl.GuideActionFightVictory", package.seeall)

local GuideActionFightVictory = class("GuideActionFightVictory", BaseGuideAction)
local VictoryTime = 2.5

function GuideActionFightVictory:onStart(context)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		self:onDone(true)

		return
	end

	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	self._playVictoryList = {}

	TaskDispatcher.runDelay(self._onVictoryEnd, self, VictoryTime)

	for _, entity in ipairs(entityList) do
		if entity.spine:hasAnimation(SpineAnimState.victory) then
			self._victoryActName = FightHelper.processEntityActionName(entity, SpineAnimState.victory)

			entity.spine:addAnimEventCallback(self._onAnimEvent, self, entity)
			entity.spine:play(self._victoryActName, false, true, true)

			if entity.nameUI then
				entity.nameUI:setActive(false)
			end

			table.insert(self._playVictoryList, entity)
		end
	end

	self:onDone(true)
end

function GuideActionFightVictory:_onAnimEvent(actionName, eventName, eventArgs, param)
	if actionName == self._victoryActName and eventName == SpineAnimEvent.ActionComplete then
		local entity = param

		entity:resetAnimState()
		entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
	end
end

function GuideActionFightVictory:_onVictoryEnd()
	for _, entity in ipairs(self._playVictoryList) do
		entity:resetAnimState()
		entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
	end
end

function GuideActionFightVictory:onDestroy()
	GuideActionFightVictory.super.onDestroy(self)
	TaskDispatcher.cancelTask(self._onVictoryEnd, self)

	self._playVictoryList = nil
end

return GuideActionFightVictory
