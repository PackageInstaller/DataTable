-- chunkname: @projbooter/sdk/SDKMgr.lua

module("projbooter.sdk.SDKMgr", package.seeall)

local SDKMgr = class("SDKMgr")

SDKMgr.ShareContentType = {
	Text = 1,
	Image = 2,
	Web = 3,
	Video = 4
}
SDKMgr.SharePlatform = {
	WechatMoment = 3,
	WechatFriend = 2,
	QQZone = 5,
	XiaoHongShu = 8,
	TikTok = 6,
	QQ = 4,
	SinaWeibo = 1
}
SDKMgr.ChannelId = {
	Douyin = "107",
	QQMobile = "102"
}

function SDKMgr:ctor()
	self.csharpInst = ZProj.SDKMgr.Instance
	self._callbackList = {
		[self.csharpInst.initCallbackType] = self._initSDKCallback,
		[self.csharpInst.loginCallBackType] = self._loginCallback,
		[self.csharpInst.logoutCallbackType] = self._logoutCallback,
		[self.csharpInst.exitCallbackType] = self._exitCallback,
		[self.csharpInst.visitorUpGradeCallBackType] = self._visitorUpGradeCallBack,
		[self.csharpInst.socialShareCallBackType] = self._socialShareCallBack,
		[self.csharpInst.screenShotCallBackType] = self._screenShotCallBack,
		[self.csharpInst.payCallBackType] = self._payCallBack,
		[self.csharpInst.earphoneStatusChangeCallBackType] = self._changeEarphoneContact,
		[self.csharpInst.windowsModeChangedCallbackType] = self._windowsModeChanged,
		[self.csharpInst.recordVideoCallbackType] = self._handleRecordVideoCalled,
		[self.csharpInst.queryProductDetailsCallbackType] = self._handleQueryProductDetailsCalled,
		[self.csharpInst.dataPropertiesChangeCallbackType] = self._handleDataPropertiesChangeCalled,
		[self.csharpInst.readNfcCallbackType] = self._handleReadNfcCalled,
		[self.csharpInst.networkStatusCallBackType] = self._handleNetworkStatusCalled,
		[self.csharpInst.batteryInfoCallBackType] = self._handleBatteryInfoCalled,
		[self.csharpInst.authenticatePlayerCallBackType] = self._handleAuthenticatePlayerCalled,
		[self.csharpInst.updateAchievementCallBackType] = self._handleUpdateAchievementCalled
	}

	self.csharpInst:AddCallback(self._callback, self)

	self._moduleSocialShareCallBack = nil
	self._moduleSocialShareCallBackObj = nil
	self._moduleScreenShotCallBack = nil
	self._moduleScreenShotCallBackObj = nil
end

function SDKMgr:_callback(callbackType, ...)
	local callback = self._callbackList[callbackType]

	if callback then
		callback(self, unpack({
			...
		}))
	elseif VersionUtil.isVersionLess("2.4.0") and (callbackType == self.csharpInst.queryProductDetailsCallbackType or callbackType == self.csharpInst.dataPropertiesChangeCallbackType or callbackType == self.csharpInst.readNfcCallbackType) then
		-- block empty
	else
		logError("SDKMgr callbackType error callbackType:", tonumber(callbackType))
	end
end

function SDKMgr:initSDK(callback, callbackObj)
	if self._isInitSDK then
		logError("SDKMgr initSDK call repeatedly")

		return
	end

	self._callbackNum = 0
	self._isInitSDK = true
	self._initCallback = {
		callback,
		callbackObj
	}

	self.csharpInst:InitSDK()
end

function SDKMgr:_initSDKCallback()
	self._callbackNum = self._callbackNum + 1

	if not self._initCallback then
		logError(string.format("SDKMgr initSDK callback error _isInitSDK:%s _callbackNum:%s", self._isInitSDK, self._callbackNum))

		return
	end

	local callback = self._initCallback[1]
	local callbackObj = self._initCallback[2]

	self._initCallback = nil

	self:_initSDKDataTrackMgr()
	callback(callbackObj)
