-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreInputNumCell.lua

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

function m:SetData(number)
	if number == nil then
		number = ""
	end

	UGUIUtil.SetTextsInChildren(self.View, number)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
