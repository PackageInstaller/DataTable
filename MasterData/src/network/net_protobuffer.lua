local netbuffer = class("netbuffer")
local var_0_1 = string
local var_0_2 = table

function netbuffer:ctor(arg_1_1, arg_1_2)
	self._client = arg_1_1
	self._handler = arg_1_2
	self._queue = {}
	self._running = true
	self._data = ""
	self._updateiter = self:createDispather()
end

function netbuffer:close()
	self._queue = {}
	self._running = false
	self._data = ""
end

function netbuffer:dispatchPacket(arg_3_1)
	self._data = self._data .. arg_3_1
end

function netbuffer:parsePacket()
	local var_4_9000
	local var_4_0 = var_0_1.len(self._data)
	local var_4_1

	if var_4_0 < 2 then
		do return end

		var_4_1 = var_4_9000 + self._data:byte(1) * 256
	end

	if var_4_0 < self._data:byte(2) + 2 then
		return
	end

	var_0_2.insert(self._queue, (self._data:sub(3, var_4_1 + 2)))

	self._data = self._data:sub(var_4_1 + 3)
end

function netbuffer:dispatchBody()
	local var_5_0 = var_0_2.remove(self._queue, 1)

	if not var_5_0 then
		return
	end

	local var_5_1, var_5_2, var_5_3, var_5_4 = self._client:dispatch(var_5_0)

	if var_5_1 == "REQUEST" then
		self._handler(NET_EVENT_REQUEST, var_5_2, var_5_3, var_5_4)
	elseif var_5_1 == "RESPONSE" then
		self._handler(NET_EVENT_RESPONSE, var_5_2, var_5_3)
	end
end

function netbuffer:createDispather()
	return coroutine.create(function()
		while self._running do
			self:parsePacket()
			self:dispatchBody()
			coroutine.yield()
		end
	end)
end

function netbuffer:update()
	local var_8_0, var_8_1 = coroutine.resume(self._updateiter)

	if not var_8_0 then
		print(var_8_1)
		__G__TRACKBACK__(var_8_1)

		self._updateiter = self:createDispather()
	end
end

return netbuffer
