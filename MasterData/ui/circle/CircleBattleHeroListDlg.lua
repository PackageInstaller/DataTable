-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleHeroListDlg.lua

local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local strClassName = "CircleBattleHeroListDlg"
local CircleBattleHeroListDlg = Class(strClassName, UIControls.Window)
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")

function CircleBattleHeroListDlg:ctor()
	self:initUI()
end

function CircleBattleHeroListDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.txtDes = UIControls.Label(self, "MainInfoPanel/ImgDes/TxtDes")

	self.txtDes:setText(ClientUtils.getClientNotice(551))

	self.cells = {}
	self.scrollHeroCard = UIControls.ScrollViewLoopV(self, "MainInfoPanel/HeroList")

	self.scrollHeroCard:addEventCellChanged(self.onHeroCardChanged)

	self.heroCardDataList = CurAvatar:getCircleBattleHeroList()
	self.filterList = self.heroCardDataList
	self.filterSelectPanel = FilterSelectPanel(self, "MainInfoPanel/ListSelectPanel")

	self.filterSelectPanel:setFilterData(UIConst.HERO_DEFAULT_FILTER_PANEL_MAP[1], Slot(self.filterHeroCard, self), 1)
	self.scrollHeroCard:setTotalCount(#self.heroCardDataList)

	self.canWearHeroDic = CurAvatar:checkCanWearRelicCBHero()
	self.actActive = false

	local actOj = CurAvatar:getCircleBattleActivity()

	if actOj and actOj:inOpenState() then
		self.actActive = true
	end
end

function CircleBattleHeroListDlg:refreshHeroList()
	self.heroCardDataList = CurAvatar:getCircleBattleHeroList()
	self.canWearHeroDic = CurAvatar:checkCanWearRelicCBHero()

	if self.filterCheckFunc then
		self:filterHeroCard(self.filterCheckFunc)
	else
		self.filterList = self.heroCardDataList

		self.scrollHeroCard:setTotalCount(#self.heroCardDataList)
	end
end

function CircleBattleHeroListDlg:onHeroCardChanged(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.HeroCardLoop(sender, "System/Hero/GridHeroCard", newIdx, 0, 0)

	if not self.filterList or #self.filterList == 0 then
		return
	end

	if self.filterList[newIdx] ~= nil then
		targetCell:setHero(self.filterList[newIdx])

		targetCell.mIndex = newIdx

		targetCell:setSelectCallback(Slot(self.onHeroCellClick, self))

		if self.actActive then
			targetCell.imgCanUpgrade:setVisible(self.canWearHeroDic[self.filterList[newIdx].gid] ~= nil)
		else
			targetCell.imgCanUpgrade:setVisible(false)
		end
	end

	self.cells[newIdx] = targetCell
end

function CircleBattleHeroListDlg:filterHeroCard(filterCheckFunc, toggleGroupTypeFilter, forSwitchGrowth)
	self.filterCheckFunc = filterCheckFunc
	self.toggleGroupTypeFilter = toggleGroupTypeFilter

	local tempFilterList = {}

	for _, hero in ipairs(self.heroCardDataList) do
		if self.filterCheckFunc(hero) then
			table.insert(tempFilterList, hero)
		end
	end

	self.filterList = tempFilterList

	self.scrollHeroCard:setTotalCount(#self.filterList, 1)
end

function CircleBattleHeroListDlg:onHeroCellClick(sender)
	local ui = UIManager.getUI("circleBattleHeroInfoDlg")

	ui:setData(self.filterList, sender.mIndex)
	ui:showForCircleBattle()
end

function CircleBattleHeroListDlg:setHeroCardData(heroCardDataList)
	self.heroCardDataList = heroCardDataList
end

function CircleBattleHeroListDlg:onBtnCloseClick()
	self:setVisible(false)
end

function CircleBattleHeroListDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_CIRCLE_BATTLE_HERO_LIST)
end

function CircleBattleHeroListDlg:destroy()
	CircleBattleHeroListDlg.super.destroy(self)
	CircleControlCenter.checkEvent()
end

return CircleBattleHeroListDlg