end

function SDKMgr:_initSDKDataTrackMgr()
	SDKDataTrackMgr.instance:initSDKDataTrack()
	SDKDataTrackMgr.instance:getDataTrackProperties()
end

function SDKMgr:useSimulateLogin()
	return self.csharpInst:UseSimulateLogin()
end

function SDKMgr:isLogin()
	return self.csharpInst:IsLogin()
end

function SDKMgr:login()
	if self._loginSuccess then
		return
	end

	self._isStartLogin = true

	self.csharpInst:Login()
	logNormal("SDKMgr login 请求登录")
end

function SDKMgr:isLoginSuccess()
	return self._loginSuccess
end

function SDKMgr:_loginCallback(success, msg, sessionId, userId, channelId, gameCode, gameId)
	logNormal("SDKMgr login callback result:" .. tostring(success))

	if not self._isStartLogin then
		logNormal("SDKMgr login callback 重复收到回调，忽略掉")

		return
	end

	self._isStartLogin = nil
	self._loginSuccess = success

	if success then
		LoginModel.instance:setChannelParam(sessionId, userId, channelId, gameCode, gameId)
		LoginController.instance:login({})

		if not SDKMgr.instance:isAdult() and SDKMgr.instance:getUserType() == 99 then
			self:showMinorLoginTipDialog()
		end
	else
		logWarn("SDKMgr login fail: msg = " .. (msg or "nil"))
	end

	LoginController.instance:dispatchEvent(LoginEvent.OnSdkLoginReturn, success, msg)
end

function SDKMgr:logout()
	if self._loginSuccess then
		self._loginSuccess = false

		self.csharpInst:Logout()
	end
end

function SDKMgr:_logoutCallback(success, msg)
	self._loginSuccess = false

	if LoginController then
		LoginController.instance:onSdkLogout()
	end
end

function SDKMgr:_exitCallback(success, msg)
	if LoginController then
		LoginController.instance:dispose()
	end

	if ConnectAliveMgr then
		ConnectAliveMgr.instance:dispose()
	end
end

function SDKMgr:_visitorUpGradeCallBack(success, msg)
	return
end

function SDKMgr:_socialShareCallBack(code, msg)
	if self._moduleSocialShareCallBack then
		self._moduleSocialShareCallBack(self._moduleSocialShareCallBackObj, code, msg)
	end
end

function SDKMgr:setSocialShareCallBack(callback, callbackObj)
	self._moduleSocialShareCallBack = callback
	self._moduleSocialShareCallBackObj = callbackObj
end

function SDKMgr:_screenShotCallBack(success, msg)
	if self._moduleScreenShotCallBack then
		self._moduleScreenShotCallBack(self._moduleScreenShotCallBackObj, success, msg)
	end
end

function SDKMgr:setScreenShotCallBack(callback, callbackObj)
	self._moduleScreenShotCallBack = callback
	self._moduleScreenShotCallBackObj = callbackObj
end

function SDKMgr:_payCallBack(code, msg)
	if self._modulePayCallBack then
		self._modulePayCallBack(self._modulePayCallBackObj, code, msg)
	end
end

function SDKMgr:setPayCallBack(callback, callbackObj)
	self._modulePayCallBack = callback
	self._modulePayCallBackObj = callbackObj
end

function SDKMgr:showVistorPlayTimeOutDialog()
	self.csharpInst:CallVoidFunc("showVistorPlayTimeOutDialog")
end

function SDKMgr:showVistorUpgradeDialog()
	self.csharpInst:CallVoidFunc("showVistorUpgradeDialog")
end

function SDKMgr:showMinorLoginTipDialog()
	self.csharpInst:CallVoidFunc("showMinorLoginTipDialog")
end

function SDKMgr:showMinorPlayTimeOutDialog()
	self.csharpInst:CallVoidFunc("showMinorPlayTimeOutDialog")
end

