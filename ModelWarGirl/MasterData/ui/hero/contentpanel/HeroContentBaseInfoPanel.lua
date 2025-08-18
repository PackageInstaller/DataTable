-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\HeroContentBaseInfoPanel.lua

local HERO_COMMON_ATLAS = "Atlas/HeroAtlas/HeroCardCommonAtlas"
local ATTR_PANEL_PROP_MAP = {
	{
		prop = "atk"
	},
	{
		prop = "mhp"
	},
	{
		prop = "p_def"
	},
	{
		prop = "cri_rate"
	},
	{
		prop = "cri_dmg"
	},
	{
		prop = "assist_enhance"
	},
	{
		prop = "effect_hit"
	}
}
local LACK_GOLD = 1
local LACK_MATERIAL = 2
local LACK_STAR_LV = 3
local LACK_PLAYER_LV = 4
local LACK_STEP_LV = 5
local LACK_TOTAL_LV = 6
local IS_CRYSTAL_SLOT = 7
local LACK_CRYSTAL_MAX = 8
local LACK_CRYSTAL_STEP_MAX = 9
local LACK_MATERIAL2 = 10
local CANT_UPGRADE_REASON_NOTICE = {
	[LACK_GOLD] = Const.MONEY_ID_GOLD,
	[LACK_MATERIAL] = 1,
	[LACK_MATERIAL2] = 1,
	[LACK_STAR_LV] = Lang.get(30364),
	[LACK_STEP_LV] = Lang.get(30376),
	[LACK_PLAYER_LV] = Lang.get(30366),
	[LACK_TOTAL_LV] = Lang.get(30367)
}
local HERO_ATLAS = "Atlas/HeroAtlas/HeroAtlas"
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local ResLevelCost = require("ClientData/ResLevelCost")
local ResColor = require("ClientData/ResColor")
local ResStar = require("ClientData/ResStar")
local strClassName = "HeroContentBaseInfoPanel"
local ResStep = require("ClientData/ResStep")
local ResHeroStepProp = require("ClientData/ResHeroStepProp")
local PropBoard = require("ClientData/PropBoard")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local EventConst = require("EventConst")
local ResCrystalMisc = require("ClientData/ResCrystalMisc")
local ResHeroMisc = require("ClientData/ResHeroMisc")
local ResCrystalLevelLimit = require("ClientData/ResCrystalLevelLimit")
local RookieFocusChild = require("Logic/Beginner/RookieFocusChild")
local HeroContentBaseInfoPanel = Class(strClassName, UIControls.Child)

function HeroContentBaseInfoPanel:ctor()
	self:initUI()
end

