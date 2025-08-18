-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\AllHero\\HeroAllDlg.lua

local strClassName = "HeroAllDlg"
local HeroAllGridCardList = require("UI/Hero/AllHero/HeroAllGridCardList")
local HeroInfoPanel = require("UI/Hero/HeroInfoPanel")
local HeroAllListFunPanel = require("UI/Hero/AllHero/HeroAllListFunPanel")
local HeroContentPanel = require("UI/Hero/AllHero/HeroAllContentPanel")
local ModelTool = require("Entity/ModelTool")
local HERO_ATLAS = "Atlas/HeroAtlas/HeroAtlas"
local HERO_MAIN_DLG_SHOW_STATE = {
	HERO_LIST = 0,
	DETAIL_INFO = 1
}
local ModelFactory = Framework.Entity.ModelFactory
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local HeroAllDlg = Class(strClassName, UIControls.Window)

function HeroAllDlg:ctor()
	self:initUI()

	self._slot4LoadNewModelEnd = Slot(self.deleteOtherModel, self)
end

function HeroAllDlg:initUI()
	self.pnlCommonFuncEntry = CommonFuncEntryPanel(self, "CommonFuncEntryPanel", "System/MainMenu/CommonFuncEntryPanel", 0, 0, true)

	self.pnlCommonFuncEntry:settingFund({
		Const.MONEY_ID_GOLD,
		Const.MONEY_ID_DIAMOND,
		500000
	})

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.heroInfoPanel = HeroInfoPanel(self, "HeroInfoPanel")
	self.heroContentPanel = HeroContentPanel(self, "HeroContentPanel")

	for index, btn in ipairs(self.heroContentPanel.btnTypeList) do
		btn:setVisible(index == 1)
	end

	self.heroListPanel = UIControls.Panel(self, "HeroListPanel")
	self.heroGridCardList = HeroAllGridCardList(self, "HeroListPanel/HeroList")
	self.heroListFunPanel = HeroAllListFunPanel(self, "HeroListPanel/ListFunPanel")
	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/HeroDlgModelStage")
	self.modelControl = UIControls.Panel(self, "ModelControl")

	self.modelStage:initOperation(self.modelControl)

	self.modelStage.mEventOprFingerDown = Slot(self.onDragStart, self)
	self.modelStage.mEventOprFingerUp = Slot(self.onDragEnd, self)
	self.btnHeroInfo = UIControls.Button(self, "BtnHeroInfo", "Text")

	self.btnHeroInfo:addEventClick(self.onBtnHeroInfoClick)

	self.btnHeroNext = UIControls.Button(self, "BtnHeroNext")

	self.btnHeroNext:addEventClick(self.onHeroNextClick)

	self.btnHeroLast = UIControls.Button(self, "BtnHeroLast")

	self.btnHeroLast:addEventClick(self.onHeroLastClick)

	self.uiAni = UIControls.UIAni(self, "")

	if CurAvatar then
		self.currentEntity = CurAvatar
	end
end

function HeroAllDlg:initForHeroList(selectHeroId)
	self:refreshBtnHeroInfoShow(HERO_MAIN_DLG_SHOW_STATE.HERO_LIST)

	if selectHeroId then
		self:regularUpdateHeroCardList(selectHeroId)
	else
		self:regularUpdateHeroCardList(nil, 1)
	end
end

function HeroAllDlg:initForContentPanel(contentPanelType, selectHeroId)
	self:refreshBtnHeroInfoShow(HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO)
	self:regularUpdateHeroCardList(selectHeroId)
	self.uiAni:startAni("ShowHeroDetailWindow2")
	self.heroContentPanel:selectTab(contentPanelType)
end

function HeroAllDlg:onOpen()
	HeroAllDlg.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)
end

function HeroAllDlg:onClose(...)
	CueManager.stopVocal()
	HeroAllDlg.super.onClose(self)
end

function HeroAllDlg:onBtnHeroInfoClick()
	if self.showState == HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO then
		self:refreshBtnHeroInfoShow(HERO_MAIN_DLG_SHOW_STATE.HERO_LIST)

		local backId = self.heroContentPanel.hero and self.heroContentPanel.hero.id or self.selectedHero.id

		self:regularUpdateHeroCardList(backId, nil)
		self.uiAni:startAni("HideHeroDetailWindow")
	elseif self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_LIST then
		self:refreshBtnHeroInfoShow(HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO)
		self.heroContentPanel:initSelectTab()
		self.uiAni:startAni("ShowHeroDetailWindow")
	end
