-- chunkname: @modules/logic/login/view/LoginView.lua

module("modules.logic.login.view.LoginView", package.seeall)

local LoginView = class("LoginView", BaseView)
local ResultCodeSdkExpired = -8
local profilerTogglePressTimeDebug = 3
local profilerTogglePressTime = 10

function LoginView:ctor()
	self._loginFlow = nil
	self._httpStartGameFlow = nil
end

function LoginView:onInitView()
	self._serverGO = gohelper.findChild(self.viewGO, "server")
	self._txtServerName = gohelper.findChildText(self._serverGO, "Text")
	self._txt_version = gohelper.findChildText(self.viewGO, "#txt_version")
	self._serverStateGOList = {}

	for i = 0, 2 do
		self._serverStateGOList[i] = gohelper.findChild(self.viewGO, "server/imgState" .. i)
	end

	self._btnServerList = gohelper.findChildButtonWithAudio(self.viewGO, "server/btnServerList")
	self._btnLogin = gohelper.findChildButtonWithAudio(self.viewGO, "center_text/btnLogin")
	self._btnPolicy = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtn_group/#btn_policy")
	self._btnAccount = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtn_group/#btn_account")
	self._btnNotice = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtn_group/#btn_notice")
	self._goBtnNotice = gohelper.findChild(self.viewGO, "rightbtn_group/#btn_notice")
	self._btnNoticeLongPress = SLFramework.UGUI.UILongPressListener.Get(self._goBtnNotice)
	self._btnFix = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtn_group/#btn_fix")
	self._btnScan = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtn_group/#btn_scan")
	self._originBgGo = gohelper.find("UIRoot/OriginBg")
	self._goClickMask = gohelper.findChild(self.viewGO, "click_mask")
	self._goEffect = gohelper.findChild(self.viewGO, "imgBg/effect")
	self._imgLogo = gohelper.findChildSingleImage(self.viewGO, "logo")
	self._btnAgeFit = gohelper.findChildButtonWithAudio(self.viewGO, "leftbtn/#btn_agefit")
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtn_group/#btn_exit")
end

function LoginView:addEvents()
	self._btnServerList:AddClickListener(self._onClickServerList, self)
	self._btnLogin:AddClickListener(self._onClickLogin, self)
	self._btnAccount:AddClickListener(self._onClickAccount, self)
	self._btnNotice:AddClickListener(self._onClickNotice, self)
	self._btnFix:AddClickListener(self._onClickFix, self)
	self._btnScan:AddClickListener(self._onClickScan, self)
	self._btnPolicy:AddClickListener(self._onClickPolicy, self)
	self._btnAgeFit:AddClickListener(self._onClickAgeFit, self)
	self._btnexit:AddClickListener(self.exit, self)
	self.addEventCb(self, LoginController.instance, LoginEvent.SelectServerItem, self._onSelectServerItem, self)
	self.addEventCb(self, LoginController.instance, LoginEvent.OnSdkLoginReturn, self._onSdkLoginReturn, self)
	self.addEventCb(self, LoginController.instance, LoginEvent.SystemLoginFail, self._onSystemLoginFail, self)
	self.addEventCb(self, LoginController.instance, LoginEvent.OnLogout, self._onLoginOut, self)
	self.addEventCb(self, LoginController.instance, LoginEvent.OnLoginBgLoaded, self._onBgLoaded, self)

	local var_3_0 = {
		nil,
		1
	}

	if isDebugBuild then
		var_3_0[1] = profilerTogglePressTimeDebug or profilerTogglePressTime
	end

	self._btnNoticeLongPress:SetLongPressTime(var_3_0)
	self._btnNoticeLongPress:AddLongPressListener(self._onNoticeLongPress, self)
end

