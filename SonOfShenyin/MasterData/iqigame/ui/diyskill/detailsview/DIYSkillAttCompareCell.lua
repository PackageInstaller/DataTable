-- chunkname: @IQIGame\\UI\\DiySkill\\DetailsView\\DIYSkillAttCompareCell.lua

local DIYSkillAttCompareCell = {}

function DIYSkillAttCompareCell.New(go, mainView)
	local o = Clone(DIYSkillAttCompareCell)

	o:Initialize(go, mainView)

	return o
end

function DIYSkillAttCompareCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function DIYSkillAttCompareCell:InitComponent()
	return
end

function DIYSkillAttCompareCell:InitDelegate()
	return
end

function DIYSkillAttCompareCell:AddListener()
	return
end

function DIYSkillAttCompareCell:RemoveListener()
	return
end

function DIYSkillAttCompareCell:OnDestroy()
	return
end

function DIYSkillAttCompareCell:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function DIYSkillAttCompareCell:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function DIYSkillAttCompareCell:Refresh(data)
	self.data = data

	local attributeData = CfgAttributeTable[self.data.type]

	LuaUtility.SetText(self.attNameText, attributeData.Name)
	LuaUtility.SetText(self.attCurrentNumText, self.data.currentValue == 0 and "-" or self.data.currentValue)
	LuaUtility.SetText(self.textAttTargetNum, self.data.targetValue)
	LuaUtility.SetGameObjectShow(self.imageUp, self.data.currentValue < self.data.targetValue)
	LuaUtility.SetGameObjectShow(self.imageDown, self.data.currentValue > self.data.targetValue)
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(attributeData.ImageUrl), self.attIcon:GetComponent("Image"))
end

return DIYSkillAttCompareCell
