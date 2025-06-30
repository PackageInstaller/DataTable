-- chunkname: @IQIGame\\UI\\ExploreHall\\SingleWeakTower\\SingleWeakTowerTypeCell.lua

local m = {
	floor = 1
}

function m.New(view, type)
	local obj = Clone(m)

	obj:Init(view, type)

	return obj
end

function m:Init(view, type)
	self.View = view
	self.type = type

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

function m:SetData(floor)
	self.floor = floor

	self:UpdateView()
end

function m:UpdateView()
	UGUIUtil.SetText(self.NameText, SingleWeakTowerFloorUIApi:GetString("TowerTypeName", self.type))

	local showFloor = self.floor == 0 and 1 or self.floor

	UGUIUtil.SetText(self.ItemNumText, SingleWeakTowerFloorUIApi:GetString("ItemNumText", showFloor))
end

function m:OnBtnSelf()
	UIModule.Open(Constant.UIControllerName.SingleWeakTowerFloorDetailUI, Constant.UILayer.UI, {
		Type = self.type
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
