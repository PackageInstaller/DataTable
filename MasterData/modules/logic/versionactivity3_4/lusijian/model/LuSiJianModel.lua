-- chunkname: @modules/logic/versionactivity3_4/lusijian/model/LuSiJianModel.lua

module("modules.logic.versionactivity3_4.lusijian.model.LuSiJianModel", package.seeall)

local LuSiJianModel = class("LuSiJianModel", BaseModel)

function LuSiJianModel:onInit()
	self:reInit()
end

function LuSiJianModel:reInit()
	self._episodeInfos = {}
	self._curEpisodeIndex = 0
	self._curEpisode = 0
	self._actId = VersionActivity3_4Enum.ActivityId.LuSiJian
end

function LuSiJianModel:initInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = LuSiJianEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function LuSiJianModel:updateEpisodeInfo(info)
	self._episodeInfos[info.episodeId]:update(info)
end

function LuSiJianModel:updateInfos(infos)
	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = LuSiJianEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function LuSiJianModel:updateInfoFinish(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		mo.isFinished = true
	end
end

function LuSiJianModel:updateInfoFinishGame(msg)
	local mo = self._episodeInfos[msg.episodeId]

	if mo then
		mo.progress = msg.progress
	end
end

function LuSiJianModel:checkEpisodeFinishGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:checkFinishGame()
	end

	return false
end

function LuSiJianModel:getCurGameProgress(episodeId)
	return self._episodeInfos[episodeId].progress
end

function LuSiJianModel:getEpisodeUnlockBranchIdList(episodeId)
	return self._episodeInfos[episodeId].unlockBranchIds
end

function LuSiJianModel:setCurEpisode(index, episodeId)
	self._curEpisodeIndex = index
	self._curEpisode = episodeId and episodeId or self._curEpisode
end

function LuSiJianModel:getEpisodeIndex(episodeId)
	local colist = LuSiJianConfig.instance:getEpisodeCoList(self._actId)

	for index, co in ipairs(colist) do
		if co.episodeId == episodeId then
			return index
		end
	end
end

function LuSiJianModel:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function LuSiJianModel:getCurEpisode()
	return self._curEpisode
end

function LuSiJianModel:isEpisodeUnlock(episodeId)
	return self._episodeInfos[episodeId]
end

function LuSiJianModel:isEpisodePass(episodeId)
	if not self._episodeInfos[episodeId] then
		return false
	end

	return self._episodeInfos[episodeId].isFinished
end

function LuSiJianModel:checkEpisodeIsGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:isGame()
	end

	return true
end

function LuSiJianModel:isAllEpisodeFinish()
	for _, info in pairs(self._episodeInfos) do
		if not info.isFinished then
			return false
		end
	end

	return true
end

function LuSiJianModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function LuSiJianModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function LuSiJianModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function LuSiJianModel:getMaxUnlockEpisodeId()
	local episodeCos = LuSiJianConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		local isUnlock = self:isEpisodeUnlock(episodeCo.episodeId)

		maxEpisodeId = isUnlock and math.max(maxEpisodeId, episodeCo.episodeId) or maxEpisodeId
	end

	return maxEpisodeId
end

function LuSiJianModel:getMaxEpisodeId()
	local episodeCos = LuSiJianConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		maxEpisodeId = math.max(maxEpisodeId, episodeCo.episodeId)
	end

	return maxEpisodeId
end

LuSiJianModel.instance = LuSiJianModel.New()

return LuSiJianModel
