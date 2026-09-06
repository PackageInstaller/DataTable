-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/model/PartySummaryModel.lua

module("logic.extensions.partysummary.model.PartySummaryModel", package.seeall)

local PartySummaryModel = class("PartySummaryModel", BaseModel)

function PartySummaryModel:ctor()
	self._partyFoodInfo = nil
end

function PartySummaryModel:onInit()
	PartySummaryModel.super.onInit(self)
	self:onReset()
end

function PartySummaryModel:onReset()
	PartySummaryModel.super.onReset(self)

	self._partyFoodInfo = nil
	self._ModelPool = {}
end

function PartySummaryModel:GetModel(activityId)
	if self._ModelPool[activityId] == nil then
		local cur = {}

		cur.loginDays = 0
		self._ModelPool[activityId] = cur
	end

	return self._ModelPool[activityId]
end

function PartySummaryModel:handlePM_PartyGiftGetInfoRes(msg)
	local curModel = self:GetModel(msg.activityId)

	curModel.loginDays = msg.loginDays
end

function PartySummaryModel:getPartyFoodInfo(actId)
	self._partyFoodInfo = self._partyFoodInfo or {}
	actId = actId or PartySummaryConfig.instance:getPartyFoodActivityId()

	return self._partyFoodInfo[actId]
end

function PartySummaryModel:getOpenPartyFoodTermCfg(actId)
	actId = actId or PartySummaryConfig.instance:getPartyFoodActivityId()

	if checknumber(actId) <= 0 then
		return nil, 0
	end

	local allCfgs = PartySummaryConfig.instance:getFoodTermCfgs(actId)

	if allCfgs == nil or #allCfgs == 0 then
		return nil, 0
	end

	local nowData = ServerTime.nowDateServerLook()
	local startTime, curList = nil, {}

	for i = 1, #allCfgs do
		if allCfgs[i] and not string.nilorempty(allCfgs[i].startTime) then
			startTime = GameUtil.string2date(allCfgs[i].startTime)

			if startTime.month == nowData.month and startTime.day == nowData.day then
				table.insert(curList, allCfgs[i])
			end
		end
	end

	if curList == nil or #curList == 0 then
		return nil, 0
	end

	local nowTime = ServerTime.now()
	local count = #curList

	if count > 1 then
		table.sort(curList, function(a, b)
			return a.termId < b.termId
		end)
	end

	local sTime, eTime
	local endIndex = curList[count].termId

	for i = 1, count do
		if GameUtil.getTimePeriodTypeBySec(GameUtil.string2time(curList[i].startTime) - curList[i].preTime, (GameUtil.string2time(curList[i].endTime))) == GameUtil.inTimePeriod then
			return curList[i], endIndex - curList[i].termId
		end
	end

	return curList[1], endIndex - curList[1].termId
end

function PartySummaryModel:getPartyFoodListCfgs(actId, isSort)
	actId = actId or PartySummaryConfig.instance:getPartyFoodActivityId()

	if checknumber(actId) <= 0 then
		return {}
	end

	local allCfgs = PartySummaryConfig.instance:getFoodTypeCfgs(actId)
	local temp = {}

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and not string.nilorempty(cfg.name) then
			table.insert(temp, cfg)
		end
	end

	if isSort and #temp > 1 then
		table.sort(temp, function(a, b)
			return a.foodType < b.foodType
		end)
	end

	return temp
end

function PartySummaryModel:getPartyFoodItemPrizes(planId, foodType)
	if planId == nil or foodType == nil then
		return nil
	end

	local allCfgs = PartySummaryConfig.instance:getFoodPrizeCfgs(planId, foodType)

	if allCfgs == nil or #allCfgs == 0 then
		return nil
	end

	return allCfgs
end

function PartySummaryModel:getPartyFoodBigPrizes(actId)
	actId = actId or PartySummaryConfig.instance:getPartyFoodActivityId()

	if checknumber(actId) <= 0 then
		return {}, 0
	end

	local allCfgs = PartySummaryConfig.instance:getFoodTermCfgs(actId)

	if allCfgs == nil or #allCfgs == 0 then
		return {}, 0
	end

	local tempTab = {}
	local timeTab, prizeTab

	for i = 1, #allCfgs do
		if allCfgs[i] and not string.nilorempty(allCfgs[i].startTime) then
			timeTab = GameUtil.parseToTimeTable(allCfgs[i].startTime)
			tempTab[timeTab.month] = tempTab[timeTab.month] or {}

			if tempTab[timeTab.month][timeTab.day] == nil then
				prizeTab = self:_getBigPrizesByPlanId(allCfgs[i].foodPrizePlanId)

				if prizeTab and #prizeTab > 0 then
					tempTab[timeTab.month][timeTab.day] = prizeTab
				end
			end
		end
	end

	local targetList = {}

	for month, dayList in pairs(tempTab or {}) do
		for day, list in pairs(dayList or {}) do
			if day and list and #list > 0 then
				table.insert(targetList, {
					month = checknumber(month),
					day = checknumber(day),
					prizeList = list
				})
			end
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			if a.month == b.month then
				return a.day < b.day
			end

			return a.month < b.month
		end)

		local nowTime = ServerTime.nowDateServerLook()

		for i = 1, #targetList do
			if targetList[i].month == nowTime.month and targetList[i].day == nowTime.day then
				return targetList, i - 1
			end
		end
	end

	return targetList, 0
end

