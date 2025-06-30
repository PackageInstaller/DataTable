-- chunkname: @IQIGame\\UI\\EquipUpLevelTipUI\\EquipUpLevelTip_AttrItem.lua

local EquipUpLevelTip_AttrItem = {}

function EquipUpLevelTip_AttrItem.New(go, mainView)
	local o = Clone(EquipUpLevelTip_AttrItem)

	o:Initialize(go, mainView)

	return o
end

function EquipUpLevelTip_AttrItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function EquipUpLevelTip_AttrItem:InitComponent()
	self.icon = self.icon:GetComponent("Image")
end

function EquipUpLevelTip_AttrItem:InitDelegate()
	return
end

function EquipUpLevelTip_AttrItem:AddListener()
	return
end

function EquipUpLevelTip_AttrItem:RemoveListener()
	return
end

function EquipUpLevelTip_AttrItem:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function EquipUpLevelTip_AttrItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function EquipUpLevelTip_AttrItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function EquipUpLevelTip_AttrItem:Refresh(lastAttribute, attribute)
	local cfgAttribute = CfgUtil.GetCfgAttributeDataWithID(attribute.attrType)

	LuaUtility.SetText(self.textName, cfgAttribute.Name)
	LuaUtility.SetText(self.textValue, CommonEquipTipsUIApi:GetMainAttributeText(EquipApi:FormatAttrValue(cfgAttribute.IsPer, attribute.attrValue)))
	LuaUtility.SetText(self.textLastValue, CommonEquipTipsUIApi:GetMainAttributeText(EquipApi:FormatAttrValue(cfgAttribute.IsPer, lastAttribute.attrValue)))
	LuaUtility.LoadImage(self, UIGlobalApi.IconPath .. cfgAttribute.ImageUrl, self.icon)
end

return EquipUpLevelTip_AttrItem
