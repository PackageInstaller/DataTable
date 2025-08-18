-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\FlowSDK\\FlowAccountCenterDlg.lua

local SDKConst = require("SDK/SDKConst")
local SDKImpFlow = require("SDK/SDKImp/SDKImpFlow")
local UrlConfig = require("Network/UrlConfig")
local EventConst = require("EventConst")
local UserData = require("Helper/UserData")
local OpenServerConst = require("Network/OpenServerConst")
local MsgManager = MsgManager
local Const = Const
local EventCenter = EventCenter
local SvrListManager = SvrListManager
local HttpUtils = Framework.Network.HttpUtils
local ResponseCode = SDKConst.ResponseCode
local strClassName = "FlowAccountCenterDlg"
local FlowAccountCenterDlg = Class(strClassName, UIControls.Window)
local FlowInputMobilePanel = Class("FlowInputMobilePanel", UIControls.Panel)

FlowInputMobilePanel.CD_CODE_SUCC = 60
FlowInputMobilePanel.CD_CODE_FAIL = 3

function FlowInputMobilePanel:ctor()
	self:initUI()

	self._timerCountdown = Timer.New(Slot(self._refreshSendButton, self), 1, -1)

	self:_refreshSendButton()
end

function FlowInputMobilePanel:initUI()
	self.inputMobile = UIControls.Input(self, self.mPath .. "/InputUsername")
	self.inputCode = UIControls.Input(self, self.mPath .. "/InputPasswordCode")
	self.btnSendCode = UIControls.Button(self, self.mPath .. "/SendSmsCodeButton", "Text")

	self.btnSendCode:addEventClick(Slot(self._onSendCode, self))

	self._btnSendCodeActiveCache = true
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/FuncButton", "Text")

	self.btnConfirm:addEventClick(Slot(self._onConfirmCode, self))
end

function FlowInputMobilePanel:setConfirmText(text)
	self.btnConfirm:setText(text)
end

function FlowInputMobilePanel:_onConfirmCode()
	local mobile = self.inputMobile:getText()
	local code = self.inputCode:getText()

	if not ClientUtils.isMobile(mobile) then
		MsgManager.notice(Lang.get(30296))
	elseif code == nil or #code == 0 then
		MsgManager.notice(Lang.get(30297))
	else
		if self._requestBindTime ~= nil and self._requestBindTime + 5 > Time.time then
			return
		end

		self._requestBindTime = Time.time

		self.mParent:requestBind(mobile, code)
	end
end

function FlowInputMobilePanel:_onSendCode()
	local mobile = self.inputMobile:getText()

	if not ClientUtils.isMobile(mobile) then
		MsgManager.notice(Lang.get(30296))
	else
		self.mParent:genSmsCode(mobile)
		self:_setDisableTime(FlowInputMobilePanel.CD_CODE_SUCC)
	end
end

function FlowInputMobilePanel:_setDisableTime(sec)
	self:_setSendCodeActive(false)

	FlowInputMobilePanel._cooldown = Time.time + sec

	self._timerCountdown:Restart()
	self:_refreshSendButton()
end

function FlowInputMobilePanel:_refreshSendButton()
	local timeLeft = -1

	if FlowInputMobilePanel._cooldown ~= nil then
		timeLeft = FlowInputMobilePanel._cooldown - Time.time
	end

	if timeLeft <= 0 then
		self._timerCountdown:Stop()
		self:_setSendCodeActive(true)
		self.btnSendCode:setText(Lang.get(1363))
	else
		self:_setSendCodeActive(false)
		self.btnSendCode:setText(math.floor(timeLeft + 0.5))

		if not self._timerCountdown:IsRunning() then
			self._timerCountdown:Restart()
		end
	end
end

function FlowInputMobilePanel:_setSendCodeActive(active)
	if self._btnSendCodeActiveCache ~= active then
		self._btnSendCodeActiveCache = active

		self.btnSendCode:setEnable(active)
	end
end

local DialogState = {
	SUCC = 3,
	INPUT_MOBILE = 1,
	INPUT_SMS_CODE = 2,
	NONE = 0
}

function FlowAccountCenterDlg:ctor()
	self:initUI()

	self._stateStack = {}
	self._lastState = nil
	self._slotGenSmsCodeFinish = Slot(self._onGenSmsCodeFinish, self)
	self._slotLoginFinish = Slot(self._onLoginFinish, self)
	self._sdk = SDKImpFlow.GetInstance()