function PartySummaryModel:_getBigPrizesByPlanId(planId)
	planId = checknumber(planId)

	local allCfgs = PartySummaryConfig.instance:getFoodPrizeCfgs(planId)
	local temp = {}

	for _, list in pairs(allCfgs or {}) do
		for _, cfg in pairs(list or {}) do
			if cfg and cfg.broadcast then
				table.insert(temp, cfg)
			end
		end
	end

	if #temp > 1 then
		table.sort(temp, function(a, b)
			if a.foodType == b.foodType then
				return a.prizeId < b.prizeId
			end

			return a.foodType < b.foodType
		end)
	end

	return temp
end

function PartySummaryModel:getPrizesReceiveByNpcId(npcId)
	local actId = PartySummaryConfig.instance:getPartyFoodActivityId()

	if checknumber(actId) <= 0 then
		return
	end

	local foodType = 0
	local allCfgs = PartySummaryConfig.instance:getFoodNpcCfgs(actId)

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and cfg.npcId == npcId then
			foodType = cfg.foodType

			break
		end
	end

	if foodType <= 0 then
		printError("sr---派对美食    PartySummaryModel:getPrizesReceiveByNpcId()   没有配置对应的npc食物类型！！")

		return
	end

	local typsCfg = PartySummaryConfig.instance:getFoodTypeCfgs(actId, foodType)

	if typsCfg == nil then
		printError("sr---派对美食    PartySummaryModel:getPrizesReceiveByNpcId()   没有配置对应的npc食物类型！！")

		return
	end

	local info = self:getPartyFoodInfo(actId)

	if info == nil or info.typeInfo == nil then
		return
	end

	local termCfg = self:_getPartyFoodOpenTerm(actId)

	if termCfg == nil then
		return
	end

	local data = {
		areaCount = 0,
		ownCount = 0,
		ownLimit = typsCfg.dailyTimes,
		areaLimit = typsCfg.allAreaLimit,
		name = typsCfg.name,
		termId = termCfg.termId
	}

	if info.typeInfo[foodType] then
		data.ownCount = info.typeInfo[foodType].ownCount
		data.areaCount = info.typeInfo[foodType].areaCount
	end

	return data
end

function PartySummaryModel:getPartyFoodTermEndTime()
	local actId = PartySummaryConfig.instance:getPartyFoodActivityId()

	if checknumber(actId) <= 0 then
		return 0
	end

	local termCfg = self:_getPartyFoodOpenTerm(actId)

	if termCfg == nil or string.nilorempty(termCfg.endTime) then
		return 0
	end

	return GameUtil.string2time(termCfg.endTime) + 1 - ServerTime.now()
end

function PartySummaryModel:_getPartyFoodOpenTerm(actId)
	local termCfgs = PartySummaryConfig.instance:getFoodTermCfgs(actId)
	local startTime, endTime

	for _, cfg in pairs(termCfgs or {}) do
		if cfg and not string.nilorempty(cfg.startTime) and GameUtil.getTimePeriodTypeBySec(GameUtil.string2time(cfg.startTime) - cfg.preTime, (GameUtil.string2time(cfg.endTime))) == GameUtil.inTimePeriod then
			return cfg
		end
	end

	return nil
end

function PartySummaryModel:getPartyFoodProbability(cfg)
	if cfg == nil or cfg.weight <= 0 then
		return 0 .. "%"
	end

	local allCfgs = PartySummaryConfig.instance:getFoodPrizeCfgs(cfg.foodPrizePlanId, cfg.foodType)
	local count = 0

	for _, v in pairs(allCfgs or {}) do
		if v and v.weight > 0 then
			count = count + v.weight
		end
	end

	if count <= 0 then
		return 0 .. "%"
	end

	local pro = string.format("%.2f", 100 * cfg.weight / count)

	return pro .. "%"
end

function PartySummaryModel:scSendPotluckDinnerInfo(msg, status)
	local actId = PartySummaryConfig.instance:getPartyFoodActivityId()

	self._partyFoodInfo = self._partyFoodInfo or {}

	if status ~= 0 or msg == nil then
		self._partyFoodInfo[actId] = nil

		return
	end

	self._partyFoodInfo[actId] = {
		curTermId = msg.curTermId,
		typeInfo = {}
	}

	for _, v in pairs(msg.food or {}) do
		if v and checknumber(v.foodType) > 0 then
			self._partyFoodInfo[actId].typeInfo[v.foodType] = {
				ownCount = checknumber(v.times),
				areaCount = checknumber(v.allAreaTimes)
			}
		end
	end
end

function PartySummaryModel:getPartyFoodViewRedPoint(isRed)
	local actId = PartySummaryConfig.instance:getPartyFoodActivityId()

	if checknumber(actId) <= 0 then
		return false
	end

	local cfg, count = self:getOpenPartyFoodTermCfg(actId)

	if cfg == nil or count == 0 then
		return false
	end

	local sTime, eTime = GameUtil.string2time(cfg.startTime), GameUtil.string2time(cfg.endTime)

	if not isRed then
		sTime = sTime - cfg.preTime
	end

	if GameUtil.getTimePeriodTypeBySec(sTime, eTime) ~= GameUtil.inTimePeriod then
		return false
	end

	local temp = self:getPartyFoodInfo(actId)

	if temp == nil or temp.typeInfo == nil then
		return false
	end

	local info
	local allCfgs = PartySummaryConfig.instance:getFoodTypeCfgs(actId)

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and not string.nilorempty(cfg.name) then
			info = temp.typeInfo[cfg.foodType]

			if temp.typeInfo[cfg.foodType] == nil then
				return true
			end

			if (cfg.allAreaLimit > 0 and info.areaCount < cfg.allAreaLimit or cfg.allAreaLimit == 0) and info.ownCount < cfg.dailyTimes then
				return true
			end
		end
	end

	return false
end

PartySummaryModel.instance = PartySummaryModel.New()

return PartySummaryModel
