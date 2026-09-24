local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = table.insert
local var_0_4 = DG.Tweening.DOTween
local var_0_5 = gamecore.UILoader
local var_0_6 = string.format
local var_0_7 = gamecore.Language
local var_0_8 = UnityEngine.Vector2
local var_0_9 = UnityEngine.Vector3
local var_0_10 = gamecore.util_func
local var_0_11 = lx.json_decode
local var_0_12 = gameenum.common_type
local var_0_15 = gamecore.UserDataManager
local var_0_16 = gameconfig.ship_rule_config
local var_0_17 = gameconfig.support_atk_config
local var_0_18 = gameconfig.pve_ninth_task_config
local var_0_19 = gameconfig.pve_ninth_award_config
local var_0_20 = gameconfig.ship_pve_buff_config
local var_0_21 = gameconfig.pve_ninth_level_config
local var_0_22 = gameconfig.ship_pve_active_config
local var_0_23 = gameconfig.pve_ninth_level_node_config
local var_0_24 = gameconfig.pve_ninth_task_server_config

gamecore.UILoader:define("ninth_main_map", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)

		if arg_3_1 then
			self._active_id = arg_3_1
		else
			local var_3_1 = var_0_16.find_object_by_id(var_0_12.pve_init_active_id.ninth_event).content

			if var_3_1 and next(var_3_1) then
				self._active_id = var_3_1.activeId
			end
		end

		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self._control.mask_image_bg:SetActive(false)
		self:__init_language()
		self:__init_map_list()
		self:__init_map_info()
		self:_show_reward_red_point()
		self:show_ninth_task_and_server_task()
		self:__destroy_pool()
		var_0_1:set_to_ninth(true)
	end

	function arg_1_0:__init_language()
		self._active_config = var_0_22.find_object_by_id(self._active_id)
		self._control.title_text.text.text = self._active_config.title
		self._control.push_guide.tip_layer.bg_container.title.text.text = var_0_7:getNowLang("activityinstruction")
		self._control.push_guide.guidecontent.guidetext.text.text = self._active_config.desc

		self:_play_audio(var_0_12:get_audio_url(var_0_12.common_icon.music_path, self._active_config.bgm))
	end

	function arg_1_0:__init_map_list()
		self.__line_list = {
			self._control.line_1,
			self._control.line_2,
			self._control.line_3,
			self._control.line_4
		}
		self.__point_list = {
			self._control.point_root.point_node_1,
			self._control.point_root.point_node_2,
			self._control.point_root.point_node_3,
			self._control.point_root.point_node_4
		}
		self.__node_img_list = {
			self._control.bg.node_img.node_img_1,
			self._control.bg.node_img.node_img_2,
			self._control.bg.node_img.node_img_3,
			self._control.bg.node_img.node_img_4,
			self._control.bg.node_img.node_img_5
		}
		self.__map_list = {
			self._control.bg.btn_root.ninth_map_point_item_1,
			self._control.bg.btn_root.ninth_map_point_item_2,
			self._control.bg.btn_root.ninth_map_point_item_3,
			self._control.bg.btn_root.ninth_map_point_item_4,
			self._control.bg.btn_root.ninth_map_point_item_5
		}
		self._boss_map_list = {
			self._control.map_preview.map_boss_bg.map_panel.map_node_root,
			self._control.map_preview.map_boss_bg.map_panel.map_node_root_2,
			self._control.map_preview.map_boss_bg.map_panel.map_node_root_3,
			self._control.map_preview.map_boss_bg.map_panel.map_node_root_4
		}
		self._boss_select_map_list = {
			self._control.boss_select_1,
			self._control.boss_select_2,
			self._control.boss_select_3,
			self._control.boss_select_4
		}
		self._task_award_list = {
			self._control.msg_panel.finish_special_mission.task_award_1,
			self._control.msg_panel.finish_special_mission.task_award_2,
			self._control.msg_panel.finish_special_mission.task_award_3,
			self._control.msg_panel.finish_special_mission.task_award_4
		}
	end

	function arg_1_0:init_show_guide_panel()
		if not var_0_1:get_ninth_guide_state() then
			self._control.push_guide:SetActive(true)

			local var_7_0 = var_0_1:get_account_id()

			var_0_15:setDataByID("is_ninth_task_", var_7_0, "")
			var_0_15:setDataByID("is_server_task_ninth_", var_7_0, "")
			var_0_1:req_NinthGuideReq()
		end
	end

	function arg_1_0:_is_open_boss_panel()
		return (self:_is_open_boss())
	end

	function arg_1_0:__init_map_info()
		local var_9_0 = {}
		local var_9_1 = {}

		self._control.map_preview:SetActive(false)

		local var_9_2, var_9_3 = var_0_21.get_sequence()

		for iter_9_0, iter_9_1 in pairs(var_9_2) do
			for iter_9_2, iter_9_3 in pairs(self._active_config.levels) do
				if iter_9_1.id == iter_9_3 and not self:_have_data(var_9_0, iter_9_1.id) then
					var_0_3(var_9_0, iter_9_1)
				end
			end
		end

		for iter_9_4, iter_9_5 in pairs(var_9_2) do
			for iter_9_6, iter_9_7 in pairs(self._active_config.hardLevels) do
				if iter_9_5.id == iter_9_7 and not self:_have_data(var_9_1, iter_9_5.id) then
					var_0_3(var_9_1, iter_9_5)
				end
			end
		end

		for iter_9_8 = 1, 5 do
			if iter_9_8 <= 4 then
				self.__line_list[iter_9_8].rectTransform.anchoredPosition = var_0_8(var_9_0[iter_9_8].line_position.x, -var_9_0[iter_9_8].line_position.y)
				self.__point_list[iter_9_8].rectTransform.anchoredPosition = var_0_8(var_9_0[iter_9_8].lock_position.x, -var_9_0[iter_9_8].lock_position.y)
			end

			self.__map_list[iter_9_8].rectTransform.anchoredPosition = var_0_8(var_9_0[iter_9_8].boss_position.x, -var_9_0[iter_9_8].boss_position.y)
			self.__node_img_list[iter_9_8].rectTransform.anchoredPosition = var_0_8(var_9_0[iter_9_8].node_position.x, -var_9_0[iter_9_8].node_position.y)
		end

		local var_9_4 = var_0_1:ninth_map_is_pass(self._active_config.levels[5])
		local var_9_5 = var_0_1:ninth_map_is_pass(self._active_config.hardLevels[5])

		for iter_9_9 = 1, 4 do
			local var_9_6 = var_0_1:ninth_map_is_pass(self._active_config.hardLevels[iter_9_9])

			if var_0_1:ninth_map_is_pass(self._active_config.levels[iter_9_9]) then
				self.__map_list[iter_9_9].bg_img.title_lab.text.text = var_9_1[iter_9_9].title

				self.__point_list[iter_9_9]:SetActive(true)

				if var_9_4 and not var_9_6 then
					self.__line_list[iter_9_9]:SetActive(false)

					self.__point_list[iter_9_9].image.sprite = self:loadSprite(var_0_6(var_0_12.ninth_main_img.lock_node, iter_9_9))
					self.__node_img_list[iter_9_9].image.sprite = self:loadSprite(var_0_6(var_0_12.ninth_main_img.lock_point, iter_9_9))
				else
					self.__line_list[iter_9_9]:SetActive(true)

					self.__point_list[iter_9_9].image.sprite = self:loadSprite(var_0_6(var_0_12.ninth_main_img.open_node, iter_9_9))
					self.__node_img_list[iter_9_9].image.sprite = self:loadSprite(var_0_6(var_0_12.ninth_main_img.open_point, iter_9_9))
				end

				self.__map_list[iter_9_9].mask_img.image.sprite = var_9_6 and self:loadSprite(var_0_6(var_0_12.fearlessness_sea_big_boss_b, var_9_1[iter_9_9].boss_id)) or self:loadSprite(var_0_6(var_0_12.fearlessness_sea_big_boss, var_9_1[iter_9_9].boss_id))
			else
				self.__line_list[iter_9_9]:SetActive(false)
				self.__point_list[iter_9_9]:SetActive(false)

				self.__map_list[iter_9_9].bg_img.title_lab.text.text = var_9_0[iter_9_9].title
				self.__map_list[iter_9_9].mask_img.image.sprite = self:loadSprite(var_0_6(var_0_12.fearlessness_sea_big_boss, var_9_0[iter_9_9].boss_id))
				self.__node_img_list[iter_9_9].image.sprite = self:loadSprite(var_0_6(var_0_12.ninth_main_img.lock_point, iter_9_9))
				self.__point_list[iter_9_9].image.sprite = self:loadSprite(var_0_6(var_0_12.ninth_main_img.lock_node, iter_9_9))
			end
		end

		local var_9_7 = {}

		for iter_9_10 = 1, 4 do
			if var_0_1:ninth_map_is_pass(self._active_config.levels[iter_9_10]) then
				var_0_3(var_9_7, iter_9_10)
			end
		end

		if var_9_7 and next(var_9_7) then
			for iter_9_11 = 1, 4 do
				self.__point_list[iter_9_11]:SetActive(true)
			end
		end

		local var_9_8 = var_0_1:ninth_map_is_pass(self._active_config.levels[5])
		local var_9_9 = var_0_1:ninth_map_is_pass(self._active_config.hardLevels[5])

		self.__map_list[5].mask_img.image.sprite = var_9_8 and var_9_9 and self:loadSprite(var_0_6(var_0_12.fearlessness_sea_big_boss_b, var_9_1[5].boss_id)) or var_9_8 and not var_9_9 and self:loadSprite(var_0_6(var_0_12.fearlessness_sea_big_boss, var_9_1[5].boss_id)) or self:loadSprite(var_0_6(var_0_12.fearlessness_sea_big_boss, var_9_1[5].boss_id))
		self._ninth_normal_map_data = {}
		self._ninth_hard_map_data = {}
		self._normal_node_data = {}
		self._hard_node_data = {}

		local var_9_10 = var_0_23.get_sequence()

		for iter_9_12, iter_9_13 in pairs(self._active_config.levels) do
			var_0_3(self._ninth_normal_map_data, var_0_21.find_object_by_id(iter_9_13))

			for iter_9_14 = 1, #var_9_10 do
				if var_9_10[iter_9_14].pve_level_id == iter_9_13 then
					if self._normal_node_data[iter_9_13] == nil then
						self._normal_node_data[iter_9_13] = {}
					end

					var_0_3(self._normal_node_data[iter_9_13], var_9_10[iter_9_14])
				end
			end
		end

		for iter_9_15, iter_9_16 in pairs(self._active_config.hardLevels) do
			var_0_3(self._ninth_hard_map_data, var_0_21.find_object_by_id(iter_9_16))

			for iter_9_17 = 1, #var_9_10 do
				if var_9_10[iter_9_17].pve_level_id == iter_9_16 then
					if self._hard_node_data[iter_9_16] == nil then
						self._hard_node_data[iter_9_16] = {}
					end

					var_0_3(self._hard_node_data[iter_9_16], var_9_10[iter_9_17])
				end
			end
		end

		local var_9_11 = var_0_1:ninth_map_is_pass(self._active_config.levels[5])

		self:_init_active_panel()
	end

	function arg_1_0:_init_active_panel()
		if var_0_1:ninth_map_is_pass(self._active_config.levels[1]) or var_0_1:ninth_map_is_pass(self._active_config.levels[2]) or var_0_1:ninth_map_is_pass(self._active_config.levels[3]) or var_0_1:ninth_map_is_pass(self._active_config.levels[4]) then
			self.__map_list[5]:SetActive(true)
			self.__node_img_list[5]:SetActive(true)
		else
			self.__map_list[5]:SetActive(false)
			self.__node_img_list[5]:SetActive(false)
		end
	end

	function arg_1_0.get_map_node(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = {}

		if var_0_1:get_is_ninth_boss() then
			local var_11_1, var_11_2 = var_0_23.get_sequence()

			if var_11_1 then
				for iter_11_0, iter_11_1 in pairs(var_11_1) do
					if iter_11_1.start_node_id == arg_11_3[arg_11_2] then
						var_11_0[#var_11_0 + 1] = iter_11_1
					end
				end
			end
		else
			local var_11_3, var_11_4 = var_0_23.get_sequence()

			if var_11_3 then
				for iter_11_2, iter_11_3 in pairs(var_11_3) do
					if iter_11_3.start_node_id == arg_11_3 then
						var_11_0[#var_11_0 + 1] = iter_11_3
					end
				end
			end
		end

		return var_11_0
	end

	function arg_1_0._have_data(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = false

		if arg_12_1 and next(arg_12_1) then
			for iter_12_0, iter_12_1 in pairs(arg_12_1) do
				if iter_12_1.id == arg_12_2 then
					var_12_0 = true
				end
			end
		end

		return var_12_0
	end

	function arg_1_0._have_data_2(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = false

		if arg_13_1 and next(arg_13_1) then
			for iter_13_0, iter_13_1 in pairs(arg_13_1) do
				if iter_13_1 == arg_13_2 then
					var_13_0 = true
				end
			end
		end

		return var_13_0
	end

	function arg_1_0:_show_panel_buff_info(arg_14_1)
		local var_14_0
		local var_14_1 = var_0_1:get_is_ninth_boss()

		if var_14_1 then
			self._control.map_preview.map_boss_bg.lock_bg:SetActive(false)
			self._control.map_preview.map_boss_bg.map_panel.buff_all_count:SetActive(false)
		else
			self._control.map_preview.map_bg.lock_bg:SetActive(false)
			self._control.map_preview.map_bg.map_panel.buff_all_count:SetActive(false)
		end

		if arg_14_1 then
			var_14_0 = var_0_21.find_object_by_id(arg_14_1)
		end

		if var_14_0.level_buff and var_14_0.level_buff > 0 then
			local var_14_2 = var_0_20.find_object_by_id(var_14_0.level_buff)

			if var_14_2 and next(var_14_2) then
				if var_14_1 then
					self._control.map_preview.map_boss_bg.lock_bg:SetActive(true)
				else
					self._control.map_preview.map_bg.lock_bg:SetActive(true)
				end

				self._map_debuff = var_14_2
			end

			local var_14_3 = {}

			for iter_14_0, iter_14_1 in pairs(var_14_0.level_buff) do
				local var_14_5 = var_0_1:score_map_is_pass(iter_14_1)

				if var_14_5 then
					-- block empty
				end

				var_0_3(var_14_3, var_14_5)
			end

			self._is_pass_debuff = self:_have_data(var_14_3, 0)
		end
	end

	function arg_1_0._show_boss_panel(arg_15_0)
		return
	end

	function arg_1_0:_show_map_panel(arg_16_1, arg_16_2, arg_16_3)
		if not arg_16_1 then
			return
		end

		self._is_hard = false

		local var_16_0 = var_0_21.find_object_by_id(arg_16_1)
		local var_16_1 = self:get_map_node(arg_16_1, arg_16_2, arg_16_3)

		if not var_16_1 and not next(var_16_1) then
			return
		end

		local var_16_3 = var_0_1:get_is_ninth_boss()

		if var_16_3 then
			self:_common_boss_panel_show()
		else
			self._control.map_preview.map_bg.map_panel.map_node_root.rectTransform.anchoredPosition = var_0_8(20, 355)
		end

		for iter_16_0 = 1, 4 do
			self._boss_select_map_list[iter_16_0].boss_1.select_text.text.text = var_0_6(var_0_7:getNowLang("ui_4th_enter_button_title"), "α")
			self._boss_select_map_list[iter_16_0].boss_2.select_text.text.text = var_0_6(var_0_7:getNowLang("ui_4th_enter_button_title"), "β")
			self._boss_select_map_list[iter_16_0].boss_3.select_text.text.text = var_0_6(var_0_7:getNowLang("ui_4th_enter_button_title"), "γ")
			self._boss_select_map_list[iter_16_0].boss_4.select_text.text.text = var_0_6(var_0_7:getNowLang("ui_4th_enter_button_title"), "δ")
		end

		if arg_16_1 == self._active_config.levels[5] or arg_16_1 == self._active_config.hardLevels[5] then
			self._control.func_toggle:SetActive(true)
			self._control.map_preview.map_boss_bg:SetActive(true)
			self._control.map_preview.map_bg:SetActive(false)
			self._control.map_preview.map_boss_bg.map_panel.pass_icon:SetActive(false)

			self._control.map_preview.map_boss_bg.map_panel.pass_icon.pass_txt.text.text = var_0_7:getNowLang("ui_pvepassed")
			self._control.map_preview.map_boss_bg.right_info.title_bg.map_title_txt.text.text = var_16_0.title
			self._control.map_preview.map_boss_bg.right_info.title_bg.map_title_txt_2.text.text = var_16_0.sub_title
			self._control.map_preview.map_boss_bg.confirm_btn.title.text.text = var_0_7:getNowLang("pvebattleprepare")
			self._control.map_preview.map_boss_bg.right_info.bottom_tips.tips_txt.text.text = var_0_7:convert_rich_text(var_16_0.tips_2)
		else
			self._control.map_preview.map_bg:SetActive(true)
			self._control.map_preview.map_boss_bg:SetActive(false)
			self._control.func_toggle:SetActive(false)
			self._control.map_preview.map_bg.title_bg:SetActive(true)
			self._control.map_preview.map_bg.map_panel.pass_icon:SetActive(false)

			self._control.map_preview.map_bg.map_panel.pass_icon.pass_txt.text.text = var_0_7:getNowLang("ui_pvepassed")
			self._control.map_preview.map_bg.title_bg.map_title_txt.text.text = var_16_0.title .. " " .. var_16_0.sub_title
			self._control.map_preview.map_bg.confirm_btn.title.text.text = var_0_7:getNowLang("pvebattleprepare")
			self._control.map_preview.map_bg.bottom_tips.tips_txt.text.text = var_0_7:convert_rich_text(var_16_0.tips)
			self._control.map_preview.map_bg.normal_tips.tips_txt.text.text = var_0_7:convert_rich_text(var_16_0.tips_2)
			self._control.map_preview.map_bg.boss_panel.boss_bg.image.sprite = self:loadSprite(var_0_6(var_0_12.fearlessness_sea_enemy_bg, var_16_0.boss_bg))
			self._control.map_preview.map_bg.boss_panel.boss_image.image.sprite = self:loadSprite(var_0_6(var_0_12.fearlessness_sea_node_boss, var_16_0.boss_id))
		end

		self.map_fight_id = arg_16_1

		self._control.map_preview:SetActive(true)
		self._control.mask_image_bg:SetActive(true)

		self._control.map_preview.map_bg.boss_panel.boss_image.image.sprite = not var_0_1:ninth_map_is_pass(arg_16_1) and self:loadSprite(var_0_6(var_0_12.fearlessness_sea_node_boss, var_16_0.boss_id)) or self:loadSprite(var_0_6(var_0_12.fearlessness_sea_node_boss_b, var_16_0.boss_id))

		local var_16_5 = string.format(var_0_12.map_path_score, var_16_0.map_id, var_16_0.map_id)
		local var_16_6 = var_0_1:get_ninth_map_data()
		local var_16_7 = 0

		if var_16_6 and next(var_16_6) then
			var_16_7 = var_16_6[arg_16_1].hp
		end

		local var_16_8 = var_16_7 / var_0_21.find_object_by_id(arg_16_1).hp

		if var_16_8 > 0 and var_16_8 < 0.01 and var_16_7 > 0 then
			var_16_8 = 0.01
		end

		if var_16_3 then
			self._control.map_preview.map_boss_bg.map_panel.map_image.image.sprite = self:loadSprite(var_16_5)
			self._control.map_preview.map_boss_bg.right_info.boss_img.boss_hp_img.image.fillAmount = var_16_8
			self._control.map_preview.map_boss_bg.right_info.boss_img.boss_hp_txt.text.text = var_16_8 * 100
		else
			self._control.map_preview.map_bg.map_panel.map_image.image.sprite = self:loadSprite(var_16_5)
			self._control.map_preview.map_bg.boss_panel.boss_hp_black.hp_percent_num.text.text = var_0_6("%0.0f%s", var_16_8 * 100, "%")
			self._control.map_preview.map_bg.boss_panel.boss_hp_black.boss_hp_bar.image.fillAmount = var_16_8
		end

		if arg_16_2 then
			-- block empty
		else
			arg_16_2 = 1
		end

		self:show_small_panel_line_and_node(var_16_1, arg_16_1, arg_16_2)
	end

	function arg_1_0:show_small_panel_line_and_node(arg_17_1, arg_17_2, arg_17_3)
		self._control.obj_pool_root.canvasGroup.interactable = true

		local var_17_0
		local var_17_1
		local var_17_2
		local var_17_3 = var_0_1:get_ninth_map_data()
		local var_17_4 = var_0_1:get_is_ninth_boss()

		if arg_17_3 == 1 and not var_17_4 then
			var_17_0 = self._control.map_preview.map_bg.map_panel.map_node_root
			var_17_1 = self._control.map_preview.map_bg.map_panel.rectTransform.rect.width
			var_17_2 = self._control.map_preview.map_bg.map_panel.rectTransform.rect.height
		elseif arg_17_3 == 1 and var_17_4 then
			var_17_0 = self._control.map_preview.map_boss_bg.map_panel.map_node_root
			var_17_1 = self._control.map_preview.map_boss_bg.map_panel.rectTransform.rect.width
			var_17_2 = self._control.map_preview.map_boss_bg.map_panel.rectTransform.rect.height
		elseif arg_17_3 == 2 then
			var_17_0 = self._control.map_preview.map_boss_bg.map_panel.map_node_root_2
			var_17_1 = self._control.map_preview.map_boss_bg.map_panel.rectTransform.rect.width
			var_17_2 = self._control.map_preview.map_boss_bg.map_panel.rectTransform.rect.height
		elseif arg_17_3 == 3 then
			var_17_0 = self._control.map_preview.map_boss_bg.map_panel.map_node_root_3
			var_17_1 = self._control.map_preview.map_boss_bg.map_panel.rectTransform.rect.width
			var_17_2 = self._control.map_preview.map_boss_bg.map_panel.rectTransform.rect.height
		elseif arg_17_3 == 4 then
			var_17_0 = self._control.map_preview.map_boss_bg.map_panel.map_node_root_4
			var_17_1 = self._control.map_preview.map_boss_bg.map_panel.rectTransform.rect.width
			var_17_2 = self._control.map_preview.map_boss_bg.map_panel.rectTransform.rect.height
		end

		local var_17_5 = {}
		local var_17_6 = {}

		self._light_seq_list = {}

		for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
			if iter_17_1.node_miss and next(iter_17_1.node_miss) then
				for iter_17_2, iter_17_3 in pairs(iter_17_1.node_miss) do
					var_0_3(var_17_5, {
						hide_start_point = iter_17_1.id,
						hide_end_point = iter_17_2,
						hide_result = iter_17_3
					})
				end
			end

			if iter_17_1.node_miss_2 and next(iter_17_1.node_miss_2) then
				for iter_17_4, iter_17_5 in pairs(iter_17_1.node_miss_2) do
					var_0_3(var_17_6, {
						hide_start_point = iter_17_1.id,
						hide_end_point = iter_17_4,
						hide_result = iter_17_5
					})
				end
			end
		end

		for iter_17_6, iter_17_7 in pairs(arg_17_1) do
			local var_17_7, var_17_8 = self:__load_map_fragment_with_pool("map_node_obj", var_17_0.transform)

			var_17_7:setVisible(true)

			var_17_8.node_image.rectTransform.parent.offsetMin = var_0_8(0, 0)
			var_17_8.node_image.rectTransform.parent.offsetMax = var_0_8(0, 0)
			var_17_8.node_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_17_1, var_17_2, iter_17_7.position.x, iter_17_7.position.y)
			var_17_7._panel.transform.localScale = var_0_9.New(1, 1, 1)

			local var_17_9
			local var_17_10 = 1

			if iter_17_7.support_icon ~= 0 then
				var_17_9 = string.format(nil and nil > 0 and var_0_12.fight_point.support_icon_path_red or var_0_12.fight_point.support_icon_path_white, var_0_17.find_object_by_id(iter_17_7.support_icon).type)
			elseif iter_17_7.node_attribute == var_0_12.map_node_finish_type.init then
				var_17_9 = var_0_12.fight_point.pve_start_l
				var_17_10 = 2
			elseif iter_17_7.node_attribute == var_0_12.map_node_finish_type.boss_finish then
				if var_0_1:is_ninth_map_node_pass(iter_17_7.start_node_id, iter_17_7.id) then
					var_17_9 = var_0_12.fight_point.pve_boss_l
					var_17_10 = 2
				else
					var_17_9 = var_0_12.fight_point.pve_boss
					var_17_10 = 1
				end
			elseif iter_17_7.node_type == var_0_12.map_node_type.reward then
				var_17_9 = var_0_1:is_ninth_map_node_pass(iter_17_7.start_node_id, iter_17_7.id) and var_0_12.fight_point.pve_green or var_0_12.fight_point.pve_white
			elseif iter_17_7.node_type == var_0_12.map_node_type.null then
				var_17_9 = var_0_1:is_ninth_map_node_pass(iter_17_7.start_node_id, iter_17_7.id) and var_0_12.fight_point.pve_blue or var_0_12.fight_point.pve_white
			elseif iter_17_7.node_type == var_0_12.map_node_type.loss then
				var_17_9 = var_0_1:is_ninth_map_node_pass(iter_17_7.start_node_id, iter_17_7.id) and var_0_12.fight_point.pve_purple or var_0_12.fight_point.pve_white
			elseif iter_17_7.node_type == var_0_12.map_node_type.little_boss then
				var_17_8.night_atk_point:SetActive(false)

				self._little_boss_point_data = iter_17_7
				var_17_9 = var_0_1:is_ninth_map_node_pass(iter_17_7.start_node_id, iter_17_7.id) and var_0_12.fight_point.pve_small_boss_l or var_0_12.fight_point.pve_small_boss

				local var_17_16 = var_17_8.node_image.guard_icon
				local var_17_17, var_17_18 = var_0_1:is_point_stationed(iter_17_7.id)

				if var_17_17 then
					self._current_station_team_id = var_17_18

					local var_17_19 = var_0_1:get_account_id()
					local var_17_20 = tonumber(var_0_15:getDataByID(var_0_6("is_first_station_%d", var_17_3[iter_17_7.map_id].id), var_17_19))

					if var_17_20 and var_17_3[iter_17_7.map_id].id == var_17_20 then
						var_0_5:destroyInstance("suppress_msg")
						var_0_5:createInstance("suppress_msg"):show("suppressed", nil, 1.5, true)
						var_0_15:setDataByID(var_0_6("is_first_station_%d", var_17_3[iter_17_7.map_id].id), var_17_19, "have_show")
					end

					local var_17_21 = var_17_8.node_image.transform.localPosition

					var_17_16:SetActive(true)
					var_17_16.button.onClick:AddListener(function()
						local var_18_0 = string.sub(tostring(var_17_16.team_id.image.sprite), 16, 16)
						local var_18_1 = var_0_5:createInstance("captainroom_fleet")

						if not var_18_1 then
							return
						end

						var_18_1:show(var_0_7:getNowLang("ui_activitydefendfleet"), var_0_1:get_team_by_id(tonumber(var_18_0)).members, var_0_7:getNowLang("ui_activitydefendcancel"), "", function()
							local var_19_0 = var_0_5:createInstance("msgbox")

							if not var_19_0 then
								return
							end

							var_19_0:show(var_0_7:getNowLang("ui_activitydefendcanceltip"), function()
								var_19_0:setVisible(false)
								var_0_1:req_StationPointExitReq(tonumber(var_18_0))
								self:__onClick_map_preview_map_bg_close_btn()
								self:__onClick_map_preview_map_boss_bg_close_btn()
								var_0_5:destroyInstance("captainroom_fleet")

								local var_20_0 = var_0_5:getInstance("cover")

								if var_20_0 then
									var_20_0:setVisible(false)
								end
							end, function()
								var_19_0:setVisible(false)
							end, var_0_7:getNowLang("ui_activitydefendcancel"))
						end, true)
						var_18_1:disallowed_clicking()
					end)

					local var_17_22 = iter_17_7.bubble_icon

					if iter_17_7.bubble_icon == 0 then
						var_17_22 = 1
					end

					var_17_16.image.sprite = self:loadSprite(string.format(var_0_12.guard_point.pve_node_guard, var_17_22))
					var_17_16.team_id.image.sprite = self:loadSprite(string.format(var_0_12.guard_point.pve_fleet_team, self._current_station_team_id))
					var_17_16.transform.localScale = var_0_9(1.38, 1.54, 1)

					local var_17_23 = var_0_9.zero
					local var_17_24 = var_0_9.zero

					if var_17_22 == 1 then
						var_17_23 = var_0_8(-10, -142)
						var_17_24 = var_0_8(0, -2.8)
					elseif var_17_22 == 2 then
						var_17_23 = var_0_8(-10, 0)
						var_17_24 = var_0_8(0, 6)
					elseif var_17_22 == 3 then
						var_17_23 = var_0_8(120, 0)
						var_17_24 = var_0_8(0, 6)
					elseif var_17_22 == 4 then
						var_17_23 = var_0_8(120, -142)
						var_17_24 = var_0_8(0, -2.8)
					end

					if (var_17_22 == 1 or var_17_22 == 2) and var_17_21.x < 60 then
						var_17_23.x = 10
					elseif (var_17_22 == 1 or var_17_22 == 4) and var_17_21.y <= -537 then
						var_17_23.y = -104
					end

					var_17_16.transform.anchoredPosition = var_17_23
					var_17_16.team_id.transform.anchoredPosition = var_17_24
				else
					var_17_16:SetActive(false)
				end
			else
				local var_17_25 = var_0_1:is_ninth_map_node_pass(iter_17_7.pve_level_id, iter_17_7.id)

				if var_17_25 and iter_17_7.node_type ~= 13 then
					var_17_9 = var_0_12.fight_point.pve_red
					var_17_10 = 2
				elseif var_17_25 == false and iter_17_7.node_type ~= 13 then
					var_17_9 = var_0_12.fight_point.pve_white
					var_17_10 = 1
				elseif var_17_25 and iter_17_7.node_type == 13 then
					var_17_9 = var_0_12.pve_buff_red
					var_17_10 = 1
				elseif var_17_25 == false and iter_17_7.node_type == 13 then
					var_17_9 = var_0_12.pve_buff_white
					var_17_10 = 1
				else
					var_17_9 = var_0_12.fight_point.pve_white
					var_17_10 = 1
				end
			end

			if iter_17_7.node_attribute == var_0_12.map_node_finish_type.normal_finish then
				if var_0_1:is_ninth_map_node_pass(iter_17_7.pve_level_id, iter_17_7.id) then
					var_17_10 = 2
				end
			elseif iter_17_7.node_attribute == var_0_12.map_node_finish_type.normal and var_0_1:is_ninth_map_node_pass(iter_17_7.pve_level_id, iter_17_7.id) then
				var_17_10 = 2
			end

			if iter_17_7.flag and var_17_10 then
				local var_17_32 = var_0_6(var_0_12.fearlessness_sea_node_letter, iter_17_7.flag .. var_17_10)
			end

			var_17_8.node_image.rectTransform:GetComponent("Image").enabled = true

			local var_17_35

			var_17_8.night_atk_point_2:SetActive(false)

			if iter_17_7.roundabout == 1 then
				var_17_35 = var_0_12.pve_g
				var_17_8.night_atk_point_2.image.sprite = self:loadSprite(var_0_12.pve_g)

				var_17_8.night_atk_point_2.image:SetNativeSize()
				var_17_8.night_atk_point_2:SetActive(true)

				var_17_8.night_atk_point_2.rectTransform.parent.offsetMin = var_0_8(0, 0)
				var_17_8.night_atk_point_2.rectTransform.parent.offsetMax = var_0_8(0, 0)
				var_17_8.night_atk_point_2.rectTransform.anchoredPosition = self:__get_real_node_pos(var_17_1, var_17_2, iter_17_7.position.x, iter_17_7.position.y)
			end

			local var_17_36 = {}

			if iter_17_7.night_atk == 1 then
				var_17_35 = var_0_12.pve_night_atk_l

				var_0_3(var_17_36, var_0_12.pve_night_atk_l)
			end

			if iter_17_7.node_type == 10 then
				var_17_35 = var_0_12.pve_air

				var_0_3(var_17_36, var_0_12.pve_air)
			elseif iter_17_7.node_type == 11 then
				var_17_35 = var_0_12.pve_special_boss_l

				var_0_3(var_17_36, var_0_12.pve_special_boss_l)
			elseif iter_17_7.node_type == 14 and self:check_node_enemy(iter_17_7) then
				var_17_35 = var_0_12.pve_special_boss_l

				var_0_3(var_17_36, var_0_12.pve_special_boss_l)
			end

			local var_17_37 = false
			local var_17_38

			if iter_17_7.support_icon ~= 0 then
				local var_17_39 = gameconfig.support_atk_config.find_object_by_id(iter_17_7.support_icon)

				var_17_38 = var_0_1:is_ninth_map_node_pass(iter_17_7.start_node_id, iter_17_7.id)
				var_17_9 = var_0_6((var_17_38 or nil) and (var_0_12.fight_point.support_icon_path_red or var_0_12.fight_point.support_icon_path_white), var_17_39.type)
				var_17_37 = true
			elseif var_17_8.node_image:GetComponent("Button") then
				var_17_8.node_image:GetComponent("Button").enabled = false
			end

			if var_17_37 then
				var_17_8.node_image.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

				var_17_8.node_image.image.raycastTarget = true
				var_17_8.node_image:GetComponent("Button").enabled = true

				var_17_8.node_image:GetComponent("Button").onClick:RemoveAllListeners()
				var_17_8.node_image:GetComponent("Button").onClick:AddListener(function()
					local var_22_0 = var_0_5:getInstance("suppress_msg")

					if not var_22_0 then
						var_22_0 = var_0_5:createInstance("suppress_msg")
					else
						var_0_5:destroyInstance("suppress_msg")

						var_22_0 = var_0_5:createInstance("suppress_msg")
					end

					if var_17_38 then
						var_22_0:show("suppressed", iter_17_7.pve_level_id, 1.5, nil, var_0_12.fight_type.ninth_attack)
					else
						var_22_0:show("suppress", iter_17_7.pve_level_id, 1.5, nil, var_0_12.fight_type.ninth_attack)
					end
				end)
			end

			if var_17_35 then
				var_17_8.night_atk_point.image.sprite = self:loadSprite(var_17_35)

				var_17_8.night_atk_point.image:SetNativeSize()

				var_17_8.night_atk_point.rectTransform.parent.offsetMin = var_0_8(0, 0)
				var_17_8.night_atk_point.rectTransform.parent.offsetMax = var_0_8(0, 0)
				var_17_8.night_atk_point.rectTransform.anchoredPosition = self:__get_real_node_pos(var_17_1, var_17_2, iter_17_7.position.x, iter_17_7.position.y)

				if iter_17_7.night_atk == 1 or iter_17_7.node_type == 10 or iter_17_7.node_type == 11 or iter_17_7.node_type == 14 then
					local var_17_42 = true

					var_17_8.night_atk_point:SetActive(true)

					if iter_17_7.node_type == 11 then
						local var_17_43 = var_0_1:get_map_list()[iter_17_7.pve_level_id]

						if var_17_43 then
							for iter_17_8, iter_17_9 in pairs(var_17_43.pass_point) do
								if iter_17_7.id == iter_17_9.id then
									for iter_17_10, iter_17_11 in pairs(iter_17_9.info) do
										if iter_17_11.grade > 2 then
											var_17_42 = false

											break
										end
									end
								end
							end
						end
					end
				end
			else
				var_17_8.night_atk_point:SetActive(false)
			end

			var_0_1:set_ninth_map_tmp_icon_list(iter_17_6, var_17_36)

			var_17_8.node_image.image.sprite = self:loadSprite(var_17_9)

			local var_17_45 = {}

			for iter_17_14, iter_17_15 in pairs(var_17_5) do
				if iter_17_15.hide_start_point == iter_17_7.id then
					for iter_17_16, iter_17_17 in pairs(iter_17_15.hide_result) do
						local var_17_46 = var_0_1:get_ninth_map_node_pass_count(iter_17_7.start_node_id, tonumber(iter_17_16))

						if var_17_46 and iter_17_17 <= var_17_46 then
							for iter_17_18, iter_17_19 in pairs(iter_17_7.next_node) do
								if iter_17_19 == tonumber(iter_17_15.hide_end_point) then
									var_0_3(var_17_45, iter_17_19)
								end
							end
						end
					end
				end
			end

			for iter_17_20, iter_17_21 in pairs(var_17_6) do
				if iter_17_21.hide_start_point == iter_17_7.id then
					local var_17_48, var_17_49 = self:_is_have_pass_node(iter_17_21.hide_result, iter_17_21.hide_end_point)

					if not var_17_48 then
						var_0_3(var_17_45, var_17_49)
					end
				end
			end

			local var_17_51 = {}

			if iter_17_7.node_hide_2 and next(iter_17_7.node_hide_2) then
				for iter_17_22, iter_17_23 in pairs(iter_17_7.node_hide_2) do
					local var_17_54 = {}

					for iter_17_24, iter_17_25 in pairs(iter_17_7.next_node) do
						if tonumber(iter_17_22) == iter_17_25 then
							for iter_17_26, iter_17_27 in pairs(iter_17_23) do
								table.insert(var_17_54, (var_0_1:ninth_map_is_pass(iter_17_27) or nil) and 1)
							end

							local var_17_57 = var_0_23.find_object_by_id_start_node_id(iter_17_25, iter_17_7.start_node_id)

							if var_17_54 and next(var_17_54) then
								var_0_3(var_17_51, {
									is_show_true = (self:_have_data_2(var_17_54, 0) or nil) and false,
									node_flag = var_17_57.flag
								})
							end
						end
					end
				end
			end

			local var_17_59 = {}
			local var_17_60 = true

			if iter_17_7.node_hide and next(iter_17_7.node_hide) then
				for iter_17_28, iter_17_29 in pairs(iter_17_7.node_hide) do
					for iter_17_30, iter_17_31 in pairs(iter_17_7.next_node) do
						if tonumber(iter_17_28) == iter_17_31 then
							for iter_17_32, iter_17_33 in pairs(iter_17_29) do
								if not var_0_1:is_ninth_map_node_pass(iter_17_7.start_node_id, iter_17_33) or var_0_1:get_ninth_map_node_pass_count(iter_17_7.start_node_id, iter_17_33) <= 0 then
									var_17_60 = false
								end
							end

							var_17_59 = {
								is_show_true = var_17_60,
								node_flag = var_0_23.find_object_by_id_start_node_id(iter_17_31, iter_17_7.start_node_id).flag
							}
						end
					end
				end
			end

			if iter_17_7.next_node_path and iter_17_7.next_node_path ~= "{}" then
				local var_17_62 = 1

				for iter_17_34, iter_17_35 in pairs((var_0_11(iter_17_7.next_node_path))) do
					local var_17_63, var_17_64 = self:__load_map_fragment_with_pool("map_line_obj", var_17_0.transform)

					var_17_63:setVisible(true)

					var_17_64.line_image.rectTransform.parent.offsetMin = var_0_8(0, 0)
					var_17_64.line_image.rectTransform.parent.offsetMax = var_0_8(0, 0)
					var_17_64.line_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_17_1, var_17_2, iter_17_35.x, iter_17_35.y)
					var_17_64.line_image.image.sprite = self:loadSprite((string.format(var_0_12.mapline_path, string.lower(arg_17_2), iter_17_34)))
					var_17_64.line_image.transform.localScale = var_0_9(0.7, 0.7, 1)

					var_17_64.line_image.image:SetNativeSize()
					var_17_64.line_image:SetActive(true)

					var_17_63._panel.transform.localScale = var_0_9.New(1, 1, 1)

					if var_17_59 and next(var_17_59) then
						if var_17_59.node_flag == lx.split(iter_17_34, "-")[3] then
							var_17_64.line_image.image.color = var_17_59.is_show_true and Color(1, 1, 1, 1) or Color(1, 1, 1, 0.2)
						end

						var_17_62 = var_17_62 + 1
					end

					if var_17_51 and next(var_17_51) then
						for iter_17_36, iter_17_37 in pairs(var_17_51) do
							if var_17_51[iter_17_36].node_flag == lx.split(iter_17_34, "-")[3] then
								var_17_64.line_image.image.color = var_17_51[iter_17_36].is_show_true and Color(1, 1, 1, 1) or Color(1, 1, 1, 0.2)
							end
						end

						var_17_62 = var_17_62 + 1
					end

					if next(var_17_45) then
						for iter_17_38, iter_17_39 in pairs(var_17_45) do
							local var_17_65 = tonumber(iter_17_39)
							local var_17_66

							for iter_17_40, iter_17_41 in pairs((var_0_23.get_start_node_id_set_by_id(var_17_65))) do
								var_17_66 = var_0_23.find_object_by_id_start_node_id(var_17_65, iter_17_40)
							end

							if var_0_6("%s-%s-%s", iter_17_7.pve_level_id, iter_17_7.flag, var_17_66.flag) == iter_17_34 then
								var_17_64.line_image:SetActive(false)
							end
						end
					end
				end
			end

			if #iter_17_7.flag > 0 then
				local var_17_68, var_17_69 = self:__load_map_fragment_with_pool("ninth_letter_name_obj", var_17_0.transform)

				var_17_68:setVisible(true)

				var_17_69.node_letter_image.rectTransform.parent.offsetMin = var_0_8(0, 0)
				var_17_69.node_letter_image.rectTransform.parent.offsetMax = var_0_8(0, 0)
				var_17_69.node_letter_image.rectTransform.anchoredPosition = var_17_8.node_image.rectTransform.anchoredPosition + var_0_8(0, 30)
				var_17_69.node_letter_image.image.sprite = self:loadSprite((iter_17_7.flag or nil) and var_0_6(var_0_12.fearlessness_sea_node_letter, iter_17_7.flag .. var_17_10))
				var_17_68._panel.transform.localScale = var_0_9.New(1, 1, 1)
			end
		end
	end

	function arg_1_0:_is_have_pass_node(arg_24_1, arg_24_2)
		local var_24_1 = {}

		for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
			var_0_3(var_24_1, var_0_1:ninth_map_is_pass(iter_24_1) and 1 or 0)
		end

		return self:_have_data_2(var_24_1, 0), arg_24_2
	end

	function arg_1_0:_is_open_boss()
		local var_25_1 = var_0_1:get_all_node_info()

		return (self:_have_data_2(self:_ninth_map_pass_list(), 1))
	end

	function arg_1_0:_ninth_map_pass_list()
		local var_26_0 = {}

		if self._active_config and next(self._active_config) then
			for iter_26_0, iter_26_1 in pairs(self._active_config.levels) do
				var_0_3(var_26_0, iter_26_1, (var_0_1:ninth_map_is_pass(iter_26_1) or nil) and 1)
			end
		end

		return var_26_0
	end

	function arg_1_0:_set_boss_pos(arg_27_1)
		self._control.map_preview.map_boss_bg.map_panel.map_image.shipViewControl.onDrag:RemoveAllListeners()
		self._control.map_preview.map_boss_bg.map_panel.map_image.shipViewControl.onDrag:AddListener(function(arg_28_0, arg_28_1)
			return
		end)
	end

	function arg_1_0:show_small_boss_panel_map(arg_29_1)
		if arg_29_1 == 1 then
			self._control.map_preview.map_boss_bg.map_panel.map_image.rectTransform.anchoredPosition = var_0_8(1920 * 0.9 * 0.7 / 2 + var_0_12.ninth_boss_pos.boss_1.x, -1200 * 0.9 * 0.7 / 2 + var_0_12.ninth_boss_pos.boss_1.y)
			self._boss_map_list[arg_29_1].rectTransform.anchoredPosition = var_0_8(var_0_12.ninth_boss_pos.boss_1.x + 35, var_0_12.ninth_boss_pos.boss_1.y + 10)
		elseif arg_29_1 == 2 then
			self._control.map_preview.map_boss_bg.map_panel.map_image.rectTransform.anchoredPosition = var_0_8(1920 * 0.9 * 0.7 / 2 + var_0_12.ninth_boss_pos.boss_2.x, -1200 * 0.9 * 0.7 / 2 + var_0_12.ninth_boss_pos.boss_2.y)
			self._boss_map_list[arg_29_1].rectTransform.anchoredPosition = var_0_8(var_0_12.ninth_boss_pos.boss_2.x + 35, var_0_12.ninth_boss_pos.boss_2.y + 10)
		elseif arg_29_1 == 3 then
			self._control.map_preview.map_boss_bg.map_panel.map_image.rectTransform.anchoredPosition = var_0_8(1920 * 0.9 * 0.7 / 2 + var_0_12.ninth_boss_pos.boss_3.x, -1200 * 0.9 * 0.7 / 2 + var_0_12.ninth_boss_pos.boss_3.y)
			self._boss_map_list[arg_29_1].rectTransform.anchoredPosition = var_0_8(var_0_12.ninth_boss_pos.boss_3.x + 35, var_0_12.ninth_boss_pos.boss_3.y + 10)
		elseif arg_29_1 == 4 then
			self._control.map_preview.map_boss_bg.map_panel.map_image.rectTransform.anchoredPosition = var_0_8(1920 * 0.9 * 0.7 / 2 + var_0_12.ninth_boss_pos.boss_4.x, -1200 * 0.9 * 0.7 / 2 + var_0_12.ninth_boss_pos.boss_4.y)
			self._boss_map_list[arg_29_1].rectTransform.anchoredPosition = var_0_8(var_0_12.ninth_boss_pos.boss_4.x + 35, var_0_12.ninth_boss_pos.boss_4.y + 10)
		end
	end

	function arg_1_0:_show_reward_red_point()
		local var_30_0 = var_0_1:get_ninth_score_info()

		if var_30_0 <= 0 then
			self._control.all_button.award_btn.reward_red_img:SetActive(false)

			return
		end

		local var_30_1 = var_0_1:get_ninth_award_data()
		local var_30_2 = {}
		local var_30_3 = var_0_19.get_sequence()
		local var_30_4 = var_0_1:get_ninth_map_data()

		if var_30_1 and next(var_30_1) then
			for iter_30_0, iter_30_1 in pairs(var_30_3) do
				if iter_30_1.level_id > 0 and var_30_0 >= iter_30_1.score and not self:_have_data_2(var_30_1, iter_30_1.id) then
					if var_30_4[iter_30_1.level_id] and var_30_4[iter_30_1.level_id].state == 2 then
						var_0_3(var_30_2, iter_30_1.id)
					end
				elseif var_30_0 >= iter_30_1.score and not self:_have_data_2(var_30_1, iter_30_1.id) then
					var_0_3(var_30_2, iter_30_1.id)
				end
			end

			if next(var_30_2) then
				self._control.all_button.award_btn.reward_red_img:SetActive(true)
			else
				self._control.all_button.award_btn.reward_red_img:SetActive(false)
			end
		elseif var_30_0 >= var_30_3[1].score then
			self._control.all_button.award_btn.reward_red_img:SetActive(true)
		end
	end

	function arg_1_0:__load_map_fragment_with_pool(arg_31_1, arg_31_2)
		local var_31_0 = false
		local var_31_1

		if self._obj_pool and next(self._obj_pool) then
			for iter_31_0, iter_31_1 in ipairs(self._obj_pool[arg_31_1]) do
				if iter_31_1.using == false then
					var_31_0 = true
					var_31_1 = self._obj_pool[arg_31_1][iter_31_0]

					break
				end
			end

			if var_31_0 then
				var_31_1.using = true

				var_31_1.prefabObj._panel.transform:SetParent(arg_31_2)

				return var_31_1.prefabObj, var_31_1.prefabContorl
			else
				local var_31_2, var_31_3 = self:loadUIPrefab(arg_31_1, arg_31_2)

				self._obj_pool[arg_31_1][#self._obj_pool[arg_31_1] + 1] = {
					using = true,
					prefabObj = var_31_2,
					prefabContorl = var_31_3
				}

				return var_31_2, var_31_3
			end
		else
			self:__preload_map_fragment()

			for iter_31_2, iter_31_3 in ipairs(self._obj_pool[arg_31_1]) do
				if iter_31_3.using == false then
					var_31_0 = true
					var_31_1 = self._obj_pool[arg_31_1][iter_31_2]

					break
				end
			end

			if var_31_0 then
				var_31_1.using = true

				var_31_1.prefabObj._panel.transform:SetParent(arg_31_2)

				return var_31_1.prefabObj, var_31_1.prefabContorl
			else
				local var_31_4, var_31_5 = self:loadUIPrefab(arg_31_1, arg_31_2)

				self._obj_pool[arg_31_1][#self._obj_pool[arg_31_1] + 1] = {
					using = true,
					prefabObj = var_31_4,
					prefabContorl = var_31_5
				}

				return var_31_4, var_31_5
			end
		end
	end

	function arg_1_0:all_pass_hard_map_list(arg_32_1)
		self.map_fight_id = self._active_config.hardLevels[arg_32_1]
	end

	function arg_1_0:all_pass_easy_map_list(arg_33_1, arg_33_2)
		local var_33_0 = {}

		if self._active_config and next(self._active_config) then
			for iter_33_0, iter_33_1 in pairs(self._active_config.levels) do
				if iter_33_1 == 10233 then
					table.insert(var_33_0, iter_33_1)
				end
			end
		end

		if not arg_33_2 then
			if var_33_0 and next(var_33_0) then
				self.map_fight_id = var_33_0[1]
			end
		else
			self.map_fight_id = var_33_0
		end
	end

	function arg_1_0:show_ninth_task_and_server_task()
		if not var_0_1:get_ninth_guide_state() then
			return
		end

		local var_34_0 = var_0_1:get_ninth_task_info_list()
		local var_34_1 = var_0_1:get_ninth_server_task_info_list()
		local var_34_2 = var_0_1:get_account_id()
		local var_34_3 = var_0_15:getDataByID("is_ninth_task_", var_34_2)
		local var_34_4 = var_0_15:getDataByID("is_server_task_ninth_", var_34_2)
		local var_34_5 = var_0_10.little_clone(var_34_0)
		local var_34_6 = var_0_10.little_clone(var_34_1)

		self._show_task_list = {}
		self._show_server_task_list = {}

		if var_34_0 and next(var_34_0) and var_34_1 and next(var_34_1) then
			if var_34_3 == "" and var_34_4 == "" then
				self:__show_task()

				for iter_34_0, iter_34_1 in pairs(var_34_1) do
					var_0_3(self._show_server_task_list, iter_34_1)
				end

				self._is_next_task = true
			elseif var_34_3 ~= "" and var_34_4 == "" then
				self:__show_task()

				for iter_34_2, iter_34_3 in pairs(var_34_1) do
					var_0_3(self._show_server_task_list, iter_34_3)
				end

				self._is_next_task = true
			elseif var_34_3 == "" and var_34_4 ~= "" then
				self:__show_task()

				for iter_34_4, iter_34_5 in pairs(var_34_1) do
					if not string.find(var_34_4, (tostring(iter_34_5))) then
						var_0_3(self._show_server_task_list, iter_34_5)

						self._is_next_task = true
					end
				end
			else
				self:__show_task()

				for iter_34_6, iter_34_7 in pairs(var_34_1) do
					if not string.find(var_34_4, (tostring(iter_34_7))) then
						var_0_3(self._show_server_task_list, iter_34_7)

						self._is_next_task = true
					end
				end
			end
		elseif var_34_0 and next(var_34_0) then
			self:__show_task()
		elseif var_34_1 and next(var_34_1) then
			self:__show_server_task()
		else
			self._control.msg_panel.finish_special_mission_btn:SetActive(false)
		end
	end

	function arg_1_0:__show_server_task()
		local var_35_0 = var_0_1:get_ninth_server_task_info_list()
		local var_35_1 = var_0_15:getDataByID("is_server_task_ninth_", (var_0_1:get_account_id()))

		if var_35_0 and next(var_35_0) then
			for iter_35_0, iter_35_1 in pairs(var_35_0) do
				if not string.find(var_35_1, (tostring(iter_35_1))) then
					var_0_3(self._show_server_task_list, iter_35_1)
				end
			end

			if self._show_server_task_list and next(self._show_server_task_list) then
				self:show_task_panel_info(self._show_server_task_list[1], 2)
			end
		end
	end

	function arg_1_0:__show_task()
		local var_36_0 = var_0_1:get_ninth_task_info_list()
		local var_36_1 = var_0_15:getDataByID("is_ninth_task_", (var_0_1:get_account_id()))

		if var_36_0 and next(var_36_0) then
			for iter_36_0, iter_36_1 in pairs(var_36_0) do
				if not string.find(var_36_1, (tostring(iter_36_1))) then
					var_0_3(self._show_task_list, iter_36_1)
				end
			end

			if self._show_task_list and next(self._show_task_list) then
				self:show_task_panel_info(self._show_task_list[1], 1)
			end
		end
	end

	function arg_1_0:show_task_panel_info(arg_37_1, arg_37_2)
		local var_37_0
		local var_37_1 = var_0_1:get_account_id()
		local var_37_2 = self._control.msg_panel.finish_special_mission

		if arg_37_2 == 1 then
			var_37_0 = var_0_18.find_object_by_id(arg_37_1)

			local var_37_3 = tostring(arg_37_1)
			local var_37_4 = var_0_15:getDataByID("is_ninth_task_", var_37_1)

			if var_37_4 and var_37_4 ~= "" then
				var_37_3 = not string.find(var_37_4, var_37_3) and var_37_4 .. var_37_3 or var_37_4
			end

			var_0_15:setDataByID("is_ninth_task_", var_37_1, var_37_3 .. "*")

			var_37_2.finish_title.text.text = var_0_7:getNowLang("ninth_task_2") .. var_0_7:getNowLang("pveexploretimelabel3") .. "!"
			var_37_2.map_title.text.text = var_0_7:convert_rich_text(var_37_0.condition_desc_2)
		elseif arg_37_2 == 2 then
			var_37_0 = var_0_24.find_object_by_id(arg_37_1)

			local var_37_5 = tostring(arg_37_1)
			local var_37_6 = var_0_15:getDataByID("is_server_task_ninth_", var_37_1)

			if var_37_6 and var_37_6 ~= "" then
				var_37_5 = not string.find(var_37_6, var_37_5) and var_37_6 .. var_37_5 or var_37_6
			end

			var_0_15:setDataByID("is_server_task_ninth_", var_37_1, var_37_5 .. "*")

			var_37_2.finish_title.text.text = var_0_7:getNowLang("ninth_task_1") .. var_0_7:getNowLang("pveexploretimelabel3") .. "!"
			var_37_2.map_title.text.text = var_0_7:convert_rich_text(var_37_0.desc_2)
		end

		var_37_2:SetActive(true)

		local var_37_7 = self:autoKillDOTween(var_0_4.Sequence())

		var_37_7:Append(var_37_2.transform:DOScaleY(0, 0))
		var_37_7:Append(var_37_2.transform:DOScaleY(1, 0.5))
		self._control.msg_panel.finish_special_mission_btn:SetActive(true)

		for iter_37_0, iter_37_1 in ipairs(self._task_award_list) do
			iter_37_1:SetActive(false)
		end

		for iter_37_2, iter_37_3 in ipairs(self._task_award_list) do
			if var_37_0.award[iter_37_2] then
				iter_37_3:SetActive(true)

				iter_37_3.award_icon.image.sprite = self:loadSprite(var_0_6(var_0_12.mail_icon, var_37_0.award[iter_37_2].id))
				iter_37_3.coin_num.text.text = var_37_0.award[iter_37_2].value
			end
		end

		var_37_2.task_title.text.text = var_0_7:getNowLang("pveexploreresultequip")
	end

	function arg_1_0:show_panel_pass()
		local var_38_0 = var_0_1:get_battle_info().id

		if var_38_0 == self._active_config.levels[5] then
			var_0_1:set_ninth_active_common_num(nil)
		end

		self._info_move_seq = {}

		local var_38_1 = self:autoKillDOTween(var_0_4.Sequence())

		var_0_3(self._info_move_seq, var_38_1)
		self._control.pass_map:SetActive(true)
		self._control.pass_map.all_pass_show:SetActive(true)

		local var_38_2 = var_0_21.find_object_by_id(var_38_0)

		self._control.pass_map.all_pass_show.pass_txt.text.text = var_0_6(var_0_7:getNowLang("ui_activityworldpasstip") .. " " .. ((var_38_2 or nil) and var_38_2.sub_title))

		var_38_1:Append(self._control.pass_map.all_pass_show.rectTransform:DOLocalMoveX(-1280, 1.5))
		var_38_1:AppendInterval(0.5)
		var_38_1:Append(self._control.pass_map.all_pass_show.rectTransform:DOLocalMoveX(-1280 + -1280, 1.5))
		var_38_1:AppendCallback(function()
			self._control.pass_map:SetActive(false)
		end)
		var_38_1:SetLoops(1)
		var_0_1:set_ninth_map_pass(false)
	end

	function arg_1_0:__preload_map_fragment()
		self._obj_pool = {}

		for iter_40_0, iter_40_1 in ipairs({
			{
				preload_count = 10,
				preload_obj_name = "map_line_obj"
			},
			{
				preload_count = 10,
				preload_obj_name = "map_node_obj"
			},
			{
				preload_count = 10,
				preload_obj_name = "ninth_letter_name_obj"
			}
		}) do
			self._obj_pool[iter_40_1.preload_obj_name] = {}

			for iter_40_2 = 1, iter_40_1.preload_count do
				local var_40_0, var_40_1 = self:loadUIPrefab(iter_40_1.preload_obj_name, self._control.obj_pool_root.transform)

				var_40_0:setVisible(true)

				self._obj_pool[iter_40_1.preload_obj_name][#self._obj_pool[iter_40_1.preload_obj_name] + 1] = {
					using = false,
					prefabObj = var_40_0,
					prefabContorl = var_40_1
				}
			end
		end
	end

	function arg_1_0.__get_real_node_pos(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
		return var_0_8(arg_41_3 / 1280 * arg_41_1, not arg_41_5 and -1 * arg_41_4 / 720 * arg_41_2 or arg_41_4 / 960 * arg_41_2)
	end

	function arg_1_0:__destroy_pool()
		if self._obj_pool and #self._obj_pool > 0 then
			for iter_42_0, iter_42_1 in pairs(self._obj_pool) do
				for iter_42_2, iter_42_3 in pairs(iter_42_1) do
					iter_42_3 = nil
				end
			end

			for iter_42_4, iter_42_5 in pairs(self._obj_pool) do
				iter_42_5 = nil
			end
		end

		self._obj_pool = nil
		self._showedMapIndexTb = nil

		if self._chapter_scroll_view_control then
			self._chapter_scroll_view_control.curve_scroll_rect.curveScrollRect.onItemSelect:RemoveAllListeners()
		end

		self._chapter_scroll_view_control = nil
		self._map_scroll_view_control = nil
		self._curr_set_chapter_index = -1

		self:destroyChildren("fearlessness_sea_enemy_point")
		self:destroyChildren("map_line_obj")
		self:destroyChildren("map_node_obj")
		self:destroyChildren("ninth_letter_name_obj")
		self:destroyChildren("fearlessness_sea_letter_obj")
	end

	function arg_1_0:__hide_all_mini_map_fragment_to_pool()
		if not self._obj_pool then
			return
		end

		for iter_43_0, iter_43_1 in pairs(self._obj_pool) do
			if iter_43_1 then
				for iter_43_2, iter_43_3 in ipairs(iter_43_1) do
					if iter_43_3.using then
						iter_43_3.prefabObj._panel.transform:SetParent(self._control.obj_pool_root.transform, false)

						iter_43_3.using = false
					end
				end
			end
		end
	end

	function arg_1_0:_play_audio(arg_44_1, arg_44_2)
		self:playBackgroundMusic(arg_44_1, arg_44_2)
	end

	function arg_1_0:_play_into_se(arg_45_1)
		self:playSE(arg_45_1, false)
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_47_0)
		arg_47_0._active_id = nil
		arg_47_0._little_boss_point_data = nil
		arg_47_0._current_station_team_id = 0
		arg_47_0.map_fight_id = nil
		arg_47_0._is_hard = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_48_0)
	local var_48_0 = var_0_5:class("ninth_main_map")

	var_48_0:__initia_lize()

	var_48_0._active_id = nil
	var_48_0._current_station_team_id = 0
	var_48_0.map_fight_id = nil
	var_48_0._is_hard = false
	var_48_0._map_debuff = nil
	var_48_0._is_pass_debuff = false
	var_48_0._is_next_task = false
	var_48_0._ninth_active_common_num = nil
	var_48_0._player_select_pos = nil

	return var_48_0
end

return var_0_0
