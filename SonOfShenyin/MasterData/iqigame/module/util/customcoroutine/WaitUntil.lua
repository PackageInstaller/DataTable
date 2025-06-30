-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitUntil.lua

WaitUntil = class(nil, CustomWait)

function WaitUntil:ctor(condition, parameters)
	self.waitType = "WaitUntil"
	self.condition = condition
	self.parameters = parameters

	self:Update()
end

function WaitUntil:Update()
	if type(self.condition) == "function" and self.condition(self.parameters) then
		self.isComplete = true
	end
end