end

function FlowAccountCenterDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self._onClickClose)

	self.panelInputMobile = FlowInputMobilePanel(self, "BgPanel/PhoneNumberPanel")
	self.labelTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.statePanel = {
		[DialogState.INPUT_MOBILE] = self.panelInputMobile
	}

	for i, panel in ipairs(self.statePanel) do
		panel:setVisible(false)
	end
end

function FlowAccountCenterDlg:setSmsPurpose(purpose)
	self._purpose = purpose
	self._isRecordMobile = self._purpose == OpenServerConst.SMS_CODE_PURPOSE_RECORD

	local funcText = self._isRecordMobile and Lang.get(30298) or Lang.get(1360)

	self.labelTitle:setText(funcText)
	self.panelInputMobile:setConfirmText(Lang.get(30299))
end

function FlowAccountCenterDlg:onOpen()
	FlowAccountCenterDlg.super.onOpen(self)
	self:_initState()
	EventCenter.addEventListener(EventConst.ACCOUNT_LOGIN_FINISH, self._slotLoginFinish)
end

function FlowAccountCenterDlg:onClose()
	EventCenter.removeEventListener(EventConst.ACCOUNT_LOGIN_FINISH, self._slotLoginFinish)
	self.panelInputMobile._timerCountdown:Stop()
	FlowAccountCenterDlg.super.onClose(self)
end

function FlowAccountCenterDlg:_onClickClose()
	self:setVisible(false)
end

function FlowAccountCenterDlg:requestBind(mobile, code)
	if self._isRecordMobile then
		self._sdk:requestRecordMobile(mobile, code)
	else
		self._sdk:bindGuestWithMobile(mobile, code)
	end
end

function FlowAccountCenterDlg:genSmsCode(mobile)
	self._sdk:genSmsCode(mobile, self._purpose, self._slotGenSmsCodeFinish)
end

function FlowAccountCenterDlg:_initState()
	self:_clearState()
	self:_enterState(DialogState.INPUT_MOBILE)
end

function FlowAccountCenterDlg:_enterState(newState)
	local stateStack = self._stateStack
	local oldState = stateStack[1]

	if oldState == newState then
		return
	end

	self._lastState = oldState

	local oldIndex

	for i, state in ipairs(stateStack) do
		if state == newState then
			oldIndex = i

			break
		end
	end

	if oldIndex then
		table.remove(stateStack, oldIndex)
	end

	table.insert(stateStack, 1, newState)
	self:_refresh()
end

function FlowAccountCenterDlg:_shiftState()
	if #self._stateStack > 0 then
		self._lastState = self._stateStack[1]

		table.remove(self._stateStack, 1)
	end
end

function FlowAccountCenterDlg:_removeState(targetState)
	local stateStack = self._stateStack
	local index

	for i, state in ipairs(stateStack) do
		if state == targetState then
			index = i

			break
		end
	end

	if index then
		table.remove(stateStack, index)
	end
end

function FlowAccountCenterDlg:_clearState()
	self._stateStack = {}
end

function FlowAccountCenterDlg:_refresh()
	self:_refreshState()
end

function FlowAccountCenterDlg:_refreshState()
	local oldState = self._lastState

	if oldState then
		self:_setStateActive(oldState, false)
	end

	local state = self._stateStack[1]

	if state == nil then
		self:_initState()

		state = self._stateStack[1]
	end

	self:_setStateActive(state, true)
end

function FlowAccountCenterDlg:_setStateActive(state, active)
	local panel = self.statePanel[state]

	if panel then
		panel:setVisible(active)

		if panel.refreshData ~= nil then
			panel:refreshData()
		end
	end
end

function FlowAccountCenterDlg:_onGenSmsCodeFinish(succ, code)
	local dlg = UIManager.getUI("flowAccountCenter", nil, false)

	if not succ and dlg ~= nil then
		dlg.panelInputMobile:_setDisableTime(FlowInputMobilePanel.CD_CODE_FAIL)
	end
end

function FlowAccountCenterDlg:_onLoginFinish(succ)
	if succ then
		self:setVisible(false)
	end
end

return FlowAccountCenterDlg
