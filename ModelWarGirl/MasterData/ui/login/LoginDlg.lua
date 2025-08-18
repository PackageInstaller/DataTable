-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\LoginDlg.lua

local LuaToolkit = Framework.Tools.LuaToolkit
local UIControls = require("UI/UIControls")
local UserData = require("Helper/UserData")
local SDKAppUtils = require("SDK/SDKAppUtils")
local UrlConfig = require("Network/UrlConfig")
local SDKConst = require("SDK/SDKConst")
local EventConst = require("EventConst")
local DeviceHelper = require("Helper/DeviceHelper")
local VersionUtils = require("System/VersionUtils")
local SwitchServerHelper = require("Helper/SwitchServerHelper")
local Analytics = require("SDK/Analytics")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local LoginHelper = require("UI/Login/LoginHelper")
local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResLoginCgConfig = require("ClientData/ResLoginCgConfig")
local RemoteConfig = require("Helper/RemoteConfig")
local SvrListManager = SvrListManager
local LoginState = SDKConst.LoginState
local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local Slot = Slot
local Const = Const
local ClientUtils = ClientUtils
local SDKAgent = SDKAgent
local AccountManager = AccountManager
local EventCenter = EventCenter
local UIManager = UIManager
local Timer = Timer
local UIConst = UIConst
local strClassName = "LoginDlg"
local LoginDlg = Class(strClassName, UIControls.Window)
local MIN_TIME_BETWEEN_CONNECT_GAME_SEVER = 5
local INTERACT_CD = 12
local GM_MODE_FORCE_CD = 5
local GM_MODE_FORCE_CLICK = 10
local ChannelID = SDKConst.ChannelID
local PROTOCOL_TYPE = {
	privacy = "privacy",
	thirdParty = "thirdParty",
	agreement = "agreement",
	privacyChildren = "privacyChildren"
}
local SWITCH_POP_AGREEMENT = true
local AGREEMENT_STORAGE = {
	isNotStorage = "false",
	isStorage = "true"
}

LoginDlg.PRE_LOGIN_TICK = DeviceHelper.isIOS() and Const.TICK_PRE_LOGIN_NOTICE_IOS or Const.TICK_PRE_LOGIN_NOTICE_AND

function LoginDlg:ctor()
	self:initUI()

	self._timerEnterBtnAutoRecover = Timer.New(Slot(self.onEnterBtnAutoRecover, self), 3)
	self._timerAutoLogin = Timer.New(Slot(self._onAutoLogin, self), 0.5)
	self._timerSilentRecover = Timer.New(Slot(self._onSilentRecover, self), 5)
	self._lastConnectServerTime = -100
	self._slotLoginCallback = Slot(self.onGetTokenFinish, self)
	self._slotRemoteConfigLoaded = LoginHelper.updateAgreement
	self._slotSelectedServerChanged = Slot(self._onSelectedServerChanged, self)
	self._slotConnSvrSucc = Slot(self.connServerSucc, self)
	self._slotConnSvrFail = Slot(self.connServerFail, self)
	self._slotEnterGame = Slot(self.onEnterGame, self)

	AccountManager.setLoginStateCallback(Slot(self.onLoginStateChange, self))

	self.forceLoginMode = SDKAgent.forceLoginMode
end

