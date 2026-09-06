-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/model/DreamIslandModel.lua

module("logic.extensions.accumulategift.model.DreamIslandModel", package.seeall)

local DreamIslandModel = class("DreamIslandModel", BaseModel)

function DreamIslandModel:ctor()
	self._activityId = nil
	self._choTableNums = nil
	self._scoreInfoList = nil
	self._taskSeverList = nil
	self._taskCacheList = nil
end

function DreamIslandModel:onInit()
	DreamIslandModel.super.onInit(self)
	self:onReset()
end

function DreamIslandModel:onReset()
	self._activityId = nil
	self._choTableNums = nil
	self._scoreInfoList = nil
	self._taskSeverList = nil
	self._taskCacheList = nil
end

function DreamIslandModel:GetSetChoiseTableNums(isSet, weekNum, dayNum)
	self._choTableNums = self._choTableNums or {}

	if isSet then
		self._choTableNums.weekNum = weekNum
		self._choTableNums.dayNum = dayNum

		return
	end

	if checknumber(self._choTableNums.weekNum) <= 0 or checknumber(self._choTableNums.dayNum) <= 0 then
		local _openDay = self:GetNowActivityTime()

		if checknumber(_openDay) > 0 then
			self._choTableNums.weekNum = math.ceil(_openDay / 7)
			self._choTableNums.dayNum = _openDay - (math.ceil(_openDay / 7) - 1) * 7
		else
			self._choTableNums.weekNum = 1
			self._choTableNums.dayNum = 1
		end
	end

	return self._choTableNums
end

function DreamIslandModel:GetOpenActivityId()
	if self._activityId and self._activityId > 0 then
		return self._activityId
	end

	local actiType = DreamIslandConfig.instance:GetDreamIslandParams("activityType")

	if checknumber(actiType) <= 0 then
		printError("sr---  DreamIslandModel:GetOpenActivityId()   重回梦之岛的活动类型获取失败！！")

		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(checknumber(actiType))

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			self._activityId = item.activityId

			return self._activityId
		end
	end

	return -2
end

function DreamIslandModel:GetNowActivityTime()
	local actiId = self:GetOpenActivityId()
	local actiType = DreamIslandConfig.instance:GetDreamIslandParams("activityType")

	if checknumber(actiId) <= 0 or checknumber(actiType) <= 0 then
		return 0, 0
	end

	local cfg = ActivityDefineConfig.instance:getCfgById(checknumber(actiType), checknumber(actiId))

	if cfg == nil or string.nilorempty(cfg.startTime) or string.nilorempty(cfg.endTime) then
		return 0, 0
	end

	local timeStart = GameUtil.string2time(cfg.startTime, true)
	local day = math.ceil((ServerTime.nowServerLook() - timeStart) / 86400)

	if day > 7 then
		day = 7
	end

	return day, GameUtil.string2time(cfg.endTime)
end

function DreamIslandModel:SCPushDreamIslandTaskData(msg)
	self._scoreInfoList = {}
	self._taskSeverList = {}
	self._taskCacheList = nil
	self._activityId = nil

	local actiId = checknumber(msg.activityId)

	if actiId <= 0 then
		printError("sr--- DreamIslandModel:SCPushDreamIslandTaskData()  重回梦之岛的活动类型有误！！" .. msg.activityId)

		return
	end

	self._activityId = actiId
	self._scoreInfoList.haveScore = checknumber(msg.totalScore)

	local scoreData = msg.gainStates
	local scoreCfgs = DreamIslandConfig.instance:GetScorePrizeCfgs(actiId)

	if scoreCfgs and #scoreCfgs > 0 then
		for i = 1, #scoreCfgs do
			if scoreCfgs[i] and checknumber(scoreCfgs[i].needScore) > 0 then
				if scoreData then
					scoreCfgs[i].isReceive = scoreData[i] or false
				end

				if i == #scoreCfgs then
					self._scoreInfoList.allScore = scoreCfgs[i].needScore
				end
			end
		end

		self._scoreInfoList.scoreList = scoreCfgs
	end

	local taskData = msg.taskInfos

	if taskData and #taskData > 0 then
		for i = 1, #taskData do
			local taskId = taskData[i].taskId

			self._taskSeverList[taskId] = {
				isReceive = taskData[i].gainPrize,
				haveCount = taskData[i].curProgress
			}
		end
	end

	GlobalDispatcher:dispatch("UpdataDreamIslandTask", 1)
end

function DreamIslandModel:SCPushReceiveTask(taskId)
	if self._taskSeverList == nil or self._taskSeverList[taskId] == nil or self._scoreInfoList == nil then
		printError("sr--- 重回梦之岛  DreamIslandModel:SCPushReceiveTask()  领取任务  本地空的 = " .. taskId)

		return
	end

	self._taskCacheList = nil
	self._taskSeverList[taskId].isReceive = true

	local haveScore = DreamIslandConfig.instance:GetDreamIslandTaskScore(self._activityId, taskId)

	self._scoreInfoList.haveScore = checknumber(self._scoreInfoList.haveScore) + haveScore

	GlobalDispatcher:dispatch("UpdataDreamIslandTask", 3)
