-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroMainDlg.lua

local strClassName = "HeroMainDlg"
local HeroGridCardList = require("UI/Hero/HeroGridCardList")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local HeroInfoPanel = require("UI/Hero/HeroInfoPanel")
local HeroListFunPanel = require("UI/Hero/HeroListFunPanel")
local HeroContentPanel = require("UI/Hero/ContentPanel/HeroContentPanel")
local ModelTool = require("Entity/ModelTool")
local HERO_ATLAS = "Atlas/HeroAtlas/HeroAtlas"
local ResWindowMoneyConfig = require("ClientData/ResWindowMoneyConfig")
local GameSettings = require("Helper/GameSettings")
local HeroSkinPanel = require("UI/Hero/HeroSkinPanel")
local RookieFocusChild = require("Logic/Beginner/RookieFocusChild")
local Mathf = Mathf
local HERO_MAIN_DLG_SHOW_STATE = {
	HERO_LIST = 0,
	DETAIL_INFO = 1,
	HERO_SKIN = 2
}
local STAGE_CAMERA_MOVE_DUR = 0.8
local HERO_STAGE_CAMERA_RIGHT = {
	16.54,
	11.87,
	109.95
}
local HERO_STAGE_CAMERA_LEFT = {
	10.54,
	11.87,
	109.95
}
local HERO_STAGE_CAMERA_RIGHT_ZOOM_DEFAULT = {
	15.46,
	13.18,
	101.73
}
local HERO_STAGE_TO_SKIN = {
	11.4,
	11.87,
	109.95
}
local SHADOW_DISTANCE_DEFAULT = 25
local SHADOW_DISTANCE_ZOOM = 18
local REDDOT_TABLE = {
	"canStepUpInTeamHerosDic",
	"canEquipInTeamHerosDic",
	"canSweepStepInTeamHerosDic",
	"canNewBaseUnlockDic",
	"canNewSkinUnlockDic",
	"canQuickSweepInTeamHerosDic"
}
local REDDOT_TABLE_HERO_ID = {
	"canUnLockPaintPlusMainPropDic",
	"canUpPaintPlusRelateLevelDic",
	"canUnLockSeasonRelicHeroDic",
	"canLvUpSeasonRelicHeroDic",
	"firstShowSeasonRelicHeroDic"
}
local REDDOT_TABLE_STICK = {
	"canLvUpStickHeroDic"
}
local DRAG_ROTATE_SPEED = 240
local DRAG_CAM_ROTATE_SPEED = 60
local HENTAI_ACTION_CD = 60
local ModelFactory = Framework.Entity.ModelFactory
local HeroMainDlg = Class(strClassName, UIControls.Window)

function HeroMainDlg:ctor()
	self:initUI()

	self._slot4LoadNewModelEnd = Slot(self.deleteOtherModel, self)
end

function HeroMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.heroInfoPanel = HeroInfoPanel(self, "HeroInfoPanel")
	self.heroContentPanel = HeroContentPanel(self, "HeroContentPanel")
	self.heroListPanel = UIControls.Panel(self, "HeroListPanel")
	self.filterSelectPanel = FilterSelectPanel(self, "HeroListPanel/ListSelectPanel")
	self.panelBgNone = UIControls.Panel(self, "HeroListPanel/BgNothing")
	self.heroGridCardList = HeroGridCardList(self, "HeroListPanel/HeroList")
	self.heroListFunPanel = HeroListFunPanel(self, "HeroListPanel/ListFunPanel")
	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/HeroDlgModelStage")
	self.modelControl = UIControls.Panel(self, "ModelControl")

	self.modelStage:initOperationDefault(self.modelControl)

	self.modelStage.mEventOprFingerDown = Slot(self.onDragStart, self)
	self.modelStage.mEventOprFingerUp = Slot(self.onDragEnd, self)
	self.modelStage.mEventOprDrag = Slot(self.onDrag, self)
	self.btnHeroInfo = UIControls.Button(self, "BtnHeroInfo", "Text")

	self.btnHeroInfo:addEventClick(self.onBtnHeroInfoClick)

	self.imgCanUpgrade = UIControls.Image(self, "BtnHeroInfo/IconNew")
	self.btnHeroNext = UIControls.Button(self, "BtnHeroNext")

	self.btnHeroNext:addEventClick(self.onHeroNextClick)

	self.btnHeroLast = UIControls.Button(self, "BtnHeroLast")

	self.btnHeroLast:addEventClick(self.onHeroLastClick)

	self.btnRecommend = UIControls.Button(self, "HeroListPanel/BtnRecommend")

	self.btnRecommend:addEventClick(self.onBtnRecommendClick)

	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self._onAniFinish)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnHandBook = UIControls.Button(self, "OtherFunPanel/BtnHandbook")

	self.btnHandBook:addEventClick(self.onBtnHandBookClick)

	self.btnStarUp = UIControls.Button(self, "OtherFunPanel/BtnStarUp")

	self.btnStarUp:addEventClick(self.onBtnStarUpClick)

	self.btnUniqueStarUp = UIControls.Button(self, "OtherFunPanel/BtnVanityHero")

	self.btnUniqueStarUp:addEventClick(self.onBtnUniqueStarUpClick)

	self.imgIconStarUpNew = UIControls.Image(self, "OtherFunPanel/BtnStarUp/IconNew")

	self:_checkBtnEnable()

	self.btnZoom = UIControls.Button(self, "OtherFunPanel/BtnZoom")

	self.btnZoom:addEventClick(self.onBtnZoomClick)

	self.imgZoom = UIControls.Image(self, "OtherFunPanel/BtnZoom/Image")
	self.isZoomIn = false
	self.heroSkinPanel = HeroSkinPanel(self, "HeroSkinPanel")
	self.bgVoiceBullet = UIControls.UIAni(self, "HeroInfoPanel/BgSubtitle")
	self.txtVoiceBullet = UIControls.Label(self, "HeroInfoPanel/BgSubtitle/Text")

	if CurAvatar then
		self.currentEntity = CurAvatar
	end

	self.DRAG_UP_LIMIT = 3
	self.DRAG_DOWN_LIMIT = -3
	self.DRAG_ANCHOR_DISTANCE = 11

	self:refreshFocusHero()
end

function HeroMainDlg:_onAniFinish(aniCom, aniName)
	if aniName == "ShowHeroDetailWindow2" then
		local equipPanel = self.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]

		if equipPanel and equipPanel:getVisible() then
			equipPanel:playPartEfx()
			equipPanel:realPlayArtifactEfx()
			equipPanel:realPlayRelicEfx()
			equipPanel:realPlayEquipAttrNum()
			equipPanel:realPlaySeasonRelicEfx()
		end
	end
end

function HeroMainDlg:_checkBtnEnable()
	self.starUpUnlocked = not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HERO_STARUP)

	if self.starUpUnlocked and not self.hintStarUp then
		self.hintStarUp = UIControls.RedDot(self, "OtherFunPanel/BtnStarUp/IconNew")

		self.hintStarUp:addHint({
			UIConst.RD_HINT_HERO_STAR_UP
		})
	elseif not self.starUpUnlocked and self.hintStarUp then
		self.hintStarUp:delHint(UIConst.RD_HINT_HERO_STAR_UP)

		self.hintStarUp = nil
	end
end

function HeroMainDlg:playLevelUpModelEfx(isSuperLvUp)
	local prefabPath = isSuperLvUp and "Effects/Heros/Common/efx_common_Levelup02.prefab" or "Effects/Heros/Common/efx_common_Levelup01.prefab"

	if self.preModelLvUpEfxId then
		EffectManager:releaseEffect(self.preModelLvUpEfxId)

		self.preModelLvUpEfxId = nil
	end

	local model = self.modelStage:getModel(self.curModelInsId)

	if model then
		self.preModelLvUpEfxId = EffectManager:playTransformEffect(model.transform, prefabPath, Const.EFFECT_LIFE_MODE.LogicControl)
	end
end

function HeroMainDlg:onBtnStarUpClick()
	if self.starUpUnlocked then
		local heroStarUpDlg = UIManager.getUI("heroStarUpDlg", true)
	else
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HERO_STARUP))
	end
end

function HeroMainDlg:onBtnUniqueStarUpClick()
	local ui = UIManager.getUI("relatedHeroInfoDlg", true)

	ui:bindWindow(self)
	ui:showHero(self.selectedHero.id)
end

function HeroMainDlg:refreshFocusHero()
	self.beginnerFocusHero = nil

	if CurAvatar.beginnerLoseMarked then
		self.beginnerFocusHero = CurAvatar:getBeginnerHintLvUpHero()

		self.heroGridCardList:beginnerFocusOneHero(self.beginnerFocusHero)

		if not self.beginnerFocusHero then
			CurAvatar:noticeBeginnerHookResult()
		end
	end
end

