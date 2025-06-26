-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionEquipStrengthenInfo.lua

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local EvilErosionEquipAttrItem = require("IQIGame.UI.EvilErosion.EvilErosionEquipAttrItem")
local EvilErosionEquipPabilityItem = require("IQIGame.UI.EvilErosion.EvilErosionEquipPabilityItem")
local m = {
	AttrItems = {},
	PabilityItems = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.AttrParent = self.AttrPrefab.transform.parent

	self.AttrPrefab:SetActive(false)

	self.AttrItemPool = UIObjectPool.New(3, function()
		self.AttrPrefab:SetActive(true)

		local item = EvilErosionEquipAttrItem.New(UnityEngine.Object.Instantiate(self.AttrPrefab))

		self.AttrPrefab:SetActive(false)

		return item
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.PabilityParent = self.PabilityPrefab.transform.parent

	self.PabilityPrefab:SetActive(false)

	self.PabilityItemPool = UIObjectPool.New(1, function()
		self.PabilityPrefab:SetActive(true)

		local item = EvilErosionEquipPabilityItem.New(UnityEngine.Object.Instantiate(self.PabilityPrefab))

		self.PabilityPrefab:SetActive(false)

		return item
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function m:SetData(itemData, previewAddStar)
	local cfgSoulPaintingQualityData = EvilErosionModule.GetQualityCfg(itemData, previewAddStar)
	local attrIds = {}

	for i = 1, #cfgSoulPaintingQualityData.MainBility do
		table.insert(attrIds, cfgSoulPaintingQualityData.MainBility[i])
	end

	table.sort(attrIds, function(id1, id2)
		return id1 < id2
	end)

	local attrIdValueMap = EquipModule.GetMainAbilityValue(cfgSoulPaintingQualityData, itemData.equipData.lv)

	self:ClearAttrItem()

	for i = 1, #attrIds do
		local attrItem = self.AttrItemPool:Obtain()

		attrItem.View:SetActive(true)
		attrItem.View.transform:SetParent(self.AttrParent, false)

		local attrId = attrIds[i]

		attrItem:SetData(attrId, attrIdValueMap[attrId])

		self.AttrItems[i] = attrItem
	end

	local pabilityCids = {}
	local cfgItemData = itemData:GetCfg()

	for i = 3, #cfgItemData.PabilityID do
		local allStarPabilityCids = cfgItemData.PabilityID[i]

		table.insert(pabilityCids, allStarPabilityCids[itemData.equipData.star + previewAddStar])
	end

	table.sort(pabilityCids, function(id1, id2)
		return id1 < id2
	end)
	self:ClearPabilityItem()

	for i = 1, #pabilityCids do
		local pabilityItem = self.PabilityItemPool:Obtain()

		pabilityItem.View:SetActive(true)
		pabilityItem.View.transform:SetParent(self.PabilityParent, false)
		pabilityItem:SetData(pabilityCids[i])

		self.PabilityItems[i] = pabilityItem
	end
end

function m:ClearAttrItem()
	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]

		item.View.transform:SetParent(self.View.transform, false)
		item.View:SetActive(false)
		self.AttrItemPool:Release(item)
	end

	self.AttrItems = {}
end

function m:ClearPabilityItem()
	for i = 1, #self.PabilityItems do
		local item = self.PabilityItems[i]

		item.View.transform:SetParent(self.View.transform, false)
		item.View:SetActive(false)
		self.PabilityItemPool:Release(item)
	end

	self.PabilityItems = {}
end

function m:Dispose()
	self:ClearAttrItem()
	self:ClearPabilityItem()
	self.AttrItemPool:Dispose()
	self.PabilityItemPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.AttrParent = nil
end

return m
