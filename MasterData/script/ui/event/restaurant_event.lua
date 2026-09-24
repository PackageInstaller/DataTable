local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.util_func
local var_0_5 = gamecore.AudioManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_return_btn()
		var_0_2:set_to_cook(false)
		var_0_5:destroyCV()
		var_0_4.clear_all_friend_visit_panel()

		if self._enter_type == var_0_3.enter_restaurant_type.myself or self._enter_type == var_0_3.enter_restaurant_type.cook_setting then
			self:__destroy_panel()

			local var_2_0 = var_0_1:createInstance("living_areas")

			var_2_0:show()
			var_2_0:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.living_bgm))
		elseif self._enter_type == var_0_3.enter_restaurant_type.cardbook then
			self:__destroy_panel()

			local var_2_1 = var_0_1:getInstance("cardbook_info")

			if var_2_1 then
				var_2_1:setVisible(true)
			else
				var_0_4.show_what_panel("cardbook")
			end

			var_0_4.play_home_bgm()
		elseif self._enter_type == var_0_3.enter_restaurant_type.cardbook_and_no_friend then
			var_0_4.show_what_panel("show_room")
		elseif self._enter_type == var_0_3.enter_restaurant_type.friend then
			self:__destroy_panel()
			var_0_4.show_what_panel("friendsmain"):play_into_home_bgm()
		elseif self._enter_type == var_0_3.enter_restaurant_type.tower then
			local var_2_2 = var_0_1:getInstance("tower_ranking_list")

			self:__destroy_panel()

			if not var_2_2 then
				var_0_1:createInstance("climb_tower"):__onClick_main_top_btns_rank()
			else
				var_2_2._panel.gameObject:SetActive(true)
			end
		end
	end

	function arg_1_0:__onClick_home_btn()
		var_0_1:destroyInstance("select_member")
		self:__destroy_panel()

		local var_3_0 = var_0_1:createInstance("home")

		var_3_0:show()
		var_3_0:into_home_bgm()
	end

	function arg_1_0:__onClick_setting_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		self:__reset_role(2)
		self:setVisible(false)
		var_0_2:set_cook_common_state(false)
		var_0_1:createInstance("restaurant_setting"):show()
	end

	function arg_1_0:__onClick_choice_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		var_0_1:createInstance("restaurant_change_style"):show(self._now_style_id)
	end

	function arg_1_0:__onClick_buff_btn()
		self:__show_buff_info(true)
	end

	function arg_1_0:__onClick_food_list_food_1()
		self:__click_food_event(self._now_cookbook_list[1].id)
	end

	function arg_1_0:__onClick_food_list_food_2()
		self:__click_food_event(self._now_cookbook_list[2].id)
	end

	function arg_1_0:__onClick_food_list_food_3()
		self:__click_food_event(self._now_cookbook_list[3].id)
	end

	function arg_1_0:__onClick_tip_bg()
		self:__show_buff_info(false)
	end

	function arg_1_0:__onClick_collect_btn()
		self:__destroy_panel()

		local var_11_0 = var_0_1:getInstance("show_room")

		var_11_0:setVisible(true)
		var_11_0:play_bgm()
	end

	function arg_1_0:__onClick_cooking_bg_cook_skip_btn()
		if self._food_animation_step == 1 then
			self:skip_animation_one()
		elseif self._food_animation_step == 2 then
			self:skip_animation_two()
		end
	end

	function arg_1_0:__onClick_cooking_skip_bg_cook_close_btn()
		self:skip_animation_two()
	end

	function arg_1_0:__onClick_goodat_btn()
		self:setVisible(false)
		var_0_2:set_cook_common_state(true)
		var_0_1:createInstance("restaurant_type_layer"):show()
	end

	function arg_1_0:__click_food_event(arg_15_1)
		if self._enter_type == var_0_3.enter_restaurant_type.cardbook and not self._friend_data._is_friend or self._enter_type == var_0_3.enter_restaurant_type.cardbook_and_no_friend or self._enter_type == var_0_3.enter_restaurant_type.tower and not self._friend_data._is_friend then
			return
		end

		self._food_cid = arg_15_1

		var_0_1:createInstance("restaurant_cookinfo"):show(2, arg_15_1, nil, nil, self._enter_type, self._friend_data)
	end

	function arg_1_0:__destroy_panel()
		self:__canvas_render_mode(false)

		if self._cook_seq then
			self._cook_seq:Kill()

			self._cook_seq = nil
		end

		self:__reset_role(4)
		var_0_1:destroyInstance("restaurant")
		var_0_1:destroyInstance("restaurant_change_style")
		var_0_1:destroyInstance("restaurant_cookinfo")
		var_0_1:destroyInstance("restaurant_setting")
	end
end

function var_0_0.extend_obj(arg_17_0)
	return
end

return var_0_0
