-- chunkname: @modules/logic/versionactivity1_2/jiexika/config/Activity114Config.lua

module("modules.logic.versionactivity1_2.jiexika.config.Activity114Config", package.seeall)

local Activity114Config = class("Activity114Config", BaseConfig)

function Activity114Config:reqConfigNames()
	return {
		"activity114_photo",
		"activity114_round",
		"activity114_task",
		"activity114_meeting",
		"activity114_difficulty",
		"activity114_const",
		"activity114_test",
		"activity114_motion",
		"activity114_event",
		"activity114_feature",
		"activity114_attribute",
		"activity114_travel"
	}
end

function Activity114Config:onInit()
	self._attrVerify = nil
	self._eventDict = nil
	self._eduEventDict = nil
	self._restEventDict = nil
	self._rateDescDict = nil
	self._allActivityIds = nil
	self._answerFailDict = nil
	self._motionDic = nil
end

function Activity114Config:onConfigLoaded(configName, configTable)
	if configName == "activity114_attribute" then
		self._attrVerify = {}

		for _, attrCo in ipairs(configTable.configList) do
			local list = string.split(attrCo.attributeNum, "|")
			local arr = {}

			for k, v in ipairs(list) do
				arr[k] = string.splitToNumber(v, "#")
			end

			self._attrVerify[attrCo.activityId] = self._attrVerify[attrCo.activityId] or {}
			self._attrVerify[attrCo.activityId][attrCo.id] = arr
		end
	elseif configName == "activity114_event" then
		self._eventDict = {}
		self._eduEventDict = {}
		self._restEventDict = {}
		self._allActivityIds = {}

		for _, eventCo in ipairs(configTable.configList) do
			self._eventDict[eventCo.activityId] = self._eventDict[eventCo.activityId] or {}
			self._allActivityIds[eventCo.activityId] = true

			local successVerify = {}
			local successFeatures = {}
			local failureVerify = {}
			local failureFeatures = {}
			local successBattleVerify = {}
			local successBattleFeatures = {}

			self:_splitVerifyInfo(eventCo.successVerify, successFeatures, successVerify)
			self:_splitVerifyInfo(eventCo.failureVerify, failureFeatures, failureVerify)
			self:_splitVerifyInfo(eventCo.successBattle, successBattleFeatures, successBattleVerify)

			local co = {
				config = eventCo,
				successVerify = successVerify,
				failureVerify = failureVerify,
				successFeatures = successFeatures,
				failureFeatures = failureFeatures,
				successBattleFeatures = successBattleFeatures,
				successBattleVerify = successBattleVerify
			}

			self._eventDict[eventCo.activityId][eventCo.id] = co

			if eventCo.eventType == Activity114Enum.EventType.Edu then
				self._eduEventDict[eventCo.activityId] = self._eduEventDict[eventCo.activityId] or {}
				self._eduEventDict[eventCo.activityId][tonumber(eventCo.param)] = co
			elseif eventCo.eventType == Activity114Enum.EventType.Rest then
				self._restEventDict[eventCo.activityId] = self._restEventDict[eventCo.activityId] or {}
				self._restEventDict[eventCo.activityId][tonumber(eventCo.param)] = co
			end
		end
	elseif configName == "activity114_difficulty" then
		self._rateDescDict = {}

		for k, co in ipairs(configTable.configList) do
			local arr = string.splitToNumber(co.interval, ",")

			self._rateDescDict[k] = {
				min = arr[1],
				max = arr[2],
				co = co
			}
		end
	elseif configName == "activity114_test" then
		self._answerFailDict = {}

		for activityId, list in pairs(configTable.configDict) do
			self._answerFailDict[activityId] = {}

			for _, co in pairs(list) do
				if not self._answerFailDict[activityId][co.testId] then
					local arr = string.splitToNumber(co.result, "#")

					self._answerFailDict[activityId][co.testId] = arr[1]
				end
			end
		end
	elseif configName == "activity114_motion" then
		self._motionDic = {}

		for k, co in ipairs(configTable.configList) do
			if co.type == Activity114Enum.MotionType.Time then
				if not self._motionDic[co.type] then
					self._motionDic[co.type] = {}

					local info = string.splitToNumber(co.param, "#")

					self._motionDic.firstTime = info[1] or 0
					self._motionDic.nextTime = info[2] or 0
				end

				table.insert(self._motionDic[co.type], co)
			elseif co.type == Activity114Enum.MotionType.Click then
				self._motionDic[co.type] = co
			else
				self._motionDic[co.type] = self._motionDic[co.type] or {}
				self._motionDic[co.type][tonumber(co.param)] = co
			end
		end
	end
end

function Activity114Config:_splitVerifyInfo(str, tb1, tb2)
	if string.nilorempty(str) then
		return
	end

	for _, v in pairs(string.split(str, "|")) do
		local arr = string.splitToNumber(v, "#")

		if not arr[1] then
			logError("洁西卡事件奖励配置错误：" .. str)
		end

		if arr[1] == Activity114Enum.AddAttrType.Feature then
			table.insert(tb1, arr[2])
		elseif arr[1] and arr[1] < Activity114Enum.Attr.End or arr[1] == Activity114Enum.AddAttrType.Attention or arr[1] == Activity114Enum.AddAttrType.KeyDayScore or arr[1] == Activity114Enum.AddAttrType.LastKeyDayScore then
			tb2[arr[1]] = ((not tb2[arr[1]] or nil) and 0) + arr[2]
		elseif arr[1] then
			tb2[arr[1]] = tb2[arr[1]] or {}

			table.insert(tb2[arr[1]], arr[2])
		end
	end
