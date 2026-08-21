-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\NewStageDlg.lua

local SubpackageUtils = Framework.Download.SubpackageUtils
local ResStage = require("ClientData/ResStage")
local PlayerInfoPanel = require("UI/MainMenu/PlayerInfoPanel")
local TopPvpEnterTipsPanel = require("UI/PVPMode/TopPVP/TopPvpEnterTipsPanel")
local PettyPayTipsPanel = require("UI/PettyPay/PettyPayTipsPanel")
local MainMenuRecommendPanel = require("UI/MainMenu/MainMenuRecommendPanel")
local MainMenuButton = require("UI/MainMenu/MainMenuButton")
local BattleConst = require("Common/FrameBattle/BattleConst")
local VersionUtils = require("System/VersionUtils")
local GiftNoticeDlg = require("UI/MainState/GiftNoticeDlg")
local DeviceHelper = require("Helper/DeviceHelper")
local PrivilegePanel = require("UI/MainMenu/PrivilegePanel")
local questionnaire = require("SDK/SDKImp/questionnaire")
local NewbieTaskBriefPanel = require("UI/Achieve/NewbieTaskBriefPanel")
local AdvanceTaskBriefPanel = require("UI/Achieve/AdvanceTaskBriefPanel")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local PerformManager = require("Logic/perform/PerformManager")
local PushGiftButton = require("UI/MainMenu/PushGiftButton")
local RookieFocusChild = require("Logic/Beginner/RookieFocusChild")
local ResStageBonusPredict = require("ClientData/ResStageBonusPredict")
local MainMenuBannerPanel = require("UI/MainMenu/MainMenuBannerPanel")
local RentMsgNoticeChild = require("UI/RentTask/RentMsgNoticeChild")
local WebView = require("SDK/Plugin/WebView")
local SDKAppUtils = require("SDK/SDKAppUtils")
local NewStageHookPart = Class("NewStageHookPart", UIControls.Panel)

function NewStageHookPart:ctor()
	self.effState = UIControls.LazyEffectPlayer(self, self.mPath .. "/BtnAward/ImgState")
	self.imgState = UIControls.Image(self, self.mPath .. "/BtnAward/ImgState")
	self.imgState1 = UIControls.Image(self, self.mPath .. "/BtnAward/ImgState1")
	self.aniGetBtn = UIControls.UIAni(self, self.mPath .. "/BtnAward/BoxPanel")
	self.imgBoxTop = UIControls.Image(self, self.mPath .. "/BtnAward/BoxPanel/ImgBoxTop")
	self.efxGold = UIControls.LazyEffectPlayer(self, self.mPath .. "/BtnAward/BoxPanel/EfxGold")
	self.imgNew = UIControls.Panel(self, self.mPath .. "/BtnAward/IconNew")
	self.panelActivity = UIControls.Panel(self, self.mPath .. "/BtnAward/BgAward")
	self.iconActivity = UIControls.Image(self, self.mPath .. "/BtnAward/BgAward/IconAward")
	self.state = 0
	self._timer = Timer.New(Slot(self.checkState, self), UIMiscConfig.STAGE_HOOK_BOX_UPDATE_CD, -1)

	self._timer:Start()
end

local STATE_UI_INFO = {
	{
		"Back01"
	},
	{
		"Back02",
		"BoxTop02",
		"Front02"
	},
	{
		"Back03",
		"BoxTop03",
		"Front03"
	},
	{
		"Back04",
		"BoxTop04",
		"Front04"
	}
}

function NewStageHookPart:checkState()
	if CurAvatar.mainStageAtkedIdx == 0 then
		return
	end

	local hookTime = ClientUtils.getServerTime() - CurAvatar.stageHookAwardGotTime
	local state = 1

	state = hookTime > UIMiscConfig.MAIN_DLG_REWARD_TIME3 and 4 or hookTime > UIMiscConfig.MAIN_DLG_REWARD_TIME2 and 3 or hookTime > UIMiscConfig.MAIN_DLG_REWARD_TIME1 and 2 or 1

	self:updateImg(state)

	local hookActivity = CurAvatar:getHookActivity()

	if hookActivity then
		local actClientData = hookActivity.actData.clientData

		if actClientData and actClientData.box_icon_path and actClientData.box_icon_name then
			self.iconActivity:setImage(actClientData.box_icon_path, actClientData.box_icon_name)
		end

		self.panelActivity:setVisible(true)
	else
		self.panelActivity:setVisible(false)
	end
end

function NewStageHookPart:updateImg(state)
	if self.state == state then
		return
	end

	self.imgNew:setVisible(state >= 3)

	self.state = state

	local info = STATE_UI_INFO[state]

	self.imgState1:setImage("Atlas/MainBattleAtlas/MainBattleChangeAtlas", info[1])

	if info[2] ~= nil then
		self.imgBoxTop:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew3", info[2])
		self.imgBoxTop:setVisible(true)
	else
		self.imgBoxTop:setVisible(false)
	end

	if info[3] ~= nil then
		self.imgState:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew3", info[3])
		self.imgState:setVisible(true)
	else
		self.imgState:setVisible(false)
	end
