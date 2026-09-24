local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = UnityEngine.Color(1, 1, 1, 1)
local var_0_5 = UnityEngine.Color(1, 1, 1, 0.5)
local var_0_6 = UnityEngine.Vector3(1.1, 1.1, 1.1)
local var_0_7 = UnityEngine.Vector3(1, 1, 1)

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_menu_return_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back_two))
		self:__play_top_menu_out_animation()

		local var_2_0 = var_0_1:getInstance("home")

		if var_2_0 then
			if not var_2_0._panel.activeSelf then
				var_2_0:setVisible(true)
			end

			var_2_0:into_home_bgm()

			if var_0_3:get_secretary_info().rand_secretary_flag == 1 then
				var_2_0:updata_model()
			end
		end
	end

	function arg_1_0:__onToggle_top_menu_tab_toggle_tab_1()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		for iter_3_0 = 1, 3 do
			if iter_3_0 == 1 then
				self._control.top_menu.tab_toggle["tab_" .. iter_3_0]["sbt" .. iter_3_0].text.color = var_0_4 or var_0_5
			end

			if iter_3_0 == 1 then
				self._control.top_menu.tab_toggle["tab_" .. iter_3_0]["sbt" .. iter_3_0].transform.localScale = var_0_6 or var_0_7
			end
		end

		self:__select_top_toggle(var_0_2.ship_ton.small)
	end

	function arg_1_0:__onToggle_top_menu_tab_toggle_tab_2()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		for iter_4_0 = 1, 3 do
			if iter_4_0 == 2 then
				self._control.top_menu.tab_toggle["tab_" .. iter_4_0]["sbt" .. iter_4_0].text.color = var_0_4 or var_0_5
			end

			if iter_4_0 == 2 then
				self._control.top_menu.tab_toggle["tab_" .. iter_4_0]["sbt" .. iter_4_0].transform.localScale = var_0_6 or var_0_7
			end
		end

		self:__select_top_toggle(var_0_2.ship_ton.middle)
	end

	function arg_1_0:__onToggle_top_menu_tab_toggle_tab_3()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		for iter_5_0 = 1, 3 do
			if iter_5_0 == 3 then
				self._control.top_menu.tab_toggle["tab_" .. iter_5_0]["sbt" .. iter_5_0].text.color = var_0_4 or var_0_5
			end

			if iter_5_0 == 3 then
				self._control.top_menu.tab_toggle["tab_" .. iter_5_0]["sbt" .. iter_5_0].transform.localScale = var_0_6 or var_0_7
			end
		end

		self:__select_top_toggle(var_0_2.ship_ton.large)
	end

	function arg_1_0.__onClick_ship_scroll_view_lattice_scroll_view_next_page_btn(arg_6_0)
		return
	end

	function arg_1_0.__onClick_ship_scroll_view_lattice_scroll_view_last_page_btn(arg_7_0)
		return
	end

	function arg_1_0:__onClick_ship_scroll_view_lattice_scroll_view_ship_info_confirm()
		if not next((var_0_3:get_workshop_data())) then
			if self.__click_upgrade_button_state == 0 then
				var_0_3:req_UpgradeWorkshopReq(self._last_click_node.node.first_array.next_id)

				self.__click_upgrade_button_state = 1
			end
		elseif self.__click_upgrade_button_state == 0 then
			var_0_3:req_UpgradeWorkshopReq(self.__now_next_id)

			self.__click_upgrade_button_state = 1
		end

		var_0_1:createInstance("loading"):show(true)
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
