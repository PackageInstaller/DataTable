-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\MainMenuDlg.lua

local UserData = require("Helper/UserData")
local BattleConst = require("Common/FrameBattle/BattleConst")
local PlayerInfoPanel = require("UI/MainMenu/PlayerInfoPanel")
local PettyPayTipsPanel = require("UI/PettyPay/PettyPayTipsPanel")
local MainMenuRecommendPanel = require("UI/MainMenu/MainMenuRecommendPanel")
local MainMenuButton = require("UI/MainMenu/MainMenuButton")
local PushGiftButton = require("UI/MainMenu/PushGiftButton")
local MainMenuBannerPanel = require("UI/MainMenu/MainMenuBannerPanel")
local PrivilegePanel = require("UI/MainMenu/PrivilegePanel")
local GameSettings = require("Helper/GameSettings")
local VersionUtils = require("System/VersionUtils")
local DeviceHelper = require("Helper/DeviceHelper")
local RentMsgNoticeChild = require("UI/RentTask/RentMsgNoticeChild")
local WebView = require("SDK/Plugin/WebView")
local SDKAppUtils = require("SDK/SDKAppUtils")
local questionnaire = require("SDK/SDKImp/questionnaire")
local NewbieTaskBriefPanel = require("UI/Achieve/NewbieTaskBriefPanel")
local AdvanceTaskBriefPanel = require("UI/Achieve/AdvanceTaskBriefPanel")
local GiftNoticeDlg = require("UI/MainState/GiftNoticeDlg")
local SDKConst = require("SDK/SDKConst")
local ChannelID = SDKConst.ChannelID
local strClassName = "MainMenuDlg"
local MainMenuDlg = Class(strClassName, UIControls.Window)

MainMenuDlg.HideBg = UserData.loadCommonData(BattleConst.INFO_SHOW_MENU_BG) == "1"
MainMenuDlg.BTN_CONFIG = {
	btnMainStage = {
		"OtherSystemEntryPanel/BtnMainBattle",
		nil,
		nil,
		nil,
		nil,
		"mainStageClick"
	},
	btnAchieve = {
		"TempFunc/BtnAchieve",
		{
			UIConst.RD_HINT_TASK_MAIN
		},
		Const.CONDITION_LIMIT_ACHIEVE,
		"achieveMainDlg"
	},
	btnYard = {
		"OtherSystemEntryPanel/BtnBackyard",
		{
			UIConst.RD_HINT_REAR_HOUSE
		},
		Const.CONDITION_LIMIT_YARD,
		nil,
		nil,
		"rearHouseClick"
	},
	btnShop = {
		"PaymentPanel/BtnStore",
		{
			UIConst.RD_HINT_MALL
		},
		Const.CONDITION_LIMIT_SHOP,
		"mallDlg",
		"openMall"
	},
	btnDraw = {
		"PaymentPanel/BtnDraw",
		{
			UIConst.RD_HINT_DRAWCARD
		},
		Const.CONDITION_LIMIT_DRAW,
		nil,
		nil,
		"drawClick"
	},
	btnHero = {
		"OtherSystemEntryPanel/BtnHero",
		{
			UIConst.RD_HINT_HERO
		},
		Const.CONDITION_LIMIT_HERO,
		"heroMainDlg",
		"initForHeroList"
	},
	btnAllHero = {
		"OtherSystemEntryPanel/BtnHandbook",
		{
			UIConst.RD_HINT_HANDBOOK
		},
		Const.CONDITION_LIMIT_HANDBOOK,
		"handBookMainDlg"
	},
	btnFriend = {
		"OtherSystemEntryPanel/BtnFriend",
		{
			UIConst.RD_HINT_FRIEND
		},
		nil,
		"friendMainDlg"
	},
	btnGuild = {
		"OtherSystemEntryPanel/BtnGuild",
		{
			UIConst.RD_HINT_CIRCLE
		},
		Const.CONDITION_LIMIT_CIRCLE,
		nil,
		nil,
		"onCircleClick"
	},
	btnRank = {
		"OtherSystemEntryPanel/BtnRank",
		{
			UIConst.RD_HINT_MASTER_APPRENTICE_MAIN
		},
		Const.CONDITION_LIMIT_MONUMENT,
		nil,
		nil,
		"onHandBookRankSelectClick"
	},
	btnPushGift = {
		"TempFunc/BtnRecGift",
		nil,
		nil,
		nil,
		nil,
		"onBtnPushGiftClick",
		"Text"
	},
	btnMorePushGift = {
		"TempFunc/BtnMoreRecGift",
		nil,
		nil,
		nil,
		nil,
		"onMorePushGiftClick"
	},
	moreGiftPanel = {
		"MoreGiftPanel",
		nil,
		nil,
		nil,
		nil,
		"onPushPanelClick"
	},
	btnFirstRecharge = {
		"TempFunc/BtnFirstRecharge",
		{
			UIConst.RD_HINT_FIRST_RECHARGE
		},
		nil,
		nil,
		nil,
		"onFirstRechargeClick"
	},
	btnQQVip = {
		"TempFunc/BtnQQVip",
		{
			UIConst.RD_HINT_QQ_PRIVILEGE
		},
		nil,
		nil,
		nil,
		"onQQVipClick"
	},
	btnSwitchAccount = {
		"TempFunc/BtnAccountSwitch",
		nil,
		nil,
		nil,
		nil,
		"onSwitchAccountClick"
	},
	gentleModeBtn = {
		"OtherSystemEntryPanel/BtnInteract",
		nil,
		nil,
		nil,
		nil,
		"onGentleModeClick"
	},
	btnSecondRecharge = {
		"TempFunc/BtnAddGift",
		{
			UIConst.RD_HINT_SECOND_RECHARGE
		},
		nil,
		nil,
		nil,
		"onSecondRechargeClick"
	},
	btnPet = {
		"OtherFuncPanel/BtnPet",
		{
			UIConst.RD_HINT_PET
		},
		nil,
		nil,
		nil,
		"onPetClick"
	},
	btnCountryEntry1 = {
		"TempFunc/BtnJoin",
		nil,
		nil,
		nil,
		nil,
		"onBtnCountryEntry1Click"
	},
	btnMiniGame = {
		"OtherFuncPanel/BtnMiniGame",
		nil,
		nil,
		nil,
		nil,
		"onMiniGameClick"
	},
	btnGameAssistant = {
		"PlayerInfoPanel/BtnGameAssistant",
		{
			UIConst.RD_HINT_GAME_ASSISTANT
		},
		nil,
		nil,
		nil,
		"onBtnGameAssistantClick"
	}
}

