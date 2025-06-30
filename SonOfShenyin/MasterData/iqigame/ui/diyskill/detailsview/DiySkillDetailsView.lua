-- chunkname: @IQIGame\\UI\\DiySkill\\DetailsView\\DiySkillDetailsView.lua

local DiySkillDetailsTopElement = require("IQIGame.UI.DiySkill.DetailsView.DiySkillDetailsTopElement")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local DIYSkillAttCompareCellClass = require("IQIGame/UI/DiySkill/DetailsView/DIYSkillAttCompareCell")
local AttributeItem = {}

function AttributeItem.New(view)
	local obj = Clone(AttributeItem)

	obj:__Init(view)

	return obj
end

function AttributeItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function AttributeItem:Hide()
	self.gameObject:SetActive(false)
end

function AttributeItem:Show(propertyData)
	self.gameObject:SetActive(true)

	local attributeData = CfgAttributeTable[propertyData.type]

	UGUIUtil.SetText(self.attNameText, attributeData.Name)
	UGUIUtil.SetText(self.attNumText, propertyData.curLvValue == nil and 0 or propertyData.curLvValue)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attributeData.ImageUrl), self.attIcon:GetComponent("Image"))
end

function AttributeItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local DiySkillDetailsView = {}

function DiySkillDetailsView.New(view)
	local obj = Clone(DiySkillDetailsView)

	obj:__Init(view)

	return obj
end

function DiySkillDetailsView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.topElement = DiySkillDetailsTopElement.New(self.topParent)

	self.attPrefab:SetActive(false)

	local attPrefabParent = self.attPrefab.transform.parent

	self.attrObjectPool = UIViewObjectPool.New(self.attPrefab, attPrefabParent, function(_view)
		return AttributeItem.New(_view)
	end)

	LuaUtility.SetGameObjectShow(self.attComparePrefab, false)

	self.attComparePool = UIViewObjectPool.New(self.attComparePrefab, attPrefabParent, function(_view)
		return DIYSkillAttCompareCellClass.New(_view, self)
	end)

	self:__AddListeners()
end

function DiySkillDetailsView:__AddListeners()
	return
end

function DiySkillDetailsView:__RemoveListeners()
	return
end

function DiySkillDetailsView:Dispose()
	self:__RemoveListeners()
	self.topElement:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillDetailsView:Show(skillData)
	self.topElement:Show(skillData)
	self:__RefreshProperty(skillData)
	self:__RefreshRefineEffect(skillData)
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function DiySkillDetailsView:ShowCompare(heroCid, skillPos, skillData)
	self.topElement:ShowCompare(heroCid, skillPos, skillData)
	self:RefreshCompareProperty(heroCid, skillPos, skillData)
	self:__RefreshRefineEffect(skillData)
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function DiySkillDetailsView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function DiySkillDetailsView:__RefreshProperty(skillData)
	UGUIUtil.SetText(self.attTitleText, DiySkillStrengthenUIApi:GetBasePropertyTitle())

	self.SkillAttributes = {}

	self.attrObjectPool:ForItems(function(item)
		item:Hide()
	end)
	self.attComparePool:ForItems(function(item)
		item:Hide()
	end)

	local attrTable = DiySkillModule.GetSkillTotalAttributes(skillData, Constant.DIYSkillDisplayAttrTable)

	ForPairs(attrTable, function(_attrType, _attrValue)
		local propertyItem = self.attrObjectPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		propertyItem:Show({
			type = _attrType,
			curLvValue = _attrValue
		})
	end)
end

function DiySkillDetailsView:RefreshCompareProperty(heroCid, skillPos, skillData)
	self.skillCompareCellData = {}

	self.attrObjectPool:ForItems(function(item)
		item:Hide()
	end)
	self.attComparePool:ForItems(function(item)
		item:Hide()
	end)

	local currentAttrTable
	local currentSkillData = RoleDevelopmentModule.GetCurHeroSkill(heroCid)[skillPos]

	if currentSkillData ~= nil then
		currentAttrTable = DiySkillModule.GetSkillTotalAttributes(currentSkillData, Constant.DIYSkillDisplayAttrTable)
	end

	local baseAttrTable = DiySkillModule.GetSkillTotalAttributes(skillData, Constant.DIYSkillDisplayAttrTable)

	ForPairs(baseAttrTable, function(_attrType, _attrValue)
		local attrData = {}

		attrData.type = _attrType
		attrData.targetValue = _attrValue

		if currentAttrTable ~= nil then
			attrData.currentValue = currentAttrTable[_attrType]
		end

		if attrData.currentValue == nil then
			attrData.currentValue = 0
		end

		local propertyItem = self.attComparePool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		propertyItem:Refresh(attrData)
		propertyItem:Show()
	end)
end

function DiySkillDetailsView:__RefreshRefineEffect(skillData)
	local refineCfg = DiySkillModule.GetSkillRefineCfg(skillData.skillCid, skillData.purifyLv)

	UGUIUtil.SetText(self.refineText, skillData.purifyLv)

	if refineCfg == nil then
		self.skilEffctParent:SetActive(false)

		return
	end

	self.skilEffctParent:SetActive(true)
	UGUIUtil.SetText(self.effctTitleText, DiySkillStrengthenUIApi:GetRefineEffectTitle())
	self.effctNameText:SetActive(false)
	UGUIUtil.SetText(self.effctContentText, refineCfg.SkillTips)
	UGUIUtil.SetText(self.descContentText, refineCfg.SkillStory)
end

return DiySkillDetailsView
