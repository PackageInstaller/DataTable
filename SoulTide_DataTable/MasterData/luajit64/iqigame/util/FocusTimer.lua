-- chunkname: @IQIGame\\Util\\FocusTimer.lua

local UpdateBeat = UpdateBeat
local Time = Time

FocusTimer = {}

local FocusTimer = FocusTimer
local mt = {
	__index = FocusTimer
}

function FocusTimer.New(func, duration, loop, scale)
	scale = scale or scale == nil
	loop = loop or 1

	return setmetatable({
		running = false,
		func = func,
		duration = duration,
		time = duration,
		loop = loop,
		scale = scale
	}, mt)
end

function FocusTimer:Start()
	self.running = true

	if not self.handle then
		self.handle = UpdateBeat:CreateListener(self.Update, self)
	end

	UpdateBeat:AddListener(self.handle)
end

function FocusTimer:Reset(func, duration, loop, scale)
	self.duration = duration
	self.loop = loop or 1
	self.scale = scale
	self.func = func
	self.time = duration
end

function FocusTimer:Stop()
	self.running = false

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end
end

function FocusTimer:Update()
	if not self.running then
		return
	end

	if not UnityEngine.Application.isFocused then
		return
	end

	local delta = self.scale and Time.deltaTime or Time.unscaledDeltaTime

	self.time = self.time - delta

	if self.time <= 0 then
		self.func()

		if self.loop > 0 then
			self.loop = self.loop - 1
			self.time = self.time + self.duration
		end

		if self.loop == 0 then
			self:Stop()
		elseif self.loop < 0 then
			self.time = self.time + self.duration
		end
	end
end