function SDKMgr:showMinorLimitLoginTimeDialog()
	self.csharpInst:CallVoidFunc("showMinorLimitLoginTimeDialog")
end

function SDKMgr:exitSdk()
	self.csharpInst:CallVoidFunc("exitSdk")
end

function SDKMgr:destroyGame()
	self.csharpInst:CallVoidFunc("destroyGame")
end

function SDKMgr:getGameCode()
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getGameCode()
	end

	return self.csharpInst:CallGetStrFunc("getGameCode")
end

function SDKMgr:getGameId()
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getGameId()
	end

	return self.csharpInst:CallGetStrFunc("getGameId")
end

function SDKMgr:getGameSdkToken()
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return ""
	end

	return self.csharpInst:CallGetStrFunc("getGameSdkToken")
end

function SDKMgr:getChannelId()
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getChannelId()
	end

	return self.csharpInst:CallGetStrFunc("getChannelId")
end

function SDKMgr:getSubChannelId()
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return GameChannelConfig.getSubChannelId()
	end

	return self.csharpInst:CallGetStrFunc("getSubChannelId")
end

function SDKMgr:getUserType()
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return 99
	end

	local userType = self.csharpInst:CallGetStrFunc("getUserType")

	return tonumber(userType)
end

function SDKMgr:isAdult()
	if SLFramework.FrameworkSettings.IsEditor or GameChannelConfig.isSlsdk() then
		return true
	end

	local isAdult = self.csharpInst:CallGetStrFunc("isAdult")

	return isAdult ~= "False"
end

function SDKMgr:setScreenLightingOff(on)
	if not on then
		self.csharpInst:CallToolVoidFunc("turnOffScreenLighting")
	else
		self.csharpInst:CallToolVoidFunc("turnOnScreenLighting")
	end
end

function SDKMgr:openLauncher()
	self.csharpInst:CallVoidFunc("sdkOpenLauncher")
end

function SDKMgr:openCostumerService()
	self.csharpInst:CallVoidFuncWithParams("openCostumerService", "深蓝互动")
end

function SDKMgr:shareMedia(sharePlatform, shareContentType, shareContent)
	self.csharpInst:ShareMedia(sharePlatform, shareContentType, shareContent)
end

function SDKMgr:saveImage(imagePath)
	self.csharpInst:SaveImage(imagePath)
end

function SDKMgr:enterGame(roleInfo)
	self.csharpInst:EnterGame(roleInfo)
end

function SDKMgr:createRole(roleInfo)
	self.csharpInst:CreateRole(roleInfo)
end

function SDKMgr:upgradeRole(roleInfo)
	self.csharpInst:UpgradeRole(roleInfo)
end

function SDKMgr:updateRole(roleInfo)
	self.csharpInst:UpdateRole(roleInfo)
end

function SDKMgr:payGoods(payInfo)
	self.csharpInst:PayGoods(payInfo)
end

function SDKMgr:getWinPackageName()
	if GameChannelConfig.isSlsdk() then
		return "com.shenlan.m.proj1"
	else
		return self.csharpInst:GetWinPackageName()
	end
end

function SDKMgr:pcLoginForQrCode()
	self.csharpInst:PcLoginForQrcode()
end

function SDKMgr:isShowUserCenter()
	return self.csharpInst:IsShowUserCenter()
end

function SDKMgr:isShowUnregisterButton()
	local isShowShareButton = self.csharpInst:CallGetStrFunc("isShowUnregisterButton")

	return isShowShareButton ~= "False"
end

function SDKMgr:isNotificationEnable()
	return self.csharpInst:IsNotificationEnable()
end

function SDKMgr:openNotificationSettings()
	self.csharpInst:OpenNotificationSettings()
end

function SDKMgr:unregisterSdk()
	self.csharpInst:CallVoidFunc("unregisterSdk")
end

function SDKMgr:isShowShareButton()
	local isShowShareButton = self.csharpInst:CallGetStrFunc("isShowShareButton")

	return isShowShareButton ~= "False"
