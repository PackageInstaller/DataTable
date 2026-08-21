-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/monthcard/StoreMonthCardView.lua

module("logic.extensions.store.view.monthcard.StoreMonthCardView", package.seeall)

local M = class("StoreMonthCardView", ViewComponent)

function M:buildUI()
	self._monthCardObj = self:getGo("store_main_view_copy_137043370")
	self._txtMonthCardName = self:getText("store_main_view_copy_1759411565")
	self._txtResidueTime = self:getText("store_main_view_copy_1563770651")
	self._willGetMothyCardTime = self:getText("store_main_view_copy_-788179395")
	self._txtAccumulated = self:getText("store_main_view_copy_1045918652")
	self._txtPrice = self:getText("store_main_view_copy_852139182")
	self._txtImmediateNum = self:getText("store_main_view_copy_315089298")
	self._txtDailyNum = self:getText("store_main_view_copy_1706100419")
	self._btnBuyMonth = self:getBtn("store_main_view_copy_1567375731")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnBuyMonth:AddClickListener(self._onClickBuyMothyCard, self)
	GlobalDispatcher:addEventListener(EventType.REFRESH_MONTH_CARD_DATA, self._onRefreshMonthCard, self)
end

function M:unbindEvents()
	self._btnBuyMonth:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.REFRESH_MONTH_CARD_DATA, self._onRefreshMonthCard, self)
end

function M:onEnter()
	StoreMainFacade.instance:registerView(self)
end

function M:onExit()
	return
end

function M:_onRefreshMonthCard(key, goodsMo)
	self._selectGoodsId = goodsMo:getGoodsId()

	if not self._isActive then
		return
	end

	self:_initMothyCard(goodsMo)
end

function M:_initMothyCard(data)
	self._curMonthMo = data
	self._txtMonthCardName.text = data:getName()
	self._txtResidueTime.text = langF("tip_store_monthcard_remaining", data:getRemainedDay())
	self._txtPrice.text = langF("tip_store_price", data:getPrice())
	self._willGetMothyCardTime.text = langF("tip_store_monthcard_add_day", data:getEffectiveDays())

	local dailyRewardStr = data:getDailyReward()
	local rewardStr = data:getReward()
	local dailyReward = StoreUtil.formatText(dailyRewardStr)
	local reward = StoreUtil.formatText(rewardStr)

	self._monthyCardDailyReward = dailyReward
	self._monthyCardReward = reward

	local rewardStr = ""

	for index, reward in ipairs(dailyReward) do
		local itemCo = BackpackConfig.instance:getItemInfoByItemId(reward.itemId)

		if itemCo then
			local totalDays = data:getRemainedDay() + data:getEffectiveDays()

			rewardStr = rewardStr .. string.format("x%s%s", reward.num * totalDays, itemCo.name)
		end
	end

	self._txtAccumulated.text = langF("tip_store_cangettotal", rewardStr)
end

function M:_onClickBuyMothyCard()
	if self._curMonthMo then
		local remainedDay = self._curMonthMo:getRemainedDay()
		local totalLimit = self._curMonthMo:getTotalDayLimit()

		if totalLimit < remainedDay + self._curMonthMo:getEffectiveDays() then
			FloatWordMgr.instance:show(lang("tip_store_monthcard_maxday"))

			return
		end

		local _payMoney = self._curMonthMo:getPrice()
		local _coinName = self._curMonthMo:getName()
		local _moreCharge = 0
		local _payType = 0
		local _productName = self._curMonthMo:getName()
		local _coinsAmount = 1
		local _rate = 10
		local _platformGoodsId = self._curMonthMo:getSdkPayId()
		local _exStr

		StoreAgent.instance:sendBuyGoodsRequestBySDK(self._selectGoodsId, 1, self._tabId, _payMoney, _coinName, _moreCharge, _payType, _productName, _coinsAmount, _rate, _platformGoodsId, _exStr)
	end
end

function M:setVisible(visble)
	self._isActive = visble

	goutil.setActive(self._monthCardObj, visble)
end

return M
