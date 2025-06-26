-- chunkname: @IQIGame\\UI\\LoopMapUI\\LoopMapUIView.lua

local LoopMapUIView = {}

function LoopMapUIView.New(go)
	local o = Clone(LoopMapUIView)

	o:Initialize(go)

	return o
end

function LoopMapUIView:Initialize(go)
	self.gameObject = go

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function LoopMapUIView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

return LoopMapUIView
