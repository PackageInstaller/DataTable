-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerEpisodeFinishAndTalent.lua

module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeFinishAndTalent", package.seeall)

local GuideTriggerEpisodeFinishAndTalent = class("GuideTriggerEpisodeFinishAndTalent", BaseGuideTrigger)

function GuideTriggerEpisodeFinishAndTalent:ctor(triggerKey)
	GuideTriggerEpisodeFinishAndTalent.super.ctor(self, triggerKey)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, self._checkStartGuide, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
	CharacterController.instance:registerCallback(CharacterEvent.successHeroRankUp, self._checkStartGuide, self)
end

function GuideTriggerEpisodeFinishAndTalent:assertGuideSatisfy(param, configParam)
	local configId = tonumber(configParam)
	local openCO = OpenConfig.instance:getOpenCo(configId)

	if openCO then
		if not openCO.episodeId then
			local configEpisodeId = configId
			local episodeMO = DungeonModel.instance:getEpisodeInfo(configEpisodeId)
			local episodeCO = DungeonConfig.instance:getEpisodeCO(configEpisodeId)

			if episodeCO and episodeMO and episodeMO.star > DungeonEnum.StarType.None then
				local finish = episodeCO.afterStory <= 0 or episodeCO.afterStory > 0 and StoryModel.instance:isStoryFinished(episodeCO.afterStory)

				if not finish then
					return false
				end

				local heroList = HeroModel.instance:getList()

				for i, v in ipairs(heroList) do
					if v.rank > 1 then
						return true
					end
				end

				return false
			else
				return false
			end
		end
	end
end

function GuideTriggerEpisodeFinishAndTalent:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerEpisodeFinishAndTalent:_checkStartGuide()
	local inMainScene = GameSceneMgr.instance:getCurSceneType() == SceneType.Main

	if inMainScene then
		self:checkStartGuide()
	end
end

return GuideTriggerEpisodeFinishAndTalent
