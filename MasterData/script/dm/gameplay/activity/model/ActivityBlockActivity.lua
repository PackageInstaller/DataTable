-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityBlockActivity.lua

ActivityBlockActivity = class("ActivityBlockActivity", BaseActivity, _M)

ActivityBlockActivity:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockActivity:has("_subActivityMap", {
	is = "r"
})
ActivityBlockActivity:has("_isCanShow", {
	is = "rw"
})
ActivityBlockActivity:has("_timeStamp", {
	is = "rw"
})
ActivityBlockActivity:has("_activityId", {
	is = "rw"
})

function ActivityBlockActivity:initialize()
	super.initialize(self)

	self._subActivityMap = {}
	self._isCanShow = "false"
	self._obtainedRewardBoxes = {}
	self._timeStamp = {}
	self._activityId = ""
end

function ActivityBlockActivity:dispose()
	super.dispose(self)
end

function ActivityBlockActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.subActivities then
		for id, value in pairs(data.subActivities) do
			local activity = self:getSubActivityById(id)

			if activity ~= nil then
				activity:synchronize(value)
			else
				local config = ConfigReader:getRecordById("Activity", id)

				if config and ActivityModel[config.Type] then
					activity = ActivityModel[config.Type]:new()

					activity:synchronize(value)

					self._subActivityMap[id] = activity
				end
			end
		end
	end

	if data.timeStamp then
		self._timeStamp = data.timeStamp
	end

	if data.activityId then
		self._activityId = data.activityId
	end
end

function ActivityBlockActivity:reset()
	super.reset(self)

	self._subActivityMap = {}
end

function ActivityBlockActivity:getSubActivityById(id)
	if id then
		return self._subActivityMap[id]
	end
end

