-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\NewcomerBP\\ActivityNewcomerBPGiftPanel.lua

local RechargeManager = require("System/Recharge/RechargeManager")
local ActivityNewcomerBPGiftCell = Class("ActivityNewcomerBPGiftCell", UIControls.Child)
local ShopItem = require("UI/MainState/Trade/ShopItem")

function ActivityNewcomerBPGiftCell:ctor(...)
	self:initUI()
end

function ActivityNewcomerBPGiftCell:ctor()
	self:initUI()
end

function ActivityNewcomerBPGiftCell:initUI(...)
	self.txtDay = UIControls.Label(self, "DayPanel/Text")
	self.btnConfirmFree = UIControls.Button(self, "FreeGiftPanel/BtnConfirm")

	self.btnConfirmFree:addEventClick(self.onBtnFreeClick)

	self.btnConfirmPay = UIControls.Button(self, "PayGiftPanel/BtnConfirm")

	self.btnConfirmPay:addEventClick(self.onBtnPayClick)

	self.pricePanel = UIControls.Image(self, "PricePanel")
	self.txtPrice = UIControls.Label(self, "PricePanel/TextPrice")
	self.txtPt = UIControls.Label(self, "PricePanel/TextPt")
	self.lockPanel = UIControls.Panel(self, "PayGiftPanel/LockPanel")
	self.getPayAwardPanel = UIControls.Panel(self, "PayGiftPanel/GetAwardPanel")
	self.panel = UIControls.Panel(self, "")

	if ChannelUtil.isDMMGame() then
		self.txtPt:setVisible(true)
	end

	self.freeItems = {}
	self.payItems = {}
	self.gridConfig = {}
	self.gridConfig.checkNeedConvertObject = true
end

function ActivityNewcomerBPGiftCell:setData(data, svrData, objGift, rechargeId, index)
	self.actId = self.mParent.actObj.actId
	self.data = data
	self.svrData = svrData
	self.rechargeId = rechargeId
	self.objGift = objGift
	self.state = svrData:getAchieveState(data.type, data.index)

	self.txtDay:setText(data.index)
	self:refreshFreePart()
	self:refreshPayPart(objGift, rechargeId)

	local progress = svrData:getAchieveProgressAndRound(data.type)

	if self.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		self.panel:playStateAnimator("DisNewcomerBPCell", true)
	elseif progress and data.index == progress then
		self.panel:playStateAnimator("HighNewcomerBPCell", true)
	else
		self.panel:playStateAnimator("NmlNewcomerBPCell", true)
	end
end

function ActivityNewcomerBPGiftCell:refreshFreePart()
	for _, gridItem in ipairs(self.freeItems) do
		gridItem:destroy()
	end

	self.freeItems = {}

	ClientUtils.CreateBonusGrid(self, self.freeItems, "FreeGiftPanel/ItemNode", self.data.award, true, nil, true, nil, nil, self.gridConfig)

	for index, grid in ipairs(self.freeItems) do
		grid:setState(false, self.state == Const.ACT_ACHIEVE_STATE_GOT, false)
	end

	self.btnConfirmFree:setVisible(self.state == Const.ACT_ACHIEVE_STATE_ENOUGH)
end

function ActivityNewcomerBPGiftCell:refreshPayPart(objGift, rechargeId)
	self.giftChooseLib = nil
	self.chooseResult = nil

	local clientActCachedData = CurAvatar:getClientActivityCachedData(self.actId)

	self.chooseResult = clientActCachedData[rechargeId] or {}

	for _, gridItem in ipairs(self.payItems) do
		gridItem:destroy()
	end

	self.payItems = {}

	if self.mParent.hasRecharged and self.mParent.hasRecharged ~= 0 then
		self.pricePanel:setVisible(false)
		ClientUtils.CreateBonusGrid(self, self.payItems, "PayGiftPanel/ItemNode", rechargeId, true, 2, true, nil, nil, self.gridConfig)

		local got = self.svrData and self.svrData.serverData and self.svrData.serverData[self.data.type] and self.svrData.serverData[self.data.type].rechargeGot and self.svrData.serverData[self.data.type].rechargeGot[self.data.index]

		self.giftBonusNum = 0

		for index, grid in ipairs(self.payItems) do
			grid:setState(false, got, false)
			grid:setAddMode(false)

			if grid:getVisible() then
				self.giftBonusNum = index
			end
		end

		self.btnConfirmPay:setVisible(self.state ~= Const.ACT_ACHIEVE_STATE_NOT_ENOUGH and not got)
		self.getPayAwardPanel:setVisible(self.btnConfirmPay:getVisible())
	else
		self.getPayAwardPanel:setVisible(false)

		local product = RechargeManager.getProductByRechargeId(rechargeId)

		if not product then
			return
		end

		self.txtPrice:setText(product.priceText)

		local gotRecharge = false
		local buyCount = 0

		if objGift.actData.serverData[rechargeId] then
			buyCount = objGift.actData.serverData[rechargeId].count or 0
		end

		self.canBuyCount = product.buyTimesMax - buyCount

		ClientUtils.CreateBonusGrid(self, self.payItems, "PayGiftPanel/ItemNode", product.randId, true, 2, true, nil, nil, self.gridConfig)

		self.giftBonusNum = 0

		for index, grid in ipairs(self.payItems) do
			grid:setState(false, self.canBuyCount <= 0, false)
			grid:setAddMode(false)

			if grid:getVisible() then
				self.giftBonusNum = index
			end
		end

		if self.canBuyCount > 0 and self.state ~= Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			self.pricePanel:setVisible(true)
			self.lockPanel:setVisible(false)
		else
			self.pricePanel:setVisible(false)
			self.lockPanel:setVisible(true)

			if self.canBuyCount <= 0 then
				self.lockPanel:setVisible(false)
			end
		end

		self.btnConfirmPay:setVisible(self.canBuyCount > 0)
		self:_refreshGiftChoosenState(product)
	end
