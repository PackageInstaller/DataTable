-- chunkname: @IQIGame\\UI\\MazeSoulRevive\\MazeSoulRevivePortraitUI.lua

local m = {
	Selected = false
}

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.SoulListCell = SoulListCell.New(self.CardNode.transform:GetChild(0).gameObject, host)
	self.GrayComponent = self.CardNode:GetComponent("GrayComponent")

	self.SelectImage:SetActive(false)
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
end

function m:SetData(dollPOD)
	self.DollPOD = dollPOD

	self.View:SetActive(dollPOD ~= nil)

	if dollPOD == nil then
		return
	end

	local soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)

	self.SoulListCell:Refresh(soulData)
	self:UpdateAliveState()
end

function m:UpdateAliveState()
	self.GrayComponent:SetGray(self.DollPOD.finalAttributes[Constant.Attribute.TYPE_HP] == 0)
end

function m:SetSelect(value)
	if self.Selected == value then
		return
	end

	self.Selected = value

	self.SelectImage:SetActive(value)
end

function m:OnClick()
	self.Host:SelectPortrait(self)
end

function m:OnSoulRevive()
	GameEntry.Effect:PlayUIMountPointEffect(8000406, 50000, 0, self.View, Constant.Unity.SortingOrderMaxValue)
	self:UpdateAliveState()
end

function m:Dispose()
	self.SoulListCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
