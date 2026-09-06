-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/model/DoubleElevenModel.lua

module("logic.extensions.doubleeleven.model.DoubleElevenModel", package.seeall)

local DoubleElevenModel = class("DoubleElevenModel", BaseModel)

function DoubleElevenModel:ctor()
	self.mainTabIndex = nil
	self.crSubTabIndex = nil
	self._rechargeInfos = nil
	self._seckillInfos = nil
	self._freeInfos = nil
end

function DoubleElevenModel:onInit()
	DoubleElevenModel.super.onInit(self)
	self:onReset()
end

function DoubleElevenModel:onReset()
	DoubleElevenModel.super.onReset(self)

	self.mainTabIndex = nil
	self.crSubTabIndex = nil
	self._rechargeInfos = nil
	self._seckillInfos = nil
	self._freeInfos = nil
	self._activityId = nil
end

function DoubleElevenModel:setActivityId(activityId)
	self._activityId = activityId
end

function DoubleElevenModel:getActId()
	return self._activityId
end

function DoubleElevenModel:getDoubleElevenTabList(param, isIndex)
	local allList = DoubleElevenConfig.instance:getAllDoubleElevenTabCfgs()
	local tempList = {}

	for _, cfg in pairs(allList or {}) do
		if cfg and checknumber(cfg.sort) > 0 and (cfg.funcId <= 0 or FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)) then
			table.insert(tempList, cfg)
		end
	end

	param = checknumber(param)

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a.sort < b.sort
		end)
	end

	if isIndex then
		if tempList[param] then
			return tempList, param
		end
	else
		for i = 1, #tempList do
			if tempList[i].tabId == param then
				return tempList, i
			end
		end
	end

	return tempList, 1
end

function DoubleElevenModel:getDaysRechargeCfgs()
	local allList = DoubleElevenConfig.instance:getDaysRechargeAllCfgs()
	local tabList = {}

	for tab, list in pairs(allList or {}) do
		if tab and list and #list > 0 then
			table.insert(tabList, tab)
		end
	end

	if #tabList > 0 then
		table.sort(tabList, function(a, b)
			return a < b
		end)
	end

	return tabList, allList
end

function DoubleElevenModel:getTodayRechargeMoney()
	if self._rechargeInfos == nil or self._rechargeInfos.rechargeInfos == nil then
		return 0
	end

	local nowTime = ServerTime.nowDateServerLook()

	if nowTime.hour < 5 then
		nowTime.day = nowTime.day - 1

		if nowTime.day < 1 then
			local timestamp = GameUtil.date2time(nowTime.year, nowTime.month, nowTime.day, nowTime.hour, nowTime.min, nowTime.sec)

			nowTime = GameUtil.time2date(timestamp)
		end
	end

	local nowNum = nowTime.year * 10000 + nowTime.month * 100 + nowTime.day
	local count = checknumber(self._rechargeInfos.rechargeInfos[nowNum])

	if count == 0 then
		return 0
	end

	return count / 100
end

function DoubleElevenModel:getSatisfyRechargeCount(money)
	if self._rechargeInfos == nil or self._rechargeInfos.rechargeInfos == nil then
		return 0
	end

	local actId = DoubleElevenConfig.instance:getDaysRechargeActivityId()
	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.DaysRecharge, actId)

	if actCfg == nil or string.nilorempty(actCfg.startTime) or string.nilorempty(actCfg.endTime) then
		return
	end

	local startDate, endDate = GameUtil.string2date(actCfg.startTime), GameUtil.string2date(actCfg.endTime)
	local startNum = startDate.year * 10000 + startDate.month * 100 + startDate.day
	local endNum = endDate.year * 10000 + endDate.month * 100 + endDate.day
	local count = 0

	money = money * 100

	for k, v in pairs(self._rechargeInfos.rechargeInfos) do
		if k and v and startNum <= k and k <= endNum and money <= v then
			count = count + 1
		end
	end

	return count
end

function DoubleElevenModel:isRechargeItemReceive(itemId)
	if self._rechargeInfos == nil or self._rechargeInfos.gainItemIds == nil then
		return false
	end

	return table.indexof(self._rechargeInfos.gainItemIds, itemId)
end

function DoubleElevenModel:getRechargeItemState(money, itemId)
	local count = self:getSatisfyRechargeCount(money)

	if count < 1 then
		return 0
	end

	local list = DoubleElevenConfig.instance:getDaysRechargeMoneyCfgs(money)

	if list == nil or #list == 0 then
		return 0
	end

	local cfg

	for i = 1, #list do
		if list[i] and list[i].itemId == itemId then
			cfg = list[i]

			break
		end
	end

	if cfg == nil or count < cfg.rechargeDays then
		return 0
	end

	local isReceive = self:isRechargeItemReceive(itemId)

	if isReceive then
		return 2
	end

	return 1
end

function DoubleElevenModel:getSeckillZoneTabList()
	local allList = DoubleElevenConfig.instance:getSeckillZoneTabCfgs()

	if allList == nil then
		return nil
	end

	local tempList = {}

	for k, v in pairs(allList) do
		local strs = string.split(v.secondSaleTimeRange, "-")
		local params = {}

		params.strStart = strs[1]
		params.strEnd = strs[2]
		params.stage = GameUtil.getTimePeriodType(strs[1], strs[2], true)
		params.secondSalePlanId = v.secondSalePlanId
		params.tabName = v.tabName

		table.insert(tempList, params)
	end

	ArraySort.sortOn(tempList, "secondSalePlanId", ArraySort.NUMERIC)

	return tempList