end

function ActivityNewcomerBPGiftCell:_refreshGiftChoosenState(product)
	product = product or RechargeManager.getProductByRechargeId(self.rechargeId)

	if product and product.selLib and #product.selLib > 0 then
		self.giftChooseLib = product.selLib

		for index = #self.payItems + 1, self.giftBonusNum + #product.selLib do
			local newGrid = UIControls.getGridAwardContainer(self, "PayGiftPanel/ItemNode")

			table.insert(self.payItems, newGrid)
		end

		for index = 1, #product.selLib do
			local grid = self.payItems[self.giftBonusNum + index]

			grid:setVisible(true)

			local changeFunc = Functor(self.onChangeGift, self, index)

			grid:setAddMode(true, changeFunc, changeFunc)
			grid:setObj(nil)
			grid:setGet(self.canBuyCount <= 0)
		end

		self:_refreshGiftChoosenResult()
	end
end

function ActivityNewcomerBPGiftCell:onChangeGift(pos, grid)
	if self.giftChooseLib then
		UIManager.getUI("giftChooseBox", true):onShow(self.giftChooseLib, self, Slot(self.onChooseGift, self), self.chooseResult, pos)
	end
end

function ActivityNewcomerBPGiftCell:_refreshGiftChoosenResult()
	local chooseResult = self.chooseResult or {}

	for index, libId in ipairs(self.giftChooseLib) do
		local grid = self.payItems[self.giftBonusNum + index]
		local libData = ResRechargeSelLib[libId]
		local chooseIndex = chooseResult[index]

		if chooseIndex and libData and libData[chooseIndex] then
			grid:onShowRandClient(libData[chooseIndex].rand_id)
		else
			grid:setObj(nil)
		end

		grid:setGet(self.canBuyCount <= 0)
	end
end

function ActivityNewcomerBPGiftCell:onChooseGift(chooseResult)
	self.chooseResult = chooseResult

	local clientActCachedData = CurAvatar:getClientActivityCachedData(self.actId)

	clientActCachedData[self.rechargeId] = chooseResult

	CurAvatar:saveClientActivityCachedData(self.actId, clientActCachedData)
	self:_refreshGiftChoosenResult()
end

function ActivityNewcomerBPGiftCell:onBtnFreeClick()
	if self.state and self.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.actObj.opId, self.data.index, self.data.type), self.mParent.actObj.opId)
	end
end

function ActivityNewcomerBPGiftCell:onBtnPayClick()
	if self.mParent.hasRecharged and self.mParent.hasRecharged ~= 0 then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.actObj.opId, self.data.index, self.data.type), self.mParent.actObj.opId)
	else
		if self.giftChooseLib then
			local chooseResult = self.chooseResult or {}

			for index, _ in ipairs(self.giftChooseLib) do
				if not chooseResult[index] then
					MsgManager.clientNotice(429)

					return
				end
			end
		end

		if self.mEventClickPay then
			self:mEventClickPay()
		end
	end
end

local ActivityBPGiftPage = require("UI/OpActivity/ActivityBPGiftPage")
local strClassName = "ActivityNewcomerBPGiftPanel"
local ActivityNewcomerBPGiftPanel = Class(strClassName, ActivityBPGiftPage)