function LoginDlg:initUI()
	self.btnEnterGame = UIControls.Button(self, "BtnBgEnter")

	self.btnEnterGame:addEventClick(self.onEnterGame)

	self.btnAccount = UIControls.Button(self, "BtnFunPanel/BtnAccount")

	self.btnAccount:addEventClick(self.onAccountClick)

	self.btnNotice = UIControls.Button(self, "BtnFunPanel/BtnNotice")

	self.btnNotice:addEventClick(self.onNoticeClick)

	self.btnServer = UIControls.Button(self, "BtnFunPanel/BtnServer")

	self.btnServer:addEventClick(self.onServerButtonClick)

	self.btnContact = UIControls.Button(self, "BtnFunPanel/BtnContact")

	self.btnContact:addEventClick(self.onContactClick)

	self.btnReplay = UIControls.Button(self, "BtnFunPanel/BtnPlayerBack")

	self.btnReplay:addEventClick(self.onReplayClick)

	self.panelNoticeReplay = UIControls.Panel(self, "BtnFunPanel/BtnPlayerBack/TipsR")
	self.labelCopyright = UIControls.Label(self, "PanelBg/Text01")
	self.btnDMM = UIControls.Button(self, "BtnFunPanel/BtnDMM")

	self.btnDMM:addEventClick(self.onDMMButtonClick)

	self.txtAgreement_1 = UIControls.Label(self, "AgreementSwitch/Label")
	self.agreementSwitch = UIControls.Toggle(self, "AgreementSwitch")

	self.agreementSwitch:addEventValueChanged(self.onAgreementSelectChanged)

	self.txtAgreement_2 = UIControls.Label(self, "AgreementSwitch/Label2")
	self.btnAgreement = UIControls.Button(self, "AgreementSwitch/BtnAgreement", "Text")

	self.btnAgreement:addEventClick(Functor(self.showAgreement, self, PROTOCOL_TYPE.agreement))

	self.btnPrivacy = UIControls.Button(self, "AgreementSwitch/BtnPrivacy", "Text")

	self.btnPrivacy:addEventClick(Functor(self.showAgreement, self, PROTOCOL_TYPE.privacy))
	self.btnPrivacy:setText(Lang.get(1395))

	self.txtAgreement_3 = UIControls.Label(self, "AgreementSwitch/Label3")
	self.txtAgreement_5 = UIControls.Label(self, "AgreementSwitch/Label5")

	self:_setAgreementText()

	self.btnPrivacyChildren = UIControls.Button(self, "AgreementSwitch/BtnPrivacyChildren", "Text")
	self.btnThirdParty = UIControls.Button(self, "AgreementSwitch/BtnThirdParty", "Text")

	self.btnPrivacyChildren:addEventClick(Functor(self.showAgreement, self, PROTOCOL_TYPE.privacyChildren))
	self.btnThirdParty:addEventClick(Functor(self.showAgreement, self, PROTOCOL_TYPE.thirdParty))

	if RegionUtils.isCN() then
		self.btnPrivacyChildren:setVisible(true)
		self.btnThirdParty:setVisible(true)
	else
		self.btnPrivacyChildren:setVisible(false)
		self.btnThirdParty:setVisible(false)
	end

	self.btnChangeZone = UIControls.Button(self, "BtnChangeZone", "Text")

	self:_setSEAZoneVisible()
	self.btnChangeZone:addEventClick(self._changeSEAZone)

	self.labelVersion = UIControls.Label(self, "PanelBg/Text03")

	self.labelVersion:setText(string.format("App:%s Res:%s", VersionUtils.getVersionName(), VersionUtils.getDocumentPatchVersion()))
	self:reviewVersion()

	if RegionUtils.isCN() then
		self.btnAge = UIControls.Button(self, "BtnAlert")

		self.btnAge:addEventClick(self.onAgeTipClick)
		self.btnAge:setVisible(true)
	end

	self:setupBG()
	self:_setButtonVisiableForMulti()
	self:_setSwitchAccount()

	self.iconLogo = UIControls.Image(self, "LogoPanel/IconLogo")

	self.iconLogo:setImage("Atlas/LogoAtlas", "Logo2")
	self:_applyModification(RegionUtils.isCN())
	self:_setDMMVisiable(false)
end

function LoginDlg:initLoginHelper()
	LoginHelper.Init()
	LoginHelper.updateAgreement()

	if RegionUtils.isKR() or ChannelUtil.isSteam() then
		self.agreementSwitch:setVisible(false)
		LoginHelper.setAgreementIsOn(true)
	end
end

function LoginDlg:reviewVersion()
	if VersionUtils.IsReviewVersion() then
		self.btnContact:setVisible(false)
		self.btnNotice:setVisible(false)
	end
end

function LoginDlg:destroy()
	self._timerEnterBtnAutoRecover:Stop()
	self._timerAutoLogin:Stop()
	AccountManager.setLoginStateCallback(nil)
	LoginDlg.super.destroy(self)
end

