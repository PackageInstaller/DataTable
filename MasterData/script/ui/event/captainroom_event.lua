local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.AudioManager
local var_0_4 = gamecore.util_func
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_type1_head_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))

		if self._enter_type == var_0_2.enter_captainroom_type.myself then
			self:instance_layer("captainroom_change_head", nil)
		else
			if self._friend_data and next(self._friend_data) then
				-- block empty
			else
				-- block empty
			end

			self:role_talk(self._control.type1.model_layer, self._friend_data.signature, nil, nil, true)
		end
	end

	function arg_1_0:__onClick_type1_fleet_btn()
		if not self:__panel_limit() then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		self:instance_layer("captainroom_fleet", nil)
	end

	function arg_1_0:__onClick_type1_type_btn()
		if not self:__panel_limit() then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		self:instance_layer("captainroom_change_style", nil)
	end

	function arg_1_0:__onClick_type1_music_btn()
		self:setVisible(false)
		self:instance_layer("music", nil)
	end

	function arg_1_0:__onClick_type1_msg_btn()
		if not self:__panel_limit() then
			return
		end

		self:show_btn_list_layer(false)
		self:editor_end_event()
	end

	function arg_1_0:__onClick_type1_role_btn()
		if self._enter_type == var_0_2.enter_captainroom_type.cardbook or self._enter_type == var_0_2.enter_captainroom_type.cardbook_and_no_friend or self._enter_type == var_0_2.enter_captainroom_type.tower and not self._friend_data._is_friend then
			return
		end

		self:show_btn_list_layer(not self._control.btn_list_layer.activeSelf)
	end

	function arg_1_0:__onClick_type2_head_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))

		if self._enter_type == var_0_2.enter_captainroom_type.myself then
			self:instance_layer("captainroom_change_head", nil)
		else
			self:role_talk(self._control.type2.model_layer, self._friend_data.signature or "", nil, nil, true)
		end
	end

	function arg_1_0:__onClick_type2_fleet_btn()
		if not self:__panel_limit() then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		self:instance_layer("captainroom_fleet", nil)
	end

	function arg_1_0:__onClick_type2_type_btn()
		if not self:__panel_limit() then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		self:instance_layer("captainroom_change_style", nil)
	end

	function arg_1_0:__onClick_type2_music_btn()
		self:setVisible(false)
		self:instance_layer("music", nil)
	end

	function arg_1_0:__onClick_type2_msg_btn()
		if not self:__panel_limit() then
			return
		end

		self:show_btn_list_layer(false)
		self:editor_end_event()
	end

	function arg_1_0:__onClick_type2_role_btn()
		if self._enter_type == var_0_2.enter_captainroom_type.cardbook or self._enter_type == var_0_2.enter_captainroom_type.cardbook_and_no_friend or self._enter_type == var_0_2.enter_captainroom_type.tower then
			return
		end

		self:show_btn_list_layer(not self._control.btn_list_layer.activeSelf)
	end

	function arg_1_0:__onClick_return_btn()
		var_0_5:set_to_cap(false)
		var_0_3:destroyCV()
		self:__destroy_panel()
		var_0_4.clear_all_friend_visit_panel()

		if self._enter_type == var_0_2.enter_captainroom_type.myself then
			var_0_1:createInstance("living_areas")._already_init = true

			self:instance_layer("living_areas", nil)
		elseif self._enter_type == var_0_2.enter_captainroom_type.cardbook then
			local var_14_0 = var_0_1:getInstance("cardbook_info")

			if var_14_0 then
				var_14_0:setVisible(true)
			else
				var_0_4.show_what_panel("cardbook")
			end

			var_0_4.play_home_bgm()
		elseif self._enter_type == var_0_2.enter_captainroom_type.cardbook_and_no_friend then
			var_0_1:createInstance("show_room"):show(self._friend_data.account_id, var_0_2.show_room_enter_type.friend, true)
			self:setVisible(false)
		elseif self._enter_type == var_0_2.enter_captainroom_type.friend then
			var_0_4.show_what_panel("friendsmain"):play_into_home_bgm()
		elseif self._enter_type == var_0_2.enter_captainroom_type.tower then
			local var_14_1 = var_0_1:getInstance("tower_ranking_list")

			if var_14_1 then
				var_14_1:setVisible(true)
			else
				var_0_1:createInstance("climb_tower"):back_tower_ranking_list()
			end
		end

		var_0_1:destroyInstance("select_member")
	end

	function arg_1_0:__onClick_home_btn()
		var_0_3:destroyCV()
		self:instance_layer("home", nil)
		self:__destroy_panel()

		if var_0_1:getInstance("select_member") then
			var_0_1:destroyInstance("select_member")
		end
	end

	function arg_1_0:__onClick_btn_list_layer()
		self:show_btn_list_layer(not self._control.btn_list_layer.activeSelf)
	end

	function arg_1_0:__onClick_btn_list_layer_bg_supply_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		self:instance_layer("chest_open_layer", false)
	end

	function arg_1_0:__onClick_btn_list_layer_bg_editor_btn()
		self:show_btn_list_layer(false)
		self:editor_end_event()
	end

	function arg_1_0:__onClick_btn_list_layer_bg_head_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		self:instance_layer("captainroom_change_head", false)
	end

	function arg_1_0:__onClick_btn_list_layer_bg_garrison_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		self:instance_layer("captainroom_fleet", false)
	end

	function arg_1_0:__onClick_btn_list_layer_bg_style_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		self:instance_layer("captainroom_change_style", false)
	end

	function arg_1_0:__onClick_btn_list_layer_bg_music_btn()
		self:setVisible(false)
		self:instance_layer("music", false)
	end

	function arg_1_0:__onClick_editor_layer_close_btn()
		self._control.editor_layer:SetActive(false)
	end

	function arg_1_0:__onClick_collect_btn()
		var_0_3:destroyCV()

		local var_24_0 = var_0_1:getInstance("show_room")

		self:__destroy_panel()

		if not var_24_0 then
			var_24_0 = var_0_1:createInstance("show_room")

			if self._enter_type == var_0_2.enter_captainroom_type.cardbook then
				var_24_0:show(self._friend_data, var_0_2.show_room_enter_type.cardbook)
			elseif self._enter_type == var_0_2.enter_captainroom_type.cardbook_and_no_friend then
				var_24_0:show(self._friend_data, var_0_2.show_room_enter_type.cardbook_and_no_friend)
			elseif self._enter_type == var_0_2.enter_captainroom_type.tower then
				var_24_0:show(self._friend_data, var_0_2.show_room_enter_type.tower)
			else
				var_24_0:show(self._friend_data.account_id, var_0_2.show_room_enter_type.friend)
			end
		else
			var_24_0:setVisible(true)
		end
	end

	function arg_1_0:__onClick_btn_list_layer2()
		self:show_btn_list_layer(not self._control.btn_list_layer2.activeSelf)
	end

	function arg_1_0:__onClick_btn_list_layer2_bg_odds_btn()
		self:show_btn_list_layer(false)
		var_0_1:createInstance("captainroom_friend_fleet"):show(self._friend_data, self._enter_type == var_0_2.enter_captainroom_type.tower and var_0_2.fight_type.tower_rank_friend_captainroom or var_0_2.fight_type.captainroom_friend)
	end

	function arg_1_0:instance_layer(arg_27_1, arg_27_2)
		if arg_27_2 ~= nil then
			self:show_btn_list_layer(arg_27_2)
		end

		local var_27_0 = var_0_1:createInstance(arg_27_1)

		if arg_27_1 == "music" then
			local var_27_1

			if self._enter_type == var_0_2.enter_captainroom_type.friend or self._enter_type == var_0_2.enter_captainroom_type.cardbook_and_no_friend then
				var_27_1 = var_0_2.enter_music_type.friend
			elseif self._enter_type == var_0_2.enter_captainroom_type.cardbook then
				var_27_1 = var_0_2.enter_music_type.cardbook
			elseif self._enter_type == var_0_2.enter_captainroom_type.myself then
				var_27_1 = var_0_2.enter_music_type.myself
			elseif self._enter_type == var_0_2.enter_captainroom_type.tower then
				var_27_1 = var_0_2.enter_music_type.tower_ranking_list
			end

			var_27_0:show(var_27_1)
		elseif arg_27_1 == "home" then
			var_27_0:show()
			var_27_0:play_open_ui_animation(true)
			var_27_0:into_home_bgm()
		else
			var_27_0:show()
		end
	end

	function arg_1_0.__destroy_panel(arg_28_0)
		var_0_1:destroyInstance("captainroom_change_head")
		var_0_1:destroyInstance("captainroom_change_style")
		var_0_1:destroyInstance("captainroom_fleet")
		var_0_1:destroyInstance("chest_open_layer")
		var_0_1:destroyInstance("captainroom_friend_fleet")
		var_0_1:destroyInstance("captainroom")
	end

	function arg_1_0:__panel_limit()
		if self._enter_type == var_0_2.enter_captainroom_type.friend or self._enter_type == var_0_2.enter_captainroom_type.cardbook or self._enter_type == var_0_2.enter_captainroom_type.cardbook_and_no_friend or self._enter_type == var_0_2.enter_captainroom_type.tower then
			return false
		end

		return true
	end
end

function var_0_0.extend_obj(arg_30_0)
	return
end

return var_0_0
