-- chunkname: @IQIGame\\UI\\Common\\Equip\\EquipScreenPopupPanel.lua

local EquipScreenData = require("IQIGame/UI/Common/Equip/EquipScreenData")
local EquipSortBtn = {
	sortValue = 0
}

function EquipSortBtn.New(view, selectCallback)
	local obj = Clone(EquipSortBtn)

	obj:__Init(view, selectCallback)

	return obj
end

function EquipSortBtn:__Init(view, selectCallback)
	self.view = view.gameObject
	self.SelectEvent = selectCallback

	LuaCodeInterface.BindOutlet(self.view, self)

	function self.__OnSelectBtnClickEventProxy()
		if self.SelectEvent ~= nil then
			self.SelectEvent(self.sortValue)
		end
	end

	self.selectBtn:GetComponent("Button").onClick:AddListener(self.__OnSelectBtnClickEventProxy)
end

function EquipSortBtn:Show(sortType, sortValue)
	self.view.gameObject:SetActive(true)

	self.sortType = sortType
	self.sortValue = sortValue

	self:__RefreshShow()
end

function EquipSortBtn:Hide()
	self.view.gameObject:SetActive(false)
end

function EquipSortBtn:__RefreshShow()
	if self.sortType == Constant.EquipScreenType.Suit then
		self:__ShowSuit()
	elseif self.sortType == Constant.EquipScreenType.Quality then
		self:__ShowQuality()
	elseif self.sortType == Constant.EquipScreenType.MainProperty then
		self:__ShowMainProperty()
	elseif self.sortType == Constant.EquipScreenType.SubProperty then
		self:__ShowSubProperty()
	else
		logError("EquipSortItem 数据错误，找不到对应的 sortType {0}", sortType)
	end
end

function EquipSortBtn:__ShowSuit()
	if self.sortValue == 0 then
		local contentData = EquipApi:GetAllSuitMenuContentData()

		self:__RefreshTextAndIcon(contentData.text, contentData.iconPath)
	else
		local suitCfg = EquipModule.GetSuitNeedCount(self.sortValue, 1)[1]

		self:__RefreshTextAndIcon(suitCfg.Name, suitCfg.SuitIcon)
	end
end

function EquipSortBtn:__ShowQuality()
	local contentData = EquipApi:GetEquipSortQualityContentData(self.sortValue)

	self:__RefreshTextAndIcon(contentData.text, contentData.iconPath)
end

function EquipSortBtn:__ShowMainProperty()
	if self.sortValue == 0 then
		local contentData = EquipApi:GetAllMainPropertyMenuContentData()

		self:__RefreshTextAndIcon(contentData.text, contentData.iconPath)
	else
		local cfgAttribute = CfgAttributeTable[self.sortValue]

		self:__RefreshTextAndIcon(cfgAttribute.Name, cfgAttribute.ImageUrl)
	end
end

function EquipSortBtn:__ShowSubProperty()
	if self.sortValue == 0 then
		local contentData = EquipApi:GetAllSubPropertyMenuContentData()

		self:__RefreshTextAndIcon(contentData.text, contentData.iconPath)
	else
		local cfgAttribute = CfgAttributeTable[self.sortValue]

		self:__RefreshTextAndIcon(cfgAttribute.Name, cfgAttribute.ImageUrl)
	end
end

function EquipSortBtn:__RefreshTextAndIcon(content, iconPath)
	self.content:GetComponent("Text").text = content

	if LuaUtility.StrIsNullOrEmpty(iconPath) then
		self.icon.gameObject:SetActive(false)
	else
		self.icon.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, iconPath, self.icon.gameObject:GetComponent("Image"))
	end
end

function EquipSortBtn:Dispose()
	AssetUtil.UnloadAsset(self)
	self.selectBtn:GetComponent("Button").onClick:RemoveListener(self.__OnSelectBtnClickEventProxy)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local EquipSortItem = {}

