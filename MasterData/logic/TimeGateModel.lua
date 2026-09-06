-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timegate/model/TimeGateModel.lua

module("logic.extensions.timegate.model.TimeGateModel", package.seeall)

local TimeGateModel = class("TimeGateModel", BaseModel)

TimeGateModel.Normal = 1
TimeGateModel.High = 2
TimeGateModel.SubTabTypeYuanqi = 1
TimeGateModel.SubTabTypeShenyao = 2
TimeGateModel.SubTabTypeLegend = 3
TimeGateModel.ReadFlag = "TimeGateModel.ReadFlag"
TimeGateModel.DaySeconds = 86400

function TimeGateModel:ctor()
	return
end

function TimeGateModel:onInit()
	self:onReset()
end

function TimeGateModel:onReset()
	self._timeGates = {}
	self._leftTimes = {}
	self._selectGate = {}
	self._openRaceIdsMap = {}
	self._regressTouchTimeMillis = -1
end

function TimeGateModel:onTimeGateInfoRes(msg)
	self._timeGates = {}
	self._leftTimes = {}
	self._openRaceIdsMap = {}
	self._regressTouchTimeMillis = msg.regressTouchTimeMillis

	if msg.types then
		for i, typeInfo in ipairs(msg.types) do
			self._leftTimes[typeInfo.type] = typeInfo.leftTimes

			for j, item in ipairs(typeInfo.items) do
				table.insert(self._timeGates, GameUtil.pbToTable(item))

				self._openRaceIdsMap[item.raceId] = true
			end
		end
	end

	local participateItemData = GameUtil.pbToTable(msg.participateItem)

	self._participateItemMap = {}

	if participateItemData then
		for i, v in ipairs(participateItemData) do
			self._participateItemMap[v.type] = self._participateItemMap[v.type] or {}
			self._participateItemMap[v.type][v.raceId] = v.num
		end
	end

	for type, raceId in pairs(self._selectGate) do
		local isFind = false

		for i, gateInfo in ipairs(self._timeGates) do
			if gateInfo.raceId == raceId and gateInfo.type == type then
				isFind = true

				break
			end
		end

		if not isFind then
			self._selectGate[type] = nil
		end
	end

	for i, v in ipairs(self._timeGates) do
		if not self._selectGate[v.type] then
			local cacheRaceId = TimeGateModel.instance:getOpenGateCache(v.type)

			if cacheRaceId and self:isOpenByRaceId(cacheRaceId) then
				self._selectGate[v.type] = cacheRaceId
			else
				self._selectGate[v.type] = v.raceId

				TimeGateModel.instance:saveOpenGateCache(v.type, v.raceId)
			end
		end
	end
end

function TimeGateModel:onTimeGateSelectOpenRes(type, raceId)
	self:onTimeGateSelectOpenBatchRes({
		{
			type = type,
			raceId = raceId
		}
	})
end

function TimeGateModel:onTimeGateSelectOpenBatchRes(items)
	local openCountMap = {}
	local selectRaceIdMap = {}
	local handledRaceIdMap = {}

	self._leftTimes = self._leftTimes or {}
	self._selectGate = self._selectGate or {}
	self._openRaceIdsMap = self._openRaceIdsMap or {}

	for _, item in ipairs(items or {}) do
		local typeIndex = checknumber(item.type)
		local raceId = checknumber(item.raceId)

		if typeIndex > 0 and raceId > 0 then
			handledRaceIdMap[typeIndex] = handledRaceIdMap[typeIndex] or {}

			if not handledRaceIdMap[typeIndex][raceId] then
				handledRaceIdMap[typeIndex][raceId] = true
				selectRaceIdMap[typeIndex] = raceId

				if not self._openRaceIdsMap[raceId] then
					self._openRaceIdsMap[raceId] = true
					openCountMap[typeIndex] = checknumber(openCountMap[typeIndex]) + 1
				end
			end
		end
	end

	for typeIndex, raceId in pairs(selectRaceIdMap) do
		local leftTimes = checknumber(self._leftTimes[typeIndex]) - checknumber(openCountMap[typeIndex])

		self._leftTimes[typeIndex] = math.max(0, leftTimes)
		self._selectGate[typeIndex] = raceId

		self:saveOpenGateCache(typeIndex, raceId)
	end
end

function TimeGateModel:changeSelectGate(typeIndex, raceId)
	self._selectGate[typeIndex] = raceId

	TimeGateModel.instance:saveOpenGateCache(typeIndex, raceId)
end

function TimeGateModel:isExistChallenge(typeIndex)
	if not self._timeGates or #self._timeGates == 0 then
		return false
	end

	for i, v in ipairs(self._timeGates) do
		if v.type == typeIndex then
			return true
		end
	end

	return false
end

function TimeGateModel:getLeftTime(typeIndex)
	return (self._leftTimes or nil) and (self._leftTimes[typeIndex] or 0)
end

function TimeGateModel:isRegressPrivilegeActive()
	if not PlayerReturnModel.instance:hasSinglePlge(PlayerReturnModel.PlgeTypeTimeGate) then
		return false
	end

	local touchTime = checknumber(self._regressTouchTimeMillis)

	if touchTime <= 0 then
		return false
	end

	local durationWeeks = TimeGateConfig.instance:getRegressExtraTimesDurationWeeks()
	local endTime = touchTime / 1000 + durationWeeks * 7 * TimeGateModel.DaySeconds

	return endTime > ServerTime.now()
end

function TimeGateModel:getRegressPrivilegeLeftDays()
	if not self:isRegressPrivilegeActive() then
		return 0
	end

	local durationWeeks = TimeGateConfig.instance:getRegressExtraTimesDurationWeeks()
	local endTime = checknumber(self._regressTouchTimeMillis) / 1000 + durationWeeks * 7 * TimeGateModel.DaySeconds
	local leftTime = endTime - ServerTime.now()

	return math.max(1, math.ceil(leftTime / TimeGateModel.DaySeconds))
end

function TimeGateModel:getRegressExtraTimes(typeIndex)
	if not self:isRegressPrivilegeActive() then
		return 0
	end

	return TimeGateConfig.instance:getRegressExtraTimes(typeIndex)
end

function TimeGateModel:getWeeklyTimesWithRegress(typeIndex)
	local typeCfg = TimeGateConfig.instance:getTypeCfg(typeIndex)

	return typeCfg.weeklyTimes + self:getRegressExtraTimes(typeIndex)
end

function TimeGateModel:getTimesLimitWithRegress(typeIndex)
	local typeCfg = TimeGateConfig.instance:getTypeCfg(typeIndex)

	return typeCfg.timesLimit
end

function TimeGateModel:getRaceIdByType(typeIndex)
	if self._selectGate[typeIndex] then
		return self._selectGate[typeIndex]
	end

	return 0
end

function TimeGateModel:isOpenByRaceId(raceId)
	return self._openRaceIdsMap[raceId] or false
end

function TimeGateModel:getParticipate(type, raceId)
	if self._participateItemMap[type] then
		return self._participateItemMap[type][raceId]
	end
end

function TimeGateModel:getRegressTouchTimeMillis()
	return self._regressTouchTimeMillis
end

function TimeGateModel:getOpenGateCache(type)
	local key = string.format("%s#OpenCache#%d", TimeGateModel.ReadFlag, type)

	return GameUtil.getUserData(key)
end

function TimeGateModel:saveOpenGateCache(type, raceId)
	local key = string.format("%s#OpenCache#%d", TimeGateModel.ReadFlag, type)

	GameUtil.saveUserData(key, raceId)
end

TimeGateModel.instance = TimeGateModel.New()

return TimeGateModel
