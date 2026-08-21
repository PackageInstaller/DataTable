local var_0_0 = type
local var_0_1 = error
local var_0_2 = string

module("protobuf.type_checkers")

function TypeChecker(arg_1_0)
	local var_1_0 = arg_1_0

	return function(arg_2_0)
		local var_2_0 = var_0_0(arg_2_0)

		if var_1_0[var_0_0(arg_2_0)] == nil then
			var_0_1(var_0_2.format("%s has type %s, but expected one of: %s", arg_2_0, var_0_0(arg_2_0), var_1_0))
		end
	end
end

function Int32ValueChecker()
	local var_3_0 = -2147483648
	local var_3_1 = 2147483647

	return function(arg_4_0)
		if var_0_0(arg_4_0) ~= "number" then
			var_0_1(var_0_2.format("%s has type %s, but expected one of: number", arg_4_0, var_0_0(arg_4_0)))
		end

		if arg_4_0 < var_3_0 or arg_4_0 > var_3_1 then
			var_0_1("Value out of range: " .. arg_4_0)
		end
	end
end

function Uint32ValueChecker(arg_5_0)
	local var_5_0 = 0
	local var_5_1 = 4294967295

	return function(arg_6_0)
		if var_0_0(arg_6_0) ~= "number" then
			var_0_1(var_0_2.format("%s has type %s, but expected one of: number", arg_6_0, var_0_0(arg_6_0)))
		end

		if arg_6_0 < var_5_0 or arg_6_0 > var_5_1 then
			var_0_1("Value out of range: " .. arg_6_0)
		end
	end
end

function UnicodeValueChecker()
	return function(arg_8_0)
		if var_0_0(arg_8_0) ~= "string" then
			var_0_1(var_0_2.format("%s has type %s, but expected one of: string", arg_8_0, var_0_0(arg_8_0)))
		end
	end
end
