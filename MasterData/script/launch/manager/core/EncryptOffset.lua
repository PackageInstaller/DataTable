local var_0_0 = lx
local var_0_2 = string.byte
local var_0_3 = table.insert
local var_0_4 = string.sub

lx.define_class("EncryptOffset", function(arg_1_0)
	function arg_1_0:getOffset(arg_2_1)
		local var_2_0 = 22

		for iter_2_0, iter_2_1 in pairs((self:str_to_table((self:get_file_name(arg_2_1))))) do
			var_2_0 = var_2_0 + var_0_2(iter_2_1)
		end

		return 33 + var_2_0 % 88
	end

	function arg_1_0.str_to_table(arg_3_0, arg_3_1)
		local var_3_0 = {}

		for iter_3_0 = 1, string.len(arg_3_1) do
			var_0_3(var_3_0, var_0_4(arg_3_1, iter_3_0, iter_3_0))
		end

		return var_3_0
	end

	function arg_1_0.get_file_name(arg_4_0, arg_4_1)
		local var_4_0 = string.find(string.reverse(arg_4_1), "/")

		if var_4_0 == nil then
			return arg_4_1
		end

		return string.sub(arg_4_1, string.len(arg_4_1) - var_4_0 + 1 + 1, string.len(arg_4_1))
	end
end)

return function()
	return (var_0_0.class("EncryptOffset"))
end
