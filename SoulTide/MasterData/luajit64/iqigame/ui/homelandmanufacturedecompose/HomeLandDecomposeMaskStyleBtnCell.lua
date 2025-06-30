-- chunkname: @IQIGame\\UI\\HomeLandManufactureDecompose\\HomeLandDecomposeMaskStyleBtnCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnSelf()
		self:onBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
end

function m:SetData(data, name)
	self.decorateThemeId = data

	UGUIUtil.SetText(self.View.transform:Find("Text").gameObject, name)
end

function m:onBtnSelf()
	if self.clickSelfCallBack then
		self.clickSelfCallBack(self.decorateThemeId)
	end
end

function m:Dispose()
	self.clickSelfCallBack = nil

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
