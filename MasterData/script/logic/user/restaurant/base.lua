local var_0_0 = {}
local var_0_1 = table.insert
local var_0_3 = table.sort
local var_0_4 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_restaurant_style()
		return (self:__get_sort_tb(self._restaurant_data.style_list))
	end

	function arg_1_0:get_restaurant_have_cookbook()
		return (self:__get_sort_tb(self._restaurant_data.have_cookbook_list))
	end

	function arg_1_0:get_restaurant_use_cookbook()
		return (var_0_4.dict_to_array(self._restaurant_data.use_cookbook_list))
	end

	function arg_1_0.__restaurant_the_cook_cookbook(arg_5_0, arg_5_1)
		arg_5_0.__user_restaurant_cookbook_exp = arg_5_1
	end

	function arg_1_0:get_restaurant_the_cook_cookbook(arg_6_1)
		local var_6_0 = 0

		for iter_6_0, iter_6_1 in pairs(self.__user_restaurant_cookbook_exp) do
			if arg_6_1 == iter_6_1.id then
				var_6_0 = iter_6_1.exp

				break
			end
		end

		return var_6_0
	end

	function arg_1_0:get_exp_by_id(arg_7_1)
		local var_7_0 = 0

		for iter_7_0, iter_7_1 in pairs(self._restaurant_data.use_cookbook_list) do
			if arg_7_1 == iter_7_1.id then
				var_7_0 = iter_7_1.exp

				break
			end
		end

		return var_7_0
	end

	function arg_1_0:get_restaurant_cookbook_buff()
		return self._restaurant_data.cookbook_buff
	end

	function arg_1_0.__get_sort_tb(arg_9_0, arg_9_1)
		local var_9_0 = var_0_4.dict_to_array(arg_9_1)

		var_0_3(var_9_0, function(arg_10_0, arg_10_1)
			return arg_10_0 < arg_10_1
		end)

		return var_9_0
	end

	function arg_1_0:reset_restaurant_data()
		self._restaurant_data.style_list = {}
		self._restaurant_data.have_cookbook_list = {}
		self._restaurant_data.use_cookbook_list = {}
		self._restaurant_data.cookbook_buff = {
			id = 0,
			end_time = 0
		}
	end

	function arg_1_0:set_friend_restaurant_data(arg_12_1)
		self._friend_restaurant_data.use_cookbook_list = arg_12_1.cook.cookbook
	end

	function arg_1_0:get_friend_exp_by_id(arg_13_1)
		local var_13_0 = 0

		for iter_13_0, iter_13_1 in pairs(self._friend_restaurant_data.use_cookbook_list) do
			if arg_13_1 == iter_13_1.id then
				var_13_0 = iter_13_1.exp

				break
			end
		end

		return var_13_0
	end

	function arg_1_0:__restaurant_style__update_id(arg_14_1)
		self._restaurant_data.style_list[arg_14_1] = arg_14_1
	end

	function arg_1_0:__restaurant_style__add_id(arg_15_1)
		self._restaurant_data.style_list[arg_15_1] = arg_15_1
	end

	function arg_1_0:__restaurant_style__remove_id(arg_16_1)
		self._restaurant_data.style_list[arg_16_1] = nil
	end

	function arg_1_0:__restaurant_have_cookbook__update_id(arg_17_1)
		self._restaurant_data.have_cookbook_list[arg_17_1] = arg_17_1
	end

	function arg_1_0:__restaurant_have_cookbook__add_id(arg_18_1)
		self._restaurant_data.have_cookbook_list[arg_18_1] = arg_18_1
	end

	function arg_1_0:__restaurant_have_cookbook__remove_id(arg_19_1)
		self._restaurant_data.have_cookbook_list[arg_19_1] = nil
	end

	function arg_1_0:__restaurant_use_cookbook(arg_20_1, arg_20_2)
		var_0_1(self._restaurant_data.use_cookbook_list, {
			id = arg_20_1,
			exp = arg_20_2
		})
	end

	function arg_1_0:__restaurant_cookbook_buff(arg_21_1, arg_21_2)
		self._restaurant_data.cookbook_buff = {
			id = arg_21_1,
			end_time = arg_21_2
		}
	end

	function arg_1_0.set_restaurant_cookbook_info(arg_22_0, arg_22_1)
		arg_22_0._all_food_info = arg_22_1
	end

	function arg_1_0:get_restaurant_cookbook_info()
		return self._all_food_info
	end

	function arg_1_0.set_cook_common_state(arg_24_0, arg_24_1)
		arg_24_0._cook_common = arg_24_1
	end

	function arg_1_0:get_cook_common_state()
		return self._cook_common
	end
end

function var_0_0:extend_obj()
	self._restaurant_data = {
		style_list = {},
		have_cookbook_list = {},
		use_cookbook_list = {},
		cookbook_buff = {}
	}
	self._friend_restaurant_data = {
		have_cookbook_list = {},
		use_cookbook_list = {},
		cookbook_buff = {}
	}
	self._restaurant_data.cookbook_buff = {
		id = 0,
		end_time = 0
	}
	self._all_food_info = {}
	self._cook_common = false
end

return var_0_0