end

function DreamIslandModel:SCPushReceiveScore(index)
	if self._scoreInfoList == nil or self._scoreInfoList.scoreList == nil or self._scoreInfoList.scoreList[index] == nil then
		printError("sr--- 重回梦之岛  DreamIslandModel:SCPushReceiveScore()  领取积分  本地空的 = " .. index)

		return
	end

	self._scoreInfoList.scoreList[index].isReceive = true

	GlobalDispatcher:dispatch("UpdataDreamIslandTask", 2)
end

function DreamIslandModel:GetDreamIslandTasks(allDayNum)
	if self._taskCacheList == nil then
		self._taskCacheList = {}
	end

	if self._taskCacheList[self._activityId] == nil then
		self._taskCacheList[self._activityId] = {}
	end

	if self._taskCacheList[self._activityId][allDayNum] then
		return self._taskCacheList[self._activityId][allDayNum]
	end

	local daysCfgs = DreamIslandConfig.instance:GetDayAllTaskCfgs(self._activityId, allDayNum) or {}

	if daysCfgs == nil or next(daysCfgs) == nil then
		printError("sr--- 重回梦之岛  DreamIslandModel:SCPushReceiveScore()  获取任务列表空 = " .. allDayNum)

		return
	end

	local targetList = {}

	for typeK, typeV in pairs(daysCfgs) do
		if typeV and #typeV > 0 then
			local list = {}

			for i = 1, #typeV do
				local tempInfo = self:_ComparedServerTaskData(self._activityId, typeV[i].id)

				if tempInfo then
					table.insert(list, tempInfo)
				end
			end

			if #list > 1 then
				table.sort(list, function(a, b)
					if a.stage == b.stage then
						if a.stage == 3 then
							return a.id > b.id
						end

						return a.id < b.id
					end

					return a.stage < b.stage
				end)
			end

			if #list > 0 then
				table.insert(targetList, list[1])
			end
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			if a.stage == b.stage then
				return a.id < b.id
			end

			return a.stage < b.stage
		end)
	end

	self._taskCacheList[self._activityId][allDayNum] = targetList

	return targetList
end

function DreamIslandModel:_ComparedServerTaskData(actiId, taskId)
	local cfg = DreamIslandConfig.instance:GetDreamIslandTaskCfg(actiId, taskId)

	if cfg == nil then
		return
	end

	local tempInfo = {
		isReach = false,
		isReceive = false,
		haveCount = 0,
		stage = 2,
		id = cfg.id,
		title = cfg.title,
		desc = cfg.desc,
		needCount = cfg.maxProgress,
		prizeList = string.split(cfg.prize, "#"),
		score = cfg.score,
		jumpTo = cfg.jumpTo
	}

	if self._taskSeverList == nil or self._taskSeverList[taskId] == nil then
		return tempInfo
	end

	tempInfo.isReceive = self._taskSeverList[taskId].isReceive
	tempInfo.haveCount = self._taskSeverList[taskId].haveCount
	tempInfo.isReach = tempInfo.haveCount >= tempInfo.needCount

	if tempInfo.isReceive then
		tempInfo.stage = 3
	elseif tempInfo.isReach then
		tempInfo.stage = 1
	end

	return tempInfo
end

function DreamIslandModel:GetDreamIslandScore()
	return self._scoreInfoList
end

function DreamIslandModel:GetWeekRedPoint(weekNum)
	local _openDay = self:GetNowActivityTime()

	if weekNum > math.ceil(_openDay / 7) then
		return false
	end

	local startIndex = 1 + (weekNum - 1) * 7

	for i = startIndex, startIndex + 6 do
		if self:GetDayRedPoint(i) then
			return true
		end
	end

	return false
end

function DreamIslandModel:GetDayRedPoint(allDayNum)
	if checknumber(self._activityId) <= 0 then
		return false
	end

	local _openDay = self:GetNowActivityTime()

	if allDayNum > checknumber(_openDay) then
		return false
	end

	local list = self:GetDreamIslandTasks(allDayNum)

	if list == nil or #list == 0 then
		return false
	end

	for i = 1, #list do
		if list[i] and not list[i].isReceive and list[i].isReach then
			return true
		end
	end

	return false
end

function DreamIslandModel:GetScoreRedPoint()
	if self._scoreInfoList == nil or self._scoreInfoList.scoreList == nil then
		return false
	end

	local haveScore = self._scoreInfoList.haveScore
	local scoreList = self._scoreInfoList.scoreList

	for _, info in pairs(scoreList) do
		if info and not info.isReceive and haveScore >= info.score then
			return true
		end
	end

	return false
end

DreamIslandModel.instance = DreamIslandModel.New()

return DreamIslandModel
