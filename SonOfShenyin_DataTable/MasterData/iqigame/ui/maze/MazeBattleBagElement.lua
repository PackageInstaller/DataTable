-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleBagElement.lua

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

	function self.__delegateOnUseButtonClick()
		self:__OnUseButtonClick()
	end

	function self.__delegateOnItemButtonClick()
		ItemModule.OpenTipByCid(self.itemCid, true, false)
	end

	self.useBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnUseButtonClick)
	self.itemBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnItemButtonClick)
end

function ItemCell:__OnUseButtonClick()
	self:Select()
end

function ItemCell:Select()
	if self.clickHandler ~= nil then
		self.clickHandler(self.itemCid)
	end

	LuaUtility.SetGameObjectShow(self.selectImg, true)
end

function ItemCell:UnSelect()
	LuaUtility.SetGameObjectShow(self.selectImg, false)
end

function ItemCell:Show(itemCid, curSelectItemCid)
	self.gameObject:SetActive(true)

	self.itemCid = itemCid

	local itemCfg = CfgItemTable[itemCid]
	local itemIconPath = UIGlobalApi.GetIconPath(itemCfg.Icon)

	AssetUtil.LoadImage(self, itemIconPath, self.itemIcon:GetComponent("Image"))

	local qualityPath = CommonSlotUIApi:GetItemFrame(Constant.ItemType.Item, itemCfg.Quality)

	AssetUtil.LoadImage(self, qualityPath, self.qualityBg:GetComponent("Image"))

	self.itemCount:GetComponent("Text").text = MazeModule.GetMazeWarehouseItemCount(itemCid)

	UGUIUtil.SetText(self.itemName, itemCfg.Name)

	if self.itemCid == curSelectItemCid then
		self:Select()
	else
		self:UnSelect()
	end
end

function ItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemCell:Dispose()
	self.useBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnUseButtonClick)
	self.itemBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnItemButtonClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	itemCellList = {},
	itemDataList = {}
}

function Element.New(view)
	local obj = Clone(Element)

	obj:__Init(view)

	return obj
end

function Element:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.scrollAreaList = self.scrollAreaListRoot:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(cell)
		self:__OnRenderItemCell(cell)
	end

	function self.scrollAreaList.onRenderEnd()
		self:__OnRenderEnd()
	end

	function self.__delegateOnCloseBtnClick()
		self:__OnCloseBtnClick()
	end

	function self.__delegateOnUseBtnClick()
		self:__OnUseBtnClick()
	end

	function self.__delegateOnMazeBagItemChange()
		self:__OnMazeBagItemChange()
	end

	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
	self.useBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnUseBtnClick)
end

function Element:__OnRenderItemCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.itemCellList[insID]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.gameObject, function(itemCid)
			self:ItemSelect(itemCid)
		end)
		self.itemCellList[insID] = itemCell
	end

	local dataIndex = cell.index + 1

	itemCell:Show(self.itemDataList[dataIndex], self.curSelectItemCid)

	if dataIndex == 1 then
		self.firstItemCell = itemCell
	end
end

function Element:__OnRenderEnd()
	if self.firstItemCell ~= nil then
		self.firstItemCell:Select()
	end
end

function Element:Show()
	self.gameObject:SetActive(true)
	self:__RefreshItemsShow()
	EventDispatcher.AddEventListener(EventID.MazeBagItemChange, self.__delegateOnMazeBagItemChange)
end

function Element:ItemSelect(itemCid)
	if itemCid == nil then
		return
	end

	for k, v in pairs(self.itemCellList) do
		v:UnSelect()
	end

	self.curSelectItemCid = itemCid
	self.ItemCfg = CfgItemTable[self.curSelectItemCid]

	self:RefreshUseBtnState()
end

function Element:RefreshUseBtnState()
	self.useBtn:GetComponent("Button").interactable = self.curSelectItemCid ~= nil and self.ItemCfg.UseType == Constant.ItemUseType.ManualUse
end

function Element:__RefreshItemsShow()
	self.curSelectItemCid = nil
	self.itemDataList = MazeModule.GetMazeFightingBagItems()

	self.scrollAreaList:Refresh(#self.itemDataList)
	self:RefreshUseBtnState()
end

function Element:__OnMazeBagItemChange()
	self:__RefreshItemsShow()
end

function Element:Hide()
	EventDispatcher.RemoveEventListener(EventID.MazeBagItemChange, self.__delegateOnMazeBagItemChange)
	self.gameObject:SetActive(false)
end

function Element:__OnCloseBtnClick()
	self:Hide()
end

function Element:__OnUseBtnClick()
	EventDispatcher.Dispatch(EventID.OpenMazeUseItemUI, self.curSelectItemCid)
end

function Element:Dispose()
	self.scrollAreaList.onRenderCell = nil
	self.scrollAreaList = nil

	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
	self.useBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnUseBtnClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
