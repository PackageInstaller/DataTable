-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\HeroStarUpDlg.lua

local StarUpExchangePanel = require("UI/Hero/StarUp/StarUpExchangePanel")
local ModelTool = require("Entity/ModelTool")
local BtnHeroChoose = require("UI/Hero/StarUp/BtnHeroChoose")
local ResItem = require("ClientData/ResItem")
local strClassName = "HeroStarUpDlg"
local STARUP_STAGE_CAMERA_FAR = {
	10.8,
	19.39,
	117.53
}
local STARUP_STAGE_CAMERA_NEAR_LEFT = {
	11.26,
	17.32,
	109.7
}
local STARUP_STAGE_CAMERA_NEAR = {
	13.44,
	17.32,
	109.7
}
local GRID_SORT_STATUS_NONE = 0
local GRID_SORT_STATUS_SAME_STAR = 1
local GRID_SORT_STATUS_SAME_ID = 2
local GRID_SORT_STATUS_BEMATERIAL = 3
local HeroStarUpDlg = Class(strClassName, UIControls.Window)

function HeroStarUpDlg:ctor()
	self:initUI()

	self._slot4LoadNewModelEnd = Slot(self.loadNewModel, self)
end

function HeroStarUpDlg:initUI()
	self.cells = {}
	self.txtRule = UIControls.Label(self, "TextRule")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.imgBgPoint = UIControls.Image(self, "BgHeroList/BgPoint")
	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/HeroStarUpDlgModelStage")
	self.btnGroupList = {}
	self.btnGroupAll = UIControls.Button(self, "BgHeroList/ListSelectPanel/BtnAll")

	self.btnGroupAll:addEventClick(self.onBtnGroupClick)

	self.btnRevertGuide = UIControls.Button(self, "BgHeroList/BtnRevertGuide")

	self.btnRevertGuide:addEventClick(self.onBtnRevertGuideClick)

	self.guideReasonData = CurAvatar:canShowStarRevertHelp()

	self.btnRevertGuide:setVisible(self.guideReasonData ~= nil)
	table.insert(self.btnGroupList, self.btnGroupAll)

	self.imgRecommedCampList = {}

	for i = 1, 5 do
		self["btnGroup" .. i] = UIControls.Button(self, "BgHeroList/ListSelectPanel/Btn" .. i)

		self["btnGroup" .. i]:addEventClick(self.onBtnGroupClick)
		table.insert(self.btnGroupList, self["btnGroup" .. i])

		self["imgRecommedCamp" .. i] = UIControls.Image(self, "BgHeroList/ListSelectPanel/Btn" .. i .. "/ImgRecommend")
		self.imgRecommedCampList[i] = self["imgRecommedCamp" .. i]
	end

	self.panelBtn = UIControls.Panel(self, "BgHeroList/BtnPanel")
	self.btnStarUpFast = UIControls.Button(self, "BgHeroList/BtnPanel/BtnStarUpFast")

	self.btnStarUpFast:addEventClick(self.onBtnStarUpFastClick)

	self.btnStarUpRevert = UIControls.Button(self, "BgHeroList/BtnPanel/BtnStarUpRevert")

	self.btnStarUpRevert:addEventClick(self.onBtnStarUpRevertClick)

	self.btnStarUpIntel = UIControls.Button(self, "BgHeroList/BtnPanel/BtnStarUpIntelligent")

	self.btnStarUpIntel:addEventClick(self.onBtnStarUpIntelClick)

	self.exchangePanel = StarUpExchangePanel(self, "ExchangePanel")
	self.bgHeroListPanel = UIControls.Panel(self, "BgHeroList")
	self.scrollHero = UIControls.ScrollViewLoopV(self, "BgHeroList/HeroChooseList")

	self.scrollHero:addEventCellChanged(self.onHeroChooseChanged)
end

function HeroStarUpDlg:onOpen()
	HeroStarUpDlg.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)
end

function HeroStarUpDlg:onWindowInit()
	HeroStarUpDlg.super.onWindowInit(self)
	self:onBtnGroupClick(self.btnGroupAll)
end

function HeroStarUpDlg:showUIPanel(isShow)
	self.exchangePanel:setVisible(isShow)
	self.bgHeroListPanel:setVisible(isShow)
	self.btnClose:setVisible(isShow)
	self.btnTips:setVisible(isShow)
	self.panelFund:setVisible(isShow)
	self.txtRule:setVisible(isShow)

	if isShow then
		self.modelStage:moveCameraSmooth(STARUP_STAGE_CAMERA_FAR, 0.5)
	end
end

function HeroStarUpDlg:playHeroStarUp()
	self:timerStarUpFinishFunc()
end

function HeroStarUpDlg:timerStarUpFinishFunc()
	self.modelStage:moveCameraSmooth(STARUP_STAGE_CAMERA_NEAR_LEFT, 0)
