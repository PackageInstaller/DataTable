-- chunkname: @IQIGame\\UI\\Login\\AccountTransfer\\AccountTransferBindingView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnBack()
		self:OnBtnBack()
	end

	function self.DelegateBtnSure()
		self:OnBtnSure()
	end

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateBtnBack)
	self.BtnSure:GetComponent("Button").onClick:AddListener(self.DelegateBtnSure)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
end

function m:RemoveListener()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBack)
	self.BtnSure:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSure)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
end

function m:SetData(ids, names, lvs)
	local str = ""

	for i = 1, #ids do
		local id = ids[i]
		local name = names[i]
		local lv = lvs[i]

		str = str .. AccountTransferUIApi:GetString("TextID", id, name, lv) .. "\n"
	end

	UGUIUtil.SetText(self.TextID, str)
end

function m:OnBtnBack()
	self:Close()
end

function m:OnBtnSure()
	self:Close()
	EventDispatcher.Dispatch(EventID.AccountTransferOpenRegister)
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
