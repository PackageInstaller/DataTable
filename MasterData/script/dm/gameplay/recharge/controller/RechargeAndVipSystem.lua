-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recharge/controller/RechargeAndVipSystem.lua

require("dm.gameplay.recharge.model.RechargeAndVipModel")

EVT_DIAMOND_RECHARGE_SUCC = "EVT_DIAMOND_RECHARGE_SUCC"
EVT_ONCLICK_CHECKVIP = "EVT_ONCLICK_CHECKVIP"
EVT_BUY_MONTHCARD_SUCC = "EVT_BUY_MONTHCARD_SUCC"
EVT_REFRESH_MONTHCARD = "EVT_REFRESH_MONTHCARD"
EVT_CHARGETASK_FIN = "EVT_CHARGETASK_FIN"
EVT_FefreshForeverCard = "EVT_FefreshForeverCard"
EVT_BUY_ACTIVITY_PAY_SUCC = "EVT_BUY_ACTIVITY_PAY_SUCC"
RechargeAndVipSystem = class("RechargeAndVipSystem", legs.Actor)

RechargeAndVipSystem:has("_rechargeAndVipService", {
	is = "r"
}):injectWith("RechargeAndVipService")
RechargeAndVipSystem:has("_rechargeAndVipModel", {
	is = "r"
}):injectWith("RechargeAndVipModel")
RechargeAndVipSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
RechargeAndVipSystem:has("_vipRewardRedPoint", {
	is = "rw"
})

function RechargeAndVipSystem:initialize()
	super.initialize(self)

	self._itemPurchaseStamp = {}
end

function RechargeAndVipSystem:syncVipCanGetRewards()
	self._vipRewardRedPoint = {}

	local developSystem = self:getInjector():getInstance("DevelopSystem")
	local curVipLevel = developSystem:getPlayer():getVipLevel()
	local maxVipLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_MaxVIPLevel", "content")

	for i = 1, maxVipLevel do
		if curVipLevel < i then
			self._vipRewardRedPoint[i] = false
		else
			local rewardState = self:getVipRewardInfo(i)

			self._vipRewardRedPoint[i] = not rewardState
		end
	end
end

function RechargeAndVipSystem:refreshVipRewardRedPoint(index)
	if self._vipRewardRedPoint[index] then
		self._vipRewardRedPoint[index] = false
	end
end

function RechargeAndVipSystem:showVipRewardRedPoint(index)
	for i = 1, index do
		if self._vipRewardRedPoint[i] then
			return true
		end
	end

	return false
end

function RechargeAndVipSystem:getRechargeGoodsList()
	return (self._rechargeAndVipModel:getRechargeGoodsList())
end

function RechargeAndVipSystem:getRechargeGoodsModelByIndex(index)
	local goodsList = self._rechargeAndVipModel:getRechargeGoodsList()

	return goodsList[index]
end

function RechargeAndVipSystem:getRechargeGoodsCapacity()
	local goodsList = self._rechargeAndVipModel:getRechargeGoodsList()

	return #goodsList
end

function RechargeAndVipSystem:getVipRewardInfo(index)
	local rewardList = self._rechargeAndVipModel:getVipRewards()

	if rewardList then
		return rewardList[index]
	end

	return nil
end

function RechargeAndVipSystem:synchronizeRechargeAndVipInfo(data)
	self._rechargeAndVipModel:synchronizeModel(data)
end

function RechargeAndVipSystem:synchronizeVipRewards(data)
	self._rechargeAndVipModel:synchronizeVipRewards(data)
end

function RechargeAndVipSystem:getNeedDiamond(viplevel)
	return (ConfigReader:getDataByNameIdAndKey("Vip", viplevel, "NeedDiamond"))
end

function RechargeAndVipSystem:getVipNeedDiamond(viplevel)
	local diamond = ConfigReader:getDataByNameIdAndKey("Vip", tostring(viplevel), "NeedDiamond")
	local recharge = self._rechargeAndVipModel:getRechargeHistory()

	return diamond - recharge
end

function RechargeAndVipSystem:hasMCRedPoint()
	local cardList = self._rechargeAndVipModel:getMonthCardList()

	if cardList then
		for i = 1, #cardList do
			local cardData = cardList[i]
			local lastTime = cardData:getLastRewardTimes()

			if self:hasMCRedPointByLastTime(lastTime) then
				return true
			end
		end
	end

	return false
