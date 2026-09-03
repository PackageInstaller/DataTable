-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/SettingDownloadMediator.lua

SettingDownloadMediator = class("SettingDownloadMediator", DmPopupViewMediator, _M)

SettingDownloadMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

local kBtnHandlers = {
	["main.autoBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAutoDownload"
	}
}

function SettingDownloadMediator:initialize()
	super.initialize(self)
end

function SettingDownloadMediator:dispose()
	super.dispose(self)
end

function SettingDownloadMediator:onRemove()
	super.onRemove(self)
end

function SettingDownloadMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._loadingBar = self._main:getChildByFullName("loadingBar")
	self._text1 = self._main:getChildByFullName("text1")
	self._progressLabel = self._main:getChildByFullName("progressLabel")
	self._autoBtn = self._main:getChildByFullName("autoBtn")
	self._sureBtn = self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onOKClicked, self)
		}
	})

	bindWidget(self, "main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onOKClicked, self)
		},
		title = Strings:get("setting_ui_DownloadTips"),
		title1 = Strings:get("UITitle_EN_Xiazaitishi")
	})

	local canAuto = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.kAutoDownloadKey)

	self._autoBtn:getChildByFullName("image"):setVisible(canAuto)
end

function SettingDownloadMediator:enterWithData(data)
	self._eventKey = data.eventKey

	local tips = data.tips

	self._text1:setString(tips)
	self:refreshView(data)
	self.mapEventListener(self, self:getEventDispatcher(), self._eventKey, self, self.refreshViewByEvent)
end

function SettingDownloadMediator:refreshView(data)
	local totalSize = data.totalSize
	local currentSize = data.currentSize
	local percent = math.modf(data.progress)
	local str = Strings:get("Download_Tip", {
		percent = percent,
		current = string.format("%.1f", currentSize),
		total = string.format("%.1f", totalSize)
	})

	self._progressLabel:setString(str)
	self._loadingBar:setPercent(percent)
end

function SettingDownloadMediator:refreshViewByEvent(event)
	local data = event:getData()

	self:refreshView(data)
end

function SettingDownloadMediator:onOKClicked(sender, eventType)
	self:close()
end

function SettingDownloadMediator:onClickAutoDownload(sender, eventType)
	local canAuto = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.kAutoDownloadKey)
	local image = self._autoBtn:getChildByName("image")

	if image:isVisible() then
		canAuto = false

		image:setVisible(false)
	else
		canAuto = true

		image:setVisible(true)
	end

	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKey.kAutoDownloadKey, canAuto)

	if self._eventKey == EVT_DOWNLOAD_PORTRAIT then
		self._settingSystem:setPortraitIgnoreNetState(canAuto)
	elseif self._eventKey == EVT_DOWNLOAD_SOUNDCV then
		self._settingSystem:setSoundCVIgnoreNetState(canAuto)
	end
end

function SettingDownloadMediator:onTouchMaskLayer()
	self.unmapEventListener(self, self:getEventDispatcher(), self._eventKey, self, self.refreshViewByEvent)
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self:close()
end
