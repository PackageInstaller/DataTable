-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PettyPay\\ActivityDailyGiftDlg.lua

local ResPettyPayDailyGift = require("ClientData/ResPettyPayDailyGift")
local ResRecharge = require("ClientData/ResRecharge")
local ResRandClient = require("ClientData/ResRandClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResClientNotice = require("ClientData/ResClientNotice")
local EventConst = require("EventConst")
local ResPettyPayTab = require("ClientData/ResPettyPayTab")
local GridAwardContainer = require("UI/Common/Grid/GridAwardContainer")
local ActivityDailyGiftCell = Class("ActivityDailyGiftCell", UIControls.Child)

function ActivityDailyGiftCell:ctor()
	self:initUI()
end

function ActivityDailyGiftCell:initUI(...)
	self.btnEnter = UIControls.Button(self, "")

	self.btnEnter:addEventClick(self.onBtnEnterClick)

	self.txtLimit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.txtPrice = UIControls.Label(self, "ContentPanel/TitlePanel/PricePanel/TextPrice")
	self.imgState = UIControls.Image(self, "ContentPanel/TitlePanel/ImgState")
	self.txtLimit = UIControls.Label(self, "ContentPanel/TextLimit")

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "ContentPanel/TitlePanel/PricePanel/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "ContentPanel/TitlePanel/PricePanel/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function ActivityDailyGiftCell:initData(data, index)
	self.data = data

	if data and data.recharge_id then
		local rechargeId = data.recharge_id
		local rechargeData = ResRecharge[rechargeId]

		if rechargeData then
			local productName = rechargeData.product_name
			local costMoney = rechargeData.cost_money

			if costMoney then
				self.txtPrice:setText(costMoney / 100)
			end

			local randId = rechargeData.rand_id

			if randId and ResRandClient[randId] then
				local randData = ResRandClient[randId]

				self.itemGrids = {}

				local num = math.min(4, #randData.show_ids)

				for i = 1, num do
					self.itemId = randData.show_ids[i]
					self.itemNum = randData.show_nums[i]

					if not self.itemGrids[i] then
						if i == 1 then
							self.itemGrids[i] = GridAwardContainer(self, "ContentPanel/AwardSpecialPanel", "System/Activity/ActivityPettyPay/GridAwardDailyGiftContainer")
						else
							self.itemGrids[i] = GridAwardContainer(self, "ContentPanel/AwardPanel", "System/Activity/ActivityPettyPay/GridAwardDailyGiftContainer")
						end

						self.itemGrids[i]:setVisible(true)
					end

					local item = BaseObject.GetObject(self.itemId, self.itemNum)

					self.itemGrids[i]:setObj(item)
					self.itemGrids[i]:hideTxtNum()
					self.itemGrids[i].txtPettyPayNum:setText(self.itemNum)
					self.itemGrids[i].grid:onConfigHideQuality()
					self.itemGrids[i].grid:hideTextNum(true)
					self.itemGrids[i].grid:onConfigHideBg()

					self.itemGrids[i].grid.mDisableWays = true
					self.itemGrids[i].grid.mEnableTips = true
					self.itemGrids[i].grid.mEventClick = self.slotOfClickGrid
				end
			end

			if rechargeData.mark_path and rechargeData.mark_name then
				self.imgState:setVisible(true)
				self.imgState:setImage(rechargeData.mark_path, rechargeData.mark_name)
			else
				self.imgState:setVisible(false)
			end

			local canBuyCount = rechargeData.can_buy_count
			local svrData = RechargeManager._gameProducts[rechargeId]

			if canBuyCount and svrData and svrData.can_buy_count then
				local remainCount = svrData.can_buy_count
				local txt = utils.format(Lang.get(89947), remainCount, canBuyCount)

				self.txtLimit:setText(txt)
			end
		end
	end

	self:refreshUI()
end

function ActivityDailyGiftCell:refreshUI(...)
	if self.data then
		local rechargeId = self.data.recharge_id

		if rechargeId then
			local product = RechargeManager.getProductByRechargeId(rechargeId)

			if product then
				local leftNum = product.buyTimesLeft
				local maxNum = product.buyTimesMax

				if leftNum and maxNum then
					local txt = utils.format(Lang.get(89947), leftNum, maxNum)

					self.txtLimit:setText(txt)
				end
			end
		end
	end
end

function ActivityDailyGiftCell:onBtnEnterClick(...)
	if self.data then
		local rechargeId = self.data.recharge_id

		if rechargeId then
			local product = RechargeManager.getProductByRechargeId(rechargeId)

			if product and product and product:isProductValid() then
				local ui = UIManager.getUI("giftBuyBox", true)

				ui:showShopItem(product, self)
				ui:setOrder(self.mParent:getOrder() + 1000)

				if ui and ui.txtPettyPayTips then
					ui.txtPettyPayTips:setVisible(true)
				end
			end
		end
	end
end

local strClassName = "ActivityDailyGiftDlg"
local ActivityDailyGiftDlg = Class(strClassName, UIControls.Window)

function ActivityDailyGiftDlg:ctor()
	self:initUI()
end

function ActivityDailyGiftDlg:initUI()
	self.txtPrice = UIControls.Label(self, "MainInfoPanel/BtnDoubleBuy/PricePanel/TextPrice")
	self.txtOldPrice = UIControls.Label(self, "MainInfoPanel/BtnDoubleBuy/PrimePricePanel/TextPrice")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnDoubleBuy = UIControls.Button(self, "MainInfoPanel/BtnDoubleBuy")

	self.btnDoubleBuy:addEventClick(self.onBtnDoubleBuyClick)

	self.btnDoubleBuyDis = UIControls.Button(self, "MainInfoPanel/BtnDoubleBuyDis")

	self.btnDoubleBuyDis:addEventClick(self.onBtnDoubleBuyDisClick)

	self.txtDisPrice = UIControls.Label(self, "MainInfoPanel/BtnDoubleBuyDis/PricePanel/TextPrice")
	self.txtDisOldPrice = UIControls.Label(self, "MainInfoPanel/BtnDoubleBuyDis/PrimePricePanel/TextPrice")

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "MainInfoPanel/BtnDoubleBuyDis/PricePanel/TextPt") then
		self.priceDisDmmPanel = UIControls.Panel(self, "MainInfoPanel/BtnDoubleBuyDis/PricePanel/TextPt")

		self.priceDisDmmPanel:setVisible(true)
	end

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "MainInfoPanel/BtnDoubleBuyDis/PrimePricePanel/TextPt") then
		self.priceDisOldDmmPanel = UIControls.Panel(self, "MainInfoPanel/BtnDoubleBuyDis/PrimePricePanel/TextPt")

		self.priceDisOldDmmPanel:setVisible(true)
	end

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "MainInfoPanel/BtnDoubleBuy/PricePanel/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "MainInfoPanel/BtnDoubleBuy/PricePanel/TextPt")

		self.priceDmmPanel:setVisible(true)
	end

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "MainInfoPanel/BtnDoubleBuy/PrimePricePanel/TextPt") then
		self.priceOldDmmPanel = UIControls.Panel(self, "MainInfoPanel/BtnDoubleBuy/PrimePricePanel/TextPt")

		self.priceOldDmmPanel:setVisible(true)
	end

	self.cellGifts = {}
	self._slot4ProductLoaded = Slot(self.refreshUI, self)

	EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

