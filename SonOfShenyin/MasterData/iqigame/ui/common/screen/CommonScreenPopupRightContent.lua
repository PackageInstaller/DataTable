-- chunkname: @IQIGame\\UI\\Common\\Screen\\CommonScreenPopupRightContent.lua

local ChoiceItem = {
	choiceID = 0
}

function ChoiceItem.New(view, callback)
	local obj = Clone(ChoiceItem)

	obj:__Init(view, callback)

	return obj
end

function ChoiceItem:__Init(view, callback)
	self.gameObject = view
	self.callback = callback

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function ChoiceItem:Show(screenType, subScreenType, value)
	self.choiceID = value

	self.gameObject.gameObject:SetActive(true)

	local showData = CommonScreenModule.GetScreenItemShowData(screenType, subScreenType, value)

	self.content:GetComponent("Text").text = showData.Content
	self.selectContent:GetComponent("Text").text = showData.Content

	if LuaUtility.StrIsNullOrEmpty(showData.Icon) then
		self.icon.gameObject:SetActive(false)
	else
		self.icon.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, CommonScreenModule.FormatScreenIconPath(showData.Icon), self.icon.gameObject:GetComponent("Image"))
	end

	self.numRoot.gameObject:SetActive(false)

	if screenType == Constant.CommonScreenType.Equip and subScreenType == Constant.EquipScreenType.Suit and value ~= Constant.CommonScreenAllValueID then
		LuaUtility.SetGameObjectShow(self.numRoot, true)

		local num = EquipModule.GetSuitNum(CfgEquipScreenTable[value].Value)

		LuaUtility.SetText(self.NumText, TernaryConditionalOperator(num, num, 0))
	end
end

function ChoiceItem:Hide()
	self.gameObject.gameObject:SetActive(false)
end

function ChoiceItem:SetSelectStatus(isSelect)
	self.normalRoot.gameObject:SetActive(not isSelect)
	self.selectRoot.gameObject:SetActive(isSelect)
end

function ChoiceItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Content = {
	screenType = 0,
	itemDataList = {},
	itemCellList = {}
}

function Content.New(view, callback)
	local obj = Clone(Content)

	obj:__Init(view, callback)

	return obj
end

function Content:__Init(view, callback)
	self.gameObject = view
	self.itemSelectHandler = callback

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.itemAreaList = self.itemAreaListRoot:GetComponent("ScrollAreaList")

	function self.itemAreaList.onRenderCell(cell)
		self:__OnRenderChoiceItem(cell)
	end

	function self.itemAreaList.onSelectedCell(cell)
		self:__OnChoiceItemSelect(cell)
	end
end

function Content:Show(screenType, screenItemData)
	self.screenType = screenType
	self.screenItemData = screenItemData
	self.itemDataList = CommonScreenModule.GetSubScreenCfgIDList(screenType, screenItemData.screenType)

	if screenItemData.limitData.excludeAll then
		self.itemAreaList:Refresh(#self.itemDataList)
	else
		self.itemAreaList:Refresh(#self.itemDataList + 1)
	end
end

function Content:UpdateSelect(screenItemData)
	self.screenItemData = screenItemData

	ForPairs(self.itemCellList, function(_, _itemCell)
		local isSelect = self.screenItemData:IndexOfValue(_itemCell.choiceID) ~= 0

		_itemCell:SetSelectStatus(isSelect)
	end)
end

function Content:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function Content:__OnRenderChoiceItem(cell)
	local insID = cell.gameObject:GetInstanceID()
	local choiceItem = self.itemCellList[insID]

	if choiceItem == nil then
		choiceItem = ChoiceItem.New(cell.gameObject, function(_value)
			self:__OnChoiceItemSelectHandler(_value)
		end)
		self.itemCellList[insID] = choiceItem
	end

	local index = cell.index

	if self.screenItemData.limitData.excludeAll then
		index = index + 1
	end

	local choiceID = Constant.CommonScreenAllValueID

	if index > 0 then
		choiceID = self.itemDataList[index]
	end

	choiceItem:Show(self.screenType, self.screenItemData.screenType, choiceID)

	local isSelect = self.screenItemData:IndexOfValue(choiceID) ~= 0

	choiceItem:SetSelectStatus(isSelect)
end

function Content:__OnChoiceItemSelect(cell)
	local insID = cell.gameObject:GetInstanceID()
	local choiceItem = self.itemCellList[insID]

	self:__OnChoiceItemSelectHandler(choiceItem.choiceID)
end

function Content:__OnChoiceItemSelectHandler(value)
	if self.itemSelectHandler == nil then
		return
	end

	self.itemSelectHandler(value)
end

return Content
