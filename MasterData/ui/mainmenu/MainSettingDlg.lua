-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\MainSettingDlg.lua

local GameSettings = require("Helper/GameSettings")
local NetService = require("Network/NetService")
local SDKConst = require("SDK/SDKConst")
local ChatService = require("Network/ChatService")
local SDKAppUtils = require("SDK/SDKAppUtils")
local VersionUtils = require("System/VersionUtils")
local SettingConfig = require("DesignerScript/SettingConfig")
local QualitySettingPanel = require("UI/MainMenu/QualitySettingPanel")
local PushSettingPanel = require("UI/MainMenu/PushSettingPanel")
local UrlConfig = require("Network/UrlConfig")
local UserData = require("Helper/UserData")
local DeviceHelper = require("Helper/DeviceHelper")
local SDKAgent = SDKAgent
local ChannelUtil = ChannelUtil
local ChannelID = SDKConst.ChannelID
local strClassName = "MainSettingDlg"
local MainSettingDlg = Class(strClassName, UIControls.Window)
local CVToggle = Class("CVToggle", UIControls.Child)

function CVToggle:ctor()
	self.btnChoose = UIControls.Toggle(self, "")

	self.btnChoose:addEventValueChanged(self.onChooseClick)

	self.textCv = UIControls.Label(self, "Text")
end

function CVToggle:setData(cvType)
	self.cvType = cvType

	self.textCv:setText(Const.CV_BTN_NAME[cvType][1])
end

function CVToggle:onChooseClick()
	self.mParent:onChooseCV(self)
end

local VolumeSetPanel = Class("VolumeSetPanel", UIControls.Panel)

function VolumeSetPanel:ctor(...)
	self:initUI()
end

function VolumeSetPanel:initUI(...)
	self.volumeSlider = UIControls.Slider(self, self.mPath .. "/Slider")

	self.volumeSlider:addEventValueChanged(self._onVolumeChanged)

	self.volumeMuteBtn = UIControls.Button(self, self.mPath .. "/BtnMute")

	self.volumeMuteBtn:addEventClick(self._onClickVolMute)

	self.volumeMuteImg = UIControls.Image(self, self.mPath .. "/BtnMute/Icon")
end

function VolumeSetPanel:setVolumeType(volumeType)
	self.volumeType = volumeType

	if self.volumeType == Const.VOLUME_TYPE_MUSIC then
		self.getVolumeFunc = GameSettings.getBGMVolume
		self.setVolumeFunc = GameSettings.setBGMVolume
		self.setMuteFunc = GameSettings.setBGMMute
	elseif self.volumeType == Const.VOLUME_TYPE_SFX then
		self.getVolumeFunc = GameSettings.getSFXVolume
		self.setVolumeFunc = GameSettings.setSFXVolume
		self.setMuteFunc = GameSettings.setSFXMute
	elseif self.volumeType == Const.VOLUME_TYPE_VOCAL then
		self.getVolumeFunc = GameSettings.getVocalVolume
		self.setVolumeFunc = GameSettings.setVocalVolume
		self.setMuteFunc = GameSettings.setVocalMute
	end

	local soundVolume, soundMute = self:_getSoundSetting()

	if not soundVolume then
		soundVolume = 1
		soundMute = false
	end

	soundVolume = math.max(0, math.min(1, soundVolume))

	self.volumeSlider:setValue(soundVolume)
	self:_refreshMuteBtn(soundMute)

	self.volumeTriggerCancelMute = true
end

function VolumeSetPanel:_onVolumeChanged(sender)
	local vol = sender:getValue()

	self:_setSoundVolume(vol)

	if self.volumeTriggerCancelMute then
		self:_setSoundMute(false)
		self:_refreshMuteBtn(false)
	end
end

function VolumeSetPanel:_onClickVolMute(...)
	local vol, oldMute = self:_getSoundSetting()
	local isMute = not oldMute

	self:_setSoundMute(isMute)
	self:_refreshMuteBtn(isMute)
end

function VolumeSetPanel:_setSoundVolume(vol)
	if self.setVolumeFunc then
		self.setVolumeFunc(vol)
	end
end

function VolumeSetPanel:_setSoundMute(mute)
	if self.setMuteFunc then
		self.setMuteFunc(mute)
	end
end

function VolumeSetPanel:_getSoundSetting()
	if self.getVolumeFunc then
		return self.getVolumeFunc()
	end
