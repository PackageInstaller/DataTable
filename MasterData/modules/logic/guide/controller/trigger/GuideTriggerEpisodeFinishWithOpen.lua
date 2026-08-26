-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerEpisodeFinishWithOpen.lua

module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeFinishWithOpen", package.seeall)

local GuideTriggerEpisodeFinishWithOpen = class("GuideTriggerEpisodeFinishWithOpen", BaseGuideTrigger)

function GuideTriggerEpisodeFinishWithOpen:ctor(triggerKey)
	GuideTriggerEpisodeFinishWithOpen.super.ctor(self, triggerKey)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, self._checkStartGuide, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
end

function GuideTriggerEpisodeFinishWithOpen:assertGuideSatisfy(param, configParam)
	local openId = tonumber(configParam)
	local openCO = OpenConfig.instance:getOpenCo(openId)

	if not openCO then
		return false
	end

	local configEpisodeId = openCO.episodeId
	local episodeMO = DungeonModel.instance:getEpisodeInfo(configEpisodeId)
	local episodeCO = DungeonConfig.instance:getEpisodeCO(configEpisodeId)

	if episodeCO and episodeMO and episodeMO.star > DungeonEnum.StarType.None then
		return episodeCO.afterStory <= 0 or episodeCO.afterStory > 0 and StoryModel.instance:isStoryFinished(episodeCO.afterStory)
	else
		return false
	end
end

function GuideTriggerEpisodeFinishWithOpen:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerEpisodeFinishWithOpen:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerEpisodeFinishWithOpen
