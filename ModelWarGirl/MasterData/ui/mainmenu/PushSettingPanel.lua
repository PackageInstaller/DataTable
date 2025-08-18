-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\PushSettingPanel.lua

local UserData = require("Helper/UserData")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local EventConst = require("EventConst")
local NotificationManager = require("SDK/Plugin/NotificationManager")
local WebView = require("SDK/Plugin/WebView")
local SDKCore = require("SDK/SDKCore")
local VersionUtils = require("System/VersionUtils")
local PushSettingPanel = Class("PushSettingPanel", UIControls.Panel)
local PushSettingKey = "push_setting_kr"

PushSettingPanel.btnName = {
	Lang.get(55291),
	Lang.get(48065),
	Lang.get(48064),
	(Lang.get(48066))
}
PushSettingPanel.MAX_BTN_COUNT = 4
PushSettingPanel.isKoreaCBTest = true
PushSettingPanel.ignoreBtn = {
	[1] = "",
	[2] = ""
}

function PushSettingPanel:ctor()
	self.panelPush = UIControls.Panel(self, "BgPanel/SetPanel/Content/ImgNotice")

	self.panelPush:setVisible(true)
	self:socialPanel()

	self.version179754 = VersionUtils.getEngineVersion() < 179754
	self.pushBtns = {}
	self.imgPoints = {}
	self.pushImg = {}

	for i = 1, #self.btnName do
		self.pushBtns[i] = UIControls.Button(self, self.mPath .. "/Btn" .. i, "TextTitle")

		self.pushBtns[i]:setText(self.btnName[i])
		self.pushBtns[i]:addEventClick(Functor(self.onPushButtonClick, self, self.btnName[i]))

		self.pushImg[self.btnName[i]] = UIControls.Image(self, self.mPath .. "/Btn" .. i .. "/Img")
		self.imgPoints[i] = UIControls.Image(self, self.mPath .. "/Btn" .. i .. "/Img/ImgSel/ImgPoint")
	end

	self.labelNightPushTime = UIControls.Label(self, self.mPath .. "/Btn4/TextTime")

	self.labelNightPushTime:setText("[21:00 ~ 8:00]")
	self:initData()
	self:setLastSetting()
	self:CBTest()
end

function PushSettingPanel:initData()
	local pushData = UserData.loadCommonData(PushSettingKey)

	if pushData ~= "" then
		self.userDataPush = ClientUtils.string2Table(pushData)
	else
		self.userDataPush = {
			[self.btnName[1]] = "1",
			[self.btnName[2]] = "1",
			[self.btnName[3]] = "1"
		}
	end

	if not IS_EDITOR then
		local platformData = SDKCore.getPlatformData()

		self.userDataPush[self.btnName[1]] = platformData and platformData.NotificationStatus or "0"

		if not self.userDataPush[self.btnName[4]] then
			local succ, result = ChannelUtil.doAnyFunction("getNightPushEnabled", {
				[AttName.EXTRA_FUNCTION_VALUE] = "",
				[AttName.EXTRA_FUNCTION_VALUE_2] = 1
			})

			self.userDataPush[self.btnName[4]] = succ and result or "0"

			UserData.saveCommonData(PushSettingKey, ClientUtils.table2String(self.userDataPush))
			UserData.save()
		end
	end
end

function PushSettingPanel:setLastSetting()
	for k, v in pairs(self.userDataPush) do
		if self.userDataPush[self.btnName[1]] == "0" and not self.version179754 then
			self:_refreshSwitch(self.pushImg[k], false)

			self.userDataPush[k] = "0"
		else
			self:_refreshSwitch(self.pushImg[k], v == "1")
		end
	end

	if not self.version179754 then
		self:refreshOperationBtn()
	end

	self:refreshNightBtn()
end

function PushSettingPanel:CBTest()
	if self.version179754 then
		self.pushBtns[1]:setVisible(false)

		self.ignoreBtn = {
			[1] = "",
			[2] = ""
		}
	end

	self.pushBtns[2]:setVisible(false)
