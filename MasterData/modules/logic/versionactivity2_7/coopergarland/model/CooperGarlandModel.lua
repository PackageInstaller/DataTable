-- chunkname: @modules/logic/versionactivity2_7/coopergarland/model/CooperGarlandModel.lua

module("modules.logic.versionactivity2_7.coopergarland.model.CooperGarlandModel", package.seeall)

local CooperGarlandModel = class("CooperGarlandModel", BaseModel)

function CooperGarlandModel:onInit()
	self:clearData()
end

function CooperGarlandModel:reInit()
	self:clearData()
end

function CooperGarlandModel:clearData()
	self._actInfoDic = {}
	self._actNewestEpisodeDict = {}
end

function CooperGarlandModel:updateAct192Info(info)
	if not info then
		return
	end

	local actId = info.activityId
	local episodeList = info.episodes

	if episodeList then
		for _, episodeInfo in ipairs(episodeList) do
			self:updateAct192Episode(actId, episodeInfo.episodeId, episodeInfo.isFinished, episodeInfo.progress)
		end
	end

	self:updateNewestEpisode(actId)
end

function CooperGarlandModel:updateAct192Episode(actId, episodeId, isFinished, progress)
	if not actId or not episodeId then
		return
	end

	local episodeDic = self._actInfoDic[actId]

	if not episodeDic then
		episodeDic = {}
		self._actInfoDic[actId] = episodeDic
	end

	local episodeInfo = episodeDic[episodeId]

	if not episodeInfo then
		episodeInfo = {}
		episodeDic[episodeId] = episodeInfo
	end

	episodeInfo.isFinished = isFinished
	episodeInfo.progress = progress
end

function CooperGarlandModel:updateNewestEpisode(actId)
	local newestEpisodeId
	local episodeIdList = CooperGarlandConfig.instance:getEpisodeIdList(actId, true)

	for _, tmpEpisodeId in ipairs(episodeIdList) do
		local isUnlock = self:isUnlockEpisode(actId, tmpEpisodeId)
		local isFinished = self:isFinishedEpisode(actId, tmpEpisodeId)

		if isUnlock and not isFinished then
			newestEpisodeId = tmpEpisodeId
		end
	end

	self._actNewestEpisodeDict[actId] = newestEpisodeId
end

function CooperGarlandModel:getAct192Id()
	return VersionActivity2_7Enum.ActivityId.CooperGarland
end

function CooperGarlandModel:isAct192Open(isToast)
	local actId = self:getAct192Id()
	local status, toastId, toastParam
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if actInfoMo then
		status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)
	else
		toastId = ToastEnum.ActivityEnd
	end

	if isToast and toastId then
		GameFacade.showToast(toastId, toastParam)
	end

	return status == ActivityEnum.ActivityStatus.Normal
end

function CooperGarlandModel:getAct192RemainTimeStr(argsActId)
	local result = ""
	local isEnd = true
	local actId = argsActId or self:getAct192Id()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		if offsetSecond > 0 then
			result = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
			isEnd = false
		end
	end

	return result, isEnd
end

function CooperGarlandModel:getEpisodeInfo(actId, episodeId)
	local result

	if actId and episodeId and self._actInfoDic then
		local episodeDic = self._actInfoDic[actId]

		if episodeDic then
			result = episodeDic[episodeId]
		end
	end

	return result
end

function CooperGarlandModel:isUnlockEpisode(actId, episodeId)
	return self:getEpisodeInfo(actId, episodeId) ~= nil
end

function CooperGarlandModel:isFinishedEpisode(actId, episodeId)
	local episodeInfo = self:getEpisodeInfo(actId, episodeId)

	return episodeInfo and episodeInfo.isFinished
end

function CooperGarlandModel:getEpisodeProgress(actId, episodeId)
	local episodeInfo = self:getEpisodeInfo(actId, episodeId)
	local saveProgress = episodeInfo and episodeInfo.progress

	if string.nilorempty(saveProgress) then
		saveProgress = CooperGarlandEnum.Const.DefaultGameProgress
	end

	return tonumber(saveProgress)
end

function CooperGarlandModel:getNewestEpisodeId(actId)
	return self._actNewestEpisodeDict and self._actNewestEpisodeDict[actId]
end

function CooperGarlandModel:isNewestEpisode(actId, episodeId)
	local result = false

	if actId and episodeId then
		local newestEpisodeId = self:getNewestEpisodeId(actId)

		result = episodeId == newestEpisodeId
	end

	return result
end

CooperGarlandModel.instance = CooperGarlandModel.New()

return CooperGarlandModel
