local var_0_0 = {}

math.randomseed(os.time())
math.random()

local function var_0_1(arg_1_0)
	local var_1_0 = math.fmod or math.mod
	local var_1_1 = ""

	if arg_1_0 == 0 then
		return "0"
	end

	while arg_1_0 > 0 do
		var_1_1 = var_1_0(arg_1_0, 2) .. var_1_1
		arg_1_0 = math.floor(arg_1_0 * 0.5)
	end

	return var_1_1
end

local function var_0_2(arg_2_0)
	local var_2_0 = 0

	if arg_2_0 == "0" then
		return 0
	end

	for iter_2_0 = #arg_2_0, 1, -1 do
		if string.sub(arg_2_0, iter_2_0, iter_2_0) == "1" then
			var_2_0 = var_2_0 + 2^0
		end
	end

	return var_2_0
end

local function var_0_3(arg_3_0, arg_3_1)
	if #arg_3_0 == arg_3_1 then
		return arg_3_0
	end

	if arg_3_1 < #arg_3_0 then
		print("too many bits")
	end

	for iter_3_0 = 1, arg_3_1 - #arg_3_0 do
		arg_3_0 = "0" .. arg_3_0
	end

	return arg_3_0
end

function var_0_0.getUUID()
	math.random()

	local var_4_0 = {}

	for iter_4_0 = 1, 6 do
		var_4_0[iter_4_0] = math.random(0, 255)
	end

	local var_4_1 = (((("" .. var_0_3(string.format("%X", (math.random(0, 65535))), 4)) .. var_0_3(string.format("%X", (math.random(0, 65535))), 4) .. "-") .. var_0_3(string.format("%X", (math.random(0, 65535))), 4) .. "-") .. var_0_3(string.format("%X", (var_0_2("0100" .. var_0_3(var_0_1((math.random(0, 4095))), 12)))), 4) .. "-") .. var_0_3(string.format("%X", (var_0_2(("10" .. var_0_3(var_0_1((math.random(0, 63))), 6)) .. var_0_3(var_0_1((math.random(0, 255))), 8)))), 4) .. "-"

	for iter_4_1 = 1, 6 do
		var_4_1 = var_4_1 .. var_0_3(string.format("%X", var_4_0[iter_4_1]), 2)
	end

	return var_4_1
end

return var_0_0