end

function NewStageHookPart:update()
	if CurAvatar == nil then
		return
	end

	local hookTime = ClientUtils.getServerTime() - CurAvatar.stageHookAwardGotTime
	local lv = 0

	if hookTime > 43200 then
		lv = 3
	elseif hookTime > 10800 then
		lv = 2
	elseif hookTime > 0 then
		lv = 1
	end

	if lv ~= self._rewardLv then
		self._rewardLv = lv
	end

	local item = CurAvatar:getMainStageHookAward().item
end

function NewStageHookPart:playEfx()
	if self.state > 1 then
		self.efxGold:playEffectByPath("Effects/UI/efx_ui_coin_drop02.prefab")
	else
		self.efxGold:playEffectByPath("Effects/UI/efx_ui_coin_drop.prefab")
	end

	self.efxGold:setVisible(true)
end

local NewStageBonusPredictPart = Class("NewStageBonusPredictPart", UIControls.Panel)

function NewStageBonusPredictPart:ctor()
	self.textTarget = UIControls.Label(self, self.mPath .. "/TextRule")
	self.textBonus = UIControls.Label(self, self.mPath .. "/TextAward")
	self.textGet = UIControls.Panel(self, self.mPath .. "/TextGet")
	self.grid = UIControls.getGridContainer(self, self.mPath .. "/GridPanel")

	self.grid:setVisible(true)

	self.imgBg = UIControls.Image(self, self.mPath)
	self.btnSensor = UIControls.Button(self, self.mPath .. "/Btn")

	self.btnSensor:addEventClick(self.onBonusClick)
end

function NewStageBonusPredictPart:setBonusPredict(nowBonus, isNotGot)
	self.isNotGot = isNotGot
	self.nowBonus = nowBonus

	local target_desc = nowBonus.target_desc or ""
	local targetDesc = string.format(Lang.get(30569), target_desc)

	if isNotGot then
		self.imgBg:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgBossGiftSel")
		self.textGet:setVisible(true)
		self.textBonus:setVisible(false)
		self.textTarget:setText(targetDesc)
		self.textBonus:setText(nowBonus.bonus_desc or "")

		local fakeItem = BaseObject.GetObject(nowBonus.bonus_id, nowBonus.bonus_num)

		self.grid:setObj(fakeItem)
	else
		self.imgBg:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgBossGiftNml")
		self.textGet:setVisible(false)
		self.textBonus:setVisible(true)
		self.textTarget:setText(targetDesc)
		self.textBonus:setText(nowBonus.bonus_desc or "")

		local fakeItem = BaseObject.GetObject(nowBonus.bonus_id, nowBonus.bonus_num)

		self.grid:setObj(fakeItem)
	end
end

function NewStageBonusPredictPart:onBonusClick()
	if self.isNotGot then
		if not CurAvatar:isBeginnerFinished(351) then
			JumpGuideManager.jump(44)
		else
			JumpGuideManager.jump(46)
		end
	else
		local chapterPreviewDlg = UIManager.getUI("chapterPreviewDlg", true)

		chapterPreviewDlg:setPreviewStageData(utils.getStageBonusDataList())
	end
end

local strClassName = "NewStageDlg"
local NewStageDlg = Class(strClassName, UIControls.Window)

