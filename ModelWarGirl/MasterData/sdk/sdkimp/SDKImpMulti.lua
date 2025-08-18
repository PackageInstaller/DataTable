-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKImp\\SDKImpMulti.lua

local HttpUtils = Framework.Network.HttpUtils
local SDKImpCommon = require("SDK/SDKImp/SDKImpCommon")
local SDKImpMulti = Class("SDKImpMulti", SDKImpCommon, true)
local SDKConst = require("SDK/SDKConst")
local OpenServerConst = require("Network/OpenServerConst")
local SDKCore = require("SDK/SDKCore")
local Base64 = require("Common/Tools/Base64")
local WebView = require("SDK/Plugin/WebView")
local RetryHelper = require("Helper/RetryHelper")
local VersionUtils = require("System/VersionUtils")
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local AttName = SDKConst.AttName

function SDKImpMulti:customerService()
	local url = ""
	local url_params = ""
	local succ = false

	if VersionUtils.hasAbilityNewCustomerService() then
		succ, url_params = ChannelUtil.doAnyFunction("customerService", {})

		if succ then
			url = "https://kf.kingnet.com?" .. url_params
		else
			url = "https://hzjwwlkjyxgs.qiyukf.com/client?k=e8d9ab8c7da60d756a59405d376e35c4&wp=1&shuntId=0"
		end
	else
		url = "https://hzjwwlkjyxgs.qiyukf.com/client?k=e8d9ab8c7da60d756a59405d376e35c4&wp=1&shuntId=0"
	end

	WebView.openWebView(url)
end

function SDKImpMulti:_doLogin()
	self:_setQQSpinner(true)
	SDKImpMulti.super._doLogin(self)
end

function SDKImpMulti:_onSDKLoginSucc(data)
	self:_setQQSpinner(false)
	SDKImpMulti.super._onSDKLoginSucc(self, data)
end

function SDKImpMulti:_onSDKLoginCancel()
	self:_setQQSpinner(false)
	SDKImpMulti.super._onSDKLoginCancel(self)
end

function SDKImpMulti:_onSDKLoginFail(data)
	self:_setQQSpinner(false)
	SDKImpMulti.super._onSDKLoginFail(self, data)
end

function SDKImpMulti:_doSDKPay(content)
	if ChannelUtil.isQQGame() then
		local QQGameHelper = require("Helper/QQGameHelper")
		local sdkOrder = ClientUtils.string2Table(content)
		local params = {}

		params.amount = sdkOrder[AttName.REAL_PRICE]
		params.extend = sdkOrder[AttName.PRODUCT_ID]
		params.order = sdkOrder[AttName.OPEN_ORDER_ID]
		params.product_id = sdkOrder[AttName.EXTRA]
		params.product_name = sdkOrder[AttName.PRODUCT_PACKAGE_NAME]
		params.role_id = sdkOrder[AttName.ROLE_ID]
		params.role_name = sdkOrder[AttName.ROLE_NAME]
		params.server_id = sdkOrder[AttName.SERVER_ID]
		params.server_name = sdkOrder[AttName.SERVER_NAME]

		local id, token = SDKAgent.getUserID(), SDKAgent.getToken()

		params.uid = id
		params.token = token
		params.sign = sdkOrder[AttName.PAY_SIGN]
		params.notify_url = sdkOrder[AttName.PAY_CALL_BACK_URL]

		local jsonStr = HttpUtils.String2Unicode(ClientUtils.table2String(params), true)
		local base64ed = Base64.enc(jsonStr)

		QQGameHelper.pay(base64ed)
	else
		SDKImpMulti.super._doSDKPay(self, content)
	end
end

function SDKImpMulti:_setQQSpinner(visible)
	if ChannelUtil.isQQGame() then
		RetryHelper.setSpinnerVisible(Const.RETRY_NAME_LOGIN_SDK, visible)
	end
end

function SDKImpMulti:getQQInfo()
	local userData = SDKCore.getUserData()
	local openID = userData[AttName.TENCENT_OPEN_ID]
	local openKey = userData[AttName.TENCENT_OPEN_KEY]

	return openID, openKey
end

return SDKImpMulti
