-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/SDKManager.lua

module("logiccommon.common.sdk.SDKManager", package.seeall)

local json = require("cjson")
local IPv6Support = require("framework.network.IPv6Support")
local SDKManager = {}
local clazz = "com.baitian.wrap.OneSDKWrap"
local KEY_INIT = "key_sdk_init"
local KEY_LOGIN = "key_sdk_login"
local KEY_PAY = "key_sdk_pay"
local KEY_LOGOUT = "key_sdk_logout"
local KEY_EXIT = "key_sdk_exit"
local KEY_SHARE = "key_sdk_share"
local KEY_GUEST_UPGRADE = "key_sdk_guest_upgrade"
local KEY_REAL_NAME_AUTH = "key_sdk_real_name_auth"

SDKManager.STATUS_OK = 0
SDKManager.SHARE_WEB = 0
SDKManager.SHARE_TEXT = 1
SDKManager.SHARE_PICTURE = 2
SDKManager.SHARE_STATUS_CODE_SUCCESS = 0
SDKManager.SHARE_STATUS_CODE_FAIL = -1
SDKManager.SHARE_STATUS_CODE_CANCEL = -2
SDKManager.STATUS_GUEST_UPGRADE_SUCCESS = 0
SDKManager.STATUS_GUEST_UPGRADE_CANCEL = -2
SDKManager.STATUS_REAL_NAME_AUTH_SUCCESS = 0
SDKManager.STATUS_REAL_NAME_AUTH_CANCEL = -2
SDKManager.TAPTAP_COMMIT_APPID = 84469

function SDKManager.init()
	NativeBridge.instance:invoke(clazz, "init")
end

function SDKManager.login()
	NativeBridge.instance:invoke(clazz, "login")
end

function SDKManager.logout()
	NativeBridge.instance:invoke(clazz, "logout")
end

function SDKManager.exit()
	NativeBridge.instance:invoke(clazz, "exit")
end

function SDKManager.destroy()
	NativeBridge.instance:invoke(clazz, "destroy")
end

function SDKManager.pay(paymentInfo)
	NativeBridge.instance:invoke(clazz, "pay", paymentInfo)
end

function SDKManager.createRole(roleInfo)
	NativeBridge.instance:invoke(clazz, "createRole", roleInfo)
end

function SDKManager.enterGame(roleInfo)
	NativeBridge.instance:invoke(clazz, "enterGame", roleInfo)
end

function SDKManager.upgradeRole(roleInfo)
	NativeBridge.instance:invoke(clazz, "upgradeRole", roleInfo)
end

function SDKManager.isShowUserCenterButton()
	return (NativeBridge.instance:invokeBool(clazz, "isShowUserCenterButton"))
end

function SDKManager.showUserCenter()
	NativeBridge.instance:invoke(clazz, "showUserCenter")
end

function SDKManager.showBBSpage()
	NativeBridge.instance:invoke(clazz, "showBBSpage")
end

function SDKManager.showWebBrowser(url, isUserBrowser)
	local param = {
		url = url,
		isUserBrowser = isUserBrowser
	}

	NativeBridge.instance:invoke(clazz, "showWebBrowser", param)
end

function SDKManager.getDevJson()
	return (NativeBridge.instance:invokeString(clazz, "getDevJson"))
end

function SDKManager.getDevInfo()
	local result = {}
	local devJson = SDKManager.getDevJson()

	if devJson == "" then
		result.channelId = "2"
		result.sysVersion = "1"
		result.sdkVersion = "1.0.0.0"
		result.othersdkVersion = "v1.1.7"
		result.sdkType = "0"
		result.gameVersionCode = "0"
		result.gameVersionName = "0.0.0"
		result.gamepackageName = "com.baitian.unity.editor"
		result.imei = "00000000"
		result.imsi = "00000000"
		result.mac = ""
		result.networkInfo = "WIFI"
		result.phoneModel = "Editor"
		result.displayScreenWidth = 720
		result.displayScreenHeight = 1280
		result.densityDpi = 240
	else
		result = json.decode(devJson)
	end

	return result
end

function SDKManager.getGameVersionCode()
	return checknumber(SDKManager.getDevInfo().gameVersionCode)
end

function SDKManager.getSystemVersion()
	if not SDKManager._systemVersion then
		local devInfo = BootstrapUtil.getDevJson()

		SDKManager._systemVersion = devInfo.sysVersion or 0
	end

	return SDKManager._systemVersion
