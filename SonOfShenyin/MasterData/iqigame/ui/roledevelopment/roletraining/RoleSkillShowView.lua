-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\RoleSkillShowView.lua

local m = {
	SkillItems = {}
}
local showSkillItem = require("IQIGame.UI.RoleDevelopment.ItemCell.ShowSkillItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 5 do
		table.insert(self.SkillItems, showSkillItem.New(self["SkillItem" .. i]))
	end

	function self.DelegateClickSkillShowItemEvent(skillData, selectIndex)
		self:OnClickSkillShowItemEvent(skillData, selectIndex)
	end

	UGUIUtil.SetText(self.CostTitme, RoleDevelopmentApi:GetCostTitle())
	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.ClickSkillShowItemEvent, self.DelegateClickSkillShowItemEvent)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.ClickSkillShowItemEvent, self.DelegateClickSkillShowItemEvent)
end

function m:SetData(tabIndex)
	self.SkillGroups = RoleDevelopmentModule.GetCurHeroSkill(RoleDevelopmentModule.CurSelectHeroCid)

	local isSelectDiy = tabIndex == 2

	LuaUtility.SetGameObjectShow(self.NormalSelectBG, tabIndex == 1)
	LuaUtility.SetGameObjectShow(self.DIYSelectBG, tabIndex ~= 1)

	for i = 4, #self.SkillItems do
		self.SkillItems[i]:SetData(self.SkillGroups[i], i)
		self.SkillItems[i]:OnSetMaskState(isSelectDiy)
	end

	local allCost, curCost = RoleDevelopmentModule.GetHeroAndSkillCost(RoleDevelopmentModule.CurSelectHeroCid)

	UGUIUtil.SetText(self.CurCostText, curCost)
	UGUIUtil.SetText(self.AllCostText, "/" .. allCost)
end

function m:OnClickSkillShowItemEvent(skillData, selectIndex)
	for i = 1, #self.SkillItems do
		if i ~= selectIndex then
			self.SkillItems[i]:OnCancelSelect()
		end
	end
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:OnWearSkillSuccess()
	self.SkillTipsView:Hide()
	self:SetData(self.SelectTabIndex)
end

function m:OnRemoveSkillSucess()
	self.InfoViewList[self.SelectTabIndex]:SetData(self.SelectHeroCid)
	self:SetData(self.SelectTabIndex)
end

function m:OnSkillUpgradeSucess()
	self.InfoViewList[self.SelectTabIndex]:SetData(self.SelectHeroCid)
	self:SetData(self.SelectTabIndex)
end

return m
