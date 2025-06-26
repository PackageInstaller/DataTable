-- chunkname: @IQIGame\\Module\\DualTeamExplore\\DualTeamExploreLevelAdaptor.lua

local m = {
	CommandSwitchIsOn = true
}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	function self.DelegateOnTimerUpdate()
		self:OnTimerUpdate()
	end

	self.__CommandQueue = Queue.New()

	GameEntry.Timer:AddFrameRender(1, self.DelegateOnTimerUpdate, true)
end

function m:OnTimerUpdate()
	while self.__CommandQueue.Size > 0 do
		if not self.CommandSwitchIsOn then
			break
		end

		xpcall(function()
			local command = self.__CommandQueue:Dequeue()

			self:SendCommand(command)
		end, function(msg)
			logError(tostring(msg))
		end)
	end
end

function m:AddCommand(command)
	self.__CommandQueue:Enqueue(command)
end

function m:SendCommand(command)
	EventDispatcher.Dispatch(DTECommandUtil.GetEventID(command), command)
end

function m:CommandSwitch(isOn)
	self.CommandSwitchIsOn = isOn
end

function m:Dispose()
	GameEntry.Timer:RemoveRender(self.DelegateOnTimerUpdate)
end

return m
