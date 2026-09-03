-- chunkname: @/tmp/or_script/lua_compile/dragon/schedule/Countdown.lua

Countdown = class("Countdown", objectlua.Object, _M)

function Countdown:initialize(viewUpdateFunc, scheduler)
	super.initialize(self)

	self._viewUpdater = viewUpdateFunc
	self._leftSeconds = 0
	self._scheduler = scheduler
	self._isPaused = false
end

function Countdown:_startTick()
	if self._cdTask ~= nil then
		return
	end

	if self._scheduler ~= nil then
		self._cdTask = self._scheduler:schedule(function(task, dt)
			self:tick(dt)
		end)
	end
end

function Countdown:_stopTick()
	if self._cdTask ~= nil then
		self._cdTask:stop()

		self._cdTask = nil
	end
end

function Countdown:_updateView(leftSeconds)
	if self._viewUpdater ~= nil then
		self:_viewUpdater(leftSeconds)
	end
end

function Countdown:tick(dt)
	if self._isPaused then
		return
	end

	self._leftSeconds = self._leftSeconds - dt

	if self._leftSeconds <= 0 then
		self._leftSeconds = 0

		self:_updateView(self._leftSeconds)
		self:_stopTick()

		if self._delegate and self._delegate.onCountdownTimeout ~= nil then
			self._delegate:onCountdownTimeout(self)
		end
	else
		self:_updateView(self._leftSeconds)
	end
end

function Countdown:setDelegate(delegate)
	self._delegate = delegate
end

function Countdown:setScheduler(scheduler)
	if self._scheduler == scheduler then
		return
	end

	self._scheduler = scheduler

	if self._cdTask ~= nil then
		self:_stopTick()
		self:_startTick()
	end
end

function Countdown:reset(leftSeconds)
	self._leftSeconds = leftSeconds

	self:_updateView(self._leftSeconds)
end

function Countdown:getLeftSeconds()
	return self._leftSeconds or 0
end

function Countdown:isPaused()
	return self._isPaused
end

function Countdown:isStopped()
	return self._cdTask == nil
end

function Countdown:start()
	self._isPaused = false

	self:_startTick()

	if self._delegate and self._delegate.onCountdownStarted ~= nil then
		self._delegate:onCountdownStarted(self)
	end
end

function Countdown:pause()
	self._isPaused = true

	if self._delegate and self._delegate.onCountdownPaused ~= nil then
		self._delegate:onCountdownPaused(self)
	end
end

function Countdown:stop()
	self:_stopTick()

	if self._delegate and self._delegate.onCountdownStopped ~= nil then
		self._delegate:onCountdownStopped(self)
	end
end

function Countdown:markTime()
	self._markedTime = os.time()
end

function Countdown:getLastMarkedTime()
	return self._markedTime
end

function Countdown:amendTimer(time, forced)
	if time == nil or not forced and self._isPaused then
		return
	end

	local left = self._leftSeconds - (os.time() - time)

	self._leftSeconds = left < 0 and 0 or left
end
