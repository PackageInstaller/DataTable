-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LoginView.lua

module("logic.extensions.login.view.LoginView", package.seeall)

local LoginView = class("LoginView", ViewComponent)
local GONG_XIN_BU_GUAN_WANG = "https://beian.miit.gov.cn"

LoginView.SDKStatus_Fail_onNetWork = -27

function LoginView:ctor()
	LoginView.super.ctor(self)

	self._noticeBtn = nil
	self._accountBtn = nil
	self._isWebLogined = false
	self._isSDK_WebLogining = false
	self._tryTimes = 0
end

function LoginView:buildUI()
	self._btnScan = self:getBtn("btns/btnScan")
	self._noticeBtn = self:getBtn("btns/btnNotice")
	self._repairBtn = self:getBtn("btns/btnRepair")
	self._showUserCenterBtn = self:getBtn("btns/btnAccount")
	self._btnDeleteCache = self:getBtn("btns/btnDeleteCache")
	self._btnReport = self:getGo("btns/btnReport")
	self._btnLayout = self:getGo("btns"):GetComponent(ComponentType.UILayoutSingleLine)
	self._imgToLoginGo = self:getGo("imgToLogin")
	self._serverGo = self:getGo("server")
	self._serverBtn = self:getBtn("server/btnSelect")
	self._serverBtnEx = self:getBtn("server/btnSelectEx")
	self._txtServerFullName = goutil.findChildComponent(self.mainGO, "server/txtServerFullName", "Text")
	self._imgState = goutil.findChildComponent(self._txtServerFullName.gameObject, "imgState", "UIImageSpriteChange")
	self._ageBtn = self:getBtn("ageBtn")
	self._txtVersion = goutil.findChildComponent(self.mainGO, "txtVersion", "Text")
	self._txtNotice = goutil.findChildComponent(self.mainGO, "btns/btnNotice/Text", "Text")
	self._txtAccount = goutil.findChildComponent(self.mainGO, "btns/btnAccount/Text", "Text")
	self._txtSelectZone = goutil.findChildComponent(self.mainGO, "server/btnSelect/Text", "Text")
	self._txtUserProtocol = goutil.findChildComponent(self.mainGO, "agreement/agreement/btnUserProtocal/Text", "Text")
	self._txtCopyRight = goutil.findChildComponent(self.mainGO, "agreement/imgCopyrightBg/txtCopyright", "Text")
	self.agreementGo = self:getGo("agreement")
	self._txtNotice.text = lang("tip_login_notice")
	self._txtAccount.text = lang("tip_login_account")
	self._txtSelectZone.text = lang("tip_login_changeserver")

	goutil.setActive(self._serverGo, false)
	self:_initProtocol()
	self._serverBtn.gameObject:SetActive(true)
	self._serverBtnEx.gameObject:SetActive(true)
	goutil.setActive(self._noticeBtn.gameObject, not BootstrapPjaqGameConfigMgr.isReview)
	goutil.setActive(self._repairBtn.gameObject, not BootstrapPjaqGameConfigMgr.isReview)
	goutil.setActive(self._btnScan.gameObject, false)
	goutil.setActive(self._btnDeleteCache.gameObject, self:_isCanDeleteCache())
	GameUtil.SetActive(self._btnReport.gameObject, self:_isCanDeleteCache())
	self._btnLayout:Layout()

	self._btnJumpTxt = self:getGo("agreement/Bg1/btnJump1")
end

function LoginView:_initProtocol()
	self._agreeProtoBtn = self:getBtn("agreement/btnAgree")
	self._agreeProtoImage = self:getGo("agreement/btnAgree/checkBox")
	self._userProtocalBtn = self:getBtn("agreement/agreement/btnUserProtocal")
	self._privateProtocalBtn = self:getBtn("agreement/private/btnPrivateProtocal")
	self._txtPrivateProtocol = goutil.findChildTextComponent(self.mainGO, "agreement/private/btnPrivateProtocal/Text")
end

function LoginView:bindEvents()
	Framework.UIClickTrigger.Get(self._imgToLoginGo):AddClickListener(self._onClickLoginBtn, self, 1)
	self._btnScan:AddClickListener(LoginView._onClickScanLogin, self)
	self._noticeBtn:AddClickListener(LoginView._onClickNoticeBtn, self)
	self._repairBtn:AddClickListener(self._onClickRepairBtn, self)
	self._showUserCenterBtn:AddClickListener(LoginView._onClickAccountBtn, self)
	self._serverBtn:AddClickListener(LoginView._onClickServerBtn, self)
	self._serverBtnEx:AddClickListener(LoginView._onClickServerBtn, self)
	self._userProtocalBtn:AddClickListener(LoginView._onClickUserProtocal, self)
	self._privateProtocalBtn:AddClickListener(LoginView._onClickPrivateProtocal, self)
	self._agreeProtoBtn:AddClickListener(LoginView._onClickAgreeProtocal, self)
	self._ageBtn:AddClickListener(LoginView._onClickAgeBtn, self)
	GameUtil.addClickHandler(self._btnJumpTxt, self._onClickJumpTxt, self)
	self._btnDeleteCache:AddClickListener(self._onClickbtnDeleteCache, self)
	GameUtil.addClickHandler(self._btnReport, self._onClickReport, self)
end

function LoginView:unbindEvents()
	Framework.UIClickTrigger.Get(self._imgToLoginGo):RemoveClickListener()
	self._btnScan:RemoveClickListener()
	self._noticeBtn:RemoveClickListener()
	self._showUserCenterBtn:RemoveClickListener()
	self._serverBtn:RemoveClickListener()
	self._repairBtn:RemoveClickListener()
	self._serverBtnEx:RemoveClickListener()
	self._userProtocalBtn:RemoveClickListener()
	self._privateProtocalBtn:RemoveClickListener()
	self._agreeProtoBtn:RemoveClickListener()
	self._ageBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnJumpTxt)
	self._btnDeleteCache:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnReport)
end

