-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\PlayerInfoPanel.lua

local ResRoleAttr = require("ClientData/ResRoleAttr")
local SubpackageHelper = require("Helper/SubpackageHelper")
local DeviceHelper = require("Helper/DeviceHelper")
local WebView = require("SDK/Plugin/WebView")
local Analytics = require("SDK/Analytics")
local UserData = require("Helper/UserData")
local SubpackageUtils = Framework.Download.SubpackageUtils
local NativeUtils = Framework.Plugin.NativeUtils
local LuaToolkit = Framework.Tools.LuaToolkit
local PlayerInfoPanel = Class("PlayerInfoPanel", UIControls.Panel)
local wifi = {
	"ImgWifi00",
	"ImgWifi01",
	"ImgWifi02",
	"ImgWifi03",
	"ImgWifi04"
}
local ATLAS_BATTLE_NEW = "Atlas/MainBattleAtlas/MainBattleAtlasNew"

function PlayerInfoPanel:ctor()
	self.btnSensor = UIControls.Button(self, self.mPath .. "/BtnPlayerInfo")

	self.btnSensor:addEventClick(self.onPlayerClick)

	self.btnHead = UIControls.PlayerHeadGridChild(self, self.mPath .. "/BtnPlayerInfo/BgPlayer/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:setEnable(false)

	self.txtName = UIControls.Label(self, self.mPath .. "/BtnPlayerInfo/NamePanel/TextName")
	self.panelVip = UIControls.PanelPlayerVip(self, self.mPath .. "/VIPPanel")
	self.txtTime = UIControls.Label(self, self.mPath .. "/BtnPlayerInfo/MobileInfo/TextTime")
	self.barExp = UIControls.Slider(self, self.mPath .. "/BtnPlayerInfo/SliderExp")
	self.imageBattery = UIControls.Image(self, self.mPath .. "/BtnPlayerInfo/MobileInfo/ImgBattery")
	self.barBattery = UIControls.MaterialProgress(self, self.mPath .. "/BtnPlayerInfo/MobileInfo/ImgBattery/SliderBattery")
	self.wifiState = UIControls.Image(self, self.mPath .. "/BtnPlayerInfo/MobileInfo/IconSignal")

	self.wifiState:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "ImgWifi04")

	self.btnDownload = UIControls.Button(self, self.mPath .. "/BtnDownload", "Text")

	self.btnDownload:addEventClick(self.onDownloadClick)

	self._timer = Timer.New(Slot(self.onTimeUpdata, self), 30, -1)
	self._timerBattery = Timer.New(Slot(self.onTimeUpdataBattery, self), 60, -1)
	self._timerWifi = Timer.New(Slot(self.onTimeUpdataWifi, self), 10, -1)
	self._timerDownload = Timer.New(Slot(self.onTimeUpdateDownload, self), 2, -1)
	self.redHintVip = UIControls.RedDot(self, self.mPath .. "/BtnPlayerInfo/IconNew")

	self.redHintVip:addHint({
		UIConst.RD_HINT_MAIN_HEAD
	})

	self.btnBBS = UIControls.Button(self, self.mPath .. "/BtnBBS")

	self.btnBBS:addEventClick(self.onBBSClick)

	self.redBBS = UIControls.RedDot(self, self.mPath .. "/BtnBBS/IconNew")

	self.redBBS:addHint({
		UIConst.RD_HINT_SDK_BBS_MSG
	})

	self.btnSocialMore = UIControls.Button(self, self.mPath .. "/BtnSocialMore")

	self.btnSocialMore:addEventClick(self.onMoreSocialClick)
	self.btnSocialMore:setVisible(false)

	self.imgSocialMore = UIControls.Image(self, self.mPath .. "/BtnSocialMore/Img")
	self.btnUIClickThrough = UIControls.Button(self, self.mPath .. "/SocialMorePanel/UIClickThrough")

	self.btnUIClickThrough:addEventClick(self.onMoreSocialClick)

	self.panelSocialMore = UIControls.Panel(self, self.mPath .. "/SocialMorePanel")

	self.panelSocialMore:setVisible(false)

	self.btnSocialBBS = UIControls.Button(self, self.mPath .. "/SocialMorePanel/BtnBBS")

	self.btnSocialBBS:addEventClick(self.onBBSClick)
	self.btnSocialBBS:setVisible(false)

	self.btnSocialDiscord = UIControls.Button(self, self.mPath .. "/SocialMorePanel/BtnDiscord")

	self.btnSocialDiscord:addEventClick(self.onDiscordClick)
	self.btnSocialDiscord:setVisible(false)

	self.resDotSocialMore = UIControls.Panel(self, self.mPath .. "/BtnSocialMore/IconNew")
	self.resDotSocialDiscord = UIControls.Panel(self, self.mPath .. "/SocialMorePanel/BtnDiscord/IconNew")
	self.btnSocialTwitter = UIControls.Button(self, self.mPath .. "/SocialMorePanel/BtnTwitter")

	self.btnSocialTwitter:setVisible(false)
	self.btnSocialTwitter:addEventClick(self.onTwitterClick)

	self.btnSocialFaceBook = UIControls.Button(self, self.mPath .. "/SocialMorePanel/BtnFacebook")

	self.btnSocialFaceBook:setVisible(false)
	self.btnSocialFaceBook:addEventClick(self.onFaceBookClick)

	self.imgQQVip1 = UIControls.Image(self, self.mPath .. "/BtnPlayerInfo/NamePanel/QQVip1")
	self.imgQQVip2 = UIControls.Image(self, self.mPath .. "/BtnPlayerInfo/NamePanel/QQVip2")
	self.btnYoutube = UIControls.Button(self, self.mPath .. "/SocialMorePanel/BtnYouTube")

	self.btnYoutube:addEventClick(self.onYoutubeClick)
