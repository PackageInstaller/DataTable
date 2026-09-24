local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.insert
local var_0_3 = table.remove
local var_0_5 = gamecore.util_func
local var_0_6 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_school_data(arg_2_0)
		arg_2_0._class_data = {}
		arg_2_0._teacher_data = {}
		arg_2_0._school_is_open = false
	end

	function arg_1_0:get_class_total_info()
		return self._class_data
	end

	function arg_1_0:get_teacher_total_info()
		return self._teacher_data
	end

	function arg_1_0:get_total_study_student_info()
		self._tatal_student_list = {}

		for iter_5_0, iter_5_1 in pairs(self._class_data) do
			self:__get_seat_student_info(iter_5_1.seat)
		end

		self:__get_not_enough_level_ship_data()

		return self._tatal_student_list
	end

	function arg_1_0:get_now_class_seat(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(self._class_data) do
			if iter_6_1.id == arg_6_1 then
				return #iter_6_1.seat
			end
		end
	end

	function arg_1_0:get_student_by_seat_id(arg_7_1, arg_7_2)
		for iter_7_0, iter_7_1 in pairs(self._class_data) do
			if iter_7_1.id == arg_7_1 then
				return iter_7_1.seat[arg_7_2]
			end
		end
	end

	function arg_1_0:get_teacher_state_by_cid(arg_8_1)
		local var_8_0 = false
		local var_8_1 = 0

		for iter_8_0, iter_8_1 in pairs(self._teacher_data) do
			if iter_8_1.id == arg_8_1 then
				var_8_0 = true
				var_8_1 = iter_8_1.class
			end
		end

		return var_8_0, var_8_1
	end

	function arg_1_0:get_class_teacher_by_id(arg_9_1)
		local var_9_0 = 0

		for iter_9_0, iter_9_1 in pairs(self._class_data) do
			if iter_9_1.id == arg_9_1 then
				var_9_0 = iter_9_1.teacher
			end
		end

		return var_9_0
	end

	function arg_1_0:get_teacher_state_by_class(arg_10_1)
		local var_10_0 = false

		for iter_10_0, iter_10_1 in pairs(self._class_data) do
			if iter_10_1.id == arg_10_1 then
				var_10_0 = self:get_seat_data(iter_10_1.seat)
			end
		end

		return var_10_0
	end

	function arg_1_0.get_seat_data(arg_11_0, arg_11_1)
		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			if iter_11_1 ~= 0 then
				return true
			end
		end

		return false
	end

	function arg_1_0:get_school_open_condition()
		return self._school_is_open
	end

	function arg_1_0.set_school_open_condition(arg_13_0, arg_13_1)
		arg_13_0._school_is_open = arg_13_1
	end

	function arg_1_0:add_classroom_data(arg_14_1)
		if not var_0_5.get_curr_data_state_by_id(self._class_data, arg_14_1) then
			var_0_2(self._class_data, arg_14_1)
		end
	end

	function arg_1_0:update_classroom_data(arg_15_1)
		local var_15_0 = 0

		for iter_15_0, iter_15_1 in pairs(self._class_data) do
			if iter_15_1.id == arg_15_1.id then
				var_15_0 = iter_15_0
			end
		end

		if var_15_0 == 0 then
			var_0_2(self._class_data, arg_15_1)
		else
			self._class_data[var_15_0] = arg_15_1
		end
	end

	function arg_1_0:remove_classroom_data(arg_16_1)
		local var_16_0 = 0

		for iter_16_0, iter_16_1 in pairs(self._class_data) do
			if iter_16_1.id == arg_16_1.id then
				var_16_0 = iter_16_0
			end
		end

		if var_16_0 > 0 then
			var_0_3(self._class_data, var_16_0)
		end
	end

	function arg_1_0:add_teacher_data(arg_17_1)
		if not var_0_5.get_curr_data_state_by_id(self._teacher_data, arg_17_1) then
			var_0_2(self._teacher_data, arg_17_1)
		end
	end

	function arg_1_0:update_teacher_data(arg_18_1)
		local var_18_0 = 0

		for iter_18_0, iter_18_1 in pairs(self._teacher_data) do
			if iter_18_1.id == arg_18_1.id then
				var_18_0 = iter_18_0
			end
		end

		if var_18_0 == 0 then
			var_0_2(self._teacher_data, arg_18_1)
		else
			self._teacher_data[var_18_0] = arg_18_1
		end
	end

	function arg_1_0:remove_teacher_data(arg_19_1)
		local var_19_0 = 0

		for iter_19_0, iter_19_1 in pairs(self._teacher_data) do
			if iter_19_1.id == arg_19_1.id then
				var_19_0 = iter_19_0
			end
		end

		if var_19_0 > 0 then
			var_0_3(self._teacher_data, var_19_0)
		end
	end

	function arg_1_0:__get_seat_student_info(arg_20_1)
		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			if iter_20_1 ~= 0 then
				self._tatal_student_list[#self._tatal_student_list + 1] = {
					id = iter_20_1
				}
			end
		end
	end

	function arg_1_0:__get_not_enough_level_ship_data()
		for iter_21_0, iter_21_1 in pairs((var_0_1:get_character_list())) do
			if iter_21_1.level < var_0_6.college_const.attack_level then
				self._tatal_student_list[#self._tatal_student_list + 1] = {
					id = iter_21_1.id
				}
			end
		end
	end

	function arg_1_0.set_now_statics_seat(arg_22_0, arg_22_1)
		arg_22_0._now_statics_seat = arg_22_1
	end

	function arg_1_0:get_now_statics_seat(arg_23_1)
		return self._now_statics_seat
	end

	function arg_1_0.set_statics_common_state(arg_24_0, arg_24_1)
		arg_24_0._statics_common_state = arg_24_1
	end

	function arg_1_0:get_statics_common_state(arg_25_1)
		return self._statics_common_state
	end

	function arg_1_0.set_now_class_num(arg_26_0, arg_26_1)
		arg_26_0._now_class_num = arg_26_1
	end

	function arg_1_0:get_now_class_num()
		return self._now_class_num
	end

	function arg_1_0.set_tactics_all_select_member_list(arg_28_0, arg_28_1)
		arg_28_0._tactics_all_select_member = arg_28_1
	end

	function arg_1_0:get_tactics_all_select_member_list()
		return self._tactics_all_select_member
	end
end

function var_0_0.extend_obj(arg_30_0)
	arg_30_0._class_data = {}
	arg_30_0._teacher_data = {}
	arg_30_0._tatal_student_list = {}
	arg_30_0._school_is_open = false
	arg_30_0._now_statics_seat = {}
	arg_30_0._statics_common_state = false
	arg_30_0._now_class_num = 1
	arg_30_0._tactics_all_select_member = {}
end

return var_0_0