function LoginView:removeEvents()
	self._btnServerList:RemoveClickListener()
	self._btnLogin:RemoveClickListener()
	self._btnAccount:RemoveClickListener()
	self._btnNotice:RemoveClickListener()
	self._btnFix:RemoveClickListener()
	self._btnScan:RemoveClickListener()
	self._btnPolicy:RemoveClickListener()
	self._btnAgeFit:RemoveClickListener()
	self._btnexit:RemoveClickListener()
	self._btnNoticeLongPress:RemoveLongPressListener()
	TaskDispatcher.cancelTask(self._delayForLogout, self)
	TaskDispatcher.cancelTask(self._endSdkBlock, self)
	TaskDispatcher.cancelTask(self._onLoginTimeout, self)
	TaskDispatcher.cancelTask(self._startLoginFlow, self)
	TaskDispatcher.cancelTask(self._login, self)
	TaskDispatcher.cancelTask(self._sdkRelogin, self)
	TaskDispatcher.cancelTask(self._startGameAfterCanvasFade, self)
	TaskDispatcher.cancelTask(self._onOpenAnimDone, self)
	TaskDispatcher.cancelTask(self._onClickLogin, self)
end

function LoginView:onOpen()
	self._sdkLoginSucc = SDKMgr.instance:isLoginSuccess()

	BootResMgr.instance:dispose()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
	TaskDispatcher.runDelay(self._onOpenAnimDone, self, 0.333)
	self._imgLogo:LoadImage(ResUrl.getLoginBgLangIcon("bg_logo"), self._onLogoLoaded, self)
	gohelper.addUIClickAudio(self._btnLogin.gameObject, AudioEnum.UI.UI_Common_Click)

	self._serverMO = ServerMO.New()
	self._serverMO.id = 1
	self._serverMO.name = ""
	self._serverMO.state = 0

	local versionName = UnityEngine.Application.version
	local resourceName = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local buildId = BootNativeUtil.getAppVersion()

	self._txt_version.text = string.format("V%s-%s-%s", versionName, resourceName, tostring(buildId))

	self:_updateServerInfo()

	local isQQ = tostring(SDKMgr.instance:getChannelId()) == "102"

	gohelper.setActive(self._btnAgeFit.gameObject, not isQQ)
	gohelper.setActive(self._goClickMask, false)
	NavigateMgr.instance:addEscape(self.viewName, self._onEscapeBtnClick, self, false)

	if self.viewParam and self.viewParam.isModuleLogout then
		if self.viewParam.isSdkLogout then
			self:_showEnterGameBtn(false, isQQ)
		else
			self:_showEnterGameBtn(true)
			self:_startLoginFlow()
		end
	else
		self:_showEnterGameBtn(false, isQQ)
	end

	gohelper.setActive(self._btnexit, BootNativeUtil.isWindows())
end

function LoginView:_onOpenAnimDone()
	self._openAnimDone = true

	self:_checkOpenDone()
end

function LoginView:_onLogoLoaded()
	self._logoLoaded = true

	self:_checkOpenDone()
end

function LoginView:_onBgLoaded()
	if not self._bgLoaded then
		self._bgLoaded = true

		self:_checkOpenDone()
	end
end

function LoginView:_checkOpenDone()
	if self._openAnimDone and self._logoLoaded and self._bgLoaded then
		TaskDispatcher.runDelay(self._login, self, 0.01)
	end
end

function LoginView:_login()
	if SDKMgr.instance:useSimulateLogin() then
		ViewMgr.instance:closeView(ViewName.ServerListView)
		ViewMgr.instance:openView(ViewName.SimulateLoginView)
	else
		SDKMgr.instance:login()
	end
end

function LoginView:_startSdkBlock()
	if BootNativeUtil.isWindows() then
		UIBlockMgrExtend.setNeedCircleMv(false)
	else
		UIBlockMgrExtend.CircleMvDelay = 5
	end

	UIBlockMgr.instance:startBlock(UIBlockKey.SdkLogin)
end

function LoginView:_endSdkBlock()
	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.SdkLogin)
end

function LoginView:_logout(userManualLogout)
	if SDKMgr.instance:useSimulateLogin() then
		ViewMgr.instance:openView(ViewName.SimulateLoginView)
	else
		self._webLoginSuccess = nil

		LoginController.instance:sdkLogout(userManualLogout)
	end
end

function LoginView:exit()
	GameFacade.showMessageBox(MessageBoxIdDefine.exitGame, MsgBoxEnum.BoxType.Yes_No, function()
		ProjBooter.instance:quitGame()
	end)
