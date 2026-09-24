local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_race_unlock_layer_close_btn()
		var_0_2:getInstance("dormitory")._control.close_btn_bg.tip_image.gameObject:SetActive(false)
		self:__show_layer(1, false)
		self._dormitory:__toggle_menu(false)
		self._dormitory:__toggle_room_select(false)
		self._dormitory:__toggle_open_btn(false)
		self._dormitory:__onClick_menu_bg_close_menu_btn()
		var_0_2:destroyInstance("dormitory_game")
	end

	function arg_1_0:__onClick_race_unlock_layer_confirm_btn()
		self:__onClick_race_unlock_layer_close_btn()
	end

	function arg_1_0:__onClick_race_select_layer_team_1_selected_btn()
		self:click_select_btn_event(1)
	end

	function arg_1_0:__onClick_race_select_layer_team_2_selected_btn()
		self:click_select_btn_event(2)
	end

	function arg_1_0:__onClick_race_select_layer_team_3_selected_btn()
		self:click_select_btn_event(3)
	end

	function arg_1_0:__onClick_race_select_layer_return_btn()
		var_0_3:set_domitory_game_list(nil, nil)
		var_0_2:getInstance("dormitory")._control.close_btn_bg.tip_image.gameObject:SetActive(false)
		self:__update_dormitory_room()

		for iter_7_0, iter_7_1 in ipairs(self._role_move_seq) do
			if self._role_move_seq[iter_7_0]:IsPlaying() then
				self._role_move_seq[iter_7_0]:Kill()
			end
		end

		self._dormitory:__toggle_close_menu(true)
		self._dormitory:__toggle_menu(false)
		self._dormitory:__toggle_room_select(false)
		self._dormitory:__toggle_open_btn(true)
		var_0_2:destroyInstance("dormitory_game")
	end

	function arg_1_0:__onClick_race_result_layer_restart_btn()
		local var_8_0 = var_0_2:getInstance("dormitory_game")

		self.restart_list = {
			role = self._role_list,
			car = self._car_list
		}

		var_0_3:set_domitory_game_list(self._role_list, self._car_list)
		var_0_2:destroyInstance("dormitory_game")

		local var_8_1 = var_0_2:createInstance("dormitory_game")

		var_8_1:__reset_game()
		var_8_1:show()
	end

	function arg_1_0:__onClick_race_result_layer_return_btn()
		self:__onClick_race_select_layer_return_btn()
	end

	function arg_1_0:__onClick_buff_layer_tip_bg()
		if self._control.buff_layer.tip_bg.canvasGroup.alpha == 0 then
			self:__change_canvas_group_state(self._control.buff_layer.tip_bg, true)
		else
			self:__change_canvas_group_state(self._control.buff_layer.tip_bg, false)
		end
	end

	function arg_1_0:__onClick_buff_layer_on_furniture_button_buff()
		self:__onClick_buff_layer_tip_bg()
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
