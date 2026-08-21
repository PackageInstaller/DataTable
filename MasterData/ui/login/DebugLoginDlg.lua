-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\DebugLoginDlg.lua

local strClassName = "DebugLoginDlg"
local DebugLoginDlg = Class(strClassName, UIControls.Window)
local UserData = require("Helper/UserData")
local MsgManager = MsgManager
local Const = Const
local SvrListManager = SvrListManager
local KEY_DEBUG_LOGIN_NAME = "debug_login_name"
local KEY_DEBUG_LOGIN_AUTO = "debug_login_auto"

function DebugLoginDlg:ctor()
	self.savedName = nil
	self.inputUsername = UIControls.Input(self, "PanelInput/InputPlayer")
	self.inputPassword = UIControls.Input(self, "PanelInput/InputPassword")
	self.toggleAutoLogin = UIControls.Toggle(self, "PanelInput/InputPlayer/AutoLogin")
	self._selectServerInfo = nil
	self._slotLoginCallback = Slot(self.onLoginCallback, self)
end

function DebugLoginDlg:onOpen()
	self.savedName = UserData.loadCommonData(KEY_DEBUG_LOGIN_NAME)
	self.recordAutoLogin = DebugLoginDlg.isAutoLogin()

	self.toggleAutoLogin:setOn(self.recordAutoLogin)

	if self.inputUsername:getText() == "" and self.savedName ~= nil then
		self.inputUsername:setText(self.savedName)
	end

	if self.toggleAutoLogin:isOn() then
		self:login()
	end
end

function DebugLoginDlg:login(callback)
	self._loginCallback = callback

	local username = self.inputUsername:getText()
	local password = self.inputPassword:getText()
	local ret = false

	if username == nil or username == "" then
		MsgManager.notice(Lang.get(30410))

		ret = true
	elseif self._curUserName ~= username or self._lastDebugLoginTime ~= nil and self._lastDebugLoginTime + 60 < os.time() then
		self._lastDebugLoginTime = os.time()

		local serverInfo = SvrListManager.getSelectedSvrInfo()

		if serverInfo and serverInfo.isValid then
			SDKAgent.debugLogin(username, password, self._slotLoginCallback)

			self._curUserName = username

			local serverData = ClientUtils.table2String(serverInfo.data)

			UserData.saveCommonData("LastServer", serverData)

			ret = true
		else
			MsgManager.notice(Lang.get(30411))

			local loginDlg = UIManager.tryGetUI("login")

			if loginDlg then
				loginDlg:onServerButtonClick()
			end
		end
	end

	return ret
end

function DebugLoginDlg:onLoginCallback(succ)
	if succ and SDKAgent.instantModeInDebug and self._loginCallback then
		self._loginCallback()

		self._loginCallback = nil

		self:_onLoginSucc()
	end
end

function DebugLoginDlg:_onLoginSucc()
	local name = self.inputUsername:getText()
	local isAutoLogin = self.toggleAutoLogin:isOn()

	if self.savedName ~= name then
		self.savedName = name

		UserData.saveCommonData(KEY_DEBUG_LOGIN_NAME, name)
	end

	if self.recordAutoLogin ~= isAutoLogin then
		self.recordAutoLogin = isAutoLogin

		DebugLoginDlg.setAutoLogin(isAutoLogin)
	end
end

function DebugLoginDlg.setAutoLogin(enabled)
	UserData.saveCommonData(KEY_DEBUG_LOGIN_AUTO, enabled and "1" or "")
end

function DebugLoginDlg.isAutoLogin()
	return false
end

return DebugLoginDlg