function ActivityNewcomerBPGiftPanel:initUI(...)
	self.txtTime = UIControls.Label(self, "BgTime/TextTime")
	self.buyPanel = UIControls.Panel(self, "ShopPanel/BuyPanel")
	self.btnCommonBuy = UIControls.Button(self, "ShopPanel/BuyPanel/BtnCommonBuy")

	self.btnCommonBuy:addEventClick(self.onBtnCommonBuyClick)

	self.btnSeniorBuy = UIControls.Button(self, "ShopPanel/BuyPanel/BtnSeniorBuy")

	self.btnSeniorBuy:addEventClick(self.onBtnSeniorBuyClick)

	self.noneContent = UIControls.Image(self, "ShopPanel/NoneContent")
	self.commonStatePanel = UIControls.Panel(self, "ShopPanel/CommonStatePanel")
	self.seniorStatePanel = UIControls.Panel(self, "ShopPanel/SeniorStatePanel")
	self.txtCommonPrice = UIControls.Label(self, "ShopPanel/BuyPanel/BtnCommonBuy/PricePanel/TextPrice")
	self.txtSeniorPrice = UIControls.Label(self, "ShopPanel/BuyPanel/BtnSeniorBuy/PricePanel/TextPrice")

	if ChannelUtil.isDMMGame() then
		self.txtCommonPricePt = UIControls.Label(self, "ShopPanel/BuyPanel/BtnCommonBuy/PricePanel/TextPt")

		self.txtCommonPricePt:setVisible(true)

		self.txtCommonPrimePricePt = UIControls.Label(self, "ShopPanel/BuyPanel/BtnCommonBuy/PrimePricePanel/TextPt")

		self.txtCommonPrimePricePt:setVisible(true)

		self.txtSeniorPricePt = UIControls.Label(self, "ShopPanel/BuyPanel/BtnSeniorBuy/PricePanel/TextPt")

		self.txtSeniorPricePt:setVisible(true)

		self.txtSeniorPrimePricePt = UIControls.Label(self, "ShopPanel/BuyPanel/BtnSeniorBuy/PrimePricePanel/TextPt")

		self.txtSeniorPrimePricePt:setVisible(true)
	end

	self.txtSeniorPrimePrice = UIControls.Label(self, "ShopPanel/BuyPanel/BtnSeniorBuy/PrimePricePanel/TextPrice")
	self.txtCommonPrimePrice = UIControls.Label(self, "ShopPanel/BuyPanel/BtnCommonBuy/PrimePricePanel/TextPrice")
end

function ActivityNewcomerBPGiftPanel:_onShow(...)
	self:setShow()
end

function ActivityNewcomerBPGiftCell:_timerOver(...)
	self.txtTime:setVisible(false)
end

function ActivityNewcomerBPGiftPanel:checkGotRechargeGift(...)
	if self.cellsData then
		for index, clientData in ipairs(self.cellsData) do
			local rechargeId

			if self.achieveToGift[clientData.type] and self.achieveToGift[clientData.type][clientData.index] then
				rechargeId = self.achieveToGift[clientData.type][clientData.index][1]
			end

			local product = RechargeManager.getProductByRechargeId(rechargeId)

			if product then
				local buyCount = 0

				if self.objGift.actData.serverData[rechargeId] then
					buyCount = self.objGift.actData.serverData[rechargeId].count or 0
				end

				local canBuyCount = product.buyTimesMax - buyCount

				if canBuyCount <= 0 then
					return true
				end
			end
		end
	end

	return false
end

function ActivityNewcomerBPGiftPanel:onActivityDataRefresh(...)
	self:setShow()
end

