-- chunkname: @IQIGame\\UI\\Common\\CommonEquipPopupListView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local UIPopupList = require("IQIGame.UI.Common.PopupList.UIPopupList")
local UIPopupListPopupBtn = require("IQIGame.UI.Common.PopupList.UIPopupListPopupBtn")
local UIPopupListItem = require("IQIGame.UI.Common.PopupList.UIPopupListItem")
local SubItem = {}

function SubItem.New(view)
	local obj = Clone(SubItem)

	obj:__Init(view)

	return obj
end

function SubItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function SubItem:Show(id, isSelect)
	self.gameObject:SetActive(true)
	UGUIUtil.SetText(self.attNameText, EquipApi:GetPopupListItemSubText(isSelect, id))
	self.selectImg:SetActive(isSelect)
	self.normalImg:SetActive(not isSelect)
end

function SubItem:Hide()
	self.gameObject:SetActive(false)
end

function SubItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local ListItem = Clone(UIPopupListItem)

function ListItem.New(view, clickEvent)
	local obj = Clone(ListItem)

	obj:__Init(view, clickEvent)

	return obj
end

ListItem.subItemPool = nil

function ListItem:ExtendInitFunc()
	self.attItemPrefab:SetActive(false)

	self.subItemPool = UIViewObjectPool.New(self.attItemPrefab, self.suitAttGrid.transform, function(_view)
		return SubItem.New(_view)
	end)
end

function ListItem:ExtendShowFunc(_data, _isSelect)
	local suitsCfg = EquipModule.GetSuitConfigListBySuitID(_data.suitID, Constant.Equip.SuitType.Normal)
	local suitCfg = suitsCfg[1]

	self.selectImg:SetActive(_isSelect)
	self.subItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, #suitCfg.SuitTips do
		local subItem = self.subItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		subItem:Show(suitCfg.SuitTips[i], _isSelect)
	end

	UGUIUtil.SetText(self.equipsuitNameText, UIGlobalApi.GetPopupListItemText(_isSelect, suitCfg.Name))
	UGUIUtil.SetText(self.haveText, _data.num)
end

function ListItem:ExtendDisposeFunc()
	self.subItemPool:Dispose(function(_item)
		_item:Dispose()
	end)
end

local PopupButton = Clone(UIPopupListPopupBtn)

function PopupButton.New(view, clickEventHandler)
	local obj = Clone(PopupButton)

	obj:__Init(view, clickEventHandler)

	return obj
end

function PopupButton:ExtendShowFunc(data, isSelect)
	if isSelect then
		self.NormalState:SetActive(false)
		self.SelectState:SetActive(true)
	else
		self.NormalState:SetActive(true)
		self.SelectState:SetActive(false)
	end

	local text = EquipApi:GetPopupListButtonStaticText()

	if data ~= nil then
		local suitsCfg = EquipModule.GetSuitConfigListBySuitID(data.suitID, Constant.Equip.SuitType.Normal)

		text = suitsCfg[1].Name
	end

	UGUIUtil.SetText(self.DescText, UIGlobalApi.GetPopupListButtonText(isSelect, text))
end

local CommonEquipPopupListView = Clone(UIPopupList)

function CommonEquipPopupListView.GetAllEquipSuitData(equipsData)
	local tempMap = EquipModule.GetSuitIDNameMap(Constant.Equip.SuitType.Normal)
	local result = {}

	for _id, _name in pairs(tempMap) do
		local resultItem = {}

		resultItem.suitID = _id
		resultItem.num = 10

		table.insert(result, resultItem)
	end

	table.sort(result, function(a, b)
		return a.suitID > b.suitID
	end)

	return result
end

function CommonEquipPopupListView.GetOwnerEquipSuitData(equipsData)
	local tempData = {}

	for i = 1, #equipsData do
		local data = equipsData[i]

		if data.equipData ~= nil then
			local suitId = data.equipData:GetCfg().SuitId[1]

			if tempData[suitId] == nil then
				tempData[suitId] = 0
			end

			tempData[suitId] = tempData[suitId] + 1
		end
	end

	local result = {}

	for _id, _cnt in pairs(tempData) do
		local resultItem = {}

		resultItem.suitID = _id
		resultItem.num = _cnt

		table.insert(result, resultItem)
	end

	table.sort(result, function(a, b)
		return a.suitID > b.suitID
	end)

	return result
end

function CommonEquipPopupListView.New(view, selectChangeEvent)
	local obj = Clone(CommonEquipPopupListView)

	obj:__Init(view, PopupButton, ListItem, selectChangeEvent)

	return obj
end

return CommonEquipPopupListView