NewStageDlg.BTN_CONFIG = {
	btnTower = {
		"OtherSystemEntryPanel/BtnTower",
		{
			UIConst.RD_HINT_STEPTOWER
		},
		Const.CONDITION_LIMIT_STEP_TOWER,
		"stepTowerDlg",
		"jumpToCurStage"
	},
	btnEquipTower = {
		"OtherSystemEntryPanel/BtnEquipTower",
		{
			UIConst.RD_HINT_EQUIPTOWER
		},
		Const.CONDITION_LIMIT_EQUIP_TOWER,
		"equipTowerMainDlg"
	},
	btnBoss = {
		"OtherSystemEntryPanel/BtnChallengeBoss",
		{
			UIConst.RD_HINT_CHALLENGE_BOSS_ALL
		},
		Const.CONDITION_LIMIT_BOSS_TOWER,
		"bossChooseDlg",
		"initShow"
	},
	btnMazz = {
		"OtherSystemEntryPanel/BtnMazz",
		{
			UIConst.RD_HINT_MAIN_MAZE
		},
		Const.CONDITION_LIMIT_MAZE,
		nil,
		nil,
		"onOpenMaze"
	},
	btnOnceTower = {
		"OtherSystemEntryPanel/BtnOneTimeTower",
		nil,
		Const.CONDITION_LIMIT_ONCE_TOWER,
		"onceTowerLevelDlg"
	},
	btnPvp = {
		"OtherSystemEntryPanel/BtnAsynPVP",
		{
			UIConst.RD_HINT_PVP_ENTER
		},
		Const.CONDITION_LIMIT_PVP,
		"pvpChooseDlg",
		"show"
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
	btnAchieve = {
		"TempFunc/BtnAchieve",
		{
			UIConst.RD_HINT_TASK_MAIN
		},
		Const.CONDITION_LIMIT_ACHIEVE,
		"achieveMainDlg"
	},
	btnHook = {
		"MainBattlePanel/HookPanel/BtnAward",
		nil,
		Const.CONDITION_LIMIT_HOOK,
		nil,
		nil,
		"onGetClick"
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
	btnShop = {
		"PaymentPanel/BtnStore",
		{
			UIConst.RD_HINT_MALL
		},
		Const.CONDITION_LIMIT_SHOP,
		"mallDlg",
		"openMall"
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
	btnCountryEntry1 = {
		"TempFunc/BtnJoin",
		nil,
		nil,
		nil,
		nil,
		"onBtnCountryEntry1Click"
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

function NewStageDlg:ctor()
	self:initUI()

	self._timerAwardUpdate = Timer.New(Slot(self.onAwardUpdate, self), Const.STAGE_HOOK_UPDATE_CD, -1)
	self._slotOnSceneReady = Slot(self.onSceneReady, self)
end

function NewStageDlg:initUI()
	self.partHook = NewStageHookPart(self, "MainBattlePanel/HookPanel")
	self.btnHero = UIControls.Button(self, "OtherFuncPanel/BtnHero")

	self.btnHero:addEventClick(self.onBtnHeroClick)

	self.btnHeroBgName = UIControls.Panel(self, "OtherFuncPanel/BtnHero/BgName")
	self.btnHeroNameText = UIControls.Panel(self, "OtherFuncPanel/BtnHero/Text")

	self.btnHeroBgName:setVisible(not RegionUtils.isSEA())
	self.btnHeroNameText:setVisible(not RegionUtils.isSEA())

	self.heroRedDot = UIControls.RedDot(self, "OtherFuncPanel/BtnHero/IconNew")

	self.heroRedDot:addHint({
		UIConst.RD_HINT_HERO
	})

	self.btnMiniGame = UIControls.Button(self, "OtherFuncPanel/BtnMiniGame")

	self.btnMiniGame:addEventClick(self.onBtnMiniGameClick)
	self.btnMiniGame:setVisible(CurAvatar:checkShowMainEnter())

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

	self.btnRanking = UIControls.Button(self, "BtnRanking")

	self.btnRanking:addEventClick(self.onBtnRankingClick)

	self.panelPlayer = PlayerInfoPanel(self, "PlayerInfoPanel")
	self.panelTopPvpEnterTips = TopPvpEnterTipsPanel(self, "TempFunc/BtnTopPVP")
	self.panelPettyPay = PettyPayTipsPanel(self, "TempFunc/BtnPettyPay")
	self.panelRecommendBtn = MainMenuRecommendPanel(self, "ActivityEntry")

	self.panelRecommendBtn:setMorePanelPath("MoreActivityPanel")

	self.panelPrivilege = PrivilegePanel(self, "PrivilegePanel")
	self.newbieTaskBrief = NewbieTaskBriefPanel(self, "TheThirdEntryPanel/BtnBeginnerTask")
	self.advanceTaskBrief = AdvanceTaskBriefPanel(self, "TheThirdEntryPanel/BtnBeginnerBPTask")
	self.btnQuest = UIControls.Button(self, "TempFunc/BtnQuest")

	self.btnQuest:addEventClick(self.onClickQuest)

	self.questCondRD = UIControls.RedDot(self, "TempFunc/BtnQuest")

	self.questCondRD:addHint({
		UIConst.RD_HINT_SURVEY
	})

	for btnName, btnInfo in pairs(NewStageDlg.BTN_CONFIG) do
		local btn = MainMenuButton(self, btnInfo[1], btnInfo[7])

		if btnName == "btnGameAssistant" then
			btn:setVisible(Const.GAME_ASSISTANT_OPEN)
		end

		btn:setting(btnInfo[2], btnInfo[3], btnInfo[4], btnInfo[5], btnInfo[6])

		self[btnName] = btn
	end

	self.btnHome = UIControls.Button(self, "OtherSystemEntryPanel/BtnMainMenu")

	self.btnHome:addEventClick(self.onClickHome)

	self.homeRedDot = UIControls.RedDot(self, "OtherSystemEntryPanel/BtnMainMenu/IconNew")

	self.homeRedDot:addHint({
		UIConst.RD_HINT_HOME
	})

	self.btnBattle = UIControls.Button(self, "MainBattlePanel/BtnFight")

	self.btnBattle:addEventClick(self.onClickBattle)

	self.textName = UIControls.Label(self, "MainBattlePanel/BtnFight/TextChapterName")
	self.textBtnProgress = UIControls.Label(self, "MainBattlePanel/BtnFight/TextProgress")
	self.imgBattleText = UIControls.Image(self, "MainBattlePanel/BtnFight/ImgText")
	self.bgMainLineSkip = UIControls.Image(self, "MainBattlePanel/BtnFight/BgMainLineSkip")
	self.animBgMainLineSkip = UIControls.UIAni(self, "MainBattlePanel/BtnFight/BgMainLineSkip")
	self.txtMainLineSkipAward = UIControls.Label(self, "MainBattlePanel/BtnFight/BgMainLineSkip/TextAward")
	self.panelProgress = UIControls.Panel(self, "MainBattlePanel/ProgressPanel")
	self.textProgress = UIControls.Label(self, "MainBattlePanel/ProgressPanel/TextProgressNum")
	self.textProgressPercent = UIControls.Label(self, "MainBattlePanel/ProgressPanel/TextProgressPer")
	self.sliderProgress = UIControls.MaterialProgress(self, "MainBattlePanel/ProgressPanel/ImgSlider")
	self.panelBoss = UIControls.Panel(self, "MainBattlePanel/BtnFight/BgBoss")
	self.panelNormal = UIControls.Panel(self, "MainBattlePanel/BtnFight/BgSimple")
	self.panelFightEff = UIControls.Panel(self, "MainBattlePanel/BtnFight/Efx")
	self.panelFightArrow = UIControls.Panel(self, "MainBattlePanel/BtnFight/ImgArrow")
	self.imgBgPass = UIControls.Image(self, "OtherSystemEntryPanel/BtnMazz/BgPass")
	self.imgMazeTime = UIControls.Image(self, "OtherSystemEntryPanel/BtnMazz/TextTime/IconTime")
	self.labelMazzTime = UIControls.Label(self, "OtherSystemEntryPanel/BtnMazz/TextTime")
	self.panelMazeTimeUp = UIControls.Panel(self, "OtherSystemEntryPanel/BtnMazz/TimeUpPanel")
	self.efxEndAnchor = UIControls.Panel(self, "MainBattlePanel/HookPanel/BtnAward/EfxPoint")
	self.panelPushGiftB = GiftNoticeDlg(self, "RecGiftPanel")
	self.moreGiftPanelVisible = false
	self.switchAnim = UIControls.UIAni(self, "TempFunc/BtnMoreRecGift/ImgArrow")

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
	self.panelMainBattle = UIControls.Panel(self, "MainBattlePanel")

	self:adaptNotchBottom()

	self.panelBonusPredict = NewStageBonusPredictPart(self, "MainBattlePanel/BtnFight/BgAward")
	self.animPredict = UIControls.UIAni(self, "MainBattlePanel/BtnFight/BgAward")

	self.animPredict:addEventFinish(self._onAniFinish)

	self.panelBanner = MainMenuBannerPanel(self, "PaymentPanel/ImgBanner")
	self.panelBannerDis = UIControls.Panel(self, "PaymentPanel/ImgBannerDis")

	self.panelBanner:setDisPanel(self.panelBannerDis)

	self.rentTaskNoticePanel = UIControls.Panel(self, "CaseTaskNewsPanel")
	self.rentTaskNoticeChild = RentMsgNoticeChild(self, "CaseTaskNewsPanel", "System/CaseTask/ChildCaseTaskNews")
	self.delayPlayAniTimer = Timer.New(Slot(self.delayPlayAniTimerFunc, self), 1, 1)

	self.delayPlayAniTimer:Start()
	self:checkBossExpandOpen()

	self.imgFirstRecharge = UIControls.Image(self, "TempFunc/BtnFirstRecharge/Img")
	self.imgSecondRecharge = UIControls.Image(self, "TempFunc/BtnAddGift/Img")
end

function NewStageDlg:delayPlayAniTimerFunc()
	self:replayAppearAnimation()
end

function NewStageDlg:updateMazzTime()
	self.slotUpdateMazzTime = self.slotUpdateMazzTime or Slot(self.updateMazzTime, self)

	self.imgBgPass:setVisible(false)
	self.labelMazzTime:setVisible(false)
	self.imgMazeTime:setVisible(false)
	self.panelMazeTimeUp:setVisible(false)
	ClientTimerManager.RemoveSecondTickUI(self.labelMazzTime)
	ClientTimerManager.stopGlobalTimer("mazeWillResetTip")

	local checkNewMaze = false
	local isNewMazePass = false
	local newMazeTime = 0
	local checkPetMaze = false
	local isPetMazePass = false
	local petMazeTime = 0

	checkNewMaze = not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_MAZE)

	if checkNewMaze then
		local isNeedReset = CurAvatar.needResetMaze == true

		RedDotManager.setKeyState(UIConst.RD_HINT_MAZE, isNeedReset)

		newMazeTime, isNewMazePass = CurAvatar:getNextMazeRefreshSeconds()
	end

	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)

	checkPetMaze = actObj ~= nil and actObj:isValid()

	if checkPetMaze then
		isPetMazePass = actObj.actData:checkPass()
		petMazeTime = actObj.actData:getSeasonLeftTime()
	end

	if checkNewMaze or checkPetMaze then
		local isPass = false
		local mazzTime = 0

		if checkNewMaze then
			isPass = isNewMazePass
			mazzTime = newMazeTime
		end

		if checkPetMaze and (not checkNewMaze or isPass and not isPetMazePass or isPass == isPetMazePass and petMazeTime < mazzTime) then
			isPass = isPetMazePass
			mazzTime = petMazeTime
		end

		self.imgBgPass:setVisible(isPass)

		if isPass then
			self.labelMazzTime:setColorByRGBA(0.6666666666666666, 0.6666666666666666, 0.6666666666666666, 0.39215686274509803)
			self.imgMazeTime:setColorByRGBA(170, 170, 170, 100)
		else
			self.labelMazzTime:setColorByRGBA(0.6313725490196078, 0.38823529411764707, 0.2, 1)
			self.imgMazeTime:setColorByRGBA(255, 255, 255, 255)
		end

		if mazzTime > 0 then
			if not isPass then
				local leftTipTime = mazzTime - 43200

				if leftTipTime > 0 then
					ClientTimerManager.startGlobalTimer("mazeWillResetTip", leftTipTime, self.slotUpdateMazzTime)
				else
					self.panelMazeTimeUp:setVisible(true)
				end
			end

			self.labelMazzTime:setVisible(true)
			self.imgMazeTime:setVisible(true)
			ClientTimerManager.AddSecondTickUI(self.labelMazzTime, mazzTime, nil, "", Lang.get(30556), self.slotUpdateMazzTime)
		end
	end
end

function NewStageDlg:checkBossExpandOpen(...)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BOSS_EXPAND) or not Const.IS_NEW_BOSSTOWER_SHOW then
		return
	end

	local btn = self.btnBoss

	if btn then
		btn:setting({
			UIConst.RD_HINT_CHALLENGE_BOSS_ALL
		}, Const.CONDITION_LIMIT_BOSS_TOWER, "bossEntryDlg", nil, nil)
	end
end

function NewStageDlg:checkPvpState(...)
	return
end

function NewStageDlg:onClickBattle()
	local nextStage = CurAvatar:getNextMainStageInfo()
	local nowStage = CurAvatar:getNowStageData()

	if nextStage == nil then
		MsgManager.notice(Lang.get(30522))
	elseif nextStage.idx == nowStage.idx then
		UIManager.getUI("stageInfoDlg", true)
	else
		if nowStage.chapter == 3 and not self:_isSubpackageReady() then
			return
		end

		RPC.stageUnlockNext()
	end
end

function NewStageDlg:_isSubpackageReady()
	if RegionUtils.isTW() then
		return true
	end

	local ready = SubpackageUtils.GetProgress() > 0.99

	if not ready then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(31301), Lang.get(31302), RPC.stageUnlockNext, nil, nil, Lang.get(31303), Lang.get(31304))
		SubpackageUtils.ResumeBackground()
		UIManager.getUI("downloadBox", true, true)
	end

	return ready
end

function NewStageDlg:onClickHome()
	GameFsm.getState(Const.STATE_MAIN_HOME).riskToHome = true

	GameFsm.translateState(Const.STATE_MAIN_HOME)
end

function NewStageDlg:onOpenMaze()
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)
	local checkOpenChooseDlg = actObj ~= nil and actObj:isValid()

	if checkOpenChooseDlg then
		UIManager.getUI("mazeChooseMainDlg", true, true)
	elseif CurAvatar.needResetMaze then
		UIManager.getUI("mazeChooseDlg", true):show()
	elseif CurAvatar:isThisMazeFinished() then
		UIManager.getUI("mazeChooseDlg", true):show(true)
	elseif CurAvatar.mazeData then
		GameFsm.translateState(Const.STATE_MAIN_MAZE)
	end
