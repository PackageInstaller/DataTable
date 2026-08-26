-- chunkname: @modules/logic/activity/view/ActivityMainBtnItem.lua

module("modules.logic.activity.view.ActivityMainBtnItem", package.seeall)

local ActivityMainBtnItem = class("ActivityMainBtnItem", ActCenterItemBase)

function ActivityMainBtnItem:init(id, go)
	self._centerId = id
	self._centerCo = ActivityConfig.instance:getActivityCenterCo(id)

	ActivityMainBtnItem.super.init(self, gohelper.cloneInPlace(go))
end

function ActivityMainBtnItem:onInit(go)
	self:_initReddotitem()
	self:_refreshItem()
end

function ActivityMainBtnItem:onClick()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Activity) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Activity))

		return
	end

	if self._centerId == ActivityEnum.ActivityType.Normal then
		ActivityController.instance:openActivityNormalView()
	elseif self._centerId == ActivityEnum.ActivityType.Beginner then
		ActivityRpc.instance:sendGetActivityInfosRequest(self.openActivityBeginnerView, self)
	elseif self._centerId == ActivityEnum.ActivityType.Welfare then
		ActivityController.instance:openActivityWelfareView()
	end
end

function ActivityMainBtnItem:openActivityBeginnerView()
	ActivityController.instance:openActivityBeginnerView()
end

function ActivityMainBtnItem:_refreshItem()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, self._centerCo.icon)

	UISpriteSetMgr.instance:setMainSprite(self._imgitem, spriteName, true)
	self:setFestival(isShow)
	self._redDot:refreshDot()
end

function ActivityMainBtnItem:_showRedDotType(redDotIcon, actId)
	redDotIcon.show = true

	local actCo = ActivityConfig.instance:getActivityCo(actId)
	local actRedDotId = actCo.redDotId
	local type = actRedDotId ~= 0 and RedDotConfig.instance:getRedDotCO(actRedDotId).style or RedDotEnum.Style.Normal

	redDotIcon:showRedDot(type)
end

function ActivityMainBtnItem:getActivityShowRedDotData(actId)
	local key = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return (PlayerPrefsHelper.getString(key, ""))
end

function ActivityMainBtnItem:getSortPriority()
	return self._centerCo.sortPriority
end

function ActivityMainBtnItem:isShowRedDot()
	return self._redDot.show
end

function ActivityMainBtnItem:_initReddotitem()
	local go = self.go

	do
		local rGo = gohelper.findChild(go, "go_activityreddot")
		local dotId = tonumber(RedDotConfig.instance:getRedDotCO(self._centerCo.reddotid).parent)

		if self._centerCo.id == ActivityEnum.ActivityType.Welfare then
			self._redDot = RedDotController.instance:addRedDot(rGo, dotId, false, self._onRefreshDot_Welfare, self)
		elseif self._centerCo.id == ActivityEnum.ActivityType.Beginner then
			self._redDot = RedDotController.instance:addRedDot(rGo, dotId, false, self._onRefreshDot_ActivityBeginner, self)

			self:_checkShowBeginnerReddot(dotId)
		else
			self._redDot = RedDotController.instance:addRedDot(rGo, dotId, false, self._onRefreshDot_ActivityBeginner, self)
		end

		return
	end

	local redGos = gohelper.findChild(go, "go_activityreddot/#go_special_reds")
	local t = redGos.transform
	local n = t.childCount

	for i = 1, n do
		local child = t:GetChild(i - 1)

		gohelper.setActive(child.gameObject, false)
	end

	local redGo
	local dotId = tonumber(RedDotConfig.instance:getRedDotCO(self._centerCo.reddotid).parent)

	if self._centerCo.id == ActivityEnum.ActivityType.Welfare then
		redGo = gohelper.findChild(redGos, "#go_welfare_red")
		self._redDot = RedDotController.instance:addRedDotTag(redGo, dotId, false, self._onRefreshDot_Welfare, self)
	else
		redGo = gohelper.findChild(redGos, "#go_activity_beginner_red")
		self._redDot = RedDotController.instance:addRedDotTag(redGo, dotId, false, self._onRefreshDot_ActivityBeginner, self)
	end

	self._btnitem2 = gohelper.getClick(redGo)
end

function ActivityMainBtnItem:_onRefreshDot_Welfare(commonRedObj)
	self._curActId = nil

	if commonRedObj.dotId then
		local ok, errmsg = pcall(self._checkRed_Welfare or self._checkActivityWelfareRedDot, self, commonRedObj)

		if not ok then
			logError(string.format("ActivityMainBtnItem:_checkRed_Welfare actId:%s error:%s", self._curActId, errmsg))
		end
	end
