local var_0_0 = {}
local var_0_1 = string.format

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:create_visual(arg_2_1, arg_2_2, ...)
		local var_2_0 = arg_2_1:create(arg_2_2)

		var_2_0._id = arg_2_2:getID()
		var_2_0._logic = arg_2_2

		var_2_0:bind(self._battlefield)
		var_2_0:__eventOnInit(...)

		self._visual_set[var_2_0._id] = var_2_0

		return var_2_0
	end

	function arg_1_0:find_visual(arg_3_1)
		return self._visual_set[arg_3_1]
	end

	function arg_1_0:remove_visual(arg_4_1)
		if not self._visual_set[arg_4_1] then
			lx.error(var_0_1("removeVisual, not find visual, id:[%s]", tostring(arg_4_1)))
		end

		self._visual_set[arg_4_1]:__eventOnDestroy()

		self._visual_set[arg_4_1] = nil
	end
end

function var_0_0.extend_obj(arg_5_0)
	arg_5_0._visual_set = {}
end

return var_0_0
