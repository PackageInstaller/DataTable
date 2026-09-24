local var_0_0 = lx
local var_0_3 = table.insert
local var_0_4 = gamecore.util_func
local var_0_5 = gamecore.UILoader

lx.define_class("user", function(arg_1_0)
	function arg_1_0:reinit()
		self:__reinit_response()
	end

	function arg_1_0:reset()
		self._in_game = false
		self._in_error = false

		self:__reset_account_data()
	end

	function arg_1_0:onAuthSucceed()
		self:reset()
	end

	function arg_1_0:isGameIng()
		return self._in_game
	end

	function arg_1_0.haveErrorReport(arg_6_0)
		arg_6_0._in_error = true
	end

	function arg_1_0:isErrorIng()
		return self._in_error
	end

	function arg_1_0.set_is_preload_completed(arg_8_0, arg_8_1)
		arg_8_0._is_preloaded = arg_8_1
	end

	function arg_1_0:get_is_preload_completed()
		return self._is_preloaded
	end

	function arg_1_0:set_preload_xm_ship_callback_func(arg_10_1)
		var_0_3(self._xm_callback, arg_10_1)
	end

	function arg_1_0:get_preload_xm_ship_callback_func()
		return self._xm_callback
	end

	function arg_1_0:onEnterGame()
		self._in_game = true

		local var_12_0 = var_0_5:getInstance("loading")

		if var_12_0 then
			var_12_0:show(false)
		end

		local var_12_1 = var_0_5:getInstance("reconnect")

		if var_12_1 then
			var_12_1:setVisible(false)
			self:set_bvr_close()
		end
	end

	function arg_1_0:set_bvr_close()
		local var_13_0 = var_0_5:getInstance("fight_info")
		local var_13_1 = var_0_5:getInstance("campaign_select")

		if var_13_0 or var_13_1 then
			self:req_BVRAttackChangeReq(self:get_bvr_state())

			if var_13_0 then
				var_13_0._control.bg.info_bg.enemy_info_bg.bvr_btn.spine_effect:SetActive(self:get_bvr_state())

				var_13_0._set_bvr_btn_isOn = false
			elseif var_13_1 then
				var_13_1._control.enemy_info_bg.bvr_btn.spine_effect:SetActive(self:get_bvr_state())

				var_13_1._set_bvr_btn_isOn = false
			end
		else
			return
		end
	end

	function arg_1_0:get_account_id()
		return self._account_id
	end

	function arg_1_0:get_name()
		return self._name
	end

	function arg_1_0:get_sex()
		return self._sex
	end

	function arg_1_0:get_secretary_id()
		return self._data.secretary
	end

	function arg_1_0:get_can_pay()
		return self._can_pay
	end

	function arg_1_0:get_home_bgm()
		return self._data.music
	end

	function arg_1_0:get_server_name()
		return self._server_name
	end

	function arg_1_0.set_server_name(arg_21_0, arg_21_1)
		arg_21_0._server_name = arg_21_1
	end

	function arg_1_0:get_use_recommend_off()
		return self._data.recommend_off
	end

	function arg_1_0:get_secretary_skin_id()
		return self:find_character_by_id(self._secretary).skin
	end

	function arg_1_0:get_use_info_data()
		return (var_0_4.little_clone(self._data))
	end

	function arg_1_0:get_use_auto_supply()
		return self._data.auto_supply
	end

	function arg_1_0:set_close_sign(arg_26_1)
		if self._close_sign_flag == arg_26_1 then
			return
		end

		self._close_sign_flag = arg_26_1
	end

	function arg_1_0.set_close_sp_sign(arg_27_0, arg_27_1)
		arg_27_0._close_sp_sign_flag = arg_27_1
	end

	function arg_1_0:get_close_sign()
		return self._close_sign_flag
	end

	function arg_1_0:get_close_sp_sign()
		return self._close_sp_sign_flag
	end

	function arg_1_0.set_close_announcement(arg_30_0, arg_30_1)
		arg_30_0._close_announcement_flag = arg_30_1
	end

	function arg_1_0:get_close_announcement()
		return self._close_announcement_flag
	end

	function arg_1_0:get_close_daily_notice()
		return self._data.daily_notice
	end

	function arg_1_0.reset_sign_data(arg_33_0)
		arg_33_0._close_sign_flag = false
	end

	function arg_1_0.reset_announcement_data(arg_34_0)
		arg_34_0._close_announcement_flag = true
	end

	function arg_1_0.reset_sp_sign_data(arg_35_0)
		arg_35_0._close_sp_sign_flag = false
	end

	function arg_1_0.set_in_bootyshop(arg_36_0, arg_36_1)
		arg_36_0._in_bootyshop = arg_36_1
	end

	function arg_1_0:get_in_bootyshop()
		return self._in_bootyshop
	end

	function arg_1_0.set_repair_info(arg_38_0, arg_38_1)
		arg_38_0._now_repair_time = arg_38_1
	end

	function arg_1_0:get_repair_info()
		return self._now_repair_time
	end

	function arg_1_0.set_into_cinema(arg_40_0, arg_40_1)
		arg_40_0._living_room_into = arg_40_1
	end

	function arg_1_0:get_into_cinema()
		return self._living_room_into
	end

	function arg_1_0.set_update_hot(arg_42_0, arg_42_1)
		arg_42_0._now_start_update = arg_42_1
	end

	function arg_1_0:get_update_hot()
		return self._now_start_update
	end

	function arg_1_0.set_is_harmonious(arg_44_0, arg_44_1)
		arg_44_0._is_harmonious = arg_44_1
	end

	function arg_1_0.set_is_first_auth(arg_45_0, arg_45_1)
		arg_45_0._is_first_auth = arg_45_1
	end

	function arg_1_0:get_is_first_auth()
		return self._is_first_auth
	end

	function arg_1_0.set_addiction_flag(arg_47_0, arg_47_1, arg_47_2)
		arg_47_0._now_addiction_time = arg_47_1
		arg_47_0._now_addiction_data = arg_47_2
	end

	function arg_1_0:get_addiction_flag()
		return self._now_addiction_time
	end

	function arg_1_0:get_addiction_data()
		return self._now_addiction_data
	end

	function arg_1_0:get_now_harmony()
		return self._is_harmony
	end

	function arg_1_0.set_ban_time(arg_51_0, arg_51_1)
		arg_51_0._now_time = arg_51_1
	end

	function arg_1_0:get_ban_time()
		return self._now_time
	end

	function arg_1_0.set_to_normal_fight(arg_53_0, arg_53_1)
		arg_53_0._now_is_fight = arg_53_1
	end

	function arg_1_0:get_to_normal_fight()
		return self._now_is_fight
	end

	function arg_1_0.set_to_cap(arg_55_0, arg_55_1)
		arg_55_0._now_is_cap = arg_55_1
	end

	function arg_1_0:get_to_cap()
		return self._now_is_cap
	end

	function arg_1_0.set_to_school(arg_57_0, arg_57_1)
		arg_57_0._now_is_school = arg_57_1
	end

	function arg_1_0:get_to_school()
		return self._now_is_school
	end

	function arg_1_0.set_to_cook(arg_59_0, arg_59_1)
		arg_59_0._now_is_cook = arg_59_1
	end

	function arg_1_0:get_to_cook()
		return self._now_is_cook
	end

	function arg_1_0.set_to_shower(arg_61_0, arg_61_1)
		arg_61_0._now_is_shower = arg_61_1
	end

	function arg_1_0:get_to_shower()
		return self._now_is_shower
	end

	function arg_1_0.set_to_living(arg_63_0, arg_63_1)
		arg_63_0._now_is_living = arg_63_1
	end

	function arg_1_0:get_to_living()
		return self._now_is_living
	end

	function arg_1_0.set_to_mix(arg_65_0, arg_65_1)
		arg_65_0._now_is_mix = arg_65_1
	end

	function arg_1_0:get_to_mix()
		return self._now_is_mix
	end

	function arg_1_0.set_to_eighth(arg_67_0, arg_67_1)
		arg_67_0._now_is_eighth = arg_67_1
	end

	function arg_1_0:get_to_eighth()
		return self._now_is_eighth
	end

	function arg_1_0.set_to_ninth(arg_69_0, arg_69_1)
		arg_69_0._now_is_ninth = arg_69_1
	end

	function arg_1_0:get_to_ninth()
		return self._now_is_ninth
	end

	function arg_1_0.set_to_score(arg_71_0, arg_71_1)
		arg_71_0._now_is_score = arg_71_1
	end

	function arg_1_0:get_to_score()
		return self._now_is_score
	end

	function arg_1_0:__main__update_ship_info(arg_73_1)
		for iter_73_0, iter_73_1 in pairs(arg_73_1) do
			self._main_icon_panel_position[iter_73_1.cid] = iter_73_1
		end
	end

	function arg_1_0:__main__add_ship_info(arg_74_1)
		for iter_74_0, iter_74_1 in pairs(arg_74_1) do
			self._main_icon_panel_position[iter_74_1.cid] = iter_74_1
		end
	end

	function arg_1_0:__main__remove_ship_info(arg_75_1)
		for iter_75_0, iter_75_1 in pairs(arg_75_1) do
			self._main_icon_panel_position[iter_75_1.cid] = iter_75_1
		end
	end

	function arg_1_0:get_main_icon_panel_position(arg_76_1)
		if arg_76_1 ~= nil then
			return self._main_icon_panel_position[arg_76_1]
		else
			local var_76_0 = 0

			for iter_76_0, iter_76_1 in pairs(self._main_icon_panel_position) do
				var_76_0 = iter_76_0

				break
			end

			return self._main_icon_panel_position[var_76_0]
		end
	end

	function arg_1_0.set_emergency_info(arg_77_0, arg_77_1)
		arg_77_0.emergency_info = arg_77_1
	end

	function arg_1_0:get_emergency_info()
		return self.emergency_info
	end

	function arg_1_0.set_bug_id(arg_79_0, arg_79_1)
		arg_79_0.sp_bug_id = arg_79_1
	end

	function arg_1_0:get_bug_id()
		return self.sp_bug_id
	end

	function arg_1_0.set_custom_ship_list(arg_81_0, arg_81_1)
		arg_81_0._custom_ship_list = arg_81_1
	end

	function arg_1_0:get_custom_ship_list()
		return self._custom_ship_list
	end

	function arg_1_0._set_custom_ship_state(arg_83_0, arg_83_1)
		arg_83_0._set_custom_ship = arg_83_1
	end

	function arg_1_0:get_custom_ship_state()
		return self._set_custom_ship
	end

	function arg_1_0.set_common_ship_deatil_num(arg_85_0, arg_85_1)
		arg_85_0._set_common_ship_deatil_num = arg_85_1
	end

	function arg_1_0:get_common_ship_deatil_num()
		return self._set_common_ship_deatil_num
	end

	function arg_1_0.set_home_panel_count(arg_87_0, arg_87_1)
		arg_87_0._home_panel_count = arg_87_1
	end

	function arg_1_0:get_home_panel_count()
		return self._home_panel_count
	end

	function arg_1_0.set_secretary_info(arg_89_0, arg_89_1)
		arg_89_0._secretary_info = arg_89_1
	end

	function arg_1_0:get_secretary_info()
		return self._secretary_info
	end

	function arg_1_0.set_all_select_member_list(arg_91_0, arg_91_1)
		arg_91_0._all_select_member_list = arg_91_1
	end

	function arg_1_0:get_all_select_member_list()
		return self._all_select_member_list
	end

	function arg_1_0.set_phone_bind_cd_time(arg_93_0, arg_93_1)
		arg_93_0._phone_bind_time_cd = arg_93_1
	end

	function arg_1_0:get_phone_bind_cd_time()
		return self._phone_bind_time_cd
	end

	function arg_1_0.set_now_bind(arg_95_0, arg_95_1)
		arg_95_0._now_bind_phone = arg_95_1
	end

	function arg_1_0:get_now_bind()
		return self._now_bind_phone
	end

	function arg_1_0.set_mail_send_code_time(arg_97_0, arg_97_1)
		arg_97_0._phone_bind_mail_time_cd = arg_97_1
	end

	function arg_1_0:get_mail_send_code_time()
		return self._phone_bind_mail_time_cd
	end

	function arg_1_0.set_now_equip_list(arg_99_0, arg_99_1)
		arg_99_0._old_equip_list = arg_99_1
	end

	function arg_1_0:get_now_equip_list(arg_100_1)
		return self._old_equip_list
	end

	function arg_1_0.set_expedition_level(arg_101_0, arg_101_1)
		arg_101_0._expedition_level = arg_101_1
	end

	function arg_1_0:get_expedition_level()
		return self._expedition_level
	end

	gamecore.extend_method(arg_1_0)
end)

