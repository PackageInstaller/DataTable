-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\FlowSDK\\FlowLoginDlg.lua

local strClassName = "FlowLoginDlg"
local FlowLoginDlg = Class(strClassName, UIControls.Window)
local SDKConst = require("SDK/SDKConst")
local FlowSDKImp = require("SDK/SDKImp/SDKImpFlow")
local OpenServerConst = require("Network/OpenServerConst")
local UrlConfig = require("Network/UrlConfig")
local EventConst = require("EventConst")
local UserData = require("Helper/UserData")
local HttpUtils = Framework.Network.HttpUtils
local ResponseCode = SDKConst.ResponseCode
local MsgManager = MsgManager
local NetService = require("Network/NetService")
local Const = Const
local EventCenter = EventCenter
local FlowAccountTypePanel = Class("FlowAccountTypePanel", UIControls.Panel)

function FlowAccountTypePanel:ctor()
	self:initUI()
end

function FlowAccountTypePanel:initUI()
	self.btnGuest = UIControls.Button(self, self.mPath .. "/BtnGuest")

	self.btnGuest:addEventClick(Slot(self.mParent.loginDeviceID, self.mParent))

	self.btnMobile = UIControls.Button(self, self.mPath .. "/BtnMobile")

	self.btnMobile:addEventClick(Slot(self.mParent.onClickMobile, self.mParent))

	self.labelTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
end

local FlowInputMobilePanel = Class("FlowInputMobilePanel", UIControls.Panel)

function FlowInputMobilePanel:ctor()
	self:initUI()
end

function FlowInputMobilePanel:initUI()
	self.inputMobile = UIControls.Input(self, self.mPath .. "/InputUsername")
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/LoginButton")

	self.btnConfirm:addEventClick(Slot(self._onConfirmMobile, self))
end

function FlowInputMobilePanel:_onConfirmMobile()
	local mobile = self.inputMobile:getText()

	if not ClientUtils.isMobile(mobile) then
		MsgManager.notice(Lang.get(30296))

		return
	end

	self.mParent:onConfirmMobile(mobile)
end

local FlowInputeSmsCodePanel = Class("FlowInputeSmsCodePanel", UIControls.Panel)

function FlowInputeSmsCodePanel:ctor()
	self._timerCountdown = Timer.New(Slot(self._onSendCodeCountdown, self), 1, -1)
	self._countdown = 0

	self:initUI()
end

function FlowInputeSmsCodePanel:initUI()
	self.labelDesc = UIControls.Label(self, self.mPath .. "/TextDes")
	self.inputCode = UIControls.Input(self, self.mPath .. "/SmsCodeGroup/InputSmsCode")
	self.btnSendCode = UIControls.Button(self, self.mPath .. "/SmsCodeGroup/SendSmsCodeButton")

	self.btnSendCode:addEventClick(Slot(self._onSendCode, self))

	self.labelSendCode = UIControls.Label(self, self.mPath .. "/SmsCodeGroup/SendSmsCodeButton/Text")
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/LoginButton")
	self.btnHelp = UIControls.Button(self, self.mPath .. "/HelpButton")

	self.btnHelp:setVisible(false)
	self.btnConfirm:addEventClick(Slot(self._onConfirmCode, self))
end

function FlowInputeSmsCodePanel:refreshData()
	local mobile = self.mParent._curMobile

	if mobile ~= nil then
		self.labelDesc:setText(string.format(Lang.get(30300), mobile))
	end
end

function FlowInputeSmsCodePanel:_onSendCode()
	self.mParent:genSmsCode()
	self.btnSendCode:setEnable(false)

	self._countdown = 60

	self:_onSendCodeCountdown()
	self._timerCountdown:Restart()
end

function FlowInputeSmsCodePanel:_onConfirmCode()
	local code = self.inputCode:getText()

	if code == nil or #code == 0 then
		MsgManager.notice(Lang.get(30297))

		return
	end

	self.mParent:onConfirmCode(code)
end

function FlowInputeSmsCodePanel:_onSendCodeCountdown()
	self._countdown = self._countdown - 1

	if self._countdown <= 0 then
		self._timerCountdown:Stop()
		self.btnSendCode:setEnable(true)
		self.labelSendCode:setText(Lang.get(30301))
	else
		self.labelSendCode:setText(self._countdown)
	end
end

function FlowInputeSmsCodePanel:onClose()
	self._timerCountdown:Stop()
end

local MobileCell = Class("MobileCell", UIControls.ScrollViewLoopCell)

function MobileCell:ctor(scrollLoop, prefabPath, width, height, idx, parentPanel)
	self:initUI()

	self.parentPanel = parentPanel
end

