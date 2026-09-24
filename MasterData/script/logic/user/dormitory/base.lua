local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = table.sort
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_dormitory_room_info(arg_2_1)
		return self._dormitory_data.room[arg_2_1]
	end

	function arg_1_0:get_dormitory_room_num()
		return #self._dormitory_data.room
	end

	function arg_1_0:get_dormitory_collect()
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(self._dormitory_data.collect) do
			if iter_4_1 ~= nil then
				var_0_1(var_4_0, iter_4_1)
			end
		end

		var_0_2(var_4_0, function(arg_5_0, arg_5_1)
			return arg_5_0.id < arg_5_1.id
		end)

		return var_4_0
	end

	function arg_1_0:get_dormitory_furniture()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(self._dormitory_data.furniture) do
			var_0_1(var_6_0, iter_6_1)
		end

		return var_6_0
	end

	function arg_1_0:have_furniture_for_cid(arg_7_1, arg_7_2)
		local var_7_0 = false

		for iter_7_0, iter_7_1 in pairs(self._dormitory_data.furniture) do
			if iter_7_1.cid == arg_7_1 and iter_7_1.room == 0 or iter_7_1.cid == arg_7_1 and iter_7_1.room == arg_7_2 then
				var_7_0 = true

				break
			end
		end

		return var_7_0
	end

	function arg_1_0:have_exhibition_for_id(arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = false

		for iter_8_0, iter_8_1 in pairs(self._dormitory_data.exhibition) do
			if iter_8_1.id == arg_8_1 then
				if arg_8_3 then
					if iter_8_1.type == var_0_3.dorm_exhibition_type.prefab and iter_8_1.type == arg_8_2 then
						var_8_0 = true

						break
					end
				elseif arg_8_2 ~= var_0_3.dorm_exhibition_type.prefab and iter_8_1.type ~= var_0_3.dorm_exhibition_type.prefab then
					var_8_0 = true

					break
				end
			end
		end

		return var_8_0
	end

	function arg_1_0:get_exhibition_for_id(arg_9_1, arg_9_2)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(self._dormitory_data.exhibition) do
			if iter_9_1.id == arg_9_1 then
				if arg_9_2 then
					if iter_9_1.type == var_0_3.dorm_exhibition_type.prefab and iter_9_1.type == type then
						var_9_0 = iter_9_1

						break
					end
				elseif type ~= var_0_3.dorm_exhibition_type.prefab and iter_9_1.type ~= var_0_3.dorm_exhibition_type.prefab then
					var_9_0 = iter_9_1

					break
				end
			end
		end

		return var_9_0
	end

	function arg_1_0:get_exhibition_data()
		return self._dormitory_data.exhibition
	end

	function arg_1_0:get_furniture_data_by_record_id(arg_11_1)
		return (self._dormitory_data.record[arg_11_1] and self._dormitory_data.record[arg_11_1].furniture or nil) and self._dormitory_data.record[arg_11_1].furniture
	end

	function arg_1_0:judge_funrniture_belong_to_dormiory(arg_12_1)
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in pairs(self._dormitory_data.furniture) do
			if arg_12_1 == iter_12_1.cid then
				var_0_1(var_12_0, iter_12_1)
			end
		end

		return var_12_0
	end

	function arg_1_0:reset_dormiyory_data()
		self._dormitory_data.furniture = {}
		self._dormitory_data.furniture_archive = {}
		self._dormitory_data.room = {}
		self._dormitory_data.collect = {}
		self._dormitory_data.exhibition = {}
		self._dormitory_data.record = {}
	end

	function arg_1_0:get_furniture_data_by_id(arg_14_1)
		return self._dormitory_data.furniture[arg_14_1]
	end

	function arg_1_0:get_dormitory_race_buff()
		return self._dormitory_data.race_buff
	end

	function arg_1_0:get_dormitory_furniture_archive()
		return self._dormitory_data.furniture_archive
	end

	function arg_1_0.clear_box_result(arg_17_0)
		arg_17_0._box_result_this_time = {}
		arg_17_0._box_result_flag = true
	end

	function arg_1_0:set_box_result(arg_18_1)
		if self._box_result_flag then
			var_0_1(self._box_result_this_time, arg_18_1)
		end
	end

	function arg_1_0:get_box_result()
		return self._box_result_this_time
	end

	function arg_1_0.reset_box_result_flag(arg_20_0)
		arg_20_0._box_result_flag = false
	end

	function arg_1_0:__dormitory__update_furniture_info(arg_21_1)
		self._dormitory_data.furniture[arg_21_1.id] = arg_21_1
	end

	function arg_1_0:__dormitory__add_furniture_info(arg_22_1)
		self._dormitory_data.furniture[arg_22_1.id] = arg_22_1
	end

	function arg_1_0:__dormitory__remove_furniture_info(arg_23_1)
		self._dormitory_data.furniture[arg_23_1.id] = nil
	end

	function arg_1_0:__dormitory__update_furniture_archive_info(arg_24_1)
		self._dormitory_data.furniture_archive[arg_24_1.id] = arg_24_1
	end

	function arg_1_0:__dormitory__add_furniture_archive_info(arg_25_1)
		self._dormitory_data.furniture_archive[arg_25_1.id] = arg_25_1
	end

	function arg_1_0:__dormitory__remove_furniture_archive_info(arg_26_1)
		self._dormitory_data.furniture_archive[arg_26_1.id] = nil
	end

	function arg_1_0:__dormitory__update_room_info(arg_27_1)
		self._dormitory_data.room[arg_27_1.id] = arg_27_1
	end

	function arg_1_0:__dormitory__add_room_info(arg_28_1)
		self._dormitory_data.room[arg_28_1.id] = arg_28_1
	end

	function arg_1_0:__dormitory__remove_room_info(arg_29_1)
		self._dormitory_data.room[arg_29_1.id] = nil
	end

	function arg_1_0:__dormitory__update_furniture_collect_info(arg_30_1)
		self._dormitory_data.collect[arg_30_1.id] = arg_30_1
	end

	function arg_1_0:__dormitory__add_furniture_collect_info(arg_31_1)
		self._dormitory_data.collect[arg_31_1.id] = arg_31_1
	end

	function arg_1_0:__dormitory__remove_furniture_collect_info(arg_32_1)
		self._dormitory_data.collect[arg_32_1.id] = nil
	end

	function arg_1_0:__dormitory__update_exhibition_info(arg_33_1)
		self._dormitory_data.exhibition[arg_33_1.id] = arg_33_1
	end

	function arg_1_0:__dormitory__add_exhibition_info(arg_34_1)
		self._dormitory_data.exhibition[arg_34_1.id] = arg_34_1
	end

	function arg_1_0:__dormitory__remove_exhibition_info(arg_35_1)
		self._dormitory_data.exhibition[arg_35_1.id] = nil
	end

	function arg_1_0:__dormitory__update_record_info(arg_36_1)
		self._dormitory_data.record[arg_36_1.id] = arg_36_1
	end

	function arg_1_0:__dormitory__add_record_info(arg_37_1)
		self._dormitory_data.record[arg_37_1.id] = arg_37_1
	end

	function arg_1_0:__dormitory__remove_record_info(arg_38_1)
		self._dormitory_data.record[arg_38_1.id] = nil
	end

	function arg_1_0:__dormitory__set_race_buff(arg_39_1)
		self._dormitory_data.race_buff = arg_39_1
	end

	function arg_1_0.set_domitory_game_list(arg_40_0, arg_40_1, arg_40_2)
		arg_40_0.role_list = arg_40_1
		arg_40_0.car_list = arg_40_2
	end

	function arg_1_0:get_domitory_game_list()
		return self.role_list, self.car_list
	end
end

function var_0_0.extend_obj(arg_42_0)
	arg_42_0._dormitory_data = {
		furniture = {},
		furniture_archive = {},
		room = {},
		collect = {},
		exhibition = {},
		record = {},
		race_buff = {}
	}
	arg_42_0.role_list = nil
	arg_42_0.car_list = nil
	arg_42_0._box_result_this_time = {}
	arg_42_0._box_result_flag = false
end

return var_0_0
