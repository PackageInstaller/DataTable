-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\BaseSkillTrainingView.lua

local m = {
	isFirstOpen = true,
	selectIndex = 1,
	itemList = {},
	UpgradeNeedItems = {}
}
local BaseSkillItemClass = require("IQIGame.UI.RoleDevelopment.Skill.BaseSkillItem")
local baseSkillDetailPanelClass = require("IQIGame.UI.RoleDevelopment.Skill.BaseSkillDetailPanel")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitComponent()
	self:InitDelegate()
	self:AddListeners()
end

function m:InitComponent()
	self.SkillDetailPanel = baseSkillDetailPanelClass.New(self.SkillDetailsRoot, self)
	self.BaseSkillViews = {}

	for i = 2, LuaUtility.GetChildCount(self.SkillBriefRoot.transform) do
		local trans = LuaUtility.GetChild(self.SkillBriefRoot.transform, i - 1)
		local item = BaseSkillItemClass.New(trans.gameObject, self, i - 1)

		table.insert(self.BaseSkillViews, item)
	end

	self.animCom = self.View:GetComponent("Animation")
end

function m:InitDelegate()
	function self.DelegateSkillUpSucessEvent()
		self:OnSkillUpgradeSucess()
	end

	function self.DelegateScrollChangeHeroEvent(heroCid)
		self:OnScrollChangeHeroEvent(heroCid)
	end
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	EventDispatcher.AddEventListener(EventID.ScrollChangeHeroEvent, self.DelegateScrollChangeHeroEvent)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	EventDispatcher.RemoveEventListener(EventID.ScrollChangeHeroEvent, self.DelegateScrollChangeHeroEvent)
end

function m:SetData(selectHeroCid)
	self.currentSelectHeroCid = selectHeroCid
	self.selectIndex = 1

	self:RefreshBriefInfo()
end

function m:RefreshBriefInfo()
	local heroSkillPOD = WarlockModule.WarlockDataDic[self.currentSelectHeroCid].SkillGroups

	for i = 1, 3 do
		self.BaseSkillViews[i]:Refresh(heroSkillPOD[i])
	end

	self:ShowSkillDetailPanel(1, false)
end

function m:Show()
	self.View:SetActive(true)

	self.isFirstOpen = true

	LuaUtility.RePlayAnimationWithName(self.animCom.gameObject, "BaseSkillTrainingPanel_In")
end

function m:Hide()
	self.View:SetActive(false)

	self.isFirstOpen = true
end

function m:OnSkillUpgradeSucess()
	if self.View.activeSelf == false then
		return
	end

	self:ShowSkillDetailPanel(self.selectIndex, true)
end

function m:OnScrollChangeHeroEvent(heroCid)
	if self.View.activeSelf == false then
		return
	end

	self:SetData(heroCid)
end

function m:ShowSkillDetailPanel(index, isUpgrade)
	local heroSkillPOD = WarlockModule.WarlockDataDic[self.currentSelectHeroCid].SkillGroups

	self.selectIndex = index

	self:RefreshSkillItemState()
	self.BaseSkillViews[self.selectIndex]:SelectState(true)
	self.SkillDetailPanel:Refresh(heroSkillPOD[index])

	if not self.isFirstOpen and not isUpgrade then
		LuaUtility.RePlayAnimationWithName(self.animCom.gameObject, "BaseSkillTrainingPanel_01")
	end

	if self.isFirstOpen then
		self.isFirstOpen = false
	end
end

function m:RefreshSkillItemState()
	for i = 1, 3 do
		if i ~= self.selectIndex then
			self.BaseSkillViews[i]:SelectState(false)
		end
	end
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.BaseSkillViews) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