end

function VolumeSetPanel:_refreshMuteBtn(isMute)
	if isMute then
		self.volumeMuteImg:setImage("Atlas/SetAtlas/SetAtlas", "VoiceDis")
	else
		self.volumeMuteImg:setImage("Atlas/SetAtlas/SetAtlas", "VoiceNml")
	end
end

function MainSettingDlg:ctor(...)
	self:initUI()
end

function MainSettingDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "BgPanel/BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.playerNameTxt = UIControls.Label(self, "BgPanel/PlayerInfoPanel/PlayerInfo/TextName")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/PlayerInfo/BgPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:hideLevel()
	self.btnHead:setEnable(false)

	self.changeAccountBtn = UIControls.Button(self, "BgPanel/PlayerInfoPanel/FuncPanel/BtnChangeID", "Text")

	self.changeAccountBtn:addEventClick(self._onClickSwitchAccount)

	self.giftExchangeBtn = UIControls.Button(self, "BgPanel/PlayerInfoPanel/FuncPanel/BtnGift")

	self.giftExchangeBtn:addEventClick(self._onGiftExchange)

	self.noticeBtn = UIControls.Button(self, "BgPanel/PlayerInfoPanel/FuncPanel/BtnNotice")

	self.noticeBtn:addEventClick(self._onNoticeClick)

	self.noticeRedDot = UIControls.RedDot(self, "BgPanel/PlayerInfoPanel/FuncPanel/BtnNotice/IconNew")

	self.noticeRedDot:addHint({
		UIConst.RD_HINT_NOTICE
	})

	self.contactBtn = UIControls.Button(self, "BgPanel/PlayerInfoPanel/FuncPanel/BtnContact")

	self.contactBtn:addEventClick(self._onClickcustomerService)

	self.contactRedDot = UIControls.RedDot(self, "BgPanel/PlayerInfoPanel/FuncPanel/BtnContact/IconNew")

	self.contactRedDot:addHint({
		UIConst.RD_HINT_CUSTOMER
	})

	self.changeSvrBtn = UIControls.Button(self, "BgPanel/PlayerInfoPanel/FuncPanel/BtnChangeServer")

	self.changeSvrBtn:addEventClick(self._onClickChangeSvr)

	self.blogBtn = UIControls.Button(self, "BgPanel/PlayerInfoPanel/FuncPanel/BtnBlog", "Text")

	self.blogBtn:addEventClick(self._onBlogBtn)

	self.musicVolumePanel = VolumeSetPanel(self, "BgPanel/SetPanel/Content/GameVoiceSet/MusicPanel")
	self.sfxVolumePanel = VolumeSetPanel(self, "BgPanel/SetPanel/Content/GameVoiceSet/SoundPanel")
	self.vocalVolumePanel = VolumeSetPanel(self, "BgPanel/SetPanel/Content/GameVoiceSet/VoicePanel")
	self.chatMuteBtn = UIControls.Button(self, "BgPanel/SetPanel/Content/ChatVoiceSet/BtnMute")

	self.chatMuteBtn:addEventClick(self._onClickChatMute)

	self.chatMuteImg = UIControls.Image(self, "BgPanel/SetPanel/Content/ChatVoiceSet/BtnMute")
	self.qualityPanel = QualitySettingPanel(self, "BgPanel/SetPanel/Content/ImgQualitySet")
	self.checkDiamond = UIControls.Button(self, "BgPanel/PlayerInfoPanel/FuncPanel/BtnOther", "Text")

	self.checkDiamond:addEventClick(self._showDiamond)

	self._slotConfirmSwitchAccount = Slot(self._onConfirmSwitchAccount, self)
	self._slotOnUpgradeGuest = Slot(self._onUpgradeGuestFinish, self)
	self.privacyPanel = UIControls.Panel(self, "BgPanel/SetPanel/Content/ImgPrivateSet")
	self.btnCookie = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgPrivateSet/BtnPrivate", "TextTitle")

	self.btnCookie:addEventClick(self._onCookieClick)

	self.imgCookie = UIControls.Image(self, "BgPanel/SetPanel/Content/ImgPrivateSet/BtnPrivate/Img")
	self.imageZone = UIControls.Panel(self, "BgPanel/SetPanel/Content/ImgZone")
	self.zoneBtn = {}
	self.zoneBtn[1] = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgZone/Btn1")
	self.zoneBtn[2] = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgZone/Btn2")
	self.zoneBtn[3] = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgZone/Btn3")

	self:_setZoneBtn()

	self.imageLanguage = UIControls.Panel(self, "BgPanel/SetPanel/Content/ImgLanguage")
	self.languageBtn = {}

	for index = 1, 12 do
		self.languageBtn[index] = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgLanguage/Btn" .. index, "Text")
	end

	self:_setLanguageBtn()
	self:pushSetting()
	self:_applyModification()
	self:_updateGuest()
	self:_updateAccount()
	self:_setSwitchAccount()
	self:_updateWeiBo()
	self:_setCustomerService()
	self:_setCheckDiamond()

	self.cvToggles = {}
	self.cvSelectPanel = UIControls.Panel(self, "BgPanel/SetPanel/Content/GameVoiceSet/CVPanel")

	if #Const.CV_LIST > 1 then
		self.cvSelectPanel:setVisible(true)

		for i, cvId in ipairs(Const.CV_LIST) do
			local toggle = CVToggle(self, "BgPanel/SetPanel/Content/GameVoiceSet/CVPanel/CVChoosePanel", "System/PlayerGuide/BtnCVCell")

			toggle:setVisible(true)
			toggle:setData(cvId)

			self.cvToggles[cvId] = toggle
		end
	else
		self.cvSelectPanel:setVisible(false)
	end

	self.bulletWorldToggle = UIControls.Toggle(self, "BgPanel/SetPanel/Content/RollingCommentsSet/ChanelSwitchPanel/Option1")
	self.bulletWorldToggle.bulletType = Const.CHANNEL_WORLD

	self.bulletWorldToggle:addEventValueChanged(self._onBulletToggle)

	self.bulletGuideToggle = UIControls.Toggle(self, "BgPanel/SetPanel/Content/RollingCommentsSet/ChanelSwitchPanel/Option2")
	self.bulletGuideToggle.bulletType = Const.CHANNEL_GUILD

	self.bulletGuideToggle:addEventValueChanged(self._onBulletToggle)

	self.bulletServerToggle = UIControls.Toggle(self, "BgPanel/SetPanel/Content/RollingCommentsSet/ChanelSwitchPanel/Option3")
	self.bulletServerToggle.bulletType = Const.CHANNEL_SERVER

	self.bulletServerToggle:addEventValueChanged(self._onBulletToggle)

	self.bulletBattleBtn = UIControls.Button(self, "BgPanel/SetPanel/Content/RollingCommentsSet/ChanelSwitchPanel/BtnBattle")

	self.bulletBattleBtn:addEventClick(self._onBattleBulletClick)

	self.bulletBattleImg = UIControls.Image(self, "BgPanel/SetPanel/Content/RollingCommentsSet/ChanelSwitchPanel/BtnBattle/Img")
	self.btnLamp = UIControls.Button(self, "BgPanel/SetPanel/Content/RollingCommentsSet/ChanelSwitchPanel/BtnLamp")

	self.btnLamp:addEventClick(self._onBtnLampClick)

	self.imgLamp = UIControls.Image(self, "BgPanel/SetPanel/Content/RollingCommentsSet/ChanelSwitchPanel/BtnLamp/Img")

	self:jpSetting()

	self.panelBeian = UIControls.Panel(self, "BgPanel/SetPanel/Content/ImgBeian")
	self.btnBeian = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgBeian/Btn1")

	self.btnBeian:addEventClick(self._onBtnBeianClick)
	self.panelBeian:setVisible(Const.FILINGS_BTN_OPEN)
