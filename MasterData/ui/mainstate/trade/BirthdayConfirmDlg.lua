-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\BirthdayConfirmDlg.lua

local UIControls = require("UI/UIControls")
local SDKConst = require("SDK/SDKConst")
local Analytics = require("SDK/Analytics")
local AttName = SDKConst.AttName
local strClassName = "BirthdayConfirmDlg"
local BirthdayConfirmDlg = Class(strClassName, UIControls.Window)

function BirthdayConfirmDlg:ctor()
	self.btnConfirm = UIControls.Button(self, "Bg/FuncPanel/BtnConfirm", "Text")

	self.btnConfirm:setText(Lang.get(50621))

	self.btnCancel = UIControls.Button(self, "Bg/FuncPanel/BtnCancel", "Text")

	self.btnCancel:setText("やめる")

	self.year = nil
	self.month = nil
	self.curPageIdx = 0
	self.panelInput = UIControls.Panel(self, "Bg/InputPanel")
	self.inputYear = UIControls.Input(self, "Bg/InputPanel/BirthdayPanel/YearInputField")
	self.inputMonth = UIControls.Input(self, "Bg/InputPanel/BirthdayPanel/MonthInputField")
	self.Stage1_age = UIControls.Label(self, "Bg/InputPanel/RulePanel/Rule1/TextAge")

	self.Stage1_age:setText(Lang.get(43996))

	self.Stage1_rule = UIControls.Label(self, "Bg/InputPanel/RulePanel/Rule1/TextRule")

	self.Stage1_rule:setText(Lang.get(36328))

	self.panelConfirm = UIControls.Panel(self, "Bg/ConfirmPanel")
	self.textYear = UIControls.Label(self, "Bg/ConfirmPanel/BirthdayPanel/YearInputField/Text")
	self.textMonth = UIControls.Label(self, "Bg/ConfirmPanel/BirthdayPanel/MonthInputField/Text")
	self.Stage2_age = UIControls.Label(self, "Bg/InputPanel/RulePanel/Rule2/TextAge")

	self.Stage2_age:setText(Lang.get(17))

	self.Stage2_rule = UIControls.Label(self, "Bg/InputPanel/RulePanel/Rule2/TextRule")

	self.Stage2_rule:setText(Lang.get(36329))

	self.panelRule = UIControls.Panel(self, "Bg/ConfirmPanel/RulePanel")
	self.panelSuccess = UIControls.Panel(self, "Bg/ConfirmPanel/SuccessPanel")
	self.txtTitle = UIControls.Label(self, "Bg/TextTitle")
	self.Stage3_age = UIControls.Label(self, "Bg/InputPanel/RulePanel/Rule3/TextAge")

	self.Stage3_age:setText(Lang.get(30529))

	self.Stage3_rule = UIControls.Label(self, "Bg/InputPanel/RulePanel/Rule3/TextRule")

	self.Stage3_rule:setText(Lang.get(36330))
end

function BirthdayConfirmDlg:onOpen()
	self:step1_inputBirthDay(0)
	BirthdayConfirmDlg.super.onOpen(self)
end

function BirthdayConfirmDlg:step1_inputBirthDay(action)
	self:sendByteLimitLog(self.curPageIdx, action)

	self.curPageIdx = 1

	self.panelInput:setVisible(true)
	self.panelConfirm:setVisible(false)
	self.btnConfirm:clearEventClick()
	self.btnConfirm:addEventClick(Functor(self.step2_confirmBirthDay, self, 2))
	self.btnCancel:setVisible(true)
	self.btnCancel:clearEventClick()
	self.btnCancel:addEventClick(Functor(self.onCloseDlg, self, true))
end

function BirthdayConfirmDlg:step2_confirmBirthDay(action)
	self:sendByteLimitLog(self.curPageIdx, action)

	self.curPageIdx = 2
	self.year = tonumber(self.inputYear:getText())
	self.month = tonumber(self.inputMonth:getText())

	local curYear = tonumber(os.date("%Y", os.time()))

	if not self.year or not self.month or not (self.year > 1900) or not (curYear > self.year) or not (self.month > 0) or not (self.month < 13) then
		MsgManager.notice(Lang.get(30530))

		return
	end

	self.panelInput:setVisible(false)
	self.panelConfirm:setVisible(true)
	self.panelRule:setVisible(true)
	self.panelSuccess:setVisible(false)
	self.textYear:setText(self.year)
	self.textMonth:setText(self.month)
	self.btnConfirm:clearEventClick()
	self.btnConfirm:addEventClick(Functor(self.step3_showBirthDay, self, 2))
	self.btnCancel:clearEventClick()
	self.btnCancel:addEventClick(Functor(self.step1_inputBirthDay, self, 1))
end

function BirthdayConfirmDlg:step3_showBirthDay(action)
	self:sendByteLimitLog(self.curPageIdx, action)

	self.curPageIdx = 3

	self.panelInput:setVisible(false)
	self.panelConfirm:setVisible(true)
	self.panelRule:setVisible(false)
	self.panelSuccess:setVisible(true)
	self.textYear:setText(self.year)
	self.textMonth:setText(self.month)
	self.btnConfirm:clearEventClick()
	self.btnConfirm:addEventClick(Functor(self.onCloseDlg, self, false))
	self.txtTitle:setText("生年月の登録完了")
	self.btnCancel:setVisible(false)
end

function BirthdayConfirmDlg:onCloseDlg(isCancel)
	self:setVisible(false, true)

	if isCancel then
		return
	end

	local userPayInfo = {}
	local content = {}

	content.birth = self:getBirth()
	userPayInfo.content = ClientUtils.table2String(content)

	SDKAgent.setUserPayInfo(userPayInfo)
end

function BirthdayConfirmDlg:getBirth()
	local month

	if self.month < 10 then
		month = "0" .. self.month
	else
		month = self.month
	end

	return tonumber(self.year .. month .. "01")
end

function BirthdayConfirmDlg:sendByteLimitLog(popupID, action)
	local data = Analytics.getByteSendLogPubParameter()

	data.popup_id = popupID or ""
	data.action = action or ""

	Analytics.sendLogByted("limit_pay", ClientUtils.table2String(data))
end

return BirthdayConfirmDlg
