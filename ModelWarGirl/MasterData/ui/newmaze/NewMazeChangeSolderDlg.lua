-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeChangeSolderDlg.lua

local HeroGridSolderCardChild = require("UI/NewMaze/HeroGridSolderCardChild")
local NewMazeGridComp = require("UI/NewMaze/NewMazeGridComp")
local NewMazeLosderTipsInfoPanel = require("UI/NewMaze/NewMazeLosderTipsInfoPanel")
local ResNewMazeFettersType = require("ClientData/ResNewMazeFettersType")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local QUALITY_PATH = {
	{
		"BgCardBlue",
		"BgCardYellow",
		"BgCardPink"
	},
	{
		"BgHeroCardBlue",
		"BgHeroCardYellow",
		"BgHeroCardPink"
	},
	{
		"BtnCardBlue",
		"BtnCardYellow",
		"BtnCardPink"
	}
}
local NewMazeLosderMixin = require("UI/NewMaze/NewMazeLosderMixin")
local strClassName = "NewMazeChangeSolderDlg"
local NewMazeChangeSolderDlg = Class(strClassName, UIControls.Window)

MixinClass(NewMazeChangeSolderDlg, NewMazeLosderMixin)

function NewMazeChangeSolderDlg:ctor()
	self:ctorMixin()
	self:initUI()
end

local MAX_SOLDER_NUM = 3

function NewMazeChangeSolderDlg:initUI()
	self.bgQualityTop = UIControls.Image(self, "MainInfoPanel/HeroDetailPanel/BgTop")
	self.bgQualityMiddle = UIControls.Image(self, "MainInfoPanel/HeroDetailPanel/BgMiddle")
	self.bgQualityBottom = UIControls.Image(self, "MainInfoPanel/HeroDetailPanel/BgBottom")
	self.textHeroName = UIControls.Label(self, "MainInfoPanel/HeroDetailPanel/BgName/TextName")
	self.gridHero = HeroGridSolderCardChild(self, "MainInfoPanel/HeroDetailPanel/GridPanel", "System/Hero/GridHeroCardSolder")

	self.gridHero:setVisible(true)
	self.gridHero.panelSolder:setVisible(false)

	self.btnHeroDetail = UIControls.Button(self, "MainInfoPanel/HeroDetailPanel/BtnDetail")

	self.btnHeroDetail:addEventClick(self.onHeroCellClick)

	self.iconHeroDetailNew = UIControls.Image(self, "MainInfoPanel/HeroDetailPanel/BtnDetail/IconNew")
	self.solderGrids = {}

	for index = 1, MAX_SOLDER_NUM do
		local newGrid = NewMazeGridComp.SolderGrid(self, "MainInfoPanel/HeroDetailPanel/SolderPanel", "System/Rogue/GridResolve")

		newGrid:setVisible(true)

		newGrid.onGridClick = Slot(self.onSolderGridClick, self)

		table.insert(self.solderGrids, newGrid)
	end

	self.losderDetailTipsPanel = UIControls.Panel(self, "MainInfoPanel/HeroDetailPanel/LosderTipsPanel")

	self.losderDetailTipsPanel:setVisible(false)

	self.uiDetailClickThrough = UIControls.Button(self, "MainInfoPanel/HeroDetailPanel/LosderTipsPanel/UIClickThrough")

	self.uiDetailClickThrough:addEventClick(self.onUIDetailClickThroughClick)

	self.losderDetailTipsInfoPanel = NewMazeLosderTipsInfoPanel(self, "MainInfoPanel/HeroDetailPanel/LosderTipsPanel", "System/Rogue/LosderTipsInfoPanel")

	self.losderDetailTipsInfoPanel:setVisible(true)

	self.panelResolve = UIControls.Panel(self, "MainInfoPanel/HeroDetailPanel/ResolvePanel")
	self.btnResolveTips = UIControls.Button(self, "MainInfoPanel/HeroDetailPanel/ResolvePanel/BtnTips")

	self.btnResolveTips:addEventClick(self.onResolveTipsClick)

	self.textResolveNum = UIControls.Label(self, "MainInfoPanel/HeroDetailPanel/ResolvePanel/BtnTips/TextNum")
	self.btnResolve = UIControls.Button(self, "MainInfoPanel/HeroDetailPanel/ResolvePanel/BtnResolve")

	self.btnResolve:addEventClick(self.onResolveClick)

	self.panelBtnResolveNml = UIControls.Panel(self, "MainInfoPanel/HeroDetailPanel/ResolvePanel/BtnResolve/NmlPanel")
	self.panelBtnResolveDis = UIControls.Panel(self, "MainInfoPanel/HeroDetailPanel/ResolvePanel/BtnResolve/DisPanel")
	self.panelNoneSolderItem = UIControls.Panel(self, "MainInfoPanel/EnchantPanel/NoContent")
	self.panelSolderItemContent = UIControls.Panel(self, "MainInfoPanel/EnchantPanel/GridPanel")
	self.solderItemGrids = {}
	self.btnChangeSolder = UIControls.Button(self, "MainInfoPanel/EnchantPanel/BtnEnchant")

	self.btnChangeSolder:addEventClick(self.onChangeSolderClick)

	self.panelBtnChangeSolderNml = UIControls.Panel(self, "MainInfoPanel/EnchantPanel/BtnEnchant/NmlPanel")
	self.textBtnChangeSolderNml = UIControls.Label(self, "MainInfoPanel/EnchantPanel/BtnEnchant/NmlPanel/Text")
	self.panelBtnChangeSolderDis = UIControls.Panel(self, "MainInfoPanel/EnchantPanel/BtnEnchant/DisPanel")
	self.textBtnChangeSolderDis = UIControls.Label(self, "MainInfoPanel/EnchantPanel/BtnEnchant/DisPanel/Text")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function NewMazeChangeSolderDlg:setData(heros, idx, miscData, actObj)
	self.actObj = actObj
	self.actData = actObj.actData
	self.newMazeData = self.actData
	self.heros = heros
	self.idx = idx
	self.miscData = miscData

	self:refreshUI()
