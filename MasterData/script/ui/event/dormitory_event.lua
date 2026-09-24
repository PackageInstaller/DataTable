local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.Language
local var_0_6 = gamecore.AuditServerManager
local var_0_7 = gamecore.dormitory_idea

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_open_btn_mask_open_menu_btn()
		self:__toggle_open_btn(false)
		self:__toggle_menu(true)
	end

	function arg_1_0:__onClick_menu_bg_close_menu_btn()
		self:__toggle_menu(false)
		self:__toggle_room_select(false)
		self:__toggle_open_btn(true)
	end

	function arg_1_0:__onClick_menu_bg_race_btn()
		if var_0_6:isAuditVersion() then
			var_0_4:show(var_0_5:getNowLang("not_enough_players"))

			return
		else
			var_0_1:getInstance("dormitory")._control.close_btn_bg.tip_image.gameObject:SetActive(true)

			if self:__judge_role_count_condition(var_0_3.fixed_data.racing_role_num) then
				var_0_1:createInstance("dormitory_game"):show()
			else
				var_0_4:show(var_0_5:getNowLang("notenoughship"))
			end
		end
	end

	function arg_1_0:__onClick_menu_bg_room_btn()
		self:__toggle_room_select(not self:__is_room_select_open())
	end

	function arg_1_0:__onClick_menu_bg_role_btn()
		self:__toggle_menu(false)
		self:__toggle_room_select(false)
		self:__toggle_open_btn(true)
		self:setVisible(false)
		self:__toggle_canvas_render_mode(false)

		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(var_0_2:get_dormitory_room_info(self._curr_room_index).members) do
			table.insert(var_6_0, var_0_2:find_character_by_id(iter_6_1))
		end

		var_0_1:createInstance("select_member"):show_by_type(var_0_3.enter_select_member_type.dormitory, var_6_0, nil)
		self:setVisible(false)
	end

	function arg_1_0:__onClick_menu_bg_warehouse_btn()
		self:__toggle_menu(false)
		self:__toggle_room_select(false)
		self:__toggle_open_btn(true)
		self:setVisible(false)

		self._furniture_list_form_warehouse = {}
		self._furniture_list_to_warehouse = {}

		var_0_1:createInstance("dorm_warehouse"):show()
	end

	function arg_1_0.__onClick_menu_bg_record_btn(arg_8_0)
		var_0_1:createInstance("dormitory_record"):show()
	end

	function arg_1_0.__onClick_menu_bg_collection_btn(arg_9_0)
		var_0_1:createInstance("dormitory_collection"):show()
	end

	function arg_1_0:__onClick_menu_bg_exhibition_btn()
		if self._exhibition_come_in_flag == 0 then
			var_0_2:req_GetExhibitionReq()
		end

		self._exhibition_come_in_flag = 1
	end

	function arg_1_0:__onClick_menu_bg_edit_btn()
		self:__toggle_menu(false)
		self:__toggle_room_select(false)
		self:__toggle_open_btn(false)
		self:__toggle_close_menu(false)
		self:__clear_all_ship_inter_furniture()
		self:__toggle_edit_mode(true)
		var_0_7:kill_all_seq()
	end

	function arg_1_0:__onClick_menu_bg_bg_btn()
		self:__toggle_menu(false)
		self:__toggle_room_select(false)
		self:__toggle_open_btn(true)
	end

	function arg_1_0:__onClick_close_btn_bg_return_btn()
		var_0_2:set_to_living(false)
		self:__toggle_menu(false)
		self:__toggle_room_select(false)
		self:__toggle_open_btn(true)
		self:__reset_select_member_info()
		var_0_2:set_domitory_game_list(nil, nil)

		local var_13_0 = var_0_1:getInstance("dormitory_game")

		if var_13_0 then
			var_13_0:return_to_dormitory()

			return
		end

		self:__destroy_panel()

		local var_13_1 = var_0_1:createInstance("living_areas")

		if self._bg_bgm then
			-- block empty
		else
			var_13_1._already_init = true
		end

		self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.living_bgm))

		self._bg_bgm = false

		var_13_1:show()
	end

	function arg_1_0:__onClick_close_btn_bg_home_btn()
		var_0_2:set_domitory_game_list(nil, nil)
		self:__reset_select_member_info()

		local var_14_0 = var_0_1:getInstance("dormitory_game")

		if var_14_0 then
			var_14_0:return_to_dormitory()
		end

		self:__destroy_panel()

		local var_14_1 = var_0_1:createInstance("home")

		var_14_1:show()
		var_14_1:into_home_bgm()
	end

	function arg_1_0:__onClick_edit_menu_bg_warehouse_btn()
		self:setVisible(false)
		var_0_1:createInstance("dorm_warehouse"):show()
	end

	function arg_1_0:__onClick_edit_menu_bg_clear_btn()
		if not self:__click_edit_ok_btn_event(true) then
			return
		end

		self:__set_covered_grid_pos_list(false)
		self:__hide_furniture_menu_btn()
		self:__clear_foot_grid_root()
	end

	function arg_1_0:__onClick_edit_menu_bg_cancel_btn()
		if not self:__click_edit_ok_btn_event(false, false) then
			return
		end

		self:__toggle_close_menu(true)
		self:__toggle_open_btn(true)
		self:__toggle_edit_mode(false, false)
	end

	function arg_1_0:__onClick_edit_menu_bg_ok_btn()
		if next(self._record_overlap_id_list) then
			for iter_18_0, iter_18_1 in pairs(self._record_overlap_id_list) do
				if iter_18_1 then
					var_0_4:show(var_0_5:getNowLang("roomnoticeerror"))

					return
				end
			end
		end

		if not self:__click_edit_ok_btn_event(false, true) then
			return
		end

		self:__toggle_close_menu(true)
		self:__toggle_open_btn(true)
		self:__toggle_edit_mode(false, true)
	end

	function arg_1_0:__onClick_furniture_menu_bg_hide_root_rotate_btn()
		self:__on_click_furniture_rotate_btn()
	end

	function arg_1_0:__onClick_furniture_menu_bg_hide_root_deposit_btn()
		self:__on_click_furniture_deposit_btn()
	end

	function arg_1_0:__onClick_room_select_bg_room1_room_btn()
		self:__show_room(1)
	end

	function arg_1_0:__onClick_room_select_bg_room2_room_btn()
		self:__show_room(2)
	end

	function arg_1_0:__onClick_room_select_bg_room3_room_btn()
		self:__show_room(3)
	end

	function arg_1_0:__onClick_room_select_bg_room4_room_btn()
		self:__show_room(4)
	end

	function arg_1_0:__onClick_room_select_bg_room5_room_btn()
		self:__show_room(5)
	end

	function arg_1_0:__onClick_room_select_bg_room6_room_btn()
		self:__show_room(6)
	end

	function arg_1_0.__onClick_room_select_bg_expand_btn(arg_27_0)
		var_0_1:createInstance("dormitory_expand_view"):show()
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

	function arg_1_0.__reset_select_member_info(arg_30_0)
		if var_0_1:getInstance("select_member") then
			var_0_1:destroyInstance("select_member")
		end
	end
end

function var_0_0.extend_obj(arg_31_0)
	return
end

return var_0_0
