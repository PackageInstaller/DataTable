-- chunkname: @IQIGame\\Scene\\StateMachine\\StateMachineMgr.lua

local m = {
	IsActive = true,
	StateMachines = {}
}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init(view)
	return
end

function m:AddStateMachine(class, controller, cid)
	local stateMachine = class.New(controller, cid)

	table.insert(self.StateMachines, stateMachine)
end

function m:RemoveStateMachine(controller)
	local index = 0

	for i = 1, #self.StateMachines do
		local stateMachine = self.StateMachines[i]

		if stateMachine.controller == controller then
			index = i

			break
		end
	end

	if index ~= 0 then
		table.remove(self.StateMachines, index)
	end
end

function m:Update()
	if self.IsActive then
		for i = #self.StateMachines, 1, -1 do
			self.StateMachines[i]:Update()
		end
	end
end

function m:SetActive(value)
	self.IsActive = value
end

function m:SetTrigger(controller, triggerName)
	for i = 1, #self.StateMachines do
		local stateMachine = self.StateMachines[i]

		if controller == nil or stateMachine.controller == controller then
			stateMachine:SetTrigger(triggerName)

			break
		end
	end
end

function m:Dispose()
	for i = 1, #self.StateMachines do
		self.StateMachines[i]:Dispose()
	end

	self.StateMachines = nil
end

StateMachineMgr = m
