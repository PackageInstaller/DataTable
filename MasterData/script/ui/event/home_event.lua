local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = UnityEngine
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.Language
local var_0_6 = gamecore.AudioManager
local var_0_7 = gamecore.PreloadManager
local var_0_8 = gamecore.prompt
local var_0_9 = UnityEngine.Input
local var_0_10 = UnityEngine.Vector2
local var_0_11 = UnityEngine.Vector3
local var_0_13 = UnityEngine.Screen

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_left_upon_on_button_support()
		var_0_6:destroyCV()
		self:setVisible(false)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		var_0_1:createInstance("ship_clerk_prepare"):show()
	end

	function arg_1_0:__onClick_left_upon_node_on_button_buff()
		self:__click_buff_btn_event(1, true)
	end

	function arg_1_0:__onClick_left_upon_node_on_item_button_buff()
		self:__click_buff_btn_event(2, true)
	end

	function arg_1_0:__onClick_left_upon_node_on_furniture_button_buff()
		self:__click_buff_btn_event(3, true)
	end

	function arg_1_0.__onClick_bottom_menu_btn_glow(arg_6_0)
		return
	end

	function arg_1_0.__onClick_top_main_up_bar_cover(arg_7_0)
		return
	end

	function arg_1_0.__onClick_top_user_res_bar_right_upon_buy_diamond(arg_8_0)
		var_0_1:createInstance("mall_shop"):show(var_0_4.mall_layer_type.layer_diamond, var_0_4.mall_enter_type.enter_home)
	end

	function arg_1_0.__onClick_top_resource_click(arg_9_0)
		return
	end

	function arg_1_0:__onClick_top_icon_click()
		var_0_1:createInstance("user_info"):show(nil)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
	end

	function arg_1_0:__onClick_top_ui_close()
		if self:get_click_opean_time() == 1 and not self._live2d then
			self._control.model_layer.model_btn:SetActive(true)

			if not self._live2d then
				self._control.model_layer.model_btn_2:SetActive(false)
			end

			var_0_9.multiTouchEnabled = false
			self._ui_close_state = false
			self._control.model_layer.shipViewControl.enabled = false

			self._control.top.back_button.gameObject:SetActive(false)
			self._control.top.role_scale.gameObject:SetActive(false)
			self._control.top.main_save_btn.gameObject:SetActive(false)
			self._control.top.main_reset_btn.gameObject:SetActive(false)
			self:set_click_opean_time(2)
		else
			self._allow_mouse_move = true
			var_0_9.multiTouchEnabled = false
			self._ui_close_state = false

			self:play_open_ui_animation(true)
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
			self:_update_main_position()
		end
	end

	function arg_1_0:__onClick_top_ui_open()
		var_0_9.multiTouchEnabled = true
		self._allow_mouse_move = false

		self:set_click_opean_time(1)
		self:play_open_ui_animation(false)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		self._ui_close_state = true
		self._control.model_layer.shipViewControl.enabled = true

		if self._live2d then
			var_0_8:show(var_0_5:getNowLang("not_adjustment"))
			self._control.top.back_button.gameObject:SetActive(false)
			self._control.top.role_scale.gameObject:SetActive(false)
			self._control.top.main_save_btn.gameObject:SetActive(false)
			self._control.top.main_reset_btn.gameObject:SetActive(false)

			self._ui_close_state = false
			self._control.model_layer.shipViewControl.enabled = false
		end
	end

	function arg_1_0.__onClick_bubble_layer_on_touch_bubble(arg_13_0)
		return
	end

	function arg_1_0.__onClick_bubble_layer_bubble_btn_layer_main_bubble_develop(arg_14_0)
		return
	end

	function arg_1_0.__onClick_bubble_layer_bubble_btn_layer_main_bubble_mail(arg_15_0)
		var_0_1:createInstance("mail"):show()
	end

	function arg_1_0.__onClick_bubble_layer_bubble_btn_layer_main_bubble_build(arg_16_0)
		return
	end

	function arg_1_0.__onClick_p_icon_touch_began(arg_17_0)
		return
	end

	function arg_1_0.__onClick_btntest(arg_18_0)
		return
	end

	function arg_1_0:__onClick_model_layer_model_btn()
		if not self._control.model_layer.talk.gameObject.activeSelf then
			self._control.model_layer.talk.bg1.bg3:SetActive(false)
			self._control.model_layer.talk.bg1.bg2:SetActive(true)

			self._control.model_layer.talk.bg1.transform.rotation = var_0_11.New(0, 0, 0)
			self._control.model_layer.talk.bg1.transform.localRotation = var_0_11(0, 0, 0)
			self._control.model_layer.talk.rectTransform.anchoredPosition = var_0_10(219, -275)

			self:__show_talk()

			local var_19_3 = self._control.model_layer.talk.rectTransform.anchoredPosition.x
			local var_19_5 = var_0_13.height - math.abs(self._control.model_layer.rectTransform.anchoredPosition.y) - (self._control.model_layer.talk.bg1.rectTransform.rect.height + self._control.model_layer.talk.bg1.bg2.rectTransform.rect.height + 40)
			local var_19_6 = var_0_13.width / 2 - math.abs(self._control.model_layer.rectTransform.anchoredPosition.x) - 360

			if self._control.model_layer.rectTransform.anchoredPosition.x + self._control.model_layer.talk.rectTransform.anchoredPosition.x - self._control.model_layer.talk.label_txt.rectTransform.rect.height / 2 < 600 and self._control.model_layer.rectTransform.anchoredPosition.x + self._control.model_layer.talk.rectTransform.anchoredPosition.x - self._control.model_layer.talk.label_txt.rectTransform.rect.height / 2 > 200 then
				self._control.model_layer.talk.bg1.transform.localRotation = var_0_11(0, 180, 0)
			end

			if self._control.model_layer.rectTransform.anchoredPosition.x > 0 then
				var_19_3 = var_19_3 - math.abs(360)
				self._control.model_layer.talk.rectTransform.anchoredPosition = var_0_10(var_19_3, 0)
			end

			local var_19_8 = self._control.model_layer.rectTransform.anchoredPosition.y + self._control.model_layer.talk.rectTransform.anchoredPosition.y - (self._control.model_layer.talk.label_txt.rectTransform.rect.height + 100) / 2

			if self._control.model_layer.rectTransform.anchoredPosition.y + self._control.model_layer.talk.rectTransform.anchoredPosition.y < 0 and self._control.model_layer.rectTransform.anchoredPosition.y < -120 then
				if math.abs(var_19_8) > 608.5 - (self._control.model_layer.talk.label_txt.rectTransform.rect.height + 100) then
					self._control.model_layer.talk.bg1.bg3:SetActive(true)
					self._control.model_layer.talk.bg1.bg2:SetActive(false)

					self._control.model_layer.talk.rectTransform.anchoredPosition = var_0_10(var_19_3, 0)
				end
			elseif self._control.model_layer.rectTransform.anchoredPosition.y + self._control.model_layer.talk.rectTransform.anchoredPosition.y > 0 and math.abs(var_19_8) > 191.5 - (self._control.model_layer.talk.label_txt.rectTransform.rect.height + 100) then
				self._control.model_layer.talk.rectTransform.anchoredPosition = var_0_10(var_19_3, 0 - (self._control.model_layer.rectTransform.anchoredPosition.y + self._control.model_layer.talk.rectTransform.anchoredPosition.y + self._control.model_layer.talk.label_txt.rectTransform.rect.height + 100))
			end
		end
	end

	function arg_1_0:__onClick_blur_layer()
		self._control.blur_layer:SetActive(false)
	end

	function arg_1_0:__onClick_top_user_res_bar_right_upon_res_btn()
		self:__show_resourse()
	end

	function arg_1_0:__onScaleButtonClick_bottom_btn_task()
		var_0_6:destroyCV()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task))
		self:setVisible(false)

		local var_22_0 = 0
		local var_22_1 = 0

		if self.acticity and next(self.acticity) then
			for iter_22_0, iter_22_1 in pairs(self.acticity) do
				if iter_22_1.type ~= var_0_4.pve_active_type.bootyshop then
					var_22_0 = iter_22_1.type
					var_22_1 = iter_22_1.id
				end
			end
		end

		var_0_1:createInstance("task"):show(var_22_0, var_22_1)
	end

	function arg_1_0:__onScaleButtonClick_bottom_btn_out()
		var_0_6:destroyCV()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.goto_fight))
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		local var_23_0 = var_0_1:createInstance("gotofight")
		local var_23_1 = {
			is_open_init = true
		}
		local var_23_2 = var_23_0:get_map_data()
		local var_23_3 = 0
		local var_23_4 = 0

		for iter_23_0, iter_23_1 in pairs(var_23_2) do
			for iter_23_2, iter_23_3 in pairs(iter_23_1) do
				var_23_4 = var_23_4 + 1
			end
		end

		local function var_23_5()
			var_23_3 = var_23_3 + 1

			if var_23_3 == var_23_4 then
				var_23_0:show(var_23_1, nil, function()
					self:setVisible(false)
				end)
			end
		end

		for iter_23_4, iter_23_5 in pairs(var_23_2) do
			for iter_23_6, iter_23_7 in pairs(iter_23_5) do
				var_0_7:preload_gotofight_map_asset(iter_23_7, var_23_5)
			end
		end
	end

	function arg_1_0.pairsByKeys(arg_26_0, arg_26_1)
		local var_26_0 = {}

		for iter_26_0 in pairs(arg_26_1) do
			var_26_0[#var_26_0 + 1] = iter_26_0
		end

		table.sort(var_26_0)

		local var_26_1 = 0

		return function()
			var_26_1 = var_26_1 + 1

			return var_26_0[var_26_1], arg_26_1[var_26_0[var_26_1]]
		end
	end

	function arg_1_0:__onScaleButtonClick_bottom_btn_ship()
		self:setVisible(false)
		var_0_1:createInstance("dock_team"):show()
	end

	function arg_1_0:__onScaleButtonClick_left_upon_on_button_living()
		var_0_6:destroyCV()
		self:setVisible(false)
		var_0_1:destroyStateUISet("game")

		local var_29_0 = var_0_1:createInstance("living_areas")

		var_29_0:show()

		var_29_0._already_init = false
	end

	function arg_1_0:__onScaleButtonClick_bottom_menu_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self:create_menu_panel()
		self._control.top.back_button.gameObject:SetActive(false)
		self._control.top.role_scale.gameObject:SetActive(false)
		self._control.top.main_save_btn.gameObject:SetActive(false)
		self._control.top.main_reset_btn.gameObject:SetActive(false)
		self:set_menu_info(true)

		self._allow_mouse_move = false
	end

	function arg_1_0:create_menu_panel()
		local var_31_0 = var_0_1:getInstance("main_menu") or var_0_1:createInstance("main_menu")

		var_31_0:reset(true)
		var_31_0:show(true)
		self:__ishave_build_redpoint(var_31_0)
		self:__is_have_activity_red_point(var_31_0)
	end

	function arg_1_0.__ishave_build_redpoint(arg_32_0, arg_32_1)
		for iter_32_0, iter_32_1 in pairs((var_0_3:get_total_dock_data())) do
			if iter_32_0 == var_0_4.pool_type.ship_build or iter_32_0 == var_0_4.pool_type.equipment_build then
				for iter_32_2, iter_32_3 in pairs(iter_32_1) do
					if iter_32_3.state == var_0_4.pool_state.finish then
						arg_32_1._control.content.toggle_group.build.main_menu_build_finish:SetActive(true)

						return
					end
				end

				arg_32_1._control.content.toggle_group.build.main_menu_build_finish:SetActive(false)
			end
		end
	end

	function arg_1_0:__is_have_activity_red_point(arg_33_1)
		if self:is_have_level_award() then
			arg_33_1._control.content.toggle_group.activity.activity_finish:SetActive(true)
		else
			arg_33_1._control.content.toggle_group.activity.activity_finish:SetActive(false)
		end
	end

	function arg_1_0.is_have_level_award(arg_34_0)
		local var_34_0 = false
		local var_34_1 = var_0_3:get_use_info_data()
		local var_34_2 = {}

		if var_34_1.level_up_award and next(var_34_1.level_up_award) then
			for iter_34_0, iter_34_1 in pairs(var_34_1.level_up_award) do
				table.insert(var_34_2, iter_34_1)
			end
		end

		local var_34_3 = 0

		if var_34_2 and next(var_34_2) then
			var_34_3 = #var_34_2

			if #var_34_2 == 10 then
				return false
			end
		end

		if var_34_3 < math.floor(var_34_1.level / 10) then
			var_34_0 = true

			return true
		end

		return var_34_0
	end

	function arg_1_0:__onClick_bottom_main_float_content_main_float_1_click_btn()
		local var_35_0 = var_0_1:createInstance("dock")

		var_0_1:createInstance("loading"):show(true, nil, true)
		var_35_0:set_enter_type("home")
		var_35_0:show(true)

		if self._dock_finish_type == var_0_4.pool_type.equipment_build then
			var_35_0:select_one("research", true)
		end
	end

	function arg_1_0.__onClick_bottom_main_float_content_main_float_2_click_btn(arg_36_0)
		var_0_1:createInstance("mail"):show()

		is_enter_mail = true

		var_0_3:set_new_mail_flag(false)
	end

	function arg_1_0:__onClick_bottom_main_float_content_main_float_3_click_btn()
		self:setVisible(false)
		var_0_1:createInstance("mall_shop"):show(var_0_4.mall_layer_type.layer_item, var_0_4.mall_enter_type.enter_home)
	end

	function arg_1_0.__onClick_bottom_main_float_content_main_float_4_click_btn(arg_38_0)
		var_0_1:getInstance("home"):setVisible(false)
		var_0_1:createInstance("friendsmain"):show("home")
		var_0_3:set_new_friend_req_flag(false)
	end

	function arg_1_0:__onClick_left_upon_tip_bg()
		self:__click_buff_btn_event(self._cur_show_buff_tip_index, false)
	end

	function arg_1_0:__onClick_bottom_main_float_content_main_float_5_click_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		var_0_1:createInstance("sp_sign"):show()
	end

	function arg_1_0.__onClick_bottom_main_float_content_main_float_6_click_btn(arg_41_0)
		var_0_1:createInstance("firsttopup"):show(true)
	end

	function arg_1_0:__onClick_bottom_main_float_content_main_float_7_click_btn()
		self:setVisible(false)
		var_0_1:createInstance("show_room_medal"):show()
	end

	function arg_1_0:__onScaleButtonClick_top_user_res_bar_right_upon_buy_diamond()
		self:__onClick_top_user_res_bar_right_upon_buy_diamond()
	end

	function arg_1_0:__onLongClick_bottom_shortcut_btn()
		self:__onLongClick_shortcut_btn()
	end

	function arg_1_0:__onPointerEnter_bottom_shortcut_btn()
		self:__onPointerEnter_shortcut_btn()
	end

	function arg_1_0:__onPointerUp_bottom_shortcut_btn()
		self:__onPointerUp_shortcut_btn()
	end

	function arg_1_0:__onLongClick_first_in_tween_shortcut_long_btn()
		self._shortcut_menu = var_0_1:createInstance("shortcut_menu")

		self._shortcut_menu:show((self._control.first_in_tween.shortcut_long_btn.homeLongClickEvent:GetClickViewportPos()))
	end

	function arg_1_0.__onPointerEnter_first_in_tween_shortcut_long_btn(arg_48_0)
		return
	end

	function arg_1_0:__onPointerUp_first_in_tween_shortcut_long_btn()
		if self._shortcut_menu and next(self._shortcut_menu) then
			self._shortcut_menu:setVisible(false)
			self._shortcut_menu:click_event((self._control.first_in_tween.shortcut_long_btn.homeLongClickEvent:GetPointerEnterName()))
		end
	end

	function arg_1_0:__onClick_top_back_button()
		self._ship_pos_start_pos = var_0_10(0, 0)
		self._ship_pos_end_pos = var_0_10(0, 0)

		self:play_open_ui_animation(true)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		self:_update_main_position()

		var_0_9.multiTouchEnabled = false
		self._allow_mouse_move = true
	end

	function arg_1_0:__onClick_top_role_scale_add_btn()
		local var_51_0 = self._control.top.role_scale.slide.slider.value + 0.1

		if self._control.top.role_scale.slide.slider.value + 0.1 > 1 then
			var_51_0 = 1
		end

		self._control.top.role_scale.slide.slider.value = var_51_0 > 1 and 1 or var_51_0
	end

	function arg_1_0:__onClick_top_role_scale_reduce_btn()
		self._control.top.role_scale.slide.slider.value = self._control.top.role_scale.slide.slider.value - 0.1 < 0 and 0 or self._control.top.role_scale.slide.slider.value - 0.1
	end

	function arg_1_0:__onClick_top_main_save_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		var_0_3:req_SecretaryShipAdjustReq({
			cid = self._main_panel_cid,
			scale = self._control.top.role_scale.slide.slider.value * 100,
			pos_x = self._control.model_layer.rectTransform.anchoredPosition.x * 100,
			pos_y = self._control.model_layer.rectTransform.anchoredPosition.y * 100
		})
	end

	function arg_1_0:__onClick_top_main_reset_btn()
		if self._control.model_layer.cc_sprite.icon.rectTransform.sizeDelta.x >= 2048 then
			self:__look_over_view(true)
		else
			self:__look_over_view()
		end

		self:_init_main_panel_position()

		self._control.top.role_scale.slide.slider.value = 0.33
	end

	function arg_1_0.__onClick_model_layer_model_btn_2(arg_55_0)
		return
	end

	function arg_1_0.__onClick_bottom_main_float_content_main_float_8_click_btn(arg_56_0)
		var_0_3:req_BindingPhoneReq(true)
		var_0_1:createInstance("phone_binding"):show()
	end

	function arg_1_0:__onClick_left_upon_node_on_combatshop_button_buff()
		self:__click_buff_btn_event(4, true)
	end

	function arg_1_0:__onClick_left_upon_node_on_combattactics_button_buff()
		self:__click_buff_btn_event(5, true)
	end

	function arg_1_0:__onClick_bottom_main_float_content_main_float_9_click_btn()
		lx.UserData:setKeyData("is_click_buy_ten", "true")
		self._control.bottom.main_float_content.main_float_9:SetActive(false)
		var_0_1:createInstance("msgbox"):show(var_0_5:getNowLang("tenth_shop"), function()
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
			var_0_2.Application.OpenURL("https://zhongchou.modian.com/item/135256.html")
		end, function()
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		end, var_0_5:getNowLang("jumpornot"), var_0_4.msg_type.tip, nil)
	end

	function arg_1_0:__onClick_bottom_main_float_content_main_float_10_click_btn()
		lx.UserData:setKeyData("is_click_buy_figurines", "true")
		self._control.bottom.main_float_content.main_float_10:SetActive(false)
		var_0_1:createInstance("msgbox"):show(var_0_5:getNowLang("tenth_shop"), function()
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
			var_0_2.Application.OpenURL("https://e.tb.cn/h.S3sk7VbLUgkSm89?tk=PmOL4w56Stn")
		end, function()
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		end, var_0_5:getNowLang("jumpornot"), var_0_4.msg_type.tip, nil)
	end

	function arg_1_0.__onClick_bottom_main_float_content_main_float_11_click_btn(arg_65_0)
		local var_65_0 = var_0_1:getInstance("upgradeawards")

		if var_65_0 then
			var_65_0:show()
		else
			var_0_1:createInstance("upgradeawards"):show()
		end
	end

	function arg_1_0.set_menu_info(arg_66_0, arg_66_1)
		arg_66_0._menu_info = arg_66_1
	end

	function arg_1_0:get_menu_info()
		return self._menu_info
	end
end

function var_0_0.extend_obj(arg_68_0)
	arg_68_0._shortcut_menu = nil
	arg_68_0._menu_info = true
end

return var_0_0
