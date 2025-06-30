-- chunkname: @IQIGame\\UI\\HomeLandPlant\\HomeLandPlantComeItem.lua

local HomeLandPlantComeItem = {}

function HomeLandPlantComeItem.New(view)
	local obj = Clone(HomeLandPlantComeItem)

	obj:Init(view)

	return obj
end

function HomeLandPlantComeItem:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnJump = self.View:GetComponent("Button")

	function self.delegateBtnJump()
		self:OnBtnJump()
	end

	self:AddListener()
end

function HomeLandPlantComeItem:AddListener()
	self.btnJump.onClick:AddListener(self.delegateBtnJump)
end

function HomeLandPlantComeItem:RemoveListener()
	self.btnJump.onClick:RemoveListener(self.delegateBtnJump)
end

function HomeLandPlantComeItem:SetData(functionID, str)
	self.Function = functionID

	UGUIUtil.SetText(self.Text, str)
end

function HomeLandPlantComeItem:OnBtnJump()
	JumpModule.Jump(self.Function)
end

function HomeLandPlantComeItem:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return HomeLandPlantComeItem
