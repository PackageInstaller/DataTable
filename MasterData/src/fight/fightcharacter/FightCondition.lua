local var_0_1 = string
local var_0_2 = table
local var_0_3 = _G

module("fightcondition")

local var_0_6
local var_0_7

function decode(arg_1_0)
	if not arg_1_0 or var_0_3.type(arg_1_0) ~= "string" then
		return {}
	end

	return var_0_6(arg_1_0)
end

local function var_0_8(arg_2_0, arg_2_1)
	local var_2_0 = {}

	var_2_0.type = 2

	if var_0_3.type(arg_2_0) == "table" then
		var_0_2.insert(var_2_0, arg_2_0)
	else
		var_0_2.insert(var_2_0, var_0_6(arg_2_0))
	end

	if var_0_3.type(arg_2_1) == "table" then
		var_0_2.insert(var_2_0, arg_2_1)
	else
		var_0_2.insert(var_2_0, var_0_6(arg_2_1))
	end

	return var_2_0
end

local function var_0_9(arg_3_0, arg_3_1)
	local var_3_0 = {}

	var_3_0.type = 1

	if var_0_3.type(arg_3_0) == "table" then
		var_0_2.insert(var_3_0, arg_3_0)
	else
		var_0_2.insert(var_3_0, var_0_6(arg_3_0))
	end

	if var_0_3.type(arg_3_0) == "table" then
		var_0_2.insert(var_3_0, arg_3_1)
	else
		var_0_2.insert(var_3_0, var_0_6(arg_3_1))
	end

	return var_3_0
end

function var_0_6(arg_4_0)
	local var_4_0 = 0

	local function var_4_2(arg_5_0, arg_5_1)
		arg_5_1 = arg_5_1 or 1

		if arg_5_1 >= var_0_1.len(arg_5_0) then
			return var_0_1.len(arg_5_0)
		end

		local var_5_0 = var_0_1.sub(arg_5_0, arg_5_1, arg_5_1)

		if var_5_0 == "(" then
			var_4_0 = var_4_0 + 1

			return var_4_2(arg_5_0, arg_5_1 + 1)
		elseif var_5_0 == ")" then
			var_4_0 = var_4_0 - 1

			if var_4_0 <= 0 then
				return arg_5_1
			else
				return var_4_2(arg_5_0, arg_5_1 + 1)
			end
		else
			return var_4_2(arg_5_0, arg_5_1 + 1)
		end
	end

	local function var_4_3(arg_6_0, arg_6_1)
		local var_6_0 = var_0_1.sub(arg_4_0, arg_6_1 + 1, arg_6_1 + 1)
		local var_6_1 = var_4_2(arg_4_0, arg_6_1 + 2)

		if var_6_0 == "&" then
			return var_0_9(arg_6_0, var_0_1.sub(arg_4_0, arg_6_1 + 3, var_6_1 - 1)), var_6_1
		elseif var_6_0 == "|" then
			return var_0_8(arg_6_0, var_0_1.sub(arg_4_0, arg_6_1 + 3, var_6_1 - 1)), var_6_1
		end
	end

	if var_0_1.sub(arg_4_0, 1, 1) == "(" then
		local var_4_4 = var_4_2(arg_4_0)

		if var_4_4 >= var_0_1.len(arg_4_0) then
			return var_0_6(var_0_1.sub(arg_4_0, 2, var_4_4 - 1))
		end

		local var_4_5 = var_0_1.sub(arg_4_0, 2, var_4_4 - 2)

		repeat
			var_4_5, var_4_4 = var_4_3(var_4_5, var_4_4)
		until var_4_4 >= var_0_1.len(arg_4_0)

		return var_4_5
	else
		return var_0_7(arg_4_0)
	end
end

function var_0_7(arg_7_0)
	local var_7_0, var_7_1, var_7_2 = arg_7_0:match("^([^~=><]+)(.+)([^~=><]+)$")
	local var_7_3 = {}

	if var_7_0:find("([%+%-*/%%])") then
		local var_7_4, var_7_5, var_7_6 = var_7_0:match("^(.+)([%+%-*/%%])(.+)$")

		var_7_3[1] = var_7_4
		var_7_3[2] = var_7_6
		var_7_3[3] = var_7_5
	else
		var_7_3[1] = var_7_0
	end

	return {
		equation = var_7_3,
		operator = var_7_1,
		value = var_0_3.tonumber(var_7_2)
	}
end
