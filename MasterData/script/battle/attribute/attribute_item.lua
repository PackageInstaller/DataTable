local var_0_0 = {}
local var_0_1 = lx

lx.define_class("attribute_item", function(arg_1_0)
	function arg_1_0:get_final_value()
		return self._final_value
	end

	function arg_1_0:get_next_value()
		return self._next_value
	end

	function arg_1_0:modify_to_value(arg_4_1)
		self._next_value = self._base_value

		if arg_4_1 == 0 and self._base_value ~= 0 then
			self._damage_control_value = self._base_value
		end

		self._base_value = arg_4_1

		self:__update_final_value()
	end

	function arg_1_0:reduction_to_next_value()
		self._base_value = self._next_value

		self:__update_final_value()

		return self._final_value
	end

	function arg_1_0:__init_value()
		self._modify = 0

		self:__update_final_value()
	end

	function arg_1_0:__update_final_value()
		self._final_value = self._base_value + self._modify
		self._modify = 0
	end
end)

function var_0_0.create(arg_8_0, arg_8_1)
	local var_8_0 = var_0_1.class("attribute_item")

	var_8_0._base_value = arg_8_1
	var_8_0._final_value = 0
	var_8_0._modify = 0
	var_8_0._next_value = arg_8_1
	var_8_0._damage_control_value = 0

	return var_8_0
end

return var_0_0
