local var_0_0 = {}
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:ClassroomInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__classroom__action(iter_2_1.info, iter_2_1.action)
		end
	end

	function arg_1_0:TeacherInfoUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__teacher__action(iter_3_1.info, iter_3_1.action)
		end
	end

	function arg_1_0:SchoolOpenNotify()
		self:set_school_open_condition(true)
	end

	function arg_1_0:__classroom__action(arg_5_1, arg_5_2)
		if arg_5_2 == var_0_3.update_modify then
			self:update_classroom_data(arg_5_1)
		elseif arg_5_2 == var_0_3.update_add then
			self:add_classroom_data(arg_5_1)
		elseif arg_5_2 == var_0_3.update_remove then
			self:remove_classroom_data(arg_5_1)
		end
	end

	function arg_1_0:__teacher__action(arg_6_1, arg_6_2)
		if arg_6_2 == var_0_3.update_modify then
			self:update_teacher_data(arg_6_1)
		elseif arg_6_2 == var_0_3.update_add then
			self:add_teacher_data(arg_6_1)
		elseif arg_6_2 == var_0_3.update_remove then
			self:remove_teacher_data(arg_6_1)
		end
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