function LoginDlg:onOpen()
	LoginDlg.super.onOpen(self)

	local state = GameFsm.getState(Const.STATE_LOGIN)

	if state then
		state:onShowLoginDlg()
	end

	self:initLoginHelper()

	self.inSilentMode = SwitchServerHelper.isSilentLoginThisTime()

	self:_setInteractableVisible(not self.inSilentMode)

	if self.inSilentMode then
		SwitchServerHelper.tryRestoreServerInfo()
		self._timerSilentRecover:Restart()
	end

	if not self.prefabBG then
		self:_connectModelStage()
	end

	if self:isDebugLoginMode() then
		self:showDebugLoginWindow()
	else
		self:hideDebugLoginWindow()
	end

	self:_doAutoAction()
	EventCenter.addEventListener(EventConst.SELECTED_SERVER_CHANGED, self._slotSelectedServerChanged)
	EventCenter.addEventListener(EventConst.ACCOUNT_LOGIN_FINISH, self._slotLoginCallback)
	EventCenter.addEventListener(EventConst.REMOTE_CONFIG_LOADED, self._slotRemoteConfigLoaded)

	if self:isDebugAndInstant() then
		if self.inSilentMode then
			self._timerSilentRecover:Restart()
			self:onEnterGame()
		else
			SvrListManager.requestUpdate(SvrListManager.REQ_TYPE.ENTRY)
		end
	end

	self:initChannelState()
	LoginHelper.tryShowAgreementOnOpen()
	UnityEngine.PlayerPrefs.SetInt("PatchTimeoutKey", 15)
	UnityEngine.PlayerPrefs.SetInt("PatchAutoDownloadSizeDataKey", 10485760)
	self:_tryShowDebugInfo()

	if ResLoginCgConfig[2] and (ResLoginCgConfig[2].time_valid_id == nil or ClientUtils.isTimeConfigPassed(ResLoginCgConfig[2].time_valid_id)) then
		self.multiCg = true

		self.panelNoticeReplay:setVisible(UserData.loadCommonData(Const.UD_KEY_CG) ~= "1")
	end
end

function LoginDlg:onClose()
	EventCenter.removeEventListener(EventConst.SELECTED_SERVER_CHANGED, self._slotSelectedServerChanged)
	EventCenter.removeEventListener(EventConst.ACCOUNT_LOGIN_FINISH, self._slotLoginCallback)
	EventCenter.removeEventListener(EventConst.REMOTE_CONFIG_LOADED, self._slotRemoteConfigLoaded)
	SvrListManager.stopRequest(SvrListManager.REQ_TYPE.ENTRY)
	self.hideDebugLoginWindow()
	LoginDlg.super.onClose(self)
	self._timerSilentRecover:Stop()
end

function LoginDlg:initChannelState()
	if ChannelUtil.getSubChannelID() == ChannelID.SUB_DALAN then
		self:_applyModification(false)
		self:hideLogoPanel(true)
	end
end

function LoginDlg:_setAgreementText()
	if RegionUtils.isJP() then
		self.txtAgreement_1:setText(Lang.get(37131))
		self.txtAgreement_2:setText(Lang.get(37132))
		self.txtAgreement_3:setText("")
		self.txtAgreement_5:setText(Lang.get(37133))
	end
end

function LoginDlg:_applyModification(visible)
	self.labelCopyright:setVisible(visible)
end

function LoginDlg:_setInteractableVisible(visible)
	self.btnEnterGame:setVisible(visible)
	self.btnNotice:setVisible(visible)
	self.btnServer:setVisible(visible)
end

function LoginDlg:_setButtonVisiableForMulti()
	self.btnContact:setVisible(false)
end

function LoginDlg:_tryAutoLogin()
	local stateLogin = GameFsm.getState(Const.STATE_LOGIN)

	if ChannelUtil.isSteam() then
		SDKAgent.login()
	end

	local autoAction = stateLogin and stateLogin:popAutoAction()

	if autoAction == nil then
		return
	end

	if Const.AUTO_LOGIN == autoAction then
		if AccountManager.getLoginState() == LoginState.UNLOGIN then
			self._timerAutoLogin:Restart()
		end
	elseif Const.AUTO_SWITCH_ACCOUNT == autoAction then
		SDKAgent.switchAccount()
	end
end

