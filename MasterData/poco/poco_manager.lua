string.split = string.split or function(arg_1_0, arg_1_1)
	arg_1_0 = tostring(arg_1_0)
	arg_1_1 = tostring(arg_1_1)

	if arg_1_1 == "" then
		return false
	end

	local var_1_0 = 0
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in function()
		return string.find(arg_1_0, arg_1_1, var_1_0, true)
	end do
		table.insert(var_1_1, string.sub(arg_1_0, var_1_0, iter_1_0 - 1))

		var_1_0 = iter_1_1 + 1
	end

	table.insert(var_1_1, string.sub(arg_1_0, var_1_0))

	return var_1_1
end

local function var_0_0(arg_3_0, arg_3_1)
	local var_3_0
	local var_3_1 = arg_3_0

	while true do
		if string.byte(arg_3_0, 1) ~= 46 then
			var_3_1 = string.sub(arg_3_0, 1)

			if var_3_0 and #var_3_0 > 0 then
				var_3_1 = table.concat(var_3_0, ".") .. "." .. var_3_1
			end

			break
		end

		if not var_3_0 then
			if not arg_3_1 then
				local var_3_3, var_3_4 = debug.getlocal(3, 1)

				arg_3_1 = var_3_4
			end

			var_3_0 = string.split(arg_3_1, ".")
		end

		table.remove(var_3_0, #var_3_0)
	end

	return require(var_3_1)
end

local var_0_1 = _G.cc or require("cc")
local var_0_2

xpcall(function()
	var_0_2 = _G.socket or require("socket.core")
end, function()
	var_0_2 = var_0_1.exports.socket
end)

local var_0_3 = var_0_0(".POCO_SDK_VERSION")
local var_0_4 = var_0_0(".FguiDumper")
local var_0_5 = var_0_0(".Cocos2dxScreen")
local var_0_6 = var_0_0(".ClientConnection")
local var_0_7 = {}

var_0_7.__index = var_0_7
var_0_7.DEBUG = false
var_0_7.VERSION = var_0_3
var_0_7.server_sock = nil
var_0_7.all_socks = {}
var_0_7.clients = {}

local var_0_8 = {
	GetSDKVersion = function()
		return var_0_3
	end,
	Dump = function(arg_7_0)
		if arg_7_0 == nil then
			arg_7_0 = true
		end

		return var_0_4:dumpHierarchy(arg_7_0)
	end,
	Screenshot = function(arg_8_0)
		arg_8_0 = arg_8_0 or 720

		return var_0_5:getScreen(arg_8_0)
	end,
	GetScreenSize = function()
		return var_0_5:getPortSize()
	end,
	SetText = function(arg_10_0, arg_10_1)
		local var_10_0 = var_0_4:getCachedNode(arg_10_0)

		if var_10_0 ~= nil then
			return var_10_0:setAttr("text", arg_10_1)
		end

		return false
	end,
	test = function(arg_11_0, arg_11_1)
		return string.format("test arg1:%s arg2:%s", arg_11_0, arg_11_1)
	end
}

function var_0_7:init_server(arg_12_1)
	self.all_socks = {}
	self.clients = {}
	arg_12_1 = arg_12_1 or 15004

	local var_12_0, var_12_1 = var_0_2.tcp()

	assert(var_12_0)
	table.insert(self.all_socks, var_12_0)

	self.server_sock = var_12_0

	var_12_0:setoption("reuseaddr", true)
	var_12_0:setoption("keepalive", true)
	var_12_0:settimeout(0)
	var_12_0:bind("*", arg_12_1)
	var_12_0:listen(5)
	release_print(string.format("[poco] server listens on tcp://*:%s", arg_12_1))

	if self._timer then
		var_0_1.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timer)

		self._timer = nil
	end

	self.timer = var_0_1.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		self:server_loop()
	end, 0.025, false)
end

function var_0_7:server_loop()
	for iter_14_0, iter_14_1 in pairs(self.clients) do
		iter_14_1:drainOutputBuffer()
	end

	local var_14_0, var_14_1, var_14_2 = var_0_2.select(self.all_socks, nil, 0)

	if #var_14_0 > 0 then
		local var_14_3 = {}

		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			if iter_14_3 == self.server_sock then
				local var_14_4, var_14_5 = self.server_sock:accept()

				if var_14_4 ~= nil then
					release_print("[poco] new client accepted", var_14_4:getpeername(), var_14_5)
					table.insert(self.all_socks, var_14_4)

					self.clients[var_14_4] = var_0_6:new(var_14_4, self.DEBUG)
				end
			elseif self.clients[iter_14_3] then
				local var_14_6 = self.clients[iter_14_3]:receive()

				if var_14_6 == "" then
					self.clients[iter_14_3] = nil

					table.insert(var_14_3, iter_14_3)
				elseif var_14_6 ~= nil then
					for iter_14_4, iter_14_5 in ipairs(var_14_6) do
						self:onRequest(iter_14_5)
					end
				end
			end
		end

		for iter_14_6, iter_14_7 in pairs(var_14_3) do
			for iter_14_8, iter_14_9 in ipairs(self.all_socks) do
				if iter_14_9 == iter_14_7 then
					table.remove(self.all_socks, iter_14_8)

					break
				end
			end
		end
	end

	for iter_14_10, iter_14_11 in pairs(self.clients) do
		iter_14_11:drainOutputBuffer()
	end
end

function var_0_7.onRequest(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.client
	local var_15_1 = arg_15_1.params
	local var_15_2 = var_0_8[arg_15_1.method]
	local var_15_3 = {
		id = arg_15_1.id,
		jsonrpc = arg_15_1.jsonrpc
	}

	if var_0_8[arg_15_1.method] == nil then
		var_15_3.error = {
			message = string.format("No such rpc method \"%s\", reqid: %s, client:%s", arg_15_1.method, arg_15_1.id, arg_15_1.client:getAddress())
		}

		g.log:info("onRequest: ", var_15_3.error.message)
		arg_15_1.client:send(var_15_3)
	else
		xpcall(function()
			local var_16_0 = var_15_2(unpack(var_15_1))

			if type(var_16_0) == "function" then
				var_16_0(function(arg_17_0)
					var_15_3.result = arg_17_0

					var_15_0:send(var_15_3)
				end)

				return
			else
				var_15_3.result = var_16_0

				var_15_0:send(var_15_3)
			end
		end, function(arg_18_0)
			var_15_3.error = {
				message = debug.traceback(arg_18_0)
			}

			var_15_0:send(var_15_3)
			arg_15_0:init_server(15004)
		end)
	end
end

return var_0_7