end

function MainSettingDlg:pushSetting()
	if RegionUtils.isKR() then
		self.pushPanel = PushSettingPanel(self, "BgPanel/SetPanel/Content/ImgNotice")
	elseif RegionUtils.isJP() and VersionUtils.IsReviewVersion() then
		self.imgNotice = UIControls.Panel(self, "BgPanel/SetPanel/Content/ImgNotice")
		self.imgNoticeBtn1 = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgNotice/Btn1", "TextTitle")
		self.imgNoticeBtn1Img = UIControls.Image(self, "BgPanel/SetPanel/Content/ImgNotice/Btn1/Img")
		self.imgNoticeBtn2 = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgNotice/Btn2")
		self.imgNoticeBtn3 = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgNotice/Btn3")
		self.imgNoticeBtn4 = UIControls.Button(self, "BgPanel/SetPanel/Content/ImgNotice/Btn4")

		self.imgNotice:setVisible(true)
		self.imgNoticeBtn1:setVisible(true)
		self.imgNoticeBtn1:setText(Lang.get(100349))
		self.imgNoticeBtn1:addEventClick(self._onClickPersonalPushSettings)
		self.imgNoticeBtn2:setVisible(false)
		self.imgNoticeBtn3:setVisible(false)
		self.imgNoticeBtn4:setVisible(false)

		local isOn = UserData.loadCommonData("jp_personal_push_setting")

		if isOn == nil or isOn == "" then
			self:_refreshSwitch(self.imgNoticeBtn1Img, true)
			UserData.saveCommonData("jp_personal_push_setting", "true")
		elseif isOn == "true" then
			self:_refreshSwitch(self.imgNoticeBtn1Img, true)
		else
			self:_refreshSwitch(self.imgNoticeBtn1Img, false)
		end
	end
