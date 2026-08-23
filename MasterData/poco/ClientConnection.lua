local function var_0_0(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1 = arg_1_0

	while true do
		if string.byte(arg_1_0, 1) ~= 46 then
			var_1_1 = string.sub(arg_1_0, 1)

			if var_1_0 and #var_1_0 > 0 then
				var_1_1 = table.concat(var_1_0, ".") .. "." .. var_1_1
			end

			break
		end

		if not var_1_0 then
			if not arg_1_1 then
				local var_1_3, var_1_4 = debug.getlocal(3, 1)

				arg_1_1 = var_1_4
			end

			var_1_0 = string.split(arg_1_1, ".")
		end

		table.remove(var_1_0, #var_1_0)
	end

	return require(var_1_1)
end

local var_0_1

xpcall(function()
	var_0_1 = _G.socket or require("socket.core")
end, function()
	var_0_1 = cc.exports.socket
end)

local var_0_2 = var_0_0(".support.dkjson")
local var_0_3 = _G.struct or var_0_0(".support.struct")
local var_0_4 = {}

var_0_4.__index = var_0_4
var_0_4.DEBUG = false
var_0_4.sock = nil
var_0_4.buf = ""
var_0_4.sendbuf = ""

function var_0_4.new(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == nil then
		arg_4_2 = false
	end

	local var_4_0 = {}

	setmetatable(var_4_0, var_0_4)

	var_4_0.DEBUG = arg_4_2
	var_4_0.sock = arg_4_1
	var_4_0.buf = ""
	var_4_0.sendbuf = ""

	var_4_0.sock:setoption("tcp-nodelay", true)
	var_4_0.sock:setoption("keepalive", true)
	var_4_0.sock:settimeout(0)

	return var_4_0
end

function var_0_4:input(arg_5_1)
	self.buf = self.buf .. arg_5_1

	local var_5_0 = {}

	while #self.buf > 4 do
		local var_5_1 = var_0_3.unpack("i", string.sub(self.buf, 1, 4))

		if #self.buf >= var_5_1 + 4 then
			local var_5_2 = string.sub(self.buf, 5, 4 + var_5_1)

			self.buf = string.sub(self.buf, 5 + var_5_1)

			if self.DEBUG then
				print(var_5_2)
			end

			var_5_0[#var_5_0 + 1] = var_0_2.decode(var_5_2)
		else
			break
		end
	end

	return var_5_0
end

function var_0_4:receive()
	local var_6_0, var_6_1, var_6_2 = self.sock:receive(65535)

	if self.DEBUG then
		print("client recv", var_6_2 or var_6_0)
	end

	if (not var_6_0 or var_6_0 == "") and (not var_6_2 or var_6_2 == "") then
		self:close()

		return ""
	else
		local var_6_3 = self:input(var_6_2 or var_6_0)

		if #var_6_3 > 0 then
			for iter_6_0, iter_6_1 in ipairs(var_6_3) do
				iter_6_1.client = self
			end

			return var_6_3
		end
	end
end

function var_0_4:send(arg_7_1)
	local var_7_0 = var_0_2.encode(arg_7_1)
	local var_7_1 = var_0_3.pack("i", #var_7_0) .. var_7_0

	if self.DEBUG then
		print(var_7_1)
	end

	self.sendbuf = self.sendbuf .. var_7_1
end

function var_0_4:drainOutputBuffer()
	while #self.sendbuf > 0 do
		local var_8_0, var_8_1, var_8_2 = var_0_1.select(nil, {
			self.sock
		}, 0)

		if #var_8_1 > 0 then
			local var_8_3, var_8_4, var_8_5 = self.sock:send(self.sendbuf)

			self.sendbuf = string.sub(self.sendbuf, (var_8_3 or var_8_5) + 1)

			if var_8_4 ~= nil then
				break
			end
		else
			break
		end
	end
end

function var_0_4:close()
	self.sock:shutdown("both")
	self.sock:close()

	self.buf = ""
	self.sendbuf = ""

	print("[poco] client disconnect")
end

function var_0_4:getAddress()
	return self.sock:getpeername()
end

return var_0_4
