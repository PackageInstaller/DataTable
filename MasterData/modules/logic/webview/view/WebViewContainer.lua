-- chunkname: @modules/logic/webview/view/WebViewContainer.lua

module("modules.logic.webview.view.WebViewContainer", package.seeall)

local WebViewContainer = class("WebViewContainer", BaseViewContainer)

function WebViewContainer:buildViews()
	local views = {}

	table.insert(views, WebView.New())

	return views
end

return WebViewContainer
