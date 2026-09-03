-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/BugFeedbackMediator.lua

BugFeedbackMediator = class("BugFeedbackMediator", DmPopupViewMediator, _M)

BugFeedbackMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BugFeedbackMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

function BugFeedbackMediator:initialize()
	super.initialize(self)
end

function BugFeedbackMediator:dispose()
	if self._webView then
		self._webView:removeFromParent()

		self._webView = nil
	end

	super.dispose(self)
end

function BugFeedbackMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
end

function BugFeedbackMediator:onRemove()
	super.onRemove(self)
end

function BugFeedbackMediator:enterWithData(data)
	self._main = self:getView():getChildByName("main")

	self._main:getChildByFullName("bg"):setVisible(false)
	self._main:getChildByFullName("Image_di"):setVisible(false)
	self._main:getChildByFullName("TextField"):setVisible(false)
	self._main:getChildByFullName("tipsText"):setVisible(false)
	self._main:getChildByFullName("btnOk"):setVisible(false)

	local CSDHelper = require("sdk.CSDHelper")
	local player = self._developSystem:getPlayer()
	local winSize = cc.Director:getInstance():getVisibleSize()

	if device.platform ~= "mac" and device.platform ~= "windows" then
		self._webView = ccui.WebView:create()

		if self._webView then
			self._webView:setPosition(winSize.width / 2, winSize.height / 2)
			self._webView:setContentSize(winSize.width / 2, winSize.height - 20)
			self._webView:loadURL(CSDHelper:getCSDUrl(player:getRid()))
			self._webView:setScalesPageToFit(true)
			self._webView:setVisible(false)

			self._waitingHandler = self:getInjector():instantiate("WaitingHandler")

			self._webView:setOnShouldStartLoading(function(sender, url)
				self:showWaiting()

				return true
			end)
			self._webView:setOnDidFinishLoading(function(sender, url)
				self._webView:setVisible(true)
				self:hideWaiting()
			end)
			self._webView:setOnDidFailLoading(function(sender, url)
				self._webView:setVisible(true)
				self:hideWaiting()
			end)
			self._webView:center(self._main:getContentSize())
			AdjustUtils.adjustLayoutByType(self:getView(), AdjustUtils.kAdjustType.Top)
			self._main:addChild(self._webView)
			self._webView:reload()
		end
	else
		cc.Application:getInstance():openURL(CSDHelper:getCSDUrl(player:getRid()))
	end
end

function BugFeedbackMediator:showWaiting()
	WaitingView:getInstance():show(WaitingStyle.kLoading, {})
end

function BugFeedbackMediator:hideWaiting()
	WaitingView:getInstance():hide()
end

function BugFeedbackMediator:mapEventListeners()
	return
end

function BugFeedbackMediator:onClickClose(sender, eventType)
	self._webView:setVisible(false)
	self:close()
end