end

function PlayerInfoPanel:onStart()
	self._timerBattery:Start()
	self._timerWifi:Start()
	self._timerDownload:Start()
	self._timer:Start()
	self:onTimeUpdata()
	self:updateInfo()
	self:onTimeUpdataBattery()
	self:onTimeUpdataWifi()
	self:updateDownloadInfo()
	self:setTwitterVisible()
	self:setBBSVisiable()
	self:updateQQVip()
	self:updateBBSNew()
	self:updateBtnYoutube()
end

function PlayerInfoPanel:updateInfo()
	if CurAvatar then
		self.txtName:setText(CurAvatar:getPlayerName() or "")
		self.panelVip:setData(CurAvatar.vipLevel, CurAvatar:getVipShowState())

		local lv = CurAvatar:getLevel()
		local value = 1
		local lvData = ResRoleAttr[lv]

		if lvData and lvData.levelxp then
			value = CurAvatar:getExp() / lvData.levelxp
		end

		self.barExp:setValue(value)
		self.btnHead:setCommInfo(CurAvatar:getMyCommInfo(), false, self)
	end
end

function PlayerInfoPanel:onPlayerClick(sender)
	CurAvatar:showPlayerTips(CurAvatar.uid, self, true)
end

function PlayerInfoPanel:onDownloadClick(sender)
	UIManager.getUI("downloadBox", true, true)
end

function PlayerInfoPanel:updateBatteryInfo()
	local batteryLevel = NativeUtils.GetBatteryLevel()

	batteryLevel = batteryLevel / 100

	self.barBattery:setValue(batteryLevel)
end

function PlayerInfoPanel:updateWifiInfo()
	local iconIndex = #wifi

	if DeviceHelper.isIOS() then
		local networkType = LuaToolkit.GetNetworkType()

		if DeviceHelper.NET_DATA == networkType then
			iconIndex = 1
		end
	else
		local wifiLevel = NativeUtils.GetWIFIStrength()

		wifiLevel = math.max(0, math.min(wifiLevel, 5))

		if wifiLevel < 5 then
			iconIndex = wifiLevel + 1
		end
	end

	local iconName = wifi[iconIndex]

	if iconName then
		self.wifiState:setImage(ATLAS_BATTLE_NEW, iconName)
	end
