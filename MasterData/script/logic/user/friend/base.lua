local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_friend_data(arg_2_0)
		arg_2_0._friend_data = {}
		arg_2_0._recommend_friend_data = {}
		arg_2_0._new_friend_req_flag = false
	end

	function arg_1_0:find_friend_by_account_id(arg_3_1, arg_3_2)
		return self:__friend__find_by_account_id(arg_3_1, arg_3_2)
	end

	function arg_1_0:get_friend_list()
		return self._friend_data
	end

	function arg_1_0.set_other_info(arg_5_0, arg_5_1)
		arg_5_0._get_other_info = arg_5_1
	end

	function arg_1_0:get_other_info()
		return self._get_other_info
	end

	function arg_1_0:get_friend_info(arg_7_1)
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(self._friend_data) do
			var_0_1(var_7_0, iter_7_1)
		end

		for iter_7_2 = 1, #var_7_0 do
			if arg_7_1 == var_7_0[iter_7_2].account_id then
				return var_7_0[iter_7_2]
			end
		end
	end

	function arg_1_0:recommend_friend_list()
		return self._recommend_friend_data
	end

	function arg_1_0:__friend__update_friend_info(arg_9_1, arg_9_2)
		if arg_9_2 == 1 then
			self._friend_data[arg_9_1.account_id] = arg_9_1
		elseif arg_9_2 == 2 then
			self._recommend_friend_data[arg_9_1.account_id] = arg_9_1
		end
	end

	function arg_1_0:__friend__add_friend_info(arg_10_1, arg_10_2)
		if arg_10_2 == 1 then
			self._friend_data[arg_10_1.account_id] = arg_10_1
		elseif arg_10_2 == 2 then
			self._recommend_friend_data[arg_10_1.account_id] = arg_10_1

			self:set_new_friend_req_flag(true)
			self:__update_friend_float()
		end
	end

	function arg_1_0:__friend__remove_friend_info(arg_11_1, arg_11_2)
		if arg_11_2 == 1 then
			self._friend_data[arg_11_1.account_id] = nil
		elseif arg_11_2 == 2 then
			self._recommend_friend_data[arg_11_1.account_id] = nil
		end
	end

	function arg_1_0:__friend__find_by_account_id(arg_12_1, arg_12_2)
		if arg_12_2 == 1 then
			return self._friend_data[arg_12_1]
		elseif arg_12_2 == 2 then
			return self._recommend_friend_data[arg_12_1]
		end
	end

	function arg_1_0:get_new_friend_req_flag()
		return self._new_friend_req_flag
	end

	function arg_1_0:set_new_friend_req_flag(arg_14_1)
		if self._new_friend_req_flag == arg_14_1 then
			return
		end

		self._new_friend_req_flag = arg_14_1
	end

	function arg_1_0.__update_friend_float(arg_15_0)
		local var_15_0 = var_0_2:getInstance("home")

		if var_15_0 and var_15_0:isVisible() then
			var_15_0:update_friend_float()
		end
	end
end

function var_0_0.extend_obj(arg_16_0)
	arg_16_0._friend_data = {}
	arg_16_0._recommend_friend_data = {}
	arg_16_0._new_friend_req_flag = nil
	arg_16_0._get_other_info = nil
end

return var_0_0