end

function MainSettingDlg:_onClickPersonalPushSettings()
	local isOn = UserData.loadCommonData("jp_personal_push_setting")

	if isOn == "true" then
		self:_refreshSwitch(self.imgNoticeBtn1Img, false)
		UserData.saveCommonData("jp_personal_push_setting", "false")
	else
		self:_refreshSwitch(self.imgNoticeBtn1Img, true)
		UserData.saveCommonData("jp_personal_push_setting", "true")
	end
end

function MainSettingDlg:jpSetting()
	if RegionUtils.isJP() then
		self.btnLamp:setVisible(true)
	end
end

function MainSettingDlg:onOpen()
	MainSettingDlg.super.onOpen(self)
	self:_loadSettings()
	self:_initPlayerInfo()
end

function MainSettingDlg:onClose(...)
	MainSettingDlg.super.onClose(self)
	self:_saveSettings()
end

function MainSettingDlg:_initPlayerInfo(...)
	if CurAvatar then
		self.playerNameTxt:setText(CurAvatar:getPlayerName() or "")
		self.btnHead:setCommInfo(CurAvatar:getMyCommInfo(), false, self)
	end
end

function MainSettingDlg:_loadSettings()
	self.musicVolumePanel:setVolumeType(Const.VOLUME_TYPE_MUSIC)
	self.sfxVolumePanel:setVolumeType(Const.VOLUME_TYPE_SFX)
	self.vocalVolumePanel:setVolumeType(Const.VOLUME_TYPE_VOCAL)
	self.qualityPanel:loadSettings()

	self.cvChanging = true

	local cvTypeString = GameSettings.getVocalLanguage()

	for cvTypeId, toggle in pairs(self.cvToggles) do
		toggle.btnChoose:setOn(Const.CV_TYPE_STRING[cvTypeId] == cvTypeString)
	end

	self.cvChanging = false
	self.bulletSetting = true

	self.bulletWorldToggle:setOn(MsgManager.getBulletChannelState(self.bulletWorldToggle.bulletType))
	self.bulletGuideToggle:setOn(MsgManager.getBulletChannelState(self.bulletGuideToggle.bulletType))
	self.bulletServerToggle:setOn(MsgManager.getBulletChannelState(self.bulletServerToggle.bulletType))

	self.bulletSetting = nil

	self:_refreshSwitch(self.bulletBattleImg, GameSettings.bulletInBattle)
	self:_refreshSwitch(self.imgCookie, GameSettings.cookie)
	self:_refreshSwitch(self.imgLamp, GameSettings.showLamp)
	self:refreshLampBtnState()
end

function MainSettingDlg:_saveSettings()
	GameSettings.savePreferences()
end

function MainSettingDlg:_updateGuest()
	return
end

function MainSettingDlg:_updateAccount()
	local subChannelId = ChannelUtil.getSubChannelID()

	if subChannelId == "huawei" then
		self.changeAccountBtn:setText(Lang.get(111312))
	else
		self.changeAccountBtn:setText(Lang.get(30440))
	end

	if RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		self.changeAccountBtn:setText(Lang.get(36326))
	end
end

function MainSettingDlg:_setSwitchAccount()
	if not SDKAgent.isSupportAccountSwitch() then
		self.changeAccountBtn:setVisible(false)
	elseif ChannelUtil.isQQGame() then
		self.changeAccountBtn:setVisible(false)
	else
		self.changeAccountBtn:setVisible(true)
	end