end

function SDKMgr:isShowAgreementButton()
	return self.csharpInst:IsShowAgreementButton()
end

function SDKMgr:isShowPcLoginButton()
	return self.csharpInst:IsShowPcLoginButton()
end

function SDKMgr:showUserCenter()
	self.csharpInst:ShowUserCenter()
end

function SDKMgr:isEarphoneContact()
	if self._isInitSDK then
		return self.csharpInst:IsEarphoneContact()
	end
end

function SDKMgr:isEmulator()
	local var_57_0

	if not BootNativeUtil.isAndroid() then
		var_57_0 = BootNativeUtil.isMuMu()

		if var_57_0 then
			var_57_0 = self.csharpInst:IsEmulator()
		end
	end

	return var_57_0
end

function SDKMgr:showAgreement()
	self.csharpInst:CallVoidFunc("showAgreement")
end

function SDKMgr:_changeEarphoneContact()
	if AudioMgr and AudioMgr.instance then
		AudioMgr.instance:changeEarMode()
	end
end

function SDKMgr:_windowsModeChanged(code, screenArgs)
	return
end

function SDKMgr:_handleRecordVideoCalled(code, msg)
	logNormal(string.format("_handleRecordVideoCalled code = [%s], msg = [%s]", code, msg))
	ToastController.instance:showToastWithString(tostring(msg))
end

function SDKMgr:_handleQueryProductDetailsCalled(code, msg)
	logNormal(string.format("_handleQueryProductDetailsCalled code = [%s], msg = [%s]", code, msg))
	ToastController.instance:showToastWithString(tostring(msg))
end

function SDKMgr:_handleDataPropertiesChangeCalled(code, msg)
	logNormal(string.format("_handleDataPropertiesChangeCalled code = [%s], msg = [%s]", code, msg))
	ToastController.instance:showToastWithString(tostring(msg))
end

function SDKMgr:_handleReadNfcCalled(code, msg)
	logNormal(string.format("_handleReadNfcCalled code = [%s], msg = [%s]", code, msg))

	if NFCController == nil or NFCController.instance == nil then
		logNormal("NFCController is nil")

		return
	end

	NFCController.instance:onNFCRead(msg)
end

function SDKMgr:_handleNetworkStatusCalled(code, msg)
	logNormal(string.format("_handleNetworkStatusCalled code = [%s], msg = [%s]", code, msg))

	if DeviceController == nil or DeviceController.instance == nil then
		self._initDeviceInfo = self._initDeviceInfo or {}
		self._initDeviceInfo.networkType = msg

		logNormal("DeviceController is nil")

		return
	end

	DeviceController.instance:onNetworkTypeChange(msg)
end

function SDKMgr:_handleBatteryInfoCalled(code, msg)
	logNormal(string.format("_handleBatteryInfoCalled code = [%s], msg = [%s]", code, msg))

	if DeviceController == nil or DeviceController.instance == nil then
		self._initDeviceInfo = self._initDeviceInfo or {}
		self._initDeviceInfo.batteryStatus = code
		self._initDeviceInfo.batteryValue = msg

		logNormal("DeviceController is nil")

		return
	end

	DeviceController.instance:onBatteryStatusChange(code)
	DeviceController.instance:onBatteryValueChange(msg)
end

function SDKMgr:_handleAuthenticatePlayerCalled(code, msg)
	return
end

function SDKMgr:_handleUpdateAchievementCalled(code, msg)
	return
end

function SDKMgr:requestReadAndWritePermission()
	self.csharpInst:RequestReadAndWritePermission()
end

function SDKMgr:showRecordBubble()
	self.csharpInst:CallVoidFunc("showRecordBubble")
end

function SDKMgr:hideRecordBubble()
	self.csharpInst:CallVoidFunc("hideRecordBubble")
end

function SDKMgr:startRecord()
	self.csharpInst:CallVoidFunc("startRecord")
end

function SDKMgr:stopRecord()
	self.csharpInst:CallVoidFunc("stopRecord")
