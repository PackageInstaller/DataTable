-- chunkname: @IQIGame\\UI\\Login\\AccountTransfer\\AccountTransferNeedKnowView.lua

local m = {}

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

	self:AddListener()
	self.View:SetActive(false)
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
end

function m:SetData(data)
	return
end

function m:OnBtnClose()
	self:Close()
end

function m:Open()
	self.View:SetActive(true)
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