function MainMenuDlg:ctor()
	self:initUI()
end

function MainMenuDlg:initUI()
	self.panelPlayer = PlayerInfoPanel(self, "PlayerInfoPanel")
	self.panelRecommendBtn = MainMenuRecommendPanel(self, "ActivityEntry")

	self.panelRecommendBtn:setMorePanelPath("MoreActivityPanel")

	self.otherFuncPanel = UIControls.Panel(self, "OtherFuncPanel")

	self.otherFuncPanel:setVisible(true)

	self.unlockSpecialIndexs = {}

	for btnName, btnInfo in pairs(MainMenuDlg.BTN_CONFIG) do
		local btn = MainMenuButton(self, btnInfo[1], btnInfo[7])

		if btnName == "btnPet" then
			btn:setVisible(CurAvatar:petSystemEnable())
		elseif btnName == "btnMiniGame" then
			btn:setVisible(CurAvatar:checkShowMainEnter())
		elseif btnName == "btnGameAssistant" then
			btn:setVisible(Const.GAME_ASSISTANT_OPEN)
		end

		btn:setting(btnInfo[2], btnInfo[3], btnInfo[4], btnInfo[5], btnInfo[6])

		self[btnName] = btn
	end

	self.newbieTaskBrief = NewbieTaskBriefPanel(self, "TheThirdEntryPanel/BtnBeginnerTask")
	self.advanceTaskBrief = AdvanceTaskBriefPanel(self, "TheThirdEntryPanel/BtnBeginnerBPTask")
	self.btnQuest = UIControls.Button(self, "TempFunc/BtnQuest")

	self.btnQuest:addEventClick(self.onClickQuest)

	self.questCondRD = UIControls.RedDot(self, "TempFunc/BtnQuest")

	self.questCondRD:addHint({
		UIConst.RD_HINT_SURVEY
	})

	self.miniGameRedDot = UIControls.RedDot(self, "OtherFuncPanel/BtnMiniGame/IconNewOpen")

	self.miniGameRedDot:addHint({
		UIConst.RD_HINT_MINI_GAME_MAIN_MENU
	})

	self.imgMiniGame = UIControls.Image(self, "OtherFuncPanel/BtnMiniGame/ImgHero")
	self.textMiniGame = UIControls.Label(self, "OtherFuncPanel/BtnMiniGame/Text")

	if CurAvatar.firstSelectGameType and CurAvatar.firstSelectGameType ~= 0 then
		self.imgMiniGame:setImage("Atlas/MainMenuAtlas/MainMenuGameAtlas", "BtnMiniGame0" .. CurAvatar.firstSelectGameType)
		self.textMiniGame:setText(Const.MINI_GAME_INFO[CurAvatar.firstSelectGameType].name)
	end

	self.panelPushGiftB = GiftNoticeDlg(self, "RecGiftPanel")
	self.moreGiftPanelVisible = false
	self.switchAnim = UIControls.UIAni(self, "TempFunc/BtnMoreRecGift/ImgArrow")
	self.rdRearHouseCrystalNew = UIControls.RedDot(self, "OtherSystemEntryPanel/BtnBackyard/IconNewCat")

	self.rdRearHouseCrystalNew:addHint({
		UIConst.RD_HINT_REAR_HOUSE_CRYSTLE
	})

	self.panelBanner = MainMenuBannerPanel(self, "PaymentPanel/ImgBanner")
	self.panelBannerDis = UIControls.Panel(self, "PaymentPanel/ImgBannerDis")

	self.panelBanner:setDisPanel(self.panelBannerDis)

	self.panelPrivilege = PrivilegePanel(self, "PrivilegePanel")
	self.rentTaskNoticePanel = UIControls.Panel(self, "CaseTaskNewsPanel")
	self.rentTaskNoticeChild = RentMsgNoticeChild(self, "CaseTaskNewsPanel", "System/CaseTask/ChildCaseTaskNews")
	self.panelPettyPay = PettyPayTipsPanel(self, "TempFunc/BtnPettyPay")

	if ClientUtils.isSuportHidePkg() == true then
		self.btnHideUI = UIControls.Button(self, "BtnHideUI")

		if VersionUtils.getEngineVersion() < 112457 then
			self.btnHideUI:addEventClick(self.onBtnHideUIHold)
		else
			self.btnHideUI:addEventHoldClick(self.onBtnHideUIHold)
		end

		self.btnHideUI:setVisible(true)

		self.panelHide = UIControls.Panel(self, "")
		self.hideFlag = false
	end

	self.panelOtherEntry = UIControls.Panel(self, "OtherSystemEntryPanel")

	if not RegionUtils.isCurrentRegion(RegionConst.REGION_CN) and self.gentleModeBtn then
		-- block empty
	end

	self:adaptNotchBottom()

	self.rootAni = UIControls.UIAni(self, "")
	self.imgFirstRecharge = UIControls.Image(self, "TempFunc/BtnFirstRecharge/Img")
	self.imgSecondRecharge = UIControls.Image(self, "TempFunc/BtnAddGift/Img")
	self.txtRankSelect = UIControls.Label(self, "OtherSystemEntryPanel/BtnRank/Text")
	self.txtMasterApprentice = UIControls.Label(self, "OtherSystemEntryPanel/BtnRank/Text1")
	self.txtRankSelectDis = UIControls.Label(self, "OtherSystemEntryPanel/BtnRankDis/Text")
	self.txtMasterApprenticeDis = UIControls.Label(self, "OtherSystemEntryPanel/BtnRankDis/Text1")

	self.txtRankSelect:setVisible(not Const.Master_Apprentice_OPEN)
	self.txtRankSelectDis:setVisible(not Const.Master_Apprentice_OPEN)
	self.txtMasterApprentice:setVisible(Const.Master_Apprentice_OPEN)
	self.txtMasterApprenticeDis:setVisible(Const.Master_Apprentice_OPEN)
