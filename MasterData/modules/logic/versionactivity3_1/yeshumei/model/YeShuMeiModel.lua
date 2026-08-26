-- chunkname: @modules/logic/versionactivity3_1/yeshumei/model/YeShuMeiModel.lua

module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiModel", package.seeall)

local YeShuMeiModel = class("YeShuMeiModel", BaseModel)

function YeShuMeiModel:onInit()
	self:reInit()
end

function YeShuMeiModel:reInit()
	self._episodeInfos = {}
	self._curEpisodeIndex = 0
	self._curEpisode = 0
	self._actId = VersionActivity3_1Enum.ActivityId.YeShuMei
end

function YeShuMeiModel:initInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = YeShuMeiEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function YeShuMeiModel:updateEpisodeInfo(info)
	self._episodeInfos[info.episodeId]:update(info)
end

function YeShuMeiModel:updateInfos(infos)
	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = YeShuMeiEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function YeShuMeiModel:updateInfoFinish(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		mo.isFinished = true
	end
end

function YeShuMeiModel:updateInfoFinishGame(msg)
	local mo = self._episodeInfos[msg.episodeId]

	if mo then
		mo.progress = msg.progress
	end
end

function YeShuMeiModel:checkEpisodeFinishGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:checkFinishGame()
	end

	return false
end

function YeShuMeiModel:getCurGameProgress(episodeId)
	return self._episodeInfos[episodeId].progress
end

function YeShuMeiModel:getEpisodeUnlockBranchIdList(episodeId)
	return self._episodeInfos[episodeId].unlockBranchIds
end

function YeShuMeiModel:setCurEpisode(index, episodeId)
	self._curEpisodeIndex = index
	self._curEpisode = episodeId and episodeId or self._curEpisode
end

function YeShuMeiModel:getEpisodeIndex(episodeId)
	local colist = YeShuMeiConfig.instance:getEpisodeCoList(self._actId)

	for index, co in ipairs(colist) do
		if co.episodeId == episodeId then
			return index
		end
	end
end

function YeShuMeiModel:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function YeShuMeiModel:getCurEpisode()
	return self._curEpisode
end

function YeShuMeiModel:isEpisodeUnlock(episodeId)
	return self._episodeInfos[episodeId]
end

function YeShuMeiModel:isEpisodePass(episodeId)
	if not self._episodeInfos[episodeId] then
		return false
	end

	return self._episodeInfos[episodeId].isFinished
end

function YeShuMeiModel:checkEpisodeIsGame(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		return mo:isGame()
	end

	return true
end

function YeShuMeiModel:isAllEpisodeFinish()
	for _, info in pairs(self._episodeInfos) do
		if not info.isFinished then
			return false
		end
	end

	return true
end

function YeShuMeiModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function YeShuMeiModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function YeShuMeiModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function YeShuMeiModel:getMaxUnlockEpisodeId()
	local episodeCos = YeShuMeiConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		local isUnlock = self:isEpisodeUnlock(episodeCo.episodeId)

		maxEpisodeId = isUnlock and math.max(maxEpisodeId, episodeCo.episodeId) or maxEpisodeId
	end

	return maxEpisodeId
end

function YeShuMeiModel:getMaxEpisodeId()
	local episodeCos = YeShuMeiConfig.instance:getEpisodeCoList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		maxEpisodeId = math.max(maxEpisodeId, episodeCo.episodeId)
	end

	return maxEpisodeId
end

YeShuMeiModel.instance = YeShuMeiModel.New()

return YeShuMeiModel
