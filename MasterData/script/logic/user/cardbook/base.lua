local var_0_0 = {}
local var_0_3 = table.sort
local var_0_4 = gamecore.util_func
local var_0_5 = gameconfig.ship_config
local var_0_6 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_cardbook_music_list()
		return (self:__get_sort_tb(self._cardbook_data.music))
	end

	function arg_1_0:get_cardbook_ship_list()
		local var_3_0 = var_0_4.dict_to_array(self._cardbook_data.ship)

		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			local var_3_2 = var_0_5.find_object_by_cid(iter_3_1.id)

			if var_3_2 and var_3_2.ship_index >= var_0_6.max_archive_index then
				table.remove(var_3_0, iter_3_0)
			end
		end

		var_0_3(var_3_0, function(arg_4_0, arg_4_1)
			return arg_4_0.id < arg_4_1.id
		end)

		for iter_3_2, iter_3_3 in pairs(var_3_0) do
			local var_3_3 = var_0_5.find_object_by_cid(iter_3_3.id)

			if var_3_3 and var_3_3.ship_index >= var_0_6.max_archive_index then
				table.remove(var_3_0, iter_3_2)
			end

			if var_3_3 and var_3_3.cid == 10011613 then
				table.remove(var_3_0, iter_3_2)
			end
		end

		return var_3_0
	end

	function arg_1_0:get_cardbook_equip_list()
		return (self:__get_sort_tb(self._cardbook_data.equip))
	end

	function arg_1_0:get_cardbook_sixth_buff_list()
		return (self:__get_sort_tb(self._cardbook_data.six_buff))
	end

	function arg_1_0.__get_sort_tb(arg_7_0, arg_7_1)
		local var_7_0 = var_0_4.dict_to_array(arg_7_1)

		var_0_3(var_7_0, function(arg_8_0, arg_8_1)
			return arg_8_0 < arg_8_1
		end)

		return var_7_0
	end

	function arg_1_0:reset_cardbook_data()
		self._cardbook_data.ship = {}
		self._cardbook_data.equip = {}
		self._cardbook_data.music = {}
		self._cardbook_data.six_buff = {}
		self._cardbook_data.tower = {}
		self._cardbook_info_data = {}
		self._user_info_list = {}
	end

	function arg_1_0.set_enter_ship_detail_type(arg_10_0, arg_10_1)
		arg_10_0._enter_ship_detail_type = arg_10_1
	end

	function arg_1_0:get_enter_ship_detail_type()
		self._enter_ship_detail_type = nil

		return self._enter_ship_detail_type
	end

	function arg_1_0.set_enter_abyss_ship_detail_type(arg_12_0, arg_12_1)
		arg_12_0._enter_abyss_ship_detail_type = arg_12_1
	end

	function arg_1_0:get_enter_abyss_ship_detail_type()
		self._enter_abyss_ship_detail_type = nil

		return self._enter_abyss_ship_detail_type
	end

	function arg_1_0:get_cardbook_user_info(arg_14_1)
		return self._user_info_list[arg_14_1]
	end

	function arg_1_0:__cardbook__update_info(arg_15_1, arg_15_2)
		if arg_15_2 == 1 then
			self._cardbook_data.ship[arg_15_1.id] = arg_15_1
		elseif arg_15_2 == 2 then
			self._cardbook_data.equip[arg_15_1.id] = arg_15_1.id
		elseif arg_15_2 == 3 then
			self._cardbook_data.music[arg_15_1.id] = arg_15_1.id
		elseif arg_15_2 == 4 then
			self._cardbook_data.six_buff[arg_15_1.id] = arg_15_1.id
		elseif arg_15_2 == 5 then
			self._cardbook_data.tower[arg_15_1.id] = arg_15_1.id
		end
	end

	function arg_1_0:__cardbook__add_info(arg_16_1, arg_16_2)
		if arg_16_2 == 1 then
			self._cardbook_data.ship[arg_16_1.id] = arg_16_1
		elseif arg_16_2 == 2 then
			self._cardbook_data.equip[arg_16_1.id] = arg_16_1.id
		elseif arg_16_2 == 3 then
			self._cardbook_data.music[arg_16_1.id] = arg_16_1.id
		elseif arg_16_2 == 4 then
			self._cardbook_data.six_buff[arg_16_1.id] = arg_16_1.id
		elseif arg_16_2 == 5 then
			self._cardbook_data.tower[arg_16_1.id] = arg_16_1.id
		end
	end

	function arg_1_0:__cardbook__remove_info(arg_17_1, arg_17_2)
		if arg_17_2 == 1 then
			self._cardbook_data.ship[arg_17_1.id] = nil
		elseif arg_17_2 == 2 then
			self._cardbook_data.equip[arg_17_1.id] = nil
		elseif arg_17_2 == 3 then
			self._cardbook_data.music[arg_17_1.id] = nil
		elseif arg_17_2 == 4 then
			self._cardbook_data.six_buff[arg_17_1.id] = nil
		elseif arg_17_2 == 5 then
			self._cardbook_data.tower[arg_17_1.id] = nil
		end
	end
end

function var_0_0.extend_obj(arg_18_0)
	arg_18_0._cardbook_data = {
		music = {},
		ship = {},
		equip = {},
		six_buff = {},
		tower = {}
	}
	arg_18_0._enter_ship_detail_type = nil
	arg_18_0._cardbook_info_data = {}
	arg_18_0._user_info_list = {}
end

return var_0_0
