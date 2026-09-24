local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = lx.json_encode
local var_0_3 = gameconfig.shop_config
local var_0_4 = gameconfig.ship_skill_buff_config
local var_0_5 = gameconfig.ship_pve_buff_config
local var_0_6 = gameconfig.joy_buff_config
local var_0_7 = UnityEngine
local var_0_8 = gamecore.UILoader
local var_0_9 = gamecore.BattleManager
local var_0_10 = gamecore.SceneManager
local var_0_11 = gamecore.user
local var_0_12 = gameenum.common_type
local var_0_13 = table.sort
local var_0_14 = table.insert
local var_0_15 = gamecore.Language
local var_0_16 = gamecore.util_func
local var_0_17 = UnityEngine.Input
local var_0_18 = UnityEngine.RectTransformUtility

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_mask()
		if not self:destroyChildren("buff_detail") then
			self:__show_hp_bar()
		end
	end

	function arg_1_0.__onClick_popup_combat_continue_frame_damagecontrol_buy(arg_3_0)
		if var_0_11:get_guide_state() then
			return
		end

		local var_3_0 = var_0_3.find_object_by_id(var_0_12.shop_damage_control_cid)
		local var_3_1 = var_0_8:createInstance("shop_bounced")

		var_3_1:show({
			price = var_3_0.price,
			title = var_3_0.title,
			id = var_0_12.shop_damage_control_cid
		})

		local var_3_2 = var_3_1._panel:GetComponent("Canvas")

		var_3_2.sortingOrder = var_3_2.sortingOrder + 1
	end

	function arg_1_0.__onClick_support_root_bg_mask(arg_4_0)
		return
	end

	function arg_1_0:__onClick_strong_buff_root_buff_bg_buff_icon()
		self:__set_buff_info()
	end

	function arg_1_0:__onClick_strong_buff_root_info_bg_close_btn()
		self._control.strong_buff_root.info_bg:SetActive(false)
	end

	function arg_1_0:__onClick_strong_buff_root_lock_bg_lock_icon()
		self:__set_lock_info()
	end

	function arg_1_0:__onClick_strong_buff_root_lock_info_lock_close()
		self._control.strong_buff_root.lock_info:SetActive(false)
	end

	function arg_1_0:__onClick_skip()
		if self._clicked_skip then
			return
		else
			self._clicked_skip = true
		end

		local var_9_0 = var_0_9:get_battle_result()
		local var_9_1 = var_0_9:get_battle_damage_report()

		var_0_9:exit(function(arg_10_0)
			if self._fight_type == var_0_12.fight_type.event_story and not var_0_11:get_battle_type() then
				self:enter_plot_event(arg_10_0, var_9_0)
			else
				var_0_11:req_QuitNightBattleReq()
				var_0_11:req_BattleFinishReq()
				self:write_battle_damage_info(var_9_1)
			end
		end)
	end

	function arg_1_0:__onClick_left_course()
		self:show_buff_desc("player", self:get_course_cid((var_0_9:getPlayerFormation())), self._control.left.course)
	end

	function arg_1_0:__onClick_right_course()
		self:show_buff_desc("enemy", self:get_course_cid((var_0_9:getEnmeyFormation())), self._control.right.course)
	end

	function arg_1_0:__onClick_support_root_bg_skip()
		if not self._support_func then
			return
		end

		self:close_click_support_attack()
		self._support_func()

		self._support_func = nil
	end

	function arg_1_0:__onClick_popup_combat_continue_frame_toggle_control_nightwarleft_btn()
		self:_play_into_se(var_0_12:get_audio_url(var_0_12.common_icon.music_path, var_0_12.back))

		if self._continue_frame_nightwarleft then
			return
		end

		self._continue_frame_nightwarleft = true

		if self._fight_type == var_0_12.fight_type.event_story and var_0_11:get_new_battle_type() ~= gameenum.battle_type.fight_type.strike then
			self:hide_night_war_tip()
			gamecore.BattleManager:handleBattleScene("night_attack_step", {
				damage_control_num = 0
			})
		else
			var_0_11:req_StartNightBattleReq()
		end
	end

	function arg_1_0:__onClick_popup_combat_continue_frame_toggle_control_nightwarright_btn()
		self:_play_into_se(var_0_12:get_audio_url(var_0_12.common_icon.music_path, var_0_12.back))

		local var_15_0 = gamecore.BattleManager:get_battle_result()
		local var_15_1 = var_0_9:get_battle_damage_report()

		var_0_9:exit(function(arg_16_0)
			if self._fight_type == gameenum.battle_type.fight_type.plot_main then
				self:enter_plot_event(arg_16_0, var_15_0)
			else
				var_0_11:req_QuitNightBattleReq()
				var_0_11:req_BattleFinishReq()
				self:write_battle_damage_info(var_15_1)
			end
		end)
	end

	function arg_1_0.write_battle_damage_info(arg_17_0, arg_17_1)
		if not app:isPC() then
			return
		end

		local var_17_0 = var_0_2(var_0_11:get_battle_data().record)
		local var_17_1 = app:getSystem()
		local var_17_2 = io.open(var_17_1:getWritePath() .. "battlereport", "wb")

		if var_17_1 then
			var_17_2:write(var_0_11:get_bvr_damage_info() .. var_0_1.json_format(arg_17_1) .. "\n" .. var_17_0)
		else
			var_17_2:write(var_0_1.json_format(arg_17_1) .. "\n" .. var_17_0)
		end

		var_17_2:close()
	end

	function arg_1_0:show_buff_desc(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
		local var_18_0 = var_0_4.find_object_by_cid(arg_18_2)
		local var_18_1 = var_0_5.find_object_by_id(arg_18_2)
		local var_18_2 = var_0_6.find_object_by_level(arg_18_4)

		if not var_18_0 and not var_18_1 and not var_18_2 then
			return
		end

		local var_18_3
		local var_18_4
		local var_18_5

		if var_18_0 then
			var_18_3 = var_18_0.title
			var_18_4 = var_0_12.open_broken and var_0_16.convert_rich_text(var_18_0.desc) or var_0_16.convert_rich_text(var_18_0.desc2)
			var_18_5 = var_18_0.level
		end

		if var_18_1 then
			var_18_3 = var_18_1.title
			var_18_4 = var_0_16.convert_rich_text(var_18_1.desc2)
		end

		if var_18_2 then
			var_18_3 = var_18_2.title
			var_18_4 = var_0_16.convert_rich_text(var_18_2.desc)
		end

		self:destroyChildren("buff_detail")

		local var_18_6, var_18_7 = self:loadUIPrefab("buff_detail", self._panel.transform)

		var_18_6:setVisible(true)

		var_18_6._panel.transform.localScale = Vector3.zero

		var_18_6._panel.transform:DOScale(Vector3.New(1, 1, 1), 0.2)
		var_18_6._control.bg.button.onClick:AddListener(function()
			self:destroyChildren("buff_detail")
		end)

		local var_18_8 = arg_18_3:GetComponent(typeof(var_0_7.RectTransform)).anchoredPosition.x
		local var_18_9 = arg_18_3:GetComponent(typeof(var_0_7.RectTransform)).anchoredPosition.y

		mousepoint = var_0_17.mousePosition
		self._uiroot_canvas_rect = var_0_16.get_ui_root_canvas_rect()
		self._ui_camera = var_0_16.get_ui_camera()

		local var_18_10, var_18_11 = var_0_18.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, mousepoint, self._ui_camera, nil)

		if var_18_10 then
			var_18_8 = var_18_11.x
			var_18_9 = var_18_11.y
		end

		local var_18_12 = 140
		local var_18_13 = -125

		var_18_6._panel.transform.pivot = Vector2(0.5, 0.5)

		if arg_18_1 == "enemy" then
			var_18_12 = -140
		end

		if arg_18_1 == "main_fight" or arg_18_1 == "abyss" then
			var_18_13 = 125
		end

		if arg_18_1 == "push_fight" then
			var_18_13 = 125
		end

		if arg_18_3 == self._control.left.course then
			var_18_12 = 170
			var_18_13 = -125
		end

		if arg_18_3 == self._control.right.course then
			var_18_12 = -170
			var_18_13 = -125
		end

		var_18_6._panel:GetComponent(typeof(var_0_7.RectTransform)).anchoredPosition = Vector2.New(var_18_8 + var_18_12, var_18_9 + var_18_13)

		if not var_18_5 or var_18_5 == 0 then
			var_18_7.bg.level:SetActive(false)
		else
			var_18_7.bg.level.text.text = "Lv:" .. var_18_5
		end

		var_18_7.bg.title.text.text = var_18_3
		var_18_7.bg.scrollview.content.info.text.text = var_18_4

		if arg_18_2 >= 911 and arg_18_2 <= 915 then
			var_18_7.bg.air_atk_txt.text.text = var_0_15:getNowLang("counter_air_num")
			var_18_7.bg.air_atk_value.text.text = math.ceil(arg_18_5 * 100) / 100

			var_18_7.bg.air_atk_txt:SetActive(true)
			var_18_7.bg.air_atk_value:SetActive(true)
		else
			var_18_7.bg.air_atk_txt:SetActive(false)
			var_18_7.bg.air_atk_value:SetActive(false)
		end

		var_18_7.bg.bg_1:SetActive(false)
	end

	function arg_1_0.get_course_cid(arg_20_0, arg_20_1)
		local var_20_0 = var_0_12.course_type.same.course_id

		for iter_20_0, iter_20_1 in pairs(var_0_12.course_type) do
			if iter_20_1.value == arg_20_1 then
				var_20_0 = iter_20_1.course_id
			end
		end

		return var_20_0
	end

	function arg_1_0:enter_plot_event(arg_21_1, arg_21_2)
		log.print_r(debug.traceback(), "为什么会走这里")

		local var_21_0, var_21_1 = self:get_hp_comprehensive(self:get_enemy_data_list(arg_21_1), arg_21_2.enemy_state)
		local var_21_2, var_21_3 = self:get_hp_comprehensive(self:get_player_data_list(arg_21_1), arg_21_2.team_state)
		local var_21_4 = self:get_combat_score(var_21_0, var_21_1)
		local var_21_5 = self:get_combat_score(var_21_2, var_21_3)
		local var_21_6 = {
			exp = 0,
			enemy_score = var_21_5,
			score = var_21_4,
			reward = {},
			state = self:get_player_state(arg_21_2),
			enemy_state = self:get_enemy_state(arg_21_2),
			grade = self:get_combat_grade(arg_21_2, var_21_4, var_21_5)
		}

		var_0_10:loadScene("main", function()
			var_0_11:set_battle_result(var_21_6)
			var_0_8:createInstance("combat_result"):show(var_21_6, self._fight_type)
		end)
	end

	function arg_1_0.get_player_data_list(arg_23_0, arg_23_1)
		for iter_23_0, iter_23_1 in pairs(var_0_1.json_decode(arg_23_1)) do
			if iter_23_1.name == "BattleObject" then
				return iter_23_1.param.data.player
			end
		end
	end

	function arg_1_0.get_enemy_data_list(arg_24_0, arg_24_1)
		for iter_24_0, iter_24_1 in pairs(var_0_1.json_decode(arg_24_1)) do
			if iter_24_1.name == "BattleObject" then
				return iter_24_1.param.data.enemy
			end
		end
	end

	function arg_1_0.get_hp_comprehensive(arg_25_0, arg_25_1, arg_25_2)
		local var_25_0 = 0
		local var_25_1 = 0

		for iter_25_0, iter_25_1 in pairs(arg_25_1) do
			var_25_0 = var_25_0 + iter_25_1.hp
		end

		for iter_25_2, iter_25_3 in pairs(arg_25_2) do
			var_25_1 = var_25_1 + iter_25_3.hp
		end

		return var_25_0, var_25_1
	end

	function arg_1_0.get_combat_score(arg_26_0, arg_26_1, arg_26_2)
		return (arg_26_1 - arg_26_2) / arg_26_1
	end

	function arg_1_0:get_player_state(arg_27_1)
		local var_27_0 = self:sort_rule(arg_27_1.team_state)
		local var_27_1 = {}

		for iter_27_0, iter_27_1 in pairs(arg_27_1.team_state) do
			var_0_14(var_27_1, {
				up = false,
				exp = 0,
				mvp = iter_27_1.id == var_27_0.id,
				hp = iter_27_1.hp,
				id = iter_27_1.id
			})
		end

		return var_27_1
	end

	function arg_1_0.get_enemy_state(arg_28_0, arg_28_1)
		local var_28_0 = {}

		for iter_28_0, iter_28_1 in pairs(arg_28_1.enemy_state) do
			var_0_14(var_28_0, {
				hp = iter_28_1.hp,
				id = iter_28_1.id
			})
		end

		return var_28_0
	end

	function arg_1_0.get_combat_grade(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
		local var_29_0 = true
		local var_29_1 = false
		local var_29_2 = true
		local var_29_3 = 0
		local var_29_4 = 0
		local var_29_5 = false

		for iter_29_0, iter_29_1 in pairs(arg_29_1.enemy_state) do
			if iter_29_1.hp ~= 0 then
				var_29_0 = false
			else
				if iter_29_0 == 1 then
					var_29_5 = true
				end

				var_29_3 = var_29_3 + 1
			end

			var_29_4 = var_29_4 + 1
		end

		if arg_29_3 == 0 then
			var_29_1 = true
		end

		for iter_29_2, iter_29_3 in pairs(arg_29_1.team_state) do
			if iter_29_3.hp == 0 then
				var_29_2 = false
			end
		end

		if var_29_0 == true and var_29_1 == true then
			return 1
		end

		if var_29_0 == true and var_29_2 == true then
			return 2
		end

		if var_29_2 == true then
			if var_29_4 == 6 and var_29_3 >= 4 then
				return 3
			elseif var_29_4 == 5 and var_29_3 == 3 then
				return 3
			elseif (var_29_4 == 4 or var_29_4 == 3) and var_29_3 == 2 then
				return 3
			elseif var_29_4 == 2 and var_29_3 == 1 then
				return 3
			elseif var_29_5 == true then
				return 4
			elseif var_29_1 == true and arg_29_2 ~= 0 then
				return 4
			elseif arg_29_2 > 2.5 * arg_29_3 then
				return 4
			else
				return 5
			end
		end

		return 6
	end

	function arg_1_0.sort_rule(arg_30_0, arg_30_1)
		var_0_13(arg_30_1, function(arg_31_0, arg_31_1)
			return arg_31_0.hurt > arg_31_1.hurt
		end)

		return arg_30_1[1]
	end

	function arg_1_0.click_down_return_state(arg_32_0)
		return false
	end
end

function var_0_0.extend_obj(arg_33_0)
	return
end

return var_0_0
