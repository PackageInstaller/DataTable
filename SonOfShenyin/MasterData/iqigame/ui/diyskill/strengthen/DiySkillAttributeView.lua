-- chunkname: @IQIGame\\UI\\DiySkill\\Strengthen\\DiySkillAttributeView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
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

function AttributeItem:Show(attrData, maxLevel)
	self.gameObject:SetActive(true)

	local attrCfg = CfgAttributeTable[attrData.type]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attrCfg.ImageUrl), self.attIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.attNameText, attrCfg.Name)
	UGUIUtil.SetText(self.attNumText, attrData.curLvValue == nil and 0 or attrData.curLvValue)

	if attrData.curLvValue == attrData.nextLvValue then
		LuaUtility.SetGameObjectShow(self.previewNumParent, false)
		LuaUtility.SetText(self.textPreviewNormal, attrData.curLvValue == nil and 0 or attrData.curLvValue)
		LuaUtility.SetGameObjectShow(self.previewNormalRoot, true)
	else
		LuaUtility.SetGameObjectShow(self.previewNumParent, true)
		LuaUtility.SetGameObjectShow(self.previewNormalRoot, false)
		LuaUtility.SetText(self.previewNumText, attrData.nextLvValue)
	end

	if maxLevel then
		LuaUtility.SetGameObjectShow(self.previewNormalRoot, false)
		LuaUtility.SetGameObjectShow(self.previewNumParent, false)
	end
end

function AttributeItem:Hide()
	self.gameObject:SetActive(false)
end

function AttributeItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local DiySkillAttributeView = {}

function DiySkillAttributeView.New(view)
	local obj = Clone(DiySkillAttributeView)

	obj:__Init(view)

	return obj
end

function DiySkillAttributeView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.attPrefab:SetActive(false)

	local attPrefabParent = self.attPrefab.transform.parent

	self.attributeObjectPool = UIViewObjectPool.New(self.attPrefab, attPrefabParent, function(_view)
		return AttributeItem.New(_view)
	end)

	self:__AddListeners()
end

function DiySkillAttributeView:__AddListeners()
	return
end

function DiySkillAttributeView:__RemoveListeners()
	return
end

function DiySkillAttributeView:Dispose()
	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillAttributeView:Show(attributesData, maxLevel)
	self.gameObject:SetActive(true)
	self.attributeObjectPool:ForItems(function(_item)
		_item:Hide()
	end)
	table.sort(attributesData, function(a, b)
		return a.type < b.type
	end)

	for i = 1, #attributesData do
		local item = self.attributeObjectPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		item:Show(attributesData[i], maxLevel)
	end
end

function DiySkillAttributeView:Hide()
	self.gameObject:SetActive(false)
end

return DiySkillAttributeView