function LoginView:onEnter()
	self._startGameOnWebLoginSuccess = false
	self._openServerListOnLoginSuccess = false

	ReConnectionMgr.instance:addDisconnectCallback()
	goutil.setActive(self._showUserCenterBtn.gameObject, false)
	goutil.setActive(self.agreementGo, true)

	self._useReverseLoginUrlIndex = 0
	self._autoEnterServer = true
	self._isCheckingMaintainNotice = false
	self._tryTimes = 0

	LoginController.instance:setLogin(false)
	LoginServerListModel.instance:sortServers()
	GlobalDispatcher:addListener(GlobalNotify.onSDKLogout, self._onSDKLogout, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationPause, self._onHandleOnApplicationPause, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationResume, self._onHandleOnApplicationResume, self)
	GlobalDispatcher:addListener(GlobalNotify.SimulationSDKLoginSuccess, self._handleAccountLoginFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.SDKLoginSuccess, self._handleAccountLoginFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.GameWebLoginSuccess, self._onGameWebLoginSuccess, self)
	GlobalDispatcher:addListener(GlobalNotify.GameWebStartGameSuccess, self._onGameWebStartGameSuccess, self)
	GlobalDispatcher:addListener(GlobalNotify.GameWebLoginSvrListEmpty, self._onGameWebLoginSvrListEmpty, self)
	GlobalDispatcher:addListener(GlobalNotify.GameWebLoginFail, self._onGameWebLoginFail, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._onRoleLogined, self)
	GlobalDispatcher:addListener(GlobalNotify.GameLoadAreaFailed, self._onGameLoadAreaFailed, self)
	GlobalDispatcher:addListener(GlobalNotify.onGameNoticeBack, self._onNoticeInfoBack, self)
	GlobalDispatcher:addListener(GlobalNotify.OnServerListCellSelect, self._onServerCellSelected, self)
	GlobalDispatcher:addListener(GlobalNotify.CloseNotice, self._onCloseNoticeWebView, self)
	GlobalDispatcher:addListener(GlobalNotify.OnServerConnectedFail, self._onServerConnectedFail, self)
	self:_updateAgreeProtocal()
	self:_updateAgreeProtocalText()
	goutil.setActive(self._serverGo, false)
	goutil.setActive(self.mainGO, false)
	self:_playVideo()

	if HardwareQuality and HardwareQuality.tryLoadImage then
		HardwareQuality.tryLoadImage()
	end

	forcePrint(">>>>>>>getCoChannelId>>", LoginModel.instance:getCoChannelId())
end

function LoginView:_playVideo()
	self._isVideoError = false

	self:_startLoginUI()

	if BootstrapPjaqGameConfigMgr.isReview then
		VideoFacade:play("cg_0_4", true, UnityEngine.Video.VideoAspectRatio.FitVertically, self._onMoviePlayStart, self._onMoviePlayFinished, self, self._onVideoPlayError, self)
	else
		VideoFacade:play("cg_0_0", true, UnityEngine.Video.VideoAspectRatio.FitVertically, self._onMoviePlayStart, self._onMoviePlayFinished, self, self._onVideoPlayError, self)
	end
end

function LoginView:_onMoviePlayStart()
	if AudioPlayerEx.isInitialized then
		AudioBgmPlayer.instance:stopMusic()
	end

	GlobalModel.instance.gameStart:SetActive(false)
end

function LoginView:_onMoviePlayFinished()
	return
end

function LoginView:_onVideoPlayError()
	self._isVideoError = true

	if not Framework.OSDef.isEditor then
		self:_playAnimation()
	end
end

function LoginView:_playAnimation()
	if AudioPlayerEx.isInitialized then
		AudioPlayerEx.instance:playMusic(10103)
	end

	GlobalModel.instance.gameStart:SetActive(true)
end

function LoginView:_handleAnimationEvts(evtName)
	if evtName == "ShowUI" then
		self:_startLoginUI()

		return true
	end
end

function LoginView:_startLoginUI()
	goutil.setActive(self.mainGO, true)

	if LoginController.instance:checkForceDownloadPackage() then
		return
	end

	if LoginController.instance:isFirstEnter() then
		LoginController.instance:setFirstEntered()
		forcePrint("===========LoginView:onEnter=============beginGetSessionId")
		self:beginGetSessionId()
	else
		self:_setAreaInfo()

		if not LoginModel.instance.sessionId then
			self:beginGetSessionId()
		end
	end
end

function LoginView:_onAnimationPlayStart()
	if self._animationResNode then
		self._animationResNode:SetActive(true)
	end

	GlobalModel.instance.gameStart:SetActive(false)
end

function LoginView:_clearAnimation()
	if self._animatorPlayer then
		self._animatorPlayer:Stop()

		self._animatorPlayer = nil
	end

	BootstrapLauncher.instance:stopAnim()
	CommonPreloader.instance:removeLoginAnimAssets()
end

function LoginView:onEnterFinished()
	WaitingView.instance:hide()

	if not Framework.OSDef.isEditor then
		self._txtVersion.text = string.format("V%s-%s-%s", BootstrapUtil.getGameHotUpdateVersionCode(), BootstrapUtil.getGameVersionName(), BootstrapUtil.getGameVersionCode())

		local code = checknumber(BootstrapUtil.getGameVersionCode())

		if code >= 1102 and code < 1110 then
			TipsFacade.instance:openTipWindowNoX(lang("tip"), "此包已失效，请卸载后重新安装", function()
				self:_applicationQuit()
			end, "确定")
		end
	end
end

function LoginView:onExit()
	LoginView.super.onExit(self)
	removetimer(self._delayLogIn, self)
	removetimer(self._checkLoginNotCallBack, self)
end

