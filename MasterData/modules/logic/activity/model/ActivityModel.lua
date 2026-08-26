-- chunkname: @modules/logic/activity/model/ActivityModel.lua

module("modules.logic.activity.model.ActivityModel", package.seeall)

local ActivityModel = class("ActivityModel", BaseModel)

function ActivityModel:onInit()
	self:reInit()
end

function ActivityModel:reInit()
	self._actInfo = {}
	self._finishActTab = {}
	self._actMoTab = {}
	self._isNoviceTaskUnlock = false
	self._targetActivityCategoryId = 0
end

function ActivityModel:setActivityInfo(info)
	self._actInfo = {}

	for _, v in ipairs(info.activityInfos) do
		local actCo = ActivityConfig.instance:getActivityCo(v.id)

		if actCo then
			local actMo = ActivityInfoMo.New()

			actMo:init(v)

			self._actInfo[v.id] = actMo
		end
	end
end

function ActivityModel:updateActivityInfo(info)
	local actMo = ActivityInfoMo.New()

	actMo:init(info)

	self._actInfo[info.id] = actMo
end

function ActivityModel:updateInfoNoRepleace(info)
	local actMo = self._actInfo[info.id]

	if not actMo then
		actMo = ActivityInfoMo.New()
		self._actInfo[info.id] = actMo
	end

	actMo:init(info)
end

function ActivityModel:endActivity(actId)
	if self._actInfo[actId] then
		self._actInfo[actId].online = false
	end
end

function ActivityModel:getActivityInfo()
	return self._actInfo
end

function ActivityModel:getActMO(actId)
	return self._actInfo[actId]
end

function ActivityModel:isActOnLine(actId)
	return self._actInfo[actId] and self._actInfo[actId].online
end

function ActivityModel:getOnlineActIdByType(actType)
	local result

	for actId, actInfo in pairs(self._actInfo) do
		if actInfo.actType == actType and actInfo.online then
			result = result or {}

			table.insert(result, actId)
		end
	end

	return result
end

function ActivityModel:getActStartTime(actId)
	return self._actInfo[actId].startTime
end

function ActivityModel:getActEndTime(actId)
	return self._actInfo[actId].endTime
end

function ActivityModel:hasActivityUnlock(centerId)
	for _, v in pairs(self._actInfo) do
		if v.online then
			return true
		end
	end

	return false
end

function ActivityModel:getTargetActivityCategoryId(centerId)
	if not next(self._actInfo) then
		self._targetActivityCategoryId = 0

		return 0
	end

	for _, v in pairs(self._actInfo) do
		if v.id == self._targetActivityCategoryId and v.centerId == centerId and v.online then
			return self._targetActivityCategoryId
		end
	end

	local centerIds = {}

	for _, v in pairs(self._actInfo) do
		if v.centerId == centerId and v.online then
			table.insert(centerIds, v.id)

			self._actMoTab[v.id] = v
		end
	end

	centerIds = self:removeUnExitAct(centerIds)

	table.sort(centerIds, function(a, b)
		local aPri = ActivityConfig.instance:getActivityCo(a).displayPriority
		local bPri = ActivityConfig.instance:getActivityCo(b).displayPriority

		return aPri < bPri
	end)

	if #centerIds > 0 then
		self._targetActivityCategoryId = centerIds[1] or 0
	end

	return self._targetActivityCategoryId
end

function ActivityModel:setTargetActivityCategoryId(id)
	self._targetActivityCategoryId = id
end

function ActivityModel:getCurTargetActivityCategoryId()
	return self._targetActivityCategoryId
end

function ActivityModel:addFinishActivity(finishActId)
	self._finishActTab[finishActId] = finishActId
end

function ActivityModel:removeUnExitAct(actIds)
	if GameUtil.getTabLen(actIds) == 0 then
		return
	end

	for k, v in pairs(self._finishActTab) do
		tabletool.removeValue(actIds, v)
	end

	return actIds
