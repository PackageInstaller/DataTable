-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/NativeContentViewMediator.lua

NativeContentViewMediator = class("NativeContentViewMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickBack"
	}
}

function NativeContentViewMediator:initialize()
	super.initialize(self)
end

function NativeContentViewMediator:dispose()
	if self._myWebView then
		self._myWebView:removeFromParent()

		self._myWebView = nil
	end

	super.dispose(self)
end

function NativeContentViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function NativeContentViewMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._webView = self._main:getChildByFullName("webView")
	self._btn_close = self._main:getChildByFullName("btn_close")
end

function NativeContentViewMediator:mapEventListeners()
	local outSelf = self

	local function onKeyReleased(keyCode, event)
		if keyCode == cc.KeyCode.KEY_BACK then
			outSelf:onClickBack()
		end
	end

	local listener = cc.EventListenerKeyboard:create()

	listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self:getView())
end

function NativeContentViewMediator:enterWithData(data)
	self:initData(data)
	self:initWidgetInfo()
	self:initView()
end

function NativeContentViewMediator:initData(data)
	self._data = data

	if data then
		self._url = data.url or "https://www.baidu.com"
	end

	self._callback = data.callback
end

function NativeContentViewMediator:initView()
	local webViewSize = self._webView:getContentSize()
	local myplatform = device.platform

	if myplatform ~= "mac" and myplatform ~= "windows" then
		self._myWebView = ccui.WebView:create()

		if self._myWebView then
			self._myWebView:setPosition(webViewSize.width / 2, webViewSize.height / 2)
			self._myWebView:setContentSize(webViewSize.width, webViewSize.height)
			self._myWebView:setScalesPageToFit(true)
			self._myWebView:loadURL(self._url)
			self._myWebView:setOpacity(0)
			self._myWebView:reload()
			AdjustUtils.adjustLayoutByType(self:getView(), AdjustUtils.kAdjustType.Top)
			self._webView:addChild(self._myWebView)
		end
	else
		cc.Application:getInstance():openURL(self._url)
	end
end

function NativeContentViewMediator:onClickBack()
	if self._callback then
		self._callback()
	end

	self:close()
end