function LoginView:onExitFinished()
	forcePrint("===========LoginView:onExitFinished 登录界面关闭 =============")

	if BootstrapPjaqGameConfigMgr.isReview then
		VideoFacade.instance:stopVideo("cg_0_4")
	else
		VideoFacade.instance:stopVideo("cg_0_0")
	end

	self:_clearAnimation()
	GlobalDispatcher:removeListener(GlobalNotify.OnServerConnectedFail, self._onServerConnectedFail, self)
	GlobalDispatcher:removeListener(GlobalNotify.onSDKLogout, self._onSDKLogout, self)
	GlobalDispatcher:removeListener(GlobalNotify.RoleLogined, self._onRoleLogined, self)
	GlobalDispatcher:removeListener(GlobalNotify.ApplicationPause, self._onHandleOnApplicationPause, self)
	GlobalDispatcher:removeListener(GlobalNotify.ApplicationResume, self._onHandleOnApplicationResume, self)
	GlobalDispatcher:removeListener(GlobalNotify.SimulationSDKLoginSuccess, self._handleAccountLoginFinish, self)
	GlobalDispatcher:removeListener(GlobalNotify.SDKLoginSuccess, self._handleAccountLoginFinish, self)
	GlobalDispatcher:removeListener(GlobalNotify.GameWebLoginSuccess, self._onGameWebLoginSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.GameWebStartGameSuccess, self._onGameWebStartGameSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.GameWebLoginSvrListEmpty, self._onGameWebLoginSvrListEmpty, self)
	GlobalDispatcher:removeListener(GlobalNotify.GameWebLoginFail, self._onGameWebLoginFail, self)
	GlobalDispatcher:removeListener(GlobalNotify.GameLoadAreaFailed, self._onGameLoadAreaFailed, self)
	GlobalDispatcher:removeListener(GlobalNotify.HttpGetServerListSuccess, self._handleHttpGetServerListSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.HttpGetServerListError, self._handleHttpGetServerListError, self)
	GlobalDispatcher:removeListener(GlobalNotify.onGameNoticeBack, self._onNoticeInfoBack, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnServerListCellSelect, self._onServerCellSelected, self)
	GlobalDispatcher:removeListener(GlobalNotify.CloseNotice, self._onCloseNoticeWebView, self)

	self._isWebLogined = false
	self._isSDK_WebLogining = false
	self._isRequestRemoteVersionCodeError = false
	self._useReverseLoginUrlIndex = nil

	if self._lastSelectSvrMo then
		LoginServerListModel.instance:pushActiveServer(self._lastSelectSvrMo)

		self._lastSelectSvrMo = nil
	end

	removetimer(self._yieldonCloseWebView, self)
	ViewMgr.instance:close(ViewName.UserProtocalView)

	if not Framework.OSDef.isEditor then
		UnityWebBridge.closeWebView()
		NoticeController.instance:closeWebView()
	end
end

function LoginView:_onCloseNoticeWebView()
	removetimer(self._yieldonCloseWebView, self)
	forcePrint("===LoginView:_onCloseNoticeWebView========")
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Login)
	settimer(0.1, self._yieldonCloseWebView, self, false)
end

function LoginView:_yieldonCloseWebView()
	forcePrint("===LoginView:_yieldonCloseWebView========")
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)
end

function LoginView:_onClickScanLogin()
	SDKManager.pcQRScanLogin()
end

function LoginView:_onClickNoticeBtn()
	if LoginController.instance._isInChecking then
		return
	end

	NoticeController.instance:openNoticeView(true)
end

function LoginView:_onClickRepairBtn()
	TipsFacade.instance:openPopupWindow(lang("tip"), "是否修复客户端，修复后需要重新启动游戏？", function()
		UnityEngine.AssetBundle.UnloadAllAssetBundles(false)
		Framework.HotUpdate.VersionMgr.Instance:DeleteAllLocal()
		Framework.LocalStorage.Instance:DeleteAllLocalData()
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "客户端已经修复", function()
			self:_applicationQuit()
		end, BootstrapLanguage.sure)
	end, function()
		return
	end, "确定", "取消")
end

function LoginView:_onClickAccountBtn()
	if LoginController.instance._isInChecking then
		return
	end

	if Framework.OSDef.isEditor then
		LoginModel.instance.sessionId = nil

		self:_resetWebLogin()
		self:_onClickLoginBtn()
	elseif Framework.OSDef.RunOS == Framework.OSDef.Android or Framework.OSDef.RunOS == Framework.OSDef.IOS then
		SDKManager.showUserCenter()
	end
end

function LoginView:_onClickServerBtn()
	self._openServerListOnLoginSuccess = false

	if LoginModel.instance.sessionId and LoginModel.instance.gameAccount then
		LoginController.instance:openServerListView(self._useReverseLoginUrlIndex)
	else
		if not LoginModel.instance.gameAccount then
			self._useReverseLoginUrlIndex = 0

			self:_handleAccountLoginFinish()
		else
			self:beginGetSessionId()
		end

		self._openServerListOnLoginSuccess = true
	end
end