function ActivityBlockActivity:getBlockMapIds()
	local ids = {}
	local activityIds = self:getActivity()

	for _, id in pairs(activityIds) do
		local config = ConfigReader:getRecordById("Activity", id)

		if config.Type == "ActivityBlockMap" or config.Type == ActivityType.KActivityBlockMapNew then
			ids[#ids + 1] = id
		end
	end

	return ids
end

function ActivityBlockActivity:getBlockMapActivity(activityId)
	local function getActivity(id)
		local activity = self:getSubActivityById(id)

		if activity and (activity:getType() == ActivityType.KActivityBlockMap or activity:getType() == ActivityType.KActivityBlockMapNew) and self:subActivityOpen(id) then
			return activity
		end

		return nil
	end

	if activityId then
		return getActivity(activityId)
	end

	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = getActivity(id)

		if activity then
			return activity
		end
	end

	return nil
end

function ActivityBlockActivity:getActivityClubBossData()
	if self._activityId == "" then
		return {}
	end

	local config = ConfigReader:getRecordById("Activity", self._activityId)

	for k, id in pairs(config.ActivityConfig.Activity) do
		local data = ConfigReader:getRecordById("Activity", id)

		if data and data.Type == ActivityType.KActivityClubBoss then
			return data
		end
	end

	return {}
end

function ActivityBlockActivity:getActivityClubBossActivity()
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.KActivityClubBoss then
			return activity
		end
	end

	local activityData = self:getActivityClubBossData()
	local tips = ""

	if activityData.TimeFactor then
		local timeStamp = activityData.TimeFactor
		local _, _, y, mon, d, h, m, s = string.find(timeStamp.start[2], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
		local table = {
			year = y,
			month = mon,
			day = d,
			hour = h,
			min = m,
			sec = s
		}
		local endTime = TimeUtil:timeByRemoteDate(table)
		local remoteTimestamp = self._activitySystem:getCurrentTime()
		local remainTime = endTime - remoteTimestamp

		if remainTime > 0 then
			local start = activityData.TimeFactor.start[1]
			local str = self._activitySystem:getTimeWillOpen(start)

			tips = Strings:get("Activity_summer_09", {
				value = str
			})
		else
			tips = Strings:get("ActivityBlock_UI_8")
		end
	end

	return nil, tips
end

function ActivityBlockActivity:getExchangeActivity()
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.KEXCHANGE then
			return activity
		end
	end

	return nil
end

function ActivityBlockActivity:getLoginActivities()
	local activityId = self:getActivityConfig().LoginActivity

	return self._activitySystem:getActivityById(activityId)
end

function ActivityBlockActivity:getColourEggActivity()
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.KColourEgg then
			return activity
		end
	end

	return nil
end

function ActivityBlockActivity:getMonsterShopActivity()
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.KMonsterShop then
			return activity
		end
	end

	return nil
end

function ActivityBlockActivity:getTaskActivities()
	local taskActivities = {}
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.kTASK then
			table.insert(taskActivities, activity)
		end
	end

	return taskActivities
end

function ActivityBlockActivity:getEggActivity()
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.kActivityBlockEgg then
			return activity
		end
	end

	return nil
end

function ActivityBlockActivity:getJumpActivity()
	local activityId = self:getActivityConfig().JumpActivityId

	return self._activitySystem:getActivityById(activityId)
end

function ActivityBlockActivity:getActivityTpurchase()
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local activity = self:getSubActivityById(id)

		if activity and self:subActivityOpen(id) and activity:getType() == ActivityType.KTPURCHASE then
			return activity
		end
	end

	return nil
end

function ActivityBlockActivity:hasRedPoint()
	local acts = self:getActivity()

	for i = 1, #acts do
		local id = acts[i]

		if self:subActivityHasRedPoint(id) and self:subActivityOpen(id) then
			return true
		end
	end

	return false
end

function ActivityBlockActivity:subActivityHasRedPoint(id)
	local activity = self:getSubActivityById(id)

	if activity then
		return activity:hasRedPoint()
	end

	return false
end

function ActivityBlockActivity:subActivityOpen(id)
	local activity = self:getSubActivityById(id)

	if activity then
		local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimeMillis()

		if curTime < activity:getStartTime() or curTime > activity:getEndTime() or not activity:getIsTodayOpen() then
			return false
		end

		return true
	end

	return false
end

function ActivityBlockActivity:subActivityHasNoFinish(id)
	local activity = self:getSubActivityById(id)

	if activity then
		local taskList = activity:getTaskList()

		for index, task in pairs(taskList) do
			local status = task:getStatus()

			if status == ActivityTaskStatus.kUnfinish then
				return true
			end
		end
	end

	return false
end

function ActivityBlockActivity:getButtonConfig()
	local btns = {
		blockParams = {},
		eggParams = {}
	}
	local activityIds = self:getActivity()

	for i = 1, #activityIds do
		local id = activityIds[i]
		local config = ConfigReader:getRecordById("Activity", id)

		if config then
			if config.Type == ActivityType.KActivityBlockMap or config.Type == ActivityType.KActivityBlockMapNew then
				btns.blockParams = {
					icon = config.ActivityConfig.ButtonIcon,
					title = Strings:get(config.Title),
					rewards = ConfigReader:getDataByNameIdAndKey("Reward", config.ActivityConfig.ShowReward, "Content"),
					heroes = config.ActivityConfig.BonusHero
				}
			elseif config.Type == ActivityType.kActivityBlockEgg then
				btns.eggParams = {
					icon = config.ActivityConfig.ButtonIcon,
					title = Strings:get(config.Title)
				}
			end
		end
	end

	return btns
end

function ActivityBlockActivity:getBgPath()
	return string.format("asset/scene/%s.jpg", self:getActivityConfig().Bmg)
end

function ActivityBlockActivity:getFrontBgPath()
	if self:getActivityConfig().Bmgupp then
		return string.format("asset/sceneStory/%s", self:getActivityConfig().Bmgupp)
	end

	return ""
end

function ActivityBlockActivity:getChangeBgPath()
	return string.format("asset/scene/%s.jpg", self:getActivityConfig().ChangeBmg)
end

function ActivityBlockActivity:getTitlePath()
	if self:getActivityConfig().Logo then
		return string.format("%s.png", self:getActivityConfig().Logo)
	end

	return nil
end

function ActivityBlockActivity:getTimeStr()
	if self._timeStr then
		return self._timeStr
	end

	local timeStr = self:getLocalTimeFactor()
	local start = ""
	local end_ = ""

	if timeStr.start then
		start = type(timeStr.start) == "table" and string.split(timeStr.start[1], " ")[1] or string.split(timeStr.start, " ")[1]

		local startTemp = string.split(start, "-")

		start = string.format("%s.%s.%s", startTemp[1], tonumber(startTemp[2]), tonumber(startTemp[3]))
	end

	if timeStr["end"] then
		end_ = string.split(timeStr["end"], " ")[1]

		local endTemp = string.split(end_, "-")

		end_ = string.format("%s.%s.%s", endTemp[1], tonumber(endTemp[2]), tonumber(endTemp[3]))
	end

	self._timeStr = string.format("%s~%s", start, end_)

	return self._timeStr
end

function ActivityBlockActivity:getTimeStamp()
	return self._timeStamp
end

function ActivityBlockActivity:getRoleParams()
	return self:getActivityConfig().ModelId
end

function ActivityBlockActivity:getResourcesBanner()
	return self:getActivityConfig().ResourcesBanner
end

function ActivityBlockActivity:getActivity()
	local actConfig = self:getActivityConfig()

	return actConfig.Activity
end

function ActivityBlockActivity:deleteSubActivity(activityMap)
	for activityId, v in pairs(activityMap) do
		if v == 1 then
			self._subActivityMap[activityId] = nil
		else
			local activity = self._subActivityMap[activityId]

			if activity and activity.delete then
				activity:delete(v)
			end
		end
	end
end

function ActivityBlockActivity:getSubActivityOpenTimes(config)
	local startTime = TimeUtil:formatStrToTImestamp(config.TimeFactor.start[1])
	local endTime = TimeUtil:formatStrToTImestamp(config.TimeFactor.start[2])

	return {
		startTime = startTime,
		endTime = endTime
	}
end

function ActivityBlockActivity:getSubActivityBaseData(activityId)
	return ConfigReader:getRecordById("Activity", activityId)
end

function ActivityBlockActivity:subActivityIsOpen(activityId)
	local activity = self:getSubActivityById(activityId)

	if activity then
		local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimeMillis()

		return curTime >= activity:getStartTime()
	end

	return false
end

function ActivityBlockActivity:subActivityIsOver(activityId)
	local activity = self:getSubActivityById(activityId)

	if activity then
		local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimeMillis()

		return curTime >= activity:getEndTime()
	end

	return true
end

function ActivityBlockActivity:isVote()
	local map = self:getBlockMapActivity()

	if not map then
		self._activitySystem:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return false
	end

	local pointId = map:getActivityConfig().VoteUnlock
	local point = map:getPointById(pointId)

	if not point then
		return false
	end

	return (point:isPass())
end

function ActivityBlockActivity:checkVote()
	local isVote = self:isVote()

	if not isVote then
		return
	end

	local map = self:getBlockMapActivity()
	local isVote = map:getIsVote()

	if isVote then
		self:showVoteResult()

		return
	end

	self:showVoteAlert()
end

function ActivityBlockActivity:showVoteResult()
	local map = self:getBlockMapActivity()

	if not map then
		self._activitySystem:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	local data = {
		doActivityType = 109
	}

	self._activitySystem:requestDoChildActivity(self._activityId, map:getId(), data, function(response)
		if response.data then
			local view = self._activitySystem:getInjector():getInstance("ActivityRiddleVoteView")

			self._activitySystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 200
			}, {
				data = response.data
			}))
		end
	end)
end

function ActivityBlockActivity:showVoteAlert()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local map = self:getBlockMapActivity()

	if not map then
		self._activitySystem:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	local function ok()
		local data = {
			doActivityType = 108
		}

		self._activitySystem:requestDoChildActivity(self._activityId, map:getId(), data, function(response)
			if response.data then
				self:showVoteResult()
			end
		end)
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			ok()
		elseif data.response == "cancel" then
			ok()
		elseif data.response == "close" then
			-- block empty
		end
	end

	local data = {
		title1 = "",
		title = Strings:get("VoteTitle_Des"),
		content = Strings:get("VoteContent_Des"),
		sureBtn = {
			text1 = "",
			text = Strings:get("Vote_Des_2")
		},
		cancelBtn = {
			text1 = "",
			text = Strings:get("Vote_Des_1")
		}
	}
	local view = self._activitySystem:getInjector():getInstance("AlertView")

	self._activitySystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end