end

function MainMenuDlg:postInit(uiName, uiData)
	MainMenuDlg.super.postInit(self, uiName, uiData)
	self.panelFund:settingFunc(true)
end

function MainMenuDlg:destroy()
	if self.newbieTaskBrief then
		self.newbieTaskBrief:destroy()
	end

	if self.advanceTaskBrief then
		self.advanceTaskBrief:destroy()
	end

	self.panelPlayer:clear()

	for btnName, btnInfo in pairs(MainMenuDlg.BTN_CONFIG) do
		self[btnName]:clearCondition()
	end

	self.panelBanner:clear()
	MainMenuDlg.super.destroy(self)
end

function MainMenuDlg:onOpen()
	MainMenuDlg.super.onOpen(self)

	if CurAvatar.syncDataReady then
		self:onRefresh()
	end

	if not GameFsm.isInState(Const.STATE_MAIN_HOME) then
		GameFsm.translateState(Const.STATE_MAIN_HOME)
	end

	self.btnQQVip:setVisible(ChannelUtil.isQQGame())
	self.btnCountryEntry1:setVisible(ClientUtils.canOpenCountryEntry(1))

	local bg = UIManager.getUI("homeBg", true)

	if bg and bg.inGentleMode then
		bg:switchGentleMode(false, true)
	end

	self.btnPet:setVisible(CurAvatar:petSystemEnable())

	if CurAvatar:checkHideCloseBtn() then
		self:onMiniGameClick()
	end

	self.btnSwitchAccount:setVisible(Const.ACCOUNT_SWITCH_OPEN and not ConditionLimitManager.inLimitState(362))
