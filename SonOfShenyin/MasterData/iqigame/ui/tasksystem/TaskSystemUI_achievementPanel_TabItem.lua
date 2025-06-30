-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskSystemUI_achievementPanel_TabItem.lua

local TaskSystemUI_achievementPanel_TabItem = {}

function TaskSystemUI_achievementPanel_TabItem.New(go, mainView)
	local o = Clone(TaskSystemUI_achievementPanel_TabItem)

	o:Initialize(go, mainView)

	return o
end

function TaskSystemUI_achievementPanel_TabItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TaskSystemUI_achievementPanel_TabItem:InitComponent()
	return
end

function TaskSystemUI_achievementPanel_TabItem:InitDelegate()
	function self.onToggleDelegate(isOn)
		self:OnToggle(isOn)
	end
end

function TaskSystemUI_achievementPanel_TabItem:AddListener()
	self.ToggleGo:GetComponent("Toggle").onValueChanged:AddListener(self.onToggleDelegate)
end

function TaskSystemUI_achievementPanel_TabItem:RemoveListener()
	self.ToggleGo:GetComponent("Toggle").onValueChanged:RemoveListener(self.onToggleDelegate)
end

function TaskSystemUI_achievementPanel_TabItem:OnToggle(isOn)
	if isOn then
		self:Selected()
	else
		self:UnSelected()
	end

	self.mainView:OnTabSelected(self.type)
end

function TaskSystemUI_achievementPanel_TabItem:Selected()
	LuaUtility.SetGameObjectShow(self.normalRoot, false)
	LuaUtility.SetGameObjectShow(self.selectedRoot, true)
end

function TaskSystemUI_achievementPanel_TabItem:UnSelected()
	LuaUtility.SetGameObjectShow(self.normalRoot, true)
	LuaUtility.SetGameObjectShow(self.selectedRoot, false)
end

function TaskSystemUI_achievementPanel_TabItem:Refresh(type)
	self.type = type

	self:UnSelected()
end

function TaskSystemUI_achievementPanel_TabItem:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return TaskSystemUI_achievementPanel_TabItem
