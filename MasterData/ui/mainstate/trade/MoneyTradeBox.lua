-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\MoneyTradeBox.lua

local strClassName = "MoneyTradeBox"
local MoneyTradeBox = Class(strClassName, UIControls.Window)

function MoneyTradeBox:ctor()
	self:initUI()
end

function MoneyTradeBox:initUI()
	self.txtNeedTag = UIControls.Label(self, "Bg/LackPanel/Text")
	self.imgNeedIcon = UIControls.Image(self, "Bg/LackPanel/Icon")
	self.txtNeedNum = UIControls.Label(self, "Bg/LackPanel/TextNum")
	self.txtUseTag = UIControls.Label(self, "Bg/NeedPanel/Text")
	self.imgUseIcon = UIControls.Image(self, "Bg/NeedPanel/Icon")
	self.txtUseNum = UIControls.Label(self, "Bg/NeedPanel/TextNum")
	self.panelLeft = UIControls.Panel(self, "Bg/BackPanel")
	self.imgLeftIcon = UIControls.Image(self, "Bg/BackPanel/Icon")
	self.txtLeftNum = UIControls.Label(self, "Bg/BackPanel/TextNum")
	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function MoneyTradeBox:show(ui, moneyID, needNum, callback)
	local changeInfo = Const.MONEY_EXCHANGE_MAP[moneyID]
	local needMoneyInfo = UIConst.MONEY_ID2INFO[moneyID]

	if changeInfo == nil or needMoneyInfo == nil then
		return
	end

	local needMoneyName = needMoneyInfo[3]

	self.txtNeedTag:setText(string.format(Lang.get(30541), needMoneyName))
	self.txtNeedNum:setText(needNum)
	self.imgNeedIcon:setImage(needMoneyInfo[1], needMoneyInfo[2])

	self._changeCount = math.ceil(needNum / changeInfo.num)
	self._changeID = changeInfo.id
	self._useMoneyNeed = self._changeCount * changeInfo.need

	local useMoneyInfo = UIConst.MONEY_ID2INFO[Const.MONEY_ID_DIAMOND]
	local useMoneyName = useMoneyInfo[3]

	self.txtUseTag:setText(string.format(Lang.get(30542), useMoneyName))
	self.txtUseNum:setText(self._useMoneyNeed)
	self.imgUseIcon:setImage(useMoneyInfo[1], useMoneyInfo[2])

	local leftNum = self._changeCount * changeInfo.num - needNum

	self.panelLeft:setVisible(leftNum > 0)

	if leftNum > 0 then
		self.txtLeftNum:setText(leftNum .. needMoneyName)
		self.imgLeftIcon:setImage(needMoneyInfo[1], needMoneyInfo[2])
	end

	self._focusUI = ui
	self._callback = callback

	if not self:getVisible() then
		self:setVisible(true)
	end
end

function MoneyTradeBox:_doExchange()
	RPC.currencyExchange(self._changeID, self._changeCount)
	self:setVisible(false)

	if self._callback then
		self._callback()
	end
end

function MoneyTradeBox:onBtnDenyClick(sender)
	self:setVisible(false)
end

function MoneyTradeBox:onBtnConfirmClick(sender)
	ClientUtils.checkMoneyChange(Const.MONEY_ID_DIAMOND, self._useMoneyNeed, Slot(self._doExchange, self), self._focusUI, true)
end

return MoneyTradeBox