end

function PushSettingPanel:onPushButtonClick(btn)
	if btn == self.btnName[1] then
		self:btnJump2SettingClick()
	elseif btn == self.btnName[2] then
		self:btnHangUpClick()
	elseif btn == self.btnName[3] then
		if self.userDataPush[self.btnName[1]] == "1" then
			self:btnOperationClick()
		end
	elseif btn == self.btnName[4] then
		self:btnNightClick()
	end

	if not self.isAllPushClick then
		self:checkAllPush()
	end

	self.isAllPushClick = false
	self.isForOpen = false

	self:refreshNightBtn()
	UserData.saveCommonData(PushSettingKey, ClientUtils.table2String(self.userDataPush))
end

function PushSettingPanel:refreshOperationBtn()
	if self.userDataPush[self.btnName[1]] == "0" then
		self.pushImg[self.btnName[3]]:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnDis")
		self.imgPoints[3]:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnSwitchDis")
	else
		self.pushImg[self.btnName[3]]:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnOff")
		self.imgPoints[3]:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnSwitch")
	end
end

function PushSettingPanel:refreshNightBtn()
	if not self:getNightPushBtnState() and self.userDataPush[self.btnName[4]] == "0" then
		self.pushImg[self.btnName[4]]:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnDis")
		self.imgPoints[4]:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnSwitchDis")
	else
		self.pushImg[self.btnName[4]]:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnOff")
		self.imgPoints[4]:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnSwitch")
	end
end

function PushSettingPanel:getNightPushBtnState()
	local isNightCloudClick = false

	for i = 2, self.MAX_BTN_COUNT - 1 do
		if self.userDataPush[self.btnName[i]] == "1" and not self.ignoreBtn[i] then
			isNightCloudClick = true

			break
		end
	end

	return isNightCloudClick
end

function PushSettingPanel:btnJump2SettingClick()
	self.isAllPushClick = true

	local function yesFunc()
		self.mWindow:setVisible(false)
		Framework.Plugin.PermissionManager.ShowAppSetting()
		ChannelUtil.doAnyFunction("getNotificationStatus", {})
		self:testFunc()
	end

	local function noFunc()
		ChannelUtil.doAnyFunction("getNotificationStatus", {})
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), Lang.get(54609), yesFunc, noFunc)
end

function PushSettingPanel:testFunc()
	self.coGetNotificationStatus = coroutine.start(function()
		coroutine.wait(0.2)
		ChannelUtil.doAnyFunction("getNotificationStatus", {})
	end)
end

function PushSettingPanel:tryRefreshAllPushBtn()
	if self.coGetNotificationStatus then
		coroutine.stop(self.coGetNotificationStatus)

		self.coGetNotificationStatus = nil
	end
end

function PushSettingPanel:btnAllClick()
	local all = self.userDataPush[self.btnName[1]]

	if all == "1" then
		for i = 1, self.MAX_BTN_COUNT do
			if self.ignoreBtn and self.ignoreBtn[i] then
				-- block empty
			else
				self:_refreshSwitch(self.pushImg[self.btnName[i]], false)

				self.userDataPush[self.btnName[i]] = "0"
			end
		end
	else
		for i = 1, self.MAX_BTN_COUNT do
			if self.ignoreBtn and self.ignoreBtn[i] then
				-- block empty
			else
				self:_refreshSwitch(self.pushImg[self.btnName[i]], true)

				self.userDataPush[self.btnName[i]] = "1"
			end
		end
	end

	self.isAllPushClick = true
end

function PushSettingPanel:btnHangUpClick()
	local hangUp = self.userDataPush[self.btnName[2]]

	if hangUp == "1" then
		self:_refreshSwitch(self.pushImg[self.btnName[2]], false)

		self.userDataPush[self.btnName[2]] = "0"
	else
		self:_refreshSwitch(self.pushImg[self.btnName[2]], true)

		self.userDataPush[self.btnName[2]] = "1"
		self.isForOpen = true
	end
