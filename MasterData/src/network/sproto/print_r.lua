local var_0_0 = print
local var_0_1 = table.concat
local var_0_2 = table.insert
local var_0_3 = string.rep
local var_0_4 = type
local var_0_5 = pairs
local var_0_6 = tostring
local var_0_7 = next

return function(arg_1_0)
	local var_1_0 = {
		[arg_1_0] = "."
	}

	local function var_1_1(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in var_0_5(arg_2_0) do
			local var_2_1 = var_0_6(iter_2_0)

			if var_1_0[iter_2_1] then
				var_0_2(var_2_0, "+" .. var_2_1 .. " {" .. var_1_0[iter_2_1] .. "}")
			elseif var_0_4(iter_2_1) == "table" then
				var_1_0[iter_2_1] = arg_2_2 .. "." .. var_2_1

				var_0_2(var_2_0, "+" .. var_2_1 .. var_1_1(iter_2_1, arg_2_1 .. (var_0_7(arg_2_0, iter_2_0) and "|" or " ") .. var_0_3(" ", #var_2_1), arg_2_2 .. "." .. var_2_1))
			else
				var_0_2(var_2_0, "+" .. var_2_1 .. " [" .. var_0_6(iter_2_1) .. "]")
			end
		end

		return var_0_1(var_2_0, "\n" .. arg_2_1)
	end

	var_0_0(var_1_1(arg_1_0, "", ""))
end
