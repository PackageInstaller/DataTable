local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = string.format
local var_0_6 = gameenum.common_type
local var_0_7 = DG.Tweening.DOTween
local var_0_8 = gamecore.util_func
local var_0_9 = table.insert
local var_0_10 = table.remove
local var_0_11 = gameconfig.equip_config
local var_0_12 = gameconfig.ship_config
local var_0_13 = gameconfig.shop_config
local var_0_14 = gameconfig.skin_config
local var_0_15 = table.sort
local var_0_17 = Vector3
local var_0_18 = gamecore.AudioManager
local var_0_20 = gamecore.prompt
local var_0_21 = gamecore.Language
local var_0_22 = gameconfig.ship_rule_config
local var_0_23 = {
	research = "research",
	constructure = "constructure",
	dispose = "dispose",
	disassemble = "disassemble"
}

gamecore.UILoader:define("dock", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true, arg_2_1)
		var_0_18:destroyCV()

		arg_2_2 = arg_2_2 or "constructure"
		self._show_panel = arg_2_2

		self:level_tips_event()
		self:update_user_res_data(false)
	end

	function arg_1_0.set_enter_type(arg_3_0, arg_3_1)
		arg_3_0._enter_type = arg_3_1
	end

	function arg_1_0:__onUpdate()
		if self._start_update then
			local var_4_0 = false

			if self._now_label == var_0_23.constructure then
				for iter_4_0, iter_4_1 in ipairs(self._dock_data[var_0_6.pool_type.ship_build]) do
					if iter_4_1.state == var_0_6.pool_state.engaged then
						local var_4_1 = iter_4_1.time - lx.ServerTime:getUtcTime()

						if var_4_1 <= 0 then
							self._dock_build_contents[iter_4_1.pos_id].build_layer.gameObject:SetActive(false)
							self._dock_build_contents[iter_4_1.pos_id].complete_layer.gameObject:SetActive(true)
						else
							self._dock_build_contents[iter_4_1.pos_id].build_layer.time_txt.text.text = var_0_8.secondsToTime(var_4_1)
							var_4_0 = true
						end
					end
				end
			elseif self._now_label == var_0_23.research then
				for iter_4_2, iter_4_3 in ipairs(self._dock_data[var_0_6.pool_type.equipment_build]) do
					if iter_4_3.state == var_0_6.pool_state.engaged then
						local var_4_2 = iter_4_3.time - lx.ServerTime:getUtcTime()

						if var_4_2 <= 0 then
							self._dock_develop_contents[iter_4_3.pos_id].build_layer.gameObject:SetActive(false)
							self._dock_develop_contents[iter_4_3.pos_id].complete_layer.gameObject:SetActive(true)
						else
							self._dock_develop_contents[iter_4_3.pos_id].build_layer.time_txt.text.text = var_0_8.secondsToTime(var_4_2)
							var_4_0 = true
						end
					end
				end
			end

			if not var_4_0 then
				self._start_update = false
			end
		end

		if self._reusable_cell_3 then
			self._reusable_cell_3:update()
		end

		if self._reusable_cell_4 then
			self._reusable_cell_4:update()
		end
	end

	function arg_1_0:level_tips_event()
		if self._show_panel ~= "constructure" then
			return
		end

		local var_5_0 = self:autoKillDOTween(var_0_7.Sequence())
		local var_5_1 = var_0_2:getInstance("home")

		if var_0_3:get_use_info_data().level < 10 and var_5_1.level_tips == false then
			var_5_1.level_tips = true

			self._control.level_tips:SetActive(true)
			var_5_0:Append(self._control.level_tips.transform:DOScale(1, 0.3):SetEase(DG.Tweening.Ease.OutBack))
		end
	end

	function arg_1_0:update_data()
		self:__updata_user_res_1()
		self:__updata_user_res_2()

		self._dock_data = var_0_3:get_total_dock_data()

		self:init_equip_data()
		self:__set_finish_tag()

		if self._now_label == var_0_23.constructure then
			for iter_6_0, iter_6_1 in ipairs(self._dock_data[var_0_6.pool_type.ship_build]) do
				self:__set_ui_state(iter_6_1.available, iter_6_1.state, self._dock_build_contents[iter_6_1.pos_id], iter_6_1.id)
			end
		elseif self._now_label == var_0_23.research then
			for iter_6_2, iter_6_3 in ipairs(self._dock_data[var_0_6.pool_type.equipment_build]) do
				self:__set_ui_state(iter_6_3.available, iter_6_3.state, self._dock_develop_contents[iter_6_3.pos_id], iter_6_3.id)
			end
		elseif self._now_label == var_0_23.dispose then
			self:__update_reusable_cell_3()
		elseif #self._disassemble_data > 0 then
			local var_6_0 = {}

			for iter_6_4, iter_6_5 in pairs(self._disassemble_data) do
				if iter_6_5 ~= " " then
					var_0_9(var_6_0, iter_6_5.id)
				end
			end

			self:set_disassemble_data(var_6_0)
		else
			self:__update_reusable_cell_4()
		end
	end

	function arg_1_0:set_disassemble_data(arg_7_1)
		self._disassemble_data = {}

		for iter_7_0, iter_7_1 in pairs(arg_7_1) do
			var_0_9(self._disassemble_data, (var_0_3:find_character_by_id(iter_7_1)))
		end

		self:__update_reusable_cell_4()
	end

	function arg_1_0.init_equip_data(arg_8_0)
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs((var_0_3:get_equipment_list())) do
			if not iter_8_1.lock then
				var_0_9(var_8_0, iter_8_1)
			end
		end

		var_0_15(var_8_0, function(arg_9_0, arg_9_1)
			local var_9_0 = var_0_11.find_object_by_cid(arg_9_0.id)
			local var_9_1 = var_0_11.find_object_by_cid(arg_9_1.id)

			if var_9_0.star == var_9_1.star then
				if var_9_0.type == var_9_1.type then
					return var_9_0.cid > var_9_1.cid
				else
					return var_9_0.type < var_9_1.type
				end
			else
				return var_9_0.star < var_9_1.star
			end
		end)

		arg_8_0._equip_data = var_8_0
	end

	function arg_1_0:get_new_equip_list(arg_10_1)
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
			for iter_10_2, iter_10_3 in pairs(self._type_toggle_data) do
				local var_10_1 = false
				local var_10_2 = var_0_11.find_object_by_cid(iter_10_1.id)

				if iter_10_2 == "all" and iter_10_3 then
					var_10_1 = true
				elseif iter_10_2 == "missile_launcher" then
					if var_0_6.equip_type.anti_ship_missile_launcher == var_10_2.type or var_0_6.equip_type.air_defense_missile_launcher == var_10_2.type then
						var_10_1 = true
					end
				elseif iter_10_2 == "missile" then
					if var_0_6.equip_type.anti_ship_missile == var_10_2.type or var_0_6.equip_type.air_defense_missile == var_10_2.type then
						var_10_1 = true
					end
				elseif var_0_6.equip_type[iter_10_2] == var_10_2.type then
					var_10_1 = true
				end

				if var_10_1 then
					var_0_9(var_10_0, iter_10_1)
				end
			end
		end

		return var_10_0
	end

	function arg_1_0:get_equip_effect_list(arg_11_1)
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			local var_11_1 = false

			for iter_11_2, iter_11_3 in pairs(self._effect_toggle_data) do
				local var_11_2 = var_0_11.find_object_by_cid(iter_11_1.id)

				if iter_11_2 == "all" and iter_11_3 then
					var_11_1 = true
				elseif iter_11_2 == "attack" then
					if var_0_8.have_data(var_11_2.effect_type, 1) then
						var_11_1 = true
					end
				elseif iter_11_2 == "extra_damage" then
					if var_0_8.have_data(var_11_2.effect_type, 2) then
						var_11_1 = true
					end
				elseif iter_11_2 == "exp_up" then
					if var_0_8.have_data(var_11_2.effect_type, 3) then
						var_11_1 = true
					end
				elseif iter_11_2 == "armor_pene" then
					if var_0_8.have_data(var_11_2.effect_type, 4) then
						var_11_1 = true
					end
				elseif iter_11_2 == "expedition_resource" then
					if var_0_8.have_data(var_11_2.effect_type, 5) then
						var_11_1 = true
					end
				elseif iter_11_2 == "hit_rate" then
					if var_0_8.have_data(var_11_2.effect_type, 6) then
						var_11_1 = true
					end
				elseif iter_11_2 == "miss" then
					if var_0_8.have_data(var_11_2.effect_type, 7) then
						var_11_1 = true
					end
				elseif iter_11_2 == "critical_rate" then
					if var_0_8.have_data(var_11_2.effect_type, 8) then
						var_11_1 = true
					end
				elseif iter_11_2 == "anti_air" then
					if var_0_8.have_data(var_11_2.effect_type, 9) then
						var_11_1 = true
					end
				elseif iter_11_2 == "atk_top" and var_0_8.have_data(var_11_2.effect_type, 10) then
					var_11_1 = true
				end
			end

			if var_11_1 then
				var_0_9(var_11_0, iter_11_1)
			end
		end

		return var_11_0
	end

	function arg_1_0:select_one(arg_12_1, arg_12_2)
		self:__select_one(arg_12_1, arg_12_2)
	end

	function arg_1_0:get_guide_btn_pos_info(arg_13_1)
		if arg_13_1 == var_0_6.guide_const_id.six_group.three then
			return self._control.level_tips.supplement_btn.transform
		elseif arg_13_1 == var_0_6.guide_const_id.six_group.ten then
			return self._control.top_layer.close_btn.transform
		elseif arg_13_1 == var_0_6.guide_const_id.six_group.four or arg_13_1 == var_0_6.guide_const_id.six_group.seven then
			return self._record_btn
		elseif arg_13_1 == var_0_6.guide_const_id.six_group.nine then
			return self._record_completet_btn
		end
	end

	function arg_1_0:_now__play_bgm()
		local var_14_0 = var_0_22.find_object_by_id(6)
		local var_14_1 = var_14_0.content.endTime
		local var_14_2 = lx.ServerTime:getUtcTime()

		if (var_14_0.content.startTime <= var_14_2 and var_14_2 <= var_14_1) == true then
			self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.building_bgm_active))
		else
			self:_play_audio(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.building_bgm))
		end
	end

	function arg_1_0:__onVisible(arg_15_1, arg_15_2)
		if not arg_15_1 then
			return
		end

		self:__init_panel(arg_15_2)

		if arg_15_2 then
			var_0_6:play_in_out_animation(self._control.bg.uITweenSequence, true, function()
				var_0_2:destroyInstance("loading")
			end)
		end
	end

	function arg_1_0:__init_panel(arg_17_1)
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.into_build))

		self._dock_data = var_0_3:get_total_dock_data()

		self:init_equip_data()
		self:__init_fixed_value()
		self:__init_select(arg_17_1)

		self._need_revert = true

		local var_17_0 = var_0_2:getInstance("home")

		if var_17_0 then
			var_17_0:setVisible(false)
		end

		if not self._already_init then
			self:_now__play_bgm()
		end

		self._already_init = true
	end

	function arg_1_0:__init_fixed_value()
		if self._already_init then
			return
		end

		local var_18_0 = var_0_3:get_use_info_data()

		self._control.top_layer.toggle_control.constructure.dbtn1.text.text = var_0_21:getNowLang("dock_build")
		self._control.top_layer.toggle_control.disassemble.dbtn1.text.text = var_0_21:getNowLang("dock_destory")
		self._control.top_layer.toggle_control.research.dbtn1.text.text = var_0_21:getNowLang("dbtn3")
		self._control.top_layer.toggle_control.dispose.dbtn1.text.text = var_0_21:getNowLang("dbtn4")
		self._control.top_layer.finish_tag_1.finish_txt.text.text = var_0_21:getNowLang("questget")
		self._control.top_layer.finish_tag_2.finish_txt.text.text = var_0_21:getNowLang("questget")
		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.destroyship_getresource.text.text = var_0_21:getNowLang("destroyshipgetresource")
		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.checkbox_layer.save_equip.text.text = var_0_21:getNowLang("saveequipinship")
		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.clear_btn.clearlist.text.text = var_0_21:getNowLang("clearlist")
		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.disaasemble_btn.dbtn.text.text = var_0_21:getNowLang("dock_destory")

		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.checkbox_layer.toggle.onValueChanged:AddListener(function(arg_19_0)
			self._unload_equips = arg_19_0

			self:__disassembel_get_res()
		end)

		self._control.right_layer.container.constructure_layer.dispose.bottom.title.txt.text.text = var_0_21:getNowLang("ui_select_dismantle_num") .. " 0/40"
		self._control.right_layer.container.constructure_layer.dispose.bottom.confirm_btn.confirm.text.text = var_0_21:getNowLang("btnabandom")
		self._control.right_layer.container.constructure_layer.dispose.bottom.fast_confirm_btn.confirm.text.text = var_0_21:getNowLang("all_select")
		self._control.right_layer.container.constructure_layer.dispose.bottom.cancel_btn.cancel.text.text = var_0_21:getNowLang("cancel")
		self._control.right_layer.equip_amount_layer.equip_amount.text.text = var_0_5(var_0_21:getNowLang("ui_dockequipcount"), 0, var_18_0.max_equip)
		self._control.right_layer.equip_amount_layer.equip_filter_btn.ui_dockequipscreen.text.text = var_0_21:getNowLang("ui_dockequipscreen")

		self:__init_build_list()
		self:__init_develop_list()
		self:__init_equip_list()
		self:__init_ship_list()
	end

	function arg_1_0:__init_select(arg_20_1)
		if not arg_20_1 then
			self:update_data()

			return
		end

		if self._now_content then
			self._now_content.toggle.isOn = false
		end

		self:__select_one("constructure", true)

		self._now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_21_1, arg_21_2)
		if self._now_label == arg_21_1 and not arg_21_2 then
			return
		end

		self.safe_lock = true

		self._control.right_layer.container.constructure_layer.dispose:SetActive(false)
		self._control.right_layer.equip_amount_layer:SetActive(false)

		self._now_label = arg_21_1

		if self._now_content then
			self._last_content = self._now_content

			self:__set_title_style(self._now_content, false)
		end

		self:__set_current_content(arg_21_1)
		self:__set_title_style(self._now_content, true)

		self._now_content.toggle.isOn = self._now_content.toggle.isOn or true

		if self._last_content and self._last_content ~= self._control.top_layer.toggle_control.dispose then
			var_0_6:play_in_out_animation(self._last_content.uITweenSequence, false, function()
				if arg_21_1 ~= "dispose" then
					var_0_6:play_in_out_animation(self._now_content.uITweenSequence, true)
				else
					self._control.right_layer.container.constructure_layer.dispose:SetActive(true)
					self._control.right_layer.equip_amount_layer:SetActive(true)
				end

				self.safe_lock = false
			end)
		else
			var_0_6:play_in_out_animation(self._now_content.uITweenSequence, true)

			self.safe_lock = false
		end

		if self._control.top_layer.toggle_control.constructure.dbtn1:GetComponent("Text").fontSize == 30 then
			self._control.top_layer.toggle_control.disassemble.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.research.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.constructure.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.constructure.unselected.selected:SetActive(true)
		elseif self._control.top_layer.toggle_control.disassemble.dbtn1:GetComponent("Text").fontSize == 30 then
			self._control.top_layer.toggle_control.constructure.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.research.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.disassemble.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.disassemble.unselected.selected:SetActive(true)
		elseif self._control.top_layer.toggle_control.research.dbtn1:GetComponent("Text").fontSize == 30 then
			self._control.top_layer.toggle_control.constructure.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.disassemble.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.research.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.research.unselected.selected:SetActive(true)
		elseif self._control.top_layer.toggle_control.dispose.dbtn1:GetComponent("Text").fontSize == 30 then
			self._control.top_layer.toggle_control.constructure.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.disassemble.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.research.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(false)
			self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(true)
		end

		self:update_data()
	end

	function arg_1_0:safe_check()
		if self.safe_lock then
			if self._control.top_layer.toggle_control.constructure.dbtn1:GetComponent("Text").fontSize == 30 then
				self._control.top_layer.toggle_control.disassemble.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.research.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.constructure.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.constructure.unselected.selected:SetActive(true)
			elseif self._control.top_layer.toggle_control.disassemble.dbtn1:GetComponent("Text").fontSize == 30 then
				self._control.top_layer.toggle_control.constructure.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.research.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.disassemble.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.disassemble.unselected.selected:SetActive(true)
			elseif self._control.top_layer.toggle_control.research.dbtn1:GetComponent("Text").fontSize == 30 then
				self._control.top_layer.toggle_control.constructure.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.disassemble.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.research.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.research.unselected.selected:SetActive(true)
			elseif self._control.top_layer.toggle_control.dispose.dbtn1:GetComponent("Text").fontSize == 30 then
				self._control.top_layer.toggle_control.constructure.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.disassemble.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.research.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(false)
				self._control.top_layer.toggle_control.dispose.unselected.selected:SetActive(true)
			end

			return true
		end

		return false
	end

	function arg_1_0:__set_current_content(arg_24_1)
		if arg_24_1 == var_0_23.constructure then
			self._now_content = self._control.top_layer.toggle_control.constructure
		elseif arg_24_1 == var_0_23.disassemble then
			self._now_content = self._control.top_layer.toggle_control.disassemble
		elseif arg_24_1 == var_0_23.research then
			self._now_content = self._control.top_layer.toggle_control.research
		elseif arg_24_1 == var_0_23.dispose then
			self._now_content = self._control.top_layer.toggle_control.dispose
		end
	end

	function arg_1_0.__set_title_style(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_2 then
			arg_25_1.dbtn1.text.fontSize = 30
			arg_25_1.dbtn1.text.color = Color.New(1, 1, 1)
		else
			arg_25_1.dbtn1.text.fontSize = 26
			arg_25_1.dbtn1.text.color = Color.New(0.5490196078431373, 0.5490196078431373, 0.5490196078431373)
		end
	end

	function arg_1_0.__set_dock_build_ui(arg_26_0, arg_26_1)
		arg_26_1.build_layer.fastbuildbtn.text.text = var_0_21:getNowLang("fastbuildbtn")
		arg_26_1.empty_layer.ui_clickstartbuild.text.text = var_0_21:getNowLang("ui_clickstartbuild")
		arg_26_1.empty_layer.ui_startbuild.text.text = var_0_21:getNowLang("ui_startbuild")
		arg_26_1.locked_layer.ui_notopen.text.text = var_0_21:getNowLang("ui_notopen")
		arg_26_1.locked_layer.dock_open.btnopenbuildslot.text.text = var_0_21:getNowLang("btnopenbuildslot")
		arg_26_1.complete_layer.buildstatus2.text.text = var_0_21:getNowLang("buildstatus2")
		arg_26_1.complete_layer.ui_buildcomplete.text.text = var_0_21:getNowLang("ui_buildcomplete")
	end

	function arg_1_0.__set_dock_develop_ui(arg_27_0, arg_27_1)
		arg_27_1.build_layer.fastbuildbtn.text.text = var_0_21:getNowLang("fastbuildequipbtn")
		arg_27_1.empty_layer.ui_clickstartbuild.text.text = var_0_21:getNowLang("ui_clickstartdevelop")
		arg_27_1.empty_layer.ui_startbuild.text.text = var_0_21:getNowLang("ui_startdevelop")
		arg_27_1.locked_layer.ui_notopen.text.text = var_0_21:getNowLang("ui_notopen")
		arg_27_1.locked_layer.dock_open.btnopenbuildslot.text.text = var_0_21:getNowLang("btnopenbuildequipslot")
		arg_27_1.complete_layer.buildstatus2.text.text = var_0_21:getNowLang("buildequipstatus2")
		arg_27_1.complete_layer.ui_buildcomplete.text.text = var_0_21:getNowLang("ui_developcomplete")
	end

	function arg_1_0:__set_ui_state(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
		arg_28_3.build_layer.gameObject:SetActive(false)
		arg_28_3.locked_layer.gameObject:SetActive(false)
		arg_28_3.empty_layer.gameObject:SetActive(false)
		arg_28_3.complete_layer.gameObject:SetActive(false)

		if not arg_28_1 then
			arg_28_3.locked_layer.gameObject:SetActive(true)

			return
		end

		local var_28_0 = var_0_22.find_object_by_id(6)
		local var_28_1 = lx.ServerTime:getUtcTime()
		local var_28_2 = var_28_0.content.startTime <= var_28_1 and var_28_1 <= var_28_0.content.endTime

		if arg_28_2 == var_0_6.pool_state.free and var_28_2 == false then
			arg_28_3.empty_layer.gameObject:SetActive(true)

			if self._now_label == var_0_23.constructure then
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_1_d)
			elseif self._now_label == var_0_23.research then
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_2_d)
			end
		elseif arg_28_2 == var_0_6.pool_state.engaged and var_28_2 == false then
			if self._now_label == var_0_23.constructure then
				ship_data = var_0_12.find_object_by_cid(arg_28_4)

				arg_28_3.build_layer.ship_shadow:SetActive(true)

				arg_28_3.build_layer.ship_shadow.image.sprite = self:loadSprite(var_0_5(var_0_6.dock_boat_shadow, ship_data.ship_ton))
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_1)
			elseif self._now_label == var_0_23.research then
				arg_28_3.build_layer.ship_shadow:SetActive(false)

				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_2)
			end

			arg_28_3.build_layer.gameObject:SetActive(true)

			self._start_update = true
		elseif arg_28_2 == var_0_6.pool_state.free and var_28_2 == true then
			arg_28_3.empty_layer.gameObject:SetActive(true)

			if self._now_label == var_0_23.constructure then
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_11_d)
			elseif self._now_label == var_0_23.research then
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_21_d)
			end
		elseif arg_28_2 == var_0_6.pool_state.engaged and var_28_2 == true then
			if self._now_label == var_0_23.constructure then
				ship_data = var_0_12.find_object_by_cid(arg_28_4)

				arg_28_3.build_layer.ship_shadow:SetActive(true)

				arg_28_3.build_layer.ship_shadow.image.sprite = self:loadSprite(var_0_5(var_0_6.dock_boat_shadow, ship_data.ship_ton))
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_11)
			elseif self._now_label == var_0_23.research then
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_21)

				arg_28_3.build_layer.ship_shadow:SetActive(false)
			end

			arg_28_3.build_layer.gameObject:SetActive(true)

			self._start_update = true
		else
			arg_28_3.complete_layer.gameObject:SetActive(true)

			if self._now_label == var_0_23.constructure and var_28_2 == true then
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_11)
			elseif self._now_label == var_0_23.research and var_28_2 == true then
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_21)
			elseif self._now_label == var_0_23.constructure and var_28_2 == false then
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_1)
			elseif self._now_label == var_0_23.research and var_28_2 == false then
				arg_28_3.bg.image.sprite = self:loadSprite(var_0_6.dock_back_bg_img.build_bg_2)
			end
		end
	end

	function arg_1_0:__set_finish_tag()
		local var_29_0

		for iter_29_0, iter_29_1 in ipairs(self._dock_data[var_0_6.pool_type.ship_build]) do
			if iter_29_1.state == var_0_6.pool_state.finish then
				var_29_0 = true
			end
		end

		self._control.top_layer.finish_tag_1:SetActive(var_29_0)

		local var_29_1

		for iter_29_2, iter_29_3 in ipairs(self._dock_data[var_0_6.pool_type.equipment_build]) do
			if iter_29_3.state == var_0_6.pool_state.finish then
				var_29_1 = true
			end
		end

		self._control.top_layer.finish_tag_2:SetActive(var_29_1)
	end

	function arg_1_0:__set_spine(arg_30_1)
		local var_30_0 = self:autoKillDOTween(var_0_7.Sequence())

		var_30_0:Append(arg_30_1.build_spine.build_carry.transform:DOBlendableLocalMoveBy(var_0_17.New(-320, 0), 5):SetEase(DG.Tweening.Ease.Linear))
		var_30_0:Append(arg_30_1.build_spine.build_carry.transform:DOScale(var_0_17.New(-arg_30_1.build_spine.build_carry.transform.localScale.x, arg_30_1.build_spine.build_carry.transform.localScale.y, arg_30_1.build_spine.build_carry.transform.localScale.z), 0.01))
		var_30_0:Append(arg_30_1.build_spine.build_carry.transform:DOBlendableLocalMoveBy(var_0_17.New(320, 0), 5):SetEase(DG.Tweening.Ease.Linear))
		var_30_0:Append(arg_30_1.build_spine.build_carry.transform:DOScale(var_0_17.New(-arg_30_1.build_spine.build_carry.transform.localScale.x, arg_30_1.build_spine.build_carry.transform.localScale.y, arg_30_1.build_spine.build_carry.transform.localScale.z), 0.01))
		var_30_0:SetLoops(-1)
		var_30_0:Play()
	end

	function arg_1_0:__updata_user_res_2()
		local var_31_0 = var_0_3:get_use_info_data()

		if self._now_label == var_0_23.constructure then
			self._control.right_layer.user_res_2.item_1.icon.image.sprite = self:loadSprite(var_0_5(var_0_6.common_icon.common_source, 7))
			self._control.right_layer.user_res_2.item_1.num.text.text = var_0_8.get_simplify_num((var_0_3:get_item_count(var_0_6.ship_item_cid.ship_blueprint)))
			self._control.right_layer.user_res_2.item_2.num.text.text = var_0_8.get_simplify_num((var_0_3:get_item_count(var_0_6.ship_item_cid.fast_build)))
			self._control.right_layer.user_res_2.item_3.num.text.text = var_0_8.get_simplify_num(var_31_0.diamond)
		elseif self._now_label == var_0_23.research then
			self._control.right_layer.user_res_2.item_1.icon.image.sprite = self:loadSprite(var_0_5(var_0_6.common_icon.common_source, 8))
			self._control.right_layer.user_res_2.item_1.num.text.text = var_0_8.get_simplify_num((var_0_3:get_item_count(var_0_6.ship_item_cid.equip_blueprint)))
			self._control.right_layer.user_res_2.item_2.num.text.text = var_0_8.get_simplify_num((var_0_3:get_item_count(var_0_6.ship_item_cid.fast_build)))
			self._control.right_layer.user_res_2.item_3.num.text.text = var_0_8.get_simplify_num(var_31_0.diamond)
		end
	end

	function arg_1_0:__updata_user_res_1()
		local var_32_0 = var_0_3:get_use_info_data()

		self._control.left_layer.user_res_1.oil_num.text.text = var_0_8.get_simplify_num(var_32_0.oil)
		self._control.left_layer.user_res_1.iron_num.text.text = var_0_8.get_simplify_num(var_32_0.fe)
		self._control.left_layer.user_res_1.mineral_num.text.text = var_0_8.get_simplify_num(var_32_0.al)
		self._control.left_layer.user_res_1.bullet_num.text.text = var_0_8.get_simplify_num(var_32_0.bullet)
	end

	function arg_1_0.__found_in_team(arg_33_0, arg_33_1)
		for iter_33_0, iter_33_1 in ipairs((var_0_3:get_all_ship_in_team())) do
			if iter_33_1.id == arg_33_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__init_build_list()
		if self._already_init then
			return
		end

		local var_34_0 = var_0_3:get_guide_state()

		self._reusable_cell_1 = gamecore.reusable_cell:create(self, self._control.right_layer.container.constructure_layer.build.scroll.viewport.content.endlessScrollView, self._control.right_layer.container.constructure_layer.build.scroll.viewport.content, "single_dock_build", "dock")

		self._reusable_cell_1:init()

		local var_34_1 = self._dock_data[var_0_6.pool_type.ship_build]

		self._reusable_cell_1:set_data(self._dock_data[var_0_6.pool_type.ship_build])

		self._dock_build_contents = {}

		function self._reusable_cell_1:_set_func(arg_35_1)
			self:__set_dock_build_ui(self)
			var_0_9(self._dock_build_contents, self)
			self:__set_spine(self.build_layer)
			self.locked_layer.buy_btn.button.onClick:RemoveAllListeners()
			self.locked_layer.buy_btn.button.onClick:AddListener(function()
				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

				local var_36_0 = var_0_13.find_object_by_id(var_0_6.shop_item_id.build_expand)

				var_0_2:createInstance("shop_bounced"):show({
					id = var_36_0.id,
					price = var_36_0.price,
					title = var_0_21:getNowLang("buildexpand"),
					type = var_36_0.type
				})
			end)

			if var_34_0 and arg_35_1 == 0 then
				self._record_btn = self.empty_layer.instant_build.transform
				self._record_completet_btn = self.complete_layer.instant_build.transform
				self.empty_layer.gameObject.name = var_0_6.guide_const_name.dock_parent_guide_name
				self.empty_layer.build_btn.image.raycastTarget = false

				self:__init_guide_btn_event(self, arg_35_1)
			else
				self.empty_layer.instant_build.image.raycastTarget = false
				self.empty_layer.build_btn.image.raycastTarget = true

				self.empty_layer.build_btn.button.onClick:RemoveAllListeners()
				self.empty_layer.build_btn.button.onClick:AddListener(function()
					self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))
					self:setVisible(false)
					var_0_2:createInstance("dock_bet"):setVisible(true, {
						pos_id = arg_35_1 + 1,
						type = var_0_6.pool_type.ship_build
					})
				end)
			end

			self.build_layer.instant_build.button.onClick:RemoveAllListeners()
			self.build_layer.instant_build.button.onClick:AddListener(function()
				if var_34_1[arg_35_1 + 1].state == var_0_6.pool_state.engaged then
					if var_0_3:get_item_count(var_0_6.ship_item_cid.fast_build) == 0 then
						var_0_20:show(var_0_21:getNowLang("item141") .. var_0_21:getNowLang("notenough"))

						return
					end

					local var_38_0 = {
						title = var_0_21:getNowLang("confirmfastbuildcontent1", true),
						title_1 = var_0_21:getNowLang("itemamount"),
						title_2 = var_0_21:getNowLang("timereduce"),
						cur_count = var_0_3:get_item_count(var_0_6.ship_item_cid.fast_build),
						finish_time = var_34_1[arg_35_1 + 1].time
					}
					local var_38_1 = var_0_2:createInstance("msgbox_image")

					local function var_38_2()
						self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))
						var_0_3:req_QuickBuildShip({
							pos_id = arg_35_1 + 1
						})
					end

					local function var_38_3()
						self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.back))
					end

					if var_0_3:get_guide_state() then
						var_38_1:Show_Info(var_38_0, var_38_2, var_38_3, var_0_21:getNowLang("confirmfastbuildtitle1"), var_0_6.msg_type.reduce_cd)
					else
						var_38_1:Show_Info(var_38_0, var_38_2, var_38_3, var_0_21:getNowLang("confirmfastbuildtitle1"))
					end
				end
			end)
			self.complete_layer.instant_build.button.onClick:RemoveAllListeners()
			self.complete_layer.instant_build.button.onClick:AddListener(function()
				if self._is_req_GetBuildShipReward then
					return
				end

				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

				self._is_req_GetBuildShipReward = true

				if var_0_8.dict_lenght(var_0_3:get_character_list()) >= var_0_3:get_use_info_data().max_ship then
					var_0_2:createInstance("msgbox"):showthird(nil, function()
						var_0_2:destroyInstance("msgbox")

						local var_42_0 = var_0_2:getInstance("dock")

						if var_42_0 then
							var_42_0:__onToggle_top_layer_toggle_control_disassemble()
						else
							local var_42_1 = var_0_2:createInstance("dock")

							var_42_1:show(true, "disassemble")
							var_42_1:set_enter_type("home")
							var_42_1:_now__play_bgm()
							var_42_1:__select_one("disassemble", true)
						end
					end, function()
						var_0_2:destroyInstance("msgbox")

						local var_43_0 = var_0_2:getInstance("remake")
						local var_43_1 = var_0_2:getInstance("home")

						if var_43_1 then
							var_43_1:_bgm_play()
						end

						if var_0_2:getInstance("dock") then
							var_0_2:destroyInstance("dock")
						end

						if var_43_0 then
							var_43_0:setVisible(true)
						else
							local var_43_2 = var_0_2:createInstance("remake")

							var_43_2:set_enter_type("home")
							var_43_2:show(true)
						end
					end, function()
						var_0_2:destroyInstance("msgbox")

						local var_44_0 = var_0_2:getInstance("home")

						if var_44_0 then
							var_44_0:_bgm_play()
						end

						var_0_2:destroyInstance("dock")

						local var_44_1 = var_0_2:getInstance("mall_shop")

						if var_44_1 then
							var_44_1:setVisible(true)
							var_44_1:__onToggle_top_layer_top_btn_btnthree()
						else
							var_0_2:createInstance("mall_shop"):show(var_0_6.mall_layer_type.layer_func, var_0_6.mall_enter_type.enter_home)
						end
					end, "", var_0_6.msg_type.ship_full, nil, true)

					self._is_req_GetBuildShipReward = false
				end

				if self._is_req_GetBuildShipReward then
					var_0_3:req_GetBuildShipReward({
						pos_id = arg_35_1 + 1
					})
				end
			end)
		end

		self._reusable_cell_1:update()
	end

	function arg_1_0.on_GetBuildShipReward_resp(arg_45_0)
		arg_45_0._is_req_GetBuildShipReward = false
	end

	function arg_1_0.__init_guide_btn_event(arg_46_0, arg_46_1, arg_46_2)
		arg_46_1.empty_layer.instant_build.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

		arg_46_1.empty_layer.instant_build.image.raycastTarget = true

		arg_46_1.empty_layer.instant_build:GetComponent("Button").onClick:RemoveAllListeners()
		arg_46_1.empty_layer.instant_build:GetComponent("Button").onClick:AddListener(function()
			arg_46_0:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))
			arg_46_0:setVisible(false)
			var_0_2:createInstance("dock_bet"):setVisible(true, {
				pos_id = arg_46_2 + 1,
				type = var_0_6.pool_type.ship_build
			})
		end)
	end

	function arg_1_0:__init_develop_list()
		if self._already_init then
			return
		end

		self._reusable_cell_2 = gamecore.reusable_cell:create(self, self._control.right_layer.container.constructure_layer.develop.scroll.viewport.content.endlessScrollView, self._control.right_layer.container.constructure_layer.develop.scroll.viewport.content, "single_dock_develop", "dock")

		self._reusable_cell_2:init()

		local var_48_0 = self._dock_data[var_0_6.pool_type.equipment_build]

		self._reusable_cell_2:set_data(self._dock_data[var_0_6.pool_type.equipment_build])

		self._dock_develop_contents = {}

		function self._reusable_cell_2:_set_func(arg_49_1)
			self:__set_dock_develop_ui(self)
			self:__set_spine(self.build_layer)
			var_0_9(self._dock_develop_contents, self)
			self.locked_layer.buy_btn.button.onClick:RemoveAllListeners()
			self.locked_layer.buy_btn.button.onClick:AddListener(function()
				local var_50_0 = var_0_13.find_object_by_id(var_0_6.shop_item_id.build_equip_expand)

				var_0_2:createInstance("shop_bounced"):show({
					id = var_50_0.id,
					price = var_50_0.price,
					title = var_0_21:getNowLang("buildequipexpand"),
					type = var_50_0.type
				})
			end)
			self.empty_layer.build_btn.button.onClick:RemoveAllListeners()
			self.empty_layer.build_btn.button.onClick:AddListener(function()
				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))
				self:setVisible(false)
				var_0_2:createInstance("dock_bet"):setVisible(true, {
					pos_id = arg_49_1 + 1,
					type = var_0_6.pool_type.equipment_build
				})
			end)
			self.build_layer.instant_build.button.onClick:RemoveAllListeners()
			self.build_layer.instant_build.button.onClick:AddListener(function()
				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))

				if var_48_0[arg_49_1 + 1].state == var_0_6.pool_state.engaged then
					if var_0_3:get_item_count(var_0_6.ship_item_cid.fast_build) == 0 then
						var_0_20:show(var_0_21:getNowLang("item141") .. var_0_21:getNowLang("notenough"))

						return
					end

					var_0_2:createInstance("msgbox_image"):Show_Info({
						title = var_0_21:getNowLang("confirmfastbuildcontent2", true),
						title_1 = var_0_21:getNowLang("itemamount"),
						title_2 = var_0_21:getNowLang("timereduce"),
						cur_count = var_0_3:get_item_count(var_0_6.ship_item_cid.fast_build),
						finish_time = var_48_0[arg_49_1 + 1].time
					}, function()
						self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))
						var_0_3:req_QuickBuildEquipment({
							pos_id = arg_49_1 + 1
						})
					end, function()
						self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.back))
					end, var_0_21:getNowLang("confirmfastbuildtitle1"))
				end
			end)
			self.complete_layer.instant_build.button.onClick:RemoveAllListeners()
			self.complete_layer.instant_build.button.onClick:AddListener(function()
				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

				local var_55_0 = 0

				for iter_55_0, iter_55_1 in pairs(var_0_3:get_equipment_list()) do
					var_55_0 = var_55_0 + iter_55_1.num
				end

				if var_55_0 >= var_0_3:get_use_info_data().max_equip then
					var_0_2:createInstance("msgbox"):showforth(nil, function()
						var_0_2:destroyInstance("msgbox")

						local var_56_0 = var_0_2:getInstance("dock")

						if var_56_0 then
							var_56_0:__onToggle_top_layer_toggle_control_dispose()
						else
							local var_56_1 = var_0_2:createInstance("dock")

							var_56_1:show(true, "dispose")
							var_56_1:set_enter_type("home")
							var_56_1:__select_one("dispose")
						end
					end, nil, function()
						var_0_2:destroyInstance("msgbox")

						local var_57_0 = var_0_2:getInstance("home")

						if var_57_0 then
							var_57_0:_bgm_play()
						end

						var_0_2:destroyInstance("dock")

						local var_57_1 = var_0_2:getInstance("mall_shop")

						if var_57_1 then
							var_57_1:setVisible(true)
							var_57_1:__onToggle_top_layer_top_btn_btnthree()
						else
							var_0_2:createInstance("mall_shop"):show(var_0_6.mall_layer_type.layer_func, var_0_6.mall_enter_type.enter_home)
						end
					end, "", var_0_6.msg_type.equipment_full, nil, true)
				else
					var_0_3:req_GetBuildEquipmentReward({
						pos_id = arg_49_1 + 1
					})
				end
			end)
		end

		self._reusable_cell_2:update()
	end

	function arg_1_0:__init_equip_list()
		if self._already_init then
			return
		end

		self._reusable_cell_3 = gamecore.reusable_cell:create(self, self._control.right_layer.container.constructure_layer.dispose.bottom.scroll.viewport.content.endlessScrollView, self._control.right_layer.container.constructure_layer.dispose.bottom.scroll.viewport.content, "single_equip", "dock")

		self._reusable_cell_3:init()
		self:__update_reusable_cell_3()
	end

	function arg_1_0:__update_reusable_cell_3()
		local var_59_0 = var_0_2:createInstance("equip_type_layer")

		self._type_toggle_data = var_59_0._type_toggle_data
		self._effect_toggle_data = var_59_0._effect_toggle_data

		local var_59_1 = self:get_equip_effect_list((self:get_new_equip_list(self._equip_data)))
		local var_59_2 = 0

		for iter_59_0, iter_59_1 in pairs(var_0_3:get_equipment_list()) do
			var_59_2 = var_59_2 + iter_59_1.num
		end

		self._control.right_layer.equip_amount_layer.equip_amount.text.text = var_0_5(var_0_21:getNowLang("ui_dockequipcount"), var_59_2, var_0_3:get_use_info_data().max_equip)
		self._dispose_already_selected = 0

		if #self._dispose_data then
			self._dispose_already_selected = #self._dispose_data
		end

		local var_59_3 = self._control.right_layer.container.constructure_layer.dispose.bottom

		self._control.right_layer.container.constructure_layer.dispose.bottom.title.txt.text.text = var_0_21:getNowLang("ui_select_dismantle_num") .. var_0_21:get(var_0_5(" %d/80", self._dispose_already_selected))

		self._reusable_cell_3:set_data(var_59_1)

		if next(self._dispose_data) == nil then
			self._dispose_data = {}
		end

		function self._reusable_cell_3:_set_func(arg_60_1)
			self.dismantle_layer.gameObject:SetActive(false)

			local var_60_0 = var_0_11.find_object_by_cid(var_59_1[arg_60_1 + 1].id)
			local var_60_1 = var_59_1[arg_60_1 + 1].num

			self._data_index = 0

			for iter_60_0, iter_60_1 in pairs(self._dispose_data) do
				if iter_60_1.id == var_60_0.cid then
					self._data_index = iter_60_0
				end
			end

			if self._dispose_data[self._data_index] and self._dispose_data[self._data_index].num and self._dispose_data[self._data_index].num > 0 then
				self.dismantle_layer.gameObject:SetActive(true)

				self.dismantle_layer.num.text.text = self._dispose_data[self._data_index].num
			end

			self.info_layer.icon_layer.icon_bg.image.sprite = self:loadSprite(var_0_5(var_0_6.equip_back.equip_back_normal, var_60_0.star))
			self.info_layer.icon_layer.icon.image.sprite = self:loadSprite(var_0_5(var_0_6.equip_icon.large, var_60_0.pic_id))
			self.info_layer.icon_layer.count.text.text = var_59_1[arg_60_1 + 1].num

			self.info_layer.name_layer.equip_name.beyondBoxEllipsis:SetTextWithEllipsis(var_60_0.title)

			local var_60_2 = {
				self.info_layer.detail_layer.attrib_1,
				self.info_layer.detail_layer.attrib_2
			}
			local var_60_3 = var_0_6:get_equip_attribute(var_59_1[arg_60_1 + 1].id)

			for iter_60_2 = 1, #var_60_2 do
				if not var_60_3[iter_60_2] then
					var_60_2[iter_60_2]:SetActive(false)
				else
					var_60_2[iter_60_2].count.text.text = var_0_6.equip_attribute[var_60_3[iter_60_2].index] == "range" and var_60_3[iter_60_2].count or var_60_3[iter_60_2].count > 0 and "+" .. var_60_3[iter_60_2].count or var_60_3[iter_60_2].count
					var_60_2[iter_60_2].title.text.text = var_0_6:get_equip_attribute_name(var_0_6.equip_attribute[var_60_3[iter_60_2].index])

					var_60_2[iter_60_2]:SetActive(true)
				end
			end

			self.info_layer.add_btn.button.onClick:RemoveAllListeners()
			self.info_layer.add_btn.button.onClick:AddListener(function()
				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

				if self._dispose_already_selected >= var_0_6.max_select_type.eighty then
					var_0_20:show(var_0_5(var_0_21:getNowLang("ismax"), var_0_6.max_select_type.eighty))

					return
				end

				if self._dispose_data then
					var_0_9(self._dispose_data, {
						num = var_60_1,
						id = var_60_0.cid
					})
				end

				self.dismantle_layer.gameObject:SetActive(true)

				self.dismantle_layer.num.text.text = var_60_1
				self._dispose_already_selected = self._dispose_already_selected + 1
				var_59_3.title.txt.text.text = var_0_21:getNowLang("ui_select_dismantle_num") .. var_0_21:get(var_0_5(" %d/80", self._dispose_already_selected))
			end)
			self.info_layer.detail_btn.button.onClick:RemoveAllListeners()
			self.info_layer.detail_btn.button.onClick:AddListener(function()
				self:__show_equip_att(self.info_layer, var_60_0)
			end)
			self.dismantle_layer.minus_btn.pointerDownUpEvent.onPointerDown:RemoveAllListeners()
			self.dismantle_layer.minus_btn.pointerDownUpEvent.onPointerDown:AddListener(function()
				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

				for iter_63_0, iter_63_1 in pairs(self._dispose_data) do
					if iter_63_1.id == var_60_0.cid then
						self._data_index = iter_63_0
					end
				end

				if self._dispose_data[self._data_index].num > 1 then
					self.dismantle_layer.num.text.text = self._dispose_data[self._data_index].num - 1
					self._dispose_data[self._data_index].num = self._dispose_data[self._data_index].num - 1
				else
					self._dispose_data[self._data_index].num = 0
					self._dispose_already_selected = self._dispose_already_selected - 1
					var_59_3.title.txt.text.text = var_0_21:getNowLang("ui_select_dismantle_num") .. var_0_21:get(var_0_5(" %d/80", self._dispose_already_selected))

					self.dismantle_layer.gameObject:SetActive(false)
				end
			end)
			self.dismantle_layer.minus_btn.clickAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.dismantle_layer.minus_btn.clickAndLongClickEvent.onLongClick:AddListener(function()
				self.minus_seq = self:autoKillDOTween(var_0_7.Sequence())

				if self._dispose_data and self._dispose_data[self._data_index] then
					for iter_64_0 = 1, self._dispose_data[self._data_index].num do
						self.minus_seq:AppendCallback(function()
							if self._dispose_data[self._data_index].num > 1 then
								self._dispose_data[self._data_index].num = self._dispose_data[self._data_index].num - 1
								self.dismantle_layer.num.text.text = self._dispose_data[self._data_index].num
								self._dispose_data[self._data_index].num = self._dispose_data[self._data_index].num
							else
								self._dispose_data[self._data_index].num = 0
								self._dispose_already_selected = self._dispose_already_selected - 1
								var_59_3.title.txt.text.text = var_0_21:getNowLang("ui_select_dismantle_num") .. var_0_21:get(var_0_5(" %d/80", self._dispose_already_selected))

								self.dismantle_layer.gameObject:SetActive(false)
								self.minus_seq:Kill()
							end
						end)
						self.minus_seq:AppendInterval(0.1)
					end
				end

				self.minus_seq:Play()
			end)
			self.dismantle_layer.minus_btn.pointerDownUpEvent.onPointerUp:RemoveAllListeners()
			self.dismantle_layer.minus_btn.pointerDownUpEvent.onPointerUp:AddListener(function()
				if self.minus_seq then
					self.minus_seq:Kill()
				end
			end)
			self.dismantle_layer.bg.button.onClick:RemoveAllListeners()
			self.dismantle_layer.bg.button.onClick:AddListener(function()
				local var_67_0 = {}

				for iter_67_0, iter_67_1 in pairs(self._dispose_data) do
					if iter_67_1.id ~= var_60_0.cid then
						var_0_9(var_67_0, iter_67_1)
					end
				end

				self._dispose_data = var_67_0

				self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.back_click))

				self._dispose_already_selected = self._dispose_already_selected - 1
				var_59_3.title.txt.text.text = var_0_21:getNowLang("ui_select_dismantle_num") .. var_0_21:get(var_0_5(" %d/80", self._dispose_already_selected))

				self.dismantle_layer.gameObject:SetActive(false)
			end)
		end
	end

	function arg_1_0:fast_choose_equipment()
		self._dispose_data = var_0_8.incorporate_repetitive_equips(self._dispose_data)
		self._dispose_list = {}

		for iter_68_0, iter_68_1 in pairs(self._dispose_data) do
			var_0_9(self._dispose_list, iter_68_1.id)
		end

		for iter_68_2, iter_68_3 in pairs((self:get_equip_effect_list((self:get_new_equip_list(self._equip_data))))) do
			if not var_0_8.have_data(self._dispose_list, iter_68_3.id) then
				if self._dispose_already_selected < var_0_6.max_select_type.eighty then
					self._dispose_already_selected = self._dispose_already_selected + 1

					var_0_9(self._dispose_data, {
						num = iter_68_3.num,
						id = iter_68_3.id
					})
					var_0_9(self._dispose_list, iter_68_3.id)
				end
			else
				for iter_68_4, iter_68_5 in pairs(self._dispose_data) do
					if iter_68_5.id == iter_68_3.id then
						iter_68_5.num = iter_68_3.num
					end
				end
			end
		end
	end

	function arg_1_0:__init_ship_list()
		if self._already_init then
			return
		end

		self._reusable_cell_4 = gamecore.reusable_cell:create(self, self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.scroll.viewport.content.endlessScrollView, self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.scroll.viewport.content, "single_dismantle_ship", "dock")

		self._reusable_cell_4:init()
	end

	function arg_1_0:__has_studying_ship()
		self._has_studying = false

		for iter_70_0 = 1, #self._disassemble_data do
			if self._disassemble_data[iter_70_0].all_tactics ~= nil and #self._disassemble_data[iter_70_0].all_tactics > 0 then
				for iter_70_1, iter_70_2 in ipairs(self._disassemble_data[iter_70_0].all_tactics) do
					if iter_70_2.state == var_0_6.stactic_state.study then
						self._has_studying = true

						return
					end
				end
			end
		end
	end

	function arg_1_0:__update_reusable_cell_4()
		self:__has_studying_ship()

		local var_71_0 = self._disassemble_data

		if self._disassemble_data[1] ~= " " then
			var_0_9(self._disassemble_data, 1, " ")
		end

		self:__disassembel_get_res()
		self._reusable_cell_4:set_data(self._disassemble_data)

		function self._reusable_cell_4:_set_func(arg_72_1)
			local var_72_0 = arg_72_1 == 0

			self.add_layer:SetActive(arg_72_1 == 0)
			self.main_layer:SetActive(not var_72_0)

			if arg_72_1 ~= 0 then
				self:_show_disassemble_ships(self, var_71_0[arg_72_1 + 1])
			end

			self.add_layer.add_btn.button.onClick:RemoveAllListeners()
			self.add_layer.add_btn.button.onClick:AddListener(function()
				if arg_72_1 == 0 then
					if var_71_0[1] == " " then
						var_0_10(var_71_0, 1)
					end

					var_0_2:createInstance("select_member"):show_by_type(var_0_6.enter_select_member_type.dock_disassemble, var_71_0)
				end
			end)
			self.main_layer.ship_btn.clickAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.main_layer.ship_btn.clickAndLongClickEvent.onLongClick:AddListener(function()
				self:setVisible(false)
				var_0_2:createInstance("ship_detail"):show(var_0_6.enter_ship_detail_type.dock, var_71_0[arg_72_1 + 1])
			end)

			self.main_layer.cancel_btn.txt.text.text = var_0_21:getNowLang("cancel")

			self.main_layer.cancel_btn.button.onClick:RemoveAllListeners()
			self.main_layer.cancel_btn.button.onClick:AddListener(function()
				var_0_10(var_71_0, arg_72_1 + 1)
				self:__update_reusable_cell_4()
			end)
		end
	end

	function arg_1_0:clear_disassemble_data()
		self._disassemble_data = {}

		self:__update_reusable_cell_4()
	end

	function arg_1_0:__disassembel_get_res()
		local var_77_0 = {
			0,
			0,
			0,
			0
		}

		for iter_77_0 = 2, #self._disassemble_data do
			local var_77_1 = var_0_12.find_object_by_cid(self._disassemble_data[iter_77_0].cid)

			if var_77_1 then
				if not self._unload_equips and self._disassemble_data[iter_77_0].equips then
					for iter_77_1, iter_77_2 in pairs(self._disassemble_data[iter_77_0].equips) do
						if iter_77_2.id > 0 and var_0_3:find_lock_equipment_by_id(iter_77_2.id) == false then
							local var_77_2 = var_0_11.find_object_by_cid(iter_77_2.id)

							var_77_0[1] = var_77_2.dismantle[1].value + var_77_0[1]
							var_77_0[2] = var_77_2.dismantle[2].value + var_77_0[2]
							var_77_0[3] = var_77_2.dismantle[3].value + var_77_0[3]
							var_77_0[4] = var_77_2.dismantle[4].value + var_77_0[4]
						end
					end

					var_77_0[1] = var_77_1.dismantle[1].value + var_77_0[1]
					var_77_0[2] = var_77_1.dismantle[2].value + var_77_0[2]
					var_77_0[3] = var_77_1.dismantle[3].value + var_77_0[3]
					var_77_0[4] = var_77_1.dismantle[4].value + var_77_0[4]
				else
					var_77_0[1] = var_77_1.dismantle[1].value + var_77_0[1]
					var_77_0[2] = var_77_1.dismantle[2].value + var_77_0[2]
					var_77_0[3] = var_77_1.dismantle[3].value + var_77_0[3]
					var_77_0[4] = var_77_1.dismantle[4].value + var_77_0[4]
				end
			end
		end

		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.aluminium.txt.text.text = "+" .. var_77_0[1]
		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.steel.txt.text.text = "+" .. var_77_0[2]
		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.bullet.txt.text.text = "+" .. var_77_0[3]
		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.oil.txt.text.text = "+" .. var_77_0[4]
	end

	function arg_1_0:_show_disassemble_ships(arg_78_1, arg_78_2)
		if not arg_78_2 then
			return
		else
			local var_78_0 = var_0_12.find_object_by_cid(arg_78_2.cid)
			local var_78_1
			local var_78_2 = var_0_8:use_big_break_painting(arg_78_2, var_0_6.ship_icon_type.model_xm, true)

			var_78_1 = arg_78_2.skin ~= 0 and var_0_6:get_ship_icon(var_78_2, var_0_14.find_object_by_cid(arg_78_2.skin).icon) or var_0_6:get_ship_icon(var_78_2, tostring(var_78_0.pic_id))
			arg_78_1.main_layer.heart.image.sprite = self:loadSprite(var_0_6:get_love_path(arg_78_2))
			arg_78_1.main_layer.icon_layer.icon.image.sprite = self:loadSprite(var_78_1)
			arg_78_1.main_layer.quality.image.sprite = self:loadSprite(var_0_6.ship_quality_frame_s[arg_78_2.star])

			arg_78_1.main_layer.name_layer.name_bg:GetComponent("TextHorizonScroller"):SetText(arg_78_2.name)

			local var_78_3 = var_0_6.ship_hp_slider.ship_hp_l_green

			if arg_78_2.now_hp / var_78_0.hp_max >= 0.25 and arg_78_2.now_hp / var_78_0.hp_max < 0.5 then
				var_78_3 = var_0_6.ship_hp_slider.ship_hp_l_yellow
			elseif arg_78_2.now_hp / var_78_0.hp_max < 0.25 then
				var_78_3 = var_0_6.ship_hp_slider.ship_hp_l_red
			end

			arg_78_1.main_layer.hp_layer.blood_bar.image.sprite = self:loadSprite(var_78_3)
			arg_78_1.main_layer.hp_layer.blood_bar.image.fillAmount = arg_78_2.now_hp / var_78_0.hp_max
			arg_78_1.main_layer.level_layer.ship_type.text.text = var_0_21:getNowLang(var_0_6:get_ship_type_language_key(var_78_0.type, 1))
			arg_78_1.main_layer.level_layer.country_txt.text.text = var_0_5("(%s)", var_0_21:getNowLang(var_0_6:get_country_language_key(var_78_0.country)))
			arg_78_1.main_layer.level_layer.level.text.text = var_0_5("LV %d", arg_78_2.level)
			arg_78_1.main_layer.level_layer.level.text.color = Color.New(1, 1, 1)

			arg_78_1.main_layer.level_layer.ship_remake:SetActive(var_78_0.evo_class)

			for iter_78_0 = 1, arg_78_1.main_layer.star_layer.transform.childCount do
				if iter_78_0 <= arg_78_2.star then
					arg_78_1.main_layer.star_layer.transform:GetChild(iter_78_0 - 1).gameObject:SetActive(true)
				else
					arg_78_1.main_layer.star_layer.transform:GetChild(iter_78_0 - 1).gameObject:SetActive(false)
				end
			end
		end
	end

	function arg_1_0:__show_equip_att(arg_79_1, arg_79_2)
		self._equip_attr = var_0_2:getInstance("equip_attr") or var_0_2:createInstance("equip_attr")

		self:__show_equip_attr_panel(true)
		self._equip_attr._panel.transform:SetParent(arg_79_1.rectTransform, false)

		self._equip_attr._panel.transform.anchoredPosition = Vector2.New(51, -230)

		self._equip_attr._panel.transform:SetParent(self._control.right_layer.rectTransform)

		local var_79_0 = self._equip_attr._panel.transform.anchoredPosition
		local var_79_1

		if self._equip_attr._panel.transform.anchoredPosition.x < 514 then
			var_79_1 = var_79_0.x or 514

			local var_79_2

			if var_79_0.y > -253 then
				var_79_2 = var_79_0.y or -253
			end
		end

		self._equip_attr._panel.transform.anchoredPosition = Vector2.New(var_79_1, var_79_2)

		self._equip_attr._panel.transform:SetParent(arg_79_1.rectTransform)
		self._equip_attr:show(arg_79_2)
	end

	function arg_1_0:__show_equip_attr_panel(arg_80_1)
		if not self._equip_attr then
			return
		end

		self._control.tip_layer:SetActive(arg_80_1)
		self._equip_attr:setVisible(arg_80_1)
	end

	function arg_1_0.__destroy_panel(arg_81_0)
		if var_0_2:getInstance("equip_attr") then
			var_0_2:destroyInstance("equip_attr")
		end

		if var_0_2:getInstance("dock_bet") then
			var_0_2:destroyInstance("dock_bet")
		end

		if var_0_2:getInstance("dock_log") then
			var_0_2:destroyInstance("dock_log")
		end

		if var_0_2:getInstance("dock_batch_pop") then
			var_0_2:destroyInstance("dock_batch_pop")
		end

		if var_0_2:getInstance("select_member") then
			var_0_2:destroyInstance("select_member")
		end

		if var_0_2:getInstance("dock") then
			var_0_2:destroyInstance("dock")
		end
	end

	function arg_1_0:update_user_res_data(arg_82_1)
		local var_82_0 = var_0_3:get_use_info_data()

		local function var_82_1(arg_83_0, arg_83_1, arg_83_2)
			if arg_82_1 and tonumber(arg_83_2) then
				if arg_83_1 < arg_83_2 then
					arg_83_0.fontJump:IncreaseAnim(arg_83_1, arg_83_2)
				end
			else
				arg_83_0.text.text = arg_83_2
			end
		end

		var_82_1(self._control.left_layer.user_res_1.oil_num, self._orgin_oil, (var_0_8.get_simplify_num(var_82_0.oil)))
		var_82_1(self._control.left_layer.user_res_1.bullet_num, self._orgin_bullet, (var_0_8.get_simplify_num(var_82_0.bullet)))
		var_82_1(self._control.left_layer.user_res_1.iron_num, self._orgin_fe, (var_0_8.get_simplify_num(var_82_0.fe)))
		var_82_1(self._control.left_layer.user_res_1.mineral_num, self._orgin_al, (var_0_8.get_simplify_num(var_82_0.al)))
		self:__record_orgin_user_data()
	end

	function arg_1_0.__record_orgin_user_data(arg_84_0)
		local var_84_0 = var_0_3:get_use_info_data()

		arg_84_0._orgin_oil = var_0_8.get_simplify_num(var_84_0.oil)
		arg_84_0._orgin_bullet = var_0_8.get_simplify_num(var_84_0.bullet)
		arg_84_0._orgin_fe = var_0_8.get_simplify_num(var_84_0.fe)
		arg_84_0._orgin_al = var_0_8.get_simplify_num(var_84_0.al)
	end

	function arg_1_0:_play_audio(arg_85_1)
		self:playBackgroundMusic(arg_85_1)
	end

	function arg_1_0:_play_into_se(arg_86_1)
		self:playSE(arg_86_1, false)
	end

	function arg_1_0._stop_all(arg_87_0)
		var_0_18:init()
	end

	function arg_1_0._pause_all(arg_88_0)
		var_0_18:pauseAll()
	end

	function arg_1_0:buy_dock_resp()
		var_0_20:show(var_0_21:getNowLang("shopbuysuccess"))
		self:update_data()
	end

	function arg_1_0:__onReset()
		self._equip_attr = nil

		self:clear_disassemble_data()

		self._already_init = false
		self._dispose_data = {}

		self:__update_reusable_cell_3()

		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.checkbox_layer.toggle.isOn = false
		self._control.right_layer.container.constructure_layer.dispose.bottom.scroll.viewport.content.rectTransform.anchoredPosition = Vector2(0, 0)
		self._control.right_layer.container.constructure_layer.disassemble.disassemble_layer.scroll.viewport.content.rectTransform.anchoredPosition = Vector2(0, 0)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_91_0)
	local var_91_0 = var_0_2:class("dock")

	var_91_0._already_init = false
	var_91_0._start_update = false
	var_91_0._unload_equips = false
	var_91_0._last_content = nil
	var_91_0._now_label = nil
	var_91_0._now_content = nil
	var_91_0._reusable_cell_1 = nil
	var_91_0._reusable_cell_2 = nil
	var_91_0._reusable_cell_3 = nil
	var_91_0._reusable_cell_4 = nil
	var_91_0._dock_build_contents = {}
	var_91_0._dock_develop_contents = {}
	var_91_0._dock_data = {}
	var_91_0._equip_data = {}
	var_91_0._type_toggle_data = {
		all = true
	}
	var_91_0._effect_toggle_data = {
		all = true
	}
	var_91_0._need_revert = false
	var_91_0._dispose_data = {}
	var_91_0._dispose_already_selected = 0
	var_91_0._disassemble_data = {}
	var_91_0._data_index = {}
	var_91_0._equip_attr = nil
	var_91_0._enter_type = nil
	var_91_0._is_play_music = false
	var_91_0.safe_lock = false

	return var_91_0
end

return var_0_0
