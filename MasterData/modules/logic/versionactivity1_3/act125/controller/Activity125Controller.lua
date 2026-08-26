-- chunkname: @modules/logic/versionactivity1_3/act125/controller/Activity125Controller.lua

module("modules.logic.versionactivity1_3.act125.controller.Activity125Controller", package.seeall)

local Activity125Controller = class("Activity125Controller", BaseController)

function Activity125Controller:getAct125InfoFromServer(actId, svrCallback, svrCallbackObj)
	actId = actId or ActivityEnum.Activity.VersionActivity1_3Radio

	if ActivityModel.instance:isActOnLine(actId) then
		local remainTime = ActivityModel.instance:getRemainTimeSec(actId)

		if remainTime and remainTime > 0 then
			Activity125Rpc.instance:sendGetAct125InfosRequest(actId, svrCallback, svrCallbackObj)
		end
	end
end

function Activity125Controller:onFinishActEpisode(actId, episodeId, targetFrequencyIndex)
	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(actId, episodeId, targetFrequencyIndex)
end

function Activity125Controller:isActFirstEnterToday(activityId)
	local key = string.format("%s#%s#", PlayerPrefsKey.FirstEnterAct125Today, activityId, PlayerModel.instance:getPlayinfo().userId)
	local str = TimeUtil.timestampToString1(ServerTime.now() - 18000)
	local cur_save = PlayerPrefsHelper.getString(key)

	return cur_save ~= str
end

function Activity125Controller:saveEnterActDateInfo(activityId)
	local key = string.format("%s#%s#", PlayerPrefsKey.FirstEnterAct125Today, activityId, PlayerModel.instance:getPlayinfo().userId)
	local str = TimeUtil.timestampToString1(ServerTime.now() - 18000)

	PlayerPrefsHelper.setString(key, str)
end

function Activity125Controller:checkActRed(activityId)
	local isFirstEnterToday = self:isActFirstEnterToday(activityId)
	local isAllEpisodeFinish = Activity125Model.instance:isAllEpisodeFinish(activityId)
	local hasEpisodeCanReceiveReward = Activity125Model.instance:isHasEpisodeCanReceiveReward(activityId)

	return not isAllEpisodeFinish and (isFirstEnterToday or hasEpisodeCanReceiveReward)
end

function Activity125Controller:checkActRed1(activityId)
	local hasEpisodeCanCheck = Activity125Model.instance:hasEpisodeCanCheck(activityId)
	local canGetReward = Activity125Model.instance:hasEpisodeCanGetReward(activityId)

	return hasEpisodeCanCheck or canGetReward
end

function Activity125Controller:checkActRed2(activityId)
	return (Activity125Model.instance:hasRedDot(activityId))
end

function Activity125Controller:sendGetTaskInfoRequest(callback, callbackObj)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity125
	}, callback, callbackObj)
end

function Activity125Controller:sendFinishAllTaskRequest(activityId, callback, callbackObj)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity125, nil, nil, callback, callbackObj, activityId)
end

local kV2a4_WarmUp_sum_help_npc = PlayerEnum.SimpleProperty.V2a4_WarmUp_sum_help_npc

function Activity125Controller:set_V2a4_WarmUp_sum_help_npc(value)
	value = value or 0

	local savedValue = tostring(value)

	PlayerModel.instance:forceSetSimpleProperty(kV2a4_WarmUp_sum_help_npc, savedValue)
	PlayerRpc.instance:sendSetSimplePropertyRequest(kV2a4_WarmUp_sum_help_npc, savedValue)
end

function Activity125Controller:get_V2a4_WarmUp_sum_help_npc(defaultValue)
	defaultValue = defaultValue or 0

	local result = PlayerModel.instance:getSimpleProperty(kV2a4_WarmUp_sum_help_npc)

	return tonumber(result) or defaultValue
end

function Activity125Controller:checkRed_Task()
	local reddotid = RedDotEnum.DotNode.Activity125Task

	return RedDotModel.instance:isDotShow(reddotid, 0)
end

function Activity125Controller:checkActRed3(activityId)
	if ActivityBeginnerController.instance:checkRedDot(activityId) then
		return true
	end

	if self:checkActRed2(activityId) then
		return true
	end

	return self:checkRed_Task()
end

Activity125Controller.instance = Activity125Controller.New()

return Activity125Controller
