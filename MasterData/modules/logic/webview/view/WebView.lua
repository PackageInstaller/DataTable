-- chunkname: @modules/logic/webview/view/WebView.lua

module("modules.logic.webview.view.WebView", package.seeall)

local WebView = class("WebView", BaseView)

WebView.DEFAULT_OPEN_AUDIO_VOLUME = 0
WebView.DEFAULT_CLOSE_AUDIO_VOLUME = 50

function WebView:onInitView()
	self._gotools = gohelper.findChild(self.viewGO, "#go_tools")
	self._btnreload = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tools/#btn_reload")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tools/#btn_close")
	self._goweb = gohelper.findChild(self.viewGO, "#go_web")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WebView:addEvents()
	self._btnreload:AddClickListener(self._btnreloadOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self.onScreenSizeChanged, self)
end

function WebView:removeEvents()
	self._btnreload:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self.onScreenSizeChanged, self)
end

function WebView:_btnreloadOnClick()
	self.webViewComp:Reload()
end

function WebView:_btncloseOnClick()
	self:closeThis()
end

function WebView:_editableInitView()
	self.webViewComp = gohelper.onceAddComponent(self._goweb, typeof(ZProj.SLWebView))
end

function WebView:_onOpenView(viewName)
	if viewName == ViewName.ToastView then
		return
	end

	if viewName ~= self.viewName then
		self:closeThis()
	end
end

function WebView:onUpdateParam()
	self:openWeb()
end

function WebView:onOpen()
	self:openWeb()
end

function WebView:openWeb()
	self.url = self:getUrl()
	self.callback = self.viewParam.callback
	self.callbackObj = self.viewParam.callbackObj
	self.left = self.viewParam.left or WebViewEnum.DefaultMargin.Left
	self.right = self.viewParam.right or WebViewEnum.DefaultMargin.Right
	self.top = self.viewParam.top or WebViewEnum.DefaultMargin.Top
	self.bottom = self.viewParam.bottom or WebViewEnum.DefaultMargin.Bottom
	self.autoTop = self.viewParam.autoTop or true
	self.autoBottom = self.viewParam.autoBottom or true

	if not self.autoTop then
		if not self.top then
			local top = WebViewController.instance:getWebViewTopOffset(nil, nil, self.top)

			if not self.autoBottom then
				if not self.bottom then
					local bottom = WebViewController.instance:getWebViewBottomOffset(nil, nil, self.bottom)

					self.webViewComp:Show(self.url, self.callbackWrap, self, self.left, top, self.right, bottom)

					local volume = self.DEFAULT_OPEN_AUDIO_VOLUME

					AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, volume)
				end
			end
		end
	end
end

function WebView:onScreenSizeChanged(width, height)
	if not self.autoTop then
		if not self.top then
			local top = WebViewController.instance:getWebViewTopOffset(width, height, self.top)

			if not self.autoBottom then
				if not self.bottom then
					local bottom = WebViewController.instance:getWebViewBottomOffset(width, height, self.bottom)

					logNormal(string.format("Change WebView Margins width:%s height:%s", width, height))
					self.webViewComp.webViewObject:SetMargins(self.left, top, self.right, bottom)
				end
			end
		end
	end
end

function WebView:getUrl()
	local url = self.viewParam.url

	if not self.viewParam.needRecordUser then
		return url
	end

	return WebViewController.instance:getRecordUserUrl(url)
end

function WebView:callbackWrap(cbType, msg)
	logNormal(string.format("cur url : %s, cb type : %s, msg : %s", self.url, cbType, msg))

	if self.callback then
		return self.callback(self.callbackObj, cbType, msg)
	end
end

function WebView:onDestroyView()
	self.webViewComp:Recycle()

	self.webViewComp = nil
end

function WebView:onClose()
	local volume = SettingsModel.instance:getGlobalAudioVolume() or self.DEFAULT_CLOSE_AUDIO_VOLUME

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, volume)
end

return WebView
