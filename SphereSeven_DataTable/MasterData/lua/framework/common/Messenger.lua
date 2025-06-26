--[[
-- added by wsh @ 2017-11-28
-- 消息系统
-- 使用范例：
-- local Messenger = require "Framework.Common.Messenger";
-- local TestEventCenter = Messenger.New() --创建消息中心
-- TestEventCenter:AddListener(Type, callback) --添加监听
-- TestEventCenter:AddListener(Type, callback, ...) --添加监听
-- TestEventCenter:Broadcast(Type, ...) --发送消息
-- TestEventCenter:RemoveListener(Type, callback, ...) --移除监听
-- TestEventCenter:Cleanup() --清理消息中心
-- 注意：
-- 1、模块实例销毁时，要自动移除消息监听，不移除的话不能自动清理监听
-- 2、使用弱引用，即使监听不手动移除，消息系统也不会持有对象引用，所以对象的销毁是不受消息系统影响的
-- 3、换句话说：广播发出，回调一定会被调用，但回调参数中的实例对象，可能已经被销毁，所以回调函数一定要注意判空
--]]

local Messenger = BaseClass("Messenger");

local function __init(self)
	self.events = {}
	self.message = {}
	self.tempEvents = {}
end

local function __delete(self)
	self.events = nil
	self.error_handle = nil
end

local function AddListener(self, e_type, e_listener, ...)
	local event = self.events[e_type]
	if event == nil then
		event = setmetatable({}, {__mode = "k"})
	end
	
	for k, v in pairs(event) do
		if k == e_listener then
			error("Already contains listener : "..tostring(e_listener))
			return
		end
	end

	local data = SafePack(...)
	if self.message[e_type] == nil or self.message[e_type] == 0 then
		event[e_listener] = setmetatable(data, {__mode = "kv"})
		self.events[e_type] = event;
		return
	end
	if self.tempEvents[e_type] == nil then
		self.tempEvents[e_type] = {}
	end
	table.insert(self.tempEvents[e_type], {type = e_type, listener = e_listener, data = data})
end

local function AddCache(self, e_type, e_listener, data)
	local event = self.events[e_type]
	if event == nil then
		event = setmetatable({}, {__mode = "k"})
	end

	for k, v in pairs(event) do
		if k == e_listener then
			error("Already contains listener : "..tostring(e_listener))
			return
		end
	end

	event[e_listener] = setmetatable(data, {__mode = "kv"})
	self.events[e_type] = event;
end

local function Broadcast(self, e_type, ...)
	local event = self.events[e_type]
	if event == nil then
		return
	end
	if self.message[e_type] == nil then
		self.message[e_type] = 1
	else
		self.message[e_type] = self.message[e_type] + 1
	end

	local _pcall = {
		__call = function(self, ...)
			local status, err
			if not self.obj then
				status, err = pcall(self.func, ...)
			else
				status, err = pcall(self.func, self.obj, ...)
			end
			if not status then
				event_err_handle(err.."\n"..traceback())
			end
			return status
		end,

		__eq = function(lhs, rhs)
			return lhs.func == rhs.func and lhs.obj == rhs.obj
		end,
	}
	
	for k, v in pairs(event) do
		assert(k ~= nil)
		local args = ConcatSafePack(v, SafePack(...))
		local status, err = pcall(k, SafeUnpack(args))
		if not status then
			Logger.LogError(err)
		end
		--k(SafeUnpack(args))
	end
	if self.message[e_type] == nil then
		Logger.LogError("Messenger??? == nil")
		return
	end
	self.message[e_type] = self.message[e_type] - 1
	if self.message[e_type] < 0 then
		Logger.LogError("Messenger??? < 0")
		self.message[e_type] = 0
	end
	if self.message[e_type] == 0 then
		if self.tempEvents[e_type] ~= nil then
			table.walk(self.tempEvents[e_type], function (k, v)
				self:AddCache(v.type, v.listener, v.data)
			end)
			self.tempEvents[e_type] = {}
		end
	end
end

local function RemoveListener(self, e_type, e_listener)
	local event = self.events[e_type]
	if event == nil then
		return
	end
	event[e_listener] = nil
end

local function RemoveListenerByType(self, e_type)
	self.events[e_type] = nil
end

local function Cleanup(self)
	self.events = {};
end

Messenger.__init = __init
Messenger.__delete = __delete
Messenger.AddListener = AddListener
Messenger.Broadcast = Broadcast
Messenger.RemoveListener = RemoveListener
Messenger.RemoveListenerByType = RemoveListenerByType
Messenger.Cleanup = Cleanup 
Messenger.AddCache = AddCache 

return Messenger;