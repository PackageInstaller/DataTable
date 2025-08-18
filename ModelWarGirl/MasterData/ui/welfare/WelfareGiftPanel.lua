-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfareGiftPanel.lua

local WelfareBase = require("UI/Welfare/WelfarePanelBase")
local ResRandClient = require("ClientData/ResRandClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local NewBeeCell = require("UI/Welfare/NewBeeCell")
local NormalBeeCell = require("UI/Welfare/NormalBeeCell")
local EventConst = require("EventConst")
local ResColor = require("ClientData/ResColor")
local ResMallMisc = require("ClientData/ResMallMisc")
local strClassName = "WelfareGiftPanel"
local WelfareGiftPanel = Class(strClassName, WelfareBase)
local everyDayTip = Lang.get(48697)

if ChannelUtil.isDMMGame() then
	everyDayTip = utils.replaceString(everyDayTip, Lang.get(78291), "pt")
end

WelfareGiftPanel.GiftData = {
	[Const.WELFARETYPE_NEWBEE] = {
		prePath = "System/Common/Grid/GridStoreGiftBeginner",
		cellType = NewBeeCell,
		lastTimeTip = Lang.get(48696)
	},
	[Const.WELFARETYPE_NEWBEE2] = {
		prePath = "System/Common/Grid/GridStoreGiftBeginner",
		cellType = NewBeeCell,
		lastTimeTip = Lang.get(48696)
	},
	[Const.WELFARETYPE_DAYBEE] = {
		prePath = "System/Common/Grid/GridStoreGiftDaily",
		cellType = NormalBeeCell,
		lastTimeTip = everyDayTip
	},
	[Const.WELFARETYPE_WEEKBEE] = {
		prePath = "System/Common/Grid/GridStoreGiftWeek",
		cellType = NormalBeeCell,
		lastTimeTip = Lang.get(48698)
	},
	[Const.WELFARETYPE_MONTHBEE] = {
		prePath = "System/Common/Grid/GridStoreGiftMonth",
		cellType = NormalBeeCell,
		lastTimeTip = Lang.get(48699)
	}
}

local REPLACE_ACT_PRE = Lang.get(48700)

if ChannelUtil.isDMMGame() then
	REPLACE_ACT_PRE = utils.replaceString(REPLACE_ACT_PRE, Lang.get(78291), "pt")
end

function WelfareGiftPanel:ctor(...)
	self.cells = {}
	self._slot4CellClick = Slot(self.onCellClick, self)
	self._slot4LoadEnd = Slot(self.refreshMixinData, self)

	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4LoadEnd)
	EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4LoadEnd)
end

local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")

function WelfareGiftPanel:initPanel()
	local id = self.panelConfigData.id

	self:initUI(ResMallSubPanelConfig[id])
end

function WelfareGiftPanel:onOpenPanel()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_MALL, self.panelConfigData.id)
end

function WelfareGiftPanel:initUI(data)
	self.giftType = data.pageType
	self.info = self.GiftData[self.giftType]
	self.existTime = (data.value1 or 1) * 86400
	self.scrollItem = UIControls.ScrollViewLoopV(self, "AwardList", 0, self._onCellChanged)
	self.textTime = UIControls.Label(self, "TipsPanel/TextTime")

	self.textTime:setText("")

	self.initGiftState = {}

	self:refreshData()
end

function WelfareGiftPanel:refreshMixinData()
	return
end

function WelfareGiftPanel:refreshData()
	if self.isTimeOver == true then
		self:refreshUI()

		return
	end

	self:refreshLastTime()

	self.productData = {}
	self.replaceProductAct = nil

	local data = CurAvatar:getGiftData(self.giftType).gifts

	for rechargeId, product in pairs(data) do
		local realShowRechargeId = rechargeId

		if CurAvatar and CurAvatar.rechargeReplaced[rechargeId] then
			local newRechargeInfo = CurAvatar.rechargeReplaced[rechargeId]

			if newRechargeInfo then
				local newRechargeId = newRechargeInfo[1]
				local actObj = newRechargeInfo[2]
				local newProduct = RechargeManager.getProductByRechargeId(newRechargeId)

				if newProduct and actObj:isValid() then
					newProduct.index = product.index
					realShowRechargeId = newRechargeId

					table.insert(self.productData, {
						newProduct,
						newRechargeInfo[2]
					})

					self.replaceProductAct = actObj
				else
					table.insert(self.productData, {
						product
					})
				end
			end
		else
			table.insert(self.productData, {
				product
			})
		end

		if not self.initGiftState[realShowRechargeId] then
			self.initGiftState[realShowRechargeId] = RechargeManager.getNestedId(realShowRechargeId)
		end
	end

	table.sort(self.productData, function(a, b)
		a[1].indexPriority = a[1].indexPriority or 0
		b[1].indexPriority = b[1].indexPriority or 0

		if a[1].indexPriority == b[1].indexPriority then
			return a[1].index < b[1].index
		else
			return a[1].indexPriority < b[1].indexPriority
		end
	end)
	self:refreshUI()