function LoginView:beginGetSessionId()
	if self._isSDK_WebLogining then
		forcePrint("===========LoginView: beginGetSessionId sessionId = nil or _isSDK_WebLogining=============")
		forcePrint(self._isSDK_WebLogining)

		return
	end

	self._isSDK_WebLogining = true

	goutil.setActive(self._serverGo, false)
	goutil.setActive(self.agreementGo, false)
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Login)

	local OSDef = Framework.OSDef
	local RunOS = OSDef.RunOS

	if not OSDef.isEditor and (RunOS == OSDef.Android or RunOS == OSDef.IOS) and not SDKManager.isAutomatorEnabled() then
		SDKManager.registerLoginListener(function(statusCode, sessionId, platformId, statusDesc)
			ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)

			self._reqLoginTime = nil

			goutil.setActive(self.agreementGo, true)
			forcePrint("=======sdk登录返回，statusCode=", statusCode)
			removetimer(self._checkLoginNotCallBack, self)

			if statusCode == SDKManager.STATUS_OK then
				forcePrint("=======sdk登录成功，platformId，sessionId=", platformId, sessionId)
				NativeBridge.instance:log("OneSDK login success")
				NativeBridge.instance:log("sessionId: " .. sessionId)
				NativeBridge.instance:log("platformId: " .. platformId)

				LoginModel.instance.sessionId = sessionId
				LoginModel.instance.platformId = platformId

				GlobalDispatcher:dispatch(GlobalNotify.SDKLoginSuccess)

				local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

				if SDKManager.isOfficial() and versionCode >= 870 then
					goutil.setActive(self._btnScan.gameObject, not BootstrapPjaqGameConfigMgr.isReview)
					self._btnLayout:Layout()
				end
			else
				NativeBridge.instance:log("OneSDK login fail")
				forcePrint("===========statusCode====" .. statusCode)

				self._isSDK_WebLogining = false

				local _findError = false

				if string.nilorempty(statusDesc) then
					if statusCode then
						_findError = true

						TipsFacade.instance:openTipWindow(lang("tip"), lang("tip_login_sdkloginfail") .. "(" .. statusCode .. ")", nil, "关闭")
					else
						_findError = true

						TipsFacade.instance:openTipWindow(lang("tip"), lang("tip_login_sdkloginfail") .. "(nil)", nil, "关闭")
					end
				elseif statusCode then
					_findError = true

					TipsFacade.instance:openTipWindowNoGuide(lang("tip"), statusDesc .. "(" .. statusCode .. ")", nil, "关闭")
				else
					_findError = true

					TipsFacade.instance:openTipWindow(lang("tip"), statusDesc .. "(nil)", nil, "关闭")
				end

				if not _findError then
					TipsFacade.instance:openTipWindow(lang("tip"), lang("tip_login_sdkloginfail") .. "(error_code)", nil, "关闭")
				end
			end
		end)

		if SDKManager.isYingyongbao() then
			settimer(0.2, self._delayLogIn, self, false)
		else
			self:_realLogIn()
		end

		forcePrint("============LoginView:发送SDK登录=========", tostring(self))
	else
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)
		ViewMgr.instance:open(ViewName.LoginSimulationSDK)
	end
end

function LoginView:_onSDKLogout()
	forcePrint("===========LoginView:_onSDKLogout in registerLogoutListener=============")

	self._isSDK_WebLogining = false
	self._isWebLogined = false

	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)

	if LoginModel.instance.sessionId then
		if Framework.OSDef.RunOS == Framework.OSDef.Android or Framework.OSDef.RunOS == Framework.OSDef.IOS then
			ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Login)

			self._isSDK_WebLogining = true

			if SDKManager.isYingyongbao() then
				settimer(0.2, self._delayLogIn, self, false)
			else
				self:_realLogIn()
			end
		end

		LoginModel.instance.sessionId = nil
	end
end

function LoginView:_handleAccountLoginFinish()
	self:_resetWebLogin()
	forcePrint("============== LoginView:_handleAccountLoginFinish ===============" .. debug.traceback())
	SDKManager.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartShowLoginView)
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Login)

	local versionCode = BootstrapUtil.getGameVersionCode()

	LoginAgent.instance:sendHttpWebLoginRequest(LoginModel.instance.sessionId, versionCode, SDKManager.getDevInfo().sdkType, self._useReverseLoginUrlIndex)
end

function LoginView:_checkShowProtosView()
	if LoginController.instance:isLogin() then
		return
	end

	if self._startGameOnWebLoginSuccess or self._openServerListOnLoginSuccess then
		return
	end

	local hasShowUser = Framework.LocalStorage.Instance:GetString(LoginController.strKeyHasShowUserProtocal, "No")
	local hasShowPrivate = Framework.LocalStorage.Instance:GetString(LoginController.strKeyHasShowPrivateProtocal, "No")

	if hasShowUser == "No" or hasShowPrivate == "No" then
		ViewMgr.instance:open(ViewName.UserProtocalView, 0, true, self._checkShowNoticeView, self)
	end
end

function LoginView:_checkShowNoticeView()
	if LoginController.instance:isLogin() then
		return
	end

	if self._startGameOnWebLoginSuccess or self._openServerListOnLoginSuccess then
		return
	end

	forcePrint(" LoginView:_checkShowNoticeView==打开公告面板")
	NoticeController.instance:openNoticeView(true, true)
end

function LoginView:_onGameWebLoginSuccess()
	forcePrint("请求web登录成功，覆盖了账号登录的sessionId，新的数据为sessionId=", LoginModel.instance.sessionId)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)

	self._isWebLogined = true
	self._isSDK_WebLogining = false

	self:_checkShowNoticeView()
	goutil.setActive(self._serverGo, true)
	goutil.setActive(self.agreementGo, true)
	self:_setAreaInfo()

	if not Framework.OSDef.isEditor then
		goutil.setActive(self._showUserCenterBtn.gameObject, SDKManager.isShowUserCenterButton())
	else
		goutil.setActive(self._showUserCenterBtn.gameObject, true)
	end

	self._btnLayout:Layout()
	AudioPlayerEx.instance:init()

	if self._isVideoError then
		AudioPlayerEx.instance:playMusic(10103)
	end

	if self._startGameOnWebLoginSuccess then
		self:_realonClickLogin()
	elseif self._openServerListOnLoginSuccess then
		self:_onClickServerBtn()
	end
end

function LoginView:_onClickUserProtocal()
	if Framework.OSDef.RunOS == Framework.OSDef.Android then
		SDKManager.showProtocolView()
	else
		ViewMgr.instance:open(ViewName.UserProtocalView, 0)
	end
end

function LoginView:_onClickPrivateProtocal()
	if Framework.OSDef.RunOS == Framework.OSDef.Android then
		SDKManager.showPrivacyView()
	else
		ViewMgr.instance:open(ViewName.UserProtocalView, 1)
	end
end

function LoginView:_onGameWebLoginSvrListEmpty()
	WaitingView.instance:hide()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)

	self._isWebLogined = false
	self._isSDK_WebLogining = false
	self._openServerListOnLoginSuccess = false

	self:_showSvrListEmpty()
end

