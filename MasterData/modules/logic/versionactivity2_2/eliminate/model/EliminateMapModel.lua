-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/EliminateMapModel.lua

module("modules.logic.versionactivity2_2.eliminate.model.EliminateMapModel", package.seeall)

local EliminateMapModel = class("EliminateMapModel", BaseModel)

function EliminateMapModel:onInit()
	self:reInit()
end

function EliminateMapModel:reInit()
	self.isPlayingClickAnimation = false
end

function EliminateMapModel:getChapterStatus(chapterId)
	if not self:checkChapterIsUnlock(chapterId) then
		return EliminateMapEnum.ChapterStatus.Lock
	end

	return EliminateMapEnum.ChapterStatus.Normal
end

function EliminateMapModel:isFirstEpisode(episodeId)
	local targetConfig = lua_eliminate_episode.configDict[episodeId]
	local chapterId = targetConfig.chapterId
	local chapterList = EliminateOutsideModel.instance:getChapterList()
	local list = chapterList[chapterId]

	return list[1].id == episodeId
end

function EliminateMapModel:getEpisodeConfig(episodeId)
	return lua_eliminate_episode.configDict[episodeId]
end

function EliminateMapModel:getLastCanFightEpisodeMo(chapterId)
	local chapterList = EliminateOutsideModel.instance:getChapterList()
	local list = chapterList[chapterId]

	for i, v in ipairs(list) do
		if v.star == 0 then
			return v
		end
	end

	return list[#list]
end

function EliminateMapModel:getEpisodeList(chapterId)
	local chapterList = EliminateOutsideModel.instance:getChapterList()

	return chapterList[chapterId]
end

function EliminateMapModel:checkChapterIsUnlock(chapterId)
	local chapterList = EliminateOutsideModel.instance:getChapterList()
	local list = chapterList[chapterId]

	if not list or #list == 0 then
		return false
	end

	local firstEpisode = list[1].config

	return firstEpisode.preEpisode == 0 or EliminateOutsideModel.instance:hasPassedEpisode(firstEpisode.preEpisode)
end

function EliminateMapModel:getLastCanFightChapterId()
	local _lastChapterId
	local chapterList = EliminateOutsideModel.instance:getChapterList()

	for chapterId, v in ipairs(chapterList) do
		if self:checkChapterIsUnlock(chapterId) then
			_lastChapterId = chapterId
		end
	end

	return _lastChapterId
end

function EliminateMapModel.getChapterNum()
	return #EliminateMapModel.getChapterConfigList()
end

function EliminateMapModel.getChapterConfigList()
	return EliminateConfig.instance:getNormalChapterList()
end

function EliminateMapModel:setPlayingClickAnimation(isPlaying)
	self.isPlayingClickAnimation = isPlaying
end

function EliminateMapModel:checkIsPlayingClickAnimation()
	return self.isPlayingClickAnimation
end

EliminateMapModel.instance = EliminateMapModel.New()

return EliminateMapModel
