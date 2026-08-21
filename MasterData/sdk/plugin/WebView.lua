-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\WebView.lua

local WebView = {}
local DeviceHelper = require("Helper/DeviceHelper")
local VersionUtils = require("System/VersionUtils")
local UserData = require("Helper/UserData")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local WebViewAgent = Framework.Plugin.WebViewAgent
local WebViewEventType = {
	ON_CLOSE = 1,
	ON_OPEN = 0
}

function WebView.setStrategy(newStrategyNo)
	WebViewAgent.SetStrategy(newStrategyNo or 0)
end

function WebView.init(strategyNo)
	local strategyNo = strategyNo or 0

	WebViewAgent.Init()
	WebViewAgent.SetLuaEventCallback(WebView.onGetEvent)

	WebView._closeCallback = nil
end

function WebView.openWebView(url, closeCallback, hasQuestionMark)
	if IS_EDITOR then
		UIManager.getUI("browserDlg", true):onShow(url)
	else
		if url == nil then
			url = "about:blank"
		end

		WebView._closeCallback = closeCallback

		WebView.onOpen()
		WebViewAgent.OpenWebView(url)
	end
end

function WebView.closeWebView()
	WebViewAgent.CloseWebView()
end

function WebView.onOpen()
	return
end

function WebView.onClose(isSucc)
	if WebView._closeCallback ~= nil then
		WebView._closeCallback()

		WebView._closeCallback = nil
	end
end

WebView._CSEventHandler = {
	[WebViewEventType.ON_CLOSE] = WebView.onClose
}

function WebView.onGetEvent(eventType, ret, arg1)
	local func = WebView._CSEventHandler[eventType]

	if func then
		func(ret, arg1)
	end
end

function WebView.unityOpenUrl(url)
	Framework.Tools.LuaToolkit.UnityOpenURL(url)
end

return WebView
