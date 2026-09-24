local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:CookStyleUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__restaurant_style__action(iter_2_1.id, iter_2_1.action)
		end
	end

	function arg_1_0:CookBookUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__restaurant_have_cookbook__action(iter_3_1.id, iter_3_1.action)
			self:set_box_result(arg_3_1.updates)
		end
	end

	function arg_1_0:UseCookBookUpdate(arg_4_1)
		self._restaurant_data.use_cookbook_list = {}

		for iter_4_0, iter_4_1 in pairs(arg_4_1.set) do
			self:__restaurant_use_cookbook(iter_4_1.id, iter_4_1.exp)
		end
	end

	function arg_1_0:AllChefInfoUpdate(arg_5_1)
		if arg_5_1 and arg_5_1.updates and next(arg_5_1.updates) then
			self:set_restaurant_cookbook_info(arg_5_1.updates)
		end
	end

	function arg_1_0:ChefCookBookUpdate(arg_6_1)
		self:__restaurant_the_cook_cookbook(arg_6_1.set)
	end

	function arg_1_0:CookBuffInfoUpdate(arg_7_1)
		self:__restaurant_cookbook_buff(arg_7_1.buff.id, arg_7_1.buff.end_time)
	end

	function arg_1_0:__restaurant_style__action(arg_8_1, arg_8_2)
		if arg_8_2 == var_0_1.update_modify then
			self:__restaurant_style__update_id(arg_8_1)
		elseif arg_8_2 == var_0_1.update_add then
			self:__restaurant_style__add_id(arg_8_1)
		elseif arg_8_2 == var_0_1.update_remove then
			self:__restaurant_style__remove_id(arg_8_1)
		end
	end

	function arg_1_0:__restaurant_have_cookbook__action(arg_9_1, arg_9_2)
		if arg_9_2 == var_0_1.update_modify then
			self:__restaurant_have_cookbook__update_id(arg_9_1)
		elseif arg_9_2 == var_0_1.update_add then
			self:__restaurant_have_cookbook__add_id(arg_9_1)
		elseif arg_9_2 == var_0_1.update_remove then
			self:__restaurant_have_cookbook__remove_id(arg_9_1)
		end
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