function LoginDlg:_tryPreDownload()
	local svrNotOpen = os.time() < Const.TICK_PRE_DOWNLOAD

	if svrNotOpen then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(30424), Lang.get(30425), Framework.Download.SubpackageUtils.DownloadForeground, nil, nil, Lang.get(30426), Lang.get(7))

		return true
	end

	return false
end

function LoginDlg:_onAutoLogin()
	if AccountManager.getLoginState() == LoginState.UNLOGIN and self:getAgreementIsOn() then
		self:onEnterGame()
	end
end

function LoginDlg:showDebugLoginWindow()
	UIManager.getUI("debugLogin", true, true)
end

function LoginDlg:hideDebugLoginWindow()
	UIManager.getUI("debugLogin", false, false)
end

function LoginDlg:setEnterButtonEnable(enable)
	self.btnEnterGame:setEnable(enable)

	if enable then
		self._timerEnterBtnAutoRecover:Stop()
	else
		self._timerEnterBtnAutoRecover:Restart()
	end
end

function LoginDlg:onLoginStateChange(oldState, newState)
	if oldState == newState then
		return
	end

	if newState == LoginState.IN_PROCESS then
		self:setEnterButtonEnable(false)
	elseif oldState == LoginState.IN_PROCESS then
		self:setEnterButtonEnable(true)
	end
end

function LoginDlg:_checkAgreement()
	local agree = self:getAgreementIsOn()

	if not agree then
		MsgManager.notice(Lang.get(30427))
	end

	return agree
end

function LoginDlg:onEnterGame(sender)
	if not self:_checkAgreement() then
		return
	end

	local loginState = AccountManager.getLoginState()

	if loginState == LoginState.IN_PROCESS or loginState == LoginState.UNLOGIN then
		if self:isDebugLoginMode() then
			self:_handledByDebugLogin()
		else
			SDKAgent.login()
		end
	elseif loginState == LoginState.LOGIN then
		if self:isDebugLoginMode() and self:_handledByDebugLogin() then
			return
		end

		if self:checkServer() then
			SvrListManager.onPreConnect()
			self:connectServer()
		end
	end
end

function LoginDlg:_handledByDebugLogin()
	local debugLogin = UIManager.getUI("debugLogin", nil, false)

	if debugLogin then
		return debugLogin:login(self._slotEnterGame)
	end

	return false
end

function LoginDlg:checkServer()
	local available = false

	if not SvrListManager.isSelectedSvrValid() then
		if SvrListManager.isRequestRunning(SvrListManager.REQ_TYPE.ENTRY) then
			MsgManager.notice(Lang.get(30428))
		else
			MsgManager.notice(Lang.get(30411))
			self:onServerButtonClick()
		end
	else
		local timeNow = os.time()

		if self._lastConnectServerTime and timeNow - self._lastConnectServerTime < MIN_TIME_BETWEEN_CONNECT_GAME_SEVER then
			MsgManager.notice(Lang.get(30429))
		else
			available = true
		end
	end

	return available
end

function LoginDlg:onForceChangeLog()
	return
end

function LoginDlg:onServerButtonClick(sender)
	local loginState = AccountManager.getLoginState()

	if loginState == LoginState.IN_PROCESS or loginState == LoginState.UNLOGIN then
		if self:isDebugLoginMode() then
			self:showServerList()
		elseif self:_checkAgreement() then
			SDKAgent.login()
		end
	elseif loginState == LoginState.LOGIN then
		self:showServerList()
	end
end

function LoginDlg:showServerList()
	local serverListDlg = UIManager.getUI("servers")

	if serverListDlg then
		serverListDlg:showServers()
	end
end

function LoginDlg:onAccountClick(sender)
	if not self:_checkAgreement() then
		return
	end

	SDKAgent.accountCenter()
end

function LoginDlg:_setSwitchAccount()
	if not SDKAgent.isSupportAccountSwitch() then
		self.btnAccount:setVisible(false)
	else
		self.btnAccount:setVisible(true)
	end
end

function LoginDlg:onNoticeClick(sender)
	SDKAgent.showNotice()
end

function LoginDlg:onContactClick(sender)
	SDKAgent.customerService()
end

