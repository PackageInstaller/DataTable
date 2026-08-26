-- chunkname: @modules/logic/versionactivity3_2/beilier/model/BeiLiErModel.lua

module("modules.logic.versionactivity3_2.beilier.model.BeiLiErModel", package.seeall)

local BeiLiErModel = class("BeiLiErModel", BaseModel)

function BeiLiErModel:onInit()
	self:reInit()
end

function BeiLiErModel:reInit()
	self._episodeInfos = {}
	self._curEpisodeIndex = 0
	self._curEpisode = 0
	self._actId = VersionActivity3_2Enum.ActivityId.BeiLiEr
end

function BeiLiErModel:initInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = BeiLiErEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function BeiLiErModel:updateEpisodeInfo(info)
	self._episodeInfos[info.episodeId]:update(info)
end

function BeiLiErModel:updateInfos(infos)
	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = BeiLiErEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function BeiLiErModel:updateInfoFinish(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		mo.isFinished = true
	end
end

function BeiLiErModel:updateInfoFinishGame(msg)
	local mo = self._episodeInfos[msg.episodeId]

	if mo then
		mo.progress = msg.progress
	end
end

function BeiLiErModel:checkEpisodeFinishGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:checkFinishGame()
	end

	return false
end

function BeiLiErModel:getCurGameProgress(episodeId)
	return self._episodeInfos[episodeId].progress
end

function BeiLiErModel:getEpisodeUnlockBranchIdList(episodeId)
	return self._episodeInfos[episodeId].unlockBranchIds
end

function BeiLiErModel:setCurEpisode(index, episodeId)
	self._curEpisodeIndex = index
	self._curEpisode = episodeId and episodeId or self._curEpisode
end

function BeiLiErModel:getEpisodeIndex(episodeId)
	local colist = BeiLiErConfig.instance:getEpisodeCoList(self._actId)

	for index, co in ipairs(colist) do
		if co.episodeId == episodeId then
			return index
		end
	end
end

function BeiLiErModel:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function BeiLiErModel:getCurEpisode()
	return self._curEpisode
end

function BeiLiErModel:isEpisodeUnlock(episodeId)
	return self._episodeInfos[episodeId]
end

function BeiLiErModel:isEpisodePass(episodeId)
	if not self._episodeInfos[episodeId] then
		return false
	end

	return self._episodeInfos[episodeId].isFinished
end

function BeiLiErModel:checkEpisodeIsGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:isGame()
	end

	return true
end

function BeiLiErModel:isAllEpisodeFinish()
	for _, info in pairs(self._episodeInfos) do
		if not info.isFinished then
			return false
		end
	end

	return true
end

function BeiLiErModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function BeiLiErModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function BeiLiErModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function BeiLiErModel:getMaxUnlockEpisodeId()
	local episodeCos = BeiLiErConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		local isUnlock = self:isEpisodeUnlock(episodeCo.episodeId)

		maxEpisodeId = isUnlock and math.max(maxEpisodeId, episodeCo.episodeId) or maxEpisodeId
	end

	return maxEpisodeId
end

function BeiLiErModel:getMaxEpisodeId()
	local episodeCos = BeiLiErConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		maxEpisodeId = math.max(maxEpisodeId, episodeCo.episodeId)
	end

	return maxEpisodeId
end

BeiLiErModel.instance = BeiLiErModel.New()

return BeiLiErModel
