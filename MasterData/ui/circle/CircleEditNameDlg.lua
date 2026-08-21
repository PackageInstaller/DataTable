-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleEditNameDlg.lua

local ResClanMisc = require("ClientData/ResClanMisc")
local ResColor = require("ClientData/ResColor")
local strClassName = "CircleEditNameDlg"
local CircleEditNameDlg = Class(strClassName, UIControls.Window)

function CircleEditNameDlg:ctor()
	self:initUI()
end

function CircleEditNameDlg:initUI()
	self.inputName = UIControls.Input(self, "Bg/NameInputField")

	ClientUtils.checkInputValueChange(self.inputName)

	self.txtCostDiamond = UIControls.Label(self, "Bg/BtnConfirm/CostPanel/Text")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnDeny = UIControls.Button(self, "BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.txtTips = UIControls.Label(self, "Bg/TextTips")

	self:initEditNameInfo()
end

function CircleEditNameDlg:initEditNameInfo()
	self.costDiamond = ResClanMisc[1].rename_consume

	self.txtCostDiamond:setText(self.costDiamond)
	self.txtTips:setText(string.format(Lang.get(30178), ResClanMisc[1].rename_cd))
	self.inputName:setText(CurAvatar.myCircle.name)

	if self.costDiamond then
		local txtColor = ClientUtils.getMoney(Const.MONEY_ID_DIAMOND) < self.costDiamond and ResColor.RED or ResColor.WHITE

		self.txtCostDiamond:setFontColor(txtColor)
	end
end

function CircleEditNameDlg:onBtnConfirmClick()
	if self.btnLockFlag then
		return
	end

	if utils.replaceString(self.inputName:getText(), "\n", "") == utils.replaceString(CurAvatar.myCircle.name, "\n", "") then
		MsgManager.clientNotice(235)

		return
	end

	if ClientUtils.getServerTime() < CurAvatar.myCircle.renameTick + ResClanMisc[1].rename_cd * 60 * 60 + 3 then
		MsgManager.clientNotice(227)

		return
	end

	local name = utils.replaceString(self.inputName:getText(), "\n", "")
	local failMsg = ClientUtils.checkCircleName(name)

	if failMsg ~= "" then
		MsgManager.notice(failMsg)

		return
	end

	ClientUtils.checkMoneyChange(Const.MONEY_ID_DIAMOND, self.costDiamond, Slot(self._circleRename, self), self)
end

function CircleEditNameDlg:_circleRename()
	local name = utils.replaceString(self.inputName:getText(), "\n", "")

	self.btnLockFlag = true

	RPC.clanRename(name)
end

function CircleEditNameDlg:onBtnDenyClick()
	self:setVisible(false)
end

function CircleEditNameDlg:markInputIllegal(hint)
	ClientUtils.markInputIllegal(self.inputName, hint)
end

return CircleEditNameDlg
