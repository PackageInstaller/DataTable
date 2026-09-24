local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = table.insert
local var_0_5 = gamecore.Language
local var_0_6 = gamecore.prompt
local var_0_8 = gameconfig.ship_config
local var_0_9 = string.format
local var_0_10 = gameconfig.skill_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_close_btn()
		var_0_2:play_in_out_animation(self._now_content.uITweenSequence, false, function()
			self:clear_strengther_res_data()
			self:setVisible(false)
			self:__destroy_panel()

			if self._enter_type == "home" or self._enter_type == "task" then
				local var_3_0 = var_0_1:getInstance("home")

				var_3_0.scorll_auto = true
				var_3_0.is_down = false

				var_3_0._control.mp_activity_node.cover:SetActive(false)
				var_3_0:show(true)
			else
				var_0_1:getInstance("home"):show(true)

				local var_3_1 = var_0_1:createInstance("main_menu")

				var_3_1:show(false)
				var_3_1:reset()
			end

			self._enter_type = nil
		end)
		var_0_2:play_in_out_animation(self._control.bg.uITweenSequence, false)
	end

	function arg_1_0:__onToggle_top_toggle_control_strengthen()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
		self:__select_one("strengthen")

		self._cur_type = var_0_2.enter_select_member_type.strengthen
	end

	function arg_1_0:__onToggle_top_toggle_control_evo()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
		self:__select_one("evo")

		self._cur_type = var_0_2.enter_select_member_type.evo
	end

	function arg_1_0:__onToggle_top_toggle_control_skill()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
		self:__select_one("skill")

		self._cur_type = var_0_2.enter_select_member_type.skill
	end

	function arg_1_0:__onClick_left_shipinfo_select_btn()
		local var_7_0 = var_0_1:createInstance("select_member")
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(self._strength_res_data) do
			if iter_7_1 ~= " " then
				var_0_4(var_7_1, iter_7_1)
			end
		end

		self._canvas_group.blocksRaycasts = false

		var_7_0:show(nil, nil, nil, nil, nil, nil, true)
		var_7_0:show_by_type(self._cur_type, var_7_1, nil, nil, nil, nil, function()
			self._canvas_group.blocksRaycasts = true
		end)
	end

	function arg_1_0:__onClick_right_strengthen_detail_clear_btn()
		self:clear_strengther_res_data()
	end

	function arg_1_0:__onClick_right_strengthen_detail_streng_btn()
		if not self._data then
			var_0_6:show(var_0_5:getNowLang("strengthenerror101"))

			return
		end

		local var_10_0 = {}
		local var_10_1 = false
		local var_10_2 = false

		for iter_10_0 = 1, #self._strength_res_data do
			if self._strength_res_data[iter_10_0] and self._strength_res_data[iter_10_0].star then
				if self._strength_res_data[iter_10_0].star >= 4 then
					var_10_1 = true
				end

				if self._strength_res_data[iter_10_0].level and self._strength_res_data[iter_10_0].level > 1 then
					var_10_2 = true
				end

				var_0_4(var_10_0, self._strength_res_data[iter_10_0].id)
			end
		end

		if #var_10_0 == 0 then
			var_0_6:show(var_0_5:getNowLang("strengthenchoosefood"))

			return
		end

		local var_10_3 = false

		if self._has_studying then
			var_0_6:show(var_0_5:getNowLang("ship_is_studying"))

			return
		end

		for iter_10_1 = 2, #self._strength_res_data do
			if self._strength_res_data[iter_10_1].lock == true then
				var_10_3 = true

				break
			end
		end

		if var_10_3 then
			var_0_6:show(var_0_5:getNowLang("selectshipisrepair"))

			return
		end

		local var_10_4 = {
			id = self._data.id,
			consumables = var_10_0
		}

		if #var_10_0 > 0 then
			local var_10_5 = false

			for iter_10_2, iter_10_3 in ipairs(var_10_0) do
				local var_10_6 = var_0_3:find_character_by_id(iter_10_3)

				if not var_10_6 then
					return
				end

				if var_10_6 and next(var_10_6) and var_10_6.state == var_0_2.ship_state.repair then
					var_0_6:show(var_0_5:getNowLang("selectshipisrepair"))

					var_10_5 = true

					break
				end
			end

			if var_10_5 then
				return
			end

			local var_10_7

			if var_10_1 and var_10_2 then
				var_10_7 = var_0_5:getNowLang("selectshipnotice3")
			elseif var_10_1 then
				var_10_7 = var_0_5:getNowLang("selectshipnotice")
			elseif var_10_2 then
				var_10_7 = var_0_5:getNowLang("selectshipnotice2")
			end

			if var_10_7 then
				var_0_1:createInstance("msgbox"):show(var_10_7, function()
					var_0_3:req_IntensifyShip(var_10_4)
				end, nil, var_0_5:getNowLang("strengthentitle"))
			else
				var_0_3:req_IntensifyShip(var_10_4)
			end
		end
	end

	function arg_1_0:__onClick_right_evo_evo_info_corelist_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		var_0_1:createInstance("core_list"):setVisible(true)
	end

	function arg_1_0:__onClick_right_evo_evo_info_remake_btn()
		local var_13_0 = false
		local var_13_1 = var_0_3:get_use_info_data()

		if not self._data then
			var_0_6:show(var_0_5:getNowLang("need_remake"))

			return
		end

		local var_13_2 = var_0_8.find_object_by_cid(self._data.cid)

		if self._data.level < var_13_2.evo_level then
			var_0_6:show(var_0_5:getNowLang("shiplevelnotenough"))

			return
		end

		for iter_13_0, iter_13_1 in ipairs(var_13_2.evo_need_resource) do
			if iter_13_1.id == 2 then
				if var_13_1.oil < iter_13_1.value then
					var_0_6:show(var_0_5:getNowLang("oilnotenough"))

					return
				end
			elseif iter_13_1.id == 3 then
				if var_13_1.bullet < iter_13_1.value then
					var_0_6:show(var_0_5:getNowLang("ammonotenough"))

					return
				end
			elseif iter_13_1.id == 4 then
				if var_13_1.fe < iter_13_1.value then
					var_0_6:show(var_0_5:getNowLang("steelnotenough"))

					return
				end
			elseif iter_13_1.id == 9 then
				if var_13_1.al < iter_13_1.value then
					var_0_6:show(var_0_5:getNowLang("aluminumnotenough"))

					return
				end
			elseif var_0_3:get_item_count(iter_13_1.id) < iter_13_1.value then
				var_0_6:show(var_0_5:getNowLang("item_no_enough"))

				return
			else
				var_13_0 = true
			end
		end

		if var_13_0 then
			var_0_3:req_ShipEvo(self._data.id)
		else
			var_0_6:show(var_0_5:getNowLang("cannotremake"))
		end
	end

	function arg_1_0:__onClick_right_skill_skill_left_has_skill_left_awake_btn()
		if self._data then
			var_0_3:req_IntensifySkill(self._data.id)
		end
	end

	function arg_1_0:__onClick_right_skill_skill_left_has_skill_left_upgrade_btn()
		if self:__check_special_skill(var_0_8.find_object_by_cid(self._data.cid).skill_type) then
			var_0_6:show(var_0_5:getNowLang("skill_cannot_be_upgraded"))

			return
		end

		local var_15_0 = var_0_1:getInstance("remake")

		if var_15_0.uplevel == false then
			return
		end

		if self._data and var_15_0._can_send_req then
			var_0_3:req_IntensifySkill(self._data.id)
		end

		var_15_0:uplevel(false)
	end

	function arg_1_0:__onClick_right_skill_skill_left_has_skill_left_switch_btn()
		if self._data then
			var_0_1:createInstance("msgbox"):show(var_0_9(var_0_5:getNowLang("switchskillnotice"), var_0_10.find_object_by_skill_type_skill_level(self._cur_show_skill_id, self._data.skill_level).title), function()
				var_0_3:req_ShipChangeSkill({
					id = self._data.id,
					skill_id = self._cur_show_skill_id
				})
			end, nil, var_0_5:getNowLang("rsbt2"))
		end
	end

	function arg_1_0:__onClick_left_shipinfo_ship_change_btn()
		local var_18_0 = var_0_1:createInstance("select_member")
		local var_18_1 = {}

		for iter_18_0, iter_18_1 in pairs(self._strength_res_data) do
			if iter_18_1 ~= " " then
				var_0_4(var_18_1, iter_18_1)
			end
		end

		var_18_0:show()
		var_18_0:show_by_type(self._cur_type, var_18_1)
	end

	function arg_1_0:__onLongClick_left_shipinfo_ship_change_btn()
		self:setVisible(false)
		var_0_1:createInstance("ship_detail"):show(var_0_2.enter_ship_detail_type.remake, self._data)
	end

	function arg_1_0:__onClick_right_skill_has_skill_skill_info_left_btn()
		self._cur_skill_lv = self._cur_skill_lv - 1

		self:_show_left_or_right_btn()
	end

	function arg_1_0:__onClick_right_skill_has_skill_skill_info_right_btn()
		self._cur_skill_lv = self._cur_skill_lv + 1

		self:_show_left_or_right_btn()
	end

	function arg_1_0:__onClick_right_skill_has_skill_skill_up_up_btn()
		self._cur_skill_lv = self._data.skill_level

		self:__switch_btn_show_info(self._data.skills[1])
		self:__show_skill_info(self._data.skills[1])
	end

	function arg_1_0:__onClick_right_skill_has_skill_skill_down_down_btn()
		self._cur_skill_lv = self._data.skill_level

		self:__switch_btn_show_info(self._data.skills[2])
		self:__show_skill_info(self._data.skills[2])
	end

	function arg_1_0:__onScaleButtonClick_right_evo_evo_info_corelist_btn()
		self:__onClick_right_evo_evo_info_corelist_btn()
	end

	function arg_1_0:__onScaleButtonClick_top_close_btn()
		self:__onClick_top_close_btn()
	end

	function arg_1_0:__onScaleButtonClick_right_strengthen_detail_clear_btn()
		self:__onClick_right_strengthen_detail_clear_btn()
	end

	function arg_1_0:__onScaleButtonClick_right_strengthen_detail_streng_btn()
		self:__onClick_right_strengthen_detail_streng_btn()
	end

	function arg_1_0:__onScaleButtonClick_right_evo_evo_info_remake_btn()
		self:__onClick_right_evo_evo_info_remake_btn()
	end

	function arg_1_0:__onScaleButtonClick_right_skill_skill_left_has_skill_left_awake_btn()
		self:__onClick_right_skill_skill_left_has_skill_left_awake_btn()
	end

	function arg_1_0:__onScaleButtonClick_right_skill_skill_left_has_skill_left_upgrade_btn()
		self:__onClick_right_skill_skill_left_has_skill_left_upgrade_btn()
	end

	function arg_1_0:__onScaleButtonClick_right_skill_skill_left_has_skill_left_switch_btn()
		self:__onClick_right_skill_skill_left_has_skill_left_switch_btn()
	end
end

function var_0_0.extend_obj(arg_32_0)
	return
end

return var_0_0