end

function PlayerInfoPanel:updateDownloadInfo()
	local progress = SubpackageHelper.getSizeDone() / SubpackageHelper.getSizeTotal()
	local visible = progress < 1

	self.btnDownload:setVisible(visible)

	if visible then
		self.btnDownload:setText(tostring(math.floor(progress * 100)) .. "%")
	else
		self._timerDownload:Stop()
	end
end

function PlayerInfoPanel:onTimeUpdata()
	if not self.mWindow:isInShow() then
		return
	end

	self.txtTime:setText(ClientUtils.getServerTimeData(nil, "%H:%M"))
end

function PlayerInfoPanel:clear()
	self._timer:Stop()
	self._timerBattery:Stop()
	self._timerWifi:Stop()
	self._timerDownload:Stop()
end

function PlayerInfoPanel:onTimeUpdataBattery()
	if not self.mWindow:isInShow() then
		return
	end

	self:updateBatteryInfo()
end

function PlayerInfoPanel:onTimeUpdataWifi()
	if not self.mWindow:isInShow() then
		return
	end

	self:updateWifiInfo()
end

function PlayerInfoPanel:onTimeUpdateDownload()
	if not self.mWindow:isInShow() then
		return
	end

	self:updateDownloadInfo()
end

function PlayerInfoPanel:setBBSVisiable()
	if VersionUtils.IsReviewVersion() then
		self.btnBBS:setVisible(false)
		self.btnSocialTwitter:setVisible(false)
		self.btnSocialMore:setVisible(false)
		self.btnSocialFaceBook:setVisible(false)
	elseif RegionUtils.isJP() or RegionUtils.isTW() or RegionUtils.isKR() then
		self.btnBBS:setVisible(true)
	elseif RegionUtils.isSEA() then
		if ChannelUtil.isSteam() then
			self.btnBBS:setVisible(true)
			self.btnSocialMore:setVisible(true)
			self.btnSocialDiscord:setVisible(true)
		else
			self.btnSocialMore:setVisible(true)
			self.btnBBS:setVisible(true)
			self.btnSocialFaceBook:setVisible(true)
		end
	elseif GameConfig.getChannelConfig(Const.REMOTE_CONFIG_HIDE_BBS) == 1 then
		self.btnBBS:setVisible(false)
	elseif VersionUtils.hasAbilityForum() then
		self.btnBBS:setVisible(true)
		SDKAgent.requestBBSNum()
	else
		self.btnBBS:setVisible(false)
	end
end

function PlayerInfoPanel:onMoreSocialClick()
	if self.panelSocialMore:getVisible() then
		self.panelSocialMore:setVisible(false)
		self.imgSocialMore:setRotate(0)
	else
		self.panelSocialMore:setVisible(true)
		self.imgSocialMore:setRotate(180)
	end
end

function PlayerInfoPanel:setTwitterVisible()
	if RegionUtils.isJP() then
		self.btnSocialTwitter:setVisible(true)
	end
end

function PlayerInfoPanel:onBBSClick()
	if RegionUtils.isTW() then
		JumpGuideManager.jump(Const.TW_HOMEPAGE_GUIDE_ID)
	elseif RegionUtils.isJP() then
		JumpGuideManager.jump(163)
		Analytics.sendWindowOperaLog(true, "onBBSClick")
	elseif RegionUtils.isKR() then
		WebView.openWebView("https://cafe.naver.com/minius")

		local EventConst = require("EventConst")

		EventCenter.sendEvent(EventConst.JUMP_GUIDE)
	elseif RegionUtils.isSEA() then
		if self.needRecordSeaBBS then
			self.redBBS:setVisible(false)
			UserData.setClientData(Const.USER_KEY_SEA_BBS_NEW, self.needRecordSeaBBS)

			self.needRecordSeaBBS = nil
		end

		if ChannelUtil.isSteam() then
			WebView.openWebView("https://store.steampowered.com/app/2996570")
		else
			JumpGuideManager.jump(Const.SEA_HOMEPAGE_GUIDE_ID)
		end
	else
		SDKAgent.openForum()
	end
