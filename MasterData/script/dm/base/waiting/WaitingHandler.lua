-- chunkname: @/tmp/or_script/lua_compile/dm/base/waiting/WaitingHandler.lua

WaitingHandleMode = {
	kActive = 1,
	kSilence = 2
}
WaitingEvent = {
	kWaitNotify = 8,
	kUnrepairableErr = 7,
	kConnect = 1,
	kConnectSucc = 3,
	kRequest = 4,
	kNotify = 9,
	kConnectErr = 2,
	kRepairableErr = 6,
	kRequestSucc = 5
}
WaitingHandler = class("WaitingHandler", legs.Actor)

WaitingHandler:has("_mode", {
	is = "rw"
})
WaitingHandler:has("_eventType", {
	is = "rw"
})

function WaitingHandler:initialize()
	super.initialize(self)

	self._mode = WaitingHandleMode.kActive
	self._eventType = nil
	self._cacheWaitingEvent = nil
end

function WaitingHandler:dispose()
	self:hideWaiting()

	self._mode = nil
	self._eventType = nil
	self._cacheWaitingEvent = nil

	super.dispose(self)
end

function WaitingHandler:showWaiting(type, data)
	if not self:isActive() then
		return
	end

	WaitingView:getInstance():show(type, data)
end

function WaitingHandler:hideWaiting()
	if not self:isActive() then
		return
	end

	WaitingView:getInstance():hide()
end

function WaitingHandler:isActive()
	return self._mode == WaitingHandleMode.kActive
end

function WaitingHandler:setMode(mode)
	if self._mode == mode then
		return
	end

	self._mode = mode

	if self:isActive() then
		self:hideWaiting()
		self:handleCacheWaitingEvent()
	end
end

function WaitingHandler:handleWaitingEvent(type, handler, data)
	if self._eventType == WaitingEvent.kUnrepairableErr then
		return
	end

	self._eventType = type

	self:onWaitingEvent(type, handler, data)
end

function WaitingHandler:handleCacheWaitingEvent()
	if self._cacheWaitingEvent == nil then
		return
	end

	local waitingEvent = self._cacheWaitingEvent

	self._cacheWaitingEvent = nil

	self:onWaitingEvent(waitingEvent.type, waitingEvent.handler, waitingEvent.data)
end

function WaitingHandler:onWaitingEvent(type, handler, data)
	assert(false, "override me")
end

GameServerWaitingHandler = class("GameServerWaitingHandler", WaitingHandler)

function GameServerWaitingHandler:initialize()
	super.initialize(self)

	self._requestCount = 0
	self._waitNotifyCount = 0
end

function GameServerWaitingHandler:dispose()
	super.dispose(self)
end