end

function NewStageDlg:postInit(uiName, uiData)
	NewStageDlg.super.postInit(self, uiName, uiData)
	self.panelFund:settingFunc(true)
end

function NewStageDlg:onOpen()
	NewStageDlg.super.onOpen(self)

	if not GameFsm.isInState(Const.STATE_MAIN_STAGE) then
		GameFsm.translateState(Const.STATE_MAIN_STAGE)
	end

	CurAvatar:enterMainStage(self._slotOnSceneReady)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_OPEN)
	self:updateMazzTime()
	self.partHook.efxGold:setVisible(false)

	if CurAvatar.opactPvpNeedGetTopRank then
		CurAvatar.opactPvpNeedGetTopRank = nil

		RPC.opactArenaRankTopGet()
	end

	self.btnQQVip:setVisible(ChannelUtil.isQQGame())
	self.btnCountryEntry1:setVisible(ClientUtils.canOpenCountryEntry(1))

	if CurAvatar and RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		local qu = questionnaire()

		if qu then
			qu:setQuestionnaireConfig()
		end
	end

	if CurAvatar:checkHideCloseBtn() then
		self:onBtnMiniGameClick()
	end

	CurAvatar:checkMainEnterRed()
	self.btnSwitchAccount:setVisible(Const.ACCOUNT_SWITCH_OPEN and not ConditionLimitManager.inLimitState(362))
