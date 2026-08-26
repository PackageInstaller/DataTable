-- chunkname: @modules/logic/room/model/trade/RoomDailyOrderMo.lua

module("modules.logic.room.model.trade.RoomDailyOrderMo", package.seeall)

local RoomDailyOrderMo = class("RoomDailyOrderMo")

function RoomDailyOrderMo:ctor()
	self.orderId = nil
	self.lastRefreshTime = nil
	self.buyerId = nil
	self.goodsInfo = nil
	self.isAdvanced = nil
	self.isTraced = nil
	self.waitRefresh = nil
	self.refreshType = nil
	self.isLocked = nil
	self.isFinish = nil
end

function RoomDailyOrderMo:initMo(info, isNewRefresh)
	self.orderId = info.orderId
	self.lastRefreshTime = info.lastRefreshTime
	self.buyerId = info.buyerId
	self.isAdvanced = info.isAdvanced
	self.isTraced = info.isTraced
	self.refreshType = info.refreshType
	self.isLocked = info.isLocked
	self.goodsInfo = {}
	self._orderPrice = 0

	for i = 1, #info.goodsInfo do
		local mo = RoomProductionMo.New()

		mo:initMo(info.goodsInfo[i])
		table.insert(self.goodsInfo, mo)

		self._orderPrice = self._orderPrice + mo:getOrderPrice()
	end

	local rate = self:getAdvancedRate()

	if self.isAdvanced then
		self._orderPrice = self._orderPrice * rate
	end

	self.isNewRefresh = isNewRefresh
	self.waitRefresh = nil
	self._orderCo = RoomTradeConfig.instance:getOrderQualityInfo(self.orderId)
	self.isFinish = false
end

function RoomDailyOrderMo:getAdvancedRate()
	local rate = RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DailyHighOrderAddRate, true) or 0

	return 1 + rate * 0.0001
end

function RoomDailyOrderMo:setFinish()
	self.isFinish = true
end

function RoomDailyOrderMo:getPrice()
	return self._orderCo.co.price
end

function RoomDailyOrderMo:getPriceCount()
	return GameUtil.numberDisplay(self._orderPrice)
end

function RoomDailyOrderMo:setWaitRefresh(isWait)
	self.waitRefresh = isWait
end

function RoomDailyOrderMo:isWaitRefresh()
	return self.waitRefresh
end

function RoomDailyOrderMo:cancelNewRefresh()
	self.isNewRefresh = false
end

function RoomDailyOrderMo:setTraced(isTraced)
	self.isTraced = isTraced
end

function RoomDailyOrderMo:setLocked(isLocked)
	self.isLocked = isLocked
end

function RoomDailyOrderMo:getLocked()
	return self.isLocked
end

function RoomDailyOrderMo:checkGoodsCanProduct()
	local wrongTip, findBuildingUid

	for _, info in ipairs(self.goodsInfo) do
		local hasBuilding = info:isPlacedProduceBuilding()

		if hasBuilding then
			if string.nilorempty(wrongTip) or not findBuildingUid then
				local needUpgrade, buildingUid = info:checkProduceBuildingLevel()

				if needUpgrade then
					wrongTip = luaLang("room_produce_building_need_upgrade")
					findBuildingUid = buildingUid
				end
			end
		else
			wrongTip = luaLang("room_no_produce_building")
			findBuildingUid = nil

			break
		end
	end

	return wrongTip, findBuildingUid
end

function RoomDailyOrderMo:isCanConfirm()
	for _, info in ipairs(self.goodsInfo) do
		if not info:isEnoughCount() then
			return false
		end
	end

	return true
end

function RoomDailyOrderMo:getRefreshTime()
	local time = 0

	if self.lastRefreshTime and self.refreshType == RoomTradeEnum.RefreshType.ActiveRefresh then
		local sec = ServerTime.now() - self.lastRefreshTime
		local value = RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DailyOrderRefreshTime, true)

		time = value - sec
	end

	return time
end

function RoomDailyOrderMo:getGoodsInfo()
	return self.goodsInfo
end

return RoomDailyOrderMo
