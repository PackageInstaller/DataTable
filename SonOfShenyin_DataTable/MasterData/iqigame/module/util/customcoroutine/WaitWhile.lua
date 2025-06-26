-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitWhile.lua

WaitWhile = class(nil, CustomWait)

function WaitWhile:ctor(condition, parameters)
	self.waitType = "WaitWhile"
	self.condition = condition
	self.parameters = parameters

	self:Update()
end

function WaitWhile:Update()
	if type(self.condition) == "function" and not self.condition(self.parameters) then
		self.isComplete = true
	end
end
