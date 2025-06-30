-- chunkname: @IQIGame\\UI\\Library\\LibraryEquipComBtnCell.lua

local LibraryEquipComBtnCell = {}

function LibraryEquipComBtnCell.New(view)
	local obj = Clone(LibraryEquipComBtnCell)

	obj:Init(view)

	return obj
end

function LibraryEquipComBtnCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnCome = self.BtnCome:GetComponent("Button")

	function self.delegateBtnCome()
		self:OnBtnCome()
	end

	self:AddListener()
end

function LibraryEquipComBtnCell:AddListener()
	self.btnCome.onClick:AddListener(self.delegateBtnCome)
end

function LibraryEquipComBtnCell:RemoveListener()
	self.btnCome.onClick:RemoveListener(self.delegateBtnCome)
end

function LibraryEquipComBtnCell:SetData(functionID)
	self.functionID = functionID

	local cfgFun = CfgFunctionTable[self.functionID]

	UGUIUtil.SetText(self.TextBtn, cfgFun.Name)
end

function LibraryEquipComBtnCell:OnBtnCome()
	if self.functionID > 0 then
		JumpModule.Jump(self.functionID)
	end
end

function LibraryEquipComBtnCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.GameObject.Destroy(self.View)

	self.View = nil
end

return LibraryEquipComBtnCell
