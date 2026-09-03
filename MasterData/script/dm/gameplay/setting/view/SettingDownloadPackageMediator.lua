-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/SettingDownloadPackageMediator.lua

SettingDownloadPackageMediator = class("SettingDownloadPackageMediator", DmPopupViewMediator, _M)

SettingDownloadPackageMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

local kBtnHandlers = {
	["main.autoBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAutoDownload"
	}
}

function SettingDownloadPackageMediator:initialize()
	super.initialize(self)
end

function SettingDownloadPackageMediator:dispose()
	self.unmapEventListener(self, self:getEventDispatcher(), EVT_DOWNLOAD_PACKAGE, self, self.refreshViewByEvent)
	super.dispose(self)
end

function SettingDownloadPackageMediator:onRemove()
	super.onRemove(self)
end

function SettingDownloadPackageMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DOWNLOAD_PACKAGE, self, self.refreshViewByEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DOWNLOAD_PACKAGE_OVER, self, self.downloadOver)

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

	self._main:getChildByFullName("btn_ok"):setVisible(false)
	bindWidget(self, "main.bg", PopupNormalWidget, {
		title = Strings:get("setting_ui_DownloadTips"),
		title1 = Strings:get("UITitle_EN_Xiazaitishi")
	})

	local canAuto = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.kAutoDownloadKey)

	self._autoBtn:getChildByFullName("image"):setVisible(canAuto)
end

function SettingDownloadPackageMediator:enterWithData(data)
	self._callFunc = data.callFunc

	local tips = data.tips

	self._text1:setString(tips)
	self:refreshView(data)
end

function SettingDownloadPackageMediator:refreshView(data)
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

function SettingDownloadPackageMediator:refreshViewByEvent(event)
	local data = event:getData()

	self:refreshView(data)
end

function SettingDownloadPackageMediator:downloadOver()
	if story then
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		if storyDirector then
			storyDirector:notifyWaiting("download_150package_res_finish")
		end
	end

	if self._callFunc then
		self._callFunc()
	end

	self:close()
end

function SettingDownloadPackageMediator:onOKClicked(sender, eventType)
	if self._settingSystem:getPackageProgress() == 100 then
		self:downloadOver()
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("setting_ui_DownloadTips_1")
		}))
	end
end

function SettingDownloadPackageMediator:onClickAutoDownload(sender, eventType)
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
	self._settingSystem:setPackageIgnoreNetState(canAuto)
end

function SettingDownloadPackageMediator:onTouchMaskLayer()
	return
end