end

function RechargeAndVipSystem:getRemainDaysForSubscribe()
	local subscribeIsPurchased = self._rechargeAndVipModel:getIsPurchased()
	local subscribeEndTime = self._rechargeAndVipModel:getEndTime()
	local subscribeType = self._rechargeAndVipModel:getType()
	local curTime = self._gameServerAgent:remoteTimeMillis()
	local oneDaySec = 86400000
	local leaveTime = subscribeEndTime - curTime
	local dayNum = 0

	dayNum = math.floor(leaveTime / oneDaySec)
	dayNum = math.max(dayNum, 0)

	return dayNum
end

function RechargeAndVipSystem:getRemainDays(monthCardId)
	local monthCardId = monthCardId or KMonthCardType.KMonthCard
	local data = self._rechargeAndVipModel:getMonthCardMap()[monthCardId]
	local curTime = self._gameServerAgent:remoteTimeMillis()
	local oneDaySec = 86400000
	local leaveTime = data._endTimes - curTime
	local dayNum = 0

	dayNum = self:hasMCRedPointByLastTime(data._lastRewardTimes) and math.ceil(leaveTime / oneDaySec) or math.floor(leaveTime / oneDaySec)
	dayNum = math.max(dayNum, 0)

	return dayNum
end

function RechargeAndVipSystem:getCanContinueBuy(monthCardId)
	local monthCardId = monthCardId or KMonthCardType.KMonthCard
	local data = self._rechargeAndVipModel:getMonthCardMap()[monthCardId]
	local curTime = self._gameServerAgent:remoteTimeMillis()

	if data._endTimes > curTime + data._time * data._renewalTimes * 86400000 then
		return false
	end

	return true
end

function RechargeAndVipSystem:getGotStatus(monthCardId)
	local monthCardId = monthCardId or KMonthCardType.KMonthCard
	local data = self._rechargeAndVipModel:getMonthCardMap()[monthCardId]

	if data._endTimes == -1 then
		-- block empty
	end

	return true
end

function RechargeAndVipSystem:getCanBuyMC(monthCardId)
	local monthCardId = monthCardId or KMonthCardType.KMonthCard

	if not self:getGotStatus(monthCardId) then
		return true
	end

	if self:getCanContinueBuy(monthCardId) then
		return true
	end

	return false
end

function RechargeAndVipSystem:hasMCRedPointByLastTime(lastTime)
	local curTime = self._gameServerAgent:remoteTimeMillis()
	local leaveTime = curTime - lastTime
	local baseTime = {
		sec = 0,
		min = 0,
		hour = 5
	}
	local isSameDay = TimeUtil:isSameDay(lastTime / 1000, curTime / 1000, baseTime)

	if not isSameDay and leaveTime > 0 and lastTime > -1 then
		return true
	end

	return false
end

function RechargeAndVipSystem:delMonthCards(data)
	for k, v in pairs(data) do
		self._rechargeAndVipModel:delMonthCard(k)
	end
end

function RechargeAndVipSystem:getMonthCardName(id)
	local nameStr = ""
	local mcMap = self._rechargeAndVipModel:getMonthCardMap()

	if mcMap and mcMap[id] then
		local name = mcMap[id]:getName()

		nameStr = Strings:get(name)
	end

	return nameStr
end

function RechargeAndVipSystem:getVipRule()
	return (ConfigReader:getDataByNameIdAndKey("ConfigValue", "Charge_Rule", "content"))
end

function RechargeAndVipSystem:checkPurchaseCD(goodsId)
	local curTime = self._gameServerAgent:remoteTimestamp()
	local cd = CommonUtils.GetPurchaseCD()

	if cd > 0 then
		if self._itemPurchaseStamp[goodsId] then
			local remainTime = math.ceil(self._itemPurchaseStamp[goodsId] + cd - curTime)

			if remainTime > 0 then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("ShopPurchaseCDTip", {
						num = remainTime
					})
				}))

				return false
			end
		end

		self._itemPurchaseStamp[goodsId] = curTime
	end

	return true
end

local perTime = 0