end

function SDKManager.getDevInfoExt(platformId)
	local result = {}
	local devJson = SDKManager.getDevJson()

	if devJson == "" then
		result.channelId = "2"
		result.sysVersion = "1"
		result.sdkVersion = "1.0.0.0"
		result.othersdkVersion = "v1.1.7"
		result.sdkType = "0"
		result.gameVersionCode = "0"
		result.gameVersionName = "0.0.0"
		result.gamepackageName = "com.baitian.unity.editor"
		result.imei = "00000000"
		result.imsi = "00000000"
		result.mac = ""
		result.networkInfo = "WIFI"
		result.phoneModel = "Editor"
		result.displayScreenWidth = 720
		result.displayScreenHeight = 1280
		result.densityDpi = 240
	else
		result = json.decode(devJson)
	end

	result.platformId = platformId

	return json.encode(result)
end

function SDKManager.getDevInfoExtWithSessionId(platformId, sessionId)
	local playerSecondaryPwd = "playersecondarypwd" .. tostring(sessionId)
	local playerSecondaryPwdStr = "playersecondarypwdstr" .. tostring(sessionId)
	local playerSecondaryPwdSaltKey = "playersecondarypwdsaltkey" .. tostring(sessionId)
	local playerSecondaryPwdType = "playersecondarypwdtype" .. tostring(sessionId)
	local password = Framework.LocalStorage.Instance:GetInt(playerSecondaryPwd)
	local passwordStr = Framework.LocalStorage.Instance:GetString(playerSecondaryPwdStr)
	local salt = Framework.LocalStorage.Instance:GetInt(playerSecondaryPwdSaltKey)
	local pwdType = Framework.LocalStorage.Instance:GetInt(playerSecondaryPwdType)

	if string.nilorempty(passwordStr) then
		local password = Framework.LocalStorage.Instance:GetInt(playerSecondaryPwd)

		if password > 0 then
			passwordStr = tostring(password)
			pwdType = 1
		end
	end

	local result = {}
	local devJson = SDKManager.getDevJson()

	if devJson == "" then
		result.channelId = "1"
		result.sysVersion = "1"
		result.sdkVersion = "1.0.0.0"
		result.othersdkVersion = "v1.1.7"
		result.sdkType = "0"
		result.gameVersionCode = "0"
		result.gameVersionName = "0.0.0"
		result.gamepackageName = "com.baitian.unity.editor"
		result.imei = "00000000"
		result.imsi = "00000000"
		result.mac = ""
		result.networkInfo = "WIFI"
		result.phoneModel = "Editor"
		result.displayScreenWidth = 720
		result.displayScreenHeight = 1280
		result.densityDpi = 240
	else
		result = json.decode(devJson)
	end

	result.platformId = platformId
	result.playerSecondaryPwd = passwordStr
	result.playerSecondaryPwdSalt = salt
	result.playerSecondaryPwdType = pwdType

	return json.encode(result)
end

function SDKManager.sensorsTrack(eventId, properties, isFlush)
	properties = properties or {}

	if isFlush == nil then
		isFlush = true
	end

	local param = {}

	param.eventId = eventId
	param.properties = json.encode(properties)
	param.isFlush = isFlush

	NativeBridge.instance:invoke(clazz, "sensorsTrack", param)
end

function SDKManager.sensorsTrackOnce(eventId, properties, key, isFlush)
	local isTracked = UnityEngine.PlayerPrefs.GetInt(key) == 1

	if isTracked then
		return
	end

	UnityEngine.PlayerPrefs.SetInt(key, 1)
	BootstrapUtil.sensorsTrack(eventId, properties, isFlush)
end

function SDKManager.sensorsTrackLoadingOnce(name, key)
	local isTracked = UnityEngine.PlayerPrefs.GetInt(key) == 1

	if isTracked then
		return
	end

	UnityEngine.PlayerPrefs.SetInt(key, 1)

	local properties = {}

	properties[BootstrapConstdef.ELoginCommonIdName] = name

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ELoginCommonId, properties, true)
end

function SDKManager.isAutomatorEnabled()
	return (NativeBridge.instance:invokeBool(clazz, "isAutomatorEnabled"))
end

function SDKManager.isShowShareButton(sharePlatform)
	return (NativeBridge.instance:invokeBool(clazz, "isShowShareButton"))