end

function ActivityMainBtnItem:_onRefreshDot_ActivityBeginner(commonRedObj)
	self._curActId = nil

	if commonRedObj.dotId then
		local ok, errmsg = pcall(self._checkRed_ActivityBeginner or self._checkActivityShowRedDotData, self, commonRedObj)

		if not ok then
			logError(string.format("ActivityMainBtnItem:_checkRed_ActivityBeginner actId:%s error:%s", self._curActId, errmsg))
		end

		self:_checkShowBeginnerReddot(commonRedObj.dotId)
	end
end

function ActivityMainBtnItem:_checkShowBeginnerReddot(dotId)
	if not dotId then
		return
	end

	local rGo = gohelper.findChild(self.go, "go_activityreddot")

	gohelper.setActive(rGo, false)

	local dotChildIds = RedDotModel.instance:getDotChilds(dotId)

	for _, childDotId in pairs(dotChildIds) do
		local childDotInfo = RedDotModel.instance:getRedDotInfo(childDotId)

		if childDotInfo and childDotInfo.infos then
			for _, dotInfo in pairs(childDotInfo.infos) do
				if dotInfo.value > 0 and not self:_isBeginnerIgnoreReddotActivity(dotInfo.uid) then
					gohelper.setActive(rGo, true)

					return
				end
			end
		else
			logWarn(string.format("not found red dot mo, dotId = %s, parentDotId = %s", childDotId, dotId))
		end
	end
end

local ignoreActivities = {
	ActivityEnum.Activity.V2a9_FreeMonthCard
}

function ActivityMainBtnItem:_isBeginnerIgnoreReddotActivity(activityId)
	for _, actId in pairs(ignoreActivities) do
		if actId == tonumber(activityId) then
			return true
		end
	end

	return false
end

function ActivityMainBtnItem:_checkRed_ActivityBeginner(commonRedDotTag)
	local isShow = self:_checkIsShowRed_ActivityBeginner(commonRedDotTag.dotId, 0)

	commonRedDotTag.show = isShow

	gohelper.setActive(commonRedDotTag.go, isShow)
	gohelper.setActive(self._imgGo, not isShow)
end

function ActivityMainBtnItem:_checkRed_Welfare(commonRedDotTag)
	local isShow = self:_checkIsShowRed_Welfare(commonRedDotTag.dotId, 0)

	commonRedDotTag.show = isShow

	gohelper.setActive(commonRedDotTag.go, isShow)
	gohelper.setActive(self._imgGo, not isShow)
end

function ActivityMainBtnItem:_checkIsShowRed_Welfare(id, uid)
	if RedDotModel.instance:isDotShow(id, uid or 0) then
		return true
	end

	local actIds = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)

	for _, actId in pairs(actIds) do
		self._curActId = actId

		if actId == ActivityEnum.Activity.StoryShow and not TaskModel.instance:isFinishAllNoviceTask() and string.nilorempty(self:getActivityShowRedDotData(actId)) then
			return true
		end

		if actId == ActivityEnum.Activity.ClassShow and not TeachNoteModel.instance:isFinalRewardGet() and string.nilorempty(self:getActivityShowRedDotData(actId)) then
			return true
		end
	end

	return false
end

function ActivityMainBtnItem:_checkIsShowRed_ActivityBeginner(id, uid)
	if RedDotModel.instance:isDotShow(id, uid or 0) then
		return true
	end

	local actIds = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)

	for _, actId in pairs(actIds) do
		self._curActId = actId

		local ActivityCo = ActivityConfig.instance:getActivityCo(actId)
		local typeId = ActivityCo.typeId

		if actId == DoubleDropModel.instance:getActId() and string.nilorempty(self:getActivityShowRedDotData(actId)) then
			return true
		end

		if actId == ActivityEnum.Activity.DreamShow then
			local taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, ActivityEnum.Activity.DreamShow)
			local firstMo = taskMoList and taskMoList[1]

			if firstMo and firstMo.config and firstMo.finishCount < firstMo.config.maxFinishCount and string.nilorempty(self:getActivityShowRedDotData(actId)) then
				return true
			end
		end

		if actId == ActivityEnum.Activity.Activity1_7WarmUp and Activity125Controller.instance:checkActRed(actId) then
			return true
		end

		if actId == ActivityEnum.Activity.Activity1_8WarmUp and Activity125Controller.instance:checkActRed1(actId) then
			return true
		end

		if actId == ActivityEnum.Activity.Activity1_5WarmUp and Activity146Controller.instance:isActFirstEnterToday() and (not Activity146Model.instance:isAllEpisodeFinish() or Activity146Model.instance:isHasEpisodeCanReceiveReward()) then
			return true
		end

		if actId == ActivityEnum.Activity.V2a2_TurnBack_H5 and ActivityBeginnerController.instance:checkFirstEnter(actId) then
			return true
		end

		if actId == VersionActivity2_2Enum.ActivityId.LimitDecorate and ActivityBeginnerController.instance:checkFirstEnter(actId) then
			return true
		end

		if typeId == ActivityEnum.ActivityTypeID.Act125 and Activity125Controller.instance:checkActRed2(actId) then
			return true
		end

		if typeId == ActivityEnum.ActivityTypeID.Act201 and ActivityBeginnerController.instance:checkFirstEnter(actId) then
			return true
		end
	end

	return false
