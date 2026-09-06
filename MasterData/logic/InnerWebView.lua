-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/innerweb/view/InnerWebView.lua

module("logic.extensions.innerweb.view.InnerWebView", package.seeall)

local InnerWebView = class("InnerWebView", ViewComponent)

function InnerWebView:ctor()
	InnerWebView.super.ctor(self)
end

function InnerWebView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function InnerWebView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function InnerWebView:buildUI()
	self._closeButton = self:getBtn("Close")
	self._contentBg = self:getGo("bg_webview")
	self._contentBgRt = self._contentBg:GetComponent("RectTransform")
end

function InnerWebView:destroyUI()
	return
end

function InnerWebView:onEnter()
	local rect = Framework.GeometryUtil.GetUnityPixelRect(self._contentBgRt, GlobalModel.instance.uiCamera)

	rect.y = UnityEngine.Screen.height - rect.y - rect.height

	local percent = SceneResolution.Instance.directPercent

	self._webViewRect = {
		x = math.floor(rect.x / percent),
		y = math.floor(rect.y / percent),
		width = math.floor(rect.width / percent),
		height = math.floor(rect.height / percent)
	}

	local x = self._webViewRect.x
	local y = self._webViewRect.y
	local width = self._webViewRect.width
	local height = self._webViewRect.height
	local url = self:getFirstParam()

	if not string.nilorempty(url) then
		UnityWebBridge.openWebView(url, false, x, y, width, height)
	else
		self:_onClickClose()
	end

	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self.checkUp, self)
end

function InnerWebView:onEnterFinished()
	return
end

function InnerWebView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self.checkUp, self)
	UnityWebBridge.closeWebView()
end

function InnerWebView:onExitFinished()
	return
end

function InnerWebView:_onClickClose()
	InnerWebController.instance:closeWebView()
end

function InnerWebView:checkUp(name)
	local v = GlobalModel.instance:getTopView()

	if v and self._viewPresentor.viewName ~= v.viewName then
		self:_onClickClose()
	end
end

return InnerWebView