end

function NewMazeChangeSolderDlg:refreshUI()
	local newMazeHeroListDlg = UIManager.tryGetUI("newMazeHeroListDlg")

	if self.curHero and newMazeHeroListDlg then
		for idx, hero in ipairs(newMazeHeroListDlg.filterList or {}) do
			if hero.id == self.curHero.id then
				self.heros = newMazeHeroListDlg.filterList
				self.idx = idx

				break
			end
		end
	end

	self.curHero = self.heros[self.idx]

	self.gridHero:setHero(self.curHero)

	local mazeData = ResNewMazeHero[self.curHero.id] or {}

	if QUALITY_PATH[1][mazeData.quality] then
		self.bgQualityTop:setImage("Atlas/RogueAtlas/RogueStoreAtlas", QUALITY_PATH[1][mazeData.quality])
		self.bgQualityMiddle:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder01", QUALITY_PATH[2][mazeData.quality])
		self.bgQualityBottom:setImage("Atlas/RogueAtlas/RogueStoreAtlas", QUALITY_PATH[3][mazeData.quality])
	end

	self.textHeroName:setText(self.curHero.name)

	self.heroEmptyIndex = 1
	self.solderList = self.curHero:getMazeSolderState()

	for index = 1, MAX_SOLDER_NUM do
		local data = self.solderList[index]

		if data then
			self.solderGrids[index]:setData(data.id, not data.isDefault)

			self.heroEmptyIndex = index + 1
		else
			self.solderGrids[index]:setData(nil)
		end
	end

	self:refreshResolveNum()
	self:refreshFettersUI()
	self:refreshSolderItem()
	self:refreshHeroDetailIconNew()
end

function NewMazeChangeSolderDlg:refreshHeroDetailIconNew()
	local canWearRelicNewMazeHeroDic = self.actData:checkCanWearRelicNewMazeHero()

	self.iconHeroDetailNew:setVisible(canWearRelicNewMazeHeroDic[self.curHero.gid] ~= nil)
end

function NewMazeChangeSolderDlg:refreshResolveNum()
	self.resolveItemNum = self.actData:getSolderResolveItemNum()

	self.textResolveNum:setText(self.resolveItemNum)

	if #self.solderList == 0 or self.resolveItemNum == 0 then
		self.panelBtnResolveNml:setVisible(false)
		self.panelBtnResolveDis:setVisible(true)
	else
		self.panelBtnResolveNml:setVisible(true)
		self.panelBtnResolveDis:setVisible(false)
	end
end

function NewMazeChangeSolderDlg:refreshSolderItem()
	self.solderItemList = self.actData:getSolderItemList()

	for index = #self.solderItemGrids, #self.solderItemList - 1 do
		local newGrid = NewMazeGridComp.SolderItemGrid(self, "MainInfoPanel/EnchantPanel/GridPanel/Content", "System/Rogue/GridEnchant")

		newGrid.onGridClick = Slot(self.onSolderItemGridClick, self)

		table.insert(self.solderItemGrids, newGrid)
	end

	for index, grid in ipairs(self.solderItemGrids) do
		local itemData = self.solderItemList[index]

		if itemData then
			grid:setVisible(true)
			grid:setData(itemData.id, itemData.num, itemData.item_id)
			grid:setOwned(self.curHero:newMazeOwnSolder(itemData.id))
		else
			grid:setVisible(false)
		end
	end

	self.selectSolderItem = nil

	if #self.solderItemList == 0 then
		self.panelNoneSolderItem:setVisible(true)
		self.panelSolderItemContent:setVisible(false)
		self.panelBtnChangeSolderDis:setVisible(true)
		self.panelBtnChangeSolderNml:setVisible(false)
	else
		self.panelNoneSolderItem:setVisible(false)
		self.panelSolderItemContent:setVisible(true)
	end

	if self.solderGrids[self.heroEmptyIndex] then
		self.textBtnChangeSolderDis:setText(Lang.get(102645))
		self.textBtnChangeSolderNml:setText(Lang.get(102645))
	else
		self.textBtnChangeSolderDis:setText(Lang.get(14994))
		self.textBtnChangeSolderNml:setText(Lang.get(14994))
	end

	self:refreshSelectSolderItem()