function HeroMainDlg:initForHeroList(selectGid)
	self.uiAni:startAni("ShowHeroMainWindow")
	self:refreshBtnHeroInfoShow(HERO_MAIN_DLG_SHOW_STATE.HERO_LIST)

	if selectGid then
		self:regularUpdateHeroCardList(selectGid)
	else
		self:regularUpdateHeroCardList(nil, 1)
	end
end

function HeroMainDlg:initForContentPanel(contentPanelType, selectGid, exArg)
	if selectGid then
		self:regularUpdateHeroCardList(selectGid)
	else
		self:regularUpdateHeroCardList(nil, 1)
	end

	self.modelStage:moveCameraSmooth(HERO_STAGE_CAMERA_LEFT, 0)
	self:refreshBtnHeroInfoShow(HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO)
	self.uiAni:startAni("ShowHeroDetailWindow2")
	self.heroContentPanel:selectTab(contentPanelType)
end

function HeroMainDlg:onOpen()
	HeroMainDlg.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)

	if self.showState == HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO then
		self.uiAni:startAni("ShowHeroDetailWindow2")
	elseif self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_SKIN then
		self.uiAni:startAni("ShowHeroSkinWindow2")
	else
		self.uiAni:startAni("ShowHeroMainWindow")
	end

	if self.showState ~= HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO then
		self:refreshImgStarAni(true)
	end

	self.heroListFunPanel.btnHeroSell:setVisible(true)
end

function HeroMainDlg:refreshImgStarAni(isonOpen)
	if #CurAvatar:getFastStarUpHeroList(true) > 0 and self.starUpUnlocked then
		self.imgIconStarUpNew:setVisible(true)
	else
		if isonOpen then
			-- block empty
		end

		self.imgIconStarUpNew:setVisible(false)
	end
end

function HeroMainDlg:onClose()
	GameSettings.resetShadowDistance("HeroMainDlg")
	CueManager.stopVocal()
	self.heroListFunPanel.btnHeroSell:setVisible(false)

	self.passCheckCryFlag = nil

	HeroMainDlg.super.onClose(self)
end

function HeroMainDlg:onReconnect()
	if self.selectedHero then
		self:refreshDetailForHero(self.selectedHero.gid)
		self.panelFund:onRefresh()
	end
end

function HeroMainDlg:jumpToHeroStickPanel(heroId)
	local hero = CurAvatar:getBestHeroByRid(heroId, "star")

	if hero then
		self:initForContentPanel(5, hero.gid)
	else
		self:initForContentPanel(1)
	end

	self.heroContentPanel:showStickEfx()
end

function HeroMainDlg:onBtnHeroInfoClick()
	if self.showState == HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO then
		self:refreshBtnHeroInfoShow(HERO_MAIN_DLG_SHOW_STATE.HERO_LIST)

		local backGid = self.heroContentPanel.hero and self.heroContentPanel.hero.gid or self.selectedHero.gid

		self:regularUpdateHeroCardList(backGid, nil, backGid)
		self.uiAni:startAni("HideHeroDetailWindow")

		if self.isZoomIn then
			self.isZoomIn = not self.isZoomIn

			self.imgZoom:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnZoomIn")
		end

		self.heroContentPanel:onPanelClose()
		self.modelStage:moveRotateCameraSmooth(HERO_STAGE_CAMERA_RIGHT, self.camInitRotation, STAGE_CAMERA_MOVE_DUR)

		if ResWindowMoneyConfig[self.mUIName] then
			self.panelFund:settingFund(ResWindowMoneyConfig[self.mUIName].moneys)
		end
	elseif self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_LIST then
		self:refreshBtnHeroInfoShow(HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO)
		self.heroContentPanel:selectTab(1)
		self.uiAni:startAni("ShowHeroDetailWindow")
		self.modelStage:moveRotateCameraSmooth(HERO_STAGE_CAMERA_LEFT, self.camInitRotation, STAGE_CAMERA_MOVE_DUR)

		if self.heroInfoFocusChild then
			self.heroInfoFocusChild:setVisible(false)
		end
	end

	self.passCheckCryFlag = nil

	GameSettings.setShadowDistance(SHADOW_DISTANCE_DEFAULT, "HeroMainDlg")
	self:_clearLookAtMode()
end

function HeroMainDlg:refreshBtnHeroInfoShow(btnFlag)
	self.showState = btnFlag

	if self.showState == HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO then
		self.btnClose:setText(Lang.get(1214))

		if self.selectedHero then
			self.heroContentPanel:refreshContentPanel(self.selectedHero.gid)
		end
	elseif self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_LIST then
		self.btnClose:setText(Lang.get(30343))
		self:delEquipWall()
	elseif self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_SKIN then
		self.btnClose:setText(Lang.get(1217))
		self:delEquipWall()
	end

	self:refreshImgStarAni()
