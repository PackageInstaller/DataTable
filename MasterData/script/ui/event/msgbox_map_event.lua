local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_confirm()
		self:setVisible(false)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		var_0_1:createInstance("ship_detail"):show(var_0_2.enter_ship_detail_type.ship_map, self._data, nil, nil, self._now_label, false)
	end

	function arg_1_0:__onClick_main_reduce_cd_item_1_next_btn_1()
		self:setVisible(false)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		if self._data_access[1] ~= 9 then
			local var_3_0 = var_0_1:getInstance("ship_map")

			if var_3_0 then
				var_3_0:__onToggle_all_do_type_layer_bg_size_group_toggle_group_all()
				var_0_1:destroyInstance("ship_map")
			end
		end

		local var_3_1 = var_0_1:getInstance("main_menu")

		if var_3_1 then
			var_3_1:reset(true)
			var_3_1:show(false)
		end

		var_0_1:destroyInstance("main_menu")
		self:__init_click_data(self._data_access[1])
	end

	function arg_1_0:__onClick_main_reduce_cd_item_2_next_btn_2()
		self:setVisible(false)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		if self._data_access[2] ~= 9 then
			local var_4_0 = var_0_1:getInstance("ship_map")

			if var_4_0 then
				var_4_0:__onToggle_all_do_type_layer_bg_size_group_toggle_group_all()
				var_0_1:destroyInstance("ship_map")
			end
		end

		local var_4_1 = var_0_1:getInstance("main_menu")

		if var_4_1 then
			var_4_1:reset(true)
			var_4_1:show(false)
		end

		var_0_1:destroyInstance("main_menu")
		self:__init_click_data(self._data_access[2])
	end

	function arg_1_0:__onClick_main_reduce_cd_item_3_next_btn_3()
		self:setVisible(false)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		if self._data_access[3] ~= 9 then
			local var_5_0 = var_0_1:getInstance("ship_map")

			if var_5_0 then
				var_5_0:__onToggle_all_do_type_layer_bg_size_group_toggle_group_all()
				var_0_1:destroyInstance("ship_map")
			end
		end

		local var_5_1 = var_0_1:getInstance("main_menu")

		if var_5_1 then
			var_5_1:reset(true)
			var_5_1:show(false)
		end

		var_0_1:destroyInstance("main_menu")
		self:__init_click_data(self._data_access[3])
	end

	function arg_1_0:__onClick_main_return_btn()
		self:setVisible(false)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
	end

	function arg_1_0:__onClick_main_reduce_cd_item_4_next_btn_4()
		self:setVisible(false)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		if self._data_access[4] ~= 9 then
			local var_7_0 = var_0_1:getInstance("ship_map")

			if var_7_0 then
				var_7_0:__onToggle_all_do_type_layer_bg_size_group_toggle_group_all()
				var_0_1:destroyInstance("ship_map")
			end
		end

		local var_7_1 = var_0_1:getInstance("main_menu")

		if var_7_1 then
			var_7_1:reset(true)
			var_7_1:show(false)
		end

		var_0_1:destroyInstance("main_menu")
		self:__init_click_data(self._data_access[4])
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
