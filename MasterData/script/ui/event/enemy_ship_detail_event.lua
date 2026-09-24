local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_panel_bg_title_bg_close_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		var_0_3:set_other_info(nil)
		var_0_1:destroyInstance("enemy_ship_detail")
	end

	function arg_1_0:__onLongClick_panel_bg_right_bg_enemy_ship_item1_show_layer_off_set_ship_item_click_btn()
		self:__onlong_click_event(1)
	end

	function arg_1_0:__onLongClick_panel_bg_right_bg_enemy_ship_item2_show_layer_off_set_ship_item_click_btn()
		self:__onlong_click_event(2)
	end

	function arg_1_0:__onLongClick_panel_bg_right_bg_enemy_ship_item3_show_layer_off_set_ship_item_click_btn()
		self:__onlong_click_event(3)
	end

	function arg_1_0:__onLongClick_panel_bg_right_bg_enemy_ship_item4_show_layer_off_set_ship_item_click_btn()
		self:__onlong_click_event(4)
	end

	function arg_1_0:__onLongClick_panel_bg_right_bg_enemy_ship_item5_show_layer_off_set_ship_item_click_btn()
		self:__onlong_click_event(5)
	end

	function arg_1_0:__onLongClick_panel_bg_right_bg_enemy_ship_item6_show_layer_off_set_ship_item_click_btn()
		self:__onlong_click_event(6)
	end

	function arg_1_0.__onClick_panel_bg_right_bg_enemy_ship_item1_show_layer_off_set_ship_item_click_btn(arg_9_0)
		return
	end

	function arg_1_0.__onClick_panel_bg_right_bg_enemy_ship_item2_show_layer_off_set_ship_item_click_btn(arg_10_0)
		return
	end

	function arg_1_0.__onClick_panel_bg_right_bg_enemy_ship_item3_show_layer_off_set_ship_item_click_btn(arg_11_0)
		return
	end

	function arg_1_0.__onClick_panel_bg_right_bg_enemy_ship_item4_show_layer_off_set_ship_item_click_btn(arg_12_0)
		return
	end

	function arg_1_0.__onClick_panel_bg_right_bg_enemy_ship_item5_show_layer_off_set_ship_item_click_btn(arg_13_0)
		return
	end

	function arg_1_0.__onClick_panel_bg_right_bg_enemy_ship_item6_show_layer_off_set_ship_item_click_btn(arg_14_0)
		return
	end

	function arg_1_0:__onClick_panel_bg_update_btn()
		if self._limit_refresh_count > 0 then
			var_0_3:req_RefreshRivalReq(self._exercise_id)
		else
			var_0_4:show(var_0_5:getNowLang("errorcode_183"))
		end
	end

	function arg_1_0:__onClick_panel_bg_fight_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		var_0_1:destroyInstance("enemy_ship_detail")
		var_0_3:set_other_info(nil)

		local var_16_0 = var_0_1:getInstance("gotofight")

		if var_16_0 then
			var_16_0:setVisible(false)
		end

		var_0_1:createInstance("fight_prepare"):show({
			exercise_id = self._exercise_id,
			fight_prepare_type = var_0_2.fight_type.exercise
		})
	end
end

function var_0_0.extend_obj(arg_17_0)
	return
end

return var_0_0