function GameServerWaitingHandler:onWaitingEvent(type, handler, data)
	if type == WaitingEvent.kConnect then
		self:showWaiting(WaitingStyle.kTipInfo, {
			noAction = true,
			delay = 200,
			tip = Strings:get("WAITING_CONNECTING")
		})
	elseif type == WaitingEvent.kConnectErr then
		if self:isActive() then
			self:hideWaiting()

			local tipStr = Strings:get("LOGIN_CONNECT_FAIL")
			local errCode = data and data.errCode
			local detail = data and data.detail

			if errCode then
				errCode = detail and errCode .. ":" .. detail or errCode
				tipStr = tipStr .. "(" .. errCode .. ")"
			end

			self:dispatch(ShowTipEvent({
				tip = tipStr
			}))
		end
	elseif type == WaitingEvent.kConnectSucc then
		if self._requestCount == 0 then
			self:hideWaiting()
		else
			self:showWaiting(WaitingStyle.kLoading, {
				delay = 200
			})
		end
	elseif type == WaitingEvent.kRequest then
		self._requestCount = self._requestCount + 1

		if self._requestCount == 1 then
			self:showWaiting(WaitingStyle.kLoading, {
				delay = 200
			})
		end
	elseif type == WaitingEvent.kRequestSucc then
		self._requestCount = self._requestCount - 1

		if self._requestCount == 0 then
			if self._waitNotifyCount == 0 then
				self:hideWaiting()
			end
		else
			self._requestCount = math.max(0, self._requestCount)
		end
	elseif type == WaitingEvent.kWaitNotify then
		self._waitNotifyCount = self._waitNotifyCount + 1

		if self._waitNotifyCount == 1 then
			self:showWaiting(WaitingStyle.kLoading, {
				delay = 200
			})
		end
	elseif type == WaitingEvent.kNotify then
		self._waitNotifyCount = self._waitNotifyCount - 1

		if self._waitNotifyCount == 0 then
			if self._requestCount == 0 then
				self:hideWaiting()
			end
		else
			self._waitNotifyCount = math.max(0, self._waitNotifyCount)
		end
	elseif type == WaitingEvent.kRepairableErr then
		if self:isActive() then
			self:showWaiting(WaitingStyle.kTipInfo, {
				tip = Strings:get("WAITING_RECONNECT"),
				onTouch = function()
					self:showWaiting(WaitingStyle.kLoading, {
						delay = 200
					})

					if handler then
						handler()
					end
				end,
				detail = data and data.detail,
				errCode = data and data.errCode
			})
		elseif handler then
			handler()
		end
	elseif type == WaitingEvent.kUnrepairableErr then
		if data and data.loginException then
			if handler then
				handler()
			end
		elseif self:isActive() then
			self:showWaiting(WaitingStyle.kTipInfo, {
				tip = Strings:get("WAITING_REBOOT"),
				onTouch = function()
					StatisticSystem:send({
						point = "restart_prompt",
						type = "restart_prompt"
					})
					self:hideWaiting()

					if handler then
						handler()
					end
				end,
				detail = data and data.detail,
				errCode = data and data.errCode
			})
		else
			self._cacheWaitingEvent = {
				type = type,
				handler = handler,
				data = data
			}
		end
	end
end

RTPVPServerWaitingHandler = class("RTPVPServerWaitingHandler", WaitingHandler)

function RTPVPServerWaitingHandler:initialize()
	super.initialize(self)

	self._requestCount = 0
end

function RTPVPServerWaitingHandler:onWaitingEvent(type, handler, data)
	if type == WaitingEvent.kConnect then
		self:showWaiting(WaitingStyle.kTipInfo, {
			noAction = true,
			delay = 200,
			tip = Strings:get("WAITING_CONNECTING")
		})
	elseif type == WaitingEvent.kConnectErr then
		if self:isActive() then
			self:hideWaiting()

			local tipStr = Strings:get("LOGIN_CONNECT_FAIL")
			local errCode = data and data.errCode
			local detail = data and data.detail

			if errCode then
				errCode = detail and errCode .. ":" .. detail or errCode
				tipStr = tipStr .. "(" .. errCode .. ")"
			end

			self:dispatch(ShowTipEvent({
				tip = tipStr
			}))
		end
	elseif type == WaitingEvent.kConnectSucc then
		if self._requestCount == 0 then
			self:hideWaiting()
		else
			self:showWaiting(WaitingStyle.kLoading, {
				delay = 200
			})
		end
	elseif type == WaitingEvent.kRequest then
		self._requestCount = self._requestCount + 1

		if self._requestCount == 1 then
			self:showWaiting(WaitingStyle.kLoading, {
				delay = 200
			})
		end
	elseif type == WaitingEvent.kRequestSucc then
		self._requestCount = math.max(0, self._requestCount - 1)

		if self._requestCount == 0 then
			self:hideWaiting()
		end
	elseif type == WaitingEvent.kRepairableErr then
		if self:isActive() then
			self:showWaiting(WaitingStyle.kTipInfo, {
				tip = Strings:get("WAITING_RECONNECT"),
				onTouch = function()
					self:showWaiting(WaitingStyle.kLoading, {
						delay = 200
					})

					if handler then
						handler()
					end
				end,
				detail = data and data.detail,
				errCode = data and data.errCode
			})
		elseif handler then
			handler()
		end
	elseif type == WaitingEvent.kUnrepairableErr then
		if self:isActive() then
			self:hideWaiting()

			if handler then
				handler()
			end
		else
			self._cacheWaitingEvent = {
				type = type,
				handler = handler,
				data = data
			}
		end
	end
end
