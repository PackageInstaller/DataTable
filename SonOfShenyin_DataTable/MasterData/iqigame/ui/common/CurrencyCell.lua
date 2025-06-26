-- chunkname: @IQIGame\\UI\\Common\\CurrencyCell.lua

CurrencyCell = {
	itemList = {},
	BindLuaTable = {}
}

local currencyItemCell = require("IQIGame.UI.Common.CurrencyItemCell")

function CurrencyCell.New(parent)
	local obj = Clone(CurrencyCell)

	obj:Initialize(parent)

	return obj
end

function CurrencyCell:Initialize(parent)
	self:LoadCurrencyCellGameObject()

	self.Parent = parent
	self.cfgId = nil
end

function CurrencyCell:LoadCurrencyCellGameObject()
	local path = UIGlobalApi.GetMoneyCellAssetPath()

	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed)
end

function CurrencyCell:OnLoadSucceed(assetName, asset, duration, userData)
	self.gameObject = UnityEngine.Object.Instantiate(asset)

	self:Init()
end

function CurrencyCell:Init()
	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.gameObject.transform:SetParent(self.Parent.transform, false)
	LuaUtility.SetAnchoredPositionWithRectTransform(LuaUtility.GetComponent(self.gameObject, "RectTransform"), 0, 0)

	if self.cfgId ~= nil then
		self:RefreshSubItem(self.cfgId)
	end
end

function CurrencyCell:RefreshItem(cfgId)
	self.cfgId = cfgId

	if self.gameObject ~= nil then
		self:RefreshSubItem(self.cfgId)
	end
end

function CurrencyCell:RefreshSubItem(cfgId)
	self.cfgId = cfgId == nil and self.cfgId or cfgId
	self.ShowCidList = CfgTopMoneyTable[self.cfgId].TypeArr
	self.JumpIdList = CfgTopMoneyTable[self.cfgId].JumpType

	for _, v in pairs(self.itemList) do
		v:Hide()
	end

	for i, v in ipairs(self.ShowCidList) do
		local itemCell = self:CreatCurrencyItemCell(i, v)

		itemCell:SetData(v, self.JumpIdList[i])
		itemCell:Show()
	end

	self.cfgId = nil
end

function CurrencyCell:CreatCurrencyItemCell(index, v)
	local itemcell = self.itemList[index]

	if itemcell == nil then
		local itemCellObj = UnityEngine.Object.Instantiate(self.ItemPrefab)

		itemCellObj.transform:SetParent(self.MoneyGrid.transform, false)

		itemCellObj.name = v
		itemcell = currencyItemCell.New(itemCellObj)
		self.itemList[index] = itemcell
	end

	return itemcell
end

function CurrencyCell:Dispose()
	for _, v in ipairs(self.itemList) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.Parent, self)

	self.Parent = nil
end
