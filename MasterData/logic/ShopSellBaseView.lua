-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mibaoshopsell/view/ShopSellBaseView.lua

module("logic.extensions.mibaoshopsell.view.ShopSellBaseView", package.seeall)

local ShopSellBaseView = class("ShopSellBaseView", ViewComponent)

function ShopSellBaseView:buildUI()
	ShopSellBaseView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._imgBgIcon = self:getGo("imgBgIcon")
	self._items = {}

	for i = 1, 4 do
		local element = {}

		element.go = self:getGo(string.format("itemParent/item%d", i))
		element.icon = self:getGo(string.format("itemParent/item%d/icon", i))
		element.txtNum = self:getTxt(string.format("itemParent/item%d/txtNum", i))

		element.icon:SetActive(true)
		element.txtNum.gameObject:SetActive(true)
		table.insert(self._items, element)
	end

	self._btnBuy = self:getBtn("btnBuy")
	self._txtPrize = self:getTxt("btnBuy/Text")
	self._txtLimit = self:getTxt("limitBuy/txtLimit")
	self._txtTime = self:getTxt("txtTime")
end

function ShopSellBaseView:bindEvents()
	ShopSellBaseView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
end

function ShopSellBaseView:unbindEvents()
	ShopSellBaseView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function ShopSellBaseView:onEnter()
	ShopSellBaseView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)

	local params = self:getOpenParam()

	self._activityType = checkint(params[1])
	self._activityId = checkint(params[2])

	self:_initViewShow(self._activityId)

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isInTime then
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
		local text = "不在活动时间内"

		local function func()
			self:_onClickClose()
		end

		local btnText = "知道了"

		TipsFacade.instance:openTipWindowNoX(lang("tip"), text, func, btnText, UnityEngine.TextAnchor.Middle)

		return
	end

	settimer(1, self._onSecond, self)
end

function ShopSellBaseView:onExit()
	ShopSellBaseView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)
	removetimer(self._onSecond, self)
	self:_resetTimestamp()
end

function ShopSellBaseView:_onClickClose()
	self:close()
end

function ShopSellBaseView:_onClickBuy()
	if not self:_isHaveBuyCount() then
		self._txtPrize.text = "已售罄"

		FloatWordMgr.instance:show("已售罄")

		return
	end

	if self._goodsCfg then
		if not self._goodsCfg.id then
			local id = 0
			local buyTimes = PayShopModel.instance:getMibaoBuyTimesById(self._goodsCfg.id) or 1
			local data = {
				id = id,
				times = buyTimes
			}

			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
		end
	end
end

function ShopSellBaseView:handlePayShopItemBuySucRes(status, msg)
	if status == 0 then
		self:_updateBtnBuyInfo()
	end
end

function ShopSellBaseView:_onSecond()
	self:_updateTimeTxt()
end

function ShopSellBaseView:_initViewShow(activityId)
	local cfg = DirectPurchaseConfig.instance:getSellItemCfgById(activityId)

	if not cfg then
		return
	end

	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfg.shopItemId)

	if not goodsCfg then
		return
	end

	self._goodsCfg = goodsCfg

	local prizes = MaterialMgr.changeItemStrArr(goodsCfg.content)
	local rewardCount = #prizes

	for i = 1, 4 do
		self._items[i].go:SetActive(i <= rewardCount)

		if i <= rewardCount then
			GameUtil.rmClickHandler(self._items[i].icon)
			MaterialMgr.clearIcon(self._items[i].icon)

			if not GameUtil.isEmptyString(prizes[i]) then
				goutil.setActive(self._items[i].go, true)
				MaterialMgr.updateItemByStr(self._items[i].icon, prizes[i])
				GameUtil.addClickHandler(self._items[i].icon, function()
					if self._items and self._items[i] and not goutil.isNil(self._items[i].go) then
						CommonTipsMgr.instance:openTipsByConfStr(self._items[i].go, prizes[i])
					end
				end)

				local matType, matId, matNum = MaterialMgr.getMatParams(prizes[i])

				self._items[i].txtNum.text = matNum <= 1 and "" or "x" .. matNum
			else
				goutil.setActive(self._items[i].go, false)
			end
		end
	end

	self:_updateTimeTxt()
	self:_updateBtnBuyInfo()
end

function ShopSellBaseView:_updateTimeTxt()
	local endTimestamp = self:_getEndTime()
	local leftTime = endTimestamp - ServerTime.now()

	leftTime = leftTime > 0 and leftTime or 0
	self._txtTime.text = "剩余时间：" .. GameUtil.FormatTimeSymbol(leftTime)
end

function ShopSellBaseView:_getEndTime()
	if self._endTimestamp then
		return self._endTimestamp
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self._endTimestamp = endTime

	return self._endTimestamp
end

function ShopSellBaseView:_resetTimestamp()
	self._endTimestamp = nil
end

function ShopSellBaseView:_updateBtnBuyInfo()
	if self._goodsCfg then
		local buyTimes = PayShopModel.instance:getMibaoBuyTimesById(self._goodsCfg.id)

		if self._goodsCfg.limitType ~= "none" then
			local limitTimes = self._goodsCfg.limitTimes
			local leftTime = limitTimes - buyTimes

			leftTime = leftTime >= 0 and leftTime or 0

			if leftTime > 0 then
				if not ColorConst.White then
					local colorStr = ColorConst.Red

					self._txtLimit.text = string.format("每周限购：<color=#%s>%d</color>/%d", colorStr, leftTime, limitTimes)

					GameUtil.SetGray(self._btnBuy, leftTime == 0)

					self._txtPrize.text = leftTime > 0 and PayConfig.instance:getPayMoneyYuan(self._goodsCfg.originalGoodsId) .. "元" or "已售罄"
				end
			end
		else
			GameUtil.SetGray(self._btnBuy, false)
		end
	end
end

function ShopSellBaseView:_isHaveBuyCount()
	if self._goodsCfg then
		local buyTimes = PayShopModel.instance:getMibaoBuyTimesById(self._goodsCfg.id)
		local limitTimes = self._goodsCfg.limitTimes

		return buyTimes < limitTimes
	else
		return false
	end
end

return ShopSellBaseView
