-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\AchiBuyBox.lua

local ResShopExchg = require("ClientData/ResShopExchg")
local ResColor = require("ClientData/ResColor")
local ConsumeTips = require("System/ConsumeTips")
local strClassName = "AchiBuyBox"
local AchiBuyBox = Class(strClassName, UIControls.Window)

function AchiBuyBox:ctor()
	self:initUI()
end

function AchiBuyBox:initUI()
	self.itemUse = UIControls.Image(self, "BgPanel/ItemPanel/ItemUse")
	self.textUseNum = UIControls.Label(self, "BgPanel/ItemPanel/ItemUse/TextNum")
	self.itemGet = UIControls.Image(self, "BgPanel/ItemPanel/ItemGet")
	self.textGetNum = UIControls.Label(self, "BgPanel/ItemPanel/ItemGet/TextNum")
	self.btnNumAdd = UIControls.Button(self, "BgPanel/NumPanel/BtnNumAdd")

	self.btnNumAdd:addEventClick(self.onBtnNumAddClick)

	self.btnNumMin = UIControls.Button(self, "BgPanel/NumPanel/BtnNumMin")

	self.btnNumMin:addEventClick(self.onBtnNumMinClick)

	self.btnNumMax = UIControls.Button(self, "BgPanel/NumPanel/BtnNumMax")

	self.btnNumMax:addEventClick(self.onBtnNumMaxClick)

	self.textInput = UIControls.Label(self, "BgPanel/NumPanel/InputNum/Text")
	self.btnNumBuy = UIControls.Button(self, "BgPanel/NumPanel/InputNum", "Text")

	self.btnNumBuy:addEventClick(self.onBuyNumClick)

	self.btnDeny = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.keyboard = UIControls.NumKeyboard(self, "BgPanel/NumPanel/KeyboardPanel")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self._buyCount = 1
	self._slot4NumInput = Slot(self.onNumInput, self)
end

function AchiBuyBox:showItem(opId, exchgID, maxExchgValue, callFunc)
	self.callFunc = callFunc
	self.opId = opId
	self.exchgID = exchgID
	self.exchgData = ResShopExchg[exchgID]
	self.useId = self.exchgData.use[1].ID
	self.useNum = self.exchgData.use[1].original or self.exchgData.use[1].discount
	self.exchgId = self.exchgData.exchg[1].key
	self.exchgNum = self.exchgData.exchg[1].value

	if maxExchgValue < 0 then
		maxExchgValue = 0
	end

	self.maxExchgNum = math.floor(maxExchgValue / self.exchgNum)

	local itemUseIcon = BaseObject.getItemIconPath(self.useId)

	if itemUseIcon then
		self.itemUse:setImage(itemUseIcon[1], itemUseIcon[2])
	end

	local itemGetIcon = BaseObject.getItemIconPath(self.exchgId)

	if itemGetIcon then
		self.itemGet:setImage(itemGetIcon[1], itemGetIcon[2])
	end

	self:updateExchgNum(1)
end

function AchiBuyBox:updateExchgNum(tgtCount)
	self._minExchgNum = 0

	if tgtCount == nil then
		tgtCount = self._minCount
	end

	if tgtCount > self.maxExchgNum then
		tgtCount = self.maxExchgNum

		MsgManager.clientNotice(147)
	elseif tgtCount < self._minExchgNum then
		tgtCount = self._minExchgNum

		MsgManager.notice(string.format(Lang.get(30549), self._minExchgNum))
	end

	self.textUseNum:setText(tgtCount * self.useNum)
	self.textGetNum:setText(tgtCount * self.exchgNum)

	self._buyCount = tgtCount
	self._totalMoney = self.useNum * self._buyCount

	self.textInput:setText(tgtCount)

	local haveV = ClientUtils.getMoney(self.useId)

	if haveV >= self._totalMoney then
		self.textUseNum:setFontColor(ResColor.WHITE)
	else
		self.textUseNum:setFontColor(ResColor.RED)
	end
end

function AchiBuyBox:onBuyNumClick()
	self.keyboard:show(self._slot4NumInput, self._buyCount, self.maxExchgNum, 0)
end

function AchiBuyBox:onNumInput(value)
	self:updateExchgNum(value)
end

function AchiBuyBox:onBtnNumAddClick()
	self:updateExchgNum(self._buyCount + 1)
end

function AchiBuyBox:onBtnNumMinClick()
	self:updateExchgNum(self._buyCount - 1)
end

function AchiBuyBox:onBtnNumMaxClick()
	self:updateExchgNum(self._buyCount + 10)
end

function AchiBuyBox:onBtnConfirmClick()
	if self._buyCount <= 0 then
		MsgManager.clientNotice(145)

		return
	end

	if self.useId == Const.MONEY_ID_DIAMOND then
		ClientUtils.checkMoneyChange(self.useId, self._totalMoney, self._showBuyTips, self, true)
	else
		ClientUtils.checkMoneyChange(self.useId, self._totalMoney, self._doBuy, self, true)
	end
end

function AchiBuyBox:_showBuyTips(...)
	ConsumeTips.showTipsDiamond(self._totalMoney, Const.CONSUME_DIAMOND_SHOP_ITEM, self._buyCount, Slot(self._doBuy, self))
end

function AchiBuyBox:_doBuy()
	RPC.opActAchieveExchangeItem(self.opId, self.exchgID, self._buyCount, 0)
	self:setVisible(false)

	if self.callFunc then
		self.callFunc()
	end
end

function AchiBuyBox:onBtnDenyClick()
	self:setVisible(false)
end

return AchiBuyBox