function EquipSortItem.New(view, sortType, selectEvent)
	local obj = Clone(EquipSortItem)

	obj:__Init(view, sortType, selectEvent)

	return obj
end

function EquipSortItem:__Init(view, sortType, selectEvent)
	self.view = view.gameObject
	self.sortType = sortType
	self.SelectEvent = selectEvent

	LuaCodeInterface.BindOutlet(self.view, self)

	function self.__SelectEventProxy(sortValue)
		if self.SelectEvent ~= nil then
			self.SelectEvent(self.sortType, sortValue)
		end
	end

	self.btnItem = EquipSortBtn.New(self.selectBtn, self.__SelectEventProxy)
end

function EquipSortItem:Show(values)
	self:__OnRefreshValue(values)
end

function EquipSortItem:__OnRefreshValue(values)
	self.btnItem:Show(self.sortType, values[1])
end

function EquipSortItem:UpdateSelect(isSelect)
	self.selectTag.gameObject:SetActive(isSelect)
end

function EquipSortItem:Dispose()
	self.btnItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local EquipSortSubPropertyItem = Clone(EquipSortItem)

function EquipSortSubPropertyItem.New(view, sortType, selectEvent)
	local obj = Clone(EquipSortSubPropertyItem)

	obj:__Init(view, sortType, selectEvent)
	obj:__InitEx()

	return obj
end

function EquipSortSubPropertyItem:__InitEx()
	self.sortItems = {}

	for i = 1, self.btnsRoot.transform.childCount do
		local child = self.btnsRoot.transform:GetChild(i - 1)
		local subBtn = EquipSortBtn.New(child, self.__SelectEventProxy)

		table.insert(self.sortItems, subBtn)
	end
end

function EquipSortSubPropertyItem:__OnRefreshValue(values)
	if values[1] == Constant.EquipSortNormalValue then
		self.btnItem:Show(Constant.EquipScreenType.SubProperty, Constant.EquipSortNormalValue)
		self.btnsRoot.gameObject:SetActive(false)

		return
	end

	self.btnItem:Hide()
	self.btnsRoot.gameObject:SetActive(true)
	ForArray(self.sortItems, function(_index, btnItem)
		if _index <= #values then
			btnItem:Show(Constant.EquipScreenType.SubProperty, values[_index])
		else
			btnItem:Hide()
		end
	end)
end

function EquipSortSubPropertyItem:Dispose()
	self.btnItem:Dispose()

	for i = 1, #self.sortItems do
		self.sortItems[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local SortSubItem = {
	sortValue = 0
}

function SortSubItem.New(view)
	local obj = Clone(SortSubItem)

	obj:__Init(view)

	return obj
end

function SortSubItem:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
end

function SortSubItem:Show(sortType, value)
	self.sortValue = value

	if sortType == Constant.EquipScreenType.Suit then
		self:__ShowSuit()
	elseif sortType == Constant.EquipScreenType.Quality then
		self:__ShowQuality()
	elseif sortType == Constant.EquipScreenType.MainProperty then
		self:__ShowMainProperty()
	elseif sortType == Constant.EquipScreenType.SubProperty then
		self:__ShowSubProperty()
	else
		logError("SortSubItem 数据错误，找不到对应的 sortType {0}", sortType)
	end
end

function SortSubItem:__ShowSuit()
	if self.sortValue == 0 then
		local contentData = EquipApi:GetAllSuitMenuContentData()

		self:__RefreshTextAndIcon(contentData.text, contentData.iconPath)
	else
		local suitCfg = EquipModule.GetSuitNeedCount(self.sortValue, 1)[1]

		self:__RefreshTextAndIcon(suitCfg.Name, suitCfg.SuitIcon)
	end

	self.numRoot.gameObject:SetActive(false)
end

function SortSubItem:__ShowQuality()
	local contentData = EquipApi:GetEquipSortQualityContentData(self.sortValue)

	self:__RefreshTextAndIcon(contentData.text, contentData.iconPath)
	self.numRoot.gameObject:SetActive(false)
end

function SortSubItem:__ShowMainProperty()
	if self.sortValue == 0 then
		local contentData = EquipApi:GetAllMainPropertyMenuContentData()

		self:__RefreshTextAndIcon(contentData.text, contentData.iconPath)
	else
		local cfgAttribute = CfgAttributeTable[self.sortValue]

		self:__RefreshTextAndIcon(cfgAttribute.Name, cfgAttribute.ImageUrl)
	end

	self.numRoot.gameObject:SetActive(false)
end

function SortSubItem:__ShowSubProperty()
	if self.sortValue == 0 then
		local contentData = EquipApi:GetAllSubPropertyMenuContentData()

		self:__RefreshTextAndIcon(contentData.text, contentData.iconPath)
	else
		local cfgAttribute = CfgAttributeTable[self.sortValue]

		self:__RefreshTextAndIcon(cfgAttribute.Name, cfgAttribute.ImageUrl)
	end

	self.numRoot.gameObject:SetActive(false)
end

function SortSubItem:__RefreshTextAndIcon(content, iconPath)
	self.content:GetComponent("Text").text = content

	if LuaUtility.StrIsNullOrEmpty(iconPath) then
		self.icon.gameObject:SetActive(false)
	else
		self.icon.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, iconPath, self.icon.gameObject:GetComponent("Image"))
	end