end

function LoginView:onClose()
	self:_clearState()
end

function LoginView:onUpdateParam()
	self:_showEnterGameBtn(true)
	self:_startLoginFlow()
end

function LoginView:_startLoginFlow()
	if self._loginFlow then
		return
	end

	self._loginFlow = FlowSequence.New()

	if SDKMgr.instance:useSimulateLogin() then
		self._loginFlow:addWork(SimulateLoginWork.New())
	end

	self._loginFlow:addWork(CheckVersionWork.New())
	self._loginFlow:addWork(WebLoginWork.New())
	self._loginFlow:registerDoneListener(self._onLoginDone, self)
	self._loginFlow:start({
		useBackupUrl = LoginModel.instance:getUseBackup()
	})
	UIBlockMgr.instance:startBlock(UIBlockKey.WebLogin)
end

function LoginView:_onLoginDone(isSuccess)
	if not self._loginFlow then
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		self:_clearState()
	end

	if isSuccess then
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		self:_trackEventHostSwitchLogin()
		LoginModel.instance:resetFailCount()
		self:_endSdkBlock()

		self._serverMO = self._loginFlow.context.serverMO
		self._webLoginSuccess = self._loginFlow.context.webLoginSuccess

		self:_updateServerInfo()
		SDKDataTrackMgr.instance:trackChooseServerEvent()

		if SLFramework.FrameworkSettings.IsEditor then
			self:_requestServerList(self._toSelectEditorLastLoginServer)
		elseif not isDebugBuild then
			self:_requestServerList(self._toSelectDefaultLoginServer)
		end

		UIBlockMgrExtend.instance:setTips()
	elseif self._loginFlow.context.resultCode == ResultCodeSdkExpired then
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		self:_onSdkExpired()
	else
		LoginModel.instance:inverseUseBackup()
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
			LoginModel.instance:resetFailAlertCount()
			GameFacade.showMessageBox(MessageBoxIdDefine.NoServerList, MsgBoxEnum.BoxType.Yes)
			UIBlockMgrExtend.instance:setTips()
		else
			self:_failWebLoginAgain()
			UIBlockMgrExtend.instance:setTips(LoginModel.instance:getFailCountBlockStr())
		end
	end

	self._loginFlow:unregisterDoneListener(self._onLoginDone, self)

	self._loginFlow = nil
end

function LoginView:_failWebLoginAgain()
	if self._sdkLoginSucc then
		TaskDispatcher.runDelay(self._startLoginFlow, self, 1)
	else
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		TaskDispatcher.runDelay(self._login, self, 1)
	end
end

function LoginView:_clearState()
	TaskDispatcher.cancelTask(self._onLoginTimeout, self)
	UIBlockMgr.instance:endBlock(UIBlockKey.HttpLogin)
	UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
	self:_endSdkBlock()

	if self._loginFlow then
		self._loginFlow:stop()
		self._loginFlow:unregisterDoneListener(self._onLoginDone, self)

		self._loginFlow = nil
	end

	if self._httpStartGameFlow then
		self._httpStartGameFlow:stop()

		self._httpStartGameFlow = nil
	end

	if self._serverListRequestId then
		SLFramework.SLWebRequest.Instance:Stop(self._serverListRequestId)

		self._serverListRequestId = nil
	end
end

function LoginView:_onClickServerList()
	ViewMgr.instance:openView(ViewName.ServerListView, {
		useBackupUrl = LoginModel.instance:getUseBackup()
	})
end

