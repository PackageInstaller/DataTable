-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\DeductConfirmBox.lua

local RechargeManager = require("System/Recharge/RechargeManager")
local Const = Const
local RECHARGE_METHOD = RechargeManager.RECHARGE_METHOD
local strClassName = "DeductConfirmBox"
local DeductConfirmBox = Class(strClassName, UIControls.Window)

function DeductConfirmBox:ctor(...)
	self:initUI()
end

function DeductConfirmBox:initUI(...)
	self.BtnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.BtnDeny:addEventClick(self._OnClickDeny)

	self.BtnConFirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.BtnConFirm:addEventClick(self._OnClickConfirm)

	self.BtnDenyImage = UIControls.Image(self, "Bg/BtnDeny/Icon")

	self.BtnDenyImage:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconRMB")

	self.BtnClose = UIControls.Button(self, "Bg/BtnClose")

	self.BtnClose:addEventClick(self._CloseBox)
end

function DeductConfirmBox:SetAllImage(method)
	self.BtnConFirmImage = UIControls.Image(self, "Bg/BtnConfirm/Icon")
	self.Icon = UIControls.Image(self, "Bg/Icon")

	local moneyID

	if method == RECHARGE_METHOD.REFUND then
		moneyID = Const.MONEY_TYPE2ID[Const.MONEY_TYPE_REFUND_COIN]
	elseif method == RECHARGE_METHOD.REBATE then
		moneyID = 510022
	end

	local moneyInfo = ClientUtils.getMoneyIcon(moneyID)

	if moneyInfo then
		self.BtnConFirmImage:setImage(moneyInfo[1], moneyInfo[2])
	end

	local iconPath = BaseObject.getItemIconPath(moneyID)

	if iconPath then
		self.Icon:setImage(iconPath[1], iconPath[2])
	end
end

function DeductConfirmBox:_OnClickDeny()
	if self.callback and self.rechargeId then
		self.callback(self.rechargeId, RECHARGE_METHOD.MONEY)
	end

	self:_CloseBox(true)
end

function DeductConfirmBox:_OnClickConfirm()
	if self.callback and self.rechargeId then
		self.callback(self.rechargeId, self.method)
	end

	self:_CloseBox(true)
end

function DeductConfirmBox:_CloseBox(isPay)
	self:setVisible(false)

	if self.method == RECHARGE_METHOD.REFUND and RechargeManager._canUseRebate(self.rechargeId) and isPay ~= true then
		local reopenBox = UIManager.getUI("deductConfirmBox", true)

		if reopenBox then
			reopenBox:SetTextContent(self.rechargeId, RECHARGE_METHOD.REBATE, self.callback)
		end
	end
end

function DeductConfirmBox:SetTextContent(rechargeId, method, callback)
	self.callback = callback
	self.rechargeId = rechargeId
	self.method = method

	local product = RechargeManager.getProductByRechargeId(rechargeId)

	self.TextContent = UIControls.Label(self, "Bg/TextContent")

	if method == RECHARGE_METHOD.REFUND then
		local productPrice = product.refundCoin

		if productPrice then
			self.TextContent:setText(string.format(Lang.get(86994), productPrice))
		end
	elseif method == RECHARGE_METHOD.REBATE then
		local productPrice = product.priceTextRebate

		if productPrice then
			self.TextContent:setText(string.format(Lang.get(86995), productPrice))
		end
	end

	self:SetAllImage(method)
end

return DeductConfirmBox