end

function HeroMainDlg:setSelectHero(hero, idx)
	self.bgVoiceBullet:setVisible(false)

	local isSameHero = self.selectedHero ~= nil and self.selectedHero.gid == hero.gid or false

	self.curCardIdx = idx

	self.btnHeroNext:setVisible(idx < #self.sortedFilterList)
	self.btnHeroLast:setVisible(idx > 1)

	local isSameModel = self.selectedHero ~= nil and self.selectedHero:getShowModelId() == hero:getShowModelId()

	self.selectedHero = hero

	if isSameModel == false then
		if self.curModelInsId then
			self.autoRotateComponent = nil

			self.modelStage:delModel(self.curModelInsId)
		end

		local modelId = self.selectedHero:getShowModelId()
		local baseModelId = self.selectedHero:getShowBaseModelId()

		self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, baseModelId, true)

		if self.curModelInsId then
			self.modelStage:setOperateModel(self.curModelInsId)

			self.curHeroModelId = modelId
		end
	elseif not isSameHero then
		self:playShowAnimation(self.curModelInsId)

		if self.autoRotateComponent then
			self.autoRotateComponent:ResetRotate()
		end
	end

	if self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_SKIN and self.heroSkinPanel then
		self.heroSkinPanel:setHero(self.selectedHero, nil, true)
	end

	self.heroInfoPanel:setHero(self.selectedHero)
	self.heroContentPanel:refreshContentPanel()

	if not isSameHero and self:isInShow() then
		CueManager.stopVocal()
		CueManager.playHeroVocal(hero.id, Const.HERO_VOCAL_CHOOSE)

		if self.heroInfoPanel:getVisible() then
			local function showBullet(...)
				self.bgVoiceBullet:setVisible(true)
				self.bgVoiceBullet:startAni("ShowSubtitle")
			end

			local function closeBullet(...)
				self.bgVoiceBullet:startAni("HideSubtitle")
			end

			if not self.bulletShowTimer then
				self.bulletShowTimer = Timer.New(Slot(showBullet, self), 0.5, 1)
			end

			if not self.bulletCloseTimer then
				self.bulletCloseTimer = Timer.New(Slot(closeBullet, self), 4.5, 1)
			end

			self.bulletShowTimer:Stop()
			self.bulletCloseTimer:Stop()

			local voiceId = ClientUtils.getHeroVoiceIdByType(hero.id, Const.HERO_VOCAL_CHOOSE)

			if voiceId then
				local showState, desc = ClientUtils.checkCanShowVoCalBullet(voiceId)

				if showState and desc then
					self.txtVoiceBullet:setText(desc)
					self.bulletShowTimer:Restart()
					self.bulletCloseTimer:Restart()
				end
			end
		end
	end

	local heroZoomPos = UIConst.getHeroCamZoomPos(self.selectedHero) or HERO_STAGE_CAMERA_RIGHT_ZOOM_DEFAULT
	local zoomPosChanged = self.cameraRightZoomPos ~= nil and heroZoomPos ~= self.cameraRightZoomPos

	self.cameraRightZoomPos = heroZoomPos

	if self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_LIST and self.isZoomIn then
		if zoomPosChanged or self.camCurPosY and self.camCurPosY ~= 0 then
			self.modelStage:moveRotateCameraSmooth(self.cameraRightZoomPos, self.camInitRotation, 0)
		end

		self:_initLookAtPoint()
		self:_clearHentaiChecker()
	end

	GameSettings.setShadowDistance(SHADOW_DISTANCE_DEFAULT, "HeroMainDlg")

	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_RECOMMEND_TRAIN)

	self.btnRecommend:setVisible(not isLocked and not CurAvatar:checkGrowRecommendClose())
	self:_checkReddot()
	self:_checkBeginnerFocus()
	self.btnStarUp:setVisible(not hero:isUniqueHero())
	self.btnUniqueStarUp:setVisible(hero:isUniqueHero())
end

