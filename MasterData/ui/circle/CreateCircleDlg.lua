-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CreateCircleDlg.lua

local ResClanMisc = require("ClientData/ResClanMisc")
local ResColor = require("ClientData/ResColor")
local strClassName = "CreateCircleDlg"
local CreateCircleDlg = Class(strClassName, UIControls.Window)

function CreateCircleDlg:ctor()
	self:initUI()
end

function CreateCircleDlg:initUI()
	self.badageInfoList = {}
	self.inputName = UIControls.Input(self, "BgPanel/InputPanel/InputName")

	ClientUtils.checkInputValueChange(self.inputName)

	self.inputTitle = UIControls.Input(self, "BgPanel/InputPanel/InputTitle")

	ClientUtils.checkInputValueChange(self.inputTitle)

	self.inputContent = UIControls.Input(self, "BgPanel/InputPanel/InputContent")

	ClientUtils.checkInputValueChange(self.inputContent)

	for i = 1, 3 do
		local btnBadage = UIControls.Button(self, "BgPanel/BadgePanel/BtnBadge" .. i)

		btnBadage:addEventClick(self.onBtnBadageClick)

		self.badageInfoList[i] = btnBadage
	end

	self:onBtnBadageClick(self.badageInfoList[1])

	self.btnSel = UIControls.Button(self, "BgPanel/SetPanel/BtnSel")

	self.btnSel:addEventClick(self.onBtnSelClick)

	self.imgAutoPassSel = UIControls.Image(self, "BgPanel/SetPanel/BtnSel/ImgSel")
	self.isAutoPass = 1
	self.btnCreate = UIControls.Button(self, "BgPanel/BtnCreate")

	self.btnCreate:addEventClick(self.onBtnCreateClick)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.txtCostDiamond = UIControls.Label(self, "BgPanel/BtnCreate/CostPanel/TextNum")
	self.imgCostDiamond = UIControls.Image(self, "BgPanel/BtnCreate/CostPanel/Icon")

	self:initCircleCreateInfo()
end

function CreateCircleDlg:onOpen()
	CreateCircleDlg.super.onOpen(self)

	if self.needDiamond then
		local txtColor = ClientUtils.getMoney(Const.MONEY_ID_DIAMOND) < self.needDiamond and ResColor.RED or ResColor.WHITE

		self.txtCostDiamond:setFontColor(txtColor)
	end

	local circleListDlg = UIManager.getUI("circleListDlg", nil, false)

	if circleListDlg then
		self:bindWindow(circleListDlg)
	end
end

function CreateCircleDlg:initCircleCreateInfo()
	self.needDiamond = ResClanMisc[1].create_consume

	local moneyID = Const.MONEY_TYPE2ID[Const.MONEY_TYPE_DIAMOND] or 0
	local moneyInfo = ClientUtils.getMoneyIcon(moneyID)

	if moneyInfo then
		self.imgCostDiamond:setImage(moneyInfo[1], moneyInfo[2])
	end

	self.txtCostDiamond:setText(ClientUtils.getNumShortStr(self.needDiamond))
	self.inputTitle:setText(Lang.get(29930))
	self.inputContent:setText(Lang.get(29931))
end

function CreateCircleDlg:onBtnBadageClick(sender)
	for idx, badageInfo in ipairs(self.badageInfoList) do
		badageInfo:setEnable(sender ~= badageInfo)

		if sender == badageInfo then
			self.selectBadageIdx = idx
		end
	end
end

function CreateCircleDlg:onBtnSelClick()
	self.isAutoPass = self.isAutoPass == 1 and 0 or 1

	self.imgAutoPassSel:setVisible(self.isAutoPass == 1)
end

function CreateCircleDlg:onBtnCreateClick()
	if self.btnLockFlag then
		return
	end

	ClientUtils.checkMoneyChange(Const.MONEY_ID_DIAMOND, self.needDiamond, Slot(self._createCircle, self))
end

function CreateCircleDlg:_createCircle()
	if CurAvatar:isEnterCircleInCD() then
		MsgManager.notice(string.format(Lang.get(30197), ResClanMisc[1].join_cd))

		return
	end

	local name = utils.replaceString(self.inputName:getText(), "\n", "")
	local failMsg = ClientUtils.checkCircleName(name)

	if failMsg ~= "" then
		MsgManager.notice(failMsg)

		return
	end

	local title = utils.replaceString(self.inputTitle:getText(), "\n", "")
	local content = utils.replaceString(self.inputContent:getText(), "\n", "")

	if title == "" then
		MsgManager.notice(Lang.get(30186))

		return
	end

	if content == "" then
		MsgManager.notice(Lang.get(30187))

		return
	end

	local len = utils.utf8len(title, 2)

	if len > Const.MAX_CIRCLE_TITLE_MAXLEN then
		MsgManager.notice(Lang.get(30188))

		return
	end

	len = utils.utf8len(content, 2)

	if len > Const.MAX_CIRCLE_CONTENT_MAXLEN then
		MsgManager.notice(Lang.get(30189))

		return
	end

	self.btnLockFlag = true

	RPC.clanCreate(name, title, content, self.isAutoPass, self.selectBadageIdx)
end

function CreateCircleDlg:onBtnCloseClick()
	self:setVisible(false)
end

function CreateCircleDlg:markInputIllegal(hint)
	ClientUtils.markInputIllegal(self.inputName, hint)
	ClientUtils.markInputIllegal(self.inputTitle, hint)
	ClientUtils.markInputIllegal(self.inputContent, hint)
end

return CreateCircleDlg