end

function PushSettingPanel:btnOperationClick()
	local operation = self.userDataPush[self.btnName[3]]

	if operation == "1" then
		self:_refreshSwitch(self.pushImg[self.btnName[3]], false)

		self.userDataPush[self.btnName[3]] = "0"

		NotificationManager.cancelAll()
	else
		self:_refreshSwitch(self.pushImg[self.btnName[3]], true)

		self.userDataPush[self.btnName[3]] = "1"
		self.isForOpen = true
	end
end

function PushSettingPanel:btnNightClick()
	if not self:getNightPushBtnState() then
		return
	end

	local night = self.userDataPush[self.btnName[4]]

	if night == "1" then
		ChannelUtil.doAnyFunction("setNightPushEnabled", "0")
		self:_refreshSwitch(self.pushImg[self.btnName[4]], false)

		self.userDataPush[self.btnName[4]] = "0"
	else
		ChannelUtil.doAnyFunction("setNightPushEnabled", "1")
		self:_refreshSwitch(self.pushImg[self.btnName[4]], true)

		self.userDataPush[self.btnName[4]] = "1"
		self.isForOpen = true
	end
end

function PushSettingPanel:checkAllPush()
	local pushNum = 0

	for i = 2, self.MAX_BTN_COUNT - 1 do
		if self.userDataPush[self.btnName[i]] == "1" and not self.ignoreBtn[i] then
			pushNum = pushNum + 1
		end
	end

	if pushNum == 0 then
		self:_refreshSwitch(self.pushImg[self.btnName[4]], false)

		self.userDataPush[self.btnName[4]] = "0"

		ChannelUtil.doAnyFunction("setNightPushEnabled", "0")
	elseif pushNum == self.MAX_BTN_COUNT - 3 then
		-- block empty
	end

	if self.isForOpen then
		self:_refreshSwitch(self.pushImg[self.btnName[4]], true)

		self.userDataPush[self.btnName[4]] = "1"

		ChannelUtil.doAnyFunction("setNightPushEnabled", "1")
	end
end

function PushSettingPanel:_refreshSwitch(imgSwitch, isOn)
	if imgSwitch then
		if isOn then
			imgSwitch:playAnimator("BtnSwitchOn")
		else
			imgSwitch:playAnimator("BtnSwitchOff")
		end
	end
end

function PushSettingPanel:getPushEnable(idx)
	if not self.userDataPush then
		self:initData()
	end

	return self.userDataPush[self.btnName[idx]] == "1"
end

PushSettingPanel.BTN_SOCIAL = {
	"공식카페",
	"페이스북",
	"트위터"
}

function PushSettingPanel:socialPanel()
	self.panelSocial = UIControls.Panel(self, "BgPanel/SetPanel/Content/ImgSocial")

	self.panelSocial:setVisible(true)

	self.btnSocial = {}

	for i = 1, 3 do
		self.btnSocial[i] = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgSocial/Btn" .. i, "Text")

		self.btnSocial[i]:addEventClick(Functor(self.socialBtnClick, self, i))
		self.btnSocial[i]:setText(self.BTN_SOCIAL[i])
	end

	self.btnSocial[2]:setVisible(false)
end

function PushSettingPanel:onOpen()
	PushSettingPanel.super:onOpen(self)

	self.labelSocial = UIControls.Label(self, "BgPanel/SetPanel/Content/ImgSocial/TextTitle")

	self.labelSocial:setText("커뮤니티")
end

function PushSettingPanel:socialBtnClick(idx)
	local url = ""

	if idx == 1 then
		url = "https://cafe.naver.com/minius"
	elseif idx == 2 then
		url = "https://www.facebook.com/miniuskr/"
	elseif idx == 3 then
		url = "https://twitter.com/Minius_kr"
	end

	WebView.openWebView(url)

	if idx == 1 then
		EventCenter.sendEvent(EventConst.JUMP_GUIDE, 1)
	end
end

return PushSettingPanel