local const_Gift_Type = {
	special = 2,
	normal = 1
}

local function stringSplitTonumber(longString)
	local splittedData = utils.splitString(tostring(longString), ",")

	for index = 1, #splittedData do
		splittedData[index] = tonumber(splittedData[index])
	end

	return splittedData
end

function ActivityDailyGiftDlg:initData(resData, svrData)
	self.resData = ResPettyPayTab[3]
	self.svrData = svrData

	if self.resData and self.resData.arg1 then
		local arg = self.resData.arg1
		local data = stringSplitTonumber(arg)

		if data then
			local numForItems = 1

			for index, id in pairs(data) do
				local giftData = ResPettyPayDailyGift[id]

				if giftData then
					if giftData.type == const_Gift_Type.normal then
						local newCell

						if numForItems == 1 then
							newCell = ActivityDailyGiftCell(self, "MainInfoPanel/DailyGiftList/Content", "System/Activity/ActivityPettyPay/GridDailyGift")
							numForItems = numForItems + 1
						else
							newCell = ActivityDailyGiftCell(self, "MainInfoPanel/DailyGiftList/Content", "System/Activity/ActivityPettyPay/GridDailyGift01")
						end

						newCell:setVisible(true)
						newCell:initData(giftData, index)
						table.insert(self.cellGifts, newCell)
					elseif giftData.type == const_Gift_Type.special then
						self:setSpecialGiftUi(giftData)
					end
				end
			end
		end
	end

	self:refreshUI()
