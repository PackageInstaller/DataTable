-- chunkname: @IQIGame\\UI\\Fishing\\FishCollectionQualityCell.lua

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

function m:SetData(num)
	self.Quality = num

	UGUIUtil.SetText(self.SelectQualityLabel, HomeLandFishCollectionUIApi:GetString("SelectQualityLabel", num))
end

function m:OnBtnSelf()
	if self.callBack then
		self.callBack(self.Quality)
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
