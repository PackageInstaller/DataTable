-- chunkname: @IQIGame\\UI\\AttributeDetailsUI.lua

local AttributeDetailsUI = {
	showBg = false,
	baseAttributsItemList = {},
	advancedAttributeItemList = {},
	baseDic = {},
	advanceDic = {}
}

AttributeDetailsUI = Base:Extend("AttributeDetailsUI", "IQIGame.Onigao.UI.AttributeDetailsUI", AttributeDetailsUI)

local attributeItemCell = require("IQIGame.UI.Attribute.AttributeItemCell")

function AttributeDetailsUI:OnInit()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function AttributeDetailsUI:GetPreloadAssetPaths()
	return nil
end

function AttributeDetailsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AttributeDetailsUI:IsManualShowOnOpen(userData)
	return false
end

function AttributeDetailsUI:GetBGM(userData)
	return nil
end

function AttributeDetailsUI:OnOpen(userData)
	self.heroCid = userData.heroCid
	self.Type = userData.type

	if self.Type == Constant.AttributeUIType.HeroAttribute then
		self.heroAttributs = WarlockModule.WarlockDataDic[self.heroCid].AttributeDir
	else
		self.heroAttributs = EquipModule.EquipAttr2HeroAttrText(WarlockModule.WarlockDataDic[self.heroCid])
	end

	self:InitAttribute()
	self:RefreshAttribute()
end

function AttributeDetailsUI:OnClose(userData)
	return
end

function AttributeDetailsUI:OnAddListeners()
	return
end

function AttributeDetailsUI:OnRemoveListeners()
	return
end

function AttributeDetailsUI:OnPause()
	return
end

function AttributeDetailsUI:OnResume()
	return
end

function AttributeDetailsUI:OnCover()
	return
end

function AttributeDetailsUI:OnReveal()
	return
end

function AttributeDetailsUI:OnRefocus(userData)
	return
end

function AttributeDetailsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AttributeDetailsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AttributeDetailsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AttributeDetailsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AttributeDetailsUI:OnDestroy()
	for k, v in pairs(self.advancedAttributeItemList) do
		v:Dispose()
	end

	for k, v in pairs(self.baseAttributsItemList) do
		v:Dispose()
	end

	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

function AttributeDetailsUI:InitAttribute()
	self.baseDic = {}
	self.advanceDic = {}

	if self.Type == Constant.AttributeUIType.HeroAttribute then
		for i, v in pairs(self.heroAttributs) do
			if CfgAttributeTable[v.attType].Type == 1 then
				table.insert(self.baseDic, v)
			elseif CfgAttributeTable[v.attType].Type == 2 then
				table.insert(self.advanceDic, v)
			end
		end
	else
		for k, v in pairs(self.heroAttributs.BaseAttributeDict) do
			table.insert(self.baseDic, {
				attType = k,
				attBaseValue = v
			})
		end

		for k, v in pairs(self.heroAttributs.AdvancedAttributeDict) do
			table.insert(self.advanceDic, {
				attType = k,
				attBaseValue = v
			})
		end
	end

	table.sort(self.baseDic, function(a, b)
		return CfgAttributeTable[a.attType].Sort < CfgAttributeTable[b.attType].Sort
	end)
	table.sort(self.advanceDic, function(a, b)
		return CfgAttributeTable[a.attType].Sort < CfgAttributeTable[b.attType].Sort
	end)
end

function AttributeDetailsUI:RefreshAttribute()
	self:RefreshBaseAttribute()
	self:RefreshAdvancedAttribute()
end

function AttributeDetailsUI:RefreshBaseAttribute()
	self:RefreshAttributeItemData(self.baseDic, self.baseAttributsItemList, self.BaseAttrGrid)
end

function AttributeDetailsUI:RefreshAdvancedAttribute()
	self:RefreshAttributeItemData(self.advanceDic, self.advancedAttributeItemList, self.AdvancedAttrGrid)
end

function AttributeDetailsUI:RefreshAttributeItemData(attrDatas, itemListTable, parent)
	for k, v in pairs(itemListTable) do
		v:Hide()
	end

	for i = 1, #attrDatas do
		local attributeItem = self:CreateAttributeItem(i, itemListTable, parent)

		self.showBg = not self.showBg

		attributeItem:SetData(attrDatas[i], self.Type == Constant.AttributeUIType.HeroAttribute, self.showBg)
		attributeItem:Show()
	end
end

function AttributeDetailsUI:CreateAttributeItem(index, attrItemTable, parent)
	local attributeItem = attrItemTable[index]

	if attributeItem == nil then
		local obj = UnityEngine.Object.Instantiate(self.AttrItemPrefab)

		obj.transform:SetParent(parent.transform, false)

		attributeItem = attributeItemCell.New(obj)
		attrItemTable[index] = attributeItem
	end

	return attributeItem
end

return AttributeDetailsUI
