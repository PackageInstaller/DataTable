-- chunkname: @modules/logic/guide/controller/special/GuideSpecialRoomOpen.lua

module("modules.logic.guide.controller.special.GuideSpecialRoomOpen", package.seeall)

local GuideSpecialRoomOpen = class("GuideSpecialRoomOpen", BaseGuideAction)
local GuideId = 401
local FinishStepId = 17

function GuideSpecialRoomOpen:ctor()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	GuideController.instance:registerCallback(GuideEvent.StartGuide, self._onStartGuide, self)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
end

function GuideSpecialRoomOpen:reInit()
	self._hasGetInfo = nil
end

function GuideSpecialRoomOpen:_onGetInfoFinish()
	self._hasGetInfo = true
end

function GuideSpecialRoomOpen:_onUpdateDungeonInfo(info)
	if self._hasGetInfo then
		self:_checkStart()
	end
end

function GuideSpecialRoomOpen:_checkStart()
	if not self._hasGetInfo then
		return
	end

	if GuideController.instance:isForbidGuides() then
		return
	end

	local doingGuideId = GuideModel.instance:getDoingGuideId()

	if doingGuideId and doingGuideId ~= GuideId then
		return
	end

	if GuideModel.instance:isStepFinish(GuideId, FinishStepId) then
		return
	end

	local triggerType = GuideConfig.instance:getTriggerType(GuideId)

	if triggerType == "EpisodeFinishAndInMainScene" then
		local triggerParam = GuideConfig.instance:getTriggerParam(GuideId)
		local configId = tonumber(triggerParam)
		local openCO = OpenConfig.instance:getOpenCo(configId)

		if openCO then
			if not openCO.episodeId then
				local configEpisodeId = configId
				local episodeMO = DungeonModel.instance:getEpisodeInfo(configEpisodeId)
				local episodeCO = DungeonConfig.instance:getEpisodeCO(configEpisodeId)

				if episodeCO and episodeMO and episodeMO.star > DungeonEnum.StarType.None then
					local hasFinishEpisode = episodeCO.afterStory <= 0 or episodeCO.afterStory > 0 and StoryModel.instance:isStoryFinished(episodeCO.afterStory)

					if hasFinishEpisode then
						GuideModel.instance:setFlag(GuideModel.GuideFlag.DontOpenMain, true, GuideId)
					end
				end
			end
		end
	else
		logError("小屋401触发条件有修改")
	end
end

function GuideSpecialRoomOpen:_onStartGuide(guideId)
	if not guideId then
		return
	end

	if guideId == GuideId then
		self:_checkStart()
	else
		local guideCO = GuideConfig.instance:getGuideCO(guideId)

		if guideCO and guideCO.parallel ~= 1 then
			GuideModel.instance:setFlag(GuideModel.GuideFlag.DontOpenMain, nil)
		end
	end
end

function GuideSpecialRoomOpen:_onFinishGuide(guideId)
	if not guideId then
		return
	end

	if guideId == GuideId then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.MainView) then
			return
		end

		if ViewMgr.instance:hasOpenFullView() then
			return
		end

		ViewMgr.instance:openView(ViewName.MainView)
	else
		self:_checkStart()
	end
end

function GuideSpecialRoomOpen:_removeEvents()
	LoginController.instance:unregisterCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, self._onStartGuide, self)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
end

function GuideSpecialRoomOpen:clearWork()
	self:_removeEvents()
end

return GuideSpecialRoomOpen