end

function WelfareGiftPanel:refreshLastTime()
	local svTime = ClientUtils.getServerTime()
	local todayLastTime = ClientUtils.getServerTimeNextDay() - svTime

	if self.giftType == Const.WELFARETYPE_DAYBEE then
		self.existTime = todayLastTime
	elseif self.giftType == Const.WELFARETYPE_WEEKBEE then
		self.existTime = ClientUtils.getServerTimeNextWday(1) - svTime
	elseif self.giftType == Const.WELFARETYPE_MONTHBEE then
		self.existTime = ClientUtils.getServerTimeNextMonth() - svTime
	end
end

function WelfareGiftPanel:refreshUI()
	if self.replaceProductAct and self.replaceProductAct:getRemainOpenTime() > 0 then
		ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.replaceProductAct:getRemainOpenTime(), false, REPLACE_ACT_PRE, Slot(self.onReplaceTimeOver, self))
	else
		local newBeeTick = ClientUtils.getServerTimeByTimeStr(ResMallMisc[1].newBee_tick)
		local timePass = 0

		if Const.WELFARETYPE_NEWBEE_GROUP[self.giftType] then
			if self.panelConfigData.arg1 ~= 1 then
				timePass = ClientUtils.getServerTime() - CurAvatar.roleCreateTick
			elseif newBeeTick >= CurAvatar.roleCreateTick then
				timePass = ClientUtils.getServerTime() - newBeeTick
			else
				timePass = ClientUtils.getServerTime() - CurAvatar.roleCreateTick
			end
		end

		self.remainTime = self.existTime - timePass

		if self.remainTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.remainTime, false, self.info.lastTimeTip, Slot(self.onTimeOver, self))
		end
	end

	self.scrollItem:setTotalCount(#self.productData, nil, false)
end

function WelfareGiftPanel:onTimeOver()
	ClientTimerManager.RemoveSecondTickUI(self.textTime)

	if Const.WELFARETYPE_NEWBEE_GROUP[self.giftType] then
		self.isTimeOver = true

		self.textTime:setText(Lang.get(30794))
	end
end

function WelfareGiftPanel:onReplaceTimeOver()
	if self.replaceProductAct then
		local actId = self.replaceProductAct.actId

		if not CurAvatar:isActivityValid(actId) then
			self:refreshData()
		end
	end
end

function WelfareGiftPanel:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		local cell = self.info.cellType

		targetCell = cell(sender, self.info.prePath, newIdx, 0, 0)
		targetCell.mEventClick = self._slot4CellClick
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setData(self.productData[newIdx][1], self.initGiftState[self.productData[newIdx].rechargeId], self.productData[newIdx][2], self.giftType)
end

function WelfareGiftPanel:onCellClick(data, actObj)
	local getLeftTimes = data:getGetLeftTimes()

	if getLeftTimes > 0 and data.buyTimesLeft > 0 then
		if not actObj then
			local function yesFunc()
				RPC.rechargeGetMulityAward(data.mulityLinkId, data.rechargeId)
			end

			UIManager.showConfirmWithId(1039, yesFunc)
		else
			RPC.rechargeGetMulityAward(data.mulityLinkId, data.rechargeId)
		end

		return
	end

	local ui = UIManager.getUI("giftBuyBox")

	self.curCellID = data.rechargeId

	if actObj then
		ui:showShopItem(data, self, self.giftType, self.curCellID, actObj)
	else
		ui:showShopItem(data, self, self.giftType, self.curCellID)
	end

	ui:bindWindow(self)

	if ui.cellShop.data.priceText == 0 then
		ui:onItemBuy()
	else
		ui:setVisible(true)
	end
end

function WelfareGiftPanel:onGetAwardBack(data)
	return
end

function WelfareGiftPanel:recommendShowGift(recommendArgs)
	local rechargeId = recommendArgs[1]

	for _, pInfo in pairs(self.productData) do
		if pInfo[1] and pInfo[1].rechargeId == rechargeId then
			if pInfo[1].buyTimesLeft <= 0 then
				MsgManager.notice(Lang.get(30063))
			else
				self:onCellClick(pInfo[1], pInfo[2])
			end
		end
	end
end

function WelfareGiftPanel:panelTop()
	return
end

function WelfareGiftPanel:onClosePanel()
	WelfareGiftPanel.super.onClosePanel(self)

	if self.isTimeOver then
		CurAvatar:setWelfareHide(self.giftType, true)
	end
end

function WelfareGiftPanel:onDestroy()
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4LoadEnd)
end

return WelfareGiftPanel
