-- chunkname: @IQIGame\\UI\\RoleDevelopment\\SkillUpgradePropertyItem.lua

local SkillUpgradePropertyItem = {}

function SkillUpgradePropertyItem.New(go, mainView)
	local o = Clone(SkillUpgradePropertyItem)

	o:Initialize(go, mainView)

	return o
end

function SkillUpgradePropertyItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SkillUpgradePropertyItem:InitComponent()
	return
end

function SkillUpgradePropertyItem:InitDelegate()
	return
end

function SkillUpgradePropertyItem:AddListener()
	return
end

function SkillUpgradePropertyItem:RemoveListener()
	return
end

function SkillUpgradePropertyItem:Refresh(Data)
	self.Data = Data

	LuaUtility.SetText(self.textName, Data.name)
	LuaUtility.SetText(self.textNowProperty, Data.OldValue)
	LuaUtility.SetText(self.textTargetProperty, Data.newValue)
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(Data.ImageUrl), self.AttImg:GetComponent("Image"))
end

function SkillUpgradePropertyItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function SkillUpgradePropertyItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

return SkillUpgradePropertyItem