end

function NewStageDlg:onClose()
	NewStageDlg.super.onClose(self)
	self.panelBanner:onMenuClose()
	PerformManager.setCustomShadowActive(false)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_CLOSE)
end

function NewStageDlg:onSceneReady()
	if not self:isInShow() then
		return
	end

	if CurAvatar and CurAvatar.beginnerLoseMarked then
		if not self.panelLoseMarked then
			self.panelLoseMarked = RookieFocusChild(self, "MainBattlePanel/HookPanel/BtnAward", "System/PlayerGuide/HighLightPanel", 0, 0)

			self.panelLoseMarked:addRedDotHint({
				UIConst.RD_HINT_BEGINNER_HOOK
			})
			self.panelLoseMarked:focus(self.btnHook:getComObj().transform, Const.BEGINNER_LOSE_NOTICE[1])
		end

		if not self.panelLoseHeroMarked then
			self.panelLoseHeroMarked = RookieFocusChild(self, "OtherFuncPanel/BtnHero", "System/PlayerGuide/HighLightPanel", 0, 0)

			self.panelLoseHeroMarked:addRedDotHint({
				UIConst.RD_HINT_BEGINNER_HERO
			})
			self.panelLoseHeroMarked:focus(self.btnHero:getComObj().transform, Const.BEGINNER_LOSE_NOTICE[3])
		end
	else
		if self.panelLoseMarked then
			self.panelLoseMarked:addRedDotHint()
		end

		if self.panelLoseHeroMarked then
			self.panelLoseHeroMarked:addRedDotHint()
		end
	end

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_STAGE_RANK) then
		self.btnRanking:setVisible(false)
		self.panelProgress:setVisible(false)
	else
		self.btnRanking:setVisible(true)
		self.panelProgress:setVisible(true)
	end

	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HERO)

	self.btnHero:setVisible(not isLocked)
	self.panelPlayer:onStart()
	self.panelRecommendBtn:onRefresh()
	self.panelBanner:onRefresh()
	self.panelPushGiftB:onRefresh()
	self.panelPrivilege:onRefresh()
	self.panelPettyPay:refreshUI()
	self:refreshData()
	self.newbieTaskBrief:refreshNewbieTaskInfo()
	self.advanceTaskBrief:refresAdvanceTaskInfo()
	self:checkDataUpdateNotify()
	PerformManager.setCustomShadowActive(true)

	if not VersionUtils.IsRechargeDisabled() == true then
		self:refreshPushGift()
		self:refreshFirstRechargeGift()
	end

	self:refreshBonusPredict()
	self:refreshBattleSkip()