end

function ActivityMainBtnItem:_checkActivityShowRedDotData(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		local actIds = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)

		for k, actId in pairs(actIds) do
			local ActivityCo = ActivityConfig.instance:getActivityCo(actId)
			local typeId = ActivityCo.typeId

			self._curActId = actId

			if actId == DoubleDropModel.instance:getActId() and string.nilorempty(self:getActivityShowRedDotData(actId)) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end

			if actId == ActivityEnum.Activity.DreamShow then
				local taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, ActivityEnum.Activity.DreamShow)
				local firstMo = taskMoList and taskMoList[1]

				if firstMo and firstMo.config and firstMo.finishCount < firstMo.config.maxFinishCount and string.nilorempty(self:getActivityShowRedDotData(actId)) then
					self:_showRedDotType(redDotIcon, actId)

					return
				end
			end

			if actId == ActivityEnum.Activity.WeekWalkDeepShow then
				if ActivityModel.instance:getActivityInfo()[actId]:isNewStageOpen() then
					self:_showRedDotType(redDotIcon, actId)

					return
				end
			end

			if actId == ActivityEnum.Activity.Activity1_7WarmUp and Activity125Controller.instance:checkActRed(actId) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end

			if actId == ActivityEnum.Activity.Activity1_8WarmUp and Activity125Controller.instance:checkActRed1(actId) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end

			if (actId == ActivityEnum.Activity.Activity1_9WarmUp or actId == ActivityEnum.Activity.V2a0_WarmUp or actId == ActivityEnum.Activity.V2a1_WarmUp or actId == ActivityEnum.Activity.V2a2_WarmUp or actId == ActivityEnum.Activity.V2a3_WarmUp or actId == ActivityEnum.Activity.V2a5_WarmUp or actId == ActivityEnum.Activity.V2a6_WarmUp or actId == ActivityEnum.Activity.V2a7_WarmUp) and Activity125Controller.instance:checkActRed2(actId) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end

			if actId == ActivityEnum.Activity.Activity1_5WarmUp and Activity146Controller.instance:isActFirstEnterToday() and (not Activity146Model.instance:isAllEpisodeFinish() or Activity146Model.instance:isHasEpisodeCanReceiveReward()) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end

			if actId == ActivityEnum.Activity.V2a2_TurnBack_H5 and ActivityBeginnerController.instance:checkFirstEnter(actId) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end

			if actId == VersionActivity2_2Enum.ActivityId.LimitDecorate and ActivityBeginnerController.instance:checkFirstEnter(actId) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end

			if actId == ActivityEnum.Activity.V2a4_WarmUp and Activity125Controller.instance:checkActRed3(actId) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end

			if typeId == ActivityEnum.ActivityTypeID.Act201 and ActivityBeginnerController.instance:checkFirstEnter(actId) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end
		end
	end
end

function ActivityMainBtnItem:_checkActivityWelfareRedDot(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		local actIds = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)

		for _, actId in pairs(actIds) do
			self._curActId = actId

			if actId == ActivityEnum.Activity.StoryShow and not TaskModel.instance:isFinishAllNoviceTask() and string.nilorempty(self:getActivityShowRedDotData(actId)) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end

			if actId == ActivityEnum.Activity.ClassShow and not TeachNoteModel.instance:isFinalRewardGet() and string.nilorempty(self:getActivityShowRedDotData(actId)) then
				self:_showRedDotType(redDotIcon, actId)

				return
			end
		end
	end
end

function ActivityMainBtnItem:_gm_getActIdDict()
	local centerCo = ActivityModel.instance:getActivityCenter()
	local list = centerCo[self._centerId]
	local dict = {}

	for _, actId in ipairs(list) do
		local id = string.sub(tostring(actId), 2, 3)

		dict[id] = dict[id] or {}

		table.insert(dict[id], actId)
	end

	return dict
end

return ActivityMainBtnItem