function HeroMainDlg:_checkReddot()
	for _, table in ipairs(REDDOT_TABLE) do
		if CurAvatar[table] and CurAvatar[table][self.selectedHero.gid] then
			self.imgCanUpgrade:setVisible(true)

			return
		end
	end

	if Const.PAINT_PLUS_OPEN then
		for _, table in ipairs(REDDOT_TABLE_HERO_ID) do
			if CurAvatar[table] and CurAvatar[table][self.selectedHero.id] then
				self.imgCanUpgrade:setVisible(true)

				return
			end
		end
	end

	if Const.HERO_STICK_LV_UP_OPEN then
		for _, table in ipairs(REDDOT_TABLE_STICK) do
			if CurAvatar[table] and CurAvatar[table][self.selectedHero.id] then
				self.imgCanUpgrade:setVisible(true)

				return
			end
		end
	end

	self.imgCanUpgrade:setVisible(false)
end

function HeroMainDlg:_checkBeginnerFocus()
	if self.showState ~= HERO_MAIN_DLG_SHOW_STATE.HERO_LIST then
		return
	end

	if self.beginnerFocusHero and self.selectedHero and self.selectedHero.gid == self.beginnerFocusHero.gid then
		if not self.heroInfoFocusChild then
			self.heroInfoFocusChild = RookieFocusChild(self, "BtnHeroInfo", "System/PlayerGuide/HighLightPanel", 0, 0)

			self.heroInfoFocusChild:focus(self.btnHeroInfo:getComObj().transform, Const.BEGINNER_LOSE_NOTICE[5])
		end

		self.heroInfoFocusChild:setVisible(true)
		self.heroGridCardList:beginnerFocusOneHero(nil)
	elseif self.heroInfoFocusChild then
		self.heroInfoFocusChild:setVisible(false)
	end
end

function HeroMainDlg:deleteOtherModel(modelInsId, modelResID)
	self.autoRotateComponent = ModelTool.addAutoRotateComponent(modelInsId)

	if modelResID then
		ModelTool.addBaseModel(modelInsId, modelResID, 1, Const.HERO_BASE_TYPE.Hero1)
	end

	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:SetAnimatorNoCulling()
			modelAux:PlayAnimatorNow("Newshow_idle")

			self.modelTransform = modelAux.transform
		end
	end
end

function HeroMainDlg:playShowAnimation(modelInsId)
	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:PlayAnimatorNow("Newshow_idle")
		end
	end
end

function HeroMainDlg:clearCardFilter()
	self.heroListFunPanel.toggleGroupTypeFilter = nil
	self.heroListFunPanel.filterCheckFunc = nil

	self.heroListFunPanel.filterTitleBtnPanel:setFilterClear()
end

function HeroMainDlg:showEquipWall()
	if self.showState == HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO then
		if self.equipWallPath then
			local newWallPath = self.selectedHero:getWallPath()

			if newWallPath ~= self.equipWallPath then
				self:delEquipWall()

				self.equipWallPath = newWallPath
				self.equipWallId = self.modelStage:showModelByModelData(self.equipWallPath, "", {
					x = -0.02,
					y = -0.09
				}, nil, 0.7, 1)
			end
		else
			self.equipWallPath = self.selectedHero:getWallPath()
			self.equipWallId = self.modelStage:showModelByModelData(self.equipWallPath, "", {
				x = -0.02,
				y = -0.09
			}, nil, 0.7, 1)
		end

		if self.seasonWallPath then
			local newLockSeasonWallPath = self.selectedHero:getSeasonRelicWallPath()

			if newLockSeasonWallPath ~= self.seasonWallPath then
				self:delLockSeasonWall()

				self.seasonWallPath = newLockSeasonWallPath

				if self.seasonWallPath then
					self.lockSeasonWallId = self.modelStage:showModelByModelData(self.seasonWallPath, "", {
						x = -0.02,
						y = -0.09
					}, nil, 0.7, 1)
				end
			end
		else
			self.seasonWallPath = self.selectedHero:getSeasonRelicWallPath()

			if self.seasonWallPath then
				self.lockSeasonWallId = self.modelStage:showModelByModelData(self.seasonWallPath, "", {
					x = -0.02,
					y = -0.09
				}, nil, 0.7, 1)
			else
				self:delLockSeasonWall()
			end
		end

		local bgmId = self.selectedHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_HERO_DLG)

		if bgmId then
			self:playLogicBGM(bgmId)
		end
	end
end

function HeroMainDlg:delLockSeasonWall()
	if self.lockSeasonWallId then
		self.modelStage:delModel(self.lockSeasonWallId)

		self.lockSeasonWallId = nil
		self.seasonWallPath = nil
	end
end

function HeroMainDlg:delEquipWall()
	if self.equipWallId then
		self.modelStage:delModel(self.equipWallId)

		self.equipWallId = nil
		self.equipWallPath = nil
	end

	self:delLockSeasonWall()
end

