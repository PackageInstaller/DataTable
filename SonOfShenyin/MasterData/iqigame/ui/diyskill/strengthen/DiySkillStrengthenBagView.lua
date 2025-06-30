-- chunkname: @IQIGame\\UI\\DiySkill\\Strengthen\\DiySkillStrengthenBagView.lua

local CommonSortingPopupListView = require("IQIGame.UI.Common.CommonSortingPopupListView")
local CommonScreenControllerView = require("IQIGame/UI/Common/Screen/CommonScreenControllerView")
local BagItemCell = {}

function BagItemCell.New(view, reduceEvent, clickEvent)
	local obj = Clone(BagItemCell)

	obj:__Init(view, reduceEvent, clickEvent)

	return obj
end

function BagItemCell:__Init(view, reduceEvent, clickEvent)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.itemCell = ItemCell.New(self.CommonSlotUI, false, true, true)

	local reduceLongBtn = self.reduceBtn:GetComponent("LongButton")

	function self.__OnReduceBtnClickProxy()
		if reduceEvent ~= nil then
			reduceEvent(self.itemCell.ItemCfgOrData)
		end
	end

	reduceLongBtn.onClick:AddListener(self.__OnReduceBtnClickProxy)

	function self.__OnReduceBtnLongClickProxy()
		if reduceEvent ~= nil then
			reduceEvent(self.itemCell.ItemCfgOrData)
		end
	end

	reduceLongBtn.onLongDownClick:AddListener(self.__OnReduceBtnLongClickProxy)

	self.itemCellBtn = self.btnGo:GetComponent("LongButton")

	function self.__OnItemCellClickProxy()
		if clickEvent ~= nil then
			clickEvent(self.itemCell.ItemCfgOrData, self.itemCell)
		end
	end

	self.itemCellBtn.onClick:AddListener(self.__OnItemCellClickProxy)

	function self.__OnItemCellLongClickProxy()
		local itemData = self.itemCell.ItemCfgOrData

		if itemData.skillData ~= nil then
			ItemModule.OpenTip(self.itemCell, {
				forceShowLock = true
			})

			return
		end

		if clickEvent ~= nil then
			clickEvent(itemData)
		end
	end

	self.itemCellBtn.onLongDownClick:AddListener(self.__OnItemCellLongClickProxy)
end

function BagItemCell:Show(itemData, num)
	self.gameObject:SetActive(true)
	self.itemCell:SetItem(itemData)
	LuaUtility.SetGameObjectShow(self.reduceBtn, num > 0)

	local skillData = itemData.skillData

	if skillData ~= nil then
		self.itemCell:SetItemLv(skillData.lv)

		self.itemCellBtn.repeatCall = false

		self.itemCell:SetLockVisable(skillData.lock)
	else
		self.itemCellBtn.repeatCall = true

		self.itemCell:SetNum(itemData.num)

		if num > 0 then
			self.itemCell:SetCostAllNumberShow(num, itemData.num)
		end
	end

	self.itemCell:SetSelectFrame(num > 0)
end

function BagItemCell:Hide()
	self.gameObject:SetActive(false)
end

function BagItemCell:Dispose()
	local reduceLongBtn = self.reduceBtn:GetComponent("LongButton")

	reduceLongBtn.onClick:RemoveListener(self.__OnReduceBtnClickProxy)
	reduceLongBtn.onLongDownClick:RemoveListener(self.__OnReduceBtnLongClickProxy)
	self.itemCellBtn.onClick:RemoveListener(self.__OnItemCellClickProxy)
	self.itemCellBtn.onLongDownClick:RemoveListener(self.__OnItemCellLongClickProxy)

	self.itemCellBtn = nil

	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local DiySkillStrengthenBagView = {
	bagItemCells = {},
	SelectItems = {}
}

function DiySkillStrengthenBagView.New(view, itemAddAction, itemReduceAction)
	local obj = Clone(DiySkillStrengthenBagView)

	obj:__Init(view, itemAddAction, itemReduceAction)

	return obj
end

function DiySkillStrengthenBagView:__Init(view, itemAddAction, itemReduceAction)
	self.gameObject = view
	self.itemAddAction = itemAddAction
	self.itemReduceAction = itemReduceAction

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.bagItemCells = {}
	self.bagScrollArea = self.equipBagScroll:GetComponent("ScrollAreaList")

	function self.bagScrollArea.onRenderCell(cell)
		self:__OnRenderBagCell(cell)
	end

	function self.__OnCloseBtnClickProxy()
		self:Hide()
	end

	self.screenController = CommonScreenControllerView.New(self.screenControllerView, function(isSortChange)
		self:__OnSortingTypeChange(isSortChange)
	end)

	function self.screenController.resetScreenDataEvent()
		return CommonScreenModule.GetCommonSkillScreenData()
	end

	self.screenController:SetSortPopupData(CommonSortingPopupListApi:GetSkillSortingData(), 3)
	self.screenController:SetSortOrderData(true)

	function self.onItemChangeEvent()
		self:__RefreshBagData(true)
	end

	self:__AddListeners()
