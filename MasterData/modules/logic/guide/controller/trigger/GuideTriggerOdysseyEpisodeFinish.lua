-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerOdysseyEpisodeFinish.lua

module("modules.logic.guide.controller.trigger.GuideTriggerOdysseyEpisodeFinish", package.seeall)

local GuideTriggerOdysseyEpisodeFinish = class("GuideTriggerOdysseyEpisodeFinish", BaseGuideTrigger)

function GuideTriggerOdysseyEpisodeFinish:ctor(triggerKey)
	GuideTriggerOdysseyEpisodeFinish.super.ctor(self, triggerKey)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, self._checkStartGuide, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
end

function GuideTriggerOdysseyEpisodeFinish:assertGuideSatisfy(param, configParam)
	local elementId = tonumber(configParam)
	local isElementFinish = OdysseyDungeonModel.instance:isElementFinish(elementId)
	local fightElementConfig = OdysseyConfig.instance:getElementFightConfig(elementId)

	if fightElementConfig then
		if not fightElementConfig.episodeId then
			local episodeId

			if not episodeId then
				return false
			end

			local episodeMO = DungeonModel.instance:getEpisodeInfo(episodeId)
			local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

			if episodeCO and episodeMO and isElementFinish then
				return episodeCO.afterStory <= 0 or episodeCO.afterStory > 0 and StoryModel.instance:isStoryFinished(episodeCO.afterStory)
			else
				return false
			end
		end
	end
end

function GuideTriggerOdysseyEpisodeFinish:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerOdysseyEpisodeFinish:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerOdysseyEpisodeFinish
