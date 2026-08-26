-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/model/WuErLiXiModel.lua

module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiModel", package.seeall)

local WuErLiXiModel = class("WuErLiXiModel", BaseModel)

function WuErLiXiModel:onInit()
	self:reInit()
end

function WuErLiXiModel:reInit()
	self._episodeInfos = {}
	self._curEpisodeIndex = 0
end

function WuErLiXiModel:initInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = WuErLiXiEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function WuErLiXiModel:updateEpisodeInfo(info)
	self._episodeInfos[info.episodeId]:update(info)
end

function WuErLiXiModel:updateInfos(infos)
	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = WuErLiXiEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function WuErLiXiModel:updateEpisodeGameString(episodeId, str)
	self._episodeInfos[episodeId]:updateGameString(str)
end

function WuErLiXiModel:getCurGameProcess(episodeId)
	return self._episodeInfos[episodeId].gameString
end

function WuErLiXiModel:getEpisodeStatus(episodeId)
	return self._episodeInfos[episodeId].status
end

function WuErLiXiModel:setCurEpisodeIndex(index)
	self._curEpisodeIndex = index
end

function WuErLiXiModel:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function WuErLiXiModel:isEpisodeUnlock(episodeId)
	return self._episodeInfos[episodeId]
end

function WuErLiXiModel:isEpisodePass(episodeId)
	if not self._episodeInfos[episodeId] then
		return false
	end

	return self._episodeInfos[episodeId].isFinished
end

function WuErLiXiModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function WuErLiXiModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function WuErLiXiModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

WuErLiXiModel.instance = WuErLiXiModel.New()

return WuErLiXiModel