function LoginView:_onGameLoadAreaFailed(msg)
	if not msg or msg == "timeout" or msg == BootstrapConstdef.NetWorkCloseed or not msg.resultCode then
		self:_resetWebLogin()
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "当前网络状态不佳。", function()
			return
		end, BootstrapLanguage.sure)

		return
	end

	local resultCode = msg.resultCode

	resultCode = resultCode or 0

	forcePrint("_onGameLoadAreaFailed========resultCode = ", resultCode)

	if resultCode == -32006 then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "账号信息已过期，请您重新登录账号。\n(-32006)", function()
			self:_resetWebLogin()
		end, BootstrapLanguage.sure)
	elseif resultCode == -32007 then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "账号信息不匹配，请您重新登录账号。\n(-32007)", function()
			self:_resetWebLogin()
		end, BootstrapLanguage.sure)
	elseif resultCode == -113 then
		local reason = GameUtil.jsonToTable(msg.reason)

		TipsFacade.instance:openTipWindowNoX(reason.title, reason.msg .. "\n(-113)", function()
			self:_resetWebLogin()
		end, BootstrapLanguage.sure)
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "获取大区信息异常，请稍后再试(" .. resultCode .. ")", function()
			return
		end, "点击重试")
	end
end

function LoginView:_onGameWebLoginFail(msg)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)

	if not msg or msg == "timeout" or msg == BootstrapConstdef.NetWorkCloseed or not msg.resultCode then
		self:_resetWebLogin()

		self._onGameWebLoginFailResultCode = BootstrapConstdef.NetWorkCloseed

		self:_onGameWebLoginTimeOut()

		return
	end

	self._openServerListOnLoginSuccess = false
	self._startGameOnWebLoginSuccess = false

	local resultCode = msg.resultCode

	resultCode = resultCode or 0

	forcePrint("GameWebLoginFail========resultCode = ", resultCode)

	if resultCode == -32003 then
		self:_resetWebLogin()
		TipsFacade.instance:openTipWindowNoX("提示", "太火爆了，服务器过于繁忙，请您重新登录账号。(-32003)", function()
			return
		end, "确定")
	elseif resultCode == -32001 then
		if msg and msg.thirdPartyServiceResultCode then
			if not msg.thirdPartyServiceResultCode then
				local code = 0
				local content = LoginConfig.instance:getThirdPartErrorMsg(code)

				TipsFacade.instance:openTipWindowNoX("提示", content, function()
					SDKManager.logout()
				end, "确定")
				forcePrint("GameWebLoginFail========resultCode = ", (msg and msg.thirdPartyServiceResultCode or nil) and (msg.thirdPartyServiceResultCode or ""))
			end
		end
	elseif resultCode == -32002 then
		self:_resetWebLogin()
		TipsFacade.instance:openTipWindowNoX("提示", "服务器调用第三方服务发送错误，请稍后重试。(-32002)", function()
			return
		end, "确定")
	elseif resultCode == -32004 then
		local endTime = GameUtil.time2date(checknumber(msg.frozenEndTime) / 1000)
		local content = string.format("您由于不当游戏行为已被封禁，解封时间%d年%d月%d日%d时。\n(-32004)", endTime.year, endTime.month, endTime.day, endTime.hour)

		TipsFacade.instance:openTipWindow("账号冻结", content, function()
			self:_onClickServerBtn()
		end)
	elseif resultCode == -32006 then
		self:_resetWebLogin()
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "账号信息已过期，请您重新登录账号。\n(-32006)", function()
			return
		end, BootstrapLanguage.sure)
	elseif resultCode == -32007 then
		self:_resetWebLogin()
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "账号信息不匹配，请您重新登录账号。\n(-32007)", function()
			return
		end, BootstrapLanguage.sure)
	elseif resultCode == -113 then
		self:_resetWebLogin()

		local reason = GameUtil.jsonToTable(msg.reason)

		TipsFacade.instance:openTipWindowNoX(reason.title, reason.msg .. "\n(-113)", function()
			self:_resetWebLogin()
		end, BootstrapLanguage.sure)
	elseif resultCode == -32008 then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "当前区服正在维护中，请稍后重试，或选择其他区服角色登录。\n(-32008)", function()
			return
		end, BootstrapLanguage.sure)
	elseif resultCode == -32009 then
		self:_resetWebLogin()

		if msg.newRecommendArea then
			LoginModel.instance.curAreaStatus = msg.newRecommendArea

			self:_setAreaInfo()
			TipsFacade.instance:openTipWindowNoX(lang("tip"), "该服务器人员过于火爆，无法进行注册了，已经自动推荐另外的区服（您也可以更换自己喜欢的区服）。\n(-32009)", function()
				return
			end, BootstrapLanguage.sure)
		else
			TipsFacade.instance:openTipWindowNoX(lang("tip"), "当前区服已经满人，请重新选择其他区服。\n(-32009)", function()
				return
			end, BootstrapLanguage.sure)
		end
	elseif resultCode == -32013 then
		local status = LoginModel.instance.curAreaStatus
		local sTime = GameUtil.time2date(checknumber(msg.closingUserSubmitTime) / 1000)
		local sTimeStr = string.format("%d年%d月%d日", sTime.year, sTime.month, sTime.day)
		local endTime = GameUtil.time2date(checknumber(msg.closingUserClosedTime) / 1000)
		local eTimeStr = string.format("%d年%d月%d日", endTime.year, endTime.month, endTime.day)

		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("zhuxiao_popup_5", (status or nil) and status.name, sTimeStr, eTimeStr), function()
			local gameAccount = LoginModel.instance.gameAccount
			local socketPassword = LoginModel.instance.socketPassword

			if status then
				LoginAgent.instance:sendHttpWebStartGameRequest(gameAccount, socketPassword, status.id, self._useReverseLoginUrlIndex, 1)
			end
		end)
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), "登录异常，请稍后再试(" .. resultCode .. ")", function()
			self._useReverseLoginUrlIndex = 0
			self._isCheckingMaintainNotice = false

			self:_resetWebLogin()
		end, "点击重试")
	end

	self._onGameWebLoginFailResultCode = resultCode