end

function DoubleElevenModel:getSeckillZoneBuyCount(planId, itemId)
	if self._seckillInfos == nil or self._seckillInfos[planId] == nil then
		return nil
	end

	return self._seckillInfos[planId][itemId]
end

function DoubleElevenModel:setSeckillZoneCustomOpens()
	return
end

function DoubleElevenModel:getFreeZoneBuyInfo(itemId)
	if self._freeInfos ~= nil and self._freeInfos.itemInfo ~= nil and self._freeInfos.itemInfo[itemId] ~= nil then
		return self._freeInfos.itemInfo[itemId]
	end
end

function DoubleElevenModel:getFreeZoneFreeRanks()
	if self._freeInfos == nil or self._freeInfos.freeCountRank == nil then
		return {}
	end

	return self._freeInfos.freeCountRank
end

function DoubleElevenModel:getFreeZoneLuckyRanks()
	if self._freeInfos == nil or self._freeInfos.luckyRank == nil then
		return {}
	end

	return self._freeInfos.luckyRank
end

function DoubleElevenModel:csSendDaysRechargeGetInfo(msg)
	self._rechargeInfos = nil
	msg = msg or {}
	self._rechargeInfos = {
		gainItemIds = {},
		rechargeInfos = {}
	}

	for _, id in pairs(msg.gainItemIds or {}) do
		if id and checknumber(id) > 0 then
			table.insert(self._rechargeInfos.gainItemIds, id)
		end
	end

	for _, info in pairs(msg.rechargeInfos or {}) do
		if info and info.dateId and checknumber(info.money) > 0 then
			self._rechargeInfos.rechargeInfos[info.dateId] = info.money
		end
	end
end

function DoubleElevenModel:csSendDaysRechargeGainPrize(params)
	if params == nil or params.itemId == nil then
		return
	end

	if self._rechargeInfos == nil then
		self._rechargeInfos = {
			gainItemIds = {},
			rechargeInfos = {}
		}
	end

	self._rechargeInfos.gainItemIds = self._rechargeInfos.gainItemIds or {}

	table.insert(self._rechargeInfos.gainItemIds, params.itemId)
end

function DoubleElevenModel:csSendSecondSaleInfo(msg)
	self._seckillInfos = self._seckillInfos or {}

	if msg == nil or msg.itemList == nil then
		return
	end

	self._seckillInfos[msg.planId] = {}

	for _, info in pairs(msg.itemList or {}) do
		if info and info.itemId then
			self._seckillInfos[msg.planId][info.itemId] = info
		end
	end
end

function DoubleElevenModel:csSendSecondSaleBuy(params)
	if params == nil or params.itemId == nil then
		return
	end

	self._seckillInfos = self._seckillInfos or {}
	self._seckillInfos[params.planId] = self._seckillInfos[params.planId] or {}
	self._seckillInfos[params.planId][params.itemId] = self._seckillInfos[params.planId][params.itemId] or {}
	self._seckillInfos[params.planId][params.itemId].spaceBuyTimes = checknumber(self._seckillInfos[params.planId][params.itemId].spaceBuyTimes) + 1
	self._seckillInfos[params.planId][params.itemId].personBuyTimes = checknumber(self._seckillInfos[params.planId][params.itemId].personBuyTimes) + 1
end

function DoubleElevenModel:csSendFreePayStoreGetInfo(msg)
	self._freeInfos = nil

	if msg == nil or msg.activityId == nil then
		return
	end

	self._freeInfos = {
		itemInfo = {},
		freeCountRank = {},
		luckyRank = {}
	}

	for _, info in pairs(msg.itemInfo or {}) do
		if info and info.itemId then
			self._freeInfos.itemInfo[info.itemId] = info
		end
	end

	self._freeInfos.freeCountRank = GameUtil.pbToTable(msg.freeCountRank or {})
	self._freeInfos.luckyRank = GameUtil.pbToTable(msg.luckyRank or {})
end

function DoubleElevenModel:csSendFreePayStoreBuy(msg)
	self._freeInfos = self._freeInfos or {}
	self._freeInfos.itemInfo = self._freeInfos.itemInfo or {}
	self._freeInfos.itemInfo[msg.item.itemId] = msg.item
end

function DoubleElevenModel:csSendFreePayStoreGetRanText(msg)
	if msg == nil or msg.activityId == nil then
		return
	end

	self._freeInfos = self._freeInfos or {}
	self._freeInfos.freeCountRank = GameUtil.pbToTable(msg.freeCountRank or {})
	self._freeInfos.luckyRank = GameUtil.pbToTable(msg.luckyRank or {})
end

function DoubleElevenModel:getRechargeTabRedpoint(money)
	local count = self:getSatisfyRechargeCount(money)

	if count < 1 then
		return false
	end

	local list = DoubleElevenConfig.instance:getDaysRechargeMoneyCfgs(money)

	if list == nil or list == 0 then
		return false
	end

	for i = 1, count do
		if list[i] and not self:isRechargeItemReceive(list[i].itemId) then
			return true
		end
	end

	return false
end

DoubleElevenModel.instance = DoubleElevenModel.New()

return DoubleElevenModel