end

function NewStageDlg:refreshBattleSkip()
	if CurAvatar:checkCanSkipStage() then
		self.panelBonusPredict:setVisible(false)
		self.bgMainLineSkip:setVisible(true)
		self.animBgMainLineSkip:startAni("JumpAppear", true)

		local showStageData = CurAvatar:getShowNextStagesData()

		if showStageData then
			self.txtMainLineSkipAward:setText(utils.format(Lang.get(103603), showStageData.chapter, showStageData.level))
		end
	else
		self.bgMainLineSkip:setVisible(false)
	end
end

function NewStageDlg:refreshBonusPredict()
	local nowBonus, isNotGot = utils.getStageBonusInfo(true)

	if nowBonus then
		self.panelBoss:setVisible(false)
		self.panelNormal:setVisible(false)
		self.panelFightEff:setVisible(false)
		self.panelBonusPredict:setVisible(true)
		self.panelBonusPredict:setBonusPredict(nowBonus, isNotGot)
	else
		self.panelBonusPredict:setVisible(false)
	end
end

function NewStageDlg:replayAppearAnimation()
	if self:isInShow() then
		self.animPredict:startAni("JumpAppear", true)
	else
		self.cachePlayPredic = true
	end
end

function NewStageDlg:_onAniFinish(aniCom, aniName)
	if aniName == "JumpAppear" then
		local nowBonus, isNotGot = utils.getStageBonusInfo(true)

		if isNotGot then
			self.animPredict:startAniLoop("JumpGet")
		else
			self.animPredict:startAniLoop("JumpAward")
		end

		self.predictAniTimer = Timer.New(Slot(self.predictAniTimerFunc, self), UIMiscConfig.PREDICT_AWARD_APPEAR_ANI_CD, 1)

		self.predictAniTimer:Start()
	end
end

function NewStageDlg:predictAniTimerFunc()
	self:replayAppearAnimation()
end

function NewStageDlg:clearPredictTimer()
	if self.predictAniTimer then
		self.predictAniTimer:Stop()

		self.predictAniTimer = nil
	end

	if self.delayPlayAniTimer then
		self.delayPlayAniTimer:Stop()

		self.delayPlayAniTimer = nil
	end