end

function LoginView:_resetWebLogin()
	LoginModel.instance.gameAccount = nil

	self:_resetStartGame()
end

function LoginView:_resetStartGame()
	LoginModel.instance.socketAccount = nil
end

function LoginView:_onRoleLogined(isSucc, resultCode)
	if not isSucc then
		WaitingView.instance:hide()

		if LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_ServerFull then
			LoginController.instance:disconnect(function()
				self:_tryReloginServer(BootstrapLanguage.a40 .. "(" .. resultCode .. ")")
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_LoginRateLimit then
			LoginController.instance:disconnect(function()
				self:_tryReloginServer(BootstrapLanguage.a37 .. "(" .. resultCode .. ")")
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_ServerNotInService then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a38 .. "(" .. resultCode .. ")", function()
					self:_changeServerIsland()
				end, BootstrapLanguage.sure)
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_Net then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a39 .. "(" .. resultCode .. ")", nil, BootstrapLanguage.sure)
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_AccountNoExisted then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a41 .. "(" .. resultCode .. ")", function()
					self:_resetWebLogin()
				end, BootstrapLanguage.sure)
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_AccountLoginTimeout then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a42 .. "(" .. resultCode .. ")", function()
					self:_resetWebLogin()
				end, BootstrapLanguage.sure)
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_NoOperationTimeout then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a43 .. "(" .. resultCode .. ")", function()
					SDKManager.logout()
				end, BootstrapLanguage.sure)
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_DataWritingBack then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a44 .. "(" .. resultCode .. ")", nil, BootstrapLanguage.sure)
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_LoginingMaxRegisterCount then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a47 .. "(" .. resultCode .. ")", nil, BootstrapLanguage.sure)
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_LoginingOnOtherDevice then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a45 .. "(" .. resultCode .. ")", nil, BootstrapLanguage.sure)
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_LoginingServerHot then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a46 .. "(" .. resultCode .. ")", function()
					self:_onClickServerBtn()
				end, BootstrapLanguage.sure)
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_ServerNotWorkingThisTime then
			self:_resetStartGame()
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a49 .. "(" .. resultCode .. ")", function()
					self:_onClickServerBtn()
				end, BootstrapLanguage.sure)
			end)
		elseif LoginModel.instance.disconnectFlag == GameEnum.DisconnectFlag_NetBlock then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), "与奥奇城的通讯连接有点缓慢，请稍后再试！(-54)", function()
					self:_resetWebLogin()
				end, BootstrapLanguage.sure)
			end)
		end
	end
end

function LoginView:_onServerConnectedFail()
	self:_changeServerIsland()
end

function LoginView:_changeServerIsland()
	local lastAreaId

	if self._lastSelectSvrMo then
		lastAreaId = self._lastSelectSvrMo.areaId

		LoginServerListModel.instance:setServerFull(self._lastSelectSvrMo.areaId, self._lastSelectSvrMo.id)

		self._lastSelectSvrMo = nil
	end

	local svr = LoginServerListModel.instance:popActiveServer(lastAreaId)

	if svr then
		LoginModel.instance.wantGoIslandId = svr.id

		self:_setServerInfo(svr)
	end

	return svr
end

function LoginView:_tryReloginServer(tips)
	forcePrint("尝试连接没有满人的岛：" .. debug.traceback())

	local svr = self:_changeServerIsland()

	if self._autoEnterServer then
		if svr then
			self:_realonClickLogin()
		else
			TipsFacade.instance:openTipWindowNoX(lang("tip"), tips, nil, lang("tip_login_relogin"))
		end
	elseif svr then
		self:_realonClickLogin()
	else
		LoginServerListModel.instance:sortServers(lastAreaId)

		local svr = LoginServerListModel.instance:popActiveServer(lastAreaId)

		if svr then
			LoginModel.instance.wantGoIslandId = svr.id

			self:_setServerInfo(svr)
			self:_realonClickLogin()
		else
			LoginController.instance:openServerListView(self._useReverseLoginUrlIndex)
			FloatWordMgr.instance:show("当前区服已经满人，请重新选择其他区服。")
		end
	end
end

function LoginView:_onGameWebLoginTimeOut()
	self._useReverseLoginUrlIndex = self._useReverseLoginUrlIndex + 1
	self._isCheckingMaintainNotice = false

	forcePrint("===========LoginView:_onGameWebLoginTimeOut=============self._useReverseLoginUrlIndex=" .. self._useReverseLoginUrlIndex)
	forcePrint("===========LoginView:_onGameWebLoginTimeOut======" .. debug.traceback())

	local url = BootstrapPjaqGameConfigMgr.getWebLoginUrl(self._useReverseLoginUrlIndex)

	if not string.nilorempty(url) then
		self:_onGameWebLoginFailHandle()

		return
	end

	self._isCheckingMaintainNotice = true
	self._useReverseLoginUrlIndex = 0
	self._isSDK_WebLogining = false
	self._tryTimes = self._tryTimes + 1

	if Framework.OSDef.isEditor then
		self:_onNoticeInfoBack()
	elseif self._tryTimes % 3 == 1 or not NoticeModel.instance:isRequesetNoticeList() then
		NoticeController.instance:requestNoticeInfo()
	else
		self:_onNoticeInfoBack()
	end
end

function LoginView:_onNoticeInfoBack()
	if self._isCheckingMaintainNotice then
		self._isCheckingMaintainNotice = false
		self._useReverseLoginUrlIndex = 0

		if not Framework.OSDef.isEditor and NoticeModel.instance:hasMainTain() then
			UIStateManager.instance:open(ViewName.NoticeView, GameEnum.NoticeType.MainTain)
		else
			forcePrint("===========LoginView:_onNoticeInfoBack=============" .. debug.traceback())
			TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("tip_login_servershutdown"), function()
				self:_onGameWebLoginFailHandle()
			end, "点击重试")
		end
	end
end