function LoginDlg:onReplayClick(sender)
	if self.multiCg then
		UIManager.createUI("loginCgDlg")
		UserData.saveCommonData(Const.UD_KEY_CG, "1")
		self.panelNoticeReplay:setVisible(false)
	else
		UIManager.playLoginCG()
	end
end

function LoginDlg:_setDMMVisiable(needShow)
	self.btnDMM:setVisible(false)
end

function LoginDlg:onDMMButtonClick()
	if VersionUtils.hasAbilityDMMSuccession() then
		local successionCodeTip = UIManager.getUI("successionCodeTipDlg")

		if successionCodeTip then
			successionCodeTip:onOpenStartTip()
		end
	else
		local message = "最新バージョンにアップデートする必要がございます。ショップにてアップデートを行ってください"

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1793), message)
	end
end

function LoginDlg:onAgeTipClick(sender)
	local info = ResInfoNotice[222]
	local title = info and info.title
	local msg = info and info.content

	UIManager.getUI("loginNotice", true, true):showCustom(title, msg)
end

function LoginDlg:connectServer()
	self.startConnTime = os.time()

	AccountManager.connectGameServer(self._slotConnSvrSucc, self._slotConnSvrFail)
	Analytics.onRoleLoginStart()
end

function LoginDlg:onGetTokenFinish(succ, data, hasRetry, querySection)
	if succ then
		if not self:isDebugAndInstant() then
			if self.inSilentMode then
				self._timerSilentRecover:Restart()
				self:onEnterGame()
			else
				self:_tryPreDownload()
				SvrListManager._clearAllCD()
				SvrListManager.requestUpdate(SvrListManager.REQ_TYPE.ENTRY)
			end
		end
	elseif querySection and not hasRetry and #Const.SEA_SECTIONS > 1 then
		UIManager.getUI("ShowZoneDlg", true, true)
	end

	self:_setDMMVisiable(true)
end

function LoginDlg:connServerFail()
	UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(30430), Lang.get(30431))
	LoginHelper.loginBuriedPoint(false, self.startConnTime)
end

function LoginDlg:connServerSucc()
	if RegionUtils.isJP() then
		AccountManager.loginOpenServerAgain_JP()
	end

	LoginHelper.loginBuriedPoint(true, self.startConnTime)
end

function LoginDlg:onEnterBtnAutoRecover()
	if self.btnEnterGame ~= nil then
		self.btnEnterGame:setEnable(true)
	end
end

function LoginDlg:_onSilentRecover()
	self:_setInteractableVisible(true)
end

function LoginDlg:_onSelectedServerChanged()
	if ChannelUtil.isQQGame() and ClientUtils.isFirstOpen() and not LoginDlg._qqFirstTimeLoginDone then
		LoginDlg._qqFirstTimeLoginDone = true

		self:onEnterGame()
	end
end

function LoginDlg:isDebugLoginMode()
	if self._isDebugLoginMode == nil then
		local isDebugLoginMode = false

		if self.forceLoginMode == 0 then
			isDebugLoginMode = true
		elseif self.forceLoginMode == 1 then
			isDebugLoginMode = false
		else
			isDebugLoginMode = true

			if DeviceHelper.isAndroid() and not SDKAppUtils.isUnityPackage() then
				isDebugLoginMode = false
			end

			if IS_PUBLISH_VERSION then
				isDebugLoginMode = false
			end
		end

		self._isDebugLoginMode = isDebugLoginMode
	end

	return self._isDebugLoginMode
end

function LoginDlg:isDebugAndInstant()
	return self:isDebugLoginMode() and SDKAgent.instantModeInDebug
end

function LoginDlg:_doAutoAction()
	if self:isDebugLoginMode() then
		self:_tryPreDownload()
	else
		self:_tryAutoLogin()
	end
end

function LoginDlg:_tryShowDebugInfo()
	if UrlConfig.isPre or LuaToolkit.IsForceIntranet() then
		MsgManager.notice("spmark:" .. LuaToolkit.GetPatchSPMark())
	end
end

function LoginDlg:onAgreementSelectChanged()
	LoginHelper.onAgreementSelectChanged()
end

function LoginDlg:showAgreement(protocol)
	SDKAgent.openAgreement(protocol)
