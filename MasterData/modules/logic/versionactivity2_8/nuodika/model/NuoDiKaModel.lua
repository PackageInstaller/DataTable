-- chunkname: @modules/logic/versionactivity2_8/nuodika/model/NuoDiKaModel.lua

module("modules.logic.versionactivity2_8.nuodika.model.NuoDiKaModel", package.seeall)

local NuoDiKaModel = class("NuoDiKaModel", BaseModel)

function NuoDiKaModel:onInit()
	self:reInit()
end

function NuoDiKaModel:reInit()
	self._episodeInfos = {}
	self._curEpisodeIndex = 0
	self._curEpisode = 0
end

function NuoDiKaModel:initInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = NuoDiKaEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function NuoDiKaModel:updateEpisodeInfo(info)
	self._episodeInfos[info.episodeId]:update(info)
end

function NuoDiKaModel:updateInfos(infos)
	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = NuoDiKaEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function NuoDiKaModel:getCurGameProcess(episodeId)
	return self._episodeInfos[episodeId].gameString
end

function NuoDiKaModel:getEpisodeStatus(episodeId)
	return self._episodeInfos[episodeId].status
end

function NuoDiKaModel:setCurEpisode(index, episodeId)
	self._curEpisodeIndex = index
	self._curEpisode = episodeId and episodeId or self._curEpisode
end

function NuoDiKaModel:getEpisodeIndex(episodeId)
	return episodeId % 1000
end

function NuoDiKaModel:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function NuoDiKaModel:getCurEpisode()
	return self._curEpisode
end

function NuoDiKaModel:isEpisodeUnlock(episodeId)
	return self._episodeInfos[episodeId]
end

function NuoDiKaModel:isEpisodePass(episodeId)
	if not self._episodeInfos[episodeId] then
		return false
	end

	return self._episodeInfos[episodeId].isFinished
end

function NuoDiKaModel:isAllEpisodeFinish()
	for _, info in pairs(self._episodeInfos) do
		if not info.isFinished then
			return false
		end
	end

	return true
end

function NuoDiKaModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function NuoDiKaModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function NuoDiKaModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function NuoDiKaModel:getMaxUnlockEpisodeId()
	local episodeCos = NuoDiKaConfig.instance:getEpisodeCoList(VersionActivity2_8Enum.ActivityId.NuoDiKa)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		local isUnlock = self:isEpisodeUnlock(episodeCo.episodeId)

		maxEpisodeId = isUnlock and math.max(maxEpisodeId, episodeCo.episodeId) or maxEpisodeId
	end

	return maxEpisodeId
end

function NuoDiKaModel:getMaxEpisodeId()
	local episodeCos = NuoDiKaConfig.instance:getEpisodeCoList(VersionActivity2_8Enum.ActivityId.NuoDiKa)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		maxEpisodeId = math.max(maxEpisodeId, episodeCo.episodeId)
	end

	return maxEpisodeId
end

NuoDiKaModel.instance = NuoDiKaModel.New()

return NuoDiKaModel