end

function Activity114Config:getUnlockIds(activityId)
	local showUnlockMeetingId = {}
	local showUnlockTravelId = {}

	for k, v in pairs(lua_activity114_meeting.configDict[activityId]) do
		if string.find(v.condition, "^1#") then
			showUnlockMeetingId[v.id] = true
		end
	end

	for k, v in pairs(lua_activity114_travel.configDict[activityId]) do
		if string.find(v.condition, "^1#") then
			showUnlockTravelId[v.id] = true
		end
	end

	return showUnlockMeetingId, showUnlockTravelId
end

function Activity114Config:getAllActivityIds()
	return self._allActivityIds
end

function Activity114Config:getFeatureCo(activityId, featureId)
	return lua_activity114_feature.configDict[activityId][featureId]
end

function Activity114Config:getMotionCo()
	return self._motionDic
end

function Activity114Config:getAttrVerify(activityId, attrType, nowAttr)
	if not self._attrVerify[activityId][attrType] then
		return 0
	end

	local max

	for _, verifyInfo in ipairs(self._attrVerify[activityId][attrType]) do
		if nowAttr >= verifyInfo[1] then
			max = verifyInfo[2]
		else
			break
		end
	end

	return max or 0
end

function Activity114Config:getEduEventCo(activityId, attrType)
	return self._eduEventDict[activityId][attrType]
end

function Activity114Config:getRestEventCo(activityId, statu)
	return self._restEventDict[activityId][statu]
end

function Activity114Config:getEventCoById(activityId, id)
	return self._eventDict[activityId][id]
end

function Activity114Config:getMeetingCoList(activityId)
	return lua_activity114_meeting.configDict[activityId]
end

function Activity114Config:getTravelCoList(activityId)
	return lua_activity114_travel.configDict[activityId]
end

function Activity114Config:getTaskCoById(activityId, taskId)
	return lua_activity114_task.configDict[activityId][taskId]
end

function Activity114Config:getAnswerCo(activityId, id)
	return lua_activity114_test.configDict[activityId][id]
end

function Activity114Config:getAnswerResult(activityId, id, score)
	local co = self:getAnswerCo(activityId, id)
	local results = string.splitToNumber(co.result, "#")

	for i = 3, 1, -1 do
		if results[i] > 0 then
			local val, str = self:getConstValue(activityId, results[i])

			if val <= score then
				return i, str
			end
		end
	end

	if results[1] > 0 then
		local val, str = self:getConstValue(activityId, results[1])

		return 1, str
	end

	logError("查找结果失败>>" .. co.id .. " >>> " .. score)

	return 1, ""
end

function Activity114Config:getRoundCo(activityId, day, round)
	return lua_activity114_round.configDict[activityId][day][round]
end

function Activity114Config:getRoundCount(activityId, day, round)
	local totalRound = round

	for i = 1, day - 1 do
		totalRound = totalRound + #lua_activity114_round.configDict[activityId][i]
	end

	return totalRound
end

function Activity114Config:getKeyDayCo(activityId, day)
	while true do
		local co = lua_activity114_round.configDict[activityId][day + 1]

		if not co or not co[1] then
			return
		end

		if co[1].type == Activity114Enum.RoundType.KeyDay then
			return co[1]
		end

		day = day + 1
	end
end

function Activity114Config:getPhotoCoList(activityId)
	return lua_activity114_photo.configDict[activityId]
end

function Activity114Config:getRateDes(rate)
	for level, info in pairs(self._rateDescDict) do
		if rate >= info.min and rate <= info.max then
			return info.co.word, level
		end
	end

	return "??", 1
end

function Activity114Config:getEduSuccessRate(activityId, attrId, nowAttention)
	local attrCo = self:getAttrCo(activityId, attrId)

	if not attrCo then
		return 0
	end

	local arr = string.splitToNumber(attrCo.educationAttentionConsts, "#")
	local a, b, c

	a = (arr[1] or 0) / 1000
	b = (arr[2] or 0) / 1000

	local rate = Mathf.Floor(a * nowAttention^2 + b * nowAttention + arr[3] / 1000)

	if not arr[3] then
		rate = 0
		nowAttention = Mathf.Clamp(nowAttention, 0, 100)
	end

	return Mathf.Clamp(rate, 0, 100)
end

function Activity114Config:getAttrName(activityId, attrType)
	return lua_activity114_attribute.configDict[activityId][attrType].attrName
end

function Activity114Config:getAttrCo(activityId, attrType)
	return lua_activity114_attribute.configDict[activityId][attrType]
end

function Activity114Config:getAttrMaxValue(activityId, attrType)
	local arr = self._attrVerify[activityId][attrType]

	if not arr then
		return 0
	end

	return arr[#arr][1]
end

function Activity114Config:getConstValue(activityId, id)
	local dict = lua_activity114_const.configDict[activityId]
	local config = dict and dict[id]

	if not config then
		return 0, ""
	end

	return config.value, config.value2
end

function Activity114Config:getDiceRate(totalNum)
	if totalNum <= 2 then
		return 100
	end

	if totalNum > 12 then
		return 0
	end

	if totalNum >= 7 then
		totalNum = 14 - totalNum

		local total = 0

		for i = 1, totalNum - 1 do
			total = total + i
		end

		return Mathf.Round(total / 36 * 100)
	else
		local total = 0

		for i = 2, totalNum - 1 do
			total = total + i - 1
		end

		return Mathf.Round(100 - total / 36 * 100)
	end
end

Activity114Config.instance = Activity114Config.New()

return Activity114Config