end

function PlayerInfoPanel:onDiscordClick()
	if RegionUtils.isJP() then
		JumpGuideManager.jump(176)
		UserData.saveCommonData("resDotSocialDiscord_jp", "saved")
		self.resDotSocialDiscord:setVisible(false)
		self.resDotSocialMore:setVisible(false)
		Analytics.sendWindowOperaLog(true, "onDiscordClick")
	end

	if ChannelUtil.isSteam() then
		WebView.openWebView("https://discord.gg/bMfKUwFGeT")
	end
end

function PlayerInfoPanel:onFaceBookClick()
	if RegionUtils.isSEA() then
		JumpGuideManager.jump(180)
	end
end

function PlayerInfoPanel:onTwitterClick()
	if RegionUtils.isJP() then
		JumpGuideManager.jump(Const.JP_HOMEPAGE_GUIDE_ID)
		Analytics.sendWindowOperaLog(true, "onTwitterClick")
	end
end

function PlayerInfoPanel:updateQQVip()
	if ChannelUtil.isQQGame() then
		local QQGameHelper = require("Helper/QQGameHelper")
		local qqAtlas = "Atlas/QQ/QQGameAtlas"
		local qqVipLevel = CurAvatar.qqBlueLevel
		local qqVipStep = CurAvatar:getQQBlueStep()
		local isAnnual = QQGameHelper.isAnnualVip(qqVipStep)
		local iconPrefix = QQGameHelper.isSuperVip(qqVipStep) and "SVip" or "Vip"

		if qqVipLevel and qqVipLevel > 0 then
			self.imgQQVip1:setImage(qqAtlas, iconPrefix .. qqVipLevel)
			self.imgQQVip1:setVisible(true)
		end

		if isAnnual then
			self.imgQQVip2:setImage(qqAtlas, "AnnualVip")
			self.imgQQVip2:setVisible(true)
		else
			self.imgQQVip2:setVisible(false)
		end
	else
		self.imgQQVip1:setVisible(false)
		self.imgQQVip2:setVisible(false)
	end
end

function PlayerInfoPanel:updateBBSNew()
	if RegionUtils.isSEA() then
		local wday = 6
		local hourTime = 28805
		local fixedZone = 8
		local lastTime = 86410
		local passedTime = ClientUtils.getNextWdayByOffset(wday, hourTime, fixedZone) - 604800
		local nowTime = ClientUtils.getServerTime() - passedTime

		if nowTime <= lastTime and UserData.getClientData(Const.USER_KEY_SEA_BBS_NEW) ~= tostring(passedTime) then
			self.redBBS:setVisible(true)

			self.needRecordSeaBBS = tostring(passedTime)
		end
	end
end

function PlayerInfoPanel:updateBtnYoutube()
	if ClientUtils.canOpenCountryEntry(2) then
		self.btnYoutube:setVisible(true)
	else
		self.btnYoutube:setVisible(false)
	end
end

function PlayerInfoPanel:onYoutubeClick()
	ClientUtils.jumpCountryEntry(2)
end

function PlayerInfoPanel:setDMMVisiable()
	if not DeviceHelper.isIOS() and RegionUtils.isJP() and VersionUtils.hasAbilityDMMSuccession() then
		local succ, channel = ChannelUtil.doAnyFunction("getBytedanceChannel", {})

		if succ and channel == "dmm" then
			self.btnBBS:setVisible(false)
			self.btnSocialMore:setVisible(false)
			self.btnSocialDiscord:setVisible(false)
			self.btnSocialTwitter:setVisible(false)
		end
	end
end

return PlayerInfoPanel