end

function HeroStarUpDlg:_modelPlayStarUpEfx()
	if self.preModelFallEfxId then
		EffectManager:releaseEffect(self.preModelFallEfxId)

		self.preModelFallEfxId = nil
	end

	local model = self.modelStage:getModel(self.curModelInsId)

	if model and self.modelHero.star >= 5 then
		local prefabPath = ""

		prefabPath = self.modelHero.star >= 10 and "Effects/UI/efx_ui_Fall_IconStar10.prefab" or "Effects/UI/efx_ui_Fall_IconStar0" .. self.modelHero.star .. ".prefab"
		self.preModelFallEfxId = EffectManager:playTransformEffect(model.transform, prefabPath, Const.EFFECT_LIFE_MODE.LogicControl)
	end
end

function HeroStarUpDlg:_playFinishUIEfx()
	local heroStarUpFinishDlg = UIManager.getUI("heroStarUpFinishDlg", nil, false)

	if heroStarUpFinishDlg then
		heroStarUpFinishDlg:_playStarUpEfx()
	end
end

function HeroStarUpDlg:destroy()
	HeroStarUpDlg.super.destroy(self)

	if self.starUpEfxFinishTimer then
		self.starUpEfxFinishTimer:Stop()

		self.starUpEfxFinishTimer = nil
	end

	if self.starUpEfxTimer then
		self.starUpEfxTimer:Stop()

		self.starUpEfxTimer = nil
	end

	if self.preModelDisappearEfxId then
		EffectManager:releaseEffect(self.preModelDisappearEfxId)

		self.preModelDisappearEfxId = nil
	end

	if self.preModelFallEfxId then
		EffectManager:releaseEffect(self.preModelFallEfxId)

		self.preModelFallEfxId = nil
	end
end

function HeroStarUpDlg:onClose()
	CurAvatar.cacheEatsMaterialHeros = {}

	HeroStarUpDlg.super.onClose(self)
end

