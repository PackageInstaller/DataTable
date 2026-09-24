local var_0_0 = type
local var_0_2 = tostring
local var_0_3 = table.sort
local var_0_4 = string.format
local var_0_5 = encode
local var_0_6 = cjson

function lx.max(arg_1_0, arg_1_1)
	if arg_1_1 < arg_1_0 then
		return arg_1_0
	else
		return arg_1_1
	end
end

function lx.min(arg_2_0, arg_2_1)
	if arg_2_0 < arg_2_1 then
		return arg_2_0
	else
		return arg_2_1
	end
end

function lx.get_millisecond()
	return get_millisecond()
end

function lx.get_microsecond()
	return get_microsecond()
end

function lx.qsort(arg_5_0, arg_5_1)
	var_0_3(arg_5_0, arg_5_1)
end

function lx.clone_table(arg_6_0)
	local function var_6_0(arg_7_0)
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(arg_7_0 or {}) do
			var_7_0[iter_7_0] = var_0_0(iter_7_1) == "table" and var_6_0(iter_7_1) or iter_7_1
		end

		return var_7_0
	end

	return var_6_0(arg_6_0)
end

function lx.table_size(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_0) do
		var_8_0 = var_8_0 + 1
	end

	return var_8_0
end

function lx.array_size(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		var_9_0 = var_9_0 + 1
	end

	return var_9_0
end

function lx.json_encode(arg_10_0)
	return var_0_6.encode(arg_10_0)
end

function lx.json_decode(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = pcall(function()
		return var_0_6.decode(arg_11_0)
	end)

	if not var_11_0 or var_0_0(var_11_1) ~= "table" then
		if arg_11_1 == true then
			lx.error(var_0_4("on decode json string, but string not is json format, error, " .. "string:%s, errorinfo:%s", var_0_2(arg_11_0), var_0_2(var_11_1)))
		end

		return nil
	end

	return var_11_1
end

function lx.jsonfile_decode(arg_13_0)
	local var_13_0, var_13_1 = jsonfile.get_file_data(arg_13_0)

	if var_13_0 == nil then
		return nil, false
	end

	local var_13_2, var_13_3 = pcall(function()
		return var_0_6.decode(var_13_0)
	end)

	if not var_13_2 then
		return nil, false
	end

	return var_13_3, var_13_2
end

function lx.ansi_to_utf8(arg_15_0)
	return var_0_5.ansi_to_utf8(arg_15_0)
end

function lx.utf8_to_ansi(arg_16_0)
	return var_0_5.utf8_to_ansi(arg_16_0)
end

function lx.utf8_charinfo(arg_17_0)
	return var_0_5.utf8_charinfo(arg_17_0)
end

function lx.utf8_char_num(arg_18_0)
	local var_18_0, var_18_1, var_18_2 = var_0_5.utf8_charinfo(arg_18_0)

	return var_18_0
end

function lx.base64_encode(arg_19_0)
	return var_0_5.base64_encode(arg_19_0)
end

function lx.base64_decode(arg_20_0)
	return var_0_5.base64_decode(arg_20_0)
end

function lx.random_string(arg_21_0, arg_21_1)
	if arg_21_0 == nil then
		arg_21_0 = 16
	end

	if arg_21_1 == nil then
		arg_21_1 = true
	end

	local var_21_0 = "abcdefghijklmnopqrstuvwxyz0123456789"

	if arg_21_1 then
		var_21_0 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	end

	local var_21_1 = ""
	local var_21_2 = string.len(var_21_0)

	while 1 <= arg_21_0 do
		local var_21_4 = math.random(1, 100000) % var_21_2 + 1

		var_21_1 = var_21_1 .. string.sub(var_21_0, var_21_4, var_21_4)
	end

	return var_21_1
end

function lx.split(arg_22_0, arg_22_1)
	if arg_22_0 == "" then
		return {}
	end

	local var_22_0 = {}
	local var_22_1 = string.len(arg_22_1)

	while true do
		local var_22_2 = string.find(arg_22_0, arg_22_1, 1, true)

		if not var_22_2 then
			var_22_0[1] = string.sub(arg_22_0, 1, string.len(arg_22_0))

			break
		end

		var_22_0[1] = string.sub(arg_22_0, 1, var_22_2 - 1)
	end

	return var_22_0
end

function lx.address_ipv4_to_ipv6(arg_23_0)
	local var_23_0 = lx.split(arg_23_0, ".")

	if not var_23_0 or #var_23_0 ~= 4 then
		return arg_23_0
	end

	return var_0_4("::ffff:%02x%02x:%02x%02x", var_23_0[1], var_23_0[2], var_23_0[3], var_23_0[4])
end

function lx.is_luajit()
	local var_24_0 = false
	local var_24_1

	if var_0_0(jit) == "table" then
		var_24_0 = true
		var_24_1 = jit.version
	end

	return var_24_0, var_24_1
end
