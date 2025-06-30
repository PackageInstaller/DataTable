-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\FavorAttributePanel_AttItem.lua

local FavorAttributePanel_AttItem = {}

function FavorAttributePanel_AttItem.New(go, mainView)
	local o = Clone(FavorAttributePanel_AttItem)

	o:Initialize(go, mainView)

	return o
end

function FavorAttributePanel_AttItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function FavorAttributePanel_AttItem:InitComponent()
	return
end

function FavorAttributePanel_AttItem:InitDelegate()
	return
end

function FavorAttributePanel_AttItem:AddListener()
	return
end

function FavorAttributePanel_AttItem:RemoveListener()
	return
end

function FavorAttributePanel_AttItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function FavorAttributePanel_AttItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function FavorAttributePanel_AttItem:Refresh(Data)
	self.data = Data

	local cfgAtt = CfgUtil.GetCfgAttributeDataWithID(self.data.attId)

	LuaUtility.SetText(self.propertyNameText, cfgAtt.Name)
	LuaUtility.SetText(self.propertyValueText, self.data.attValue)
	LuaUtility.SetGameObjectShow(self.AttributeImg, not LuaUtility.StrIsNullOrEmpty(cfgAtt.ImageUrl))

	if not LuaUtility.StrIsNullOrEmpty(cfgAtt.ImageUrl) then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgAtt.ImageUrl), self.attrImg:GetComponent("Image"))
	end
end

function FavorAttributePanel_AttItem:OnDestroy()
	return
end

return FavorAttributePanel_AttItem