end

function NewMazeChangeSolderDlg:refreshSelectSolderItem()
	for index, grid in ipairs(self.solderItemGrids) do
		grid:setSelected(self.selectSolderItem and grid.solderId == self.selectSolderItem)
	end

	local nextEmptyGrid = self.solderGrids[self.heroEmptyIndex]

	if nextEmptyGrid then
		if self.selectSolderItem then
			nextEmptyGrid:setData(self.selectSolderItem, nil, true)
		else
			nextEmptyGrid:setData(nil)
		end
	end

	if self.selectSolderItem then
		self.panelBtnChangeSolderDis:setVisible(false)
		self.panelBtnChangeSolderNml:setVisible(true)
	else
		self.panelBtnChangeSolderDis:setVisible(true)
		self.panelBtnChangeSolderNml:setVisible(false)
	end
end

function NewMazeChangeSolderDlg:onHeroCellClick(sender)
	local ui = UIManager.getUI("newMazeHeroInfoDlg")

	ui:setData(self.heros, self.idx, self.miscData)
end

function NewMazeChangeSolderDlg:onBtnCloseClick()
	self:setVisible(false)
end

function NewMazeChangeSolderDlg:onResolveTipsClick()
	return
end

function NewMazeChangeSolderDlg:onUIDetailClickThroughClick()
	self.losderDetailTipsPanel:setVisible(false)
end

function NewMazeChangeSolderDlg:onSolderGridClick(grid)
	local solderId = grid.solderId

	if solderId == nil then
		MsgManager.notice(Lang.get(103605))
	else
		self.losderDetailTipsPanel:setVisible(true)

		local fettersData = self.actData:getOneFetters(solderId)
		local fettersTableData = ResNewMazeFettersType[solderId][1]

		self.losderDetailTipsInfoPanel:setData(fettersData, fettersTableData)
	end
end

function NewMazeChangeSolderDlg:onSolderItemGridClick(sender)
	if self.selectSolderItem == sender.solderId then
		self.selectSolderItem = nil
	else
		for _, info in ipairs(self.solderList) do
			if info.id == sender.solderId then
				MsgManager.notice(Lang.get(102257))

				return
			end
		end

		self.selectSolderItem = sender.solderId
		self.selectSolderItemId = sender.solderItemId
	end

	self:refreshSelectSolderItem()
end

function NewMazeChangeSolderDlg:onChangeSolderClick()
	if #self.solderItemList == 0 then
		MsgManager.notice(Lang.get(103606))

		return
	end

	if not self.selectSolderItem then
		MsgManager.notice(Lang.get(103607))

		return
	end

	if self.solderGrids[self.heroEmptyIndex] then
		self:rpcChangeHeroSolder(self.heroEmptyIndex)
	else
		UIManager.getUI("newMazeConfirmBox", true):onConfirmChange(self.curHero, self.selectSolderItem, self.actObj, Slot(self.rpcChangeHeroSolder, self))
	end
end

function NewMazeChangeSolderDlg:rpcChangeHeroSolder(repId)
	RPC.newMazeEnchanterUse(self.actObj.opId, self.curHero.id, self.selectSolderItemId, repId)
end

function NewMazeChangeSolderDlg:onResolveClick()
	if self.curHero.id == self.actObj.actData.heroId then
		MsgManager.notice(ResNewMazeDisplay[13060075].desc or Lang.get(102777))

		return
	end

	if #self.solderList == 0 then
		MsgManager.notice(Lang.get(102260))

		return
	end

	if self.resolveItemNum == 0 then
		MsgManager.notice(Lang.get(103608))

		return
	end

	UIManager.getUI("newMazeConfirmBox", true):onConfirmResolve(self.curHero, self.actObj, Slot(self.rpcResolveHero, self))
end

function NewMazeChangeSolderDlg:rpcResolveHero()
	RPC.newMazeEnchanterUse(self.actObj.opId, self.curHero.id, self.newMazeData.resolveItemId)
	self:setVisible(false)
end

return NewMazeChangeSolderDlg