function ActivityNewcomerBPGiftPanel:setShow(...)
	local remainTime = self.actObj:getRemainOpenTime()

	if self.actObj:inOpenState() and remainTime and remainTime > 0 then
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, self.actObj:getRemainOpenTime(), false, Lang.get(48655), Slot(self._timerOver, self))
	else
		self.txtTime:setVisible(false)
	end

	self.hasRecharged = self.actData.hasRecharged

	if self.hasRecharged then
		if self.hasRecharged == Const.ACT_ACHIEVE_RECHARGE_STATE_NONE then
			if self.actData.connectRechargeId and self.actData.connectRechargeId > 0 then
				local product = RechargeManager.getProductByRechargeId(self.actData.connectRechargeId)

				if not product then
					-- block empty
				else
					self.txtCommonPrice:setText(product.priceText)
					self.txtCommonPrimePrice:setText(product.showOriginalPrice)
				end
			end

			if self.actData.connectMultipleRechargeId and self.actData.connectMultipleRechargeId > 0 then
				local product = RechargeManager.getProductByRechargeId(self.actData.connectMultipleRechargeId)

				if not product then
					-- block empty
				else
					self.txtSeniorPrice:setText(product.priceText)
					self.txtSeniorPrimePrice:setText(product.showOriginalPrice)
				end
			end

			self.commonStatePanel:setVisible(false)
			self.seniorStatePanel:setVisible(false)

			if self:checkGotRechargeGift() then
				self.noneContent:setVisible(true)
				self.buyPanel:setVisible(false)
			else
				self.noneContent:setVisible(false)
				self.buyPanel:setVisible(true)
			end
		else
			self.txtTime:setVisible(false)
			self.buyPanel:setVisible(false)

			if self.hasRecharged == Const.ACT_ACHIEVE_RECHARGE_STATE_LOW then
				self.commonStatePanel:setVisible(true)
				self.seniorStatePanel:setVisible(false)
			elseif self.hasRecharged == Const.ACT_ACHIEVE_RECHARGE_STATE_HIGH then
				self.commonStatePanel:setVisible(false)
				self.seniorStatePanel:setVisible(true)
			else
				self.commonStatePanel:setVisible(false)
				self.seniorStatePanel:setVisible(false)
			end
		end
	end

	if self.cellsData then
		for i = 1, 10 do
			local clientData = self.cellsData[i]
			local rechargeId

			if self.achieveToGift[clientData.type] and self.achieveToGift[clientData.type][clientData.index] then
				rechargeId = self.achieveToGift[clientData.type][clientData.index][1]
			end

			if self.hasRecharged == Const.ACT_ACHIEVE_RECHARGE_STATE_LOW and clientData and clientData.recharge_award then
				rechargeId = clientData.recharge_award
			end

			if self.hasRecharged == Const.ACT_ACHIEVE_RECHARGE_STATE_HIGH and clientData and clientData.high_recharge_award then
				rechargeId = clientData.high_recharge_award
			end

			local cellPath = "System/Activity/ActivityNewcomerBP/ActivityNewcomerBPCell02"
			local listPath = "AwardListR/Content"

			if i <= 5 then
				cellPath = "System/Activity/ActivityNewcomerBP/ActivityNewcomerBPCell01"
				listPath = "AwardListL/Content"
			end

			if not self.bpGiftCells[i] then
				self.bpGiftCells[i] = ActivityNewcomerBPGiftCell(self, listPath, cellPath)
				self.bpGiftCells[i].mEventClickPay = Slot(self.onBtnPayClick, self)

				self.bpGiftCells[i]:setVisible(true)
			end

			self.bpGiftCells[i]:setData(clientData, self.actData, self.objGift, rechargeId)
		end
	end
end

function ActivityNewcomerBPGiftPanel:onBtnPayClick(sender)
	if self.actData and self.actData:checkActivityExtraOpen() then
		local function onBuyCB(self, ui)
			if self:checkGotRechargeGift() then
				ui:onItemBuy()
			else
				local function funN(self, ui)
					if self.actData and self.actData:checkActivityExtraOpen() then
						ui:onItemBuy()
					else
						MsgManager.notice(Lang.get(32785))
					end
				end

				UIManager.showConfirmWithId(1129, nil, Functor(funN, self, ui))
			end
		end

		local product = RechargeManager.getProductByRechargeId(sender.rechargeId)

		if product then
			local ui = UIManager.getUI("giftBuyBox")

			ui._slot4OnItemBuy = Slot(onBuyCB, self)

			ui:showShopItem(product, self, nil, sender.rechargeId, self.actObj)
			ui:bindWindow(self)

			if product.price == 0 then
				ui:onItemBuy()
			else
				ui:setVisible(true)
			end

			if sender.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
				ui:setNewcomerSpecialShow()
			end
		end
	else
		MsgManager.notice(Lang.get(32785))
	end
end

function ActivityNewcomerBPGiftPanel:onBtnCommonBuyClick()
	if self.actData and self.actData:checkActivityExtraOpen() then
		if self.actData and self.actData.connectRechargeId and self.actData.hasRecharged == Const.ACT_ACHIEVE_RECHARGE_STATE_NONE then
			local function funN(self)
				if self.actData and self.actData:checkActivityExtraOpen() then
					RechargeManager.startRecharge(self.actData.connectRechargeId)
				else
					MsgManager.notice(Lang.get(32785))
				end
			end

			UIManager.showConfirmWithId(1130, nil, Slot(funN, self))
		end
	else
		MsgManager.notice(Lang.get(32785))
	end
end

function ActivityNewcomerBPGiftPanel:onBtnSeniorBuyClick()
	if self.actData and self.actData:checkActivityExtraOpen() then
		if self.actData and self.actData.connectMultipleRechargeId and self.actData.hasRecharged == Const.ACT_ACHIEVE_RECHARGE_STATE_NONE then
			RechargeManager.startRecharge(self.actData.connectMultipleRechargeId)
		end
	else
		MsgManager.notice(Lang.get(32785))
	end
end

return ActivityNewcomerBPGiftPanel
