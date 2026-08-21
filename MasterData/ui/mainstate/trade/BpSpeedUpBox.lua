-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\BpSpeedUpBox.lua

local ResBattlePassMisc = require("ClientData/ResBattlePassMisc")
local ResBattlePassLevel = require("ClientData/ResBattlePassLevel")
local RPC = require("Framework/RPC")
local strClassName = "BpSpeedUpBox"
local BpSpeedUpBox = Class(strClassName, UIControls.Window)

function BpSpeedUpBox:ctor()
	self.btnDel = UIControls.Button(self, "BgPanel/SetNumPanel/BtnMin")
	self.btnAdd = UIControls.Button(self, "BgPanel/SetNumPanel/BtnAdd")
	self.txtPre = UIControls.Label(self, "BgPanel/SetNumPanel/TextLvPre")
	self.txtMax = UIControls.Label(self, "BgPanel/SetNumPanel/TextLvMax")
	self.slider = UIControls.Slider(self, "BgPanel/SetNumPanel/Slider", "Handle Slide Area/Handle/Textlv")
	self.imgNeedBP = UIControls.Image(self, "BgPanel/NeedPanel/Icon")
	self.txtNeedBP = UIControls.Label(self, "BgPanel/NeedPanel/Text")
	self.imgMoney = UIControls.Image(self, "BgPanel/CostPanel/Icon")
	self.txtMoney = UIControls.Label(self, "BgPanel/CostPanel/Text")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnFunc")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")
	self._slot4SliderChanged = Slot(self.onSliderChange, self)

	self.slider:addEventValueChanged(self._slot4SliderChanged)
	self.btnDel:addEventClick(self.onBtnDelClick)
	self.btnAdd:addEventClick(self.onBtnAddClick)

	self._slot4Close = Slot(self.onBtnCloseClick, self)

	self.btnClose:addEventClick(self._slot4Close)
	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function BpSpeedUpBox:onShow(curLevel, maxLevel, curBPValue, step)
	self.step = step

	self.txtPre:setText(curLevel)
	self.txtMax:setText(maxLevel)
	self.txtNeedBP:setText(0)
	self.txtMoney:setText(0)

	self.needMoney = 0

	local moneyInfo = UIConst.MONEY_ID2INFO[Const.MONEY_ID_DIAMOND]

	self.imgMoney:setImage(moneyInfo[1], moneyInfo[2])

	local moneyInfoBP = UIConst.MONEY_ID2INFO[Const.MONEY_ID_BP]

	self.imgNeedBP:setImage(moneyInfoBP[1], moneyInfoBP[2])

	self.price = ResBattlePassMisc[1].gem_buy_count
	self.bpCount = 0
	self.minLevel = curLevel
	self.maxLevel = maxLevel
	self.bpNeed = 0
	self.chooseLevel = curLevel

	self.slider:setText(self.chooseLevel)

	self.delta = maxLevel - curLevel
	self.minNeedPoint = curBPValue
end

function BpSpeedUpBox:onSliderChange()
	local curValue = self.slider:getValue()

	self.chooseLevel = self.minLevel + self.delta * curValue
	self.chooseLevel = self.chooseLevel % 1 < 0.5 and math.floor(self.chooseLevel) or math.ceil(self.chooseLevel)

	local value = (self.chooseLevel - self.minLevel) / self.delta

	self.slider:setValue(value)
	self:onUpdate()
end

function BpSpeedUpBox:onBtnDelClick()
	if self.chooseLevel > self.minLevel then
		self.chooseLevel = self.chooseLevel - 1

		local value = (self.chooseLevel - self.minLevel) / self.delta

		self.slider:setValue(value)
		self:onUpdate()
	end
end

function BpSpeedUpBox:onBtnAddClick()
	if self.chooseLevel < self.maxLevel then
		self.chooseLevel = self.chooseLevel + 1

		local value = (self.chooseLevel - self.minLevel) / self.delta

		self.slider:setValue(value)
		self:onUpdate()
	end
end

function BpSpeedUpBox:onUpdate()
	self.slider:setText(self.chooseLevel)

	local bpNeed = ResBattlePassLevel[self.chooseLevel][self.step].bp_need - self.minNeedPoint

	bpNeed = bpNeed >= 0 and bpNeed or 0
	self.bpNeed = bpNeed

	self.txtNeedBP:setText(bpNeed)
	self.txtMoney:setText(bpNeed * self.price)

	self.needMoney = bpNeed * self.price
end

function BpSpeedUpBox:onBtnConfirmClick()
	if self.bpNeed == 0 then
		MsgManager.notice(Lang.get(30534))

		return
	end

	ClientUtils.checkMoneyChange(Const.MONEY_ID_DIAMOND, self.needMoney, self._doBuy, self, true)
end

function BpSpeedUpBox:_doBuy()
	RPC.battlePassBuyBpCount(self.bpNeed)
	UIManager.getUI("bPLvUpResultBox", true):onShow(self.minLevel, self.chooseLevel)
	self:setVisible(false)
end

function BpSpeedUpBox:onBtnCloseClick(sender)
	self:setVisible(false)
end

return BpSpeedUpBox