function LoginView:_onGameWebLoginFailHandle()
	if not LoginModel.instance.sessionId then
		self._useReverseLoginUrlIndex = 0
	end

	if self._onGameWebLoginFailResultCode == BootstrapConstdef.NetWorkCloseed and LoginModel.instance.sessionId then
		self:_handleAccountLoginFinish()
	elseif not LoginModel.instance.sessionId then
		forcePrint("===========LoginView:_onGameWebLoginFailHandle=============beginGetSessionId")
		SDKManager.logout()
		forcePrint("===========LoginView:_onGameWebLoginFailHandle after SDKManager.logout() ?============")

		self._isSDK_WebLogining = false
		LoginModel.instance.sessionId = nil

		self:beginGetSessionId()
	end

	self._onGameWebLoginFailResultCode = nil
end

function LoginView:_onHandleOnApplicationPause(pause)
	forcePrint("============== come in _onHandleOnApplicationPause ===============")

	if LoginModel.instance.sessionId == nil then
		self._isSDK_WebLogining = false
		self._isWebLogined = false

		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)
	end
end

function LoginView:_onHandleOnApplicationResume()
	forcePrint("============== come in _onHandleOnApplicationResume ===============")

	self._useReverseLoginUrlIndex = 0

	if not self._isWebLogined and LoginModel.instance.sessionId then
		forcePrint("============== come in _isWebLogined = false ")

		self._useReverseLoginUrlIndex = 0
	end
end

function LoginView:_handleHttpGetServerListSuccess()
	GlobalDispatcher:removeListener(GlobalNotify.HttpGetServerListSuccess, self._handleHttpGetServerListSuccess, self)
end

function LoginView:_onServerCellSelected()
	self:_setAreaInfo()
end

function LoginView:_setAreaInfo()
	local status = LoginModel.instance.curAreaStatus

	self._txtServerFullName.text = ""

	self._imgState:SetState(3)

	if status then
		self._txtServerFullName.text = status.name

		if status.modeId == 1 or status.modeId == 2 then
			self._imgState:SetState(3)
		elseif status.regUserCountPercent == 100 then
			self._imgState:SetState(2)
		else
			self._imgState:SetState(1)
		end

		goutil.setActive(self._serverGo, true)
	else
		goutil.setActive(self._serverGo, false)
	end
end

function LoginView:_setServerInfo(mo)
	if self._lastSelectSvrMo then
		LoginServerListModel.instance:pushActiveServer(self._lastSelectSvrMo)

		self._lastSelectSvrMo = nil
	end

	self._lastSelectSvrMo = mo
	LoginModel.instance.zoneInfo = mo

	if not mo then
		self._serverIp = "nil"
		self._serverZoneId = "nil"
		self._serverPort = "nil"
		self._serverState = nil
		self._serverName = nil

		return
	end

	self._serverZoneId = mo.id
	self._serverIp = mo.ip
	self._serverState = mo.state
	self._serverPort = mo.port
	self._serverName = mo.name
end

function LoginView:_onClickLoginBtn()
	if self._isSDK_WebLogining then
		return
	end

	if self._reqLoginTime and os.time() - self._reqLoginTime > 2 then
		self._reqLoginTime = nil

		self:_realLogIn()
	end

	local acceptStr = Framework.LocalStorage.Instance:GetString(LoginController.strKeyUserProtocal, "")

	if acceptStr ~= "Accept" then
		FloatWordMgr.instance:show(lang("tip_login_notacceptuserprotocol1"))

		return
	end

	local acceptpivateStr = Framework.LocalStorage.Instance:GetString(LoginController.strKeyPrivateProtocal, "")

	if acceptpivateStr ~= "Accept" then
		-- block empty
	end

	if LoginModel.instance.sessionId == nil then
		self:beginGetSessionId()

		return
	end

	self._startGameOnWebLoginSuccess = false
	self._openServerListOnLoginSuccess = false
	self._isRequestRemoteVersionCodeError = false

	WaitingView.instance:show()
	printInfo("click login btn,sessionId = " .. LoginModel.instance.sessionId .. ",platformId=" .. LoginModel.instance.platformId)

	if rescache.resLoadMode ~= Framework.ResourceLoadMode.Direct then
		if not Framework.OSDef.isEditor then
			if LoginController.instance:checkForceDownloadPackage() then
				WaitingView.instance:hide()

				return
			end

			Framework.HotUpdate.GameUpdateMgr.Instance:RequestRemoteVersionCode(function()
				WaitingView.instance:hide()
				LoginController.instance:onReset()
				SDKManager.logout()

				self._isSDK_WebLogining = false
				LoginModel.instance.sessionId = nil

				self:beginGetSessionId()
				forcePrint("请求回来的最新版本号=,===请求失败")

				self._isRequestRemoteVersionCodeError = true
			end, function(gameHotUpdateVersion)
				WaitingView.instance:hide()

				if self._isRequestRemoteVersionCodeError then
					return
				end

				self._isRequestRemoteVersionCodeError = false

				if not gameHotUpdateVersion then
					self:_realonClickLogin()

					return
				end

				if not gameHotUpdateVersion.version then
					local gameHotUpdateVersionCode = "0.0.0"

					forcePrint("再次检查资源版本号，当前版本号=，请求回来的最新版本号=", BootstrapUtil.getGameHotUpdateVersionCode(), gameHotUpdateVersionCode)

					if gameHotUpdateVersionCode ~= "0.0.0" and not self:_checkAgainHotUpdateVersion(gameHotUpdateVersionCode) then
						forcePrint("请求回来的最新版本号=,come here ...")
						TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("tip_login_updateclient"), function()
							self:_applicationQuit()
						end, "确定")

						return
					end

					self:_realonClickLogin()
				end
			end)
		else
			WaitingView.instance:hide()
			self:_realonClickLogin()
		end
	else
		WaitingView.instance:hide()
		self:_realonClickLogin()
	end
end

function LoginView:_checkAgainHotUpdateVersion(gameHotUpdateVersionCode)
	return LoginController.instance:checkAgainHotUpdateVersion(gameHotUpdateVersionCode)