end

function ActivityModel:getActivityCenter()
	local centers = {}

	for _, v in pairs(self._actInfo) do
		if v.centerId ~= 0 and v.online then
			centers[v.centerId] = centers[v.centerId] or {}

			table.insert(centers[v.centerId], v.id)
		end
	end

	return centers
end

function ActivityModel:getCenterActivities(centerId)
	local acts = {}

	for _, v in pairs(self._actInfo) do
		if v.centerId == centerId and v.online then
			table.insert(acts, v.id)
		end
	end

	return acts
end

function ActivityModel:hasNorSignRewardUnReceived()
	local infos = ActivityType101Model.instance:getType101Info(ActivityEnum.Activity.NorSign)

	if infos then
		for _, v in pairs(infos) do
			if v.state == 1 then
				return true
			end
		end
	end

	return false
end

function ActivityModel:hasNoviceSignRewardUnReceived()
	local infos = ActivityType101Model.instance:getType101Info(ActivityEnum.Activity.NoviceSign)

	if infos then
		for _, v in pairs(infos) do
			if v.state == 1 then
				return true
			end
		end
	end

	return false
end

function ActivityModel:getRemainTime(actId)
	local actMO = self:getActMO(actId)

	if actMO then
		local remainTimeSec = actMO.endTime / 1000 - ServerTime.now()
		local day = Mathf.Floor(remainTimeSec / TimeUtil.OneDaySecond)
		local hourSecond = remainTimeSec % TimeUtil.OneDaySecond
		local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
		local minuteSecond = hourSecond % TimeUtil.OneHourSecond
		local minute = Mathf.Ceil(minuteSecond / TimeUtil.OneMinuteSecond)

		return day, hour, minute
	end
end

function ActivityModel:removeFinishedCategory(actCo)
	for index, id in pairs(actCo) do
		if id == ActivityEnum.Activity.DreamShow then
			local taskMos = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.ActivityShow)

			if taskMos and next(taskMos) then
				local taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, ActivityEnum.Activity.DreamShow)

				if taskMoList and taskMoList[1].finishCount >= taskMoList[1].config.maxFinishCount then
					actCo[index] = nil

					self:addFinishActivity(id)
				end
			end
		elseif id == ActivityEnum.Activity.V2a7_SelfSelectSix1 then
			if ActivityType101Model.instance:isType101RewardGet(id, 1) then
				actCo[index] = nil

				self:addFinishActivity(id)
			end
		elseif id == ActivityEnum.Activity.V3a3_SkinDiscount then
			if not StoreModel.instance:isSkinDiscountNotSoldOut() then
				actCo[index] = nil

				self:addFinishActivity(id)
			end
		elseif id == ActivityEnum.Activity.V3a4_DestinyGift then
			if ActivityType101Model.instance:isType101RewardGet(id, 1) then
				local config = ActivityConfig.instance:getActivityCo(id)
				local param = string.splitToNumber(config.param, "#")
				local storeGoodsMo = StoreModel.instance:getGoodsMO(param[1])

				if storeGoodsMo and storeGoodsMo:isSoldOut() then
					local poolInfo = SummonMainModel.instance:getPoolServerMO(param[2])

					if poolInfo and poolInfo.infallibleItemStatus == SummonEnum.InfallibleItemState.Used then
						actCo[index] = nil

						self:addFinishActivity(id)
					end
				end
			end
		elseif ActivityEnum.CheckFinishActDic[id] then
			local functionName = string.format("CheckActivity%sFinish", id)
			local checkFunc = ActivityFinishHelper[functionName]

			if not checkFunc then
				logError("没有找到对应的活动隐藏检测函数 actId:" .. tostring(id))
			elseif checkFunc(id) then
				actCo[index] = nil

				self:addFinishActivity(id)
			end
		end
	end
end

