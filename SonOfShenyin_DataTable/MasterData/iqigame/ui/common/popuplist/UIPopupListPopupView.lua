-- chunkname: @IQIGame\\UI\\Common\\PopupList\\UIPopupListPopupView.lua

local UIPopupListPopupView = {
	staticBtnId = 0,
	itemsTable = {}
}

function UIPopupListPopupView.New(view, parentUI, itemController, itemSelectEvent)
	local obj = Clone(UIPopupListPopupView)

	obj:__Init(view, parentUI, itemController, itemSelectEvent)

	return obj
end

function UIPopupListPopupView:__Init(view, parentUI, itemController, itemSelectEvent)
	self.parentUI = parentUI
	self.gameObject = view
	self.itemController = itemController
	self.onItemSelectEvent = itemSelectEvent

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.unfilterButton:SetActive(false)

	self.itemsTable = {}
	self.itemScrollView = self.ItemScroll:GetComponent("ScrollAreaList")

	function self.itemScrollView.onRenderCell(cell)
		self:__OnRenderItemCell(cell)
	end

	function self.OnClearBtnClickProxy()
		self.onItemSelectEvent(self.staticBtnId)
	end

	self:__AddListeners()
end

function UIPopupListPopupView:__AddListeners()
	self.unfilterButton:GetComponent("Button").onClick:AddListener(self.OnClearBtnClickProxy)
end

function UIPopupListPopupView:__RemoveListeners()
	self.unfilterButton:GetComponent("Button").onClick:RemoveListener(self.OnClearBtnClickProxy)
end

function UIPopupListPopupView:Dispose()
	self:__RemoveListeners()

	self.parentUI = nil

	for _id, _item in pairs(self.itemsTable) do
		_item:Dispose()
	end

	self.itemsTable = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function UIPopupListPopupView:SetStaticBtnData(text, index)
	self.staticBtnId = index

	if LuaUtility.StrIsNullOrEmpty(text) then
		self.unfilterButton:SetActive(false)
	else
		self.unfilterButton:SetActive(true)
		UGUIUtil.SetText(self.unfilterText, text)
	end
end

function UIPopupListPopupView:Show()
	self.gameObject:SetActive(true)
	self.itemScrollView:Refresh(#self.parentUI.PopupsData)
end

function UIPopupListPopupView:Hide()
	self.gameObject:SetActive(false)
end

function UIPopupListPopupView:__OnRenderItemCell(cell)
	local itemIndex = cell.index + 1
	local popupItemData = self.parentUI.PopupsData[itemIndex]
	local isSelect = itemIndex == self.parentUI.SelectIndex
	local instanceID = cell.gameObject:GetInstanceID()
	local item = self.itemsTable[instanceID]

	if item == nil then
		item = self.itemController.New(cell.gameObject, function(_item)
			if self.onItemSelectEvent ~= nil then
				self.onItemSelectEvent(_item.Index)
			end
		end)
		self.itemsTable[instanceID] = item
	end

	item:Show(itemIndex, popupItemData, isSelect)
end

return UIPopupListPopupView
