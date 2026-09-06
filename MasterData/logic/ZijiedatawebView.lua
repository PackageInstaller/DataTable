-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zijiedatatransfer/view/ZijiedatawebView.lua

module("logic.extensions.zijiedatatransfer.view.ZijiedatawebView", package.seeall)

local ZijiedatawebView = class("ZijiedatawebView", ViewComponent)

function ZijiedatawebView:ctor()
	ZijiedatawebView.super.ctor(self)
end

function ZijiedatawebView:unbindEvents()
	ZijiedatawebView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ZijiedatawebView:bindEvents()
	ZijiedatawebView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ZijiedatawebView:buildUI()
	ZijiedatawebView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._contentBg = self:getGo("content")
	self._contentBgRt = self._contentBg:GetComponent("RectTransform")
end

function ZijiedatawebView:onExit()
	ZijiedatawebView.super.onExit(self)
	UnityWebBridge.closeWebView()
end

function ZijiedatawebView:onEnter()
	ZijiedatawebView.super.onEnter(self)

	local msg = self:getFirstParam()

	if msg then
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
		local appCode = msg.appCode
		local platformId = msg.platformId
		local platformAccountId = msg.platformAccountId
		local timestamp = msg.timestamp
		local token = msg.sign
		local url = string.format("https://resource.172tt.com/inapp/dmw-kptoaq/?appCode=%s&platformId=%s&platformAccountId=%s&timestamp=%s&token=%s", appCode, platformId, platformAccountId, timestamp, token)

		if enableDebug then
			printError(">>>>>>>>>当前打开 url : ", url)
		end

		UnityWebBridge.openWebView(url, false, x, y, width, height)
	end
end

return ZijiedatawebView
