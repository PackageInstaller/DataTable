local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_6 = string.format
local var_0_7 = table.insert
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = UnityEngine.Vector2
local var_0_10 = UnityEngine.Vector3
local var_0_11 = gamecore.util_func
local var_0_12 = gameconfig.fifth_map_node_config
local var_0_13 = gameconfig.pve_fifth_level_config
local var_0_14 = gameconfig.pve_fifth_situations_config
local var_0_16 = lx.json_decode

gamecore.UILoader:define("fifth_preview_map", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)

		self._level_cfg = var_0_3:get_fifth_level_cfg()

		if not self._level_cfg then
			return
		end

		self:__init_panel()
	end

	function arg_1_0:__preload_map_fragment()
		self._obj_pool = {}

		for iter_3_0, iter_3_1 in ipairs({
			{
				preload_count = 15,
				preload_obj_name = "map_line_obj"
			},
			{
				preload_count = 15,
				preload_obj_name = "map_node_obj"
			},
			{
				preload_count = 15,
				preload_obj_name = "map_node_letter_obj"
			},
			{
				preload_count = 5,
				preload_obj_name = "map_node_flag"
			},
			{
				preload_count = 4,
				preload_obj_name = "fifth_boss_icon"
			}
		}) do
			self._obj_pool[iter_3_1.preload_obj_name] = {}

			for iter_3_2 = 1, iter_3_1.preload_count do
				local var_3_0, var_3_1 = self:loadUIPrefab(iter_3_1.preload_obj_name, self._control.obj_pool_root.transform)

				var_3_0:setVisible(true)

				self._obj_pool[iter_3_1.preload_obj_name][#self._obj_pool[iter_3_1.preload_obj_name] + 1] = {
					using = false,
					prefabObj = var_3_0,
					prefabContorl = var_3_1
				}
			end
		end
	end

	function arg_1_0:__load_map_fragment_with_pool(arg_4_1, arg_4_2)
		local var_4_0 = false
		local var_4_1

		for iter_4_0, iter_4_1 in ipairs(self._obj_pool[arg_4_1]) do
			if iter_4_1.using == false then
				var_4_0 = true
				var_4_1 = self._obj_pool[arg_4_1][iter_4_0]

				break
			end
		end

		if var_4_0 then
			var_4_1.using = true

			var_4_1.prefabObj._panel.transform:SetParent(arg_4_2)
			var_4_1.prefabObj:setVisible(true)

			return var_4_1.prefabObj, var_4_1.prefabContorl
		else
			local var_4_2, var_4_3 = self:loadUIPrefab(arg_4_1, arg_4_2)

			self._obj_pool[arg_4_1][#self._obj_pool[arg_4_1] + 1] = {
				using = true,
				prefabObj = var_4_2,
				prefabContorl = var_4_3
			}

			var_4_2:setVisible(true)

			return var_4_2, var_4_3
		end
	end

	function arg_1_0:__hide_all_map_fragment_to_pool()
		self:__stop_node_shining()

		for iter_5_0, iter_5_1 in pairs(self._obj_pool) do
			for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
				if iter_5_3.using then
					if iter_5_0 == "map_node_flag" then
						iter_5_3.prefabContorl.flag_image.is_start = false

						iter_5_3.prefabContorl.flag_image.uITweenSequence:Kill()
					elseif iter_5_0 == "map_node_obj" then
						iter_5_3.prefabContorl.night_atk_point:SetActive(false)
					end

					iter_5_3.prefabObj._panel.transform:SetParent(self._control.obj_pool_root.transform)

					iter_5_3.using = false
				end
			end
		end
	end

	function arg_1_0:__get_node_data_by_map_id()
		local var_6_0 = {}
		local var_6_1, var_6_2 = var_0_12.get_sequence()

		for iter_6_0, iter_6_1 in pairs(var_6_1) do
			if tonumber(iter_6_1.pve_level_id) == self._map_id then
				var_6_0[#var_6_0 + 1] = iter_6_1
			end
		end

		return var_6_0
	end

	function arg_1_0:__select_hide_node_list()
		local var_7_0 = {}
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in ipairs(self._level_cfg.hiddens) do
			if not iter_7_1[1] or not iter_7_1[2] or not iter_7_1[3] then
				return
			end

			local var_7_2 = var_0_12.find_object_by_id(iter_7_1[2]).flag

			if iter_7_1[3] > self._cur_stationed_num then
				if iter_7_1[1] == 0 then
					var_0_7(var_7_1, iter_7_1[2], true)

					for iter_7_2, iter_7_3 in pairs(self._map_node_data) do
						for iter_7_4, iter_7_5 in ipairs(iter_7_3.next_node) do
							if iter_7_5 == iter_7_1[2] then
								local var_7_3 = var_0_12.find_object_by_id(iter_7_3.id).flag

								if not var_7_3 or var_7_3 == "" then
									var_7_3 = 0
								end

								var_7_0[var_0_6("%s-%s-%s", self._map_id, var_7_3, var_7_2)] = true

								break
							end
						end
					end
				else
					local var_7_4 = var_0_12.find_object_by_id(iter_7_1[1]).flag

					if not var_7_4 or var_7_4 == "" then
						var_7_4 = 0
					end

					var_7_0[var_0_6("%s-%s-%s", self._map_id, var_7_4, var_7_2)] = true
				end
			end
		end

		var_0_3:set_fifth_hide_node(var_7_1)
		var_0_3:set_fifth_hide_route(var_7_0)

		return var_7_1, var_7_0
	end

	function arg_1_0.__get_real_node_pos(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		return var_0_9(arg_8_3 / 1280 * arg_8_1, -1 * arg_8_4 / 960 * arg_8_2)
	end

	function arg_1_0.__play_seq(arg_9_0, arg_9_1)
		if arg_9_1.is_start then
			var_0_4:play_in_out_animation(arg_9_1.uITweenSequence, true, function()
				arg_9_0:__reverse_seq(arg_9_1)
			end)
		end
	end

	function arg_1_0.__reverse_seq(arg_11_0, arg_11_1)
		if arg_11_1.is_start then
			var_0_4:play_in_out_animation(arg_11_1.uITweenSequence, false, function()
				arg_11_0:__play_seq(arg_11_1)
			end)
		end
	end

	function arg_1_0:__set_map_node()
		local var_13_0 = self._control.main.content.map.map_root.rectTransform
		local var_13_1 = self._control.main.content.map.map_root.rectTransform.rect.width
		local var_13_2 = self._control.main.content.map.map_root.rectTransform.rect.height
		local var_13_3, var_13_4 = self:__select_hide_node_list()

		self._do_shining_obj_list = {}

		for iter_13_0, iter_13_1 in ipairs(self._map_node_data) do
			if not var_13_3[iter_13_1.id] then
				local var_13_5, var_13_6 = self:__load_map_fragment_with_pool("map_node_obj", var_13_0)

				var_13_5:setVisible(true)

				var_13_6.node_image.rectTransform.parent.offsetMin = var_0_9(0, 0)
				var_13_6.node_image.rectTransform.parent.offsetMax = var_0_9(0, 0)

				local var_13_7 = self:__get_real_node_pos(var_13_1, var_13_2, iter_13_1.position.x, iter_13_1.position.y)

				var_13_6.node_image.rectTransform.anchoredPosition = var_13_7
				var_13_6.node_image.rectTransform.localScale = var_0_10(0.75, 0.75, 0.75)

				if iter_13_1.score ~= 0 and not self._level_cfg.is_main then
					local var_13_8, var_13_9 = self:__load_map_fragment_with_pool("map_node_flag", var_13_0)

					var_13_8:setVisible(true)

					var_13_9.flag_image.rectTransform.parent.offsetMin = var_0_9(0, 0)
					var_13_9.flag_image.rectTransform.parent.offsetMax = var_0_9(0, 0)
					var_13_9.flag_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_13_1, var_13_2, iter_13_1.position.x, iter_13_1.position.y)
					var_13_9.flag_image.image.sprite = self:loadSprite((var_0_3:is_already_get_score(iter_13_1.id) or nil) and var_0_4.fifth_event_const.joy_flag_gray)

					var_13_9.flag_image.image:SetNativeSize()

					var_13_9.flag_image.is_start = true

					self:__play_seq(var_13_9.flag_image)
				end

				local var_13_11
				local var_13_12
				local var_13_13

				if iter_13_1.node_attribute == var_0_4.map_node_finish_type.init then
					var_13_11 = var_0_4.fight_point.pve_start_l
				elseif iter_13_1.node_attribute == var_0_4.map_node_finish_type.boss_finish then
					var_13_11 = self._level_cfg.type == self._main_node_type.son and (var_0_3:is_map_node_pass(iter_13_1.pve_level_id, iter_13_1.id) and var_0_4.fight_point.pve_small_boss_l or var_0_4.fight_point.pve_small_boss) or var_0_3:is_map_node_pass(iter_13_1.pve_level_id, iter_13_1.id) and var_0_4.fight_point.pve_boss_l or var_0_4.fight_point.pve_boss

					if self._level_cfg.is_main then
						local var_13_15 = var_0_3:get_fifth_boss_info(iter_13_1.id)

						if var_13_15 then
							var_13_12, var_13_13 = self:__load_map_fragment_with_pool("fifth_boss_icon", var_13_0)
							var_13_13.obj.icon.image.sprite = self:loadSprite(var_0_6(var_0_4.fifth_event_const.main.boss_icon, iter_13_1.id))

							local var_13_16 = var_13_15.hp / var_13_15.max_hp

							if var_13_15.hp / var_13_15.max_hp == 0 then
								var_13_13.obj.icon_dead.image.sprite = self:loadSprite(var_0_6(var_0_4.fifth_event_const.main.boss_icon, iter_13_1.id))

								var_13_13.obj.icon.gameObject:SetActive(false)
							else
								var_13_13.obj.icon.gameObject:SetActive(true)
							end

							var_13_13.obj.hp.image.fillAmount = var_13_16
						end
					end
				else
					var_13_11 = iter_13_1.node_type == var_0_4.map_node_type.reward and (var_0_3:is_map_node_pass(iter_13_1.pve_level_id, iter_13_1.id) and var_0_4.fight_point.pve_green or var_0_4.fight_point.pve_white) or iter_13_1.node_type == var_0_4.map_node_type.loss and (var_0_3:is_map_node_pass(iter_13_1.pve_level_id, iter_13_1.id) and var_0_4.fight_point.pve_purple or var_0_4.fight_point.pve_white) or iter_13_1.node_type == var_0_4.map_node_type.null and (var_0_3:is_map_node_pass(iter_13_1.pve_level_id, iter_13_1.id) and var_0_4.fight_point.pve_blue or var_0_4.fight_point.pve_white) or var_0_3:is_map_node_pass(iter_13_1.pve_level_id, iter_13_1.id) and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
				end

				var_13_6.node_image.image.sprite = self:loadSprite(var_13_11)

				var_13_6.node_image.image:SetNativeSize()

				local var_13_17 = false
				local var_13_18

				if iter_13_1.roundabout == 1 then
					var_13_18 = var_0_4.pve_g
				elseif iter_13_1.night_atk == 1 then
					var_13_18 = var_0_4.pve_night_atk_l
					var_13_17 = true
				elseif iter_13_1.node_type == 10 then
					var_13_18 = var_0_4.pve_air
					var_13_17 = true
				elseif iter_13_1.node_type == 11 then
					var_13_18 = var_0_4.pve_special_boss_l
					var_13_17 = true
				end

				if var_13_12 and var_13_13 then
					local var_13_19

					if iter_13_1.id == self._level_cfg.boss_id then
						var_13_19 = self._level_cfg.boss_avatar_position[1]
					elseif iter_13_1.id == self._level_cfg.boss_id2 then
						var_13_19 = self._level_cfg.boss_avatar_position[2]
					end

					if var_13_19 then
						var_13_13.obj.rectTransform.parent.offsetMin = var_0_9(0, 0)
						var_13_13.obj.rectTransform.parent.offsetMax = var_0_9(0, 0)
						var_13_13.obj.rectTransform.anchoredPosition = self:__get_real_node_pos(var_13_1, var_13_2, var_13_19.x, var_13_19.y)
					end
				end

				if var_13_18 then
					var_13_6.night_atk_point.image.sprite = self:loadSprite(var_13_18)
					var_13_6.night_atk_point.rectTransform.anchoredPosition = var_13_7

					var_13_6.night_atk_point:SetActive(true)

					if var_13_17 then
						var_0_7(self._do_shining_obj_list, var_13_6.night_atk_point)
					end
				end

				if iter_13_1.next_node_path ~= "{}" then
					for iter_13_2, iter_13_3 in pairs((var_0_16(iter_13_1.next_node_path))) do
						if not var_13_4[iter_13_2] then
							local var_13_20, var_13_21 = self:__load_map_fragment_with_pool("map_line_obj", var_13_0)

							var_13_20:setVisible(true)

							var_13_21.line_image.rectTransform.parent.offsetMin = var_0_9(0, 0)
							var_13_21.line_image.rectTransform.parent.offsetMax = var_0_9(0, 0)
							var_13_21.line_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_13_1, var_13_2, iter_13_3.x, iter_13_3.y)
							var_13_21.line_image.rectTransform.localScale = var_0_10(0.75, 0.75, 0.75)
							var_13_21.line_image.image.sprite = self:loadSprite((var_0_6(var_0_4.mapline_path, string.sub(iter_13_2, 1, #iter_13_2 - 4), iter_13_2)))

							var_13_21.line_image.image:SetNativeSize()
							var_13_21.line_image:SetActive(true)
						end
					end
				end

				if #iter_13_1.flag > 0 then
					local var_13_22, var_13_23 = self:__load_map_fragment_with_pool("map_node_letter_obj", var_13_0)

					var_13_22:setVisible(true)

					var_13_23.node_letter_text.rectTransform.parent.offsetMin = var_0_9(0, 0)
					var_13_23.node_letter_text.rectTransform.parent.offsetMax = var_0_9(0, 0)
					var_13_23.node_letter_text.rectTransform.sizeDelta = var_0_9(50, 70)
					var_13_23.node_letter_text.rectTransform.anchoredPosition = var_13_6.node_image.rectTransform.anchoredPosition + var_0_9(11, 31)
					var_13_23.node_letter_text.text.text = iter_13_1.flag
					var_13_23.node_letter_text.text.fontSize = 35
					var_13_23.node_letter_text.text.fontStyle = UnityEngine.FontStyle.Italic
				end
			end
		end

		self:__do_node_shining()
	end

	function arg_1_0:__do_node_shining()
		if not self._do_shining_obj_list then
			return
		end

		local var_14_0 = self:autoKillDOTween(var_0_8.Sequence())

		for iter_14_0, iter_14_1 in ipairs(self._do_shining_obj_list) do
			var_14_0:Insert(2, iter_14_1.image:DOFade(0, 1):SetAutoKill(true))
			var_14_0:Insert(3, iter_14_1.image:DOFade(1, 1):SetAutoKill(true))
			var_14_0:SetLoops(-1)
		end

		var_14_0:Play()

		self._do_shining_tween_seq = var_14_0
	end

	function arg_1_0:__show_side(arg_15_1)
		for iter_15_0, iter_15_1 in pairs(self._side_list) do
			self:__set_control_layer(iter_15_1, false)
		end

		self:__set_control_layer(self._side_list[arg_15_1], true)

		return self._side_list[arg_15_1]
	end

	function arg_1_0.__set_control_layer(arg_16_0, arg_16_1, arg_16_2)
		arg_16_1.canvasGroup.alpha = arg_16_2 and 1 or 0
		arg_16_1.canvasGroup.interactable = arg_16_2
		arg_16_1.canvasGroup.blocksRaycasts = arg_16_2
	end

	function arg_1_0:__init_language()
		self._control.main.detail_layer.bg.bg_top.title.text.text = var_0_1:getNowLang("ui_5th_enter_detail_view")
		self._control.main.content.joy_side.title.text.text = var_0_1:getNowLang("ui_5th_level_can_get")
		self._control.main.content.joy_side.tip_txt.text.text = var_0_1:getNowLang("ui_1145141919810")
		self._control.main.content.main_side2.title.text.text = var_0_1:getNowLang("ui_5th_level_info")
		self._control.main.content.main_side1.title.text.text = var_0_1:getNowLang("ui_5th_level_info")
		self._control.main.content.main_side1.detail_btn.txt.text.text = var_0_1:getNowLang("pvpdetailbtn")
	end

	function arg_1_0:__init_constant()
		self._side_list = {
			self._control.main.content.main_side1,
			self._control.main.content.main_side2,
			self._control.main.content.joy_side
		}
		self._main_node_type = {
			son = 1,
			father = 2
		}
		self._bg_seq = self._control.main.detail_layer.bg.uITweenSequence
	end

	function arg_1_0:__init_active()
		self:__set_control_layer(self._control.main.detail_layer, false)
	end

	function arg_1_0:__set_side_info()
		if not self._level_cfg.is_main then
			local var_20_0 = self:__show_side(3)

			var_20_0.num1.text.text = tostring(self._level_cfg.already_get_score)
			var_20_0.num1.num.text.text = "/" .. tostring(self._level_cfg.total_score)
			var_20_0.num2.text.text = tostring(self._level_cfg.love)
			var_20_0.num2.num.text.text = "/" .. tostring(100)
			var_20_0.progress_bg.progress.image.fillAmount = self._level_cfg.love / 100
			self._control.main.content.boss_bg.icon.image.sprite = self:loadSprite(var_0_6(var_0_4.fearlessness_sea_node_boss_b, self._level_cfg.boss_id))

			self._control.main.content.boss_bg.boss_hp.gameObject:SetActive(false)
		elseif self._level_cfg.type == self._main_node_type.son then
			local var_20_1 = self:__show_side(2)
			local var_20_2 = var_0_14.find_object_by_id(self._level_cfg.situations[1])

			self._control.main.content.main_side2.buff.text.text = var_20_2.title
			self._control.main.content.main_side2.desc.text.text = var_0_11.convert_rich_text(var_20_2.desc)
			self._control.main.content.boss_bg.icon.image.sprite = self:loadSprite(var_0_6(var_0_4.fearlessness_sea_node_boss, self._level_cfg.boss_id))

			self._control.main.content.boss_bg.boss_hp.gameObject:SetActive(false)
		else
			local var_20_3 = self:__show_side(1).buff.transform
			local var_20_4 = var_20_3:GetChild(0).gameObject
			local var_20_5 = self._control.main.detail_layer.bg.content.transform:GetChild(0).gameObject

			for iter_20_0 = var_20_3.childCount, #self._level_cfg.situations - 1 do
				UnityEngine.Object.Instantiate(var_20_4, var_20_3, false)
				UnityEngine.Object.Instantiate(var_20_5, self._control.main.detail_layer.bg.content.transform, false)
			end

			local var_20_6 = {}
			local var_20_7 = 0

			for iter_20_1, iter_20_2 in ipairs(self._level_cfg.branch_levels) do
				if var_0_3:get_fifth_station(iter_20_2) then
					local var_20_8 = var_0_13.find_object_by_id(iter_20_2)

					if var_20_8 and var_20_8.situations then
						for iter_20_3, iter_20_4 in ipairs(var_20_8.situations) do
							var_20_6[iter_20_4] = true
							var_20_7 = var_20_7 + 1
						end
					end
				end
			end

			local var_20_9 = var_0_3:get_fifth_map_data(self._map_id).exclude

			if var_20_9 then
				for iter_20_5, iter_20_6 in pairs(var_20_9) do
					var_20_6[iter_20_6] = true
				end
			end

			self._cur_stationed_num = var_20_7

			local var_20_10 = {}

			for iter_20_7, iter_20_8 in pairs(self._level_cfg.situations) do
				local var_20_11 = var_0_14.find_object_by_id(iter_20_8)
				local var_20_12 = var_20_3:GetChild(iter_20_7 - 1)
				local var_20_13 = self._control.main.detail_layer.bg.content.transform:GetChild(iter_20_7 - 1)

				var_20_12:Find("txt"):GetComponent("Text").text = var_20_11.title

				local var_20_14 = var_20_13:Find("condition"):GetComponent("Text")

				if var_20_6[iter_20_8] then
					var_20_12:Find("ban"):GetComponent("Image").color = UnityEngine.Color(1, 1, 1, 1)
					var_20_14.text = var_0_11.convert_rich_text(var_0_1:getNowLang("ui_5th_sublevel_guard"))
					var_20_13:Find("arrow"):GetComponent("Image").color = UnityEngine.Color(0.1568627450980392, 0.5882352941176471, 1, 1)
				else
					var_0_7(var_20_10, iter_20_8)

					var_20_14.text = var_0_11.convert_rich_text(var_20_11.unlock_condition)
				end

				var_20_13:Find("suppress_bg/txt"):GetComponent("Text").text = var_20_11.title
				var_20_13:Find("desc"):GetComponent("Text").text = var_0_11.convert_rich_text(var_20_11.desc)
			end

			var_0_3:set_fifth_buff(self._level_cfg.id, var_20_10)

			local var_20_15
			local var_20_16 = var_0_3:get_fifth_cur_boss(self._map_id)

			if var_20_16.hp == 0 then
				self._control.main.content.boss_bg.boss_hp.gameObject:SetActive(false)

				var_20_15 = self:loadSprite(var_0_6(var_0_4.fearlessness_sea_big_boss_b, var_20_16.id))
			else
				self._control.main.content.boss_bg.boss_hp.gameObject:SetActive(true)

				var_20_15 = self:loadSprite(var_0_6(var_0_4.fearlessness_sea_node_boss, var_20_16.id))
			end

			self._control.main.content.boss_bg.boss_hp.hp.image.fillAmount = var_20_16.hp / var_20_16.max_hp
			self._control.main.content.boss_bg.boss_hp.txt.text.text = var_0_6("%.1f", var_20_16.hp / var_20_16.max_hp * 100) .. " %"
			self._control.main.content.boss_bg.icon.image.sprite = var_20_15
		end

		self._control.main.content.boss_bg.image.sprite = self:loadSprite(var_0_6(var_0_4.fearlessness_sea_enemy_bg, self._level_cfg.boss_bg))

		self._control.main.content.boss_bg.icon.image:SetNativeSize()
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
			self:__init_active()
			self:__preload_map_fragment()
		end

		self._map_id = self._level_cfg.map_id

		local var_21_0 = self._level_cfg.main_pve_level_id

		self._concerto_station = var_0_3:get_fifth_station(self._map_id)
		self._control.main.content.fight_btn.txt.text.text = self._concerto_station and var_0_1:getNowLang("lookfleet") or var_0_1:getNowLang("ui_4th_prepare")
		self._control.main.content.title_bg.title.text.text = var_0_6("%s %s", self._level_cfg.title, self._level_cfg.sub_title)

		if var_21_0 == 0 then
			if self._level_cfg.type == var_0_4.fifth_event_const.main_map_node_type.main_node then
				self._control.main.content.tip_txt.text.text = var_0_11.convert_rich_text(self._level_cfg.tips)
			end
		else
			local var_21_2 = var_0_13.find_object_by_id(var_21_0)
			local var_21_3 = 0

			for iter_21_0, iter_21_1 in ipairs(var_21_2.branch_levels) do
				if var_0_3:get_fifth_station(iter_21_1) then
					var_21_3 = var_21_3 + 1
				end
			end

			self._control.main.content.tip_txt.text.text = var_0_6(var_0_11.convert_rich_text(self._level_cfg.tips), var_21_3, #var_21_2.branch_levels)
		end

		self._control.main.content.map.map_bg.image.sprite = self:loadSprite(var_0_6(var_0_4.map_path, self._level_cfg.map_id, self._level_cfg.map_id))
		self._map_node_data = self:__get_node_data_by_map_id()

		self:__set_side_info()
		self:__set_map_node()

		self._is_already_init = true
	end

	function arg_1_0:__stop_node_shining()
		if self._do_shining_tween_seq then
			self._do_shining_tween_seq:Kill()

			self._do_shining_tween_seq = nil
		end

		self._do_shining_obj_list = {}
	end

	function arg_1_0:__destroy_panel()
		self:__hide_all_map_fragment_to_pool()
		self:setVisible(false)
	end

	function arg_1_0:__onReset()
		self._concerto_station = false

		self:__hide_all_map_fragment_to_pool()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_25_0)
	local var_25_0 = var_0_2:class("fifth_preview_map")

	var_25_0._is_already_init = false
	var_25_0._obj_pool = {}
	var_25_0._level_cfg = nil
	var_25_0._concerto_station = false

	gamecore.extend_obj(var_25_0)

	return var_25_0
end

return var_0_0