function LoginView:_onClickLogin()
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.start_game)

	if self._delayLogout then
		logWarn("LoginView:_onClickLogin, delayLogout")

		return
	end

	if not GameChannelConfig.isSlsdk() and not SDKMgr.instance:isLogin() then
		logNormal("LoginView:_onClickLogin,isLogin flag is false")
		self:_delayForLogout()
		self:_login()

		return
	end

	if not self._webLoginSuccess then
		logWarn("LoginView:_onClickLogin, not web login, try again!")
		self:_startLoginFlow()

		return
	end

	UIBlockMgr.instance:startBlock(UIBlockKey.HttpLogin)

	local canvasGroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	if canvasGroup then
		canvasGroup.alpha = 1
	end

	TaskDispatcher.cancelTask(self._onLoginTimeout, self)
	TaskDispatcher.runDelay(self._onLoginTimeout, self, 60)

	self._httpStartGameFlow = FlowSequence.New()

	self._httpStartGameFlow:addWork(CheckVersionWork.New(self._restartHttpStartGame, self))
	self._httpStartGameFlow:addWork(HttpStartGameWork.New())
	self._httpStartGameFlow:registerDoneListener(self._onHttpStartGameDone, self)
	self._httpStartGameFlow:start({
		useBackupUrl = LoginModel.instance:getUseBackup(),
		lastServerMO = self._serverMO
	})
end

function LoginView:_restartHttpStartGame()
	logNormal("LoginView:_restartHttpStartGame")
	self:_clearState()
	self:_onClickLogin()
end

function LoginView:_onHttpStartGameDone(isSuccess)
	if isSuccess then
		self:_trackEventHostSwitchIpRequest()
		LoginModel.instance:resetFailCount()

		if SLFramework.FrameworkSettings.IsEditor then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.LastLoginServerForPC, self._serverMO.id)
		end

		gohelper.setActive(self._originBgGo, false)
		gohelper.setActive(self._goClickMask, true)

		local viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

		if viewAnimator then
			viewAnimator:Play(UIAnimationName.Close)
		end

		TaskDispatcher.runDelay(self._startGameAfterCanvasFade, self, 0.4)
		UIBlockMgrExtend.instance:setTips()
		self:_clearState()
	else
		local var_25_0 = self._httpStartGameFlow

		if self._httpStartGameFlow then
			var_25_0 = self._httpStartGameFlow.context

			if self._httpStartGameFlow.context then
				local resultCode = self._httpStartGameFlow.context.resultCode

				if resultCode and resultCode == ResultCodeSdkExpired then
					self:_onSdkExpired()
					self:_clearState()
				elseif self._httpStartGameFlow and not self._httpStartGameFlow.context.dontReconnect then
					LoginModel.instance:inverseUseBackup()
					LoginModel.instance:incFailCount()

					if LoginModel.instance:isFailNeedAlert() then
						LoginModel.instance:resetFailAlertCount()
						GameFacade.showMessageBox(MessageBoxIdDefine.LoginLostConnect2, MsgBoxEnum.BoxType.Yes_No, function()
							self:_onClickLogin()
						end)
						UIBlockMgrExtend.instance:setTips()
						self:_clearState()
					else
						TaskDispatcher.runDelay(self._onClickLogin, self, 0.01)
						UIBlockMgrExtend.instance:setTips(LoginModel.instance:getFailCountBlockStr())
					end
				else
					self:_clearState()
				end
			end
		end
	end
end

function LoginView:_onSdkExpired()
	logWarn("登录信息已过期，需重新调起sdk登录")
	self:_showEnterGameBtn(false)
	GameFacade.showMessageBox(MessageBoxIdDefine.SdkTimeoutRelogin, MsgBoxEnum.BoxType.Yes, function()
		TaskDispatcher.runDelay(self._sdkRelogin, self, 0.3)
	end)
end

function LoginView:_startGameAfterCanvasFade()
	LoginController.instance:startLogin()
end

function LoginView:_onEscapeBtnClick()
	if SLFramework.FrameworkSettings.IsEditor then
		self:_onClickAccount()

		return
	end

	SDKMgr.instance:exitSdk()
end

function LoginView:onClickModalMask()
	self:_onClickLogin()
end

function LoginView:_onLoginTimeout()
	self:_clearState()
	logWarn("http登录超时，请稍后重试")
end

function LoginView:_onClickAccount()
	GameFacade.showMessageBox(MessageBoxIdDefine.LogoutThisDevice, MsgBoxEnum.BoxType.Yes_No, function()
		self._delayLogout = true
		self._isUserManualLogout = true

		self:_showEnterGameBtn(false)
		TaskDispatcher.runDelay(self._delayForLogout, self, 0.45)
	end)
