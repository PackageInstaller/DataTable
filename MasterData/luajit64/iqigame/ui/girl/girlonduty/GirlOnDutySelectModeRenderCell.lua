-- chunkname: @IQIGame\\UI\\Girl\\GirlOnDuty\\GirlOnDutySelectModeRenderCell.lua

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
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
end

function m:SetData(type, labStr)
	self.type = type

	UGUIUtil.SetText(self.SelectTimeLabel, labStr)
end

function m:OnBtnSelf()
	if self.clickSelfCallBack then
		self.clickSelfCallBack(self.type)
	end
end

function m:Dispose()
	self:RemoveListener()

	self.clickSelfCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