end

function LoginDlg:getAgreementIsOn()
	return UserData.loadCommonData(Const.UD_KEY_AGREEMENT) == "true"
end

function LoginDlg:setAgreementIsOn(isOn)
	self.agreementSwitch:setOn(isOn)
end

function LoginDlg:setupBG()
	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.prefabRoot = UIControls.Panel(self, "OtherFuncPanel")

	local bgInfo = UIConst.getBgChangeInfo("login")

	if bgInfo and bgInfo.prefab_path then
		self.modelViewport:setVisible(false)
		self.prefabRoot:setVisible(true)

		self.bgChild = UIControls.Child(self, "OtherFuncPanel", bgInfo.prefab_path, 0, 0, true)

		if bgInfo.scale_with_height then
			local windowSize = self:getRectSize()

			if windowSize and windowSize.height then
				local height = windowSize.height
				local scale = height / 1080

				self.bgChild:setScale(scale)
			end
		end

		if bgInfo.hide_logo then
			self:hideLogoPanel()
		end

		if bgInfo.change_bgm then
			self:playLogicBGM(bgInfo.change_bgm)
		end

		self.prefabBG = true
	else
		self.modelViewport:setVisible(true)
		self.prefabRoot:setVisible(false)
		self:_createModelStage()

		self.prefabBG = false
	end
end

function LoginDlg:hideLogoPanel(hideAll)
	if not self.logoPanel then
		self.logoPanel = UIControls.Panel(self, "LogoPanel")
	end

	self.logoPanel:setVisible(false)

	if hideAll and self.bgChild and UIControls.checkControlFunc(self.bgChild, "LogoPanel") then
		if not self.childLogoPanel then
			self.childLogoPanel = UIControls.Panel(self.bgChild, "LogoPanel")
		end

		self.childLogoPanel:setVisible(false)
	end
end

function LoginDlg:_createModelStage(...)
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/LoginModelStage")

	self.modelStage:initAnchorModels({
		1,
		2,
		3
	})

	for i = 1, 3 do
		self.modelStage:playAnimByAnchor(i, "IdleSelect", 0)
	end

	self.interactBtn = UIControls.Button(self, "BtnInteract")

	self.interactBtn:addEventClick(self._onClickInteract)
end

function LoginDlg:_connectModelStage(...)
	self.modelStage:connectImage(self.modelViewport)
end

function LoginDlg:_onClickInteract(...)
	local nowTime = Time.time

	if self._lastClickTick and nowTime - self._lastClickTick < INTERACT_CD then
		return
	end

	for i = 1, 4 do
		self.modelStage:playAnimByAnchor(i, "Scare", 0)
	end

	self._lastClickTick = nowTime
end

function LoginDlg:_setSEAZoneVisible()
	if VersionUtils.isSectionEnabled() then
		if ChannelUtil.isSteam() then
			self.btnChangeZone:setVisible(false)
		else
			self.btnChangeZone:setVisible(true)
			self.btnChangeZone:setText(Lang.get(55408))
		end
	end
end

function LoginDlg:_changeSEAZone()
	UIManager.getUI("ShowZoneDlg", true, true)
end

function LoginDlg:_showJPOpreateChangeTips(registTime, lastLoginTime)
	local serverTime = ClientUtils.getServerTime()
	local timeA = tonumber(RemoteConfig.getValue(Const.REMOTE_CONFIG_KEY_JP_TIME_A)) or Const.TIMESTAMP_2099_2_16
	local timeB = tonumber(RemoteConfig.getValue(Const.REMOTE_CONFIG_KEY_JP_TIME_B)) or Const.TIMESTAMP_2099_2_24

	if timeB <= serverTime then
		if registTime < timeB and lastLoginTime < timeA then
			local notice = UIManager.getUI("confirmNotice")

			if notice then
				notice:show()
			end
		end
	elseif timeA <= serverTime and serverTime < timeB then
		local operateChangeTipsJP = UserData.loadCommonData("operateChangeTipsJP")

		if operateChangeTipsJP ~= "showed" then
			local notice = UIManager.getUI("confirmNotice")

			if notice then
				notice:show()
			end
		end
	end
end

return LoginDlg