function MobileCell:initUI()
	self.labelAccount = UIControls.Label(self, "TextAccount")
	self.imgAccount = UIControls.Image(self, "IconAccount")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(Slot(self._onClickClose, self))

	self.btnSelect = UIControls.Button(self, "")

	self.btnSelect:addEventClick(Slot(self._onClickSelect, self))
end

function MobileCell:_onClickClose()
	self.parentPanel:removeEntry(self.accountInfo.entryID)
end

function MobileCell:_onClickSelect()
	self.parentPanel:selectEntry(self.accountInfo.entryID)
end

function MobileCell:setData(accountInfo, index)
	self.accountInfo = accountInfo
	self.idx = index

	self.labelAccount:setText(accountInfo.entryName)
	self.imgAccount:setImage("Atlas/LoginAtlas/LoginAtlas", accountInfo.isMobile and "IconMobile" or "IconVisitor")
end

local FlowChooseAccountPanel = Class("FlowChooseAccountPanel", UIControls.Panel)

function FlowChooseAccountPanel:ctor()
	self:initUI()

	self._cells = {}
	self._sdk = FlowSDKImp.GetInstance()
end

function FlowChooseAccountPanel:initUI()
	self.labelTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.labelAccount = UIControls.Label(self, "TextAccount")
	self.imgAccount = UIControls.Image(self, "IconAccount")
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/LoginButton")

	self.btnConfirm:addEventClick(Slot(self._onConfirm, self))

	self.btnShowList = UIControls.Button(self, self.mPath .. "/AccountButton")

	self.btnShowList:addEventClick(Slot(self._onPickMobile, self))

	self.btnChooseType = UIControls.Button(self, self.mPath .. "/OtherAccountButton")

	self.btnChooseType:addEventClick(Slot(self._onClickChooseType, self))

	self.scrollMoblie = UIControls.ScrollViewLoopV(self, self.mPath .. "/AccountButton/AccountScrollLoopVertical", 0, self.initItem)

	self.scrollMoblie:setVisible(false)
end

function FlowChooseAccountPanel:_onPickMobile()
	self:setCrollVisible(not self.scrollMoblie:getVisible())
end

function FlowChooseAccountPanel:_onClickChooseType()
	self.mParent:onClickChooseType()
end

function FlowChooseAccountPanel:_onConfirm()
	if self.selectedAccount then
		self.mParent:loginSavedToken(self.selectedAccount.entryID)
	end
end

function FlowChooseAccountPanel:initItem(sender, targetCell, newIdx)
	targetCell = targetCell or MobileCell(sender, "System/Login/AccountCell", 0, 0, newIdx, self)

	if not self.data or #self.data == 0 then
		return
	end

	if self.data[newIdx] ~= nil then
		local accountInfo = self.data[newIdx]

		targetCell:setData(accountInfo, newIdx)
	end

	self._cells[newIdx] = targetCell
end

function FlowChooseAccountPanel:removeEntry(mobile)
	self._sdk:removeEntry(mobile)
	self:refreshData()
end

function FlowChooseAccountPanel:selectEntry(mobile)
	self:setCrollVisible(false)

	self.mParent._curMobile = mobile

	self._sdk:selectEntry(mobile)
	self:refreshData()
end