end

function DiySkillStrengthenBagView:__AddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__OnCloseBtnClickProxy)
end

function DiySkillStrengthenBagView:__RemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__OnCloseBtnClickProxy)
end

function DiySkillStrengthenBagView:Dispose()
	self:__RemoveListeners()

	for _, _itemCell in pairs(self.bagItemCells) do
		_itemCell:Dispose()
	end

	LuaUtility.ClearAnimationEvent(self.animationRoot, "DIYBagContent_In")

	self.bagItemCells = nil

	self.screenController:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillStrengthenBagView:Show(allItems, selectItems, sortFunc)
	self.gameObject:SetActive(true)
	self.screenController:ResetSortPopupIndex(3, false)
	self.screenController:SetScreenPopupData(nil)

	self.allItems = allItems
	self.showItems = DiySkillModule.ScreenDiySkillItemDataListByScreenData(self.allItems, self.screenController.screenData)
	self.SelectItems = selectItems
	self.sortFunc = sortFunc

	self:__RefreshBagData(false)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.onItemChangeEvent)
	EventDispatcher.Dispatch(EventID.SetDiySkillStrengthenFunTabsShowEvent, false)
	LuaUtility.PlayAnimation(self.animationRoot, "DIYBagContent_In")
end

function DiySkillStrengthenBagView:__RefreshBagData(isDynamic)
	local sortType = self.screenController.sortIndex

	if self.sortFunc ~= nil then
		self.showItems = self.sortFunc(self.showItems, sortType, self.screenController.ascending)
	else
		WarehouseModule.SortItems(self.showItems, sortType, self.screenController.ascending)
	end

	self:RefreshBagShow(self.SelectItems, isDynamic)
end

function DiySkillStrengthenBagView:Hide()
	if not self.gameObject.activeSelf then
		return
	end

	LuaUtility.ReversePlayAnimation(self.animationRoot, "DIYBagContent_In", nil, function()
		EventDispatcher.Dispatch(EventID.SetDiySkillStrengthenFunTabsShowEvent, true)
		LuaUtility.ClearAnimationEvent(self.animationRoot, "DIYBagContent_In")
		LuaUtility.SetGameObjectShow(self.gameObject, false)
	end)

	self.sortFunc = nil

	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.onItemChangeEvent)
end

function DiySkillStrengthenBagView:__OnSortingTypeChange(isSortChange)
	local dynamic = true

	if not isSortChange then
		self.showItems = DiySkillModule.ScreenDiySkillItemDataListByScreenData(self.allItems, self.screenController.screenData)
		dynamic = false
	end

	self:__RefreshBagData(dynamic)
end

function DiySkillStrengthenBagView:RefreshBagShow(selectItems, isDynamic)
	self.SelectItems = selectItems

	if isDynamic then
		self.bagScrollArea:RenderCellsDynamic(#self.showItems)
	else
		self.bagScrollArea:Refresh(#self.showItems)
	end
end

function DiySkillStrengthenBagView:__OnRenderBagCell(cell)
	local itemData = self.showItems[cell.index + 1]
	local itemCell = self:__GetBagCell(cell.gameObject)
	local cnt = self.SelectItems[itemData.id]

	if cnt == nil then
		cnt = 0
	end

	itemCell:Show(itemData, cnt)
end

function DiySkillStrengthenBagView:__GetBagCell(cellGo)
	local insID = cellGo:GetInstanceID()
	local itemCell = self.bagItemCells[insID]

	if itemCell == nil then
		itemCell = BagItemCell.New(cellGo, function(_itemData)
			self:__OnBagCellReduceClickHandler(_itemData)
		end, function(_itemData, itemCell)
			self:__OnBagCellClickHandler(_itemData, itemCell)
		end)
		self.bagItemCells[insID] = itemCell
	end

	return itemCell
end

function DiySkillStrengthenBagView:__OnBagCellClickHandler(_itemData, itemCell)
	if _itemData.skillData and _itemData.skillData.lock then
		NoticeModule.ShowNotice(70010)
		ItemModule.OpenTip(itemCell, {
			forceShowLock = true
		})

		return
	end

	if self.SelectItems[_itemData.id] and _itemData:GetCfg().ItemTypes ~= Constant.ItemType.Item then
		self:__OnBagCellReduceClickHandler(_itemData)

		return
	end

	if self.itemAddAction ~= nil then
		self.itemAddAction(_itemData)
	end
end

function DiySkillStrengthenBagView:__OnBagCellReduceClickHandler(_itemData)
	if self.itemReduceAction ~= nil then
		self.itemReduceAction(_itemData)
	end
end

return DiySkillStrengthenBagView
