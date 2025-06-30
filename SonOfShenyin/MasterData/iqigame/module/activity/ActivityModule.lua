-- chunkname: @IQIGame\\Module\\Activity\\ActivityModule.lua

ActivityModule = {
	ActivityPodList = {}
}

function ActivityModule.Reload(activityPods)
	for _, activityPOD in pairs(activityPods) do
		ActivityModule.ActivityPodList[activityPOD.cid] = activityPOD
	end

	ActivityModule.isInitialized = true
end

function ActivityModule.Shutdown()
	ActivityModule.isInitialized = false
	ActivityModule.ActivityPodList = {}
end

function ActivityModule.Update(activityPods)
	for _, activityPOD in pairs(activityPods) do
		ActivityModule.ActivityPodList[activityPOD.cid] = activityPOD

		if activityPOD.stage ~= 0 then
			EventDispatcher.Dispatch(EventID.ActivityOpenEvent, activityPOD.cid)
		else
			EventDispatcher.Dispatch(EventID.ActivityCloseEvent, activityPOD.cid)
		end
	end

	EventDispatcher.Dispatch(EventID.ActivityUpdateEvent)
end

function ActivityModule.GetActivityPodByID(activityId)
	if ActivityModule.FilterActivity(activityId) then
		return nil
	end

	local activityPod = ActivityModule.ActivityPodList[activityId]

	if activityPod ~= nil then
		return activityPod
	else
		return nil
	end
end

function ActivityModule.IsOpenByTime(activityId)
	if ActivityModule.FilterActivity(activityId) then
		return false
	end

	local activityPod = ActivityModule.GetActivityPodByID(activityId)

	if activityPod == nil then
		return false
	end

	if activityPod.stage ~= 0 then
		return true
	end

	return false
end

function ActivityModule.GetDupDropPODPod(activityId)
	local activityPod = ActivityModule.GetActivityPodByID(activityId)

	if activityPod ~= nil and activityPod.dupDropPOD ~= nil then
		return activityPod.dupDropPOD
	else
		logError("ActivityModule.GetActivityPodByID:  无法找到 activityId={0} dupDropPOD信息.", activityId)

		return nil
	end
end

function ActivityModule.GetActivityDesc(activityId)
	return CfgActivityTable[activityId].Desc
end

function ActivityModule.GetActivityPodByActivityTag(activityType, ActivityTag)
	for k, v in pairs(ActivityModule.ActivityPodList) do
		if v.stage ~= 0 and not ActivityModule.FilterActivity(v.cid) then
			local cfg = CfgActivityTable[v.cid]

			if cfg.ActivityType == activityType and cfg.ExtraParam[4] ~= nil and cfg.ExtraParam[4] == ActivityTag then
				return v
			end
		end
	end

	return nil
end

function ActivityModule.GetActivityPodByActivityType(activityTypes)
	local activityPods = {}

	if type(activityTypes) ~= "table" then
		logError("接收参数须为table")

		return activityPods
	end

	for k, v in pairs(ActivityModule.ActivityPodList) do
		if v.stage ~= 0 and not ActivityModule.FilterActivity(v.cid) then
			local cfg = CfgActivityTable[v.cid]

			if table.indexOf(activityTypes, cfg.ActivityType) ~= -1 then
				table.insert(activityPods, v)
			end
		end
	end

	return activityPods
end

function ActivityModule.GetActivityPodByActivityTypeHasAll(activityType)
	for k, v in pairs(ActivityModule.ActivityPodList) do
		if CfgActivityTable[v.cid].ActivityType == activityType and v.stage ~= 0 then
			return v
		end
	end

	for k, v in pairs(ActivityModule.ActivityPodList) do
		if CfgActivityTable[v.cid].ActivityType == activityType then
			return v
		end
	end
end

function ActivityModule.GetMultipleActivityIsOpenByActivityPod(activityPods)
	for i = 1, #activityPods do
		if activityPods[i].stage ~= 0 then
			return true
		end
	end

	return false
end

function ActivityModule.GetMultipleActivityIsOpen(activityIds)
	for i = 1, #activityIds do
		if ActivityModule.IsOpenByTime(activityIds[i]) then
			return true
		end
	end

	return false
end

function ActivityModule.GetActivityStageOpenTime(activityId, stage)
	local activityPod = ActivityModule.GetActivityPodByID(activityId)

	if not activityPod then
		return
	end

	local cfgActivity = CfgUtil.GetCfgActivityDataWithID(activityId)
	local len = #cfgActivity.Duration

	if len <= 0 then
		return
	end

	local time = activityPod.openDateTime

	for i = 1, stage do
		if cfgActivity.Duration[i] then
			time = time + cfgActivity.Duration[i] * 1000
		end
	end

	return time
end

function ActivityModule.GetActivityStageEndTime(activityId, stage)
	local activityCfg = CfgActivityTable[activityId]
	local endTime = cfgDateTimeToTimeStamp(activityCfg.OpenTime)

	for i = 1, stage do
		endTime = endTime + activityCfg.Duration[i]
	end

	return endTime
end

function ActivityModule.DEBUG_NoviceActivity_OpenUI()
	UIModule.Open(Constant.UIControllerName.NoviceActivityUI, Constant.UILayer.UI)
end

function ActivityModule.ReceiveSupply(activityId, index)
	net_activity.receiveSupply(activityId, index)
end

function ActivityModule.ReceiveSupplyResult(shows)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, shows)
end

function ActivityModule.OnRaffleResult(awardCid, shows)
	EventDispatcher.Dispatch(EventID.OnRaffleResult, awardCid, shows)
end

ActivityModule.filterActivityID = {}

function ActivityModule.FilterActivity(activityID)
	local isExist

	isExist = table.search(ActivityModule.filterActivityID, function(k, v)
		return v == activityID
	end)

	return isExist ~= nil
end

function ActivityModule.GetActivityRechargeRewards(activityCid, id)
	net_activityRecharge.getRewards(activityCid, id)
end

function ActivityModule.OnGetActivityRechargeRewardsResult(activityCid, id, rewards)
	EventDispatcher.Dispatch(EventID.OnActivityRechargeDataChange)
	UIModule.Open(Constant.UIControllerName.GetPanelUI, Constant.UILayer.UI, {
		items = rewards
	})
end
