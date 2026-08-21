local var_0_0 = _G
local var_0_1 = require("string")
local var_0_2 = require("math")
local var_0_3 = require("socket.core")
local var_0_4 = var_0_3

function var_0_4.connect4(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	return var_0_3.connect(arg_1_0, arg_1_1, arg_1_2, arg_1_3, "inet")
end

function var_0_4.connect6(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	return var_0_3.connect(arg_2_0, arg_2_1, arg_2_2, arg_2_3, "inet6")
end

function var_0_4.bind(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0 == "*" then
		arg_3_0 = "0.0.0.0"
	end

	local var_3_0, var_3_1 = var_0_3.dns.getaddrinfo(arg_3_0)

	if not var_3_0 then
		return nil, var_3_1
	end

	local var_3_2
	local var_3_3
	local var_3_4 = "no info on address"

	for iter_3_0, iter_3_1 in var_0_0.ipairs(var_3_0) do
		if iter_3_1.family == "inet" then
			var_3_2, var_3_4 = var_0_3.tcp4()
		else
			var_3_2, var_3_4 = var_0_3.tcp6()
		end

		if not var_3_2 then
			return nil, var_3_4
		end

		var_3_2:setoption("reuseaddr", true)

		local var_3_5, var_3_6 = var_3_2:bind(iter_3_1.addr, arg_3_1)

		var_3_4 = var_3_6

		if not var_3_5 then
			var_3_2:close()
		else
			local var_3_7, var_3_8 = var_3_2:listen(arg_3_2)

			var_3_4 = var_3_8

			if not var_3_7 then
				var_3_2:close()
			else
				return var_3_2
			end
		end
	end

	return nil, var_3_4
end

var_0_4.try = var_0_4.newtry()

function var_0_4.choose(arg_4_0)
	return function(arg_5_0, arg_5_1, arg_5_2)
		if var_0_0.type(arg_5_0) ~= "string" then
			arg_5_0, arg_5_1, arg_5_2 = "default", arg_5_0, arg_5_1
		end

		local var_5_0 = arg_4_0[arg_5_0 or "nil"]

		if not var_5_0 then
			var_0_0.error("unknown key (" .. var_0_0.tostring(arg_5_0) .. ")", 3)
		else
			return var_5_0(arg_5_1, arg_5_2)
		end
	end
end

local var_0_5 = {}
local var_0_6 = {}

var_0_4.sourcet = var_0_5
var_0_4.sinkt = var_0_6
var_0_4.BLOCKSIZE = 2048
var_0_6["close-when-done"] = function(arg_6_0)
	return var_0_0.setmetatable({
		getfd = function()
			return arg_6_0:getfd()
		end,
		dirty = function()
			return arg_6_0:dirty()
		end
	}, {
		__call = function(arg_9_0, arg_9_1, arg_9_2)
			if not arg_9_1 then
				arg_6_0:close()

				return 1
			else
				return arg_6_0:send(arg_9_1)
			end
		end
	})
end
var_0_6["keep-open"] = function(arg_10_0)
	return var_0_0.setmetatable({
		getfd = function()
			return arg_10_0:getfd()
		end,
		dirty = function()
			return arg_10_0:dirty()
		end
	}, {
		__call = function(arg_13_0, arg_13_1, arg_13_2)
			if arg_13_1 then
				return arg_10_0:send(arg_13_1)
			else
				return 1
			end
		end
	})
end
var_0_6.default = var_0_6["keep-open"]
var_0_4.sink = var_0_4.choose(var_0_6)
var_0_5["by-length"] = function(arg_14_0, arg_14_1)
	return var_0_0.setmetatable({
		getfd = function()
			return arg_14_0:getfd()
		end,
		dirty = function()
			return arg_14_0:dirty()
		end
	}, {
		__call = function()
			if arg_14_1 <= 0 then
				return nil
			end

			local var_17_0 = var_0_2.min(var_0_3.BLOCKSIZE, arg_14_1)
			local var_17_1, var_17_2 = arg_14_0:receive(var_17_0)

			if var_17_2 then
				return nil, var_17_2
			end

			arg_14_1 = arg_14_1 - var_0_1.len(var_17_1)

			return var_17_1
		end
	})
end
var_0_5["until-closed"] = function(arg_18_0)
	local var_18_0

	return var_0_0.setmetatable({
		getfd = function()
			return arg_18_0:getfd()
		end,
		dirty = function()
			return arg_18_0:dirty()
		end
	}, {
		__call = function()
			if var_18_0 then
				return nil
			end

			local var_21_0, var_21_1, var_21_2 = arg_18_0:receive(var_0_3.BLOCKSIZE)

			if not var_21_1 then
				return var_21_0
			elseif var_21_1 == "closed" then
				arg_18_0:close()

				var_18_0 = 1

				return var_21_2
			else
				return nil, var_21_1
			end
		end
	})
end
var_0_5.default = var_0_5["until-closed"]
var_0_4.source = var_0_4.choose(var_0_5)

return var_0_4