end

function MainMenuDlg:onRefresh()
	self.panelFund:onRefresh()
	self.panelPlayer:onStart()
	self.panelRecommendBtn:onRefresh()
	self.panelPushGiftB:onRefresh()
	self.panelBanner:onRefresh()
	self.panelPrivilege:onRefresh()
	self.panelPettyPay:refreshUI()

	local homeBg = UIManager.getUI("homeBg", nil, false)

	if homeBg then
		homeBg:onRefresh()
	end

	if not VersionUtils.IsRechargeDisabled() == true then
		self:refreshPushGift()
		self:refreshFirstRechargeGift()
	end

	for btnName, btnInfo in pairs(MainMenuDlg.BTN_CONFIG) do
		local btn = self[btnName]

		btn:checkCondition()
	end

	self.newbieTaskBrief:refreshNewbieTaskInfo()
	self.advanceTaskBrief:refresAdvanceTaskInfo()

	if not homeBg or not homeBg.bgmChanged then
		GameFsm.getState(Const.STATE_MAIN_STAGE):setMainBGM()
		CueManager.playBaseBGM()
	end

	if CurAvatar then
		if RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
			local qu = questionnaire()

			if qu then
				qu:setQuestionnaireConfig()
			end
		else
			CurAvatar:refreshSurveyData()
		end
	end
end

local RECOMMEND_ACT = false
local IN_ROOKIE_UI = {
	"rookieMainDlg",
	"sequenceFramePlayer",
	"graphicListDlg",
	"newbieTalkDlg",
	"talkBox"
}

function MainMenuDlg:onOpenOver()
	MainMenuDlg.super.onOpenOver(self)

	if RECOMMEND_ACT then
		return
	end

	if not self:isInShow() then
		return
	end

	for _, uiName in ipairs(IN_ROOKIE_UI) do
		if UIManager.tryGetUI(uiName) then
			return
		end
	end

	if CurAvatar and CurAvatar.syncDataReady and CurAvatar:getRecommendActivityGroup() then
		local activityMainDlg = UIManager.getUI("activityMainDlg", true)

		activityMainDlg:openActivityGroup()
		activityMainDlg:openWay("patface")

		RECOMMEND_ACT = true
	end
end

function MainMenuDlg:onClose()
	MainMenuDlg.super.onClose(self)
	self.panelBanner:onMenuClose()

	self.registered = false
end

function MainMenuDlg:onBtnCountryEntry1Click()
	ClientUtils.jumpCountryEntry(1)
end

function MainMenuDlg:onVisibleChanged(visible)
	MainMenuDlg.super.onVisibleChanged(self, visible)
	self:setRentMsgActive(visible)
end

function MainMenuDlg:setRentMsgActive(isActive)
	if isActive then
		RentMsgManager.registerNoticeUI("MainMenu", self.rentTaskNoticePanel, self.rentTaskNoticeChild)
	else
		RentMsgManager.unregisterNoticeUI("MainMenu")
	end
end

function MainMenuDlg:onUpdateAttrChanged()
	self.panelPlayer:updateInfo()
end

function MainMenuDlg:onClickQuest()
	CurAvatar:openSurvey()

	if RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		self.btnQuest:setVisible(false)
	end
