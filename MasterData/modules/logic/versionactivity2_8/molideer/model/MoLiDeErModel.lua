-- chunkname: @modules/logic/versionactivity2_8/molideer/model/MoLiDeErModel.lua

module("modules.logic.versionactivity2_8.molideer.model.MoLiDeErModel", package.seeall)

local MoLiDeErModel = class("MoLiDeErModel", BaseModel)

function MoLiDeErModel:onInit()
	self:init()
end

function MoLiDeErModel:reInit()
	self:init()
end

function MoLiDeErModel:init()
	self._curActId = VersionActivity2_8Enum.ActivityId.MoLiDeEr
	self._curEpisodeConfig = nil
	self._curEpisodeId = nil
	self._actInfoDic = {}
end

function MoLiDeErModel:onGetActInfo(msg)
	local actId = msg.activityId

	actId = VersionActivity2_8Enum.ActivityId.MoLiDeEr

	local episodeDic

	if not self._actInfoDic[actId] then
		episodeDic = {}
		self._actInfoDic[actId] = episodeDic
	else
		episodeDic = self._actInfoDic[actId]

		tabletool.clear(self._actInfoDic[actId])
	end

	local infos = msg.episodeRecords

	if not infos or #infos <= 0 then
		return
	end

	for _, info in ipairs(infos) do
		local mo

		if MoLiDeErConfig.instance:getEpisodeConfig(actId, info.episodeId) == nil then
			logError("episodeConfig not exist id: " .. info.episodeId)
		elseif episodeDic[info.episodeId] then
			logError("episodeId has exist id: " .. info.episodeId)
		else
			mo = MoLiDeErInfoMo.New()

			mo:init(actId, info.episodeId, info.isUnlock, info.passCount, info.passStar, info.haveProgress)

			episodeDic[info.episodeId] = mo
		end
	end
end

function MoLiDeErModel:onEpisodeRecordsPush(actId, infos)
	local episodeDic

	if not self._actInfoDic[actId] then
		episodeDic = {}
		self._actInfoDic[actId] = episodeDic
	else
		episodeDic = self._actInfoDic[actId]
	end

	if not infos or #infos <= 0 then
		return
	end

	for _, info in ipairs(infos) do
		local mo

		if MoLiDeErConfig.instance:getEpisodeConfig(actId, info.episodeId) == nil then
			logError("episodeConfig not exist id: " .. info.episodeId)
		else
			mo = episodeDic[info.episodeId] and episodeDic[info.episodeId] or MoLiDeErInfoMo.New()
		end

		mo:init(actId, info.episodeId, info.isUnlock, info.passCount, info.passStar, info.haveProgress)

		episodeDic[info.episodeId] = mo
	end
end

function MoLiDeErModel:isEpisodeFinish(actId, episodeId, isFirst)
	local episodeMo = self:getEpisodeInfoMo(actId, episodeId)

	if not episodeMo then
		return false
	end

	if isFirst then
		return episodeMo.passCount == 1
	end

	return episodeMo.passCount > 0
end

function MoLiDeErModel:haveEpisodeProgress(actId, episodeId)
	local episodeMo = self:getEpisodeInfoMo(actId, episodeId)

	if not episodeMo then
		return false
	end

	return episodeMo:isInProgress()
end

function MoLiDeErModel:getEpisodeInfoMo(actId, episodeId)
	if not self._actInfoDic[actId] then
		return nil
	end

	return self._actInfoDic[actId][episodeId]
end

function MoLiDeErModel:setCurEpisodeData(actId, episodeId, episodeConfig)
	self._curActId = actId
	self._curEpisodeId = episodeId

	if episodeConfig == nil then
		episodeConfig = MoLiDeErConfig.instance:getEpisodeConfig(actId, episodeId)
	end

	self._curEpisodeConfig = episodeConfig
end

function MoLiDeErModel:getCurEpisode()
	return self._curEpisodeConfig
end

function MoLiDeErModel:getCurEpisodeId()
	return self._curEpisodeId
end

function MoLiDeErModel:getCurActId()
	return self._curActId
end

function MoLiDeErModel:getCurEpisodeInfo()
	return self:getEpisodeInfoMo(self._curActId, self._curEpisodeId)
end

MoLiDeErModel.instance = MoLiDeErModel.New()

return MoLiDeErModel
