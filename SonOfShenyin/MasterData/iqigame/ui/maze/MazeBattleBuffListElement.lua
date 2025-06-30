-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleBuffListElement.lua

local ItemCell = {}

function ItemCell.New(view, clickHandler)
	local obj = Clone(ItemCell)

	obj:__Init(view, clickHandler)

	return obj
end

function ItemCell:__Init(view, clickHandler)
	self.gameObject = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function ItemCell:SetData(buffPoolCfg)
	local buffCfg = CfgBuffTable[buffPoolCfg.BuffID]

	UGUIUtil.SetText(self.nameText, buffCfg.Name)
	UGUIUtil.SetText(self.descText, buffCfg.Describe)
	AssetUtil.LoadImage(self, BattleApi:GetAttributeIconUrl(buffCfg.Icon), self.iconGo:GetComponent("Image"))
end

function ItemCell:Show()
	self.gameObject:SetActive(true)
end

function ItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	buffItemCellList = {}
}

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

	self.buffListScrollCom = self.buffListScroll:GetComponent("ScrollAreaList")

	function self.buffListScrollCom.onRenderCell(cell)
		self:onRenderCell(cell)
	end

	self:AddListeners()
end

function Element:AddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
end

function Element:RemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
end

function Element:SetData()
	self.buffDataList = {}

	local seasonId = MazeModule.GetMazeSeason()

	for k, v in pairsCfg(CfgLabyrinthBuffPoolTable) do
		if v.MazeSeason == seasonId then
			table.insert(self.buffDataList, v)
		end
	end

	table.sort(self.buffDataList, function(a, b)
		return a.Id < b.Id
	end)
	self.buffListScrollCom:Refresh(#self.buffDataList)
end

function Element:onRenderCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local buffItem = self.buffItemCellList[instanceID]

	if buffItem == nil then
		buffItem = ItemCell.New(cell.gameObject)
		self.buffItemCellList[instanceID] = buffItem
	end

	local buffData = self.buffDataList[cell.index + 1]

	buffItem:Show()
	buffItem:SetData(buffData)
end

function Element:__OnCloseBtnClick()
	self:Hide()
end

function Element:Show()
	self:SetData()
	self.gameObject:SetActive(true)
end

function Element:Hide()
	self.gameObject:SetActive(false)
end

function Element:Dispose()
	for k, v in pairs(self.buffItemCellList) do
		v:Dispose()
	end

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