function ActivityModel:removeFinishedWelfare(actCo)
	local storyShowFinish = false
	local noviceSignFinish = ActivityType101Model.instance:hasReceiveAllReward(ActivityEnum.Activity.NoviceSign)
	local classShowFinish = TeachNoteModel.instance:isFinalRewardGet()
	local newWelfareFinish = Activity160Model.instance:allRewardReceive(ActivityEnum.Activity.NewWelfare)

	for index, id in pairs(actCo) do
		if id == ActivityEnum.Activity.StoryShow and TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Novice) then
			storyShowFinish = true
			actCo[index] = nil

			self:addFinishActivity(id)
		end

		if id == ActivityEnum.Activity.ClassShow and classShowFinish then
			actCo[index] = nil

			self:addFinishActivity(id)
		end

		if id == ActivityEnum.Activity.NoviceSign and noviceSignFinish then
			actCo[index] = nil

			self:addFinishActivity(id)
		end

		if id == ActivityEnum.Activity.NewWelfare and newWelfareFinish then
			actCo[index] = nil

			self:addFinishActivity(ActivityEnum.Activity.NewWelfare)
		end
	end
end

function ActivityModel:removeSelectSixAfterRemoveFinished(actCo)
	for index, id in pairs(actCo) do
		if (id == ActivityEnum.Activity.V2a7_SelfSelectSix2 or id == ActivityEnum.Activity.V3a8_SelfSelectSix) and ActivityType101Model.instance:isType101RewardGet(id, 1) then
			actCo[index] = nil
		end
	end
end

function ActivityModel:getRemainTimeSec(actId)
	local actMO = self:getActMO(actId)

	if actMO then
		return actMO.endTime / 1000 - ServerTime.now()
	end
end

function ActivityModel:setPermanentUnlock(actId)
	local actMO = self:getActMO(actId)

	if actMO then
		actMO:setPermanentUnlock()
	end
end

function ActivityModel:isReceiveAllBonus(actId)
	local actMO = self:getActMO(actId)

	if actMO then
		return actMO.isReceiveAllBonus
	end

	return false
end

function ActivityModel.checkIsShowLogoVisible()
	local config = ActivityConfig.instance:getMainActAtmosphereConfig()

	if not config then
		return false
	end

	return config.isShowLogo or false
end

function ActivityModel.checkIsShowActBgVisible()
	local config = ActivityConfig.instance:getMainActAtmosphereConfig()

	if not config then
		return false
	end

	return config.isShowActBg or false
end

function ActivityModel.checkIsShowFxVisible()
	local config = ActivityConfig.instance:getMainActAtmosphereConfig()

	if not config then
		return false
	end

	return config.isShowFx or false
end

function ActivityModel.showActivityEffect()
	local isOpenFastDungeonBtn = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FastDungeon)

	if not isOpenFastDungeonBtn then
		return false
	end

	if not DungeonModel.instance:hasPassLevelAndStory(ActivityEnum.ShowVersionActivityEpisode) then
		return false
	end

	local activityId = CommonConfig.instance:getConstNum(ConstEnum.MainActAtmosphereActId)
	local status = ActivityHelper.getActivityStatus(activityId, true)

	if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock then
		return true
	end

	return false
end

function ActivityModel:tryGetFirstOpenedActCOByTypeId(typeId)
	local COList = ActivityConfig.instance:typeId2ActivityCOList(typeId)

	for _, CO in ipairs(COList) do
		local actId = CO.id

		if ActivityHelper.getActivityStatus(actId, true) == ActivityEnum.ActivityStatus.Normal then
			return CO
		end
	end
end

function ActivityModel.getRemainTimeStr(actId)
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(actId) or 0

	if remainTimeSec <= 0 then
		return luaLang("turnback_end")
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(remainTimeSec)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			min
		})
	elseif sec > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

ActivityModel.instance = ActivityModel.New()

return ActivityModel
