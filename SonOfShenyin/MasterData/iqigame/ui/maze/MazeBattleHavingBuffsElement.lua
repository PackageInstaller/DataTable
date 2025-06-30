-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleHavingBuffsElement.lua

local BuffGroupTitleItemView = require("IQIGame.UI.Maze.ItemCell.BuffGroupTitleItemView")
local BuffItem = {}

function BuffItem.New(view)
	local obj = Clone(BuffItem)

	obj:__Init(view)

	return obj
end

function BuffItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.buffGroupTitleItemView = BuffGroupTitleItemView.New(self.buffGroupTitle)
end

function BuffItem:SetData(buffCid)
	local buffCfg = CfgBuffTable[buffCid]
	local buffItemCfg = MazeModule.GetBuffItemCfg(buffCid)

	UGUIUtil.SetText(self.nameText, buffCfg.Name)
	UGUIUtil.SetText(self.descText, buffCfg.Describe)
	UGUIUtil.SetText(self.titleText, MazeApi:GetBuffQualityTitle(buffItemCfg.Quality))
	AssetUtil.LoadImage(self, BattleApi:GetAttributeIconUrl(buffCfg.Icon), self.iconGo:GetComponent("Image"))
	AssetUtil.LoadImage(self, MazeApi:GetSelectBuffFrame(buffItemCfg.Quality), self.buffFrame:GetComponent("Image"))
	AssetUtil.LoadImage(self, MazeApi:GetBuffTitleFrame(buffItemCfg.Quality), self.titleFrame:GetComponent("Image"))

	local buffPoolCfg = MazeModule.GetBuffCfg(buffCid)

	self.buffGroupTitleItemView:SetData(buffPoolCfg.Id)

	self.descScroll:GetComponent("ScrollRect").verticalNormalizedPosition = 1
end

function BuffItem:Show()
	self.gameObject:SetActive(true)
end

function BuffItem:Hide()
	self.gameObject:SetActive(false)
end

function BuffItem:Dispose()
	self.buffGroupTitleItemView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local BuffPanelItem = {
	buffItemCellList = {}
}

function BuffPanelItem.New(view, clickHandler)
	local obj = Clone(BuffPanelItem)

	obj:__Init(view, clickHandler)

	return obj
end

function BuffPanelItem:__Init(view, clickHandler)
	self.gameObject = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.buffItemScrollCom = self.buffItemScroll:GetComponent("ScrollAreaList")

	function self.buffItemScrollCom.onRenderCell(cell)
		self:onRenderCell(cell)
	end
end

function BuffPanelItem:SetData(buffDataList)
	if buffDataList == nil then
		buffDataList = {}
	end

	self.buffDataList = buffDataList.buffs

	table.sort(self.buffDataList, function(buffId1, buffId2)
		local buff1ItemCfg = MazeModule.GetBuffItemCfg(buffId1)
		local buff2ItemCfg = MazeModule.GetBuffItemCfg(buffId2)
		local quality1 = buff1ItemCfg == nil or buff1ItemCfg.Quality
		local quality2 = buff2ItemCfg == nil or buff2ItemCfg.Quality

		if quality1 == quality2 then
			return buffId1 < buffId2
		end

		return quality2 < quality1
	end)

	if self.buffDataList == nil or table.len(self.buffDataList) == 0 then
		LuaUtility.SetGameObjectShow(self.NormalParent, false)
		LuaUtility.SetGameObjectShow(self.EmptyParent, true)

		return
	else
		LuaUtility.SetGameObjectShow(self.NormalParent, true)
		LuaUtility.SetGameObjectShow(self.EmptyParent, false)
	end

	self.buffItemScrollCom:Refresh(#self.buffDataList)
end

function BuffPanelItem:onRenderCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local buffItemCell = self.buffItemCellList[instanceID]

	if buffItemCell == nil then
		buffItemCell = BuffItem.New(cell.gameObject)
		self.buffItemCellList[instanceID] = buffItemCell
	end

	local buffData = self.buffDataList[cell.index + 1]

	buffItemCell:Show()
	buffItemCell:SetData(buffData)
end

function BuffPanelItem:Show()
	self.gameObject:SetActive(true)
end

function BuffPanelItem:Hide()
	self.gameObject:SetActive(false)
end

function BuffPanelItem:Dispose()
	for k, v in pairs(self.buffItemCellList) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local buffGroupElement = require("IQIGame.UI.Maze.MazeBattleHavingBuffsGroupElement")
local Element = {}

function Element.New(view)
	local obj = Clone(Element)

	obj:__Init(view)

	return obj
end

function Element:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnCloseBtnClick()
		self:__OnCloseBtnClick()
	end

	self.mazeBuffListView = BuffPanelItem.New(self.mazeBuffParent)
	self.buffGroupView = buffGroupElement.New(self.buffGroupParent)

	self:AddListeners()
end

function Element:AddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
end

function Element:RemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
end

function Element:SetData()
	self.buffDataList = MazeModule.GetBuffList()

	self.mazeBuffListView:SetData(self.buffDataList[Constant.MazeBuffType.BattleBuff])
	self.buffGroupView:SetData()
end

function Element:__OnCloseBtnClick()
	self:Hide()
end

function Element:Show()
	self:SetData()
	self.gameObject:SetActive(true)
	self.buffGroupView:Show()
end

function Element:Hide()
	self.gameObject:SetActive(false)
end

function Element:Dispose()
	self.mazeBuffListView:Dispose()
	self.buffGroupView:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