end

function MainMenuDlg:refreshButtons()
	return
end

function MainMenuDlg:setButtonVisible(btnName, visible)
	local btn = self[btnName]

	if btn then
		btn:setVisible(visible)
	end
end

function MainMenuDlg:refreshPushGift()
	if CurAvatar.testType == Const.TEST_TYPE_A then
		self.curPushGiftData = nil
		self.moreGiftPanelVisible = false

		local gifts = CurAvatar:getPushGift()

		self.pushGifts = {}
		self.morePushGifts = self.morePushGifts or {}

		for _, gift in pairs(gifts) do
			local time = gift.endTime - ClientUtils.getServerTime()

			if time > 0 then
				self.pushGifts[#self.pushGifts + 1] = gift
			end
		end

		if #self.pushGifts == 0 then
			self.btnPushGift:setVisible(false)
			self.btnMorePushGift:setVisible(false)
			self.moreGiftPanel:setVisible(false)

			self.moreGiftPanelVisible = false

			return
		end

		table.sort(self.pushGifts, function(a, b)
			return a.endTime > b.endTime
		end)

		self.curPushGiftData = self.pushGifts[1]

		ClientTimerManager.RemoveSecondTickUI(self.btnPushGift)

		local lastTime = self.pushGifts[1].endTime - ClientUtils.getServerTime()

		if lastTime > 86400 then
			self.btnPushGift:setText(string.format(Lang.get(30022), math.floor(lastTime / 86400)))
		else
			ClientTimerManager.AddSecondTickUI(self.btnPushGift, lastTime, nil, "", "", Slot(self.pushGiftTimeDownCB, self))
		end

		self.btnPushGift:setVisible(true)

		if #self.pushGifts > 1 then
			self.btnMorePushGift:setVisible(true)

			for _, btn in pairs(self.morePushGifts) do
				btn:setVisible(false)
			end

			if self.pushGifts then
				for i = 2, #self.pushGifts do
					if not self.morePushGifts[i - 1] then
						local gift = PushGiftButton(self, "MoreGiftPanel/RecGiftPanel", "System/MainMenu/BtnRecGift", 0, 0, true)

						self.morePushGifts[i - 1] = gift
					end

					self.morePushGifts[i - 1]:setVisible(true)
					self.morePushGifts[i - 1]:setData(self.pushGifts[i])
				end
			end
		else
			self.btnMorePushGift:setVisible(false)
			self.moreGiftPanel:setVisible(false)

			self.moreGiftPanelVisible = false
		end
	end
end

function MainMenuDlg:onBtnPushGiftClick()
	if not self.curPushGiftData then
		return
	end

	UIManager.getUI("welfarePushGiftDlg", true):setData(self.curPushGiftData)
end

function MainMenuDlg:pushGiftTimeDownCB()
	self:refreshPushGift()
end

function MainMenuDlg:onMorePushGiftClick()
	self.moreGiftPanel:setVisible(not self.moreGiftPanelVisible)

	self.moreGiftPanelVisible = not self.moreGiftPanelVisible

	if self.moreGiftPanelVisible == true then
		self.switchAnim:startAni("ArrowUp", true)
	else
		self.switchAnim:startAni("ArrowDown", true)
	end
end

function MainMenuDlg:onPushPanelClick()
	self.moreGiftPanel:setVisible(false)

	self.moreGiftPanelVisible = false

	self.switchAnim:startAni("ArrowDown", true)
end

function MainMenuDlg:onFirstRechargeClick()
	UIManager.getUI("welfareFirstRechargeDlg", true)
end

function MainMenuDlg:onQQVipClick()
	UIManager.getUI("qqPrivilegeDlg", true):onShow(1)
end

function MainMenuDlg:onSwitchAccountClick()
	CurAvatar:openSwitchAccount()
end

function MainMenuDlg:refreshFirstRechargeGift()
	if CurAvatar.firstRechargeVersion == 2 then
		self.imgFirstRecharge:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew4", "BtnFirstRecharge")
		self.imgSecondRecharge:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew4", "BtnFirstRecharge")
	else
		self.imgFirstRecharge:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BtnFirstRecharge")
		self.imgSecondRecharge:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BtnFirstRecharge")
	end

	local fState, sState = CurAvatar:getFirstRechargeState()

	self.btnFirstRecharge:setVisible(fState)
	self.btnSecondRecharge:setVisible(sState)
	CurAvatar:refreshFirstRechargeRed()
end

function MainMenuDlg:onSecondRechargeClick()
	UIManager.getUI("welfareSecondRecharge", true)
end

function MainMenuDlg:mainStageClick()
	local ui = UIManager.tryGetUI("homeBg")

	if ui and ui:getVisible() then
		ui:clearBulletShow()
	end

	GameFsm.getState(Const.STATE_MAIN_HOME):actionEnterStage()
end

function MainMenuDlg:onCircleClick()
	if CurAvatar:isInCircle() then
		CurAvatar:openMainCircleDlg()
	else
		local circleListDlg = UIManager.getUI("circleListDlg", true)

		circleListDlg:initCircleList()
	end
end

function MainMenuDlg:bannerClick()
	MainMenuDlg.drawClick()
end

function MainMenuDlg:drawClick(...)
	UIManager.getUI("drawCardMainDlg", true):selectDefaultPool()
end

function MainMenuDlg:rearHouseClick()
	if CurAvatar.rearHouseState.unlock_award == 0 then
		RPC.houseUnlockAwardGet()
	end

	GameFsm.translateState(Const.STATE_MAIN_REAR_HOUSE)
end

function MainMenuDlg:onBtnHideUIHold(...)
	if self.hideFlag then
		self.panelHide:setCanvasGroupAlpha(1)
	else
		self.panelHide:setCanvasGroupAlpha(0)
	end

	self.hideFlag = not self.hideFlag
end

function MainMenuDlg:onPetClick()
	if CurAvatar:petSystemEnable() then
		UIManager.getUI("petMainDlg", true):setData()
	end
end

function MainMenuDlg:onMiniGameClick()
	if CurAvatar.firstSelectGameType and CurAvatar.firstSelectGameType ~= 0 then
		if not GameFsm.isInState(Const.MINI_GAME_INFO[CurAvatar.firstSelectGameType].state) then
			GameFsm.translateState(Const.MINI_GAME_INFO[CurAvatar.firstSelectGameType].state)
		end
	else
		UIManager.getUI("miniGameMainDlg", true):setData()
	end
end

function MainMenuDlg:checkGameSetting()
	GameSettings.tryToNoticeQuality()
end

function MainMenuDlg:setCSButtonVisiable()
	local channelId = ChannelUtil.getChannelID()

	if channelId == ChannelID.MULTI then
		self.btnContect:setVisible(true)
		self.btnContectImgNew:setVisible(false)
	end
end

function MainMenuDlg:onClickContect()
	ChannelUtil.doAnyFunction("customerService", {})
end

function MainMenuDlg:adaptSpecialLeft()
	local RectTransformType = typeof(UnityEngine.RectTransform)
	local otherEntryRect = self.panelOtherEntry:getComObj():GetComponent(RectTransformType)
	local oldMin = otherEntryRect.anchorMin

	oldMin.x = -230
	otherEntryRect.offsetMin = oldMin
end

function MainMenuDlg:adaptNotchBottom()
	if DeviceHelper.isiPhoneWithNotch() then
		local RectTransformType = typeof(UnityEngine.RectTransform)
		local otherEntryRect = self.panelOtherEntry:getComObj():GetComponent(RectTransformType)
		local oldMin = otherEntryRect.anchorMin

		oldMin.y = 0.02

		local oldMax = otherEntryRect.anchorMax

		oldMax.y = 0.02
		otherEntryRect.anchorMin = oldMin
		otherEntryRect.anchorMax = oldMax
	end
end

function MainMenuDlg:onHandBookRankSelectClick()
	if Const.Master_Apprentice_OPEN then
		UIManager.getUI("masterApprenticeMainDlg", true)
	else
		UIManager.getUI("handBookRankSelectDlg", true)
	end
end

function MainMenuDlg:onGentleModeClick()
	self:inGentleMode()
end

function MainMenuDlg:inGentleMode()
	local homeBg = UIManager.getUI("homeBg", nil, false)

	if homeBg then
		homeBg:switchGentleMode(true)
	end
end

function MainMenuDlg:outGentleMode()
	return
end

function MainMenuDlg:onBtnGameAssistantClick()
	UIManager.getUI("gameAssistantMainDlg", true):setData()
end

return MainMenuDlg
