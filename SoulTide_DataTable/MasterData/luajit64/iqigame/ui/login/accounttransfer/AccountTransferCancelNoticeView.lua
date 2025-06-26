-- chunkname: @IQIGame\\UI\\Login\\AccountTransfer\\AccountTransferCancelNoticeView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnNoTransfer()
		self:OnNoTransfer()
	end

	function self.DelegateBtnLastStep()
		self:OnBtnLastStep()
	end

	self:AddListener()
	self.View:SetActive(false)
end

function m:AddListener()
	self.BtnNoTransfer:GetComponent("Button").onClick:AddListener(self.DelegateBtnNoTransfer)
	self.BtnLastStep:GetComponent("Button").onClick:AddListener(self.DelegateBtnLastStep)
end

function m:RemoveListener()
	self.BtnNoTransfer:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnNoTransfer)
	self.BtnLastStep:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnLastStep)
end

function m:SetData(data)
	return
end

function m:Open()
	self.View:SetActive(true)
end

function m:OnNoTransfer()
	self:Close()
	UIModule.Close(Constant.UIControllerName.AccountTransferUI)
end

function m:OnBtnLastStep()
	self:Close()
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