end

function MainSettingDlg:_setCustomerService()
	if GameConfig.getChannelConfig(Const.REMOTE_CONFIG_HIDE_CONTACT) then
		self.contactBtn:setVisible(false)
	elseif RegionUtils.isKR() or RegionUtils.isSEA() or RegionUtils.isJP() then
		if ChannelUtil.isSteam() then
			self.contactBtn:setVisible(true)
		else
			self.contactBtn:setVisible(false)
		end
	end
end

function MainSettingDlg:_updateWeiBo()
	if RegionUtils.isJP() then
		self.blogBtn:setText("ログアウト")
		self.blogBtn:setVisible(true)
	elseif RegionUtils.isTW() then
		self.blogBtn:setText(Lang.get(32778))
	elseif RegionUtils.isKR() then
		self.blogBtn:setVisible(true)
		self.blogBtn:setText("다이아 정보")
	elseif RegionUtils.isSEA() then
		self.blogBtn:setVisible(false)
	elseif GameConfig.getChannelConfig(Const.REMOTE_CONFIG_HIDE_BLOG) then
		self.blogBtn:setVisible(false)
	elseif ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_MAIN_SETTING_BLOG) then
		self.blogBtn:setVisible(false)
	end
end

function MainSettingDlg:_applyModification()
	if VersionUtils.IsReviewVersion() then
		if ChannelUtil.getSubChannelID() ~= "oppo" then
			self.contactBtn:setVisible(false)
		end

		self.blogBtn:setVisible(false)

		if RegionUtils.isCN() and DeviceHelper.isIOS() then
			self.giftExchangeBtn:setVisible(false)
		end

		if RegionUtils.isSEA() or RegionUtils.isKR() or RegionUtils.isJP() then
			self.giftExchangeBtn:setVisible(false)
		end
	end

	if ChannelUtil.isQQGame() then
		self.changeAccountBtn:setVisible(false)
	end

	self.privacyPanel:setVisible(RegionUtils.isJP())

	if RegionUtils.isCN() then
		self.privacyPanel:setVisible(true)
		self.btnCookie:setText(Lang.get(100349))
	end
end

function MainSettingDlg:_isAllBulletOff(...)
	if self.bulletServerToggle:isOn() or self.bulletWorldToggle:isOn() or self.bulletGuideToggle:isOn() then
		return false
	else
		return true
	end
end

function MainSettingDlg:refreshLampBtnState(forceSet)
	if not self:_isAllBulletOff() then
		GameSettings.showLamp = false

		self:_refreshSwitch(self.imgLamp, GameSettings.showLamp)
	else
		if forceSet then
			GameSettings.showLamp = true
		end

		self:_refreshSwitch(self.imgLamp, GameSettings.showLamp)
	end
end

function MainSettingDlg:_onClickClose(...)
	self:setVisible(false)
end

function MainSettingDlg:_onClickChatMute(...)
	return
end

function MainSettingDlg:_onBulletToggle(sender)
	if self.bulletSetting then
		return
	end

	local bulletType = sender.bulletType
	local isOn = sender:isOn()

	MsgManager.changeBulletChannels(bulletType, isOn)
	self:refreshLampBtnState(true)
end

function MainSettingDlg:_onBtnLampClick(...)
	if not self:_isAllBulletOff() then
		MsgManager.notice(Lang.get(50886))

		return
	end

	GameSettings.showLamp = not GameSettings.showLamp

	self:_refreshSwitch(self.imgLamp, GameSettings.showLamp)
end

function MainSettingDlg:_onBattleBulletClick()
	GameSettings.bulletInBattle = not GameSettings.bulletInBattle

	self:_refreshSwitch(self.bulletBattleImg, GameSettings.bulletInBattle)
end

function MainSettingDlg:_onCookieClick()
	GameSettings.cookie = not GameSettings.cookie

	self:_refreshSwitch(self.imgCookie, GameSettings.cookie)
end

function MainSettingDlg:_refreshSwitch(imgSwitch, isOn)
	if imgSwitch then
		if isOn then
			imgSwitch:playAnimator("BtnSwitchOn")
		else
			imgSwitch:playAnimator("BtnSwitchOff")
		end
	end
end

