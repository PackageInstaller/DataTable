local var_0_0 = {}
local var_0_1 = gameconfig.item_config
local var_0_2 = table.insert
local var_0_3 = table.sort
local var_0_4 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_item(arg_2_1)
		return self._item_data[arg_2_1]
	end

	function arg_1_0:get_item_count(arg_3_1)
		if self._item_data[arg_3_1] == nil then
			return 0
		end

		return self._item_data[arg_3_1].count
	end

	function arg_1_0:get_all_items()
		return self._item_data
	end

	function arg_1_0:get_all_items_by_type(arg_5_1)
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in pairs(self._item_data) do
			local var_5_1 = var_0_1.find_object_by_cid(iter_5_1.id)

			if var_5_1 and var_5_1.type == arg_5_1 then
				var_0_2(var_5_0, iter_5_1)
			end
		end

		var_0_3(var_5_0, function(arg_6_0, arg_6_1)
			return arg_6_0.id < arg_6_1.id
		end)

		return var_5_0
	end

	function arg_1_0:get_fast_item_count()
		local var_7_1 = self:get_item(var_0_4.quick_repair_item_cid)

		return (var_7_1 and var_7_1.count or nil) and var_7_1.count
	end

	function arg_1_0:get_workshop_item_count(arg_8_1)
		local var_8_1 = self:get_item(var_0_4.workshop_const.workshop_item_id[arg_8_1])

		return (var_8_1 and var_8_1.count or nil) and var_8_1.count
	end

	function arg_1_0.reset_item_data(arg_9_0)
		arg_9_0._item_data = {}
	end

	function arg_1_0:__item__add_item_info(arg_10_1)
		self._item_data[arg_10_1.id] = arg_10_1
	end

	function arg_1_0:__item__update_item_info(arg_11_1)
		self._item_data[arg_11_1.id] = arg_11_1
	end

	function arg_1_0:__item__remove_item_info(arg_12_1)
		self._item_data[arg_12_1.id] = nil
	end

	function arg_1_0:__item__find_by_id(arg_13_1)
		return self._item_data[arg_13_1]
	end
end

function var_0_0.extend_obj(arg_14_0)
	arg_14_0._item_data = {}
end

return var_0_0