end

function NewStageDlg:onRefresh(...)
	self.panelRecommendBtn:onRefresh()
	self.panelPrivilege:onRefresh()
end

function NewStageDlg:checkDataUpdateNotify()
	if not CurAvatar.stageDataChanged then
		return
	end

	UIManager.getUI("mainStageSpeedUpDlg", true):onShow()

	CurAvatar.stageDataChanged = nil
end

function NewStageDlg:destroy()
	if self.newbieTaskBrief then
		self.newbieTaskBrief:destroy()
	end

	if self.advanceTaskBrief then
		self.advanceTaskBrief:destroy()
	end

	self.panelPlayer:clear()
	self._timerAwardUpdate:Stop()

	if self.partHook then
		self.partHook._timer:Stop()
	end

	for btnName, btnInfo in pairs(NewStageDlg.BTN_CONFIG) do
		self[btnName]:clearCondition()
	end

	self.panelBanner:clear()
	self:clearPredictTimer()
	NewStageDlg.super.destroy(self)
end

function NewStageDlg:openDeposit()
	if self.mOpening then
		self.overOpenDeposit = true
	else
		local ui = UIManager.getUI("mainStageAwardBox", true)

		ui:bindWindow(self)
	end
end

function NewStageDlg:onOpenOver()
	NewStageDlg.super.onOpenOver(self)

	if self.overOpenDeposit then
		local ui = UIManager.getUI("mainStageAwardBox", true)

		ui:bindWindow(self)

		self.overOpenDeposit = nil
	end

	if self.cachePlayPredic then
		self.animPredict:startAni("JumpAppear", true)

		self.cachePlayPredic = nil
	end
end

function NewStageDlg:refreshData()
	if CurAvatar == nil then
		return
	end

	self._timerAwardUpdate:Start()
	self:requestRefreshBonus()

	local curData = CurAvatar:getNowStageData()
	local levelText = ClientUtils.getMainStageLevelStr(curData.season, curData.chapter, curData.level)

	self.textProgress:setText(levelText)
	self.panelBoss:setVisible(curData.levelBoss == 1)
	self.panelNormal:setVisible(curData.levelBoss ~= 1)

	local nextData = CurAvatar:getNextMainStageInfo()

	self.textName:setVisible(not RegionUtils.isSEA() and not RegionUtils.isJP())

	if nextData and nextData.idx ~= curData.idx then
		self.sliderProgress:setValue(1)
		self.textProgressPercent:setText("100")
		self.btnBattle:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BtnFightingNext")
		self.imgBattleText:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "TxtFightingNext")
		self.panelBoss:setVisible(false)
		self.panelNormal:setVisible(false)
		self.textBtnProgress:setText("")
		self.textName:setText(nextData.next_name or "")
	elseif nextData == nil then
		self.sliderProgress:setValue(1)
		self.panelBoss:setVisible(false)
		self.panelNormal:setVisible(false)
		self.textProgressPercent:setText("100")
		self.btnBattle:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BtnFightingDis")
		self.imgBattleText:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "TxtFightingDis")
		self.panelFightEff:setVisible(false)
		self.panelFightArrow:setVisible(false)
		self.textBtnProgress:setText("")
		self.textName:setText(Lang.get(30524))
	else
		local chapterData = ResStage[curData.season] or {}

		chapterData = chapterData[curData.chapter] or {}

		self.btnBattle:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BtnFighting")
		self.imgBattleText:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "TxtFighting")

		local maxLevel = #chapterData
		local nowLevel = nextData.level - 1

		if nowLevel < maxLevel then
			local pro = nowLevel / maxLevel

			self.sliderProgress:setValue(pro)
			self.textProgressPercent:setText(math.floor(pro * 100))
		end

		self.textBtnProgress:setText(levelText)
		self.textName:setText(curData.short_name or curData.name)
	end

	self:refreshBattleSkip()
	GameFsm.getState(Const.STATE_MAIN_STAGE):setStageBGM()
	CueManager.playBaseBGM()
end

function NewStageDlg:onUpdateAttrChanged()
	self.panelPlayer:updateInfo()
end

function NewStageDlg:updateHook()
	self.partHook:update()
	self.partHook:checkState()
	self:onAwardUpdate()
end

function NewStageDlg:onAwardUpdate()
	local mainStageAwardBox = UIManager.getUI("mainStageAwardBox", nil, false)

	if mainStageAwardBox and mainStageAwardBox:getVisible() then
		mainStageAwardBox:update()
	end
end

function NewStageDlg:refreshPushGift()
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

function NewStageDlg:onFirstRechargeClick()
	UIManager.getUI("welfareFirstRechargeDlg", true)
end

function NewStageDlg:refreshFirstRechargeGift()
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

function NewStageDlg:onSecondRechargeClick()
	UIManager.getUI("welfareSecondRecharge", true)
end