function HeroMainDlg:refreshHeroCardList(selectGid, selectIdx)
	self.sortedFilterList = self.heroListFunPanel:getSortedFilterList()

	self.heroGridCardList:setData(self.sortedFilterList, selectGid, selectIdx)
	self:refreshFocusHero()
	self:setClickCard(selectGid, selectIdx)
end

function HeroMainDlg:regularUpdateHeroCardList(selectGid, selectIdx, gidRefreshFor)
	self.sortedFilterList = self.heroListFunPanel:getNewSortedFilterList(gidRefreshFor)

	self.heroGridCardList:setData(self.sortedFilterList, selectGid, selectIdx)
	self:refreshFocusHero()
	self:setClickCard(selectGid, selectIdx)
	self.heroListFunPanel:refreshBagBlankNum()
end

function HeroMainDlg:refreshDetailForHero(gidRefreshFor, notSelect)
	self:refreshFocusHero()

	local isHave = false

	if gidRefreshFor and self.sortedFilterList then
		local listCount = #self.sortedFilterList

		for i = 1, listCount do
			if self.sortedFilterList[i].gid == gidRefreshFor then
				isHave = true
				self.sortedFilterList[i] = CurAvatar.heroDic[gidRefreshFor]

				break
			end
		end
	end

	if not notSelect then
		if isHave then
			self.heroGridCardList:setData(self.sortedFilterList, gidRefreshFor)
			self:setClickCard(gidRefreshFor)
		else
			self:setSelectHero(CurAvatar.heroDic[gidRefreshFor], 1)
		end
	end
end

function HeroMainDlg:refreshSkinPanel(needResetUI)
	if self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_SKIN and self.heroSkinPanel then
		self.heroSkinPanel:setHero(self.selectedHero, nil, nil, needResetUI)
	end

	self.heroContentPanel:refreshContentRedDot()
end

function HeroMainDlg:showSkinPanel()
	self.heroSkinPanel:resetPage()
	self.heroSkinPanel:setHero(self.selectedHero)
	self:refreshBtnHeroInfoShow(HERO_MAIN_DLG_SHOW_STATE.HERO_SKIN)
	self.uiAni:startAni("ShowHeroSkinWindow")
	self.modelStage:moveRotateCameraSmooth(HERO_STAGE_TO_SKIN, self.camInitRotation, STAGE_CAMERA_MOVE_DUR)
end

function HeroMainDlg:changeHeroSkin(modelId, baseId)
	if self.curHeroModelId and self.curHeroModelId == modelId then
		return
	end

	self.curHeroModelId = modelId

	local modelData = {}

	modelData.model_type = Const.MODEL_TYPE.ShowStepOne
	modelData.model_id = tonumber(modelId)

	if self.curModelInsId then
		self.autoRotateComponent = nil

		self.modelStage:delModel(self.curModelInsId)
	end

	self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, baseId, true)

	if self.curModelInsId then
		self.modelStage:setOperateModel(self.curModelInsId)
	end

	local ui = UIManager:getUI("homeBg", nil, false)

	if ui then
		ui:refreshModel()
	end
end

function HeroMainDlg:hideModel(isHide, ignoreAnim)
	self.modelControl:setVisible(not isHide)
	self.modelStage:setModelVisible(self.curModelInsId, not isHide)

	if not isHide and not ignoreAnim then
		self:playShowAnimation(self.curModelInsId)
	end
end

function HeroMainDlg:changeHeroBase(baseId)
	if self.curBaseModelId and self.curBaseModelId == baseId then
		return
	end

	self.curBaseModelId = baseId

	ModelTool.restModelPosition(self.curModelInsId)
	ModelTool.addBaseModel(self.curModelInsId, baseId, 1, Const.HERO_BASE_TYPE.Hero1)
end

function HeroMainDlg:setClickCard(selectGid, selectIdx)
	if selectGid then
		self.heroGridCardList:setClickCardByGid(selectGid)
	elseif selectIdx then
		self.heroGridCardList:setClickCardByIdx(selectIdx)
	end
end

function HeroMainDlg:setClickCardByResId(heroId)
	if heroId then
		self.heroGridCardList:setClickCardByResId(heroId)
	end
end

function HeroMainDlg:setClickCardUniqueHero()
	self.heroGridCardList:setClickCardUniqueHero()
end

function HeroMainDlg:setClickCardForReset()
	self.heroGridCardList:setClickCardForReset()
end

function HeroMainDlg:onHeroNextClick()
	if self.curCardIdx < #self.sortedFilterList then
		self.heroGridCardList:setClickCardByIdx(self.curCardIdx + 1)
	end