end

function LoginView:_delayForLogout()
	local isUserManualLogout = self._isUserManualLogout

	self._isUserManualLogout = false
	self._delayLogout = false

	self:_showEnterGameBtn(false)
	self:_logout(isUserManualLogout)
end

function LoginView:_onClickNotice()
	if VersionValidator.instance:isInReviewing() then
		logWarn("in reviewing ...")

		return
	end

	if self._noticeBtnPressed and not self._noticeBtnClickable then
		self._noticeBtnClickable = true

		return
	else
		self._noticeBtnPressed = false
		self._noticeBtnClickable = true
	end

	NoticeController.instance:openNoticeView()
end

function LoginView:_onClickFix()
	if self._noticeBtnPressed then
		logNormal("begin init ProfilerCmdFileCheck")
		GMController.instance:initProfilerCmdFileCheck()

		self._noticeBtnPressed = false
	else
		ViewMgr.instance:openView(ViewName.FixResTipView, {
			callback = self.reallyFix,
			callbackObj = self
		})
	end
end

function LoginView:_onNoticeLongPress()
	self._noticeBtnPressed = true
	self._noticeBtnClickable = false

	BenchmarkApi.AndroidLog("_onNoticeLongPress")
	logNormal("_onNoticeLongPress")
end

function LoginView:_onClickPolicy()
	SDKMgr.instance:showAgreement()
end

function LoginView:_onClickAgeFit()
	ViewMgr.instance:openView(ViewName.SdkFitAgeTipView)
end

function LoginView:reallyFix()
	PlayerPrefsHelper.deleteAll()
	ZProj.GameHelper.DeleteAllCache()
	MessageBoxController.instance:setEnableClickAudio(false)
	GameFacade.showMessageBox(MessageBoxIdDefine.FixFinished, MsgBoxEnum.BoxType.Yes, function()
		if BootNativeUtil.isAndroid() then
			if SDKMgr.restartGame ~= nil then
				SDKMgr.instance:restartGame()
			else
				ProjBooter.instance:quitGame()
			end
		else
			ProjBooter.instance:quitGame()
		end
	end)
end

function LoginView:_onClickScan()
	SDKMgr.instance:pcLoginForQrCode()
end

function LoginView:_updateServerInfo()
	if self._serverMO then
		self._txtServerName.text = self._serverMO.name or ""
	end

	if self._serverMO then
		for i = 0, 2 do
			gohelper.setActive(self._serverStateGOList[i], i == self._serverMO.state)
		end
	end
end

function LoginView:_showEnterGameBtn(isShow, hideStartForQQ)
	if not SLFramework.FrameworkSettings.IsEditor then
		self._isShowEnterGameBtn = isShow

		gohelper.setActive(self._serverGO, isShow and SLFramework.FrameworkSettings.IsEditor)
		gohelper.setActive(self._btnLogin.gameObject, isShow and not hideStartForQQ)

		if SLFramework.FrameworkSettings.IsEditor then
			gohelper.setActive(self._btnLogin.gameObject, isShow)
		end

		self:_showAccountBtn(isShow)
	end
end

function LoginView:_showAccountBtn(isShow)
	gohelper.setActive(self._btnAccount.gameObject, isShow)

	local notReview = not VersionValidator.instance:isInReviewing()
	local notExternalTest = not GameFacade.isExternalTest()
	local sdkShowNotice = not SDKMgr.getShowNotice or SDKMgr.instance:getShowNotice()

	gohelper.setActive(self._btnNotice.gameObject, isShow and notReview and notExternalTest and sdkShowNotice)
	gohelper.setActive(self._btnFix.gameObject, isShow)
	gohelper.setActive(self._btnScan.gameObject, isShow and SDKMgr.instance:isShowPcLoginButton())
	gohelper.setActive(self._btnPolicy.gameObject, isShow and SDKMgr.instance:isShowAgreementButton())

	self._isShowAccountBtn = isShow
end

function LoginView:_onSelectServerItem(serverMO)
	self._serverMO = serverMO

	self:_updateServerInfo()
end