function HeroStarUpDlg:onHeroChooseChanged(sender, targetCell, newIdx)
	targetCell = targetCell or BtnHeroChoose(sender, "System/StarUp/BtnHeroChoose", newIdx)

	if not self.heroList or #self.heroList == 0 then
		return
	end

	if self.heroList[newIdx] ~= nil then
		targetCell:setHero(self.heroList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

function HeroStarUpDlg:onBtnGroupClick(sender)
	for idx, btn in ipairs(self.btnGroupList) do
		btn:setEnable(btn ~= sender)

		if btn == sender then
			self.filterGroup = idx - 1

			if idx > 1 then
				self["imgRecommedCamp" .. idx - 1]:setVisible(false)
			end
		elseif idx > 1 and self.exchangePanel.hero and self.exchangePanel.hero.camp == idx - 1 then
			self["imgRecommedCamp" .. idx - 1]:setVisible(true)
		end
	end

	self.heroList = nil

	self:refreshHeroList()
end

function HeroStarUpDlg:onBtnRevertGuideClick()
	local starUpRevertGuideDlg = UIManager.getUI("starUpRevertGuideDlg", true)

	starUpRevertGuideDlg:initByGuideData(self.guideReasonData)
end

function HeroStarUpDlg:refreshHeroList(regular, idx)
	if not self.heroList or regular then
		self.heroList = nil

		self:initHeroList()
	end

	self.scrollHero:setTotalCount(#self.heroList, regular and 1 or idx)
	self.imgBgPoint:setVisible(self.exchangePanel.hero == nil and CurAvatar and not CurAvatar:isHaveUpSomeOneStar(7))

	self.guideReasonData = CurAvatar:canShowStarRevertHelp()

	self.btnRevertGuide:setVisible(self.btnStarUpRevert:getVisible() and self.guideReasonData ~= nil)
end

local function _heroListSortFuncByStatus(a, b)
	if a.status ~= b.status then
		return a.status > b.status
	elseif a.level ~= b.level then
		return a.level < b.level
	elseif a.quality ~= b.quality then
		return a.quality < b.quality
	elseif a.id ~= b.id then
		return a.id > b.id
	end
end

function HeroStarUpDlg:setHeroToExchagngePanel(hero)
	self:showHeroModel(hero)
	self.exchangePanel:setHero(hero)
	self.exchangePanel:setVisible(true)
	self:refreshHeroList()

	if self.exchangePanel.hero and self["imgRecommedCamp" .. self.exchangePanel.hero.camp] and self.exchangePanel.hero.camp ~= self.filterGroup then
		self["imgRecommedCamp" .. self.exchangePanel.hero.camp]:setVisible(true)
	end
end

function HeroStarUpDlg:showHeroModel(hero)
	self.modelHero = hero

	if self.curModelInsId then
		self.modelStage:delModel(self.curModelInsId)
	end

	local modelId = hero:getShowModelId()
	local baseModelId = hero:getShowBaseModelId()

	self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, baseModelId)
end

function HeroStarUpDlg:delHeroModel()
	if self.curModelInsId then
		self.modelStage:delModel(self.curModelInsId)

		self.curModelInsId = nil
	end
end

function HeroStarUpDlg:loadNewModel(modelInsId, modelResID)
	self.curModelInsId = modelInsId

	ModelTool.modelPlayAnimationNow(modelInsId, "Newshow_idle")

	if modelResID then
		ModelTool.addBaseModel(modelInsId, modelResID, 1, Const.HERO_BASE_TYPE.Hero1)
	end

	self.modelStage:setTonemapping(self.curModelInsId, true)
end

local function _heroListSortFunc(a, b)
	if a.canStarUp ~= b.canStarUp then
		return a.canStarUp > b.canStarUp
	elseif a.star ~= b.star then
		return a.star > b.star
	elseif a.level ~= b.level then
		return a.level > b.level
	elseif a.camp ~= b.camp then
		return a.camp > b.camp
	elseif a.id ~= b.id then
		return a.id > b.id
	else
		return a.gid > b.gid
	end
end

function HeroStarUpDlg:refreshForHero(hero)
	for i, _ in ipairs(self.heroList) do
		local fakeHero = BaseObject.CopyObject(hero)

		fakeHero:initCrystalData()

		fakeHero.canStarUp = fakeHero:canStarUp() and 1 or 0
		self.heroList[i] = fakeHero
	end

	self:refreshHeroList()
end

function HeroStarUpDlg:initHeroList()
	self.heroList = {}

	local mDict, nDict, xDict = CurAvatar:getStarUpLimitParm()

	for _, hero in pairs(CurAvatar.heroDic) do
		if (self.filterGroup == 0 or self.filterGroup == hero.camp) and hero.resData.ori_star < hero:getMaxStar() and not hero:isUniqueHero() then
			local fakeHero = BaseObject.CopyObject(hero)

			fakeHero:initCrystalData()

			if CurAvatar:checkCanStarUp(hero, mDict, xDict) then
				fakeHero.canStarUp = fakeHero:canStarUp() and 1 or 0
			else
				fakeHero.canStarUp = 0
			end

			table.insert(self.heroList, fakeHero)
		end
	end

	table.sort(self.heroList, _heroListSortFunc)
	self.btnStarUpFast:setVisible(#CurAvatar:getFastStarUpHeroList(true) > 0)
	self.btnStarUpIntel:setVisible(not self.btnStarUpFast:getVisible() and #CurAvatar:getIntelStarUpHeroList(true) > 0)

	if not self.btnStarUpIntel:getVisible() and not self.btnStarUpFast:getVisible() then
		self.btnStarUpIntel:setVisible(#CurAvatar:getSuperIntelStarUpHeroList() > 0)
	end

	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_STAR_UP_REVERT)

	self.btnStarUpRevert:setVisible(not isLocked)
	self.panelBtn:setVisible(self.btnStarUpRevert:getVisible() or self.btnStarUpIntel:getVisible() or self.btnStarUpFast:getVisible())
end

function HeroStarUpDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HERO_STARUP)
end

function HeroStarUpDlg:onBtnStarUpFastClick()
	local heroStarUpFastDlg = UIManager.getUI("heroStarUpFastDlg", true)

	heroStarUpFastDlg:initHeroList()
end

function HeroStarUpDlg:onBtnStarUpIntelClick()
	local heroStarUpFastDlg = UIManager.getUI("heroStarUpFastDlg", true)

	heroStarUpFastDlg:initHeroList(true)
end

function HeroStarUpDlg:onBtnStarUpRevertClick()
	local heroStarUpRevertDlg = UIManager.getUI("heroStarUpRevertDlg", true)

	heroStarUpRevertDlg:initHeroList()
end

function HeroStarUpDlg:isLastAsyncFormationHero(hero)
	local asyncCount = utils.getTableElemCount(CurAvatar.asyncPVPDefendFormation)
	local preAsyncCount = 0

	for materialType, gridList in pairs(self.exchangePanel.gridMaterials) do
		for _, grid in ipairs(gridList) do
			if grid.realHero and CurAvatar.asyncPVPDefendFormation[grid.realHero.gid] then
				preAsyncCount = preAsyncCount + 1
			end
		end
	end

	if preAsyncCount == asyncCount - 1 and CurAvatar.asyncPVPDefendFormation[hero.gid] then
		return true
	end

	return false
end

function HeroStarUpDlg:onBtnCloseClick()
	self:setVisible(false)
end

return HeroStarUpDlg