end

function ActivityDailyGiftDlg:refreshUI()
	local flag = true

	if self.cellGifts and #self.cellGifts ~= 0 then
		for i = 1, #self.cellGifts do
			local data = self.cellGifts[i].data

			if data then
				local rechargeId = data.recharge_id

				if rechargeId then
					local product = RechargeManager.getProductByRechargeId(rechargeId)

					if product and product.buyTimesLeft and product.buyTimesLeft == 0 then
						self.cellGifts[i].btnEnter:setEnable(false)
						self.cellGifts[i]:refreshUI()

						flag = false
					end
				end
			end

			if flag == true then
				self.btnDoubleBuyDis:setVisible(false)
				self.btnDoubleBuy:setVisible(true)
			else
				self.btnDoubleBuy:setVisible(false)
				self.btnDoubleBuyDis:setVisible(true)
			end
		end
	end
end

function ActivityDailyGiftDlg:setResData(resData)
	return
end

function ActivityDailyGiftDlg:setSpecialGiftUi(giftData)
	if not giftData then
		return
	end

	self.specialGiftData = giftData

	local rechargeId = giftData.recharge_id

	if rechargeId then
		local rechargeData = ResRecharge[rechargeId]

		if rechargeData then
			local costMoney = rechargeData.cost_money

			if costMoney then
				self.txtDisPrice:setText(costMoney / 100)
				self.txtPrice:setText(costMoney / 100)
			end

			local originalMoney = rechargeData.original_money

			if originalMoney then
				self.txtOldPrice:setText(originalMoney / 100)
				self.txtDisOldPrice:setText(originalMoney / 100)
			end
		end
	end
end

function ActivityDailyGiftDlg:onBtnDoubleBuyClick()
	if self.specialGiftData then
		local rechargeId = self.specialGiftData.recharge_id

		if rechargeId then
			local product = RechargeManager.getProductByRechargeId(rechargeId)

			if product and product and product:isProductValid() then
				self._curItem = product

				self:onItemBuy(rechargeId)
			end
		end
	end
end

function ActivityDailyGiftDlg:onItemBuy(rechargeId)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, rechargeId)
	self:realBuy(rechargeId)
end

function ActivityDailyGiftDlg:realBuy(rechargeId)
	local _rechargeId = rechargeId
	local rechargeArgs

	if self._curItem.special then
		rechargeArgs = {
			special = self._curItem.special
		}
	end

	if self.actObj then
		CurAvatar:activityRPC(Functor(RechargeManager.startRecharge, _rechargeId, rechargeArgs, nil), self.actObj.opId)
	else
		RechargeManager.startRecharge(_rechargeId, rechargeArgs, nil)
	end
end

function ActivityDailyGiftDlg:onClose()
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
	ActivityDailyGiftDlg.super.onClose(self)
end

function ActivityDailyGiftDlg:onBtnCloseClick()
	self:setVisible(false)
end

function ActivityDailyGiftDlg:onDestroy(...)
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
	ActivityDailyGiftDlg.super.onDestroy(self)
end

function ActivityDailyGiftDlg:onBtnDoubleBuyDisClick()
	local resData = ResClientNotice[721]

	if resData then
		local hint = resData.notice

		if hint then
			MsgManager.notice(hint)
		end
	end
end

return ActivityDailyGiftDlg
