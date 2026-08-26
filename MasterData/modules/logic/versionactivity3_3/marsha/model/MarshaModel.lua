-- chunkname: @modules/logic/versionactivity3_3/marsha/model/MarshaModel.lua

module("modules.logic.versionactivity3_3.marsha.model.MarshaModel", package.seeall)

local MarshaModel = class("MarshaModel", BaseModel)

function MarshaModel:onInit()
	self:reInit()
end

function MarshaModel:reInit()
	self._episodeInfos = {}
	self._curEpisodeIndex = 0
	self._curEpisodeId = 0
	self._actId = VersionActivity3_3Enum.ActivityId.Marsha
end

function MarshaModel:initInfos(infos)
	self._episodeInfos = {}

	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = MarshaEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function MarshaModel:updateInfos(infos)
	for _, info in ipairs(infos) do
		if not self._episodeInfos[info.episodeId] then
			self._episodeInfos[info.episodeId] = MarshaEpisodeMo.New()

			self._episodeInfos[info.episodeId]:init(info)
		else
			self._episodeInfos[info.episodeId]:update(info)
		end
	end
end

function MarshaModel:updateInfoFinish(episodeId)
	local mo = self._episodeInfos[episodeId]

	if mo then
		mo.isFinished = true
	end
end

function MarshaModel:setCurEpisode(episodeId)
	if self._curEpisodeId == episodeId then
		return
	end

	self._curEpisodeIndex = self:getEpisodeIndex(episodeId)
	self._curEpisodeId = episodeId and episodeId or self._curEpisodeId

	local episodeCo = Activity220Config.instance:getEpisodeConfig(self._actId, episodeId)

	if episodeCo and episodeCo.gameId ~= 0 then
		self.gameCo = MarshaConfig.instance:getGameConfig(episodeCo.gameId)
	end
end

function MarshaModel:getEpisodeIndex(episodeId)
	local colist = Activity220Config.instance:getEpisodeConfigList(self._actId)

	for index, co in ipairs(colist) do
		if co.episodeId == episodeId then
			return index
		end
	end
end

function MarshaModel:getCurActId()
	return self._actId
end

function MarshaModel:getCurEpisode()
	return self._curEpisodeId
end

function MarshaModel:isEpisodeUnlock(episodeId)
	return self._episodeInfos[episodeId]
end

function MarshaModel:isEpisodePass(episodeId)
	if not self._episodeInfos[episodeId] then
		return false
	end

	return self._episodeInfos[episodeId].isFinished
end

function MarshaModel:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function MarshaModel:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function MarshaModel:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function MarshaModel:getMaxUnlockEpisodeId()
	local episodeCos = Activity220Config.instance:getEpisodeConfigList(self._actId)
	local maxEpisodeId = 0

	for _, episodeCo in pairs(episodeCos) do
		local isUnlock = self:isEpisodeUnlock(episodeCo.episodeId)

		maxEpisodeId = isUnlock and math.max(maxEpisodeId, episodeCo.episodeId) or maxEpisodeId
	end

	return maxEpisodeId
end

function MarshaModel:getGameConfig()
	return self.gameCo
end

function MarshaModel:getCurGameMaxDespair()
	if self.gameCo then
		return self.gameCo.maxBuff
	end
end

MarshaModel.instance = MarshaModel.New()

return MarshaModel
