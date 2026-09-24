local var_0_0 = pairs
local var_0_2 = type
local var_0_3 = next
local var_0_4 = tostring
local var_0_6 = getmetatable
local var_0_7 = string.format
local var_0_8 = table.insert
local var_0_9 = string.rep
local var_0_10 = table.concat
local var_0_11 = {
	__skip_name_set = {},
	__hook_class_set = {}
}

function var_0_11.__check_need_skip(arg_1_0)
	return var_0_11.__skip_name_set[arg_1_0]
end

function var_0_11:__get_hook_func()
	local var_2_0 = var_0_6(self)

	if not var_2_0 or var_0_6(var_2_0) or var_0_2(var_2_0.__index) ~= "table" or not var_2_0.__index.getClassName then
		return
	end

	if not var_0_11.__hook_class_set[self:getClassName()] then
		return
	end

	if self.pairs then
		return self.pairs, self.has_next
	end

	return nil, nil
end

local var_0_12

local function var_0_13(arg_3_0)
	var_0_8(var_0_12, arg_3_0 .. "\n")
end

local var_0_14

local function var_0_15(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = {}

	local function var_4_1(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		if var_0_11.__check_need_skip(arg_5_0) or var_0_14[arg_5_1] then
			return
		end

		local var_5_0 = var_0_9("    ", arg_5_2)

		if var_0_2(arg_5_1) == "table" and arg_5_3 ~= 0 then
			if not var_4_0[arg_5_1] then
				var_4_0[arg_5_1] = var_0_7(" = {%s} [type:reference]", var_0_4(arg_5_4))
			else
				var_0_13(var_0_7("%s%s%s", var_0_4(var_5_0), var_0_4(arg_5_0), var_0_4(var_4_0[arg_5_1])))

				return
			end

			var_0_13(var_0_7("%s%s = \n%s{", var_5_0, var_0_4(arg_5_0), var_5_0))

			arg_5_3 = arg_5_3 - 1

			for iter_5_0, iter_5_1 in (var_0_11.__get_hook_func(arg_5_1) or var_0_0)(arg_5_1) do
				var_4_1(iter_5_0, iter_5_1, arg_5_2 + 1, arg_5_3, var_0_7("%s.%s", var_0_4(arg_5_4), var_0_4(iter_5_0)))
			end

			var_0_13(var_0_4(var_5_0) .. "}")
		else
			var_0_13((var_0_7("%s%s = %s    [type:%s]", var_5_0, var_0_4(arg_5_0), var_0_4(arg_5_1), var_0_2(arg_5_1))))
		end
	end

	var_4_1(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
end

local function var_0_16(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {
		[arg_6_1] = arg_6_0
	}

	local function var_6_1(arg_7_0, arg_7_1, arg_7_2)
		if var_0_11.__check_need_skip(arg_7_2) or var_0_14[arg_7_0] then
			return
		end

		if var_0_2(arg_7_0) ~= "table" then
			return var_0_7(" = %s [type:%s]", var_0_4(arg_7_0), var_0_2(arg_7_0))
		end

		local var_7_0 = {}
		local var_7_1, var_7_2 = var_0_11.__get_hook_func(arg_7_0)

		var_7_1 = var_7_1 or var_0_0
		var_7_2 = var_7_2 or var_0_3

		for iter_7_0, iter_7_1 in var_7_1(arg_7_0) do
			if not var_0_11.__check_need_skip(iter_7_0) and not var_0_14[iter_7_1] then
				local var_7_3 = var_0_4(iter_7_0)

				if var_6_0[iter_7_1] then
					var_0_8(var_7_0, var_0_7("+%s {%s} [type:reference]", var_0_4(var_7_3), var_0_4(var_6_0[iter_7_1])))
				elseif var_0_2(iter_7_1) == "table" then
					local var_7_4 = var_0_7("%s.%s", var_0_4(arg_7_2), var_0_4(var_7_3))

					var_6_0[iter_7_1] = var_7_4

					if arg_6_2 ~= 1 then
						var_0_8(var_7_0, "+" .. var_0_4(var_7_3) .. var_6_1(iter_7_1, arg_7_1 .. (var_7_2(arg_7_0, iter_7_0) and "|" or " ") .. var_0_9(" ", #var_7_3), var_7_4))
					else
						var_0_8(var_7_0, var_0_7("+%s = %s [type:%s]", var_7_3, var_0_4(iter_7_1), var_0_2(iter_7_1)))
					end
				else
					var_0_8(var_7_0, var_0_7("+%s = %s [type:%s]", var_7_3, var_0_4(iter_7_1), var_0_2(iter_7_1)))
				end
			end
		end

		return var_0_10(var_7_0, "\n" .. arg_7_1)
	end

	var_0_13(arg_6_0 .. var_6_1(arg_6_1, var_0_9(" ", #arg_6_0), arg_6_0))
end

function var_0_11.reset_dump()
	var_0_11.__skip_name_set = {}
	var_0_11.__hook_class_set = {}
end

function var_0_11.dump_skip_name(arg_9_0)
	for iter_9_0, iter_9_1 in var_0_0(arg_9_0) do
		var_0_11.__skip_name_set[iter_9_1] = true
	end
end

function var_0_11.dump_hook_class(arg_10_0)
	var_0_11.__hook_class_set[arg_10_0] = true
end

function var_0_11.format_value_for_table(arg_11_0, arg_11_1, arg_11_2)
	var_0_12 = {}
	var_0_14 = arg_11_2 or {}

	if var_0_2(arg_11_1) ~= "string" then
		arg_11_1 = ""
	end

	var_0_15(arg_11_1, arg_11_0, 0, -1, arg_11_1)

	var_0_12 = nil
	var_0_14 = nil

	return (var_0_10(var_0_12))
end

function var_0_11.format_value_for_tree(arg_12_0, arg_12_1, arg_12_2)
	var_0_12 = {}
	var_0_14 = arg_12_2 or {}

	if var_0_2(arg_12_1) ~= "string" then
		arg_12_1 = ""
	end

	var_0_16(arg_12_1, arg_12_0, -1)

	var_0_12 = nil
	var_0_14 = nil

	return (var_0_10(var_0_12))
end

return var_0_11