end

function SDKManager.share(shareType, content, title, img, url, sharePlatform)
	print("SDKManager.share() begin", shareType, content, title, img, url)

	local param = {}

	param.shareType = shareType
	param.content = content
	param.title = title
	param.img = img
	param.url = url
	param.sharePlatform = sharePlatform

	NativeBridge.instance:invoke(clazz, "share", param)
	print("SDKManager.share() end", shareType, content, title, img, url)
end

function SDKManager.showTransition()
	NativeBridge.instance:invoke(clazz, "showTransition")
end

function SDKManager.hideTransition()
	NativeBridge.instance:invoke(clazz, "hideTransition")
end

function SDKManager.registerInitListener(callFunc)
	NativeBridge.instance:registerListener(KEY_INIT, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		callFunc(statusCode, statusDesc)
	end)
end

function SDKManager.unregisterInitListener()
	NativeBridge.instance:unregisterListener(KEY_INIT)
end

function SDKManager.registerLoginListener(callFunc)
	NativeBridge.instance:registerListener(KEY_LOGIN, function(result)
		local statusCode = result.statusCode
		local sessionId = result.sessionId
		local platformId = result.platformId
		local statusDesc = result.statusDesc

		callFunc(statusCode, sessionId, platformId, statusDesc)
	end)
end

function SDKManager.unregisterLoginListener()
	NativeBridge.instance:unregisterListener(KEY_LOGIN)
end

function SDKManager.registerLogoutListener(callFunc)
	NativeBridge.instance:registerListener(KEY_LOGOUT, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		callFunc(statusCode, statusDesc)
	end)
end

function SDKManager.unregisterLogoutListener()
	NativeBridge.instance:unregisterListener(KEY_LOGOUT)
end

function SDKManager.registerPayListener(callFunc)
	NativeBridge.instance:registerListener(KEY_PAY, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		callFunc(statusCode, statusDesc)
	end)
end

function SDKManager.unregisterPayListener()
	NativeBridge.instance:unregisterListener(KEY_PAY)
end

function SDKManager.registerExitListener(callFunc)
	NativeBridge.instance:registerListener(KEY_EXIT, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		callFunc(statusCode, statusDesc)
	end)
end

function SDKManager.unregisterExitListener()
	NativeBridge.instance:unregisterListener(KEY_EXIT)
end

function SDKManager.registerShareListener(callFunc)
	NativeBridge.instance:registerListener(KEY_SHARE, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		callFunc(statusCode, statusDesc)
	end)
end

function SDKManager.unregisterShareListener()
	NativeBridge.instance:unregisterListener(KEY_SHARE)
end

function SDKManager.isShowShareFailDesc()
	return SDKManager.getGameVersionCode() >= 940
end

function SDKManager.adaptIPv6(address, port, callback)
	if Framework.OSDef.RunOS == Framework.OSDef.IOS then
		local portNum = port

		if portNum and portNum ~= "" then
			portNum = tonumber(portNum)
		end

		IPv6Support.adaptIPv6(address, portNum, function(addressNew)
			forcePrint("adaptIPv6 success", address, port, addressNew)
			callback(addressNew, port)
		end, function()
			forcePrint("adaptIPv6 fail", address, port)
			callback(address, port)
		end)
	else
		callback(address, port)
	end
end

function SDKManager.getCurrentUserId()
	return (NativeBridge.instance:invokeString(clazz, "getCurrentUserId"))
end

function SDKManager.getGameId()
	return (NativeBridge.instance:invokeString(clazz, "getGameId"))
end

function SDKManager.getUserType()
	return (NativeBridge.instance:invokeInt(clazz, "getUserType"))
end

function SDKManager.getUserRealNameStatus()
	return (NativeBridge.instance:invokeBool(clazz, "getUserRealNameStatus"))
end

function SDKManager.getGovAuthStatus()
	if checknumber(SDKManager.getDevInfo().gameVersionCode) >= 201 then
		return NativeBridge.instance:invokeBool(clazz, "getGovAuthStatus")
	else
		return true
	end
end

function SDKManager.registerGuestUpgradeListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_GUEST_UPGRADE, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function SDKManager.unregisterGuestUpgradeListener()
	NativeBridge.instance:unregisterListener(KEY_GUEST_UPGRADE)
end

