local var_0_1 = lx
local var_0_2 = tostring
local var_0_3 = string.format
local var_0_4 = table.insert
local var_0_5 = table.sort
local var_0_6 = table.concat

local function var_0_7(arg_1_0, arg_1_1)
	return arg_1_0.key < arg_1_1.key
end

lx.define_class("security", function(arg_2_0)
	function arg_2_0.format_data(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			if iter_3_0 ~= arg_3_2 then
				var_0_4(var_3_0, {
					key = var_0_2(iter_3_0),
					value = var_0_3("%s=%s", var_0_2(iter_3_0), var_0_2(iter_3_1))
				})
			end
		end

		var_0_5(var_3_0, var_0_7)

		local var_3_1 = {}

		for iter_3_2, iter_3_3 in pairs(var_3_0) do
			var_0_4(var_3_1, iter_3_3.value)
		end

		return var_0_6(var_3_1, "&")
	end

	function arg_2_0:encrypt(arg_4_1, arg_4_2, arg_4_3)
		self._util:reset()
		self._util:set_secret(arg_4_1)

		return self._util:encrypt(arg_4_2, arg_4_3)
	end

	function arg_2_0:decrypt(arg_5_1, arg_5_2, arg_5_3)
		self._util:reset()
		self._util:set_secret(arg_5_1)

		return self._util:decrypt(arg_5_2, arg_5_3)
	end

	function arg_2_0:sign(arg_6_1, arg_6_2)
		self._util:reset()
		self._util:set_secret(arg_6_1)

		return self._util:sign(arg_6_2)
	end

	function arg_2_0:verify(arg_7_1, arg_7_2, arg_7_3)
		self._util:reset()
		self._util:set_secret(arg_7_1)

		return self._util:verify(arg_7_2, arg_7_3)
	end
end)

return function()
	local var_8_0 = var_0_1.class("security")

	var_8_0._util = var_0_1.secretbox:create()

	return var_8_0
end
