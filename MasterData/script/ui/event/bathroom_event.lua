local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.prompt

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_return_btn()
		var_0_3:set_to_shower(false)

		if self._enter_panel == nil then
			self._enter_panel = var_0_4.enter_bathroom_panel.living_areas
		end

		self:__destroy_panel()

		if var_0_1:getInstance("strike_main") and self._enter_panel == "fight_prepare" then
			var_0_1:createInstance("fight_prepare"):show((var_0_3:get_fight_info_for_strike()))

			return
		end

		local var_2_0 = var_0_1:createInstance(self._enter_panel)

		var_2_0:show(self._return_param)

		if self._enter_panel == var_0_4.enter_bathroom_panel.living_areas then
			var_2_0:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.living_bgm))
		elseif var_0_3:get_to_normal_fight() then
			local var_2_1 = var_0_1:getInstance("gotofight")

			if var_2_1 then
				if var_2_1._now_lock_id then
					var_2_1:_play_fight_bgm(var_2_1._now_lock_id)
				else
					self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.fignt_one))
				end
			else
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.fignt_one))
			end
		else
			local var_2_2 = var_0_1:getInstance("home")

			if var_2_2 then
				var_2_2:into_home_bgm()
			end
		end
	end

	function arg_1_0:__onClick_home_btn()
		var_0_1:destroyInstance("dock_team")

		local var_3_0 = var_0_1:createInstance("home")

		var_3_0:show()
		var_3_0:into_home_bgm()
		self:__destroy_panel()
	end

	function arg_1_0.__onClick_style_btn(arg_4_0)
		var_0_1:createInstance("bathroom_change_style"):show()
	end

	function arg_1_0.__onClick_repair_btn(arg_5_0)
		var_0_1:createInstance("bathroom_repair"):show()
	end

	function arg_1_0:__onClick_basket_1_frame_btn()
		self:__click_basket_expantion_event()
	end

	function arg_1_0:__onClick_basket_2_frame_btn()
		self:__click_basket_expantion_event()
	end

	function arg_1_0:__onClick_basket_3_frame_btn()
		self:__click_basket_expantion_event()
	end

	function arg_1_0:__onClick_quick_repair_layer_main_quitbtn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		self:__show_quick_repair_layer(false)

		self._now_repair_role_index = 0
	end

	function arg_1_0:__onClick_quick_repair_layer_main_confirmbtn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		var_0_3:req_QuickRepairReq({
			self._countdown_list[self._now_repair_role_index].character_data.id
		})
	end

	function arg_1_0:__onClick_expantion_layer_content_expansion_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_goto))
		self:__click_buy_expansion_event()
	end

	function arg_1_0:__onClick_expantion_layer_content_close_btn()
		self:__show_expantion_layer(false)
	end

	function arg_1_0:__onToggle_now_room_left_btn()
		self._room_end_pos = nil
		self._room_start_pos = nil

		if self._now_room_num == 1 then
			return
		end

		self._now_room_style_change = true
		self._now_room_num = 1

		self:_set_now_room_index(1)
	end

	function arg_1_0:__onToggle_now_room_mid_btn()
		self._room_end_pos = nil
		self._room_start_pos = nil

		if self._now_room_num == 2 then
			return
		end

		self._now_room_style_change = true
		self._now_room_num = 2

		self:_set_now_room_index(2)
	end

	function arg_1_0:__onToggle_now_room_right_btn()
		self._room_end_pos = nil
		self._room_start_pos = nil

		if self._now_room_num == 3 then
			return
		end

		self._now_room_style_change = true
		self._now_room_num = 3

		self:_set_now_room_index(3)
	end

	function arg_1_0.__onClick_now_room_left_btn_ban_btn(arg_16_0)
		var_0_5:show(var_0_2:getNowLang("bathroom_open_desc"))
	end

	function arg_1_0.__onClick_now_room_mid_btn_ban_btn(arg_17_0)
		var_0_5:show(var_0_2:getNowLang("bathroom_open_desc"))
	end

	function arg_1_0.__onClick_now_room_right_btn_ban_btn(arg_18_0)
		var_0_5:show(var_0_2:getNowLang("bathroom_open_desc"))
	end

	function arg_1_0:__destroy_panel()
		self:__reset_role_list()
		var_0_1:destroyInstance("bathroom")
		var_0_1:destroyInstance("bathroom_change_style")
		var_0_1:destroyInstance("bathroom_rubdown")
	end
end

function var_0_0.extend_obj(arg_20_0)
	return
end

return var_0_0