function NewStageDlg:onBtnPushGiftClick()
	if not self.curPushGiftData then
		return
	end

	UIManager.getUI("welfarePushGiftDlg", true):setData(self.curPushGiftData)
end

function NewStageDlg:drawClick(...)
	UIManager.getUI("drawCardMainDlg", true):selectDefaultPool()
end

function NewStageDlg:pushGiftTimeDownCB()
	self:refreshPushGift()
end

function NewStageDlg:onMorePushGiftClick()
	self.moreGiftPanel:setVisible(not self.moreGiftPanelVisible)

	self.moreGiftPanelVisible = not self.moreGiftPanelVisible

	if self.moreGiftPanelVisible == true then
		self.switchAnim:startAni("ArrowUp", true)
	else
		self.switchAnim:startAni("ArrowDown", true)
	end
end

function NewStageDlg:onPushPanelClick()
	self.moreGiftPanel:setVisible(false)

	self.moreGiftPanelVisible = false

	self.switchAnim:startAni("ArrowDown", true)
end

function NewStageDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_MAIN_STAGE)
end

function NewStageDlg:onBtnHeroClick()
	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		UIManager.getUI("heroMainDlg", true)
	else
		UIManager.getUI("heroMainDlg", true):initForHeroList()
	end

	if CurAvatar.beginnerLoseMarked then
		RedDotManager.setKeyState(UIConst.RD_HINT_BEGINNER_HERO, false)
	end
end

function NewStageDlg:onBtnMiniGameClick()
	if CurAvatar.firstSelectGameType and CurAvatar.firstSelectGameType ~= 0 then
		if not GameFsm.isInState(Const.MINI_GAME_INFO[CurAvatar.firstSelectGameType].state) then
			GameFsm.translateState(Const.MINI_GAME_INFO[CurAvatar.firstSelectGameType].state)
		end
	else
		UIManager.getUI("miniGameMainDlg", true):setData()
	end
end

function NewStageDlg:onBtnRankingClick()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_MAINSTAGE)
end

function NewStageDlg:playGetAnim()
	self.partHook.aniGetBtn:startAni("BoxLoopAni")
	self.partHook:playEfx()
end

function NewStageDlg:onClickQuest()
	CurAvatar:openSurvey()

	if RegionUtils.isCurrentRegion(RegionConst.REGION_JP) then
		self.btnQuest:setVisible(false)
	end
end

function NewStageDlg:onQQVipClick()
	UIManager.getUI("qqPrivilegeDlg", true):onShow(1)
end

function NewStageDlg:onBtnCountryEntry1Click()
	ClientUtils.jumpCountryEntry(1)
end

function NewStageDlg:onSwitchAccountClick()
	CurAvatar:openSwitchAccount()
end

function NewStageDlg:requestRefreshBonus()
	if CurAvatar.mainStageCur.idx ~= 0 then
		CurAvatar:refreshDepositActivity()
		RPC.depositAwardRefresh()
	end
end

function NewStageDlg:onGetClick()
	self:requestRefreshBonus()

	local ui = UIManager.getUI("mainStageAwardBox", true)

	ui:bindWindow(self)
end

function NewStageDlg:onOpenAchieveDlg()
	local achieveMainDlg = UIManager.getUI("achieveMainDlg", true)

	achieveMainDlg:selectPage(achieveMainDlg.PAGE_ID.Achieve)
end

function NewStageDlg:onBtnHideUIHold(...)
	if self.hideFlag then
		self.panelHide:setCanvasGroupAlpha(1)
	else
		self.panelHide:setCanvasGroupAlpha(0)
	end

	self.hideFlag = not self.hideFlag
end

function NewStageDlg:adaptNotchBottom()
	if DeviceHelper.isiPhoneWithNotch() then
		local RectTransformType = typeof(UnityEngine.RectTransform)
		local otherEntryRect = self.panelOtherEntry:getComObj():GetComponent(RectTransformType)
		local oldMin = otherEntryRect.anchorMin

		oldMin.y = 0.02

		local oldMax = otherEntryRect.anchorMax

		oldMax.y = 0.02
		otherEntryRect.anchorMin = oldMin
		otherEntryRect.anchorMax = oldMax

		local battleRect = self.panelMainBattle:getComObj():GetComponent(RectTransformType)
		local oldMin = battleRect.anchorMin

		oldMin.y = 0.02
		battleRect.anchorMin = oldMin
	end
end

function NewStageDlg:onVisibleChanged(visible)
	NewStageDlg.super.onVisibleChanged(self, visible)
	self:setRentMsgActive(visible)
end

function NewStageDlg:setRentMsgActive(isActive)
	if isActive then
		RentMsgManager.registerNoticeUI("NewStage", self.rentTaskNoticePanel, self.rentTaskNoticeChild)
	else
		RentMsgManager.unregisterNoticeUI("NewStage")
	end
end

function NewStageDlg:onBtnGameAssistantClick()
	UIManager.getUI("gameAssistantMainDlg", true):setData()
end

return NewStageDlg
