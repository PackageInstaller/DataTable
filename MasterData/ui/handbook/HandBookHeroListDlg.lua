-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookHeroListDlg.lua

local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local FilterBtnSelPanel = require("UI/MainState/FilterBtnSelPanel")
local HandBookHeroCard = require("UI/HandBook/HandBookHeroCard")
local strClassName = "HandBookHeroListDlg"
local HandBookHeroListDlg = Class(strClassName, UIControls.Window)

function HandBookHeroListDlg:ctor()
	self:initUI()
end

function HandBookHeroListDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnRewardCollection = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnRewardCollection")

	self.btnRewardCollection:addEventClick(self.onBtnRewardCollectionClick)

	self.scrollCard = UIControls.ScrollViewLoopV(self, "MainInfoPanel/HeroList", 0, self._initItem)
	self.cards = {}
	self.btnGrowth = UIControls.Button(self, "BtnGrowth")

	self.btnGrowth:addEventClick(self.onBtnGrowthClick)

	self.animatorBtnSwitch = UIControls.Panel(self, "MainInfoPanel/BtnGrowth/Img")

	self.animatorBtnSwitch:playAnimator("BtnSwitchOff")

	self.isShowGrowth = false
	self.cardItemList = CurAvatar:getHandBookHeroList(self.isShowGrowth)
	self.filterList = self.cardItemList
	self.idGrowthestHeroDic = CurAvatar:getIdGrowthestHeroDic()

	self.scrollCard:setTotalCount(#self.filterList)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.uiAni = UIControls.UIAni(self, "MainInfoPanel/HeroList")

	self.uiAni:addEventAnimateCue(self.switchGrowthCue)

	local handBookRD = UIControls.RedDot(self, "MainInfoPanel/ListFunPanel/BtnRewardCollection/IconNew")

	handBookRD:addHint({
		UIConst.RD_HINT_HANDBOOK_AWARD
	})

	self.filterSelectPanel = FilterSelectPanel(self, "MainInfoPanel/ListSelectPanel")
	self.filterBtnSelPanel = FilterBtnSelPanel(self, "MainInfoPanel/SelPanel", self.filterSelectPanel, nil, Slot(self.filterHeroCard, self), UIConst.HANDBOOK_FILTER_PANEL_MAP)

	self.filterBtnSelPanel:initBtnSelPanel()
end

function HandBookHeroListDlg:switchGrowthCue(aniCom, eventKey)
	if eventKey == "ChangeHandBookHeroList" then
		self.idGrowthestHeroDic = CurAvatar:getIdGrowthestHeroDic()
		self.cardItemList = CurAvatar:getHandBookHeroList(self.isShowGrowth)

		if self.filterCheckFunc then
			self:filterHeroCard(self.filterCheckFunc, self.toggleGroupTypeFilter, true)
		else
			self.filterList = self.cardItemList

			self.scrollCard:setTotalCount(#self.filterList)
		end
	end
end

function HandBookHeroListDlg:onBtnGrowthClick()
	self.isShowGrowth = not self.isShowGrowth

	for _, card in pairs(self.cards) do
		card:stopUIEffect()
	end

	if not self.isShowGrowth then
		self.animatorBtnSwitch:playAnimator("BtnSwitchSetOff")
		self.uiAni:startAni("ChangeHandBookHeroList", true)
	else
		self.animatorBtnSwitch:playAnimator("BtnSwitchSetOn")
		self.uiAni:startAni("ChangeHandBookHeroList", true)
	end
end

function HandBookHeroListDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HANDBOOK_HERO)
end

function HandBookHeroListDlg:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or HandBookHeroCard(sender, "System/Hero/GridHeroCard", newIdx)

	if not self.filterList or #self.filterList == 0 then
		return
	end

	if self.filterList[newIdx] ~= nil then
		targetCell.isPlayEffect = true

		targetCell:_setHero(self.filterList[newIdx])
		targetCell:setSelectCallback(Slot(self.heroCardOnClick, self))
	end

	self.cards[newIdx] = targetCell
end

function HandBookHeroListDlg:onBtnRewardCollectionClick()
	local handBookAwardDlg = UIManager.getUI("handBookAwardDlg", true)

	if handBookAwardDlg then
		-- block empty
	end
end

function HandBookHeroListDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HandBookHeroListDlg:heroCardOnClick(card)
	local handBookHeroInfoDlg = UIManager.getUI("handBookHeroInfoDlg", true)

	if handBookHeroInfoDlg then
		handBookHeroInfoDlg:setHero(card.hero, self.filterList)
	end
end

function HandBookHeroListDlg:filterHeroCard(filterCheckFunc, toggleGroupTypeFilter, forSwitchGrowth)
	self.filterCheckFunc = filterCheckFunc
	self.toggleGroupTypeFilter = toggleGroupTypeFilter

	local tempFilterList = {}

	for _, hero in ipairs(self.cardItemList) do
		if self.filterCheckFunc(hero) then
			table.insert(tempFilterList, hero)
		end
	end

	self.filterList = tempFilterList

	if forSwitchGrowth then
		self.scrollCard:setTotalCount(#self.filterList)
	else
		self.scrollCard:setTotalCount(#self.filterList, 1)
	end
end

return HandBookHeroListDlg