end

function HeroAllDlg:refreshBtnHeroInfoShow(btnFlag)
	self.showState = btnFlag

	if self.showState == HERO_MAIN_DLG_SHOW_STATE.DETAIL_INFO then
		self.btnHeroInfo:setText(Lang.get(30343))
	elseif self.showState == HERO_MAIN_DLG_SHOW_STATE.HERO_LIST then
		self.btnHeroInfo:setText(Lang.get(366))
		self.heroInfoPanel:setVisible(true)
	end
end

function HeroAllDlg:setSelectHero(hero, idx)
	local isSameHero = self.selectedHero ~= nil and self.selectedHero.id == hero.id or false

	self.curCardIdx = idx

	self.btnHeroNext:setVisible(idx ~= #self.sortedFilterList)
	self.btnHeroLast:setVisible(idx ~= 1)

	local isSameModel = self.selectedHero ~= nil and self.selectedHero.resData.model == hero.resData.model

	self.selectedHero = hero

	if isSameModel == false then
		if self.curModelInsId then
			self.autoRotateComponent = nil

			self.modelStage:delModel(self.curModelInsId)
		end

		local modelId = self.selectedHero:getShowModelId()
		local baseModelId = self.selectedHero:getShowBaseModelId()

		self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, baseModelId)

		if self.curModelInsId then
			self.modelStage:setOperateModel(self.curModelInsId)
		end
	elseif not isSameHero then
		self:playShowAnimation(self.curModelInsId)

		if self.autoRotateComponent then
			self.autoRotateComponent:ResetRotate()
		end
	end

	self.heroInfoPanel:setHero(self.selectedHero)
	self.heroContentPanel:refreshContentPanel()
end

function HeroAllDlg:deleteOtherModel(modelInsId, modelResID)
	self.autoRotateComponent = ModelTool.addAutoRotateComponent(modelInsId)

	if modelResID then
		ModelTool.addBaseModel(modelInsId, modelResID, 1, Const.HERO_BASE_TYPE.Hero1)
	end

	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:SetAnimatorNoCulling()
			modelAux:PlayAnimator("Show")
		end
	end
end

function HeroAllDlg:playShowAnimation(modelInsId)
	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:PlayAnimator("Show")
		end
	end
end

function HeroAllDlg:refreshHeroCardList(selectHeroId, selectIdx)
	self.sortedFilterList = self.heroListFunPanel:getSortedFilterList()

	self.heroGridCardList:setData(self.sortedFilterList, selectHeroId, selectIdx)
	self:setClickCard(selectHeroId, selectIdx)
end

function HeroAllDlg:regularUpdateHeroCardList(heroId, selectIdx)
	self.sortedFilterList = self.heroListFunPanel:getNewSortedFilterList()

	self.heroGridCardList:setData(self.sortedFilterList, heroId, selectIdx)
	self:setClickCard(heroId, selectIdx)
end

function HeroAllDlg:setClickCard(selectHeroId, selectIdx)
	if selectHeroId then
		self.heroGridCardList:setClickCardByGid(selectHeroId)
	elseif selectIdx then
		self.heroGridCardList:setClickCardByIdx(selectIdx)
	end
end

function HeroAllDlg:setClickCardByResId(heroId)
	if heroId then
		self.heroGridCardList:setClickCardByResId(heroId)
	end
end

function HeroAllDlg:onDragStart(...)
	if self.autoRotateComponent then
		self.autoRotateComponent:EndRotate()
	end
end

function HeroAllDlg:onDragEnd(...)
	if self.autoRotateComponent then
		self.autoRotateComponent:StartRotate()
	end
end

function HeroAllDlg:onHeroNextClick()
	if self.curCardIdx < #self.sortedFilterList then
		self.heroGridCardList:setClickCardByIdx(self.curCardIdx + 1)
	end
end

function HeroAllDlg:onHeroLastClick()
	if self.curCardIdx > 1 then
		self.heroGridCardList:setClickCardByIdx(self.curCardIdx - 1)
	end
end

function HeroAllDlg:onCloseClick()
	CueManager.stopVocal()
	self:setVisible(false)
end

return HeroAllDlg