end

function HeroMainDlg:onHeroLastClick()
	if self.curCardIdx > 1 then
		self.heroGridCardList:setClickCardByIdx(self.curCardIdx - 1)
	end
end

function HeroMainDlg:onBtnRecommendClick()
	local heroGrowRecommendDlg = UIManager.getUI("heroGrowRecommendDlg", true)
end

function HeroMainDlg:onBtnHandBookClick()
	JumpGuideManager.jump(Const.HANDBOOK_JUMP_HERO_ID, "", self.selectedHero.id)
end

function HeroMainDlg:onBtnZoomClick()
	self.isZoomIn = not self.isZoomIn

	local sprite = self.isZoomIn and "BtnZoomOut" or "BtnZoomIn"

	self.imgZoom:setImage("Atlas/CommonAtlas/BtnAtlas2", sprite)

	local cameraPos = self.isZoomIn and self.cameraRightZoomPos or HERO_STAGE_CAMERA_RIGHT
	local shadowDistance = self.isZoomIn and SHADOW_DISTANCE_ZOOM or SHADOW_DISTANCE_DEFAULT

	GameSettings.setShadowDistance(shadowDistance, "HeroMainDlg")
	self.modelStage:moveRotateCameraSmooth(cameraPos, self.camInitRotation, STAGE_CAMERA_MOVE_DUR)

	if not self.isZoomIn then
		self:_clearLookAtMode()
	else
		self:delayInitLookAtMode()
	end
end

function HeroMainDlg:onBtnTipsClick()
	local noticeType = Const.INFO_NOTICE_HERO

	if self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_SKIN then
		noticeType = Const.INFO_NOTICE_HERO_SKIN
	end

	UIManager.getUI("infoNotice", true):showSystemInfo(noticeType)
end

function HeroMainDlg:onBtnCloseClick()
	local enjoyPanel = self.heroSkinPanel:getEnJoyPanel()

	if enjoyPanel and enjoyPanel.isAppreciate then
		enjoyPanel:outEnjoyClick()
	elseif self.showState == HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO then
		self:onBtnHeroInfoClick()
	elseif self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_SKIN then
		self:refreshBtnHeroInfoShow(HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO)
		self.heroSkinPanel:resetCurSel(true)
		self.heroSkinPanel:onCloseClick()

		if utils.getTableElemCount(self.heroContentPanel.panelList) == 0 then
			self.heroContentPanel:selectTab(Const.HERO_CONTENT_PANEL.BASE_INFO)
		end

		self.heroContentPanel:refreshContentRedDot()
		self.uiAni:startAni("HideHeroSkinWindow")
		self.modelStage:moveRotateCameraSmooth(HERO_STAGE_CAMERA_LEFT, self.camInitRotation, STAGE_CAMERA_MOVE_DUR)
	else
		self:setVisible(false)
	end
end

function HeroMainDlg:onDestroy()
	if self.heroContentPanel and self.heroContentPanel.timerRefreshHeroDlg then
		self.heroContentPanel.timerRefreshHeroDlg:Stop()

		self.heroContentPanel.timerRefreshHeroDlg = nil
	end

	if self.heroContentPanel and self.heroContentPanel.timerDelayPlaySkillUpEfx then
		self.heroContentPanel.timerDelayPlaySkillUpEfx:Stop()

		self.heroContentPanel.timerDelayPlaySkillUpEfx = nil
	end

	if self.heroContentPanel then
		self.heroContentPanel:onDlgDestroy()
	end

	if self.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.BASE_INFO] then
		self.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.BASE_INFO]:destroy()
	end

	if self.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP] then
		self.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]:destroy()
	end

	if self.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.STAGE_UP] then
		self.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.STAGE_UP]:destroy()
	end

	if self.heroGridCardList then
		self.heroGridCardList:clearCardEffectCor()
	end

	if self.heroSkinPanel and self.heroSkinPanel.pages[1] then
		self.heroSkinPanel.pages[1]:onDestroy()
	end

	if self.preModelLvUpEfxId then
		EffectManager:releaseEffect(self.preModelLvUpEfxId)

		self.preModelLvUpEfxId = nil
	end

	if self.bulletShowTimer then
		self.bulletShowTimer:Stop()
	end

	if self.bulletCloseTimer then
		self.bulletCloseTimer:Stop()
	end

	CueManager.stopVocal()
	HeroMainDlg.super.onDestroy(self)
end

