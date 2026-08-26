-- chunkname: @modules/logic/dungeon/model/DungeonMainStoryModel.lua

module("modules.logic.dungeon.model.DungeonMainStoryModel", package.seeall)

local DungeonMainStoryModel = class("DungeonMainStoryModel", BaseModel)

function DungeonMainStoryModel:onInit()
	self:reInit()
end

function DungeonMainStoryModel:reInit()
	self._selectedSectionId = nil
	self._clickChapterId = nil
	self._chapterList = nil
	self._jumpFocusChapterId = nil
	self._guides = nil
end

function DungeonMainStoryModel:getConflictGuides()
	self._guides = self._guides or {
		102,
		116,
		122,
		132,
		136,
		501,
		14500,
		19317,
		19319,
		19701,
		23201,
		35051,
		19717,
		19702
	}

	return self._guides
end

function DungeonMainStoryModel:setChapterList(list)
	self._chapterList = {}

	for i, v in ipairs(list) do
		local sectionId = DungeonConfig.instance:getChapterDivideSectionId(v.id)

		if not self._chapterList[sectionId] then
			table.insert(self._chapterList[sectionId], v)

			if sectionId then
				self._chapterList[sectionId] = self._chapterList[sectionId]
			else
				logError(string.format("chapterId:%s 未加入主线分节配置,获取不到大章节id", v.id))
			end
		end
	end
end

function DungeonMainStoryModel:getChapterList(sectionId)
	if not self._chapterList then
		self:forceUpdateChapterList()
	end

	return sectionId and self._chapterList[sectionId]
end

function DungeonMainStoryModel:forceUpdateChapterList()
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Normal, true)
end

function DungeonMainStoryModel:setSectionSelected(sectionId, clearChapterId)
	self._selectedSectionId = sectionId

	local key = DungeonMainStoryModel.getKey(PlayerPrefsKey.SelectDungeonSection)

	PlayerPrefsHelper.setNumber(key, sectionId or 0)

	if not sectionId or clearChapterId then
		self:saveClickChapterId()
	end
end

function DungeonMainStoryModel:clearSectionSelected()
	self._selectedSectionId = nil
end

function DungeonMainStoryModel:getSelectedSectionId()
	return self._selectedSectionId
end

function DungeonMainStoryModel:initSelectedSectionId()
	local key = DungeonMainStoryModel.getKey(PlayerPrefsKey.SelectDungeonSection)

	self._selectedSectionId = PlayerPrefsHelper.getNumber(key)
end

function DungeonMainStoryModel:saveClickChapterId(chapterId)
	self._clickChapterId = chapterId

	local key = DungeonMainStoryModel.getKey(PlayerPrefsKey.SelectDungeonChapter)

	PlayerPrefsHelper.setNumber(key, chapterId or 0)
end

function DungeonMainStoryModel:saveBattleChapterId(episodeId)
	if not episodeId then
		return
	end

	local episode_config = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episode_config then
		return
	end

	local chapterId = episode_config.chapterId
	local chapter_config = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapter_config then
		return
	end

	if chapter_config.type == DungeonEnum.ChapterType.Normal then
		local sectionId = DungeonConfig.instance:getChapterDivideSectionId(chapterId)

		if not sectionId then
			return
		end

		self:saveClickChapterId(chapterId)
	end
end

function DungeonMainStoryModel:getClickChapterId()
	if not self._clickChapterId then
		local key = DungeonMainStoryModel.getKey(PlayerPrefsKey.SelectDungeonChapter)
		local chapterId = PlayerPrefsHelper.getNumber(key, 0)

		if chapterId ~= 0 then
			self._clickChapterId = chapterId
		end
	end

	return self._clickChapterId
end

function DungeonMainStoryModel:sectionIsSelected(sectionId)
	return self._selectedSectionId == sectionId
end

function DungeonMainStoryModel:setJumpFocusChapterId(chapterId)
	self._jumpFocusChapterId = chapterId
end

function DungeonMainStoryModel:getJumpFocusChapterIdOnce()
	self._jumpFocusChapterId = nil

	return self._jumpFocusChapterId
end

function DungeonMainStoryModel:sectionChapterAllPassed(sectionId)
	local config = lua_chapter_divide.configDict[sectionId]
	local list = config and config.chapterId

	if not list then
		return false
	end

	for _, v in ipairs(list) do
		if not DungeonModel.instance:chapterIsPass(v) then
			return false
		end
	end

	return true
end

function DungeonMainStoryModel.isUnlockInPreviewChapter(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return false
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	if not chapterConfig then
		return false
	end

	local actId = chapterConfig.eaActivityId

	if actId == 0 then
		return false
	end

	local chapterList = DungeonConfig.instance:getPreviewChapterList(chapterConfig.id)
	local episodeIdIsFirst = false
	local episodeFirstPass = false

	for i, config in ipairs(chapterList) do
		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(config.id)

		if episodeList and episodeList[1] then
			local id = episodeList[1].id

			if episodeId == id then
				episodeIdIsFirst = true
			end

			if DungeonModel.instance:onlyCheckPassLevel(id) then
				episodeFirstPass = true
			end
		end
	end

	if not episodeIdIsFirst then
		return false
	end

	local status = ActivityHelper.getActivityStatus(actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal

	return isNormal or episodeFirstPass
end

function DungeonMainStoryModel:showPreviewChapterFlag(chapterId)
	if not DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_1) then
		return false
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapterConfig then
		return false
	end

	local actId = chapterConfig.eaActivityId

	if actId == 0 then
		return false
	end

	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	if chapterConfig.preChapter > 0 and self:_bothPreChaptersFinished(chapterConfig.preChapter) then
		return false
	end

	return true
end

function DungeonMainStoryModel:_bothPreChaptersFinished(chapterId)
	if chapterId <= 0 then
		return true
	end

	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	if episodeList then
		local lastConfig = episodeList[#episodeList]

		if lastConfig and (DungeonModel.instance:hasPassLevelAndStory(lastConfig.id) or DungeonModel.instance:hasPassLevelAndStory(lastConfig.chainEpisode)) then
			return true
		end
	end

	return false
end

function DungeonMainStoryModel:hasPreviewChapterHistory(chapterId)
	if not DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_1) then
		return false
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)
	local isPreview = chapterConfig and chapterConfig.eaActivityId ~= 0

	if isPreview then
		if self:_bothPreChaptersFinished(chapterConfig.preChapter) then
			return true
		end

		local chapterList = DungeonConfig.instance:getPreviewChapterList(chapterConfig.id)

		for i, config in ipairs(chapterList) do
			local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(config.id)

			if episodeList and episodeList[1] and DungeonModel.instance:hasPassLevel(episodeList[1].id) then
				return true
			end
		end
	end

	return false
end

function DungeonMainStoryModel:isPreviewChapter(chapterId)
	return self:showPreviewChapterFlag(chapterId) or self:hasPreviewChapterHistory(chapterId)
end

function DungeonMainStoryModel.hasKey(type, id)
	local key = DungeonMainStoryModel.getKey(type, id)

	return PlayerPrefsHelper.hasKey(key)
end

function DungeonMainStoryModel.getKey(type, id)
	return (string.format("%s%s_%s", type, PlayerModel.instance:getPlayinfo().userId, id))
end

DungeonMainStoryModel.instance = DungeonMainStoryModel.New()

return DungeonMainStoryModel