end

function SortSubItem:UpdateSelect(isSelect)
	self.selectRoot.gameObject:SetActive(isSelect)
	self.normalRoot.gameObject:SetActive(not isSelect)
end

function SortSubItem:UpdateSelectByTableData(table)
	local isSelect = false

	ForPairs(table, function(_, _id)
		if self.sortValue ~= _id then
			return
		end

		isSelect = true

		return true
	end)
	self:UpdateSelect(isSelect)
end

function SortSubItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local Panel = {
	sortType = 0,
	sortItems = {},
	subItemAreaCellList = {},
	sortData = {}
}

function Panel.New(view, callback)
	local obj = Clone(Panel)

	obj:__Init(view, callback)

	return obj
end

function Panel:__Init(view, callback)
	self.view = view
	self.sortCallback = callback

	LuaCodeInterface.BindOutlet(self.view, self)
	self:__InitDelegateFun()

	self.sortItems[Constant.EquipScreenType.Suit] = EquipSortItem.New(self.suitRoot, Constant.EquipScreenType.Suit, self.__OnSortItemSelectEventProxy)
	self.sortItems[Constant.EquipScreenType.Quality] = EquipSortItem.New(self.qualityRoot, Constant.EquipScreenType.Quality, self.__OnSortItemSelectEventProxy)
	self.sortItems[Constant.EquipScreenType.MainProperty] = EquipSortItem.New(self.mainPropertyRoot, Constant.EquipScreenType.MainProperty, self.__OnSortItemSelectEventProxy)
	self.sortItems[Constant.EquipScreenType.SubProperty] = EquipSortSubPropertyItem.New(self.subPropertyRoot, Constant.EquipScreenType.SubProperty, self.__OnSortItemSelectEventProxy)
	self.subItemAreaList = self.itemAreaListRoot:GetComponent("ScrollAreaList")

	function self.subItemAreaList.onRenderCell(cell)
		self:__OnRenderSubSelectItemCell(cell)
	end

	function self.subItemAreaList.onSelectedCell(cell)
		self:__OnSubSelectItemCellSelect(cell)
	end

	self:__AddListener()
end

