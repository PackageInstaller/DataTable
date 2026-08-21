-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeHeroListDlg.lua

local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local HeroGridSolderCard = require("UI/NewMaze/HeroGridSolderCard")
local NewMazeLosderGrid = require("UI/NewMaze/NewMazeLosderGrid")
local NewMazeLosderTipsInfoPanel = require("UI/NewMaze/NewMazeLosderTipsInfoPanel")
local NewMazeLosderMixin = require("UI/NewMaze/NewMazeLosderMixin")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local strClassName = "NewMazeHeroListDlg"
local NewMazeHeroListDlg = Class(strClassName, UIControls.Window)

MixinClass(NewMazeHeroListDlg, NewMazeLosderMixin)

function NewMazeHeroListDlg:ctor()
	self:ctorMixin()
	self:initUI()
end

function NewMazeHeroListDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.txtDes = UIControls.Label(self, "MainInfoPanel/ImgDes/TxtDes")

	self.txtDes:setText(ClientUtils.getClientNotice(658))

	self.cells = {}
	self.scrollHeroCard = UIControls.ScrollViewLoopV(self, "MainInfoPanel/HeroList")

	self.scrollHeroCard:addEventCellChanged(self.onHeroCardChanged)

	self.filterSelectPanel = FilterSelectPanel(self, "MainInfoPanel/ListSelectPanel")

	self.filterSelectPanel:setFilterData(UIConst.HERO_DEFAULT_FILTER_PANEL_MAP[1], Slot(self.filterHeroCard, self), 1)

	self.btnHandBook = UIControls.Button(self, "MainInfoPanel/BtnHandbook")

	self.btnHandBook:addEventClick(self.onBtnHandBookClick)
	self.btnHandBook:setVisible(Const.OPEN_NEW_MAZE_TALENT)
end

function NewMazeHeroListDlg:refreshHeroList()
	self.heroCardDataList = self.newMazeData:initAllHeros(true)
	self.canWearRelicHeros = self.newMazeData:checkCanWearRelicNewMazeHero()

	if self.filterCheckFunc then
		self:filterHeroCard(self.filterCheckFunc)
	else
		self.filterList = self.heroCardDataList

		self.scrollHeroCard:setTotalCount(#self.heroCardDataList)
	end
end

function NewMazeHeroListDlg:setData()
	self.actActive = false
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		self.newMazeData = self.actObj.actData

		if self.actObj:inOpenState() then
			self.actActive = true
		end
	else
		return
	end

	self.heroCardDataList = self.newMazeData:initAllHeros(true)
	self.canWearRelicHeros = self.newMazeData:checkCanWearRelicNewMazeHero()
	self.filterList = self.heroCardDataList

	self.scrollHeroCard:setTotalCount(#self.heroCardDataList)
	self:refreshFettersUI()
end

function NewMazeHeroListDlg:getShowHeroList()
	local allHeroList = self.newMazeData:initAllHeros(true)
	local heroList = {}

	for i, hero in pairs(allHeroList) do
		if not utils.tableIsContainsElement(self.newMazeData.assistHeroIds, hero.id) then
			table.insert(heroList, hero)
		end
	end

	return heroList
end

function NewMazeHeroListDlg:onHeroCardChanged(sender, targetCell, newIdx)
	targetCell = targetCell or HeroGridSolderCard(sender, "System/Hero/GridHeroCardSolder", newIdx, 0, 0)

	if not self.filterList or #self.filterList == 0 then
		return
	end

	if self.filterList[newIdx] ~= nil then
		targetCell:setHero(self.filterList[newIdx])
		targetCell:setFormation()

		targetCell.mIndex = newIdx

		if self.actActive then
			targetCell.imgCanUpgrade:setVisible(self.canWearRelicHeros[self.filterList[newIdx].gid] ~= nil)
		else
			targetCell.imgCanUpgrade:setVisible(false)
		end

		targetCell:setSelectCallback(Slot(self.onHeroCellClick, self))
	end

	self.cells[newIdx] = targetCell
end

function NewMazeHeroListDlg:filterHeroCard(filterCheckFunc, toggleGroupTypeFilter, forSwitchGrowth)
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

function NewMazeHeroListDlg:onHeroCellClick(sender)
	local hero = self.filterList[sender.mIndex]

	if Const.OPEN_NEW_MAZE_TALENT and hero and ResNewMazeHero[hero.id] then
		local ui = UIManager.getUI("newMazeChangeSolderDlg", true)

		ui:bindWindow(self)
		ui:setData(self.filterList, sender.mIndex, self.newMazeData.miscData, self.actObj)
	else
		local ui = UIManager.getUI("newMazeHeroInfoDlg")

		ui:setData(self.filterList, sender.mIndex, self.newMazeData.miscData)
	end
end

function NewMazeHeroListDlg:onBtnCloseClick()
	self:setVisible(false)
end

function NewMazeHeroListDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_NEW_MAZE_HEROLIST)
end

function NewMazeHeroListDlg:onBtnHandBookClick()
	UIManager.getUI("newMazeSolderHandBook", true):setData(self.actObj)
end

function NewMazeHeroListDlg:destroy()
	NewMazeHeroListDlg.super.destroy(self)
end

return NewMazeHeroListDlg
