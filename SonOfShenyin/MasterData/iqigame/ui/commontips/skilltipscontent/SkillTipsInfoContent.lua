-- chunkname: @IQIGame\\UI\\CommonTips\\SkillTipsContent\\SkillTipsInfoContent.lua

local TipsSourcesElement = require("IQIGame.UI.CommonTips.Element.TipsSourcesElement")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local __SkillPropertyItem = {}

function __SkillPropertyItem.New(view)
	local obj = Clone(__SkillPropertyItem)

	obj:__Init(view)

	return obj
end

function __SkillPropertyItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function __SkillPropertyItem:Show(propertyData)
	self.gameObject:SetActive(true)

	local attributeData = CfgAttributeTable[propertyData.type]

	UGUIUtil.SetText(self.attNameText, attributeData.Name)
	UGUIUtil.SetText(self.attNumText, propertyData.curLvValue == nil and 0 or propertyData.curLvValue)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attributeData.ImageUrl), self.attQualityImg:GetComponent("Image"))
end

function __SkillPropertyItem:Hide()
	self.gameObject:SetActive(false)
end

function __SkillPropertyItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SkillTipsInfoContent = {}

SkillTipsInfoContent.SkillPropertyItem = __SkillPropertyItem

function SkillTipsInfoContent.New(view)
	local obj = Clone(SkillTipsInfoContent)

	obj:__Init(view)

	return obj
end

function SkillTipsInfoContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.sourcesElement = TipsSourcesElement.New(self.TipsSourcesContent)

	self.attItemPrefab:SetActive(false)

	local attItemPrefabParent = self.attItemPrefab.transform.parent.transform

	self.propertyItemPool = UIViewObjectPool.New(self.attItemPrefab, attItemPrefabParent, function(_view)
		return self.SkillPropertyItem.New(_view)
	end)

	self:__AddListeners()
end

function SkillTipsInfoContent:__AddListeners()
	return
end

function SkillTipsInfoContent:__RemoveListeners()
	return
end

function SkillTipsInfoContent:Dispose()
	self:__RemoveListeners()
	self.sourcesElement:Dispose()
	self.propertyItemPool:ForItems(function(item)
		item:Dispose()
	end)

	self.propertyItemPool = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SkillTipsInfoContent:SetData(userData, params)
	self.Content:SetActive(false)

	local skillData = userData.skillData

	self:__RefreshProperty(skillData)

	local skillLevelCfg = skillData:GetSkillCfgByLevel()
	local skillRefineCfg = skillData:GetSkillRefineInfo()

	if skillRefineCfg == nil then
		UGUIUtil.SetText(self.skillEffectText, skillLevelCfg.SkillTips)
	else
		UGUIUtil.SetText(self.skillEffectText, skillRefineCfg.SkillTips)
	end

	UGUIUtil.SetText(self.skillBackstoryText, skillLevelCfg.SkillStory)

	if params.hideSource then
		self.sourcesElement:Hide()
	else
		self.sourcesElement:Show(userData:GetCfg().Source)
	end

	self.Content:SetActive(true)

	self.Content.transform.localPosition = Vector3.New(0, 0, 0)
end

function SkillTipsInfoContent:__RefreshProperty(skillData)
	self.propertyItemPool:ForItems(function(item)
		item:Hide()
	end)

	if skillData.id == 0 then
		return
	end

	local attrTable = DiySkillModule.GetSkillTotalAttributes(skillData, Constant.DIYSkillDisplayAttrTable)

	ForPairs(attrTable, function(_attrType, _attrValue)
		local propertyItem = self.propertyItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		propertyItem:Show({
			type = _attrType,
			curLvValue = _attrValue
		})
	end)
end

return SkillTipsInfoContent
