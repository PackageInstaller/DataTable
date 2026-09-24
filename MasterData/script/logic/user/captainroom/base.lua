local var_0_0 = {}
local var_0_3 = table.sort
local var_0_4 = gamecore.util_func
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_captainroom_style()
		return (self:__get_sort_tb(self._captainroom_data.style_list))
	end

	function arg_1_0:get_captainroom_head()
		return (self:__get_sort_tb(self._captainroom_data.head_list))
	end

	function arg_1_0:get_captainroom_garrison()
		return self._captainroom_data.garrison_list
	end

	function arg_1_0.__get_sort_tb(arg_5_0, arg_5_1)
		local var_5_0 = var_0_4.dict_to_array(arg_5_1)

		var_0_3(var_5_0, function(arg_6_0, arg_6_1)
			return arg_6_0 < arg_6_1
		end)

		return var_5_0
	end

	function arg_1_0:reset_captainroom_data()
		self._captainroom_data.style_list = {}
		self._captainroom_data.head_list = {}
		self._captainroom_data.garrison_list = {}
	end

	function arg_1_0.set_friend_id(arg_8_0, arg_8_1)
		arg_8_0._friend_id = arg_8_1
	end

	function arg_1_0:get_friend_id()
		return self._friend_id
	end

	function arg_1_0:get_ship_daata_by_id(arg_10_1)
		local var_10_0 = var_0_5:get_friend_info(self._friend_id).mansion.garrison
		local var_10_1 = {}

		for iter_10_0, iter_10_1 in pairs(var_10_0 and var_0_4.little_clone(var_10_0) or {}) do
			if iter_10_1.cid == arg_10_1 then
				var_10_1 = iter_10_1

				break
			end
		end

		return var_10_1
	end

	function arg_1_0:__captainroom_style__update_id(arg_11_1)
		self._captainroom_data.style_list[arg_11_1] = arg_11_1
	end

	function arg_1_0:__captainroom_style__add_id(arg_12_1)
		self._captainroom_data.style_list[arg_12_1] = arg_12_1
	end

	function arg_1_0:__captainroom_style__remove_id(arg_13_1)
		self._captainroom_data.style_list[arg_13_1] = nil
	end

	function arg_1_0:__captainroom_head__update_id(arg_14_1)
		self._captainroom_data.head_list[arg_14_1] = arg_14_1
	end

	function arg_1_0:__captainroom_head__add_id(arg_15_1)
		self._captainroom_data.head_list[arg_15_1] = arg_15_1
	end

	function arg_1_0:__captainroom_head__remove_id(arg_16_1)
		self._captainroom_data.head_list[arg_16_1] = nil
	end
end

function var_0_0.extend_obj(arg_17_0)
	arg_17_0._captainroom_data = {
		style_list = {},
		head_list = {},
		garrison_list = {}
	}
	arg_17_0._friend_id = nil
end

return var_0_0
