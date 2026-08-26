-- chunkname: @modules/logic/versionactivity3_7/xruianyi/model/XRuiAnYiModel.lua

module("modules.logic.versionactivity3_7.xruianyi.model.XRuiAnYiModel", package.seeall)

local XRuiAnYiModel = class("XRuiAnYiModel", BaseModel)

function XRuiAnYiModel:onInit()
	self:reInit()
end

function XRuiAnYiModel:reInit()
	self._episodeInfos = {}
	self._curEpisodeIndex = 0
	self._curEpisode = 0
	self._actId = VersionActivity3_7Enum.ActivityId.XRuiAnYi
end

function XRuiAnYiModel:initInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = XRuiAnYiEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function XRuiAnYiModel:updateEpisodeInfo(info)
	self._episodeInfos[info.episodeId]:update(info)
end

function XRuiAnYiModel:updateInfos(infos)
	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = XRuiAnYiEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function XRuiAnYiModel:updateInfoFinish(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		mo.isFinished = true
	end
end

function XRuiAnYiModel:updateInfoFinishGame(msg)
	local mo = self._episodeInfos[msg.episodeId]

	if mo then
		mo.progress = msg.progress
	end
end

function XRuiAnYiModel:checkEpisodeFinishGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:checkFinishGame()
	end

	return false
end

function XRuiAnYiModel:getCurGameProgress(episodeId)
	return self._episodeInfos[episodeId].progress
end

function XRuiAnYiModel:getEpisodeUnlockBranchIdList(episodeId)
	return self._episodeInfos[episodeId].unlockBranchIds
end

function XRuiAnYiModel:setCurEpisode(index, episodeId)
	self._curEpisodeIndex = index
	self._curEpisode = episodeId and episodeId or self._curEpisode
end

function XRuiAnYiModel:getEpisodeIndex(episodeId)
	local colist = XRuiAnYiConfig.instance:getEpisodeCoList(self._actId)

	for index, co in ipairs(colist) do
		if co.episodeId == episodeId then
			return index
		end
	end
end

function XRuiAnYiModel:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function XRuiAnYiModel:getCurEpisode()
	return self._curEpisode
end

function XRuiAnYiModel:isEpisodeUnlock(episodeId)
	return self._episodeInfos[episodeId]
end

function XRuiAnYiModel:isEpisodePass(episodeId)
	if not self._episodeInfos[episodeId] then
		return false
	end

	return self._episodeInfos[episodeId].isFinished
end

function XRuiAnYiModel:checkEpisodeIsGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:isGame()
	end

	return true
end

function XRuiAnYiModel:isAllEpisodeFinish()
	for _, info in pairs(self._episodeInfos) do
		if not info.isFinished then
			return false
		end
	end

	return true
end

function XRuiAnYiModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function XRuiAnYiModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function XRuiAnYiModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function XRuiAnYiModel:getMaxUnlockEpisodeId()
	local episodeCos = XRuiAnYiConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		local isUnlock = self:isEpisodeUnlock(episodeCo.episodeId)

		maxEpisodeId = isUnlock and math.max(maxEpisodeId, episodeCo.episodeId) or maxEpisodeId
	end

	return maxEpisodeId
end

function XRuiAnYiModel:getMaxEpisodeId()
	local episodeCos = XRuiAnYiConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		maxEpisodeId = math.max(maxEpisodeId, episodeCo.episodeId)
	end

	return maxEpisodeId
end

XRuiAnYiModel.instance = XRuiAnYiModel.New()

return XRuiAnYiModel
