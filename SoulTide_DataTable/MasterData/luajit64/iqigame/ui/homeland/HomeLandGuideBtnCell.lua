-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandGuideBtnCell.lua

local HomeLandGuideBtnCell = {}

function HomeLandGuideBtnCell.__New(ui)
	local o = Clone(HomeLandGuideBtnCell)

	o:InitView(ui)

	return o
end

function HomeLandGuideBtnCell:InitView(ui)
	self.goView = ui

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnSelf = self.goView:GetComponent("Button")

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddEventListener()
end

function HomeLandGuideBtnCell:AddEventListener()
	self.btnSelf.onClick:AddListener(self.delegateBtnSelf)
end

function HomeLandGuideBtnCell:RemoveEventListener()
	self.btnSelf.onClick:RemoveListener(self.delegateBtnSelf)
end

function HomeLandGuideBtnCell:SetData(data)
	self.data = data
end

function HomeLandGuideBtnCell:OnBtnSelf()
	if self.callBackSelf then
		self.callBackSelf(self.data)
	end
end

function HomeLandGuideBtnCell:Dispose()
	self.callBackSelf = nil

	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandGuideBtnCell
