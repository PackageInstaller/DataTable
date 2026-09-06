-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/UnityWebBridge.lua

module("logiccommon.common.sdk.UnityWebBridge", package.seeall)

local json = require("cjson")
local UnityWebBridge = {}
local nativeClazz = "com.baitian.android.webview.bridge.unity.UnityWebBridge"

function UnityWebBridge.openWebView(url, showToolbar, x, y, width, height)
	local params = {}

	params.url = url
	params.showToolbar = showToolbar

	if x ~= nil and y ~= nil and width ~= nil and height ~= nil then
		params.x = x
		params.y = y
		params.width = width
		params.height = height
	end

	NativeBridge.instance:invoke(nativeClazz, "openWebView", params)
end

function UnityWebBridge.closeWebView()
	NativeBridge.instance:invoke(nativeClazz, "closeWebView", params)
end

function UnityWebBridge.callbackWebView(callback, msgTable)
	local param = {}

	param.callback = callback
	param.paramJson = json.encode(msgTable)

	NativeBridge.instance:invoke(nativeClazz, "callbackWebView", param)
end

function UnityWebBridge.registerGetActionListener(callFunc)
	NativeBridge.instance:registerListener("key_webview_get_action", function(result)
		callFunc(result)
	end)
end

function UnityWebBridge.unregisterGetActionListener()
	NativeBridge.instance:unregisterListener("key_webview_get_action")
end

function UnityWebBridge.registerPostActionListener(callFunc)
	NativeBridge.instance:registerListener("key_webview_post_action", function(result)
		callFunc(result)
	end)
end

function UnityWebBridge.unregisterPostActionListener()
	NativeBridge.instance:unregisterListener("key_webview_post_action")
end

function UnityWebBridge.resetWebViewSize(x, y, width, height)
	local param = {}

	param.x = x
	param.y = y
	param.width = width
	param.height = height

	NativeBridge.instance:invoke(nativeClazz, "resetWebViewSize", param)
end

return UnityWebBridge
