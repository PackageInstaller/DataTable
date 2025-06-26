-- chunkname: @IQIGame\\UI\\Setting\\ChangeIcon\\SettingSelectGroupView.lua

local m = {
	isOpen = false,
	selectIndex = 0,
	groups = {},
	selectGroupRenders = {},
	defaultGroup = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local SettingSelectGroupRenderCell = require("IQIGame.UI.Setting.ChangeIcon.SettingSelectGroupRenderCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateOnChangeToggle(isOn)
		self:OnChangeToggle(isOn)
	end

	self.SelectMould:SetActive(false)

	self.selectGroupRenderPool = UIObjectPool.New(8, function()
		return SettingSelectGroupRenderCell.New(UnityEngine.Object.Instantiate(self.SelectMould))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.CurrentSelect:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnChangeToggle)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.CurrentSelect:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnChangeToggle)
end

function m:RefreshGroup(groups)
	self.defaultGroup = groups
	self.groups = {
		0
	}

	for i = 1, #groups do
		table.insert(self.groups, groups[i])
	end

	self.isOpen = false
	self.selectIndex = self.groups[1]

	self:RefreshSelectNode()

	for i, v in pairs(self.selectGroupRenders) do
		self.selectGroupRenderPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	end

	self.selectGroupRenders = {}

	for i = 1, #self.groups do
		local groupID = self.groups[i]
		local selectCell = self.selectGroupRenderPool:Obtain()

		selectCell.View:SetActive(true)
		selectCell.View.transform:SetParent(self.SelectSort.transform, false)
		selectCell:SetData(groupID)

		function selectCell.callBack(group)
			self:OnSelect(group)
		end

		table.insert(self.selectGroupRenders, selectCell)
	end
end

function m:OnSelect(group)
	self.selectIndex = group
	self.isOpen = false

	self:RefreshSelectNode()

	if self.selectCallBack then
		self.selectCallBack()
	end
end

function m:OnChangeToggle(isOn)
	self.isOpen = isOn

	self:RefreshSelectNode()
end

function m:OnBtnClose()
	self.isOpen = false

	self:RefreshSelectNode()
end

function m:RefreshSelectNode()
	self.SelectSort:SetActive(self.isOpen)
	self.BtnClose:SetActive(self.isOpen)

	self.CurrentSelect:GetComponent("Toggle").isOn = self.isOpen
	self.CurrentSelect:GetComponent("ToggleHelperComponent").text = SettingUIApi:GetString("GroupName", self.selectIndex)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.selectCallBack = nil

	for i, v in pairs(self.selectGroupRenders) do
		self.selectGroupRenderPool:Release(v)
	end

	self.selectGroupRenders = {}

	self.selectGroupRenderPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
