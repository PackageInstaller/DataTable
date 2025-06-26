-- chunkname: @IQIGame\\UI\\LoopMapUI\\LoopMapCellView.lua

local LoopMapCellView = {}

function LoopMapCellView.New(go)
	local o = Clone(LoopMapCellView)

	o:Initialize(go)

	return o
end

function LoopMapCellView:Initialize(go)
	self.gameObject = go

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function LoopMapCellView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return LoopMapCellView
