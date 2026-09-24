local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_4 = gamecore.AudioManager
local var_0_5 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_collect_showcase_l()
		if self.from_friend == true then
			return
		end

		var_0_1:createInstance("show_room_collection"):show(2)
	end

	function arg_1_0:__onClick_collect_showcase_r()
		if self.from_friend == true then
			return
		end

		var_0_1:createInstance("show_room_collection"):show(2)
	end

	function arg_1_0:__onClick_collect_desktop()
		if self.from_friend == true then
			return
		end

		var_0_1:createInstance("show_room_collection"):show(1)
	end

	function arg_1_0:__onClick_collect_desktop_l()
		if self.from_friend == true then
			return
		end

		var_0_1:createInstance("show_room_collection"):show(1)
	end

	function arg_1_0:__onClick_collect_desktop_r()
		if self.from_friend == true then
			return
		end

		var_0_1:createInstance("show_room_collection"):show(1)
	end

	function arg_1_0:__onClick_bg_style()
		if self.from_friend == true then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		var_0_1:createInstance("show_room_change_style"):show(self.show_room_style)
	end

	function arg_1_0:__onClick_photoframe()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))

		local var_8_0 = var_0_1:createInstance("user_info")

		if self._enter_type == var_0_2.show_room_enter_type.cardbook then
			var_8_0:show(self._friend_data, var_0_2.user_info_enter_type.cardbook)
		elseif self._enter_type == var_0_2.show_room_enter_type.cardbook_and_no_friend then
			var_8_0:show(self._friend_data, var_0_2.user_info_enter_type.cardbook)
		elseif self._enter_type == var_0_2.show_room_enter_type.tower then
			var_8_0:show(self._friend_data, var_0_2.user_info_enter_type.tower)
		else
			var_8_0:show(self.from_friend_id, self._friend_data)
		end
	end

	function arg_1_0:__onClick_collect_btn_list_layer()
		self:show_btn_list_layer(not self._control.collect.btn_list_layer.activeSelf)
	end

	function arg_1_0.__onClick_collect_btn_list_layer_changestyle_btn(arg_10_0)
		return
	end

	function arg_1_0.__onClick_collect_btn_list_layer_collection_btn(arg_11_0)
		return
	end

	function arg_1_0.__onClick_collect_btn_list_layer_medal_btn(arg_12_0)
		return
	end

	function arg_1_0:__onClick_collect_role_btn()
		if self._enter_type == var_0_2.show_room_enter_type.cardbook and not self._friend_data._is_friend or self._enter_type == var_0_2.show_room_enter_type.cardbook_and_no_friend or self._enter_type == var_0_2.show_room_enter_type.tower and not self._friend_data._is_friend then
			return
		end

		self:show_btn_list_layer(not self._control.collect.btn_list_layer.activeSelf)
	end

	function arg_1_0:__onClick_to_captain_btn()
		self:setVisible(false)

		local var_14_0 = var_0_1:createInstance("captainroom")

		var_0_4:destroyCV()

		if self._enter_type == var_0_2.show_room_enter_type.cardbook then
			var_14_0:show(var_0_2.enter_captainroom_type.cardbook, self._friend_data)
		elseif self._enter_type == var_0_2.show_room_enter_type.cardbook_and_no_friend then
			var_14_0:show(var_0_2.enter_captainroom_type.cardbook_and_no_friend, self._friend_data)
		elseif self._enter_type == var_0_2.show_room_enter_type.tower then
			var_14_0:show(var_0_2.enter_captainroom_type.tower, self._friend_data)
		else
			var_14_0:show(var_0_2.enter_captainroom_type.friend, self._friend_data)
		end
	end

	function arg_1_0:__onClick_to_restaurant_btn()
		var_0_4:destroyCV()
		self:setVisible(false)

		local var_15_0 = var_0_1:createInstance("restaurant")

		if self._enter_type == var_0_2.show_room_enter_type.cardbook then
			self._friend_data._is_friend = self._is_friend or false

			var_15_0:show(var_0_2.enter_restaurant_type.cardbook, self._friend_data)
		elseif self._enter_type == var_0_2.show_room_enter_type.cardbook_and_no_friend then
			var_15_0:show(var_0_2.enter_restaurant_type.cardbook_and_no_friend, self._friend_data)
		elseif self._enter_type == var_0_2.show_room_enter_type.tower then
			var_15_0:show(var_0_2.enter_restaurant_type.tower, self._friend_data)
		else
			var_15_0:show(var_0_2.enter_restaurant_type.friend, self._friend_data)
		end
	end

	function arg_1_0.__onClick_collect_freind_btn_list_layer(arg_16_0)
		return
	end

	function arg_1_0.__onClick_collect_freind_btn_list_layer_friend_drill_btn(arg_17_0)
		return
	end

	function arg_1_0:__onClick_collect_cover()
		self:friend_medal_anim()
	end

	function arg_1_0:__onClick_collect_medal()
		if self.from_friend == true then
			self:friend_medal_anim()

			return
		end

		var_0_1:createInstance("show_room_medal"):show()
	end

	function arg_1_0.__onClick_collect_medal_medal_icon_1(arg_20_0)
		return
	end

	function arg_1_0.__onClick_collect_medal_medal_icon_2(arg_21_0)
		return
	end

	function arg_1_0.__onClick_collect_medal_medal_icon_3(arg_22_0)
		return
	end

	function arg_1_0.__onClick_collect_medal_medal_icon_4(arg_23_0)
		return
	end

	function arg_1_0.__onClick_collect_medal_medal_icon_5(arg_24_0)
		return
	end

	function arg_1_0:__onClick_collect_return_btn()
		var_0_4:destroyCV()
		var_0_5.clear_all_friend_visit_panel()

		if self._enter_type == var_0_2.show_room_enter_type.cardbook then
			local var_25_0 = var_0_1:getInstance("cardbook_info")

			if var_25_0 then
				var_25_0:setVisible(true)
			else
				var_0_5.show_what_panel("cardbook")
			end

			var_0_5.play_home_bgm()

			return
		elseif self._enter_type == var_0_2.show_room_enter_type.cardbook_and_no_friend then
			local var_25_1 = var_0_1:getInstance("friendsmain")

			if var_25_1 then
				var_25_1:_tip_have()
				var_25_1._panel.gameObject:SetActive(true)
			end

			return
		elseif self._enter_type == var_0_2.show_room_enter_type.tower then
			local var_25_2 = var_0_1:getInstance("tower_ranking_list")

			if var_25_2 then
				var_25_2:setVisible(true)
			else
				var_0_1:createInstance("climb_tower"):back_tower_ranking_list()
			end

			return
		elseif self._enter_type == var_0_2.show_room_enter_type.living_areas then
			var_0_5.show_what_panel("living_areas")

			return
		elseif self._enter_type == var_0_2.show_room_enter_type.friend then
			local var_25_3 = var_0_1:getInstance("friendsmain")

			if var_25_3 then
				var_25_3:setVisible(true)
				var_25_3:_tip_have()
			else
				var_25_3 = var_0_1:createInstance("friendsmain")

				var_25_3:show("main_menu")
			end

			var_25_3:play_into_home_bgm()

			return
		end

		local var_25_4 = var_0_1:createInstance("living_areas")

		var_25_4._already_init = true

		var_25_4:show(true)
		var_0_1:destroyInstance("captainroom_friend_fleet")

		if self.from_friend == true then
			var_25_4:setVisible(false)
			var_0_1:createInstance("home"):show()

			local var_25_5 = var_0_1:getInstance("friendsmain")

			if var_25_5 then
				var_25_5:_tip_have()
			end
		end
	end

	function arg_1_0.__onClick_collect_home_btn(arg_26_0)
		var_0_4:destroyCV()
		var_0_1:destroyInstance("show_room")

		local var_26_0 = var_0_1:createInstance("home")

		var_26_0:show()
		var_26_0:into_home_bgm()
	end

	function arg_1_0.__onPointerUp_collect_btn_list_layer_changestyle_btn(arg_27_0)
		return
	end

	function arg_1_0.__onPointerUp_collect_btn_list_layer_collection_btn(arg_28_0)
		return
	end

	function arg_1_0.__onPointerUp_collect_btn_list_layer_medal_btn(arg_29_0)
		return
	end

	function arg_1_0.__onPointerUp_collect_freind_btn_list_layer(arg_30_0)
		return
	end

	function arg_1_0.__onPointerUp_collect_freind_btn_list_layer_friend_drill_btn(arg_31_0)
		return
	end

	function arg_1_0:instance_layer(arg_32_1, arg_32_2, arg_32_3)
		if arg_32_2 ~= nil then
			self:show_btn_list_layer(arg_32_2)
		end

		var_0_1:createInstance(arg_32_1):show(arg_32_3)
	end
end

function var_0_0.extend_obj(arg_33_0)
	return
end

return var_0_0