function HeroMainDlg:onDragStart(...)
	if self.autoRotateComponent then
		self.autoRotateComponent:EndRotate()
	end

	self:_clearHentaiChecker()
end

function HeroMainDlg:onDragEnd(...)
	if self.autoRotateComponent then
		self.autoRotateComponent:StartRotate()
	end

	self.dragDirection = nil

	self:_checkHentaiCam()
end

function HeroMainDlg:onDrag(delta)
	local deltaX = math.abs(delta.x)
	local deltaY = math.abs(delta.y)

	if not self.dragDirection then
		if self.needCareVertical and deltaX < deltaY then
			self.dragDirection = "y"
		else
			self.dragDirection = "x"
		end
	end

	if not self.modelTransform then
		return
	end

	if self.dragDirection == "x" then
		local angles = self.modelTransform.eulerAngles

		angles.y = angles.y - delta.x * DRAG_ROTATE_SPEED
		self.modelTransform.eulerAngles = angles
	elseif self.stageCamera then
		self.camCurPosY = Mathf.Clamp(math.min(self.camCurPosY + DRAG_CAM_ROTATE_SPEED * delta.y, self.camLookAtDistance), self.DRAG_DOWN_LIMIT, self.DRAG_UP_LIMIT)

		local targetPosZ = self.camLookAtPos.z + self.camLookAtDistance * math.cos(math.asin(self.camCurPosY / self.camLookAtDistance))
		local targetPos = {
			[2] = self.camInitPos.y + self.camCurPosY
		}
		local rotateAngle = Vector3.Angle(self.camInitForward, self.camLookAtPos - Vector3(self.camInitPos.x, targetPos[2], self.camInitPos.z))
		local targetRotate

		if self.camCurPosY > 0 then
			targetRotate = {
				self.camInitAngle.x + rotateAngle,
				self.camInitAngle.y,
				self.camInitAngle.z
			}
		else
			targetRotate = {
				self.camInitAngle.x - rotateAngle,
				self.camInitAngle.y,
				self.camInitAngle.z
			}
		end

		self.modelStage:moveRotateCameraSmooth(targetPos, targetRotate, 0)
	end
end

function HeroMainDlg:delayInitLookAtMode()
	if self.initCamTimer then
		self.initCamTimer:Restart()
	else
		self.initCamTimer = Timer.New(Slot(self._initLookAtPoint, self), STAGE_CAMERA_MOVE_DUR, 1)

		self.initCamTimer:Start()
	end
end

function HeroMainDlg:_initLookAtPoint()
	self.stageCamera = self.modelStage:getCamera()
	self.needCareVertical = true

	if self.stageCamera then
		self.camCurPosY = 0
		self.camInitPos = self.stageCamera.transform.localPosition
		self.camLookAtDistance = self.DRAG_ANCHOR_DISTANCE
		self.camLookAtPos = Vector3(self.cameraRightZoomPos[1], self.cameraRightZoomPos[2], self.cameraRightZoomPos[3] - self.camLookAtDistance)
		self.camInitForward = self.camLookAtPos - self.camInitPos
		self.camInitAngle = self.stageCamera.transform.localRotation.eulerAngles

		local rotVector = self.stageCamera.transform.localRotation.eulerAngles

		self.camInitRotation = {
			rotVector.x,
			rotVector.y,
			rotVector.z
		}
	end
end

function HeroMainDlg:_clearLookAtMode(...)
	self.needCareVertical = nil

	if self.initCamTimer then
		self.initCamTimer:Stop()
	end

	self:_clearHentaiChecker()

	self.camInitRotation = nil
end

function HeroMainDlg:_checkHentaiCam(...)
	self:_clearHentaiChecker()

	if self.camCurPosY and self.camCurPosY <= self.DRAG_DOWN_LIMIT + 0.3 then
		self.hentaiCheckTimer = Timer.New(Slot(self._stopHentaiAct, self), HENTAI_ACTION_CD, 1)

		self.hentaiCheckTimer:Start()
	end
end

function HeroMainDlg:_stopHentaiAct()
	if self.curModelInsId then
		-- block empty
	end

	self.needCareVertical = nil

	self.modelStage:moveRotateCameraSmooth(self.cameraRightZoomPos, self.camInitRotation, STAGE_CAMERA_MOVE_DUR)
	self:delayInitLookAtMode()
end

function HeroMainDlg:_clearHentaiChecker(...)
	if self.hentaiCheckTimer then
		self.hentaiCheckTimer:Stop()

		self.hentaiCheckTimer = nil
	end
end

return HeroMainDlg