end

function LoginView:_showSvrListEmpty()
	TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("tip_login_servershutdown"), nil, lang("confirm"))
end

function LoginView:_applicationQuit()
	LoginController.instance:applicationQuit()
end

function LoginView:_realonClickLogin()
	self._startGameOnWebLoginSuccess = false
	self._openServerListOnLoginSuccess = false

	if not LoginModel.instance.sessionId then
		self._isSDK_WebLogining = false

		self:beginGetSessionId()

		return
	end

	if LoginModel.instance.gameAccount and LoginModel.instance.sessionId then
		if not LoginModel.instance.socketAccount then
			local status = LoginModel.instance.curAreaStatus

			if status and status.modeId == 0 then
				LoginAgent.instance:sendHttpWebStartGameRequest(LoginModel.instance.gameAccount, LoginModel.instance.socketPassword, status.id, self._useReverseLoginUrlIndex)
			else
				self:_onClickServerBtn()
			end
		else
			self:_onGameWebStartGameSuccess()
		end
	elseif not LoginModel.instance.gameAccount then
		self._useReverseLoginUrlIndex = 0
		self._startGameOnWebLoginSuccess = true

		self:_handleAccountLoginFinish()
	end
end

function LoginView:_onGameWebStartGameSuccess()
	if LoginModel.instance.wantGoIslandId then
		self._autoEnterServer = nil
	end

	local serverMo = LoginServerListModel.instance:getServerByZoneId(LoginModel.instance.curAreaStatus.id, LoginModel.instance.wantGoIslandId)

	self:_setServerInfo(serverMo)
	self:_realGoLogin()
end

function LoginView:_realGoLogin()
	ReConnectionMgr.instance:addDisconnectCallback()

	if not self._serverState or self._serverState <= 10 then
		printInfo("========_realonClickLogin========,ip=" .. (self._serverIp or "") .. ",port=" .. (self._serverPort or ""))

		if not self._serverIp or self._serverIp == "nil" then
			printInfo("拉取服务器信息失败或者未选服务器")

			if Framework.OSDef.isEditor then
				FloatWordMgr.instance:show("尚未选服，请点击选区-选择区服")
			end

			SDKManager.logout()

			self._isSDK_WebLogining = false
			LoginModel.instance.sessionId = nil

			return
		end

		if Framework.OSDef.RunOS == Framework.OSDef.IOS and Framework.OSDef.isEditor == false then
			SDKManager.adaptIPv6(self._serverIp, self._serverPort, function(ipAddress)
				forcePrint("_adaptIPv6Success==========ipAddress==" .. ipAddress)

				self._serverIp = ipAddress

				LoginController.instance:safeLogin(self._serverIp, self._serverPort)
			end, function()
				TipsFacade.instance:openTipWindow(lang("tip"), lang("自适应IPv6失败"), function()
					self:_realonClickLogin()
				end, BootstrapLanguage.retry)
			end)
		else
			LoginController.instance:safeLogin(self._serverIp, self._serverPort)
		end
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a40, nil, lang("tip_login_relogin"))
	end
end

function LoginView:_onClickAgreeProtocal()
	local acceptStr = Framework.LocalStorage.Instance:GetString(LoginController.strKeyUserProtocal, "")

	acceptStr = acceptStr ~= "Accept" and "Accept" or "notAccept"

	Framework.LocalStorage.Instance:SetString(LoginController.strKeyUserProtocal, acceptStr)
	self:_updateAgreeProtocal()
end

function LoginView:_onClickAgeBtn()
	ViewMgr.instance:open(ViewName.LoginAgeTips)
end

function LoginView:_updateAgreeProtocal()
	local acceptStr = Framework.LocalStorage.Instance:GetString(LoginController.strKeyUserProtocal, "")

	if acceptStr ~= "Accept" then
		self._agreeProtoImage:SetActive(false)
	else
		self._agreeProtoImage:SetActive(true)
	end
end

function LoginView:_updateAgreeProtocalText()
	if Framework.OSDef.RunOS == Framework.OSDef.Android then
		self._txtUserProtocol.text = SDKManager.getProtocolName()
		self._txtPrivateProtocol.text = SDKManager.getPrivacyName()
	end
end

function LoginView:_delayLogIn()
	self:_realLogIn()
end

function LoginView:_realLogIn()
	self._reqLoginTime = os.time()

	SDKManager.login()
	settimer(5, self._checkLoginNotCallBack, self, false)
end

function LoginView:_checkLoginNotCallBack()
	if LoginModel.instance.sessionId == nil then
		self._isSDK_WebLogining = false
		self._isWebLogined = false

		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)
	end
end

function LoginView:_onClickJumpTxt()
	UnityEngine.Application.OpenURL(GONG_XIN_BU_GUAN_WANG)
end

function LoginView:_onClickbtnDeleteCache()
	if not self:_isCanDeleteCache() then
		return
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), "是否清理游戏资源缓存，修复后需要重新启动游戏？", function()
		UnityEngine.AssetBundle.UnloadAllAssetBundles(false)

		local success = Framework.HotUpdate.VersionMgr.Instance:DeleteCache()
		local content = success and "客户端缓存清理<color=green>成功</color>" or "客户端缓存清理<color=red>失败</color>"

		TipsFacade.instance:openTipWindowNoX(lang("tip"), content, function()
			self:_applicationQuit()
		end, BootstrapLanguage.sure)
	end, function()
		return
	end, "确定", "取消")
end

function LoginView:_onClickReport()
	if not self:_isCanDeleteCache() then
		return
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), lang("是否上传游戏日志？"), function()
		SDKManager.loganUpload()
	end)
end

function LoginView:_isCanDeleteCache()
	local versionCode = SDKManager.getGameVersionCode()

	if Framework.OSDef.RunOS == Framework.OSDef.Android then
		if versionCode <= 931 then
			return false
		end
	elseif Framework.OSDef.RunOS == Framework.OSDef.IOS and versionCode <= 931 then
		return false
	end

	return true
end

return LoginView
