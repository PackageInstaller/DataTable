local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = table.insert
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.Language
local var_0_6 = gameconfig.equip_config
local var_0_7 = DG.Tweening.DOTween
local var_0_8 = gamecore.prompt
local var_0_9 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onToggle_top_layer_toggle_control_constructure()
		if self:safe_check() then
			return
		end

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_top_btn))
		self:__select_one("constructure")
	end

	function arg_1_0:__onToggle_top_layer_toggle_control_disassemble()
		if self:safe_check() then
			return
		end

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_top_btn))
		self:__select_one("disassemble")
	end

	function arg_1_0:__onToggle_top_layer_toggle_control_research()
		if self:safe_check() then
			return
		end

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_top_btn))
		self:__select_one("research")
	end

	function arg_1_0:__onToggle_top_layer_toggle_control_dispose()
		if self:safe_check() then
			return
		end

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_top_btn))

		self._type_toggle_data = {
			"all"
		}

		self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(true)
		self:__select_one("dispose")
	end

	function arg_1_0:__onClick_right_layer_container_constructure_layer_disassemble_disassemble_layer_clear_btn()
		self:clear_disassemble_data()
	end

	function arg_1_0:__onClick_right_layer_container_constructure_layer_disassemble_disassemble_layer_disaasemble_btn()
		local var_7_0 = {}
		local var_7_1 = false

		for iter_7_0 = 2, #self._disassemble_data do
			if self._disassemble_data[iter_7_0].lock == true then
				var_0_8:show(var_0_5:getNowLang("cannot_dismantle"))

				return
			end

			if self._disassemble_data[iter_7_0].star >= 4 then
				var_7_1 = true
			end

			var_0_3(var_7_0, self._disassemble_data[iter_7_0].id)
		end

		if self._has_studying then
			var_0_8:show(var_0_5:getNowLang("ship_is_studying"))

			return
		end

		if #var_7_0 > 0 then
			if var_7_1 then
				var_0_1:createInstance("msgbox"):show(var_0_5:getNowLang("selectshipnotice"), function()
					var_0_2:req_DecomposeShip(var_7_0, self._unload_equips)
				end, nil, var_0_5:getNowLang("destroyshiptitle"))
			else
				var_0_2:req_DecomposeShip(var_7_0, self._unload_equips)
			end
		end
	end

	function arg_1_0:__onToggle_right_layer_container_constructure_layer_disassemble_disassemble_layer_checkbox_layer()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_goto))
	end

	function arg_1_0:__onClick_right_layer_container_constructure_layer_dispose_bottom_confirm_btn()
		local var_10_0 = {}
		local var_10_1 = false

		if not self._dispose_data or not next(self._dispose_data) then
			return
		end

		for iter_10_0, iter_10_1 in pairs(self._dispose_data) do
			if iter_10_1.num > 0 then
				if var_0_6.find_object_by_cid(iter_10_1.id).star >= 4 then
					var_10_1 = true
				end

				var_0_3(var_10_0, iter_10_1)
			end
		end

		local function var_10_2()
			var_0_2:req_DecomposeEquipment((var_0_9.incorporate_repetitive_equips(var_10_0)))

			self._dispose_data = {}
		end

		local var_10_3 = {
			fe = 0,
			al = 0,
			bullet = 0,
			oil = 0
		}

		for iter_10_2, iter_10_3 in ipairs(var_10_0) do
			local var_10_4 = var_0_6.find_object_by_cid(iter_10_3.id)

			var_10_3.al = var_10_3.al + var_10_4.dismantle[1].value * iter_10_3.num
			var_10_3.fe = var_10_3.fe + var_10_4.dismantle[2].value * iter_10_3.num
			var_10_3.bullet = var_10_3.bullet + var_10_4.dismantle[3].value * iter_10_3.num
			var_10_3.oil = var_10_3.oil + var_10_4.dismantle[4].value * iter_10_3.num
		end

		local var_10_5 = var_0_1:createInstance("msgbox")

		if #var_10_0 > 0 then
			if var_10_1 then
				var_10_5:show(var_0_5:getNowLang("destroyequipcontent"), function()
					var_10_5:showOne(var_10_3, var_10_2, nil, var_0_5:getNowLang("destoryequpgetresource"), var_0_4.msg_type.get_res)
				end, nil, var_0_5:getNowLang("destroyequiptitle"), nil, true)
			else
				var_10_5:showOne(var_10_3, var_10_2, nil, var_0_5:getNowLang("destoryequpgetresource"), var_0_4.msg_type.get_res)
			end
		else
			var_0_8:show(var_0_5:getNowLang("ui_select_dismantle_zero"))
		end
	end

	function arg_1_0:__onClick_right_layer_container_constructure_layer_dispose_bottom_cancel_btn()
		self._dispose_data = {}

		self:__update_reusable_cell_3()
	end

	function arg_1_0:__onClick_right_layer_equip_amount_layer_equip_filter_btn()
		local var_14_0 = var_0_1:createInstance("equip_type_layer")

		var_14_0:show()

		if self._need_revert then
			var_14_0:__revert_toggle_group_all_set()

			self._need_revert = false
		end

		var_14_0:__save_toggle_group_all_set_data()
	end

	function arg_1_0:__onClick_tip_layer()
		self:__show_equip_attr_panel(false)
	end

	function arg_1_0:__onClick_level_tips_supplement_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self:autoKillDOTween(var_0_7.Sequence()):Append(self._control.level_tips.transform:DOScale(0, 0.3):SetEase(DG.Tweening.Ease.InExpo):SetAutoKill(true)):OnKill(function()
			self._control.level_tips:SetActive(false)
		end)
	end

	function arg_1_0:__onScaleButtonClick_top_layer_close_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back_two))

		if self._now_label == "dispose" then
			self:__destroy_panel()

			local var_18_0 = var_0_1:getInstance("equip_type_layer")

			if var_18_0 then
				var_18_0:__revert_toggle_group_all_set()
				var_18_0:reset_sort_info()
				var_0_1:destroyInstance("equip_type_layer")
			end

			local var_18_1 = var_0_1:getInstance("home") or var_0_1:createInstance("home")

			var_18_1:into_home_bgm()

			var_18_1.scorll_auto = true
			var_18_1.is_down = false

			var_18_1._control.mp_activity_node.cover:SetActive(false)

			if self._enter_type == "home" or self._enter_type == "task" then
				var_18_1:show(true)
			else
				var_18_1:show()

				local var_18_2 = var_0_1:createInstance("main_menu")

				var_18_2:reset()
				var_18_2:show(false)
				var_18_1:__ishave_build_redpoint(var_18_2)
			end

			self._enter_type = nil
		elseif self._now_content and self._now_content.uITweenSequence then
			var_0_4:play_in_out_animation(self._now_content.uITweenSequence, false, function()
				self:__destroy_panel()

				local var_19_0 = var_0_1:getInstance("equip_type_layer")

				if var_19_0 then
					var_19_0:reset_sort_info()
					var_0_1:destroyInstance("equip_type_layer")
				end

				local var_19_1 = var_0_1:getInstance("home") or var_0_1:createInstance("home")

				var_19_1:into_home_bgm()

				var_19_1.scorll_auto = true
				var_19_1.is_down = false

				var_19_1._control.mp_activity_node.cover:SetActive(false)

				if self._enter_type == "home" or self._enter_type == "task" then
					var_19_1:show(true)
				else
					var_19_1:show()

					local var_19_2 = var_0_1:createInstance("main_menu")

					var_19_2:reset()
					var_19_2:show(false)
					var_19_1:__ishave_build_redpoint(var_19_2)
				end

				self._enter_type = nil
			end)
			var_0_4:play_in_out_animation(self._control.bg.uITweenSequence, false)
		end
	end

	function arg_1_0:__onClick_right_layer_container_constructure_layer_dispose_bottom_fast_confirm_btn()
		self:__update_reusable_cell_3()
		self:fast_choose_equipment()
	end
end

function var_0_0.extend_obj(arg_21_0)
	return
end

return var_0_0