function SDKManager.isShowGuestUpgradeAccount()
	return (NativeBridge.instance:invokeBool(clazz, "isShowGuestUpgradeAccount"))
end

function SDKManager.gotoGuestUpgradeAccount()
	NativeBridge.instance:invoke(clazz, "gotoGuestUpgradeAccount")
end

function SDKManager.registerRealNameAuthListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_REAL_NAME_AUTH, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function SDKManager.unregisterRealNameAuthListener()
	NativeBridge.instance:unregisterListener(KEY_REAL_NAME_AUTH)
end

function SDKManager.isShowRealNameAuth()
	return (NativeBridge.instance:invokeBool(clazz, "isShowRealNameAuth"))
end

function SDKManager.gotoRealNameAuth()
	NativeBridge.instance:invoke(clazz, "gotoRealNameAuth")
end

function SDKManager.getPrivacyName()
	return (NativeBridge.instance:invokeString(clazz, "getPrivacyName"))
end

function SDKManager.showPrivacyView()
	NativeBridge.instance:invoke(clazz, "showPrivacyView")
end

function SDKManager.getProtocolName()
	return (NativeBridge.instance:invokeString(clazz, "getProtocolName"))
end

function SDKManager.showProtocolView()
	NativeBridge.instance:invoke(clazz, "showProtocolView")
end

function SDKManager.isMuMu()
	return BootstrapUtil.getPlatformId() == 266
end

function SDKManager.isHuawei()
	return BootstrapUtil.getPlatformId() == 5
end

function SDKManager.isOppo()
	return BootstrapUtil.getPlatformId() == 6
end

function SDKManager.isOfficial()
	local btplatformId = BootstrapUtil.getPlatformId()

	return btplatformId == 2 or btplatformId == 10
end

function SDKManager.getForceDownloadPackageUrl()
	if Framework.OSDef.isEditor then
		return
	end

	local btplatformId = BootstrapUtil.getPlatformId()
	local gameVersionCode = checknumber(BootstrapUtil.getGameVersionCode())
	local newestVersionCode, url

	if btplatformId == 25 then
		newestVersionCode = 137
		url = "https://pkg.biligame.com/games/aqcs_8.0.91_0517_20210517_115547_c2bcb.apk"
	elseif btplatformId == 74 then
		newestVersionCode = 137
		url = "https://c1-appstore.nubia.com/Developer/app/2021/05/24/140635/27bcbb2458904b68bea28a8fe5fff3a7.apk"
	end

	if newestVersionCode and gameVersionCode < newestVersionCode then
		return url
	end
end

function SDKManager.loganLogUnity(log)
	local param = {}

	param.log = log

	NativeBridge.instance:invoke(clazz, "loganLogUnity", param)
end

function SDKManager.loganUpload()
	NativeBridge.instance:invoke(clazz, "loganUpload")
end

function SDKManager.isYingyongbao()
	return BootstrapUtil.getPlatformId() == 16
end

function SDKManager.openAiCustomerService(roleName, serverId)
	local param = {}

	param.roleName = roleName
	param.serverId = tostring(serverId)

	NativeBridge.instance:invoke(clazz, "openAiCustomerService", param)
end

function SDKManager.hasAiCustomerService()
	return SDKManager.getGameVersionCode() > 750
end

function SDKManager.joinQQGroup(url)
	local param = {}

	param.url = url

	NativeBridge.instance:invoke(clazz, "joinQQGroup", param)
end

function SDKManager.isSupportTapTap()
	return SDKManager.getGameVersionCode() >= 790 and NativeBridge.instance:invokeBool(clazz, "isSupportTapTap")
end

function SDKManager.openReviewInTapTap()
	local param = {}

	param.appId = tostring(SDKManager.TAPTAP_COMMIT_APPID)

	NativeBridge.instance:invoke(clazz, "openReviewInTapTap", param)
end

function SDKManager.openMobileApp(installParam, notInstallParam)
	local param = {}

	param.installParam = installParam
	param.notInstallParam = notInstallParam

	return (NativeBridge.instance:invokeBool(clazz, "openMobileApp", param))
end

function SDKManager.pcQRScanLogin()
	NativeBridge.instance:invoke(clazz, "pcQRScanLogin")
end

function SDKManager.isAppReviewing()
	return (NativeBridge.instance:invokeBool(clazz, "isAppReviewing"))
end

return SDKManager
