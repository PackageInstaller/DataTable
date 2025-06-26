-- chunkname: @IQIGame\\UI\\FormationUI\\FormationPanelPositionCell.lua

local m = {}

function m.New(view, index)
	local obj = Clone(m)

	obj:Init(view, index)

	return obj
end

function m:Init(view, index)
	self.View = view
	self.Index = index

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(position, hasSoul)
	local isCellFrontPos = self.Index <= 5
	local isSoulOnFrontPos = position == Constant.SoulPrefab.PositionFront
	local isOccupied = hasSoul and isCellFrontPos == isSoulOnFrontPos

	self.EmptyIcon:SetActive(not isOccupied)
	self.OccupiedIcon:SetActive(isOccupied)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