function RechargeAndVipSystem:requestRechargeDiamonds(goodsId)
	local curTime = self._gameServerAgent:remoteTimestamp()

	if curTime - perTime < 0.5 then
		return
	end

	perTime = curTime

	if not self:checkPurchaseCD(goodsId) then
		return
	end

	local params = {
		mallId = goodsId
	}

	self._rechargeAndVipService:rechargeDiamonds(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			local payOffSystem = self:getInjector():getInstance(PayOffSystem)

			payOffSystem:payOffToSdk(response.data)
		end
	end)
end

function RechargeAndVipSystem:requestBuyVipReward(vipLevel, callback)
	local params = {
		vipLevel = vipLevel
	}

	self._rechargeAndVipService:requestBuyVipReward(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data.reward)
		end
	end)
end

function RechargeAndVipSystem:requestPurchaseSubscribe(cardId, isRecover, index)
	local curTime = self._gameServerAgent:remoteTimestamp()

	if curTime - perTime < 0.5 then
		return
	end

	perTime = curTime

	local params = {
		bizId = cardId
	}

	self._rechargeAndVipService:requestPurchaseSubscribe(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			local payOffSystem = self:getInjector():getInstance(PayOffSystem)

			payOffSystem:payOffToSdk(response.data, isRecover)
		end
	end)
end

function RechargeAndVipSystem:requestBuyMonthCard(cardId, index)
	local curTime = self._gameServerAgent:remoteTimestamp()

	if curTime - perTime < 0.5 then
		return
	end

	perTime = curTime

	if not self:checkPurchaseCD(cardId) then
		return
	end

	local params = {
		cardId = cardId
	}

	self._rechargeAndVipService:requestBuyMonthCard(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			local payOffSystem = self:getInjector():getInstance(PayOffSystem)

			payOffSystem:payOffToSdk(response.data)
		end
	end)
end

function RechargeAndVipSystem:requestObtainMCReward(cardId, index)
	local params = {
		cardId = cardId
	}

	self._rechargeAndVipService:requestObtainMCReward(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_BUY_MONTHCARD_SUCC, {
				index = index,
				reward = response.data.reward
			}))
		end
	end)
end

function RechargeAndVipSystem:requestRefreshMonthCard(callback)
	local params = {}

	self._rechargeAndVipService:requestRefreshMonthCard(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback()
		end
	end)
end

function RechargeAndVipSystem:doReset(resetId, value)
	value = value or 0

	if resetId == ResetId.kMonthCard then
		self:dispatch(Event:new(EVT_REFRESH_MONTHCARD))
	end
end

function RechargeAndVipSystem:requestGetFirstRechargeReward(callback)
	local params = {}

	self._rechargeAndVipService:requestGetFirstRechargeReward(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data.firstChargeReward)
		end
	end)
end

function RechargeAndVipSystem:requestGetAccRechargeReward(chargeNum, callback)
	local params = {}

	params.chargeNum = chargeNum

	self._rechargeAndVipService:requestGetAccRechargeReward(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data.reward)
		end
	end)
end

function RechargeAndVipSystem:requestBuyForeverCard(callback)
	if not self:checkPurchaseCD("ForeverCard") then
		return
	end

	local params = {}

	self._rechargeAndVipService:requestBuyForeverCard(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response.data)
			end

			local payOffSystem = self:getInjector():getInstance(PayOffSystem)

			payOffSystem:payOffToSdk(response.data)
		end
	end)
end

function RechargeAndVipSystem:requestFCardWeekReward(callback)
	local params = {}

	self._rechargeAndVipService:requestFCardWeekReward(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response.data)
			end

			if response.data.reward then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					needClick = true,
					rewards = response.data.reward
				}))
			end

			self:dispatch(Event:new(EVT_FefreshForeverCard))
		end
	end)
end

function RechargeAndVipSystem:requestFCardStaminaReward(callback, powerCount)
	local params = {}

	self._rechargeAndVipService:requestFCardStaminaReward(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response.data)
			end

			local rewards = {
				{
					type = 2,
					code = "IR_Power",
					amount = powerCount
				}
			}
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				needClick = true,
				rewards = rewards
			}))
			self:dispatch(Event:new(EVT_FefreshForeverCard))
		end
	end)
end

function RechargeAndVipSystem:requestFefreshForeverCard(callback)
	local params = {}

	self._rechargeAndVipService:requestFefreshForeverCard(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response.data)
			end

			self:dispatch(Event:new(EVT_FefreshForeverCard))
		end
	end)
end
