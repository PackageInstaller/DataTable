local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = string.format
local var_0_7 = table.insert
local var_0_10 = gameconfig.pve_ocean_level_config
local var_0_11 = gameconfig.ship_config
local var_0_12 = gameconfig.equip_config
local var_0_14 = gameconfig.ship_pve_active_config
local var_0_15 = DG.Tweening.DOTween
local var_0_16 = lx.json_decode
local var_0_17 = UnityEngine.Vector2
local var_0_18 = UnityEngine.Vector3
local var_0_19 = gameconfig.map_node_config
local var_0_20 = gameconfig.ocean_map_node_config
local var_0_21 = gamecore.util_func
local var_0_22 = UnityEngine.Handheld
local var_0_23 = UnityEngine.FullScreenMovieControlMode
local var_0_25 = UnityEngine.Color

gamecore.UILoader:define("ocean_main_map", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:_init_panel()
	end

	function arg_1_0:_init_panel()
		if not self._is_init then
			self:__initial_func()
			self:__init_data()
			self:__init_active()
			self:__init_position(self._big_normal_map_data)

			self._is_init = true
		end

		self:__init_anim()

		self.__now_state = self:__pass_all_normal_map() and 2 or 1

		self:__normal_or_hard()
		self:__destroy_pool()
		self:__preload_map_fragment()
		self:__show_next_map()
	end

	function arg_1_0:__normal_or_hard()
		if self.__now_state == 1 then
			self:__init_content(self._big_normal_map_data)

			self._control.main.top.title_bg.image.sprite = self:loadSprite(var_0_5.forth_title_bg.normal)
		else
			self:__init_content(self._big_hard_map_data)

			self._control.main.top.title_bg.image.sprite = self:loadSprite(var_0_5.forth_title_bg.hard)
		end

		self._control.active_bg.gameObject:SetActive(self.__now_state == 1)
		self._control.active_hard_bg.gameObject:SetActive(self.__now_state == 2)
		self._control.main.bottom.hard_btn.gameObject:SetActive(false)

		if var_0_3:is_ocean_map_pass(9618) then
			self._control.main.bottom.hard_btn.gameObject:SetActive(self.__now_state == 1)
		end

		self._control.main.bottom.normal_btn.gameObject:SetActive(self.__now_state == 2)
	end

	function arg_1_0:__init_data()
		self._user_data = var_0_3:get_ocean_map_data()
		self.__map_list = {
			self._control.main.middle.map._9613,
			self._control.main.middle.map._9614,
			self._control.main.middle.map._9615,
			self._control.main.middle.map._9616,
			self._control.main.middle.map._9617,
			self._control.main.middle.map._9618
		}
		self.__map_btn_list = {
			self._control.main.middle.btns.btn1,
			self._control.main.middle.btns.btn2,
			self._control.main.middle.btns.btn3,
			self._control.main.middle.btns.btn4,
			self._control.main.middle.btns.btn5,
			self._control.main.middle.btns.btn6
		}
		self.__map_name1_list = {
			self._control.main.middle.map_name1.map_name_bg_1.text1,
			self._control.main.middle.map_name1.map_name_bg_2.text2,
			self._control.main.middle.map_name1.map_name_bg_3.text3,
			self._control.main.middle.map_name1.map_name_bg_4.text4,
			self._control.main.middle.map_name1.map_name_bg_5.text5,
			self._control.main.middle.map_name1.map_name_bg_6.text6
		}
		self.__map_name2_list = {
			self._control.main.middle.map_name2._9613,
			self._control.main.middle.map_name2._9614,
			self._control.main.middle.map_name2._9615,
			self._control.main.middle.map_name2._9616,
			self._control.main.middle.map_name2._9617,
			self._control.main.middle.map_name2._9618
		}
		self.__map_score_list = {
			self._control.main.middle.map_score.score1,
			self._control.main.middle.map_score.score2,
			self._control.main.middle.map_score.score3,
			self._control.main.middle.map_score.score4,
			self._control.main.middle.map_score.score5,
			self._control.main.middle.map_score.score6
		}
		self._node_data = var_0_20.get_sequence()
		self._big_normal_map_data = {}
		self._big_hard_map_data = {}
		self._normal_node_data = {}
		self._hard_node_data = {}
		self._active_config = var_0_14.find_object_by_id(self._active_id)

		for iter_5_0, iter_5_1 in pairs(self._active_config.levels) do
			var_0_7(self._big_normal_map_data, var_0_10.find_object_by_id(iter_5_1))

			for iter_5_2 = 1, #self._node_data do
				if self._node_data[iter_5_2].pve_level_id == iter_5_1 then
					if self._normal_node_data[iter_5_1] == nil then
						self._normal_node_data[iter_5_1] = {}
					end

					var_0_7(self._normal_node_data[iter_5_1], self._node_data[iter_5_2])
				end
			end
		end

		for iter_5_3, iter_5_4 in pairs(self._active_config.hardLevels) do
			var_0_7(self._big_hard_map_data, var_0_10.find_object_by_id(iter_5_4))

			for iter_5_5 = 1, #self._node_data do
				if self._node_data[iter_5_5].pve_level_id == iter_5_4 then
					if self._hard_node_data[iter_5_4] == nil then
						self._hard_node_data[iter_5_4] = {}
					end

					var_0_7(self._hard_node_data[iter_5_4], self._node_data[iter_5_5])
				end
			end
		end

		self._shop_data = var_0_3:get_ocean_shop_data()
		self._user_point = self._shop_data.coin or 0
		self._user_hard_point = self._shop_data.hard_coin or 0
		self.__btn_state = 1
	end

	function arg_1_0:__tween_ocean_guide_ainimation(arg_6_1)
		local var_6_0 = self:autoKillDOTween(var_0_15.Sequence())
		local var_6_1 = self._control.ocean_guide

		if arg_6_1 then
			self._control.ocean_guide:SetActive(true)
			self._control.shadow:SetActive(true)

			self._control.ocean_guide.transform.localScale = var_0_17.New(0.1, 0.1)

			var_6_0:Append(self._control.ocean_guide.transform:DOScale(1.1, 0.15)):SetEase(DG.Tweening.Ease.InOutElastic)
			var_6_0:Append(self._control.ocean_guide.transform:DOScale(1, 0.05)):SetEase(DG.Tweening.Ease.InOutQuad)
		else
			var_6_0:Append(self._control.ocean_guide.transform:DOScale(0.3, 0.2)):SetEase(DG.Tweening.Ease.InExpo)
			var_6_0:AppendCallback(function()
				var_6_1:SetActive(false)
				self._control.shadow:SetActive(false)
			end)
		end

		var_6_0:Play()
	end

	function arg_1_0:__init_active()
		for iter_8_0 = 1, #self.__map_name2_list do
			self.__map_name2_list[iter_8_0].gameObject:SetActive(self.__map_list[iter_8_0].gameObject.activeSelf)
		end
	end

	function arg_1_0:__show_next_map()
		local var_9_0 = {}
		local var_9_1 = {}

		for iter_9_0, iter_9_1 in pairs(self.__map_list) do
			iter_9_1.gameObject:SetActive(true)
		end

		if self.__now_state == 1 then
			for iter_9_2, iter_9_3 in pairs(self._user_data) do
				for iter_9_4, iter_9_5 in pairs(iter_9_3.boss_hp) do
					if iter_9_5.hp == 0 then
						table.insert(var_9_0, iter_9_5.id)
					end
				end

				for iter_9_6, iter_9_7 in pairs(iter_9_3.start_point) do
					local var_9_2 = var_0_10.find_object_by_id(iter_9_3.id)

					if var_9_2.line[tostring(iter_9_7)] then
						var_9_1[iter_9_7] = var_9_2.line[tostring(iter_9_7)]
					end
				end
			end
		else
			for iter_9_8, iter_9_9 in pairs(self._user_data) do
				for iter_9_10, iter_9_11 in pairs(iter_9_9.boss_hp) do
					if iter_9_8 >= 9619 and iter_9_11.hp == 0 then
						table.insert(var_9_0, iter_9_11.id)
					end
				end
			end
		end

		self.__map_list[1].gameObject:SetActive(false)

		for iter_9_12, iter_9_13 in pairs(var_9_0) do
			local var_9_4 = string.sub(var_0_20.find_object_by_id_start_node_id(iter_9_13, (var_0_20.get_start_node_id_by_id(iter_9_13))).next_level_node, 1, 4) + 0

			for iter_9_14, iter_9_15 in ipairs(self.__map_list) do
				if self.__now_state == 1 then
					if "_" .. var_9_4 == iter_9_15.gameObject.name then
						iter_9_15.gameObject:SetActive(false)
					end
				elseif "_" .. var_9_4 - 6 == iter_9_15.gameObject.name then
					iter_9_15.gameObject:SetActive(false)
				end
			end
		end

		for iter_9_16, iter_9_17 in pairs(var_9_1) do
			local var_9_5, var_9_6 = self:__load_map_fragment_with_pool("ocean_map_line_obj", self._control.active_bg.transform)

			var_9_5:setVisible(true)

			var_9_6.line_image.rectTransform.parent.offsetMin = var_0_17(0, 0)
			var_9_6.line_image.rectTransform.parent.offsetMax = var_0_17(0, 0)
			var_9_6.line_image.rectTransform.anchoredPosition = var_0_17(iter_9_17[1], -iter_9_17[2])
			var_9_6.line_image.image.sprite = self:loadSprite((string.format(self.__now_state == 1 and var_0_5.ocean_normal_mapline_path or var_0_5.ocean_hard_mapline_path, iter_9_16)))

			var_9_6.line_image.image:SetNativeSize()
			var_9_6.line_image:SetActive(true)
		end
	end

	function arg_1_0:__init_position(arg_10_1)
		for iter_10_0 = 1, #self.__map_list do
			self.__map_list[iter_10_0].rectTransform.anchoredPosition = var_0_17(arg_10_1[iter_10_0].position.x, -arg_10_1[iter_10_0].position.y)
		end

		for iter_10_1 = 1, #self.__map_btn_list do
			self.__map_btn_list[iter_10_1].rectTransform.anchoredPosition = var_0_17(arg_10_1[iter_10_1].position.x, -arg_10_1[iter_10_1].position.y)
		end

		for iter_10_2 = 1, #self.__map_name1_list do
			self.__map_name1_list[iter_10_2].rectTransform.parent.anchoredPosition = var_0_17(arg_10_1[iter_10_2].name_position.x, -arg_10_1[iter_10_2].name_position.y)
		end

		for iter_10_3 = 1, #self.__map_score_list do
			self.__map_score_list[iter_10_3].rectTransform.anchoredPosition = var_0_17(arg_10_1[iter_10_3].name_position.x, -arg_10_1[iter_10_3].name_position.y)
		end

		for iter_10_4 = 1, #self.__map_name2_list do
			self.__map_name2_list[iter_10_4].rectTransform.anchoredPosition = var_0_17(arg_10_1[iter_10_4].name2_position.x, -arg_10_1[iter_10_4].name2_position.y)
		end
	end

	function arg_1_0:__init_content(arg_11_1)
		local var_11_0 = 0

		for iter_11_0 = 1, #arg_11_1 do
			var_11_0 = var_11_0 + arg_11_1[iter_11_0].total_score
		end

		for iter_11_1 = 1, #arg_11_1 do
			-- block empty
		end

		self._control.ocean_guide.guidecontent.guidetext.text.text = string.gsub(var_0_1:convert_rich_text(self._active_config.desc), ";", "\n")
		self._control.main.top.title_bg.title_text.text.text = self._active_config.title

		for iter_11_2 = 1, #self.__map_name1_list do
			self.__map_name1_list[iter_11_2].text.text = arg_11_1[iter_11_2].title .. arg_11_1[iter_11_2].sub_title
		end

		for iter_11_3 = 1, #self.__map_name2_list do
			self.__map_name2_list[iter_11_3].text.text = arg_11_1[iter_11_3].sub_title2
		end

		self._control.main.top.point_bg_2.point_num.text.text.text = self._user_point .. "/" .. var_11_0

		local var_11_3
		local var_11_5

		if self.__now_state == 1 then
			var_11_3 = self._big_normal_map_data
			var_11_5 = 9613
		else
			var_11_3 = self._big_hard_map_data
			var_11_5 = 9619
		end

		self.user_point_list = {
			cur_point = {},
			total_score = {}
		}

		for iter_11_4, iter_11_5 in pairs(var_11_3) do
			table.insert(self.user_point_list.total_score, iter_11_5.total_score)
		end

		local var_11_6 = var_0_3:get_ocean_map_point_list()

		for iter_11_6 = var_11_5, var_11_5 + 5 do
			if var_11_6[iter_11_6] then
				table.insert(self.user_point_list.cur_point, var_11_6[iter_11_6])
			else
				table.insert(self.user_point_list.cur_point, 0)
			end
		end

		self.user_box_list = {
			cur_box = {},
			total_treasure = {}
		}

		for iter_11_7, iter_11_8 in pairs(var_11_3) do
			table.insert(self.user_box_list.total_treasure, iter_11_8.total_treasure)
		end

		local var_11_7 = var_0_3:get_ocean_map_box_list()

		for iter_11_9 = var_11_5, var_11_5 + 5 do
			if var_11_7[iter_11_9] then
				table.insert(self.user_box_list.cur_box, var_11_7[iter_11_9])
			else
				table.insert(self.user_box_list.cur_box, 0)
			end
		end

		for iter_11_10 = 1, #self.__map_score_list do
			self.__map_score_list[iter_11_10].point_num.text.text = (self.user_point_list.cur_point[iter_11_10] ~= self.user_point_list.total_score[iter_11_10] and self.user_point_list.cur_point[iter_11_10] or var_0_6("<color=#%s>%s</color>", "A4FF79", self.user_point_list.cur_point[iter_11_10])) .. "/" .. self.user_point_list.total_score[iter_11_10]
			self.__map_score_list[iter_11_10].box_num.text.text = (self.user_box_list.cur_box[iter_11_10] ~= self.user_box_list.total_treasure[iter_11_10] and self.user_box_list.cur_box[iter_11_10] or var_0_6("<color=#%s>%s</color>", "A4FF79", self.user_box_list.cur_box[iter_11_10])) .. "/" .. self.user_box_list.total_treasure[iter_11_10]
		end
	end

	function arg_1_0:__init_map_detail_content(arg_12_1, arg_12_2)
		self._control.ocean_map_detail.main.map_panel.map_image.image.sprite = self:loadSprite(var_0_6(var_0_5.map_path, self._active_config.levels[arg_12_2], self._active_config.levels[arg_12_2]))
		self._control.ocean_map_detail.main.title_bg.title_text.text.text = arg_12_1[arg_12_2].title .. arg_12_1[arg_12_2].sub_title
		self._control.ocean_map_detail.main.right.reward_item.img.image.sprite = self:loadSprite(var_0_6(var_0_5.normal_str, arg_12_1[arg_12_2].award[1].id))

		local var_12_0 = var_0_12.find_object_by_cid(arg_12_1[arg_12_2].award[1].id)

		if var_12_0 then
			self._control.ocean_map_detail.main.right.reward_item.rewardbg.image.sprite = self:loadSprite(var_0_5.equip_quality_frame_s[var_12_0.star])
		end

		self._control.ocean_map_detail.main.right.reward_item.get_icon:SetActive((var_0_3:is_ocean_map_pass(arg_12_1[arg_12_2].map_id)))

		self._current_reward_id = arg_12_1[arg_12_2].award[1].id
		self._control.ocean_map_detail.main.right.point_bg.point_num.text.text = var_0_6("<color=#%s>%s</color>", "0099FF", self.user_point_list.cur_point[arg_12_2]) .. "/" .. arg_12_1[arg_12_2].total_score
		self._control.ocean_map_detail.main.right.point_bg.box_num.text.text = var_0_6("<color=#%s>%s</color>", "0099FF", self.user_box_list.cur_box[arg_12_2]) .. "/" .. arg_12_1[arg_12_2].total_treasure
		self._control.ocean_map_detail.main.right.enter_btn.text.text.text = var_0_6(var_0_1:getNowLang("ui_4th_enter_button_title"), var_0_20.find_object_by_id_start_node_id(arg_12_1[arg_12_2].init_nodes[1], arg_12_1[arg_12_2].init_nodes[1]).flag)
		self._control.ocean_map_detail.main.right.enter_btn.image.sprite = self:loadSprite(var_0_5.init_bg_path.active)

		local var_12_1 = {}

		for iter_12_0, iter_12_1 in pairs(self._normal_node_data) do
			for iter_12_2, iter_12_3 in pairs(iter_12_1) do
				if iter_12_3.next_level_node % 100 ~= 1 and iter_12_3.next_level_node ~= 0 and var_0_3:is_ocean_map_node_pass(iter_12_3.start_node_id, iter_12_3.id) then
					table.insert(var_12_1, iter_12_3.next_level_node)
				end
			end
		end

		local var_12_2 = self._control.ocean_map_detail.main.right.enter_btn_2

		self._control.ocean_map_detail.main.right.enter_btn_2.lock:SetActive(false)

		if #arg_12_1[arg_12_2].init_nodes > 1 then
			local var_12_3 = false
			local var_12_4
			local var_12_5

			table.sort(arg_12_1[arg_12_2].init_nodes)

			if var_0_21.have_data(var_12_1, arg_12_1[arg_12_2].init_nodes[2]) then
				var_12_3 = true
			end

			if not var_12_3 then
				var_12_4 = self:loadSprite(var_0_5.init_bg_path.unlocked)
				var_12_5 = var_0_6(var_0_1:getNowLang("ui_4th_enter_button_title"), var_0_20.find_object_by_id_start_node_id(arg_12_1[arg_12_2].init_nodes[2], arg_12_1[arg_12_2].init_nodes[2]).flag) .. "\n" .. var_0_10.find_object_by_id(arg_12_1[arg_12_2].map_id).nodes_desc[2]
			else
				var_12_4 = self:loadSprite(var_0_5.init_bg_path.unselected)
				var_12_5 = var_0_6(var_0_1:getNowLang("ui_4th_enter_button_title"), var_0_20.find_object_by_id_start_node_id(arg_12_1[arg_12_2].init_nodes[2], arg_12_1[arg_12_2].init_nodes[2]).flag)
			end

			var_12_2.image.sprite = var_12_4
			var_12_2.text.text.text = var_12_5
			var_12_2.button.interactable = var_12_3

			var_12_2.lock:SetActive(var_12_3 == false)
		else
			var_12_2.image.sprite = self:loadSprite(var_0_5.init_bg_path.unlocked)
			var_12_2.text.text.text = "---"
		end

		self._control.ocean_map_detail.main.bottom.desc.text.text = arg_12_1[arg_12_2].tips

		for iter_12_4, iter_12_5 in ipairs(arg_12_1[arg_12_2].boss) do
			local var_12_6, var_12_7 = self:__load_map_fragment_with_pool("ocean_boss_node_obj", self._control.ocean_map_detail.main.map_panel.map_node_root.transform)

			var_12_6:setVisible(true)

			var_12_7.boss_icon.rectTransform.parent.offsetMin = var_0_17(0, 0)
			var_12_7.boss_icon.rectTransform.parent.offsetMax = var_0_17(0, 0)
			var_12_7.boss_icon.rectTransform.anchoredPosition = self:__get_real_node_pos(self._control.ocean_map_detail.main.map_panel.rectTransform.rect.width, self._control.ocean_map_detail.main.map_panel.rectTransform.rect.height, iter_12_5[4], iter_12_5[5])

			local var_12_8 = true
			local var_12_9 = var_12_8 and self:loadSprite(var_0_5.ocean_boss_unknow_icon) or self:loadSprite(var_0_6(var_0_5.ocean_boss_icon, iter_12_5[3]))

			var_12_7.boss_icon.boss_hp_bg:SetActive(not var_12_8)
			var_12_7.boss_icon.boss_hp_bar:SetActive(not var_12_8)

			var_12_7.boss_icon.image.sprite = var_12_9

			var_12_7.boss_icon.image:SetNativeSize()
		end
	end

	function arg_1_0:__init_map_detail_node(arg_13_1, arg_13_2, arg_13_3)
		if arg_13_3 and arg_13_3 == 0 then
			self:__set_node_data_by_map(arg_13_1, arg_13_2, arg_13_3)
		else
			self:__set_node_data_by_map(arg_13_1, arg_13_2, arg_13_3)
		end
	end

	function arg_1_0:__set_mini_map_data(arg_14_1)
		local var_14_0 = self._control.ocean_map_detail.main

		self._control.ocean_map_detail.main.map_panel.map_image.image.sprite = self:loadSprite(string.format(var_0_5.map_path, arg_14_1.id, arg_14_1.id))
		var_14_0.title_bg.title_txt.text.text = arg_14_1.title .. " " .. arg_14_1.sub_title
		var_14_0.boss_panel.boss_bg.image.sprite = self:loadSprite(var_0_6(var_0_5.fearlessness_sea_enemy_bg, arg_14_1.boss_bg))

		local var_14_1 = var_0_3:is_map_pass(arg_14_1.map_id)

		var_14_0.boss_panel.boss_image.image.sprite = not var_14_1 and self:loadSprite(var_0_6(var_0_5.fearlessness_sea_node_boss, arg_14_1.boss_id)) or self:loadSprite(var_0_6(var_0_5.fearlessness_sea_node_boss_b, arg_14_1.boss_id))

		var_14_0.reward_panel.reward_icon.get_icon:SetActive(var_14_1)
		var_14_0.map_panel.pass_icon:SetActive(var_14_1)

		var_14_0.bottom_tips.tips_txt.text.text = var_0_1:convert_rich_text(arg_14_1.tips)

		local var_14_2 = var_0_12.find_object_by_cid(arg_14_1.award[1].id)

		var_14_0.reward_panel.reward_title.text.text = var_0_1:getNowLang("pveeventitemcanget")

		if var_14_2 then
			var_14_0.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(var_0_5.equip_quality_frame_s[var_14_2.star])
			var_14_0.reward_panel.reward_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.equip_icon.equip, var_14_2.pic_id))
		else
			log.print_r(arg_14_1.id .. " not have equip with cid " .. arg_14_1.award[1].id)
		end

		self:__update_boss_hp(arg_14_1)
	end

	function arg_1_0:__update_boss_hp(arg_15_1)
		local var_15_0 = self._control.map_preview.map_bg.boss_panel.boss_hp_black
		local var_15_1 = var_0_3:get_map_list()[arg_15_1.id]
		local var_15_2

		if var_15_1 then
			var_15_2 = var_15_1.hp / arg_15_1.hp or 1
		end

		var_15_0.boss_hp_bar.image.fillAmount = var_15_2
		var_15_0.hp_percent_num.text.text = var_0_6("%0.0f%s", var_15_2 * 100, "%")
	end

	function arg_1_0:__set_node_data_by_map(arg_16_1, arg_16_2, arg_16_3)
		local var_16_0 = arg_16_3 == 0 and self._control.ocean_map_detail.main.map_panel.map_node_root or self._control.ocean_map_detail.main.map_panel.map_node_root_1
		local var_16_1 = self._control.ocean_map_detail.main.map_panel.rectTransform.rect.width
		local var_16_2 = self._control.ocean_map_detail.main.map_panel.rectTransform.rect.height
		local var_16_3 = {}

		for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
			if iter_16_1.node_miss and next(iter_16_1.node_miss) then
				for iter_16_2, iter_16_3 in pairs(iter_16_1.node_miss) do
					var_0_7(var_16_3, {
						hide_start_point = iter_16_1.id,
						hide_end_point = iter_16_2,
						hide_result = iter_16_3
					})
				end
			end
		end

		self:__destroy_seq()

		self._light_seq = {}

		for iter_16_4, iter_16_5 in ipairs(arg_16_1) do
			local var_16_4, var_16_5 = self:__load_map_fragment_with_pool("map_node_obj", var_16_0.transform)

			var_16_4:setVisible(true)

			var_16_5.node_image.rectTransform.parent.offsetMin = var_0_17(0, 0)
			var_16_5.node_image.rectTransform.parent.offsetMax = var_0_17(0, 0)
			var_16_5.node_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_16_1, var_16_2, iter_16_5.position.x, iter_16_5.position.y)

			if iter_16_5.id == iter_16_5.start_node_id then
				local var_16_6 = arg_16_3 == 0 and self._control.ocean_map_detail.main.map_panel.arrow_icon or self._control.ocean_map_detail.main.map_panel.arrow_icon_1

				var_16_6.rectTransform.anchoredPosition = self:__get_real_node_pos(var_16_1, var_16_2, iter_16_5.position.x, iter_16_5.position.y)

				local var_16_7 = self:__get_arrow_pos_offset(iter_16_5.arrow, arg_16_3)

				var_16_6.rectTransform.anchoredPosition = var_0_17(var_16_6.rectTransform.anchoredPosition.x + var_16_7.x, var_16_6.rectTransform.anchoredPosition.y + var_16_7.y)
			end

			self._control.ocean_map_detail.main.map_panel.arrow_icon_1:SetActive(false)

			local var_16_8
			local var_16_9 = 1

			if iter_16_5.node_attribute == var_0_5.map_node_finish_type.init then
				var_16_8 = var_0_5.fight_point.pve_start_l
				var_16_9 = 2
			elseif iter_16_5.node_attribute == var_0_5.map_node_finish_type.boss_finish then
				if var_0_3:is_ocean_map_node_pass(iter_16_5.start_node_id, iter_16_5.id) then
					var_16_8 = var_0_5.fight_point.pve_boss_l
					var_16_9 = 2
				else
					var_16_8 = var_0_5.fight_point.pve_boss
					var_16_9 = 1
				end
			elseif iter_16_5.node_type == var_0_5.map_node_type.reward then
				var_16_8 = var_0_3:is_ocean_map_node_pass(iter_16_5.start_node_id, iter_16_5.id) and var_0_5.fight_point.pve_green or var_0_5.fight_point.pve_white
			elseif iter_16_5.node_type == var_0_5.map_node_type.loss then
				var_16_8 = var_0_3:is_ocean_map_node_pass(iter_16_5.start_node_id, iter_16_5.id) and var_0_5.fight_point.pve_purple or var_0_5.fight_point.pve_white
			elseif iter_16_5.node_type == var_0_5.map_node_type.null then
				var_16_8 = var_0_3:is_ocean_map_node_pass(iter_16_5.start_node_id, iter_16_5.id) and var_0_5.fight_point.pve_blue or var_0_5.fight_point.pve_white
			else
				if var_0_3:is_ocean_map_node_pass(iter_16_5.start_node_id, iter_16_5.id) then
					var_16_8 = var_0_5.fight_point.pve_red
					var_16_9 = 2
				else
					var_16_8 = var_0_5.fight_point.pve_white
					var_16_9 = 1
				end

				var_16_8 = var_0_3:is_ocean_map_node_pass(iter_16_5.start_node_id, iter_16_5.id) and var_0_5.fight_point.pve_red or var_0_5.fight_point.pve_white
			end

			var_16_5.node_image.image.sprite = self:loadSprite(var_16_8)

			var_16_5.node_image.image:SetNativeSize()

			local var_16_10

			if iter_16_5.flag and var_16_9 then
				var_16_10 = var_0_6(var_0_5.fearlessness_sea_node_letter, iter_16_5.flag .. var_16_9)
			end

			local var_16_12

			if iter_16_5.roundabout == 1 then
				var_16_12 = var_0_5.pve_g
			elseif iter_16_5.night_atk == 1 then
				var_16_12 = var_0_5.pve_night_atk_l
			elseif iter_16_5.node_type == 10 then
				var_16_12 = var_0_5.pve_air
			elseif iter_16_5.node_type == 11 then
				var_16_12 = var_0_5.pve_special_boss_l
			end

			local var_16_13 = var_0_3:get_map_list()[iter_16_5.pve_level_id]
			local var_16_14 = {}

			if iter_16_5.node_type == var_0_5.map_node_type.air_attack then
				var_0_7(var_16_14, var_0_5.pve_air)
			end

			if iter_16_5.treasure_icon then
				if iter_16_5.treasure_icon == var_0_5.ocean_map_node_type.point then
					var_0_7(var_16_14, var_0_5.pve_point)
				elseif iter_16_5.treasure_icon == var_0_5.ocean_map_node_type.box then
					var_0_7(var_16_14, var_0_5.pve_box)
				elseif iter_16_5.treasure_icon == var_0_5.ocean_map_node_type.point_and_box then
					var_0_7(var_16_14, var_0_5.pve_point)
					var_0_7(var_16_14, var_0_5.pve_box)
				end
			end

			if iter_16_5.unlock_buy_cid and iter_16_5.unlock_buy_cid[1] then
				var_0_7(var_16_14, var_0_5.pve_buff)
			end

			var_0_3:set_ocean_map_tmp_icon_list(iter_16_4, var_16_14)

			if var_16_12 or #var_16_14 > 0 then
				local var_16_16

				if var_16_12 then
					var_16_16 = var_16_12
				elseif #var_16_14 > 0 then
					var_16_16 = var_16_14[1]
				end

				var_16_5.night_atk_point.image.sprite = self:loadSprite(var_16_16)

				var_16_5.night_atk_point.image:SetNativeSize()
				var_16_5.night_atk_point:SetActive(true)

				var_16_5.night_atk_point.rectTransform.parent.offsetMin = var_0_17(0, 0)
				var_16_5.night_atk_point.rectTransform.parent.offsetMax = var_0_17(0, 0)
				var_16_5.night_atk_point.rectTransform.anchoredPosition = self:__get_real_node_pos(var_16_1, var_16_2, iter_16_5.position.x, iter_16_5.position.y)

				if iter_16_5.night_atk == 1 or iter_16_5.node_type == 10 or iter_16_5.node_type == 11 or #var_16_14 > 0 then
					local var_16_17 = true

					if iter_16_5.node_type == 11 then
						-- block empty
					end

					local var_16_18 = self:autoKillDOTween(var_0_15.Sequence())

					if var_16_17 then
						var_16_18:Append(var_16_5.night_atk_point.image:DOFade(0, 0))

						for iter_16_6, iter_16_7 in pairs(var_16_14) do
							var_16_18:Append(var_16_5.night_atk_point.image:DOFade(0, 0.1):OnStepComplete(function()
								if not self._control.ocean_map_detail:Equals(nil) and self._control.ocean_map_detail.gameObject.activeSelf then
									var_16_5.night_atk_point.image.sprite = self:loadSprite(iter_16_7)
								end
							end))
							var_16_18:Append(var_16_5.night_atk_point.image:DOFade(1, 1))
							var_16_18:Append(var_16_5.night_atk_point.image:DOFade(0, 1))
						end

						var_16_18:SetLoops(-1)
						var_16_18:Play()
					end

					var_0_7(self._light_seq, var_16_18)
				end
			else
				var_16_5.night_atk_point:SetActive(false)
			end

			local var_16_19 = {}

			for iter_16_8, iter_16_9 in pairs(var_16_3) do
				if iter_16_9.hide_start_point == iter_16_5.id then
					for iter_16_10, iter_16_11 in pairs(iter_16_9.hide_result) do
						local var_16_21 = var_0_19.find_object_by_id(tonumber(iter_16_10))

						if var_0_3:is_ocean_map_node_pass(var_16_21.start_node_id, var_16_21.id) then
							for iter_16_12, iter_16_13 in pairs(iter_16_5.next_node) do
								if iter_16_13 == tonumber(iter_16_9.hide_end_point) then
									var_0_7(var_16_19, iter_16_13)
								end
							end
						end
					end
				end
			end

			local var_16_22 = {}
			local var_16_23 = true

			if iter_16_5.node_hide and next(iter_16_5.node_hide) then
				for iter_16_14, iter_16_15 in pairs(iter_16_5.node_hide) do
					local var_16_24 = 1

					for iter_16_16, iter_16_17 in pairs(iter_16_5.next_node) do
						if tonumber(iter_16_14) == iter_16_17 then
							for iter_16_18, iter_16_19 in pairs(iter_16_15) do
								local var_16_25 = var_0_19.find_object_by_id(tonumber(iter_16_19))

								if not var_0_3:is_ocean_map_node_pass(var_16_25.start_node_id, var_16_25.id) then
									var_16_23 = false
								end
							end

							var_16_22 = {
								var_16_23,
								var_16_24
							}
						else
							var_16_24 = var_16_24 + 1
						end
					end
				end
			end

			if iter_16_5.next_node_path ~= "{}" then
				local var_16_26 = 1

				for iter_16_20, iter_16_21 in pairs((var_0_16(iter_16_5.next_node_path))) do
					local var_16_27, var_16_28 = self:__load_map_fragment_with_pool("map_line_obj", var_16_0.transform)

					var_16_27:setVisible(true)

					var_16_28.line_image.rectTransform.parent.offsetMin = var_0_17(0, 0)
					var_16_28.line_image.rectTransform.parent.offsetMax = var_0_17(0, 0)
					var_16_28.line_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_16_1, var_16_2, iter_16_21.x, iter_16_21.y)
					var_16_28.line_image.image.sprite = self:loadSprite((string.format(var_0_5.mapline_path, string.lower(arg_16_2), iter_16_20)))
					var_16_28.line_image.transform.localScale = var_0_18(0.75, 0.75, 1)

					var_16_28.line_image.image:SetNativeSize()
					var_16_28.line_image:SetActive(true)

					if next(var_16_22) and (var_16_22[2] ~= var_16_26 or not var_16_22[1] or true) then
						var_16_26 = var_16_26 + 1
					end

					if next(var_16_19) then
						for iter_16_22, iter_16_23 in pairs(var_16_19) do
							if var_0_6("%s-%s-%s", iter_16_5.pve_level_id, iter_16_5.flag, var_0_19.find_object_by_id(iter_16_23).flag) == iter_16_20 then
								var_16_28.line_image:SetActive(false)
							end
						end
					end
				end
			end

			if #iter_16_5.flag > 0 then
				local var_16_29, var_16_30 = self:__load_map_fragment_with_pool("fearlessness_sea_letter_obj", var_16_0.transform)

				var_16_29:setVisible(true)

				var_16_30.node_letter_image.rectTransform.parent.offsetMin = var_0_17(0, 0)
				var_16_30.node_letter_image.rectTransform.parent.offsetMax = var_0_17(0, 0)
				var_16_30.node_letter_image.rectTransform.anchoredPosition = var_16_5.node_image.rectTransform.anchoredPosition + var_0_17(0, 30)
				var_16_30.node_letter_image.image.sprite = self:loadSprite(var_16_10)
			end
		end
	end

	function arg_1_0.__get_real_node_pos(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
		return var_0_17(arg_18_3 / 1280 * arg_18_1, not arg_18_5 and -1 * arg_18_4 / 720 * arg_18_2 or arg_18_4 / 960 * arg_18_2)
	end

	function arg_1_0:__get_arrow_pos_offset(arg_19_1, arg_19_2)
		local var_19_0 = arg_19_2 == 0 and self._control.ocean_map_detail.main.map_panel.arrow_icon or self._control.ocean_map_detail.main.map_panel.arrow_icon_1

		if arg_19_1 == 270 then
			var_19_0.transform.eulerAngles = var_0_18(0, 0, arg_19_1)

			return var_0_17(0, 0)
		elseif arg_19_1 == 90 then
			var_19_0.transform.eulerAngles = var_0_18(0, 0, arg_19_1)

			return var_0_17(0, 200)
		elseif arg_19_1 == 180 then
			var_19_0.transform.eulerAngles = var_0_18(0, 0, 0)

			return var_0_17(96.5, 89.6)
		elseif arg_19_1 == 0 then
			var_19_0.transform.eulerAngles = var_0_18(0, 0, 180)

			return var_0_17(-97, 87)
		end
	end

	function arg_1_0:__destroy_seq()
		if self._hard_tips_seq and self._hard_tips_seq:IsPlaying() then
			self._hard_tips_seq:Kill()
		end

		for iter_20_0, iter_20_1 in pairs(self._light_seq) do
			if iter_20_1 and iter_20_1:IsPlaying() then
				iter_20_1:Kill()
			end
		end
	end

	function arg_1_0:__kill_all_tween()
		if self._point_seq then
			self._point_seq:Kill()

			self._point_seq = nil
		end
	end

	function arg_1_0:__preload_map_fragment()
		print("__preload_map_fragment")

		self._obj_pool = {}

		for iter_22_0, iter_22_1 in ipairs({
			{
				preload_count = 10,
				preload_obj_name = "fearlessness_sea_enemy_point"
			},
			{
				preload_count = 10,
				preload_obj_name = "map_line_obj"
			},
			{
				preload_count = 10,
				preload_obj_name = "map_node_obj"
			},
			{
				preload_count = 2,
				preload_obj_name = "ocean_boss_node_obj"
			},
			{
				preload_count = 10,
				preload_obj_name = "fearlessness_sea_letter_obj"
			},
			{
				preload_count = 10,
				preload_obj_name = "ocean_map_line_obj"
			}
		}) do
			self._obj_pool[iter_22_1.preload_obj_name] = {}

			for iter_22_2 = 1, iter_22_1.preload_count do
				local var_22_0, var_22_1 = self:loadUIPrefab(iter_22_1.preload_obj_name, self._control.obj_pool_root.transform)

				var_22_0:setVisible(true)

				self._obj_pool[iter_22_1.preload_obj_name][#self._obj_pool[iter_22_1.preload_obj_name] + 1] = {
					using = false,
					prefabObj = var_22_0,
					prefabContorl = var_22_1
				}
			end
		end
	end

	function arg_1_0:__load_map_fragment_with_pool(arg_23_1, arg_23_2)
		local var_23_0 = false
		local var_23_1

		for iter_23_0, iter_23_1 in ipairs(self._obj_pool[arg_23_1]) do
			if iter_23_1.using == false then
				var_23_0 = true
				var_23_1 = self._obj_pool[arg_23_1][iter_23_0]

				break
			end
		end

		if var_23_0 then
			var_23_1.using = true

			var_23_1.prefabObj._panel.transform:SetParent(arg_23_2)

			return var_23_1.prefabObj, var_23_1.prefabContorl
		else
			local var_23_2, var_23_3 = self:loadUIPrefab(arg_23_1, arg_23_2)

			self._obj_pool[arg_23_1][#self._obj_pool[arg_23_1] + 1] = {
				using = true,
				prefabObj = var_23_2,
				prefabContorl = var_23_3
			}

			return var_23_2, var_23_3
		end
	end

	function arg_1_0:__hide_all_mini_map_fragment_to_pool()
		for iter_24_0, iter_24_1 in pairs(self._obj_pool) do
			for iter_24_2, iter_24_3 in ipairs(iter_24_1) do
				if iter_24_3.using and iter_24_0 ~= "ocean_map_line_obj" then
					iter_24_3.prefabObj._panel.transform:SetParent(self._control.obj_pool_root.transform, false)

					iter_24_3.using = false
				end
			end
		end
	end

	function arg_1_0:__destroy_pool()
		if self._obj_pool and #self._obj_pool > 0 then
			for iter_25_0, iter_25_1 in pairs(self._obj_pool) do
				for iter_25_2, iter_25_3 in pairs(iter_25_1) do
					iter_25_3 = nil
				end
			end

			for iter_25_4, iter_25_5 in pairs(self._obj_pool) do
				iter_25_5 = nil
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
		self:destroyChildren("ocean_boss_node_obj")
		self:destroyChildren("fearlessness_sea_letter_obj")
	end

	function arg_1_0:__pass_all_normal_map()
		for iter_26_0, iter_26_1 in pairs(self._active_config.levels) do
			if not var_0_3:is_ocean_map_pass(iter_26_1) then
				return false
			end
		end

		return true
	end

	function arg_1_0.__play_video(arg_27_0, arg_27_1)
		var_0_22.PlayFullScreenMovie(arg_27_1, var_0_25.black, var_0_23.Hidden)
	end

	function arg_1_0:_play_into_se(arg_28_1)
		self:playSE(arg_28_1, false)
	end

	function arg_1_0:__initial_func()
		local var_29_0 = {
			{
				nodetext = "activityinstruction",
				node = self._control.ocean_guide.tip_layer.bg_container.title
			},
			{
				nodetext = "activityinstruction",
				node = self._control.ocean_guide.guidecontent.guidetext
			},
			{
				nodetext = "ui_4th_reward",
				node = self._control.ocean_map_detail.main.right.awardtitle_text
			},
			{
				nodetext = "ui_4th_zhankuang",
				node = self._control.ocean_map_detail.main.right.supplytitle_text
			},
			{
				nodetext = "ui_4th_enter_select",
				node = self._control.ocean_map_detail.main.right.entertitle_text
			},
			{
				nodetext = "ui_4th_prepare",
				node = self._control.ocean_map_detail.main.bottom.fight_prepare_btn.text
			}
		}
		local var_29_1 = {
			{
				state = false,
				node = self._control.ocean_guide
			},
			{
				state = false,
				node = self._control.ocean_map_detail
			},
			{
				state = false,
				node = self._control.main.middle.map._9613
			},
			{
				state = false,
				node = self._control.active_result_bg
			},
			{
				state = false,
				node = self._control.active_hard_bg
			},
			{
				state = false,
				node = self._control.active_bg
			},
			{
				state = false,
				node = self._control.ocean_map_detail.main.map_panel.pass_icon
			},
			{
				state = false,
				node = self._control.main.middle.map_score
			},
			{
				state = false,
				node = self._control.main.bottom.hard_btn
			},
			{
				state = false,
				node = self._control.main.bottom.normal_btn
			},
			{
				state = false,
				node = self._control.shadow
			}
		}
		local var_29_2 = {
			init_language = function(self, arg_30_1)
				self.text.text = var_0_1:getNowLang(arg_30_1)
			end,
			init_active = function(self, arg_31_1)
				self.gameObject:SetActive(arg_31_1)
			end
		}

		for iter_29_0 = 1, #var_29_0 do
			var_29_2.init_language(var_29_0[iter_29_0].node, var_29_0[iter_29_0].nodetext)
		end

		for iter_29_1 = 1, #var_29_1 do
			var_29_2.init_active(var_29_1[iter_29_1].node, var_29_1[iter_29_1].state)
		end
	end

	function arg_1_0:__init_anim()
		self._control.main.top.transform:DOBlendableLocalMoveBy(var_0_18.New(0, -100), 0.3)
		self._control.main.bottom.transform:DOBlendableLocalMoveBy(var_0_18.New(0, 120), 0.3)
	end

	function arg_1_0:__onReset()
		self._control.main.top.rectTransform.anchoredPosition = var_0_18.New(0, 50)
		self._control.main.bottom.rectTransform.anchoredPosition = var_0_18.New(0, -60)

		self._control.ocean_map_detail:SetActive(false)
	end

	function arg_1_0:__get_award_type()
		if self._current_reward_id >= 10000000 then
			if self._current_reward_id % 100 == 21 then
				return var_0_5.reward_type.equipment
			elseif self._current_reward_id % 100 == 11 or self._current_reward_id % 100 == 12 or self._current_reward_id % 100 == 13 then
				return var_0_5.reward_type.ship
			elseif self._current_reward_id % 100 == 61 then
				return var_0_5.reward_type.head_icon
			elseif self._current_reward_id % 100 == 71 then
				return var_0_5.reward_type.furniture
			end
		elseif self._current_reward_id % 100 == 81 then
			return var_0_5.reward_type.cg
		else
			return var_0_5.reward_type.item
		end
	end

	function arg_1_0:__show_ocean_award_detail()
		local var_35_0 = self:__get_award_type()

		if var_35_0 == var_0_5.reward_type.equipment then
			self:__show_equip_mask(true)

			self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

			self._equip_attr._panel.transform:SetParent(self._panel.transform)
			self._equip_attr:show((var_0_12.find_object_by_cid(self._current_reward_id)))
		elseif var_35_0 == var_0_5.reward_type.ship then
			var_0_2:createInstance("ship_detail"):show(var_0_5.enter_ship_detail_type.bootyshop, (var_0_11.find_object_by_cid(self._current_reward_id)))
		elseif var_35_0 == var_0_5.reward_type.item then
			var_0_2:createInstance("specificdetails"):show(self._current_reward_id, var_0_5.enter_icon_detail_type.bootyshop_item)
		elseif var_35_0 == var_0_5.reward_type.cg then
			var_0_2:createInstance("specificdetails"):show(self._current_reward_id, var_0_5.enter_icon_detail_type.bootyshop_cg)

			return
		elseif var_35_0 == var_0_5.reward_type.head_icon then
			return
		end
	end

	function arg_1_0:__show_equip_mask(arg_36_1)
		self._control.equip_mask:SetActive(arg_36_1)

		if self._equip_attr then
			self._equip_attr._panel:SetActive(arg_36_1)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_37_0)
	local var_37_0 = var_0_2:class("ocean_main_map")

	var_37_0._active_id = 22
	var_37_0._is_init = false
	var_37_0._active_config = nil
	var_37_0._big_normal_map_data = {}
	var_37_0._big_hard_map_data = {}
	var_37_0._hard_node_data = {}
	var_37_0._big_hard_map_data = {}
	var_37_0.__map_list = {}
	var_37_0.__map_name_list = {}
	var_37_0.__now_state = nil
	var_37_0.__btn_state = nil
	var_37_0._light_seq = {}
	var_37_0.user_point_list = {}
	var_37_0.user_box_list = {}
	var_37_0._btn_index = 0
	var_37_0._current_reward_id = 0
	var_37_0._equip_attr = nil

	gamecore.extend_obj(var_37_0)

	return var_37_0
end

return var_0_0