function FlowChooseAccountPanel:refreshData()
	local accountList = self._sdk:getAccountList()

	if accountList == nil or #accountList == 0 then
		self.mParent:onChooseMobileEmpty()

		return
	end

	if accountList then
		self.data = accountList

		if self.scrollMoblie:getVisible() then
			self.scrollMoblie:setTotalCount(#self.data, true)
		end
	end

	self:setSelectedAccount(accountList and accountList[1])
end

function FlowChooseAccountPanel:setSelectedAccount(accountInfo)
	self.selectedAccount = accountInfo

	self.labelAccount:setText(accountInfo.entryName or "")
	self.imgAccount:setImage("Atlas/LoginAtlas/LoginAtlas", accountInfo.isMobile and "IconMobile" or "IconVisitor")
end

function FlowChooseAccountPanel:setCrollVisible(visible)
	self.scrollMoblie:setVisible(visible)

	if visible then
		self.scrollMoblie:setTotalCount(#self.data, true)
	end
end

local DialogState = {
	CHOOSE_ACCOUNT = 2,
	INPUT_MOBILE = 3,
	INPUT_SMS_CODE = 4,
	CHOOSE_ACCOUNT_TYPE = 1,
	NONE = 0
}

function FlowLoginDlg:ctor()
	self:initUI()

	self._stateStack = {}
	self._lastState = nil
	self._slotGenSmsCodeFinish = Slot(self._onGenSmsCodeFinish, self)
	self._slotLoginFinish = Slot(self._onLoginFinish, self)
	self._slotDataChanged = Slot(self._onDataChanged, self)
	self._sdk = FlowSDKImp.GetInstance()
end

function FlowLoginDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BaseDialog/BtnClose")

	self.btnClose:addEventClick(self._onClickClose)

	self.btnBack = UIControls.Button(self, "BgPanel/BaseDialog/BtnBack")

	self.btnBack:addEventClick(self._onClickBack)

	self.panelAccountType = FlowAccountTypePanel(self, "BgPanel/AccountDialog")
	self.panelInputMobile = FlowInputMobilePanel(self, "BgPanel/LoginDialog")
	self.panelInputCode = FlowInputeSmsCodePanel(self, "BgPanel/PasswordDialog")
	self.panelChooseMobile = FlowChooseAccountPanel(self, "BgPanel/ChooseAccountDialog")
	self.statePanel = {
		[DialogState.CHOOSE_ACCOUNT_TYPE] = self.panelAccountType,
		[DialogState.CHOOSE_ACCOUNT] = self.panelChooseMobile,
		[DialogState.INPUT_MOBILE] = self.panelInputMobile,
		[DialogState.INPUT_SMS_CODE] = self.panelInputCode
	}

	for i, panel in ipairs(self.statePanel) do
		panel:setVisible(false)
	end
end

function FlowLoginDlg:onOpen()
	FlowLoginDlg.super.onOpen(self)
	EventCenter.addEventListener(EventConst.ACCOUNT_LOGIN_FINISH, self._slotLoginFinish)
	self._sdk:setDataChangedCallback(self._slotDataChanged)
	self:_initState()
end

function FlowLoginDlg:onClose()
	EventCenter.removeEventListener(EventConst.ACCOUNT_LOGIN_FINISH, self._slotLoginFinish)
	self._sdk:setDataChangedCallback(nil)

	for i, panel in ipairs(self.statePanel) do
		if panel.onClose then
			panel:onClose()
		end
	end

	FlowLoginDlg.super.onClose(self)
end

function FlowLoginDlg:_onClickClose()
	self:setVisible(false)
end

function FlowLoginDlg:_onClickBack()
	self:_shiftState()
	self:_refresh()
end

function FlowLoginDlg:onClickMobile()
	self:_enterState(DialogState.INPUT_MOBILE)
end

function FlowLoginDlg:onClickChooseType()
	self:_enterState(DialogState.CHOOSE_ACCOUNT_TYPE)
end

function FlowLoginDlg:onConfirmMobile(mobile)
	self._curMobile = mobile

	self:_enterState(DialogState.INPUT_SMS_CODE)
end

function FlowLoginDlg:onConfirmCode(code)
	self._sdk:loginSmsCode(self._curMobile, code)
end

function FlowLoginDlg:onChooseMobileEmpty()
	self:_enterState(DialogState.CHOOSE_ACCOUNT_TYPE)
end

function FlowLoginDlg:genSmsCode()
	if self._curMobile ~= nil then
		self._sdk:genSmsCode(self._curMobile, OpenServerConst.SMS_CODE_PURPOSE_VERIFY, self._slotGenSmsCodeFinish)
	end
end

function FlowLoginDlg:loginDeviceID()
	self._curMobile = nil

	self._sdk:loginDeviceID()
end

function FlowLoginDlg:loginSavedToken(mobile)
	self._sdk:loginSavedToken(mobile)
end

function FlowLoginDlg:_initState()
	self:_clearState()

	local accountList = self._sdk:getAccountList()

	if accountList ~= nil and #accountList > 0 then
		self:_enterState(DialogState.CHOOSE_ACCOUNT)
	else
		self:_enterState(DialogState.CHOOSE_ACCOUNT_TYPE)
	end
end

function FlowLoginDlg:_enterState(newState)
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

function FlowLoginDlg:_shiftState()
	if #self._stateStack > 0 then
		self._lastState = self._stateStack[1]

		table.remove(self._stateStack, 1)
	end
end

function FlowLoginDlg:_removeState(targetState)
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

function FlowLoginDlg:_clearState()
	self._stateStack = {}
end

function FlowLoginDlg:_refresh()
	self:_refreshState()
	self:_refreshBack()
end

function FlowLoginDlg:_refreshBack()
	local showBack = #self._stateStack > 1

	self.btnBack:setVisible(showBack)
end

function FlowLoginDlg:_refreshState()
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

function FlowLoginDlg:_setStateActive(state, active)
	local panel = self.statePanel[state]

	if panel then
		panel:setVisible(active)

		if panel.refreshData ~= nil then
			panel:refreshData()
		end
	end
end

function FlowLoginDlg:_onGenSmsCodeFinish(code, content)
	if ResponseCode.SUCC == code then
		MsgManager.notice(Lang.get(30009))
	end
end

function FlowLoginDlg:_onLoginFinish(succ)
	if succ then
		self:setVisible(false)
	end
end

function FlowLoginDlg:_onDataChanged()
	self:_refresh()
end

return FlowLoginDlg
