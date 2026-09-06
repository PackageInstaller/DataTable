-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/model/RomanticGiftsModel.lua

module("logic.extensions.romanticgifts.model.RomanticGiftsModel", package.seeall)

local RomanticGiftsModel = class("RomanticGiftsModel", BaseModel)

RomanticGiftsModel.taskState = {
	completed = 3,
	unComplete = 2,
	complete = 1
}

function RomanticGiftsModel:ctor()
	return
end

function RomanticGiftsModel:onInit()
	self:onReset()
end

function RomanticGiftsModel:onReset()
	self._activityId = 0
	self._dayTaskList = {}
	self._achievementList = {}
	self._records = {}
	self._friends = {}
	self._romanticRankInfo = {}
	self._sweetRankInfo = {}
end

function RomanticGiftsModel:getActId()
	if checknumber(self._activityId) <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.QIXI_SEND)
	end

	return self._activityId
end

function RomanticGiftsModel:setRomanticRankInfo(msg)
	self._romanticRankInfo[msg.zoneId] = GameUtil.pbToTable(msg)
end

function RomanticGiftsModel:setSweetRankInfo(msg)
	self._sweetRankInfo[msg.zoneId] = GameUtil.pbToTable(msg)
end

function RomanticGiftsModel:getSweetRankInfo(zoneId)
	return self._sweetRankInfo[zoneId]
end

function RomanticGiftsModel:getRomanticRankInfo(zoneId)
	return self._romanticRankInfo[zoneId]
end

function RomanticGiftsModel:setSendInfo(msg)
	self._records = msg.records
	self._friends = msg.friends
end

function RomanticGiftsModel:updateFiendsInfo(target)
	for i, v in ipairs(self._friends) do
		if v.userId == target.userId then
			v.value = target.value
		end
	end
end

function RomanticGiftsModel:getTabInfo()
	return self._records, self._friends
end

function RomanticGiftsModel:getTabInfoByKeyWord(key)
	local records = {}
	local friends = {}

	for i, v in ipairs(self._records) do
		if string.find(v.userName, key) or string.find(tostring(v.userId), key) then
			table.insert(records, v)
		end
	end

	for i, v in ipairs(self._friends) do
		local friendInfo = FriendModel.instance:getFriendMo(v.userId)

		if string.find(friendInfo.headInfo.userName, key) or string.find(tostring(v.userId), key) then
			table.insert(friends, v)
		end
	end

	return records, friends
end

function RomanticGiftsModel:getAllTaskList(actId)
	if not TableUtil.isTableEmpty(self._dayTaskList) and not TableUtil.isTableEmpty(self._achievementList) then
		return self._dayTaskList, self._achievementList
	end

	local taskCfg = EventTaskSummaryConfig.instance:getTaskCfgs(actId)

	self._dayTaskList = {}
	self._achievementList = {}

	for k, v in ipairs(taskCfg) do
		if v and v.periodType then
			if v.periodType == "daily" then
				table.insert(self._dayTaskList, v)
			else
				table.insert(self._achievementList, v)
			end
		end
	end

	return self._dayTaskList, self._achievementList
end

function RomanticGiftsModel:setTaskListSort(taskCfg)
	local taskInfos = EventTaskSummaryModel.instance:getTaskInfoList()
	local taskList = {}

	for i, v in ipairs(taskCfg) do
		local taskInfo = taskInfos[v.taskId]

		v.curProgress = taskInfo.curProgress
		v.hasGainPrize = taskInfo.hasGainPrize
		v.state = v.hasGainPrize and RomanticGiftsModel.taskState.completed or v.curProgress >= v.maxProgress and RomanticGiftsModel.taskState.complete or RomanticGiftsModel.taskState.unComplete

		if not taskList[v.pageId] then
			taskList[v.pageId] = v
		elseif taskList[v.pageId].hasGainPrize and v.taskId > taskList[v.pageId].taskId then
			taskList[v.pageId] = v
		end
	end

	local list = {}

	for k, v in pairs(taskList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		if a.state == b.state then
			return a.taskId < b.taskId
		end

		return a.state < b.state
	end)

	return list
end

function RomanticGiftsModel:getDayTaskCfg(actId)
	local taskCfg = self:getAllTaskList(actId)

	return self:setTaskListSort(taskCfg)
end

function RomanticGiftsModel:getAchievementCfg(actId)
	local _, taskCfg = self:getAllTaskList(actId)

	return self:setTaskListSort(taskCfg)
end

function RomanticGiftsModel:getFlowerCfg(flowerId)
	return RomanticGiftsConfig.instance:getFlowerCfg(self:getActId(), flowerId)
end

function RomanticGiftsModel:getPlayerZoneId()
	local areaId = RoleModel.instance:getAreaId() or 1
	local zoneCfg = RomanticGiftsConfig.instance:getZoneCfg()

	for _, v in ipairs(zoneCfg) do
		local areaIds = v.areaIds

		if areaId <= areaIds[2] and areaId >= areaIds[1] then
			return v.zoneId
		end
	end
end

RomanticGiftsModel.instance = RomanticGiftsModel.New()

return RomanticGiftsModel
