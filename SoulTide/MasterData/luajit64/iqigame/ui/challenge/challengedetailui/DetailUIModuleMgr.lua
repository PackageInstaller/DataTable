-- chunkname: @IQIGame\\UI\\Challenge\\ChallengeDetailUI\\DetailUIModuleMgr.lua

local m = {
	controllers = {}
}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	return
end

function m:AddModule(class, view, uiController)
	local moduleController = class.New(view, uiController)

	table.insert(self.controllers, moduleController)
end

function m:SetData(data)
	for i = 1, #self.controllers do
		self.controllers[i]:SetData(data)
	end
end

function m:Dispose()
	for i = 1, #self.controllers do
		self.controllers[i]:Dispose()
	end

	self.View = nil
end

return m
