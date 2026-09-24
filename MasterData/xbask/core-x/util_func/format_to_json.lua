local var_0_0 = {}
local var_0_1 = pairs
local var_0_2 = type
local var_0_3 = tostring
local var_0_4 = string.format
local var_0_5 = string.gsub
local var_0_6 = table.insert
local var_0_7 = table.sort
local var_0_8 = table.concat
local var_0_9 = "\t"
local var_0_10 = "\n"
local var_0_11 = "\n"
local var_0_12 = "," .. "\n"
local var_0_13 = false
local var_0_14
local var_0_15
local var_0_16

local function var_0_17(arg_1_0)
	arg_1_0 = var_0_5(arg_1_0, "\\", "\\\\")
	arg_1_0 = var_0_5(arg_1_0, "\"", "\\\"")
	arg_1_0 = var_0_5(arg_1_0, "\n", "\\n")
	arg_1_0 = var_0_5(arg_1_0, "\r", "\\r")
	arg_1_0 = var_0_5(arg_1_0, "\t", "\\t")
	arg_1_0 = var_0_5(arg_1_0, "\b", "\\b")
	arg_1_0 = var_0_5(arg_1_0, "\f", "\\f")

	return arg_1_0
end

local var_0_18 = {
	boolean = tostring,
	number = tostring,
	string = function(arg_2_0)
		return var_0_4("\"%s\"", var_0_17(arg_2_0))
	end,
	table = function(arg_3_0, arg_3_1, arg_3_2)
		if var_0_14(arg_3_0) then
			return var_0_15(arg_3_0, arg_3_1, arg_3_2)
		end

		return var_0_16(arg_3_0, arg_3_1, arg_3_2)
	end
}

local function var_0_19(arg_4_0)
	if var_0_18[var_0_2(arg_4_0)] then
		return true
	end

	return false
end

local function var_0_20(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_18[var_0_2(arg_5_0)]

	if not var_5_0 then
		return "\"\""
	end

	return var_5_0(arg_5_0, arg_5_1, arg_5_2)
end

function var_0_14(arg_6_0)
	if var_0_13 then
		return false
	end

	local var_6_0 = 0

	for iter_6_0, iter_6_1 in var_0_1(arg_6_0) do
		var_6_0 = var_6_0 + 1
	end

	local var_6_1 = 0

	for iter_6_2, iter_6_3 in ipairs(arg_6_0) do
		var_6_1 = var_6_1 + 1
	end

	if var_6_1 == var_6_0 then
		return true
	end

	return false
end

function var_0_15(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}

	var_0_6(var_7_0, "[")

	local var_7_1 = true

	for iter_7_0, iter_7_1 in var_0_1(arg_7_0) do
		var_0_6(var_7_0, (var_0_11 .. arg_7_1 .. var_0_9) .. var_0_20(iter_7_1, arg_7_1 .. var_0_9, arg_7_2))

		var_7_1 = false
	end

	if not var_7_1 then
		var_0_6(var_7_0, var_0_10 .. arg_7_1)
	end

	var_0_6(var_7_0, "]")

	return var_0_8(var_7_0)
end

local function var_0_21(arg_8_0)
	if var_0_2(arg_8_0) == "number" then
		if var_0_13 then
			return "\"" .. var_0_3(arg_8_0) .. "\""
		end

		return var_0_3(arg_8_0)
	elseif var_0_2(arg_8_0) == "string" then
		return var_0_4("\"%s\"", var_0_17(arg_8_0))
	end

	return nil
end

function var_0_16(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	var_0_6(var_9_0, "{")

	local var_9_1 = true
	local var_9_2 = var_0_11 .. arg_9_1 .. var_0_9

	if arg_9_2 then
		local var_9_3 = {}
		local var_9_4 = 0

		for iter_9_0, iter_9_1 in var_0_1(arg_9_0) do
			if var_0_21(iter_9_0) and var_0_19(iter_9_1) then
				var_9_3[iter_9_0] = true
				var_9_4 = var_9_4 + 1
			end
		end

		local var_9_5

		for iter_9_2, iter_9_3 in var_0_1(arg_9_2) do
			if #iter_9_3 == var_9_4 then
				local var_9_6 = true

				for iter_9_4, iter_9_5 in var_0_1(iter_9_3) do
					if not var_9_3[iter_9_5] then
						var_9_6 = false
					end
				end

				if var_9_6 then
					var_9_5 = iter_9_3
				end
			end
		end

		if var_9_5 == nil then
			var_9_5 = {}

			for iter_9_6, iter_9_7 in var_0_1(var_9_3) do
				var_0_6(var_9_5, iter_9_6)
			end

			var_0_7(var_9_5)
		end

		for iter_9_8, iter_9_9 in var_0_1(var_9_5) do
			var_0_6(var_9_0, var_9_2 .. var_0_21(iter_9_9) .. ":" .. var_0_20(arg_9_0[iter_9_9], arg_9_1 .. var_0_9, arg_9_2))

			var_9_1 = false
			var_9_2 = var_0_12 .. arg_9_1 .. var_0_9
		end
	else
		for iter_9_10, iter_9_11 in var_0_1(arg_9_0) do
			var_0_6(var_9_0, var_9_2 .. var_0_21(iter_9_10) .. ":" .. var_0_20(iter_9_11, arg_9_1 .. var_0_9, arg_9_2))

			var_9_1 = false
			var_9_2 = var_0_12 .. arg_9_1 .. var_0_9
		end
	end

	if not var_9_1 then
		var_0_6(var_9_0, var_0_10 .. arg_9_1)
	end

	var_0_6(var_9_0, "}")

	return var_0_8(var_9_0)
end

function var_0_0.format(arg_10_0, arg_10_1)
	if var_0_2(arg_10_1) == "table" then
		for iter_10_0, iter_10_1 in var_0_1(arg_10_1) do
			assert(var_0_2(iter_10_1) == "table", "seq_rule error")

			for iter_10_2, iter_10_3 in var_0_1(iter_10_1) do
				assert(var_0_2(iter_10_3) == "string", "field name type error")
			end
		end
	end

	return var_0_20(arg_10_0, "", arg_10_1)
end

return var_0_0
