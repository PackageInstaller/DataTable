-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerEpisodeFinishAndInMainScene.lua

module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeFinishAndInMainScene", package.seeall)

local GuideTriggerEpisodeFinishAndInMainScene = class("GuideTriggerEpisodeFinishAndInMainScene", BaseGuideTrigger)

function GuideTriggerEpisodeFinishAndInMainScene:ctor(triggerKey)
	GuideTriggerEpisodeFinishAndInMainScene.super.ctor(self, triggerKey)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, self._checkStartGuide, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._checkStartGuide, self)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._checkStartGuide, self)
	PatFaceController.instance:registerCallback(PatFaceEvent.FinishAllPatFace, self._checkStartGuide, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function GuideTriggerEpisodeFinishAndInMainScene:assertGuideSatisfy(param, configParam)
	local configId = tonumber(configParam)
	local openCO = OpenConfig.instance:getOpenCo(configId)

	if openCO then
		if not openCO.episodeId then
			local configEpisodeId = configId
			local episodeMO = DungeonModel.instance:getEpisodeInfo(configEpisodeId)
			local episodeCO = DungeonConfig.instance:getEpisodeCO(configEpisodeId)

			if episodeCO and episodeMO and episodeMO.star > DungeonEnum.StarType.None then
				local hasFinishEpisode = episodeCO.afterStory <= 0 or episodeCO.afterStory > 0 and StoryModel.instance:isStoryFinished(episodeCO.afterStory)

				if not hasFinishEpisode then
					return false
				end
			else
				return false
			end

			local inMainScene = GameSceneMgr.instance:getCurSceneType() == SceneType.Main
			local isLoading = GameSceneMgr.instance:isLoading()
			local isClosing = GameSceneMgr.instance:isClosing()
			local isPatting = PatFaceModel.instance:getIsPatting()

			if inMainScene and not isLoading and not isClosing and not isPatting then
				local hasOpenAnyView = false
				local openViewNameList = ViewMgr.instance:getOpenViewNameList()

				for _, viewName in ipairs(openViewNameList) do
					if ViewMgr.instance:isModal(viewName) or ViewMgr.instance:isFull(viewName) then
						hasOpenAnyView = true

						break
					end
				end

				if not hasOpenAnyView then
					return true
				end
			end

			return false
		end
	end
end

function GuideTriggerEpisodeFinishAndInMainScene:_onOpenViewFinish(viewName)
	if viewName == ViewName.MainView then
		self:checkStartGuide()
	end
end

function GuideTriggerEpisodeFinishAndInMainScene:_onCloseViewFinish(viewName)
	self:checkStartGuide()
end

function GuideTriggerEpisodeFinishAndInMainScene:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerEpisodeFinishAndInMainScene
