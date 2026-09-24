-- chunkname: @modules/logic/matchgame/model/MatchGameLevelModel.lua

module("modules.logic.matchgame.model.MatchGameLevelModel", package.seeall)

local MatchGameLevelModel = class("MatchGameLevelModel", BaseModel)

function MatchGameLevelModel:onInit()
	self:reInit()
end

function MatchGameLevelModel:reInit()
	self._curEpisodeIndex = 0
	self._curEpisodeId = 0
	self._curChapterIndex = 0
	self._curChapterId = 0
	self._curEpisodeCos = nil
	self._curChapterMo = nil
	self._mapType = MatchGameEnum.LevelType.Normal
end

function MatchGameLevelModel:initMapType(mapType, chapterId)
	self._mapType = mapType or MatchGameEnum.LevelType.Normal
	self._chapterMoList = MatchGameConfig.instance:getChapterListByLevelType(self._mapType)

	if not self._chapterMoList then
		logError(string.format("三消不存在任意章节配置 mapType = %s", self._mapType))

		self._chapterMoList = {}
	end

	chapterId = chapterId or self:_findSelectChapterId()

	self:initChapter(chapterId)
end

function MatchGameLevelModel:_findSelectChapterId()
	if not self._chapterMoList then
		return
	end

	if not self._chapterMoList[1].chapterId then
		local lastChapterId = 0

		for _, chapterMo in ipairs(self._chapterMoList) do
			if MatchGameHelper.isChapterUnlock(chapterMo.chapterId) then
				lastChapterId = chapterMo.chapterId
			end
		end

		return lastChapterId
	end
end

function MatchGameLevelModel:initChapter(chapterId)
	self._curChapterId = chapterId
	self._curChapterIndex = self:_getChapterIndexByChapterId(chapterId)
	self._curChapterMo = MatchGameConfig.instance:getChapterMo(self._curChapterId)
	self._curEpisodeCos = self._curChapterMo and self._curChapterMo.episodeList

	self:_initEpisodeInfoList()
end

function MatchGameLevelModel:_getChapterIndexByChapterId(chapterId)
	local index = 1

	if self._chapterMoList then
		for i, chapterCo in ipairs(self._chapterMoList) do
			if chapterCo.chapterId == chapterId then
				index = i

				break
			end
		end
	end

	return index
end

function MatchGameLevelModel:_initEpisodeInfoList()
	local maxUnlockEpisode = self:getMaxUnlockEpisodeId()

	self:setCurEpisode(maxUnlockEpisode)
end

function MatchGameLevelModel:switchChapter(chapterId, showToast)
	if not self:isCanSwitchChapter(chapterId, showToast) then
		return
	end

	self:initChapter(chapterId)
	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnClickSelectMap, chapterId)
end

function MatchGameLevelModel:isCanSwitchChapter(chapterId, showToast)
	if self._curChapterId == chapterId then
		return
	end

	local unlock, toastId, toastParam = MatchGameHelper.isChapterUnlock(chapterId)

	if not unlock then
		if showToast and toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	return true
end

function MatchGameLevelModel:switchEpisode(episodeId)
	if self._curEpisodeId == episodeId then
		return
	end

	self:setCurEpisode(episodeId)
end

function MatchGameLevelModel:setCurEpisode(episodeId)
	self._curEpisodeIndex = self:getEpisodeIndex(episodeId)
	self._curEpisodeId = episodeId or self._curEpisodeId

	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnClickSelectEpisode, self._curEpisodeId)
end

function MatchGameLevelModel:getEpisodeIndex(episodeId)
	for index, co in ipairs(self._curEpisodeCos) do
		if co.id == episodeId then
			return index
		end
	end
end

function MatchGameLevelModel:getCurEpisodeCos()
	return self._curEpisodeCos
end

function MatchGameLevelModel:getCurChapterCos()
	return self._chapterMoList
end

function MatchGameLevelModel:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function MatchGameLevelModel:getCurEpisodeId()
	return self._curEpisodeId
end

function MatchGameLevelModel:getCurEpisodeCo()
	return self._curEpisodeCos and self._curEpisodeCos[self._curEpisodeIndex]
end

function MatchGameLevelModel:getCurChapterId()
	return self._curChapterId
end

function MatchGameLevelModel:getCurChapterIndex()
	return self._curChapterIndex or 0
end

function MatchGameLevelModel:isEpisodeUnlock(episodeId)
	return MatchGameModel.instance:getEpisodeStatus(episodeId) >= MatchGameEnum.EpisodeStatus.Unlock
end

function MatchGameLevelModel:getEpisodeInfoById(episodeId)
	return MatchGameModel.instance:getEpisodeInfoById(episodeId)
end

function MatchGameLevelModel:isEpisodePass(episodeId)
	return MatchGameModel.instance:getEpisodeStatus(episodeId) == MatchGameEnum.EpisodeStatus.Finish
end

function MatchGameLevelModel:isAllEpisodeFinish()
	if not self._curEpisodeCos then
		return
	end

	for _, episodeCo in ipairs(self._curEpisodeCos) do
		if not self:isEpisodePass(episodeCo.id) then
			return false
		end
	end

	return true
end

function MatchGameLevelModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function MatchGameLevelModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function MatchGameLevelModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function MatchGameLevelModel:getMaxUnlockEpisodeId()
	local maxEpisodeId = 0

	for _, episodeCo in ipairs(self._curEpisodeCos) do
		local isUnlock = self:isEpisodeUnlock(episodeCo.id)

		if not isUnlock then
			break
		end

		maxEpisodeId = episodeCo.id
	end

	return maxEpisodeId
end

MatchGameLevelModel.instance = MatchGameLevelModel.New()

return MatchGameLevelModel
