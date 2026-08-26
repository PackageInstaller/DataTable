-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerEpisodeFinish.lua

module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeFinish", package.seeall)

local GuideTriggerEpisodeFinish = class("GuideTriggerEpisodeFinish", BaseGuideTrigger)

function GuideTriggerEpisodeFinish:ctor(triggerKey)
	GuideTriggerEpisodeFinish.super.ctor(self, triggerKey)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, self._checkStartGuide, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
end

function GuideTriggerEpisodeFinish:assertGuideSatisfy(param, configParam)
	local configEpisodeId = tonumber(configParam)
	local episodeMO = DungeonModel.instance:getEpisodeInfo(configEpisodeId)
	local episodeCO = DungeonConfig.instance:getEpisodeCO(configEpisodeId)

	if episodeCO and episodeMO and episodeMO.star > DungeonEnum.StarType.None then
		return episodeCO.afterStory <= 0 or episodeCO.afterStory > 0 and StoryModel.instance:isStoryFinished(episodeCO.afterStory)
	else
		return false
	end
end

function GuideTriggerEpisodeFinish:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerEpisodeFinish:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerEpisodeFinish
