-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/controller/VersionActivity1_2DungeonController.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.controller.VersionActivity1_2DungeonController", package.seeall)

local VersionActivity1_2DungeonController = class("VersionActivity1_2DungeonController", BaseController)

function VersionActivity1_2DungeonController:onInit()
	return
end

function VersionActivity1_2DungeonController:onInitFinish()
	return
end

function VersionActivity1_2DungeonController:addConstEvents()
	return
end

function VersionActivity1_2DungeonController:reInit()
	return
end

function VersionActivity1_2DungeonController:setDungeonSelectedEpisodeId(episodeId)
	self.dungeonSelectedEpisodeId = episodeId
end

function VersionActivity1_2DungeonController:getDungeonSelectedEpisodeId()
	return self.dungeonSelectedEpisodeId
end

function VersionActivity1_2DungeonController:getEpisodeMapConfig(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local start_chapter_id = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1

	while episodeCo.chapterId ~= start_chapter_id do
		episodeCo = DungeonConfig.instance:getEpisodeCO(episodeCo.preEpisode)
	end

	return DungeonConfig.instance:getChapterMapCfg(start_chapter_id, episodeCo.preEpisode)
end

function VersionActivity1_2DungeonController:_onFinishStory()
	self:openDungeonView(self._enterChapterId, self._enterEpisodeId, self._showMapLevelView, self._focusCamp)
end

function VersionActivity1_2DungeonController:openDungeonView(chapterId, episodeId, showMapLevelView, focusCamp, jumpParam)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_2Enum.ActivityId.Dungeon) then
		local activityCo = ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.Dungeon)
		local storyId = activityCo and activityCo.storyId

		if storyId and storyId ~= 0 then
			self._enterChapterId = chapterId
			self._enterEpisodeId = episodeId
			self._showMapLevelView = showMapLevelView
			self._focusCamp = focusCamp

			StoryController.instance:playStory(storyId, nil, self._onFinishStory, self)

			return
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_2DungeonView, {
		chapterId = chapterId,
		episodeId = episodeId,
		showMapLevelView = showMapLevelView,
		focusCamp = focusCamp,
		jumpParam = jumpParam
	})
end

function VersionActivity1_2DungeonController:_getDefaultFocusEpisode(ChapterId)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(ChapterId)
	local allPassed = true
	local lastEpisodeId

	for i, v in ipairs(episodeList) do
		if not DungeonModel.instance:hasPassLevel(v.id) then
			allPassed = false
		end

		if DungeonModel.instance:isUnlock(v) and DungeonModel.instance:isFinishElementList(v) then
			lastEpisodeId = v.id
		end
	end

	if allPassed then
		local episodeId = VersionActivity1_2DungeonMapEpisodeBaseView.getlastBattleEpisodeId(ChapterId)

		if episodeId > 0 then
			return episodeId
		end
	end

	return lastEpisodeId or episodeList[1].id
end

function VersionActivity1_2DungeonController:getNowEpisodeId()
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1)
	local lastEpisodeId = episodeList[1].id

	for i, v in ipairs(episodeList) do
		if DungeonModel.instance:isUnlock(v) and DungeonModel.instance:isFinishElementList(v) then
			lastEpisodeId = v.id
		end
	end

	return lastEpisodeId
end

VersionActivity1_2DungeonController.instance = VersionActivity1_2DungeonController.New()

return VersionActivity1_2DungeonController
