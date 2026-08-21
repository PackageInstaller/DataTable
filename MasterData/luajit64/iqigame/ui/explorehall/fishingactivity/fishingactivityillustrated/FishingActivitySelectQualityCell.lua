-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityIllustrated\\FishingActivitySelectQualityCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

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

function m:SetData(num)
	self.Quality = num

	UGUIUtil.SetText(self.SelectQualityLabel, FishingActivityIllustratedUIApi:GetString("SelectQualityLabel", num))
end

function m:OnBtnSelf()
	if self.CallBack then
		self.CallBack(self.Quality)
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