end

function SDKMgr:isRecording()
	return self.csharpInst:IsRecording()
end

function SDKMgr:isSupportRecord()
	return self.csharpInst:IsSupportRecord()
end

function SDKMgr:openVideosPage()
	self.csharpInst:CallVoidFunc("openVideosPage")
end

function SDKMgr:openSoJump(paramsJson)
	self.csharpInst:CallVoidFuncWithParams("openSoJump", paramsJson)
end

function SDKMgr:getUserInfo()
	return self.csharpInst:CallGetStrFunc("getUserInfo")
end

function SDKMgr:getUserInfoExtraParams()
	local userInfo = cjson.decode(self:getUserInfo() or "{}")
	local extraParams = userInfo.extraJson

	if extraParams == nil then
		return nil
	end

	return cjson.decode(extraParams)
end

function SDKMgr:restartGame()
	self.csharpInst:CallVoidFunc("restartGame")
end

function SDKMgr:getSystemMediaVolume()
	return self.csharpInst:GetSystemMediaVolume()
end

function SDKMgr:setSystemMediaVolume(volume)
	self.csharpInst:SetSystemMediaVolume(volume)
end

function SDKMgr:isIgnoreFileMissing()
	if BootNativeUtil.getPackageName() == "com.shenlan.m.reverse1999.nearme.gamecenter" then
		return false
	else
		return self.csharpInst:IsIgnoreFileMissing()
	end
end

function SDKMgr:isUnsupportChangeVolume()
	return self.csharpInst:IsUnsupportChangeVolume()
end

function SDKMgr:getDeviceInfo()
	if not self._deviceInfo then
		local deviceInfoJson = self.csharpInst:CallGetStrFunc("getDeviceInfo")

		self._deviceInfo = not string.nilorempty(deviceInfoJson) and cjson.decode(deviceInfoJson) or {}
	end

	return self._deviceInfo
end

function SDKMgr:getGameSdkConfig()
	if not self._gameSdkConfig then
		local gameSdkConfigJson = self.csharpInst:CallGetStrFunc("getGameSdkConfig")

		self._gameSdkConfig = not string.nilorempty(gameSdkConfigJson) and cjson.decode(gameSdkConfigJson) or {}
	end

	return self._gameSdkConfig
end

function SDKMgr:getShowNotice()
	local sdkConfig = self:getGameSdkConfig()

	if sdkConfig and sdkConfig.showButtons then
		return sdkConfig.showButtons.Notice
	end

	return true
end

function SDKMgr:getInitDeviceInfo(isClear)
	if isClear then
		self._initDeviceInfo = nil
	end

	return self._initDeviceInfo
end

function SDKMgr:getIntMetaData(key)
	return ZProj.SDKMgr.Instance:GetIntMetaData(key)
end

function SDKMgr:getBoolMetaData(key)
	return ZProj.SDKMgr.Instance:GetBoolMetaData(key)
end

function SDKMgr:getStringMetaData(key)
	return ZProj.SDKMgr.Instance:GetStringMetaData(key)
end

function SDKMgr:requestLocationPermission()
	self.csharpInst:RequestLocationPermission()
end

function SDKMgr:getCurrentLocation()
	local result = ZProj.SDKMgr.Instance:GetCurrentLocation()

	logNormal(string.format("getCurrentLocation result = [%s]", result))

	return result
end

function SDKMgr:authenticatePlayer()
	return ZProj.SDKMgr.Instance:AuthenticatePlayer()
end

function SDKMgr:updateAchievement(achievementJsonStr)
	return ZProj.SDKMgr.Instance:UpdateAchievement(achievementJsonStr)
end

function SDKMgr:showAchievementPage()
	return ZProj.SDKMgr.Instance:ShowAchievementPage()
end

function SDKMgr:stopAllDownload()
	print("stopAllDownload")

	return self.csharpInst:StopAllDownload()
end

SDKMgr.instance = SDKMgr.New()

return SDKMgr
