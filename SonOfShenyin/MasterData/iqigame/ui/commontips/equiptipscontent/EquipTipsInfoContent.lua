-- chunkname: @IQIGame\\UI\\CommonTips\\EquipTipsContent\\EquipTipsInfoContent.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local TipsSourcesElement = require("IQIGame.UI.CommonTips.Element.TipsSourcesElement")
local EquipTipsSuitElement = require("IQIGame.UI.CommonTips.Element.EquipTipsSuitElement")
local __attributeItem = {}

function __attributeItem.New(view)
	local obj = Clone(__attributeItem)

	obj:__Init(view)

	return obj
end

function __attributeItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function __attributeItem:Hide()
	self.gameObject:SetActive(false)
end

function __attributeItem:Show(attributeData, unlockLevel)
	local qualityPath
	local isLocked = attributeData.OldAddAttNum == 0

	self.attNumText:SetActive(not isLocked)
	self.attLockText:SetActive(isLocked)

	if isLocked then
		self.attLockText:GetComponent("Text").text = EquipApi:GetUnLockLvDescribute(unlockLevel)
		qualityPath = EquipApi:GetNewEquipOtherAttriActiveBgPath(0)
	else
		self.attNumText:GetComponent("Text").text = EquipApi:GetTextAddDescribe(attributeData.AddAttNum)

		local qualityValue = EquipModule.GetQualityByAttribute(attributeData.id, attributeData.OldAddAttNum)

		qualityPath = EquipApi:GetNewEquipOtherAttriActiveBgPath(qualityValue)
	end

	local attrInerval = CfgEquipAttrTable[attributeData.onlyId].AttrShowRange
	local attrCfg = CfgAttributeTable[attributeData.id]

	UGUIUtil.SetText(self.intervalText, string.format("[%s-%s]", EquipApi:FormatAttrValue(attrCfg.IsPer, attrInerval[1]), EquipApi:FormatAttrValue(attrCfg.IsPer, attrInerval[2])))
	LuaUtility.SetGameObjectShow(self.attQualityImg, false)

	self.attNameText:GetComponent("Text").text = attributeData.Name

	self.gameObject:SetActive(true)
end

function __attributeItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local EquipTipsInfoContent = {}

EquipTipsInfoContent.AttributeItem = __attributeItem
EquipTipsInfoContent.SuitItem = __suitItem

function EquipTipsInfoContent.New(view)
	local obj = Clone(EquipTipsInfoContent)

	obj:__Init(view)

	return obj
end

function EquipTipsInfoContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.sourcesElement = TipsSourcesElement.New(self.TipsSourcesContent)

	self.attItemPrefab:SetActive(false)

	local attributeItemParent = self.attItemPrefab.transform.parent.transform

	self.attributeItemPool = UIViewObjectPool.New(self.attItemPrefab, attributeItemParent, function(_view)
		return self.AttributeItem.New(_view)
	end)
	self.suitElement = EquipTipsSuitElement.New(self.suitEffectParent)
	self.suitAwakenElement = EquipTipsSuitElement.New(self.suitAwakenEffectParent)

	self:__AddListeners()
end

function EquipTipsInfoContent:__AddListeners()
	return
end

function EquipTipsInfoContent:__RemoveListeners()
	return
end

function EquipTipsInfoContent:Dispose()
	self:__RemoveListeners()
	self.sourcesElement:Dispose()
	self.attributeItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.attributeItemPool = nil

	self.suitElement:Dispose()

	self.suitElement = nil

	self.suitAwakenElement:Dispose()

	self.suitAwakenElement = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipTipsInfoContent:SetData(itemData, params)
	self.Content:SetActive(false)

	local cfgData = itemData:GetCfg()

	self:__RefreshAttribute(itemData.equipData)

	local equipCfg = itemData.equipData:GetEquipCfg()
	local suitId = equipCfg.SuitId[1]

	self.suitElement:SetData(suitId, Constant.Equip.SuitType.Normal)
	self.suitAwakenElement:SetData(suitId, Constant.Equip.SuitType.Awaken)
	self.suitElement:Show()
	self.suitAwakenElement:Show()
	LuaUtility.SetGameObjectShow(self.awakenInfo, false)

	if LuaUtility.StrIsNullOrEmpty(cfgData.ItemStory) then
		self.equipBackstoryText:SetActive(false)
	else
		self.equipBackstoryText:SetActive(true)

		self.equipBackstoryText:GetComponent("Text").text = cfgData.ItemTips
	end

	if params.hideSource then
		self.sourcesElement:Hide()
	else
		self.sourcesElement:Show(cfgData.Source)
	end

	self.Content:SetActive(true)

	self.Content.transform.localPosition = Vector3.New(0, 0, 0)
end

function EquipTipsInfoContent:__RefreshAttribute(equipData)
	self.attributeItemPool:ForItems(function(item)
		item:Hide()
	end)

	local attributes = equipData.baseAttribute.Other

	for i = 1, #attributes do
		local item = self.attributeItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		item:Show(attributes[i], equipData:GetEquipCfg().CountCondition[i])
	end
end

function EquipTipsInfoContent:SetEquipmentSeatActive(active)
	self.equipmentSeatItemGo.gameObject:SetActive(active)
end

return EquipTipsInfoContent
