local var_0_0 = {}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__eventOnFrame(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(self._visual_set) do
			iter_2_1:__eventOnFrame(arg_2_1)
		end
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
