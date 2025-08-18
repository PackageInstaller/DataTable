-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\EditNameDlg.lua

local ResItem = require("ClientData/ResItem")
local ResCommonHardCode = require("ClientData/ResCommonHardCode")
local ConsumeTips = require("System/ConsumeTips")
local strClassName = "EditNameDlg"
local EditNameDlg = Class(strClassName, UIControls.Window)
local renameId = ResCommonHardCode[30].value[2]
local renameCost = ResCommonHardCode[30].value[3]
local renameCD = ResCommonHardCode[30].value[1]

function EditNameDlg:ctor(...)
	self:initUI()
	self:initData()
end

function EditNameDlg:initUI(...)
	self.inputName = UIControls.Input(self, "Bg/NameInputField")

	ClientUtils.checkInputValueChange(self.inputName)

	self.txtPlaceHolder = UIControls.Label(self, "Bg/NameInputField/Placeholder")
	self.panelCost = UIControls.Panel(self, "Bg/DiamondPanel")
	self.imgIcon = UIControls.Image(self, "Bg/BtnConfirm/CostPanel/Icon")
	self.txtCount = UIControls.Label(self, "Bg/BtnConfirm/CostPanel/Text")
	self.txtTime = UIControls.Label(self, "Bg/TextTips/TextTime")
	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function EditNameDlg:initData(...)
	local diamondPath = UIConst.MONEY_ID2INFO[Const.MONEY_ID_DIAMOND]

	self.txtTime:setText(string.format(Lang.get(30022), math.ceil(renameCD / 86400)))

	local ticktCount = CurAvatar:getItemNumById(renameId)

	if ticktCount > 0 then
		self.imgIcon:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas2", "IconNameCard")
		self.txtCount:setText(1)
	else
		self.imgIcon:setImage(diamondPath[1], diamondPath[2])
		self.txtCount:setText(renameCost)
	end

	self.ticktOk = ticktCount > 0
	self.diamondOk = ClientUtils.getMoney(Const.MONEY_ID_DIAMOND) >= renameCost
end

function EditNameDlg:setData(name)
	self.name = name

	self.inputName:setText(name)
end

function EditNameDlg:markInputIllegal(hint)
	ClientUtils.markInputIllegal(self.inputName, hint)
end

function EditNameDlg:onBtnDenyClick(...)
	self:setVisible(false)
end

function EditNameDlg:onBtnConfirmClick(...)
	local name = self.inputName:getText()
	local hint = self:_checkLegal(name)

	if hint then
		MsgManager.notice(hint)

		return
	end

	if not self.ticktOk then
		ClientUtils.checkMoneyChange(Const.MONEY_ID_DIAMOND, renameCost, Slot(self.showTips, self), self)
	else
		self:rename()
	end
end

function EditNameDlg:showTips(...)
	ConsumeTips.showTipsDiamond(renameCost, Const.CONSUME_DIAMOND_CHANGE_NAME, 1, Slot(self.rename, self), Slot(self.onBtnDenyClick, self))
end

function EditNameDlg:rename(...)
	local name = self.inputName:getText()
	local costType = Const.RENAME_COST_TICKET

	if not self.ticktOk then
		costType = Const.RENAME_COST_DIAMOND
	end

	RPC.roleRename(name, costType)
end

function EditNameDlg:_checkLegal(name)
	if name == self.name then
		return Lang.get(30742)
	end

	local failMsg = ClientUtils.checkPlayerName(name)

	if failMsg ~= "" then
		return failMsg
	end
end

return EditNameDlg