function Panel:__InitDelegateFun()
	function self.__OnSortItemSelectEventProxy(_sortType)
		self:__OnSortItemSelect(_sortType)
	end

	function self.__OnCloseBGBtnClickEventProxy()
		self:Hide()
	end

	function self.__OnCloseBtnClickEventProxy()
		self:Hide()
	end

	function self.__OnResetBtnClickEventProxy()
		self:__Refresh(nil, self.sortType)
	end

	function self.__OnOkBtnClickEventProxy()
		if self.sortCallback ~= nil then
			self.sortCallback(self.sortData)
		end

		self:Hide()
	end
end

function Panel:__AddListener()
	self.closeBG:GetComponent("Button").onClick:AddListener(self.__OnCloseBGBtnClickEventProxy)
	self.resetBtn:GetComponent("Button").onClick:AddListener(self.__OnResetBtnClickEventProxy)
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__OnCloseBtnClickEventProxy)
	self.okBtn:GetComponent("Button").onClick:AddListener(self.__OnOkBtnClickEventProxy)
end

function Panel:__RemoveListener()
	self.closeBG:GetComponent("Button").onClick:RemoveListener(self.__OnCloseBGBtnClickEventProxy)
	self.resetBtn:GetComponent("Button").onClick:RemoveListener(self.__OnResetBtnClickEventProxy)
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__OnCloseBtnClickEventProxy)
	self.okBtn:GetComponent("Button").onClick:RemoveListener(self.__OnOkBtnClickEventProxy)
end

function Panel:Show(sortData)
	self.view.gameObject:SetActive(true)
	self:__Refresh(sortData, Constant.EquipScreenType.Suit)
end

function Panel:__Refresh(sortData, selectSortType)
	self.sortData = sortData == nil and EquipScreenData.New() or sortData

	ForPairs(self.sortItems, function(_sortType, _item)
		_item:Show(self.sortData:GetSelectIDs(_sortType))
	end)
	self:__OnSortItemSelect(selectSortType)
end

function Panel:__OnSortItemSelect(sortType)
	self.sortType = sortType

	ForPairs(self.sortItems, function(_sortType, _item)
		if _sortType ~= sortType then
			_item:UpdateSelect(false)

			return
		end

		_item:UpdateSelect(true)
		self:__ShowSubSelectItems(_sortType)
	end)
end

function Panel:__ShowSubSelectItems(sortType)
	self.subItemDataList = EquipModule.GetEquipScreenSubMenuList(sortType)

	self.subItemAreaList:Refresh(#self.subItemDataList + 1)
end

function Panel:__OnRenderSubSelectItemCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local subItem = self.subItemAreaCellList[insID]

	if subItem == nil then
		subItem = SortSubItem.New(cell.gameObject)
		self.subItemAreaCellList[insID] = subItem
	end

	if cell.index == 0 then
		subItem:Show(self.sortType, 0)
	else
		local cid = self.subItemDataList[cell.index]

		subItem:Show(self.sortType, EquipModule.GetEquipScreenSubMenuData(cid).Value)
	end

	local newSelectData = self.sortData:GetSelectIDs(self.sortType)

	subItem:UpdateSelectByTableData(newSelectData)
end

function Panel:__OnSubSelectItemCellSelect(cell)
	local insID = cell.gameObject:GetInstanceID()
	local subItem = self.subItemAreaCellList[insID]

	self.sortData:UpdateValue(self.sortType, subItem.sortValue)

	local newSelectData = self.sortData:GetSelectIDs(self.sortType)

	self.sortItems[self.sortType]:__OnRefreshValue(newSelectData)
	self:__OnRefreshSubSelectItemsShow(newSelectData)
end

function Panel:__OnRefreshSubSelectItemsShow(newSelectData)
	ForPairs(self.subItemAreaCellList, function(k, _subItem)
		_subItem:UpdateSelectByTableData(newSelectData)
	end)
end

function Panel:Hide()
	self.view.gameObject:SetActive(false)
end

function Panel:Dispose()
	self:__RemoveListener()
	ForPairs(self.sortItems, function(_sortType, _item)
		_item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

return Panel