function LoginView:_onSdkLoginReturn(isSuccess, msg)
	self:_endSdkBlock()
	self:_startSdkBlock()
	TaskDispatcher.cancelTask(self._endSdkBlock, self)
	TaskDispatcher.runDelay(self._endSdkBlock, self, 0.5)

	if not isSuccess then
		self:_showAccountBtn(true)

		self._sdkLoginSucc = nil
	else
		self._sdkLoginSucc = true
	end
end

function LoginView:_onSystemLoginFail()
	self:_clearState()
end

function LoginView:_onLoginOut()
	self._sdkLoginSucc = nil

	self:_showEnterGameBtn(false)
end

function LoginView:_sdkRelogin()
	self._sdkLoginSucc = nil

	self:_showEnterGameBtn(false)
	self:_logout()
	self:_login()
end

function LoginView:_requestServerList(callback)
	local url = LoginController.instance:get_getServerListUrl(LoginModel.instance:getUseBackup())
	local data = {}

	table.insert(data, string.format("sessionId=%s", LoginModel.instance.sessionId))
	table.insert(data, string.format("zoneId=%s", 0))

	url = url .. "?" .. table.concat(data, "&")
	self._onServerListCallback = callback
	self._serverListRequestId = SLFramework.SLWebRequest.Instance:Get(url, self._onServerListRespone, self)
end

function LoginView:_onServerListRespone(isSuccess, msg)
	self._serverListRequestId = nil

	if not isSuccess then
		return
	end

	if string.nilorempty(msg) then
		return
	end

	local data = cjson.decode(msg)

	if not data or not data.resultCode or data.resultCode ~= 0 or not data.zoneInfos then
		return
	end

	if self._onServerListCallback then
		-- block empty
	end
end

function LoginView:_toSelectEditorLastLoginServer(msg, data)
	local lastLoginServerId = PlayerPrefsHelper.getNumber(PlayerPrefsKey.LastLoginServerForPC, nil)

	if lastLoginServerId then
		ServerListModel.instance:setServerList(data.zoneInfos)

		for i, zone in ipairs(data.zoneInfos) do
			if zone.id == lastLoginServerId then
				self._serverMO = {
					id = zone.id,
					name = zone.name,
					prefix = zone.prefix,
					state = zone.state
				}

				self:_updateServerInfo()

				break
			end
		end
	end
end

function LoginView:_toSelectDefaultLoginServer(msg, data)
	ServerListModel.instance:setServerList(data.zoneInfos)

	for i, zone in ipairs(data.zoneInfos) do
		if zone.default == true then
			self._serverMO = {
				id = zone.id,
				name = zone.name,
				prefix = zone.prefix,
				state = zone.state
			}

			self:_updateServerInfo()

			break
		end
	end
end

function LoginView:_trackEventHostSwitchLogin()
	if LoginModel.instance:getFailCount() > 0 then
		local domain = LoginController.instance:get_httpWebLoginUrl(LoginModel.instance:getUseBackup())

		StatController.instance:track(StatEnum.EventName.EventHostSwitch, {
			[StatEnum.EventProperties.GameScene] = "scene_login",
			[StatEnum.EventProperties.CurrentHost] = domain,
			[StatEnum.EventProperties.SwitchCount] = LoginModel.instance:getFailCount()
		})
	end
end

function LoginView:_trackEventHostSwitchIpRequest()
	if LoginModel.instance:getFailCount() > 0 then
		local domain = LoginController.instance:get_startGameUrl(LoginModel.instance:getUseBackup())

		StatController.instance:track(StatEnum.EventName.EventHostSwitch, {
			[StatEnum.EventProperties.GameScene] = "scene_iprequest",
			[StatEnum.EventProperties.CurrentHost] = domain,
			[StatEnum.EventProperties.SwitchCount] = LoginModel.instance:getFailCount()
		})
	end
end

function LoginView:onDestroyView()
	self._openAnimDone = nil
	self._logoLoaded = nil
	self._bgLoaded = nil

	if self._originBgGo then
		gohelper.destroy(self._originBgGo)

		self._originBgGo = nil
	end

	self._imgLogo:UnLoadImage()
end

return LoginView
