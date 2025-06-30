-- chunkname: @IQIGame\\UI\\DiySkill\\Strengthen\\DiySkillStrengthenAttrCell.lua

local DiySkillStrengthenAttrCell = {}

function DiySkillStrengthenAttrCell.New(go, mainView)
	local o = Clone(DiySkillStrengthenAttrCell)

	o:Initialize(go, mainView)

	return o
end

function DiySkillStrengthenAttrCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function DiySkillStrengthenAttrCell:InitComponent()
	return
end

function DiySkillStrengthenAttrCell:InitDelegate()
	return
end

function DiySkillStrengthenAttrCell:AddListener()
	return
end

function DiySkillStrengthenAttrCell:RemoveListener()
	return
end

function DiySkillStrengthenAttrCell:OnDestroy()
	return
end

function DiySkillStrengthenAttrCell:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function DiySkillStrengthenAttrCell:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function DiySkillStrengthenAttrCell:Refresh(type, value)
	local attributeData = CfgUtil.GetCfgAttributeDataWithID(type)

	LuaUtility.SetText(self.attNameText, attributeData.Name)
	LuaUtility.SetText(self.attNumText, value)
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(attributeData.ImageUrl), self.attIcon:GetComponent("Image"))
end

return DiySkillStrengthenAttrCell
