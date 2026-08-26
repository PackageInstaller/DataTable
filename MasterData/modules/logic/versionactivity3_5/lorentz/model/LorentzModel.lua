-- chunkname: @modules/logic/versionactivity3_5/lorentz/model/LorentzModel.lua

module("modules.logic.versionactivity3_5.lorentz.model.LorentzModel", package.seeall)

local LorentzModel = class("LorentzModel", BaseModel)

function LorentzModel:onInit()
	self:reInit()
end

function LorentzModel:reInit()
	self._episodeInfos = {}
	self._curEpisodeIndex = 0
	self._curEpisode = 0
	self._actId = VersionActivity3_5Enum.ActivityId.Lorentz
end

function LorentzModel:initInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = LorentzEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function LorentzModel:updateEpisodeInfo(info)
	self._episodeInfos[info.episodeId]:update(info)
end

function LorentzModel:updateInfos(infos)
	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = LorentzEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function LorentzModel:updateInfoFinish(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		mo.isFinished = true
	end
end

function LorentzModel:updateInfoFinishGame(msg)
	local mo = self._episodeInfos[msg.episodeId]

	if mo then
		mo.progress = msg.progress
	end
end

function LorentzModel:checkEpisodeFinishGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:checkFinishGame()
	end

	return false
end

function LorentzModel:getCurGameProgress(episodeId)
	return self._episodeInfos[episodeId].progress
end

function LorentzModel:getEpisodeUnlockBranchIdList(episodeId)
	return self._episodeInfos[episodeId].unlockBranchIds
end

function LorentzModel:setCurEpisode(index, episodeId)
	self._curEpisodeIndex = index
	self._curEpisode = episodeId and episodeId or self._curEpisode
end

function LorentzModel:getEpisodeIndex(episodeId)
	local colist = LorentzConfig.instance:getEpisodeCoList(self._actId)

	for index, co in ipairs(colist) do
		if co.episodeId == episodeId then
			return index
		end
	end
end

function LorentzModel:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function LorentzModel:getCurEpisode()
	return self._curEpisode
end

function LorentzModel:isEpisodeUnlock(episodeId)
	return self._episodeInfos[episodeId]
end

function LorentzModel:isEpisodePass(episodeId)
	if not self._episodeInfos[episodeId] then
		return false
	end

	return self._episodeInfos[episodeId].isFinished
end

function LorentzModel:checkEpisodeIsGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:isGame()
	end

	return true
end

function LorentzModel:isAllEpisodeFinish()
	for _, info in pairs(self._episodeInfos) do
		if not info.isFinished then
			return false
		end
	end

	return true
end

function LorentzModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function LorentzModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function LorentzModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function LorentzModel:getMaxUnlockEpisodeId()
	local episodeCos = LorentzConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		local isUnlock = self:isEpisodeUnlock(episodeCo.episodeId)

		maxEpisodeId = isUnlock and math.max(maxEpisodeId, episodeCo.episodeId) or maxEpisodeId
	end

	return maxEpisodeId
end

function LorentzModel:getMaxEpisodeId()
	local episodeCos = LorentzConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		maxEpisodeId = math.max(maxEpisodeId, episodeCo.episodeId)
	end

	return maxEpisodeId
end

LorentzModel.instance = LorentzModel.New()

return LorentzModel
