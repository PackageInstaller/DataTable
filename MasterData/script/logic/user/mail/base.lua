local var_0_0 = {}
local var_0_1 = table.sort
local var_0_2 = table.insert
local var_0_3 = table.remove
local var_0_4 = gamecore.UILoader
local var_0_5 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_mail_data(arg_2_0)
		arg_2_0._mail_data = {}
		arg_2_0._new_mail_flag = false
	end

	function arg_1_0:get_mail_data()
		return self._mail_data
	end

	function arg_1_0:get_mail_count()
		if self._mail_data and next(self._mail_data) then
			return #self._mail_data
		else
			return 0
		end
	end

	function arg_1_0:get_not_receive_mail()
		local var_5_0 = 0

		for iter_5_0, iter_5_1 in pairs(self._mail_data) do
			if iter_5_1.get == false then
				var_5_0 = var_5_0 + 1
			end
		end

		if var_5_0 == 0 then
			self:set_new_mail_flag(false)
		end

		return var_5_0
	end

	function arg_1_0:get_receive_mail()
		local var_6_0 = 0

		for iter_6_0, iter_6_1 in pairs(self._mail_data) do
			if iter_6_1.get == true then
				var_6_0 = var_6_0 + 1
			end
		end

		return var_6_0
	end

	function arg_1_0:add_mail_info(arg_7_1)
		if not var_0_5.get_curr_data_state_by_id(self._mail_data, arg_7_1) then
			var_0_2(self._mail_data, arg_7_1)
		end

		self:__sort_mail_by_time(self._mail_data)
		self:__update_mail_date_state()
		self:__set_main_mail_float_stage(self._mail_data)
		self:__update_mail_float()
	end

	function arg_1_0:update_mail_info(arg_8_1)
		local var_8_0 = 0

		for iter_8_0, iter_8_1 in pairs(self._mail_data) do
			if iter_8_1.id == arg_8_1.id then
				var_8_0 = iter_8_0
			end
		end

		if var_8_0 == 0 then
			var_0_2(self._mail_data, arg_8_1)
		else
			self._mail_data[var_8_0] = arg_8_1
		end

		self:__sort_mail_by_time(self._mail_data)
		self:__update_mail_date_state()
	end

	function arg_1_0:remove_mail_info(arg_9_1)
		local var_9_0 = 0

		for iter_9_0, iter_9_1 in pairs(self._mail_data) do
			if iter_9_1.id == arg_9_1.id then
				var_9_0 = iter_9_0
			end
		end

		if var_9_0 > 0 then
			var_0_3(self._mail_data, var_9_0)
		end

		self:__sort_mail_by_time(self._mail_data)
		self:__update_mail_date_state()
	end

	function arg_1_0:get_new_mail_flag()
		return self._new_mail_flag, (self:get_mail_count())
	end

	function arg_1_0:set_new_mail_flag(arg_11_1)
		if self._new_mail_flag == arg_11_1 then
			return
		end

		self._new_mail_flag = arg_11_1
	end

	function arg_1_0.__update_mail_date_state(arg_12_0)
		local var_12_0 = var_0_4:getInstance("mail")

		if var_12_0 then
			var_12_0:update_mail_data_by_sever()
		end
	end

	function arg_1_0:__set_main_mail_float_stage(arg_13_1)
		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			if iter_13_1.get == false then
				self:set_new_mail_flag(true)

				break
			end
		end
	end

	function arg_1_0.__update_mail_float(arg_14_0)
		local var_14_0 = var_0_4:getInstance("home")

		if var_14_0 and var_14_0:isVisible() then
			var_14_0:update_mail_float()
		end
	end

	function arg_1_0.__sort_mail_by_time(arg_15_0, arg_15_1)
		var_0_1(arg_15_1, function(arg_16_0, arg_16_1)
			return arg_16_0.send_time > arg_16_1.send_time
		end)
	end

	function arg_1_0.set_get_all_mail_state(arg_17_0, arg_17_1)
		arg_17_0._get_all_mail = arg_17_1
	end

	function arg_1_0:get_get_all_mail_state()
		return self._get_all_mail
	end
end

function var_0_0.extend_obj(arg_19_0)
	arg_19_0._mail_data = {}
	arg_19_0._new_mail_flag = nil
	arg_19_0._get_all_mail = false
end

return var_0_0
