-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/Activity201MaLiAnNaModel.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.Activity201MaLiAnNaModel", package.seeall)

local Activity201MaLiAnNaModel = class("Activity201MaLiAnNaModel", BaseModel)

function Activity201MaLiAnNaModel:onInit()
	self:reInit()
end

function Activity201MaLiAnNaModel:reInit()
	self._episodeInfos = {}
	self._curEpisodeIndex = 0
	self._curEpisode = 0
	self._actId = VersionActivity3_0Enum.ActivityId.MaLiAnNa
end

function Activity201MaLiAnNaModel:initInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = Activity201MaLiAnNaEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function Activity201MaLiAnNaModel:updateEpisodeInfo(info)
	self._episodeInfos[info.episodeId]:update(info)
end

function Activity201MaLiAnNaModel:updateInfos(infos)
	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = Activity201MaLiAnNaEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function Activity201MaLiAnNaModel:updateInfoFinish(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		mo.isFinished = true
	end
end

function Activity201MaLiAnNaModel:updateInfoFinishGame(msg)
	local mo = self._episodeInfos[msg.episodeId]

	if mo then
		mo.progress = msg.progress
	end
end

function Activity201MaLiAnNaModel:checkEpisodeFinishGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:checkFinishGame()
	end

	return false
end

function Activity201MaLiAnNaModel:getCurGameProgress(episodeId)
	return self._episodeInfos[episodeId].progress
end

function Activity201MaLiAnNaModel:getEpisodeUnlockBranchIdList(episodeId)
	return self._episodeInfos[episodeId].unlockBranchIds
end

function Activity201MaLiAnNaModel:setCurEpisode(index, episodeId)
	self._curEpisodeIndex = index
	self._curEpisode = episodeId and episodeId or self._curEpisode
end

function Activity201MaLiAnNaModel:getEpisodeIndex(episodeId)
	local colist = Activity201MaLiAnNaConfig.instance:getEpisodeCoList(self._actId)

	for index, co in ipairs(colist) do
		if co.episodeId == episodeId then
			return index
		end
	end
end

function Activity201MaLiAnNaModel:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function Activity201MaLiAnNaModel:getCurEpisode()
	return self._curEpisode
end

function Activity201MaLiAnNaModel:isEpisodeUnlock(episodeId)
	return self._episodeInfos[episodeId]
end

function Activity201MaLiAnNaModel:isEpisodePass(episodeId)
	if not self._episodeInfos[episodeId] then
		return false
	end

	return self._episodeInfos[episodeId].isFinished
end

function Activity201MaLiAnNaModel:checkEpisodeIsGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:isGame()
	end

	return true
end

function Activity201MaLiAnNaModel:isAllEpisodeFinish()
	for _, info in pairs(self._episodeInfos) do
		if not info.isFinished then
			return false
		end
	end

	return true
end

function Activity201MaLiAnNaModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function Activity201MaLiAnNaModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function Activity201MaLiAnNaModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function Activity201MaLiAnNaModel:getMaxUnlockEpisodeId()
	local episodeCos = Activity201MaLiAnNaConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		local isUnlock = self:isEpisodeUnlock(episodeCo.episodeId)

		maxEpisodeId = isUnlock and math.max(maxEpisodeId, episodeCo.episodeId) or maxEpisodeId
	end

	return maxEpisodeId
end

function Activity201MaLiAnNaModel:getMaxEpisodeId()
	local episodeCos = Activity201MaLiAnNaConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		maxEpisodeId = math.max(maxEpisodeId, episodeCo.episodeId)
	end

	return maxEpisodeId
end

Activity201MaLiAnNaModel.instance = Activity201MaLiAnNaModel.New()

return Activity201MaLiAnNaModel
