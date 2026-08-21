-- chunkname: @IQIGame\\UI\\Setting\\ChangeIcon\\SettingSelectGroupRenderCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
end

function m:SetData(group)
	self.group = group

	UGUIUtil.SetText(self.SelectTimeLabel, SettingUIApi:GetString("GroupName", group))
end

function m:OnBtnSelf()
	if self.callBack then
		self.callBack(self.group)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.callBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