function MainSettingDlg:_onClickSwitchAccount()
	if ChannelUtil.getSubChannelID() == "huawei" then
		ChannelUtil.doAnyFunction("showLogoff", SvrListManager.getAccountSeverAndRoleInfo())

		return
	end

	local channelId = ChannelUtil.getChannelID()

	if channelId == ChannelID.FLOW or channelId == ChannelID.BT then
		MsgManager.onAccountChange()
		SDKAgent.switchAccount()
	else
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(8), Lang.get(30441), self._slotConfirmSwitchAccount, nil)
	end
end

function MainSettingDlg:_onConfirmSwitchAccount()
	MsgManager.onAccountChange()
	GameFsm.getState(Const.STATE_LOGIN):setAutoAction(Const.AUTO_SWITCH_ACCOUNT)
	SDKAgent.logout()
	ChatService.disconnect()
	ChatService.resetConnectTime()
end

function MainSettingDlg:_onClickBind()
	if not CurAvatar.isMobileRecorded then
		if ChannelUtil.isFlow then
			SDKAgent.bindGuest(SDKConst.Tip.BIND_ACCOUNT, self._slotOnUpgradeGuest)
		else
			SDKAgent.recordMobile(self._slotOnUpgradeGuest)
		end
	end
end

function MainSettingDlg:_onUpgradeGuestFinish()
	local uiSettings = UIManager.getUI("mainSettingDlg", nil, false)

	if uiSettings ~= nil then
		uiSettings:_updateGuest()
	end
end

function MainSettingDlg:_onGiftExchange(...)
	UIManager.getUI("giftExchangeDlg", true)
end

function MainSettingDlg:_onNoticeClick()
	SDKAgent.showNotice()
end

function MainSettingDlg:_onClickcustomerService()
	SDKAgent.customerService()
	RedDotManager.setKeyState(UIConst.RD_HINT_CUSTOMER, false)
end

function MainSettingDlg:_onClickChangeSvr(...)
	local serverListDlg = UIManager.getUI("servers")

	if serverListDlg then
		serverListDlg:showServers(true)
	end
end

function MainSettingDlg:_onBlogBtn()
	if RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(8), "タイトル画面へ戻り、アカウントを切り替えますか。\n※現在プレイしているデータが引継ぎ実行済みのアカウントの場合、引き続き該当データで\nプレイされたい場合、タイトル画面で再度ログインアカウントを選択する必要があります。", self._slotConfirmSwitchAccount, nil, nil, nil, nil, nil, UIConst.TXTALIGN_UL)
	elseif RegionUtils.isCurrentRegion(RegionConst.REGION_TW) then
		JumpGuideManager.jump(Const.TW_HOMEPAGE_GUIDE_ID)
	elseif RegionUtils.isKR() then
		UIManager.getUI("diamondHaveDlg", true)
	else
		JumpGuideManager.jump(69)
	end
end

function MainSettingDlg:onChooseCV(sender)
	if self.cvChanging then
		return
	end

	self.cvChanging = true

	for i, toggle in pairs(self.cvToggles) do
		toggle.btnChoose:setOn(sender == toggle)
	end

	GameSettings.setVocalLanguage(Const.CV_TYPE_STRING[sender.cvType])
	MsgManager.notice(string.format(Lang.get(30438), Const.CV_BTN_NAME[sender.cvType][1]))

	self.cvChanging = false
end

function MainSettingDlg:_setCheckDiamond()
	if RegionUtils.isJP() then
		self.checkDiamond:setVisible(true)
	elseif RegionUtils.isTW() or RegionUtils.isKR() or RegionUtils.isSEA() then
		if ChannelUtil.isSteam() then
			self.checkDiamond:setVisible(false)
		else
			self.checkDiamond:setVisible(true)
			self.checkDiamond:setText(Lang.get(37096))
		end
	elseif RegionUtils.isCN() then
		local hide = ChannelUtil.getSubChannelID() == ChannelID.SUB_DALAN or ChannelUtil.isQQGame()

		self.checkDiamond:setVisible(not hide)
		self.checkDiamond:setText(Lang.get(1395))
	end
end

function MainSettingDlg:_jpDmmChannelSettings()
	if not DeviceHelper.isIOS() and RegionUtils.isJP() and VersionUtils.hasAbilityDMMSuccession() then
		local succ, channel = ChannelUtil.doAnyFunction("getBytedanceChannel", {})

		if succ and channel == "dmm" then
			self.changeAccountBtn:setVisible(false)
			self.blogBtn:setVisible(false)
		end
	end
