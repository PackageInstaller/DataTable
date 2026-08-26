-- chunkname: @modules/logic/versionactivity1_3/act125/view/Activity125ViewBaseContainer.lua

module("modules.logic.versionactivity1_3.act125.view.Activity125ViewBaseContainer", package.seeall)

local Activity125ViewBaseContainer = class("Activity125ViewBaseContainer", BaseViewContainer)
local kPrefix = "Activity125|"

function Activity125ViewBaseContainer:getPrefsKeyPrefix()
	return kPrefix .. tostring(self:actId())
end

function Activity125ViewBaseContainer:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function Activity125ViewBaseContainer:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

function Activity125ViewBaseContainer:getActivityRemainTimeStr()
	return ActivityHelper.getActivityRemainTimeStr(self:actId())
end

function Activity125ViewBaseContainer:getEpisodeCount()
	return Activity125Config.instance:getEpisodeCount(self:actId())
end

function Activity125ViewBaseContainer:getH5BaseUrl()
	return Activity125Config.instance:getH5BaseUrl(self:actId())
end

function Activity125ViewBaseContainer:getEpisodeConfig(episodeId)
	return Activity125Config.instance:getEpisodeConfig(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:getFirstEpisodeId()
	local COs = Activity125Config.instance:getAct125Config(self:actId())

	if not COs then
		return nil
	end

	local key, CO = next(COs)

	if not key then
		return nil
	end

	return CO.id
end

function Activity125ViewBaseContainer:setCurSelectEpisodeIdSlient(episodeId)
	if self:getCurSelectedEpisode() == episodeId then
		return
	end

	self:setSelectEpisodeId(episodeId)

	if episodeId then
		self:setOldEpisode(episodeId)
	end
end

function Activity125ViewBaseContainer:sendFinishAct125EpisodeRequest(episodeId)
	local CO

	if not episodeId then
		CO = self:getEpisodeConfigCur()
		episodeId = CO.id
	end

	CO = CO or self:getEpisodeConfig(episodeId)

	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(self:actId(), episodeId, CO.targetFrequency)
end

function Activity125ViewBaseContainer:getCurSelectedEpisode()
	return Activity125Model.instance:getSelectEpisodeId(self:actId())
end

function Activity125ViewBaseContainer:setSelectEpisodeId(episodeId)
	return Activity125Model.instance:setSelectEpisodeId(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:isEpisodeFinished(episodeId)
	return Activity125Model.instance:isEpisodeFinished(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:checkIsOldEpisode(episodeId)
	return Activity125Model.instance:checkIsOldEpisode(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:isFirstCheckEpisode(episodeId)
	return Activity125Model.instance:isFirstCheckEpisode(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:isEpisodeDayOpen(episodeId)
	return Activity125Model.instance:isEpisodeDayOpen(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:isEpisodeUnLock(episodeId)
	return Activity125Model.instance:isEpisodeUnLock(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:setLocalIsPlay(episodeId)
	return Activity125Model.instance:setLocalIsPlay(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:checkLocalIsPlay(episodeId)
	return Activity125Model.instance:checkLocalIsPlay(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:isEpisodeReallyOpen(episodeId)
	return Activity125Model.instance:isEpisodeReallyOpen(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:setOldEpisode(episodeId)
	return Activity125Model.instance:setOldEpisode(self:actId(), episodeId)
end

function Activity125ViewBaseContainer:getActivity125MO()
	return Activity125Model.instance:getById(self:actId())
end

function Activity125ViewBaseContainer:getFirstRewardEpisode()
	local mo = self:getActivity125MO()

	return mo:getFirstRewardEpisode()
end

function Activity125ViewBaseContainer:getLatestEpisode()
	local mo = self:getActivity125MO()

	return mo:getLatestEpisode()
end

function Activity125ViewBaseContainer:getRLOC(episodeId)
	local mo = self:getActivity125MO()

	return mo:getRLOC(episodeId)
end

function Activity125ViewBaseContainer:getPreTaskInfo(episodeId, ...)
	local mo = self:getActivity125MO()

	return mo:getPreTaskInfo(episodeId, ...)
end

function Activity125ViewBaseContainer:checkPassedPreTask(episodeId, ...)
	local mo = self:getActivity125MO()

	return mo:checkPassedPreTask(episodeId, ...)
end

function Activity125ViewBaseContainer:isActivityOpen()
	return Activity125Model.instance:isActivityOpen(self:actId())
end

function Activity125ViewBaseContainer:hasEpisodeCanCheck()
	return Activity125Model.instance:hasEpisodeCanCheck(self:actId())
end

function Activity125ViewBaseContainer:getEpisodeList()
	local mo = self:getActivity125MO()

	return mo:getEpisodeList() or {}
end

function Activity125ViewBaseContainer:isAllEpisodeFinish()
	local mo = self:getActivity125MO()

	return mo:isAllEpisodeFinish()
end

function Activity125ViewBaseContainer:getEpisodeConfigCur()
	return self:getEpisodeConfig(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:isEpisodeFinishedCur()
	return self:isEpisodeFinished(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:checkIsOldEpisodeCur()
	return self:checkIsOldEpisode(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:isFirstCheckEpisodeCur()
	return self:isFirstCheckEpisode(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:isEpisodeDayOpenCur()
	return self:isEpisodeDayOpen(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:isEpisodeUnLockCur()
	return self:isEpisodeUnLock(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:setLocalIsPlayCur()
	return self:setLocalIsPlay(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:checkLocalIsPlayCur()
	return self:checkLocalIsPlay(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:getLocalIsPlayCur()
	return self:checkLocalIsPlayCur()
end

function Activity125ViewBaseContainer:isEpisodeReallyOpenCur()
	return self:isEpisodeReallyOpen(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:getRLOCCur()
	return self:getRLOC(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:setOldEpisodeCur()
	return self:setOldEpisode(self:getCurSelectedEpisode())
end

function Activity125ViewBaseContainer:getBonusListCur()
	local CO = self:getEpisodeConfigCur()

	return GameUtil.splitString2(CO.bonus, true) or {}
end

function Activity125ViewBaseContainer:sendGetTaskInfoRequest(callback, callbackObj)
	Activity125Controller.instance:sendGetTaskInfoRequest(callback, callbackObj)
end

function Activity125ViewBaseContainer:sendFinishAllTaskRequest(callback, callbackObj)
	Activity125Controller.instance:sendFinishAllTaskRequest(self:actId(), callback, callbackObj)
end

function Activity125ViewBaseContainer:sendFinishTaskRequest(taskId, callback, callbackObj)
	TaskRpc.instance:sendFinishTaskRequest(taskId, callback, callbackObj)
end

function Activity125ViewBaseContainer:getTaskCO_sum_help_npc(taskId)
	return Activity125Config.instance:getTaskCO_ReadTask_Tag_TaskId(self:actId(), ActivityWarmUpEnum.Activity125TaskTag.sum_help_npc, taskId)
end

function Activity125ViewBaseContainer:getTaskCO_help_npc(taskId)
	return Activity125Config.instance:getTaskCO_ReadTask_Tag_TaskId(self:actId(), ActivityWarmUpEnum.Activity125TaskTag.help_npc, taskId)
end

function Activity125ViewBaseContainer:getTaskCO_perfect_win(taskId)
	return Activity125Config.instance:getTaskCO_ReadTask_Tag_TaskId(self:actId(), ActivityWarmUpEnum.Activity125TaskTag.perfect_win, taskId)
end

function Activity125ViewBaseContainer:isTimeToActiveH5Btn()
	local openTs = CommonConfig.instance:getConstStr(ConstEnum.V2a4_WarmUp_btnplay_openTs)

	if string.nilorempty(openTs) then
		return true
	end

	openTs = SettingsModel.instance:extractByRegion(openTs)

	return ServerTime.now() >= TimeUtil.stringToTimestamp(openTs)
end

function Activity125ViewBaseContainer:openWebView(onWebViewCb, onWebViewCbObj)
	local baseUrl = self:getH5BaseUrl()

	WebViewController.instance:simpleOpenWebView(baseUrl, onWebViewCb, onWebViewCbObj)
end

function Activity125ViewBaseContainer:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:actId())
end

function Activity125ViewBaseContainer:ActivityInfoMo()
	return ActivityModel.instance:getActMO(self:actId())
end

function Activity125ViewBaseContainer:actId()
	assert(false, "please override this function")
end

return Activity125ViewBaseContainer