function HeroContentBaseInfoPanel:initUI()
	self.txtPower = UIControls.Label(self, "InfoPanel/ImgPower/TextTitle/TextPower")
	self.imgCareerIcon = UIControls.Image(self, "InfoPanel/IconCareer/Icon")
	self.txtCareer = UIControls.Label(self, "InfoPanel/IconCareer/Text")
	self.txtHeroLv = UIControls.Label(self, "InfoPanel/TextLvPanel/TextLv")
	self.aniHeroLv = UIControls.UIAni(self, "InfoPanel/TextLvPanel/TextLv")
	self.bgStage = UIControls.Label(self, "InfoPanel/BgStageLv")
	self.txtStage = UIControls.Label(self, "InfoPanel/BgStageLv/Text")
	self.txtName = UIControls.Label(self, "InfoPanel/TextName")
	self.txtGroup = UIControls.Label(self, "InfoPanel/IconGroup/Text")
	self.imgGroup = UIControls.Image(self, "InfoPanel/IconGroup/Icon")
	self.txtTeam = UIControls.Label(self, "InfoPanel/IconTeam/Text")
	self.panelTeam = UIControls.Panel(self, "InfoPanel/IconTeam")
	self.imgTeamIcon = UIControls.Image(self, "InfoPanel/IconTeam/Icon")
	self.txtPowerNum = UIControls.Label(self, "InfoPanel/ImgPower/TextTitle/TextPower")
	self.imgIconHead = UIControls.Image(self, "InfoPanel/BgHead/IconHead")
	self.imgIconHeadBg = UIControls.Image(self, "InfoPanel/BgHead/Bg")
	self.imgPaint = UIControls.Image(self, "InfoPanel/BgHead/CoatingImg")
	self.efxPainting = UIControls.Panel(self, "InfoPanel/BgHead/CoatingImg/EfxCoating")
	self.btnBgHead = UIControls.Button(self, "InfoPanel/BgHead")

	self.btnBgHead:addEventClick(self.onBtnBgHeadClick)

	self.imgPainting = UIControls.Image(self, "InfoPanel/BgHead/IconCoating")
	self.btnUpgrade = UIControls.Button(self, "InfoPanel/BtnUpgrade")

	self.btnUpgrade:addEventClick(self.onBtnUpgradeClick)

	self.btnUpgradeFast = UIControls.Button(self, "InfoPanel/BtnUpgradeFast", "Text")

	self.btnUpgradeFast:addEventClick(self.onBtnUpgradeFastClick)

	self.btnDetail = UIControls.Button(self, "AttrPanel/BtnDetail", "Text")

	self.btnDetail:addEventClick(self.onBtnDetailClick)

	self.btnResetBase = UIControls.Button(self, "BtnResetBase", "Text")

	self.btnResetBase:addEventClick(self.onBtnResetBaseClick)

	self.btnResetBaseIconNew = UIControls.Image(self, "BtnResetBase/IconNew")
	self.btnResetStage = UIControls.Button(self, "BtnResetStage", "Text")

	self.btnResetStage:addEventClick(self.onBtnResetStageClick)

	self.txtResetStageCd = UIControls.Label(self, "BtnResetStage/TextTime")
	self.imgResetStage = UIControls.Image(self, "BtnResetStage/BgBtn")
	self.imgResetBase = UIControls.Image(self, "BtnResetBase/BgBtn")
	self.btnInfo = UIControls.Button(self, "InfoPanel/BtnInfo")

	self.btnInfo:addEventClick(self.onBtnInfoClick)

	self.btnOutCrysta = UIControls.Button(self, "BtnOutCrysta")

	self.btnOutCrysta:addEventClick(self.onBtnOutCrystaClick)

	self.btnGoldIcon = UIControls.Button(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial1")

	self.btnGoldIcon:addEventClick(self.onGoldClick)

	self.imgGoldIcon = UIControls.Image(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial1/UpgradeMaterial1")
	self.imgGoldAdd = UIControls.Image(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial1/ImgAdd")
	self.txtNeedGold = UIControls.Label(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial1/UpgradeMaterial1/TextNum")
	self.btnMaterialIcon = UIControls.Button(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial2")

	self.btnMaterialIcon:addEventClick(self.onMaterialClick)

	self.imgMaterialIcon = UIControls.Image(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial2/UpgradeMaterial2")
	self.imgMaterialAdd = UIControls.Image(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial2/ImgAdd")
	self.txtNeedMaterial = UIControls.Label(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial2/UpgradeMaterial2/TextNum")
	self.btnMaterialIcon2 = UIControls.Button(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial3")

	self.btnMaterialIcon2:addEventClick(self.onMaterial2Click)

	self.btnBecomeLeader = UIControls.Button(self, "BtnBecomeLeader")

	self.btnBecomeLeader:addEventClick(self.onBtnBecomeLeaderClick)

	self.imgMaterialIcon2 = UIControls.Image(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial3/UpgradeMaterial3")
	self.imgMaterialAdd2 = UIControls.Image(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial3/ImgAdd")
	self.txtNeedMaterial2 = UIControls.Label(self, "InfoPanel/UpgradeMaterialPanel/BtnUpgradeMaterial3/UpgradeMaterial3/TextNum")
	self.imgGoldIconBg = UIControls.Image(self, "InfoPanel/UpgradeMaterialPanel/Bg1")
	self.imgMaterialIconBg = UIControls.Image(self, "InfoPanel/UpgradeMaterialPanel/Bg2")
	self.imgMaterialIcon2Bg = UIControls.Image(self, "InfoPanel/UpgradeMaterialPanel/Bg3")
	self.efxPower1 = UIControls.LazyEffectPlayer(self, "InfoPanel/ImgPower/TextTitle/TextPower/EfxPower1")
	self.efxPower2 = UIControls.LazyEffectPlayer(self, "InfoPanel/ImgPower/TextTitle/TextPower/EfxPower2")
	self.imgLvMax = UIControls.Image(self, "InfoPanel/TextLvPanel/IconLvMax")

	if UIControls.checkControlFunc(self, "InfoPanel/TextLvPanel/ImgCrystalLv") then
		self.imgCrystalLv = UIControls.Image(self, "InfoPanel/TextLvPanel/ImgCrystalLv")
		self.txtCrystalLv = UIControls.Label(self, "InfoPanel/TextLvPanel/ImgCrystalLv/TextCrystalLv")
	end

	self.txtCryRule = UIControls.Label(self, "InfoPanel/TextRule")
	self.imgHeroStar = UIControls.Image(self, "InfoPanel/ImgStar")
	self.attrList = {}
	self.attrMoreList = {}
	self.panelLessAttr = UIControls.Panel(self, "AttrPanel/AttrLessPanel")
	self.panelMoreAttr = UIControls.Panel(self, "AttrPanel/AttrMorePanel")
	self.panelSkill = UIControls.Panel(self, "SkillPanel")
	self.efxAttrList1 = {}
	self.efxAttrList2 = {}

	for i = 1, 3 do
		local attrPanel = HeroAttrPanel(self, "AttrPanel/AttrLessPanel/Attr" .. i)

		table.insert(self.attrList, attrPanel)

		local attrEfxPanel1 = UIControls.LazyEffectPlayer(self, "AttrPanel/AttrLessPanel/Attr" .. i .. "/Efx1")
		local attrEfxPanel2 = UIControls.LazyEffectPlayer(self, "AttrPanel/AttrLessPanel/Attr" .. i .. "/Efx2")

		table.insert(self.efxAttrList1, attrEfxPanel1)
		table.insert(self.efxAttrList2, attrEfxPanel2)
	end

	local attrPanel = HeroAttrPanel(self, "AttrPanel/AttrLessPanel/Attr4")

	attrPanel:setVisible(false)

	for i = 1, 8 do
		local attrPanel = HeroAttrPanel(self, "AttrPanel/AttrMorePanel/Attr0" .. i)

		table.insert(self.attrMoreList, attrPanel)
	end

	self.slot4RefreshData = Slot(self.refreshColor, self)

	EventCenter.addEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshData)

	self.gridSkillList = {}
	self.btnCommentEnter = UIControls.Button(self, "BtnHeroGuideEvaluate")

	self.btnCommentEnter:setVisible(true)
	self.btnCommentEnter:addEventClick(self.onCommentBtnClick)

	self.imgRedDotPaintPlus = UIControls.Image(self, "InfoPanel/BgHead/IconNew")
	self.iconCoating02 = UIControls.Image(self, "InfoPanel/BgHead/IconCoating02")
	self.txtPaintPlusLevel = UIControls.Label(self, "InfoPanel/BgHead/IconCoating02/Text")
	self.bgBullet = UIControls.UIAni(self, "BgSubtitle")
	self.txtBullet = UIControls.Label(self, "BgSubtitle/Text")

	if UIControls.checkControlFunc(self, "InfoPanel/BgHead/IconUR") then
		self.iconUR = UIControls.Panel(self, "InfoPanel/BgHead/IconUR")
	end
end

function HeroContentBaseInfoPanel:onCommentBtnClick()
	local commentDlg = UIManager.getUI("commentDlg", true)

	commentDlg:setHeroId(self.hero.id)
end

function HeroContentBaseInfoPanel:onGoldClick()
	UIManager.getUI("itemTips"):showObj(self, BaseObject.GetObject(Const.MONEY_ID_GOLD), {
		AutoOpenGuide = 1
	})
end

function HeroContentBaseInfoPanel:onMaterialClick()
	local needMaterialId = self.levelCostInfo.res_id[1]

	if needMaterialId then
		UIManager.getUI("itemTips"):showObj(self, BaseObject.GetObject(needMaterialId), {
			AutoOpenGuide = 1
		})
	end
end

function HeroContentBaseInfoPanel:onMaterial2Click()
	local needMaterialId = self.levelCostInfo.res_id[2]

	if needMaterialId then
		UIManager.getUI("itemTips"):showObj(self, BaseObject.GetObject(needMaterialId), {
			AutoOpenGuide = 1
		})
	end
end

function HeroContentBaseInfoPanel:playUpgradeEfx(effectAttrList, isSuperLvUp)
	self.mWindow:playLevelUpModelEfx(isSuperLvUp)

	if isSuperLvUp then
		self.efxPower2:playEffect()

		for _, efxPanel in ipairs(self.efxAttrList2) do
			efxPanel:playEffect()
		end
	else
		self.efxPower1:playEffect()

		for _, efxPanel in ipairs(self.efxAttrList1) do
			efxPanel:playEffect()
		end
	end

	self.aniHeroLv:startAni("HeroLvChange")
end

function HeroContentBaseInfoPanel:restartQuickLvPanelShow()
	self.cacheLvTarget = self.quickLvTarget

	self.btnUpgradeFast:setVisible(true)
	self.btnUpgradeFast:setText(string.format(Lang.get(30371), self.cacheLvTarget))

	if not self.timerHideQuickLv then
		self.timerHideQuickLv = Timer.New(Slot(self.timerHideQuickLvFunc, self), 3, 1)

		self.timerHideQuickLv:Start()
	else
		self.timerHideQuickLv:Stop()

		self.timerHideQuickLv = nil
		self.timerHideQuickLv = Timer.New(Slot(self.timerHideQuickLvFunc, self), 3, 1)

		self.timerHideQuickLv:Start()
	end
end

function HeroContentBaseInfoPanel:hideQuickLvPanel()
	self.btnUpgradeFast:setVisible(false)

	if self.timerHideQuickLv then
		self.timerHideQuickLv:Stop()

		self.timerHideQuickLv = nil
	end
end

function HeroContentBaseInfoPanel:timerHideQuickLvFunc()
	self.btnUpgradeFast:setVisible(false)
end

function HeroContentBaseInfoPanel:onBtnUpgradeFastClick()
	self:hideQuickLvPanel()

	local heroUpgradeFastDlg = UIManager.getUI("heroUpgradeFastDlg", true)

	heroUpgradeFastDlg:setHeroQuickLv(self.hero, self.cacheLvTarget)
end

local function jumpToRearHouse()
	if CurAvatar.rearHouseState.unlock_award == 0 then
		RPC.houseUnlockAwardGet()
	end

	GameFsm.translateState(Const.STATE_MAIN_REAR_HOUSE)
end

function HeroContentBaseInfoPanel:onBtnUpgradeClick()
	if self.btnUpgradeLock then
		return
	end

	if not self.mWindow.passCheckCryFlag and self.hero.inCry == 0 and CurAvatar:isCrystalOpened() and CurAvatar.crystalData.level > 1 then
		local function noFunc()
			self.mWindow.passCheckCryFlag = true
		end

		local msgContent = string.format(Lang.get(30372), math.min(CurAvatar.crystalData.level, self.hero:getMaxLv()))

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, jumpToRearHouse, noFunc, -1)

		return
	end

	local reasonList = self:_checkHeroUpgradeCan()

	if #reasonList == 0 then
		if self.hero.realLevel + ResHeroMisc[1].quick_lv_diff <= self.quickLvTarget and not self.isSecondLvTarget then
			self:restartQuickLvPanelShow()
		elseif self.isSecondLvTarget and self.hero.realLevel < self.quickLvTarget then
			self:restartQuickLvPanelShow()
		end

		if self.levelCostInfo.res_id[2] then
			local heroUpgradeDlg = UIManager.getUI("heroUpgradeDlg", true)

			heroUpgradeDlg:setHero(self.hero)
		else
			self.btnUpgradeLock = true

			RPC.heroLevelUp(self.hero.gid)
		end
	else
		self.btnUpgrade:interruptHoldEvent()

		if reasonList[1] == LACK_CRYSTAL_MAX then
			MsgManager.notice(string.format(Lang.get(30373), CurAvatar:getHeroPriestsLvStep(self.hero).level))
		elseif reasonList[1] == LACK_GOLD or reasonList[1] == LACK_MATERIAL or reasonList[1] == LACK_MATERIAL2 then
			UIManager.getUI("itemTips"):showObj(self, BaseObject.GetObject(CANT_UPGRADE_REASON_NOTICE[reasonList[1]]), {
				AutoOpenGuide = 1
			})
			MsgManager.notice(string.format(Lang.get(30228), BaseObject.GetObject(CANT_UPGRADE_REASON_NOTICE[reasonList[1]]).name))
		elseif reasonList[1] == LACK_STEP_LV then
			local function yesFunc()
				self.mParent:selectTab(Const.HERO_CONTENT_PANEL.STAGE_UP)
			end

			local function noFunc()
				return
			end

			local msgContent = Lang.get(30377)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, noFunc, -1)
		elseif reasonList[1] == LACK_STAR_LV then
			self:upgradeNeedStarLv()
		else
			MsgManager.notice(CANT_UPGRADE_REASON_NOTICE[reasonList[1]])
		end
	end

	if self.beginnerUpgradeFocusChild then
		self.beginnerUpgradeFocusChild:setVisible(false)
	end
end

function HeroContentBaseInfoPanel:upgradeNeedStarLv()
	local function yesFunc()
		if self.hero:isUniqueHero() then
			local relatedHero = self.hero:getRelatedHero()

			if relatedHero then
				local starUpDlg = UIManager.getUI("heroStarUpDlg", true)

				starUpDlg:setHeroToExchagngePanel(relatedHero)
			else
				MsgManager.notice(Lang.get(56190))
			end
		else
			local heroStarUpDlg = UIManager.getUI("heroStarUpDlg", true)

			heroStarUpDlg:setHeroToExchagngePanel(self.hero)
		end
	end

	local function noFunc()
		return
	end

	if self.hero:isUniqueHero() then
		UIManager.getUI("relatedStarUpNoticeDlg", true):setHero(self.hero.id, 1, yesFunc)
	else
		local msgContent = Lang.get(30378)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, noFunc, -1)
	end
end

function HeroContentBaseInfoPanel:onBtnDetailClick()
	local txtStr = self.panelSkill:getVisible() and Lang.get(466) or Lang.get(963)

	self.btnDetail:setText(txtStr)
	self.panelSkill:changeVisible()
	self.panelLessAttr:changeVisible()
	self.panelMoreAttr:changeVisible()
end

function HeroContentBaseInfoPanel:onBtnBgHeadClick()
	local heroPaintingDlg = UIManager.getUI("heroPaintingDlg", true)

	heroPaintingDlg:setHero(self.hero)
end

function HeroContentBaseInfoPanel:onBtnResetBaseClick()
	if CurAvatar:isCrystalOpened() then
		self:openResetDlg(Const.HERO_RESET_LEVEL)
	else
		self:openResetDlg(Const.HERO_RESET_ALL)
	end
end

function HeroContentBaseInfoPanel:onBtnResetStageClick()
	if self.hero.step >= Const.HERO_RESET_CLOSE_STEP then
		MsgManager.clientNotice(265)

		return
	end

	self:openResetDlg(Const.HERO_RESET_STEP)
end

function HeroContentBaseInfoPanel:openResetDlg(resetType)
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HERO_RESET)

	if isLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HERO_RESET))

		return
	end

	if resetType == Const.HERO_RESET_LEVEL and self.hero.realLevel <= 1 then
		MsgManager.clientNotice(153)

		return
	end

	if resetType == Const.HERO_RESET_STEP and self.hero.step <= 0 then
		MsgManager.clientNotice(171)

		return
	end

	if resetType == Const.HERO_RESET_ALL and self.hero.realLevel <= 1 and self.hero.step <= 0 then
		MsgManager.clientNotice(153)

		return
	end

	local uiName = resetType == Const.HERO_RESET_STEP and "heroResetOrderDlg" or "heroResetDlg"
	local heroResetDlg = UIManager.getUI(uiName, true)

	heroResetDlg:setHero(self.hero, resetType)
end

function HeroContentBaseInfoPanel:onBtnInfoClick()
	UIManager.getUI("heroGroupCareerInfoDlg", true)
end

function HeroContentBaseInfoPanel:onBtnOutCrystaClick()
	local function yesFunc()
		MsgManager.clientNotice(241)
		CurAvatar:removeHeroFromHouse(self.hero.gid)
	end

	local msgContent = string.format(Lang.get(30374), self.hero.realLevel)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
end

function HeroContentBaseInfoPanel:onBtnBecomeLeaderClick()
	local heroBecomeLeaderDlg = UIManager.getUI("heroBecomeLeaderDlg", true)

	heroBecomeLeaderDlg:setRecHero(self.hero)
end

function HeroContentBaseInfoPanel:_checkHeroUpgradeCan()
	local maxLv = self.hero:getMaxStarLv()
	local maxStepLimitLv = ResStep[self.hero.step + 1] and ResStep[self.hero.step + 1].last_step_max_lv or 99999
	local totalMaxLv = self.hero:getMaxLv()
	local reasonList = {}

	if totalMaxLv <= self.hero.level then
		table.insert(reasonList, LACK_TOTAL_LV)
	end

	if self.hero.level >= CurAvatar:getCrystalPriestsMaxLv() then
		table.insert(reasonList, LACK_CRYSTAL_MAX)
	end

	if maxLv <= self.hero.level then
		table.insert(reasonList, LACK_STAR_LV)
	end

	if maxStepLimitLv <= self.hero.level then
		table.insert(reasonList, LACK_STEP_LV)
	end

	if self.levelCostInfo then
		local needMaterialId = self.levelCostInfo.res_id[1]

		CANT_UPGRADE_REASON_NOTICE[LACK_MATERIAL] = needMaterialId

		local needMaterialCount = self.levelCostInfo.res_num[1]
		local needGoldCount = self.levelCostInfo.gold

		if needMaterialCount > CurAvatar:getItemNumById(needMaterialId) then
			table.insert(reasonList, LACK_MATERIAL)
		end

		if self.levelCostInfo.res_id[2] and CurAvatar:getItemNumById(self.levelCostInfo.res_id[2]) < self.levelCostInfo.res_num[2] then
			CANT_UPGRADE_REASON_NOTICE[LACK_MATERIAL2] = self.levelCostInfo.res_id[2]

			table.insert(reasonList, LACK_MATERIAL2)
		end

		if needGoldCount > CurAvatar:getMoneyByType(Const.MONEY_TYPE_GOLD) then
			table.insert(reasonList, LACK_GOLD)
		end
	end

	if self.hero:isCrystalSlot() then
		table.insert(reasonList, IS_CRYSTAL_SLOT)
	end

	return reasonList
end

function HeroContentBaseInfoPanel:setHero(hero)
	if self.hero and hero.gid ~= self.hero.gid then
		self:hideQuickLvPanel()

		self.isSecondLvTarget = false
		self.mWindow.passCheckCryFlag = nil

		self.aniHeroLv:setScale(1)
	end

	self.hero = hero
	self.btnUpgradeLock = false

	self:refreshBaseInfo()
	self:refreshStarPanel()
	self:refreshPropPanel()
	self:refreshMaterialInfo()
	self:refreshGridSkill()
	self:refreshTextColor()

	if Const.PAINT_PLUS_OPEN then
		self:refreshPaintPlus()
	end

	self:setBulletShow()
end

function HeroContentBaseInfoPanel:setBulletShow(...)
	self.bgBullet:setVisible(false)

	local function showBullet(...)
		self.bgBullet:setVisible(true)
		self.bgBullet:startAni("ShowSubtitle")
	end

	local function closeBullet(...)
		self.bgBullet:startAni("HideSubtitle")
	end

	if not self.bulletShowTimer then
		self.bulletShowTimer = Timer.New(Slot(showBullet, self), 0.5, 1)
	end

	if not self.bulletCloseTimer then
		self.bulletCloseTimer = Timer.New(Slot(closeBullet, self), 4.5, 1)
	end

	self.bulletShowTimer:Stop()
	self.bulletCloseTimer:Stop()

	local voiceId = ClientUtils.getHeroVoiceIdByType(self.hero.id, Const.HERO_VOCAL_CHOOSE)

	if voiceId then
		local showState, desc = ClientUtils.checkCanShowVoCalBullet(voiceId)

		if showState and desc then
			self.txtBullet:setText(desc)
			self.bulletShowTimer:Restart()
			self.bulletCloseTimer:Restart()
		end
	end
end

function HeroContentBaseInfoPanel:refreshPaintPlus(...)
	local REDDOT_TABLE_HERO_ID = {
		"canUnLockPaintPlusMainPropDic",
		"canUpPaintPlusRelateLevelDic"
	}

	if Const.PAINT_PLUS_OPEN then
		local nowMainLevel = self.hero:getPaintPlusShowLevel()

		if nowMainLevel and nowMainLevel > 0 then
			self.iconCoating02:setVisible(true)
			self.txtPaintPlusLevel:setText(nowMainLevel)
		else
			self.iconCoating02:setVisible(false)
		end

		for _, table in ipairs(REDDOT_TABLE_HERO_ID) do
			if CurAvatar[table] and CurAvatar[table][self.hero.id] then
				self.imgRedDotPaintPlus:setVisible(true)

				return
			end
		end
	end

	self.imgRedDotPaintPlus:setVisible(false)
end

function HeroContentBaseInfoPanel:refreshTextColor()
	local reasonList = self:_checkHeroUpgradeCan()
	local reasonCount = #reasonList

	self.txtNeedGold:setFontColor(ResColor.GREYWHITE)
	self.txtNeedMaterial:setFontColor(ResColor.GREYWHITE)
	self.txtNeedMaterial2:setFontColor(ResColor.GREYWHITE)
	self.btnGoldIcon:setEnable(false)
	self.btnMaterialIcon:setEnable(false)
	self.btnMaterialIcon2:setEnable(false)
	self.imgGoldAdd:setVisible(false)
	self.imgMaterialAdd:setVisible(false)
	self.imgMaterialAdd2:setVisible(false)

	if reasonCount == 0 then
		self:setIsCryShow(false)
	else
		local isLockGuild = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_ITEM_GUILD)
		local isCryStepMax = false
		local isCryShow = false

		for i = 1, reasonCount do
			if reasonList[i] == LACK_GOLD then
				self.txtNeedGold:setFontColor(ResColor.RED)
				self.btnGoldIcon:setEnable(true)

				if not isLockGuild then
					self.imgGoldAdd:setVisible(true)
				end
			elseif reasonList[i] == LACK_MATERIAL then
				self.txtNeedMaterial:setFontColor(ResColor.RED)
				self.btnMaterialIcon:setEnable(true)

				if not isLockGuild then
					self.imgMaterialAdd:setVisible(true)
				end
			elseif reasonList[i] == LACK_MATERIAL2 then
				self.txtNeedMaterial2:setFontColor(ResColor.RED)
				self.btnMaterialIcon2:setEnable(true)

				if not isLockGuild then
					self.imgMaterialAdd2:setVisible(true)
				end
			elseif reasonList[i] == IS_CRYSTAL_SLOT then
				isCryShow = true
			elseif reasonList[i] == LACK_CRYSTAL_MAX then
				isCryShow = true
			elseif reasonList[i] == LACK_CRYSTAL_STEP_MAX then
				isCryStepMax = true
				isCryShow = true
			end
		end

		self:setIsCryShow(isCryShow, isCryStepMax)
	end
end

function HeroContentBaseInfoPanel:setIsCryShow(isCryShow, isCryStepMax)
	local totalMax = self.hero.level == self.hero:getMaxLv()
	local isShowMaterial = not isCryShow and not totalMax

	self.btnGoldIcon:setVisible(isShowMaterial)
	self.btnMaterialIcon:setVisible(isShowMaterial)
	self.btnMaterialIcon2:setVisible(isShowMaterial and self.levelCostInfo.res_id[2] ~= nil)
	self.imgMaterialIcon2Bg:setVisible(isShowMaterial and self.levelCostInfo.res_id[2] == nil)
	self.btnUpgrade:setVisible(isShowMaterial)

	if isCryShow or totalMax then
		self.btnUpgrade:interruptHoldEvent()
	end

	if isCryShow and not totalMax then
		local txtRuleStr = ""

		if self.hero.level == ResCrystalMisc[1].maxLevel and CurAvatar.crystalData.level >= ResCrystalLevelLimit[#ResCrystalLevelLimit].level then
			txtRuleStr = string.format(Lang.get(30375), ResCrystalMisc[1].maxLevel)
		else
			txtRuleStr = self.hero:isCrystalSlot() and Lang.get(30379) or string.format(Lang.get(30373), CurAvatar:getHeroPriestsLvStep(self.hero).level)
		end

		self.txtCryRule:setText(txtRuleStr)
		self.txtCryRule:setVisible(true)
	else
		self.txtCryRule:setVisible(false)
	end

	self.btnOutCrysta:setVisible(self.hero:isCrystalSlot())

	local lvColor = self.hero:getLvColor()

	if Const.REVIEW_VERSION then
		self.txtHeroLv:setText(Lang.get(1203) .. self.hero:getShowLv())
	else
		self.txtHeroLv:setText("LV." .. self.hero:getShowLv())
	end

	self.txtHeroLv:setFontColor(lvColor)
	self.txtHeroLv:setVisible(not totalMax)
	self.imgLvMax:setVisible(totalMax)
end

function HeroContentBaseInfoPanel:refreshColor()
	if CurAvatar.crystalData then
		self:refreshTextColor()
	end
end

function HeroContentBaseInfoPanel:refreshGridSkill()
	if self.skillTips then
		self.skillTips:setVisible(false)
		self.btnSkillTipsSensor:setVisible(false)

		if self.curSelectSkillGrid then
			self.curSelectSkillGrid.imgSelect:setVisible(false)
			self.curSelectSkillGrid.btnSelf:setEnable(true)

			self.curSelectSkillGrid = nil
		end
	end

	local willUpSkillField = self.hero:getNextUpSkillField()

	for i = 1, 4 do
		if self.hero[Const.SKILL_FIELD_LIST[i]] then
			if not self.gridSkillList[i] then
				self.gridSkillList[i] = UIControls.HeroSkillGridChild(self, "SkillPanel/SkillList", "System/Hero/GridHeroSkill", 0, 0, true)
			end

			self.gridSkillList[i].gridPanel = UIConst.SKILL_PANEL_HERO_BASE

			local skill = self.hero[Const.SKILL_FIELD_LIST[i]]

			self.gridSkillList[i]:setObj(skill, self.hero)

			if willUpSkillField and skill.skillField == willUpSkillField then
				self.gridSkillList[i]:showUpInfo()
			end
		elseif self.gridSkillList[i] then
			self.gridSkillList[i]:destroy()

			self.gridSkillList[i] = nil
		end
	end
end

function HeroContentBaseInfoPanel:refreshMaterialInfo()
	self.levelCostInfo = ResLevelCost[self.hero.quality][self.hero.level]

	if not self.levelCostInfo then
		return
	end

	local needMaterialId = self.levelCostInfo.res_id[1]
	local needMaterialCount = self.levelCostInfo.res_num[1]
	local needGoldCount = self.levelCostInfo.gold
	local moneyID = Const.MONEY_TYPE2ID[Const.MONEY_TYPE_GOLD] or 0
	local moneyInfo = UIConst.MONEY_ID2INFO[moneyID]

	if moneyInfo then
		self.imgGoldIcon:setImage(moneyInfo[1], moneyInfo[2])
	end

	self.txtNeedGold:setText(ClientUtils.getNumShortStr(needGoldCount))
	self.imgMaterialIcon:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconHeroExp")
	self.txtNeedMaterial:setText(ClientUtils.getNumShortStr(needMaterialCount))
	self.mWindow.panelFund:onItemUpdate(needMaterialId)

	if self.levelCostInfo.res_id[2] then
		local needId = self.levelCostInfo.res_id[2]
		local needNum = self.levelCostInfo.res_num[2]

		self.btnMaterialIcon2:setVisible(true)
		self.imgMaterialIcon2:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconLvUp")
		self.imgMaterialIcon2Bg:setVisible(false)
		self.txtNeedMaterial2:setText(ClientUtils.getNumShortStr(needNum))
	else
		self.imgMaterialIcon2Bg:setVisible(true)
		self.btnMaterialIcon2:setVisible(false)
	end
end

function HeroContentBaseInfoPanel:refreshPropPanel()
	local checkCrystalLevel = self.hero.crystalSecondLevel and self.hero.crystalSecondLevel > 9

	if self.imgCrystalLv then
		if checkCrystalLevel then
			self.imgCrystalLv:setVisible(true)
			self.txtCrystalLv:setText(math.floor(self.hero.crystalSecondLevel / 10))
		else
			self.imgCrystalLv:setVisible(false)
		end
	end

	local equips = self.hero:getEquips()
	local artifact = self.hero:getArtifact()
	local propLevel = self.hero:getPropLevel()

	self.container = PropHelper.getHeroPanelAttrContainer(self, self.hero.id, propLevel, self.hero.battleStep, self.hero.star, equips, artifact, self.hero, self.hero:getSkinData(), self.hero:getBaseData(), self.hero:getRelic(), self.hero:getPaintData(), self.hero:getRelationPointData())

	local originalContainer

	if checkCrystalLevel then
		local level = propLevel - self.hero.crystalSecondLevel

		originalContainer = PropHelper.getHeroPanelAttrContainer(self, self.hero.id, level, self.hero.battleStep, self.hero.star, equips, artifact, self.hero, self.hero:getSkinData(), self.hero:getBaseData(), self.hero:getRelic(), self.hero:getPaintData(), self.hero:getRelationPointData())
	end

	for i = 1, #ATTR_PANEL_PROP_MAP do
		local attrName = ATTR_PANEL_PROP_MAP[i].prop
		local value = self.container[attrName] or 0
		local dValue = 0

		if checkCrystalLevel and (attrName == "atk" or attrName == "mhp") then
			local originalValue = originalContainer[attrName] or 0

			dValue = value - originalValue
		end

		local zhName, valueStr = ClientUtils.getRolePropZhName(attrName, value, true)
		local attriconInfo = ClientUtils.getRolePropIcon(attrName)

		self.attrMoreList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
		self.attrMoreList[i]:setData(zhName, valueStr)
		self.attrMoreList[i]:setCrystalProp(dValue)

		if dValue > 0 then
			self.attrMoreList[i]:setValueColor(ResColor.LIGHTBLUE)
		else
			self.attrMoreList[i]:setValueColor(ResColor.WHITE)
		end

		if self.attrList[i] then
			self.attrList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
			self.attrList[i]:setData(zhName, valueStr)
			self.attrList[i]:setCrystalProp(dValue)

			if dValue > 0 then
				self.attrList[i]:setValueColor(ResColor.LIGHTBLUE)
			else
				self.attrList[i]:setValueColor(ResColor.WHITE)
			end

			local rankValue = CurAvatar:getHeroPropValueByStep(attrName, self.hero)
			local attrRank = CurAvatar:getHeroPropRank(attrName, rankValue)
			local rankIconInfo = UIConst.HERO_PROP_RANK_ICON[attrRank]
			local imgRank = UIControls.Image(self.attrList[i], self.attrList[i].mPath .. "/IconScore")

			imgRank:setImage(rankIconInfo[1], rankIconInfo[2])
		end
	end

	for i = #ATTR_PANEL_PROP_MAP + 1, #self.attrMoreList do
		self.attrMoreList[i]:setVisible(false)
	end
end

function HeroContentBaseInfoPanel:refreshStarPanel()
	local starPath = self.hero:getStarPath()

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
	end
end

function HeroContentBaseInfoPanel:refreshBaseInfo()
	self.quickLvTarget = CurAvatar:getHeroQuickLvTarget(self.hero, self.isSecondLvTarget)

	if Const.REVIEW_VERSION and self.hero.fullName == "S-VIII" then
		self.txtName:setText(Lang.get(111526))
	else
		self.txtName:setText(self.hero.fullName)
	end

	local headPath = self.hero:getIconPath(true)

	if headPath then
		self.imgIconHead:setImage(headPath[1], headPath[2])
	end

	local stepImgIdx = ResStarUpCondition[self.hero.star].step_img_idx or 1
	local stepImgInfo = UIConst.HERO_CARD_SPRITE_BY_STEP[stepImgIdx]

	self.imgIconHeadBg:setImage(stepImgInfo.BG_HEAD[1], stepImgInfo.BG_HEAD[2])

	local careerPath = self.hero:getCareerPath()

	self.imgCareerIcon:setImage(careerPath[1], careerPath[2])
	self.txtCareer:setText(Const.CAREER_CONFIG[self.hero.career].name)
	self.txtHeroLv:setText(string.format(Lang.get(30171), self.hero.level))
	self.bgStage:setVisible(self.hero.step > 0)

	if self.hero.step > 0 then
		self.hero:setHeroStepUI(nil, self.txtStage)
	end

	self.txtGroup:setText(Const.CAMP_CONFIG[self.hero.resData.camp].name)

	local groupPath = self.hero:getGroupPath()

	self.imgGroup:setImage(groupPath[1], groupPath[2])

	local groupTeamPath = self.hero:getGroupTeamPath()

	if groupTeamPath then
		self.panelTeam:setVisible(true)
		self.imgTeamIcon:setImage(groupTeamPath[1], groupTeamPath[2])
		self.txtTeam:setText(Const.HERO_TEAM_CONFIG[self.hero.team].name)
	else
		self.panelTeam:setVisible(false)
	end

	self.txtPowerNum:setText(self.hero:getCapacity())

	local maxStarLv = CurAvatar:getHeroMaxStarLv(self.hero)
	local maxStepLimitLv = ResStep[self.hero.step + 1] and ResStep[self.hero.step + 1].last_step_max_lv or 99999

	if CurAvatar:isCrystalOpened() then
		self.btnResetStage:setVisible(true)

		local spriteName = self.hero.realLevel > 1 and "BtnResetNml" or "BtnReset"

		self.btnResetBase:setVisible(true)
		self.btnResetBase:setText(Lang.get(1146))
		self.btnResetBaseIconNew:setVisible(self.hero.inCry == 0 and self.hero.level > 1)

		if CurAvatar:getMostEarlyStepTick() == 0 or self.hero:getResetStepCD() <= 0 then
			local spriteName = self.hero.step > 0 and self.hero.step < Const.HERO_RESET_CLOSE_STEP and "BtnResetNml" or "BtnReset"

			self.txtResetStageCd:setVisible(false)
		elseif ClientUtils.getServerTime() >= CurAvatar:getMostEarlyStepTick() then
			self:timeDownCallBack()
			ClientTimerManager.RemoveSecondTickUI(self.txtResetStageCd)
		else
			self.txtResetStageCd:setVisible(true)

			local remainTime = CurAvatar:getMostEarlyStepTick() - ClientUtils.getServerTime()

			ClientTimerManager.AddSecondTickUI(self.txtResetStageCd, remainTime, false, "", "", Slot(self.timeDownCallBack, self))
		end
	else
		self.btnResetStage:setVisible(false)
		self.btnResetBase:setVisible(true)
		self.btnResetBase:setText(Lang.get(919))

		if self.hero.realLevel > 1 or self.hero.step > 0 and self.hero.step < Const.HERO_RESET_CLOSE_STEP then
			local var_42_0 = "BtnResetNml"
		else
			local spriteName = "BtnReset"
		end
	end

	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_HERO_EXCHANGE)

	self.btnBecomeLeader:setVisible(not isLocked and CurAvatar:isCrystalOpened() and self.hero.star >= ResHeroMisc[1].hero_exchange_star and not self.hero:isCrystalPriests())

	if self.mWindow.heroInfoFocusChild and self.mWindow.heroInfoFocusChild:getVisible() then
		if not self.beginnerUpgradeFocusChild then
			self.beginnerUpgradeFocusChild = RookieFocusChild(self, "InfoPanel/BtnUpgrade", "System/PlayerGuide/HighLightPanel", 0, 0)

			self.beginnerUpgradeFocusChild:focus(self.btnUpgrade:getComObj().transform, Const.BEGINNER_LOSE_NOTICE[6])
		end

		self.beginnerUpgradeFocusChild:setVisible(true)
	elseif self.beginnerUpgradeFocusChild then
		self.beginnerUpgradeFocusChild:setVisible(false)
	end

	self.btnBgHead:setEnable(CurAvatar:canShowPaintEntry(self.hero))
	self.imgPainting:setVisible(CurAvatar:canShowPaintEntry(self.hero))

	local paintPath = self.hero:getPaintPath(Const.PAINT_HERO_BASEPANEL)

	if paintPath then
		self.imgPaint:setVisible(true)
		self.imgPaint:setImage(paintPath[1], paintPath[2])
	else
		self.imgPaint:setVisible(false)
	end

	local paintEfxPath = self.hero:getPaintEfxPath(Const.PAINT_HERO_BASEPANEL)

	if paintEfxPath then
		self.efxPainting:playEffect(paintEfxPath)
		self.efxPainting:setVisible(true)
	else
		self.efxPainting:setVisible(false)
	end

	if self.iconUR then
		self.iconUR:setVisible(self.hero:isURHero())
	end
end

function HeroContentBaseInfoPanel:timeDownCallBack(...)
	self.txtResetStageCd:setVisible(false)

	local spriteName = self.hero.step > 0 and self.hero.step < Const.HERO_RESET_CLOSE_STEP and "BtnResetNml" or "BtnReset"
end

function HeroContentBaseInfoPanel:setVisible(isVisible)
	self:clearEfx()
	HeroContentBaseInfoPanel.super.setVisible(self, isVisible)
end

function HeroContentBaseInfoPanel:clearEfx()
	self.efxPower1:stopEffect()
	self.efxPower2:stopEffect()

	for _, efxPanel in ipairs(self.efxAttrList1) do
		efxPanel:stopEffect()
	end

	for _, efxPanel in ipairs(self.efxAttrList2) do
		efxPanel:stopEffect()
	end
end

function HeroContentBaseInfoPanel:destroy()
	self:clearEfx()
	EventCenter.removeEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshData)

	if self.timerHideQuickLv then
		self.timerHideQuickLv:Stop()

		self.timerHideQuickLv = nil
	end

	if self.bulletShowTimer then
		self.bulletShowTimer:Stop()
	end

	if self.bulletCloseTimer then
		self.bulletCloseTimer:Stop()
	end

	HeroContentBaseInfoPanel.super.destroy(self)
end

return HeroContentBaseInfoPanel