end

function MainSettingDlg:_showDiamond()
	if RegionUtils.isJP() then
		UIManager.getUI("showDiamondDlg", true, true)
	elseif RegionUtils.isTW() or RegionUtils.isKR() or RegionUtils.isSEA() then
		SDKAgent.accountCenter()
	elseif RegionUtils.isCN() then
		if ChannelUtil.isCNOfficialChannel() then
			local data = {}

			data.type = 2

			ChannelUtil.doAnyFunction("sdkAgreement", ClientUtils.table2String(data))
		else
			local WebView = require("SDK/Plugin/WebView")

			if ChannelUtil.getSubChannelID() == "xxgame" then
				WebView.openWebView("https://s-cdn.xxbox.cn/cdn/txt/privacy_2.html")
			else
				WebView.openWebView("http://resource.xgjoy.com/agreement/figurestory/Privacy-Protocol.html")
			end
		end
	end
end

function MainSettingDlg:_setZoneBtn()
	if ChannelUtil.isSteam() then
		self.imageZone:setVisible(false)

		return
	end

	if VersionUtils.isSectionEnabled() then
		local sections = {
			Const.SEA_SECTION_EU,
			Const.SEA_SECTION_NA,
			Const.SEA_SECTION_SEA
		}

		self.imageZone:setVisible(true)

		local svrListMark = ServerSection.getSection()

		for index = 1, 3 do
			local section = sections[index]

			self.zoneBtn[index]:addEventClick(Functor(self._changeZone, self, Const.SEA_SECTION_NAME[section], section))

			if section == svrListMark then
				self.zoneBtn[index]:setEnable(false)
			end
		end
	end
end

function MainSettingDlg:_changeZone(zoneName, zoneValue)
	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1793), Lang.get(63155), Functor(self._setServerSection, self, zoneValue), nil, nil, Lang.get(8), Lang.get(7))
end

function MainSettingDlg:_setServerSection(zoneValue)
	ServerSection.setSection(zoneValue)
	SDKAppUtils.exitApp()
end

function MainSettingDlg:_setLanguageBtn()
	if RegionUtils.isSEA() then
		self.imageLanguage:setVisible(true)

		local curLanguage = Framework.Tools.LuaToolkit.GetCurLanguage()
		local curLanguageList = Framework.Tools.LuaToolkit.GetLanguageList()
		local readyLangs = {}

		for i = 0, curLanguageList.Count - 1 do
			local lang = curLanguageList[i]

			if ChannelUtil.isSteam() then
				if Const.SEA_READY_LANG_STEAM[lang] then
					table.insert(readyLangs, lang)
				end
			elseif Const.SEA_READY_LANG[lang] then
				table.insert(readyLangs, lang)
			end
		end

		for index = 1, 12 do
			if index > #readyLangs then
				self.languageBtn[index]:setVisible(false)
			else
				local lang = readyLangs[index]

				if lang ~= nil then
					self.languageBtn[index]:setVisible(true)
					self.languageBtn[index]:setText(Const.Lang_Text[lang])
					self.languageBtn[index]:addEventClick(Functor(self._changeLanguage, self, lang))
				end

				if lang == curLanguage then
					self.languageBtn[index]:setEnable(false)
				end
			end
		end
	end
end

function MainSettingDlg:_changeLanguage(language)
	if language == RegionConst.LANGUAGE_THAI and not VersionUtils.hasAbilityThai() then
		local ResClientConfirm = require("ClientData/ResClientConfirm")

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1793), ResClientConfirm[1054].content)

		return
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1793), Lang.get(63156), Functor(self._setLanguage, self, language), nil, nil, Lang.get(8), Lang.get(7))
end

function MainSettingDlg:_setLanguage(language)
	Framework.Tools.LuaToolkit.SetCurLanguage(language)
	UserData.save()

	if ChannelUtil.isSteam() then
		Framework.SDK.U3DOceanSDK.QuitApplication()
	else
		SDKAppUtils.exitApp()
	end
end

function MainSettingDlg:_onBtnBeianClick()
	CurAvatar:jumpToOpenWebUrl("https://beian.miit.gov.cn")
end

return MainSettingDlg
