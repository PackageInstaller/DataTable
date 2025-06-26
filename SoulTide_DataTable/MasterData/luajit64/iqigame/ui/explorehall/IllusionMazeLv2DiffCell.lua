-- chunkname: @IQIGame\\UI\\ExploreHall\\IllusionMazeLv2DiffCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(isEnabled)
	self.EnableView:SetActive(isEnabled)
	self.DisableView:SetActive(not isEnabled)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
