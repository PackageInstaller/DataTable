-- chunkname: @modules/logic/versionactivity3_8/dianjishi/model/DianJiShiModel.lua

module("modules.logic.versionactivity3_8.dianjishi.model.DianJiShiModel", package.seeall)

local DianJiShiModel = class("DianJiShiModel", BaseModel)

function DianJiShiModel:onInit()
	self:reInit()
end

function DianJiShiModel:reInit()
	self._episodeInfos = {}
	self._curEpisodeIndex = 0
	self._curEpisode = 0
end

function DianJiShiModel:initInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = DianJiShiEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function DianJiShiModel:updateEpisodeInfo(info)
	self._episodeInfos[info.episodeId]:update(info)
end

function DianJiShiModel:updateInfos(infos)
	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = DianJiShiEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function DianJiShiModel:updateInfoFinish(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		mo.isFinished = true
	end
end

function DianJiShiModel:updateInfoFinishGame(msg)
	local mo = self._episodeInfos[msg.episodeId]

	if mo then
		mo.progress = msg.progress
	end
end

function DianJiShiModel:checkEpisodeFinishGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:checkFinishGame()
	end

	return false
end

function DianJiShiModel:getCurGameProgress(episodeId)
	return self._episodeInfos[episodeId].progress
end

function DianJiShiModel:getEpisodeUnlockBranchIdList(episodeId)
	return self._episodeInfos[episodeId].unlockBranchIds
end

function DianJiShiModel:setCurEpisode(index, episodeId)
	self._curEpisodeIndex = index
	self._curEpisode = episodeId and episodeId or self._curEpisode
end

function DianJiShiModel:getEpisodeIndex(episodeId)
	local colist = Activity220Config.instance:getEpisodeConfigList(VersionActivity3_8Enum.ActivityId.DianJiShi)

	for index, co in ipairs(colist) do
		if co.episodeId == episodeId then
			return index
		end
	end
end

function DianJiShiModel:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function DianJiShiModel:getCurEpisode()
	return self._curEpisode
end

function DianJiShiModel:isEpisodeUnlock(episodeId)
	return self._episodeInfos[episodeId]
end

function DianJiShiModel:isEpisodePass(episodeId)
	if not self._episodeInfos[episodeId] then
		return false
	end

	return self._episodeInfos[episodeId].isFinished
end

function DianJiShiModel:checkEpisodeIsGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:isGame()
	end

	return true
end

function DianJiShiModel:isAllEpisodeFinish()
	for _, info in pairs(self._episodeInfos) do
		if not info.isFinished then
			return false
		end
	end

	return true
end

function DianJiShiModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function DianJiShiModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function DianJiShiModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function DianJiShiModel:getMaxUnlockEpisodeId()
	local episodeCos = Activity220Config.instance:getEpisodeConfigList(VersionActivity3_8Enum.ActivityId.DianJiShi)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		local isUnlock = self:isEpisodeUnlock(episodeCo.episodeId)

		maxEpisodeId = isUnlock and math.max(maxEpisodeId, episodeCo.episodeId) or maxEpisodeId
	end

	return maxEpisodeId
end

function DianJiShiModel:getMaxEpisodeId()
	local episodeCos = Activity220Config.instance:getEpisodeConfigList(VersionActivity3_8Enum.ActivityId.DianJiShi)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		maxEpisodeId = math.max(maxEpisodeId, episodeCo.episodeId)
	end

	return maxEpisodeId
end

DianJiShiModel.instance = DianJiShiModel.New()

return DianJiShiModel