return function()
	local var_103_0 = var_0_0.class("user")

	var_103_0._account_id = 0
	var_103_0._name = ""
	var_103_0._sex = 0
	var_103_0._data = nil
	var_103_0._server_name = ""
	var_103_0._audit_type = false
	var_103_0._last_offline_time = 0
	var_103_0._last_ip = ""
	var_103_0._close_sign_flag = nil
	var_103_0._close_sp_sign_flag = nil
	var_103_0._close_announcement_flag = true
	var_103_0._can_pay = true
	var_103_0._in_bootyshop = false
	var_103_0._set_num = 0
	var_103_0._is_reconnection = false
	var_103_0._now_repair_time = {}
	var_103_0._living_room_into = false
	var_103_0._now_start_update = false
	var_103_0._now_addiction_time = false
	var_103_0._is_first_auth = true
	var_103_0._is_harmony = true
	var_103_0._now_is_fight = false
	var_103_0._in_game = false
	var_103_0._in_error = false
	var_103_0._is_preloaded = false
	var_103_0._xm_callback = {}
	var_103_0._main_icon_panel_position = {}
	var_103_0.emergency_info = {}
	var_103_0._custom_ship_list = {}
	var_103_0._set_custom_ship = nil
	var_103_0._set_common_ship_deatil_num = 0
	var_103_0._home_panel_count = 1
	var_103_0._secretary_info = {}
	var_103_0._all_select_member_list = nil
	var_103_0._old_equip_list = nil
	var_103_0._expedition_level = nil

	gamecore.extend_obj(var_103_0)

	return var_103_0
end
