local var_0_0 = {}

var_0_0.sdkconf = nil

function var_0_0.getSDKConfig()
	var_0_0.sdkconf = var_0_0.sdkconf or FySDK.getSDKConfig()

	return var_0_0.sdkconf
end

function var_0_0.getSDKVersion()
	if FySDK.getFySDKVersion then
		return FySDK.getFySDKVersion()
	else
		return nil
	end
end

function var_0_0.getplatform()
	return var_0_0.getSDKConfig().platform
end

function var_0_0.getchannelid()
	return var_0_0.getSDKConfig().channelId
end

function var_0_0.getIDFA()
	return var_0_0.getSDKConfig().idfa
end

function var_0_0.getDeviceID()
	return var_0_0.getSDKConfig().deviceId
end

function var_0_0.getPaymentCode()
	return var_0_0.getSDKConfig().paymentCode
end

local var_0_1 = "3"

function var_0_0.setServerID(arg_8_0)
	var_0_1 = arg_8_0
end

function var_0_0.getServerID()
	return var_0_1 or "3"
end

function var_0_0.registerInitHandler(arg_10_0)
	FySDK.registerEventHandler(FySDK.EventType.INIT, arg_10_0)
end

function var_0_0.registerLoginHandler(arg_11_0)
	FySDK.registerEventHandler(FySDK.EventType.LOGIN, arg_11_0)
end

function var_0_0.registerPayHandler(arg_12_0)
	FySDK.registerEventHandler(FySDK.EventType.PAY, arg_12_0)
end

function var_0_0.registerLogoutHandler(arg_13_0)
	FySDK.registerEventHandler(FySDK.EventType.LOGOUT, arg_13_0)
end

function var_0_0.registerExitGameHandler(arg_14_0)
	FySDK.registerEventHandler(FySDK.EventType.EXITGAME, arg_14_0)
end

function var_0_0.registerGetOaidHandler(arg_15_0)
	if FySDK.EventType.OAID then
		FySDK.registerEventHandler(FySDK.EventType.OAID, arg_15_0)
	elseif arg_15_0 then
		arg_15_0()
	end
end

function var_0_0.init(arg_16_0)
	FySDK.init(arg_16_0)
end

function var_0_0.login()
	FySDK.login()
end

function var_0_0.switchAccount()
	FySDK.switchAccount()
end

function var_0_0.openUserCenter(arg_19_0)
	FySDK.openUserCenter(arg_19_0)
end

function var_0_0.pay(arg_20_0)
	FySDK.pay(arg_20_0)
end

function var_0_0.logout()
	FySDK.logout()
end

function var_0_0.exitgame()
	FySDK.exitGame()
end

function var_0_0.onAccountRegister(arg_23_0)
	return
end

function var_0_0.onAccountLogin(arg_24_0, arg_24_1)
	FySDK.onAccountLogin(arg_24_0, arg_24_1)
end

function var_0_0.onPlayerCreate(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	return
end

function var_0_0.onPlayerLogin(arg_26_0, arg_26_1, arg_26_2)
	return
end

function var_0_0.onPlayerUpdate(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	return
end

function var_0_0.enterGame(arg_28_0, arg_28_1)
	FySDK.enterGame(arg_28_0, arg_28_1)
end

function var_0_0.recordGame(arg_29_0)
	return
end

function var_0_0.recordMission(arg_30_0)
	return
end

function var_0_0.recordEvent(arg_31_0, arg_31_1)
	FySDK.recordEvent(arg_31_0, arg_31_1)
end

var_0_0.recordgame = var_0_0.recordGame
var_0_0.recordmisssion = var_0_0.recordMission
var_0_0.recordevent = var_0_0.recordEvent

function var_0_0.recordStartPay(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	FySDK.recordStartPay(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
end

function var_0_0.recordPaySuccess(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	FySDK.recordPaySuccess(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
end

function var_0_0.onEventPurchaseADReport(arg_34_0, arg_34_1, arg_34_2)
	return
end

function var_0_0.onEventLoginADReport(arg_35_0, arg_35_1)
	return
end

function var_0_0.setting(arg_36_0)
	return
end

function var_0_0.collectInfo(arg_37_0)
	FySDK.collectInfo(arg_37_0)
end

function var_0_0.registerRealNameHandler(arg_38_0)
	if FySDK.EventType.REALNAME then
		FySDK.registerEventHandler(FySDK.EventType.REALNAME, arg_38_0)
	end
end

function var_0_0.registerAntiAddictHandler(arg_39_0)
	if FySDK.EventType.ANTIADDICT then
		FySDK.registerEventHandler(FySDK.EventType.ANTIADDICT, arg_39_0)
	end
end

function var_0_0.registerLimitPayHandler(arg_40_0)
	if FySDK.EventType.LIMITPAY then
		FySDK.registerEventHandler(FySDK.EventType.LIMITPAY, arg_40_0)
	end
end

function var_0_0.registerAntiTimeOutHandler(arg_41_0)
	if FySDK.EventType.ANTIADDICTTIMEOUT then
		FySDK.registerEventHandler(FySDK.EventType.ANTIADDICTTIMEOUT, arg_41_0)
	end
end

function var_0_0.initAntiAddict()
	FySDK.initAntiAddict()
end

if DeviceManager.platform == "android" then
	function var_0_0.realName(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
		FySDK.realName(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	end

	function var_0_0.antiAddiction(arg_44_0)
		FySDK.antiAddiction(arg_44_0)
	end
else
	function var_0_0.realName(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
		FySDK.realName(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	end

	function var_0_0.antiAddiction()
		FySDK.antiAddiction()
	end
end

function var_0_0.isTimeOut()
	FySDK.isTimeOut()
end

function var_0_0.limitPay(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	FySDK.limitPay(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
end

function var_0_0.checkPrivacy()
	FySDK.checkPrivacy()
end

function var_0_0.checkAuth()
	FySDK.checkAuth()
end

function var_0_0.registerPrivacyHandler(arg_51_0)
	FySDK.registerEventHandler(FySDK.EventType.PRIVACY, arg_51_0)
end

function var_0_0.showServiceBeforeLogin()
	FySDK.showServiceBeforeLogin(config.version)
end

function var_0_0.showServiceBeforeEnterGame(arg_53_0)
	FySDK.showServiceBeforeEnterGame(config.version, arg_53_0)
end

function var_0_0.showServiceAfterEnterGame(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5)
	FySDK.showServiceAfterEnterGame(config.version, arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5, "0")
end

local var_0_2 = false

function var_0_0.canShare()
	return var_0_2
end

function var_0_0.setShare(arg_56_0)
	var_0_2 = arg_56_0 and arg_56_0 > 0
end

function var_0_0.initShare(arg_57_0)
	return false
end

return var_0_0
