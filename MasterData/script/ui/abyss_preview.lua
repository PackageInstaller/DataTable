local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.abyss_map_config
local var_0_6 = gameconfig.abyss_map_node_config
local var_0_7 = table.insert
local var_0_8 = string.format
local var_0_9 = UnityEngine.Object.Instantiate
local var_0_10 = gameconfig.ship_pve_active_config
local var_0_11 = Vector3
local var_0_12 = Vector2
local var_0_13 = gameconfig.equip_config
local var_0_14 = gameconfig.ship_config
local var_0_15 = UnityEngine.Color
local var_0_16 = UnityEngine.Color(0.2, 0.5686274509803921, 0.8666666666666667)
local var_0_17 = UnityEngine.Color(0.6431372549019608, 0.12941176470588237, 0.12941176470588237)
local var_0_18 = DG.Tweening.DOTween
local var_0_19 = UnityEngine.UI.Dropdown.OptionData
local var_0_20 = string.gsub
local var_0_21 = math.floor
local var_0_22 = gamecore.prompt
local var_0_23 = next
local var_0_24 = gamecore.util_func

gamecore.UILoader:define("abyss_preview", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self._chapter_cfg = arg_2_1

		var_0_3:set_abyss_now_chapter_cfg(arg_2_1)

		self._is_select_team = var_0_4.abyss_const.abyss_enter_preview_type.select_team == arg_2_2

		if not self._is_select_team then
			var_0_3:is_abyss_fighting(false)
			var_0_3:set_abyss_fight_cam(nil)
			var_0_3:reset_abyss_enter_repair_time()
			var_0_3:reset_abyss_fight_start_point()
			var_0_3:set_abyss_ship_move_callback(nil)
			var_0_3:reset_fight_info_pass()
		end

		self._show_level_id = arg_2_3
		self._now_page = arg_2_4

		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		if not self._chapter_cfg then
			return
		end

		if not self._init_comp then
			local var_3_0
			local var_3_1

			if self._is_select_team and self._show_level_id then
				var_3_0 = var_0_5.find_object_by_id(self._show_level_id)
			else
				var_3_1 = var_0_5.find_object_by_id(self._chapter_cfg.level_id_2)
				var_3_0 = var_0_5.find_object_by_id(self._chapter_cfg.level_id_1)
			end

			self:__init_language()

			self._level_cfg = {}
			self._level_cfg[1] = var_3_0
			self._level_cfg[2] = var_3_1

			self:__load_level_config()
			self:__init_page_data()
			self:__init_bottom()

			self._init_comp = true
		end

		self:__update_page()
		self:__set_ui_layout()
		self:__update_boss()
	end

	function arg_1_0:__update_boss()
		if not self._chapter_cfg then
			return
		end

		local var_4_0 = self._chapter_cfg
		local var_4_1 = 0

		if self._chapter_cfg.type == var_0_4.abyss_chapter_type.boss then
			local var_4_2 = var_0_3:get_abyss_world_boss_info(4)
			local var_4_4 = var_4_0["hp" .. (var_4_2 and var_0_23(var_4_2) and (var_4_2.step or 1) or 1)] or 0

			var_4_1 = var_4_2 and (var_4_4 == 0 and 0 or var_0_21(var_4_2.hp / var_4_4 * 100)) or 1

			if var_4_2 and var_0_23(var_4_2) then
				if var_4_1 > 100 then
					var_4_1 = 100
				elseif var_4_1 == 0 and var_4_2.hp > 0 then
					var_4_1 = 1
				end
			else
				var_4_1 = 1
			end
		else
			var_4_1 = var_0_3:check_chapter_pass(var_4_0.chapter_id) and 0 or 100
		end

		self._control.bottom.boss_frame.hp.rest.image.fillAmount = var_4_1 / 100
		self._control.bottom.boss_frame.hp_perc.text.text = var_0_21(var_4_1) .. "%"
	end

	function arg_1_0:get_now_page()
		log.print_r(debug.traceback(), "[Warning]This method is obsoleted")

		return self._control.middle.page_view.latticeScrollRect.m_ShowItemIndex
	end

	function arg_1_0:__init_bottom()
		if self._is_select_team then
			return
		end

		local var_6_0 = var_0_3:get_abyss_world_boss_info(self._chapter_cfg.chapter_id)

		self._control.bottom.boss_frame.pic.image.sprite = self:loadSprite((var_0_8(var_0_4.abyss_const.abyss_boss_spine, (self._chapter_cfg.type == var_0_4.abyss_chapter_type.boss or nil) and (self._chapter_cfg.chapter_id .. "_" .. ((var_6_0 or nil) and (var_6_0.step or 1)) or self._chapter_cfg.chapter_id))))

		local function var_6_3(arg_7_0, arg_7_1)
			arg_7_0.transform:Find("pic"):GetComponent("Image").sprite = self:loadSprite(var_0_8(var_0_4.normal_str, arg_7_1))

			local var_7_0 = arg_7_0:GetComponent("Button")

			var_7_0.onClick:RemoveAllListeners()
			var_7_0.onClick:AddListener(function()
				local var_8_0

				if arg_7_1 >= 10000000 then
					if arg_7_1 % 100 == 21 then
						local var_8_1 = var_0_2:createInstance("equip_attr")

						if var_8_1 then
							var_8_1:show((var_0_13.find_object_by_cid(arg_7_1)))
						end

						self:__active_canvas(self._control.shadow.canvasGroup, true)

						var_8_0 = true
					elseif arg_7_1 % 100 == 11 or arg_7_1 % 100 == 12 or arg_7_1 % 100 == 13 then
						local var_8_2 = var_0_2:createInstance("ship_detail")

						if var_8_2 then
							var_8_2:show(var_0_4.enter_ship_detail_type.bootyshop, (var_0_14.find_object_by_cid(arg_7_1)))
						end

						var_8_0 = true
					end
				end

				if not var_8_0 then
					local var_8_3 = var_0_2:createInstance("specificdetails")

					if var_8_3 then
						var_8_3:show(arg_7_1, var_0_4.enter_icon_detail_type.bootyshop_item)
					end
				end
			end)
		end

		if self._chapter_cfg.awardview then
			for iter_6_0, iter_6_1 in ipairs(self._chapter_cfg.awardview) do
				if iter_6_0 == 1 then
					var_6_3(self._control.bottom.item_preview.list.content.item.gameObject, iter_6_1)
				else
					local var_6_4 = var_0_9(self._control.bottom.item_preview.list.content.item.gameObject)

					var_0_7(self._collect_rubbish, var_6_4)
					var_6_4.transform:SetParent(self._control.bottom.item_preview.list.content.transform)

					var_6_4.transform.localScale = var_0_11(1, 1, 1)

					var_6_3(var_6_4, iter_6_1)
				end
			end

			self._control.bottom.item_preview.list.scrollRect.horizontal = #self._chapter_cfg.awardview > 6
		end

		self:__show_boss_remain_time()
	end

	function arg_1_0:__init_page_data()
		self._level_data = {}
		self._map_dic = {}
		self._collect_rubbish = {}
		self._flash_obj_list = {}

		for iter_9_0 = 1, 2 do
			if self._level_cfg[iter_9_0] then
				local var_9_0 = self._level_cfg[iter_9_0]
				local var_9_1 = {
					title = self._level_cfg[iter_9_0].title,
					title2 = self._level_cfg[iter_9_0].sub_title
				}
				local var_9_2 = self:loadSprite(var_0_8(var_0_4.abyss_const.abyss_fight_bg, self._level_cfg[iter_9_0].id))
				local var_9_3

				if app:isPC() then
					var_9_3 = self._control.bottom.team_select.gm["gm_" .. iter_9_0].dropdown
				end

				local var_9_4 = var_0_3:get_account_id()

				if var_9_4 == 16329 or var_9_4 == 16541 or var_9_4 == 17990 or var_9_4 == 16308 then
					self._control.input_map_node.text.text = "0"

					self._control.input_map_node:SetActive(true)
				end

				self:__load_map(var_9_0.id, self._control.middle.page_view.content["page" .. iter_9_0].root.transform, iter_9_0, var_9_3)

				var_9_1.page = self._control.middle.page_view.content["page" .. iter_9_0]
				var_9_1.page.image.sprite = var_9_2
				self._level_data[iter_9_0] = var_9_1
			end
		end

		self._control.middle.page_view.latticeScrollRect:InitItemWidth(self._control.middle.page_view.content.page1.gameObject)

		for iter_9_1, iter_9_2 in pairs(self._flash_obj_list) do
			local var_9_5 = self:autoKillDOTween(var_0_18.Sequence())

			var_9_5:Append(iter_9_2.control.image:DOFade(0, 0))

			for iter_9_3, iter_9_4 in pairs(iter_9_2.path) do
				var_9_5:Append(iter_9_2.control.image:DOFade(0, 0.1):OnStepComplete(function()
					if not iter_9_2.control:Equals(nil) and iter_9_2.control.gameObject.activeSelf then
						iter_9_2.control.image.sprite = self:loadSprite(iter_9_4)
					end
				end))
				var_9_5:Append(iter_9_2.control.image:DOFade(1, 1))
				var_9_5:Append(iter_9_2.control.image:DOFade(0, 1))
				var_9_5:SetLoops(-1)
				var_9_5:Play()
			end

			var_0_7(self._flash_tween_seq, var_9_5)
		end
	end

	function arg_1_0:__update_page()
		self._now_page = self._now_page or 0
		self._page_num = self._is_select_team and 1 or 2

		self._control.middle.page_view.latticeScrollRect:SetContentWidthWithMapCount(self._page_num)

		local var_11_0 = self._now_page + 1

		for iter_11_0, iter_11_1 in ipairs(self._level_data) do
			if self._level_data and self._page_num == 1 then
				if iter_11_0 == var_11_0 then
					iter_11_1.page.gameObject:SetActive(true)
				else
					iter_11_1.page.gameObject:SetActive(false)
				end
			elseif self._level_data and self._page_num == 2 then
				iter_11_1.page.gameObject:SetActive(true)
			end

			if iter_11_0 == var_11_0 then
				self._control.top.title.text.text = var_0_8("%s\t%s", iter_11_1.title, iter_11_1.title2)
				self._control.top.chap_title.text.text = var_0_8("%s\t%s", iter_11_1.title, iter_11_1.title2) or ""
			end
		end

		if self._page_num > 1 then
			self._control.middle.page_view.latticeScrollRect:SetTargetItemIndex(self._now_page)
		end
	end

	function arg_1_0.__get_real_pos(arg_12_0, arg_12_1, arg_12_2)
		return var_0_12(arg_12_1 * 0.575, -arg_12_2 * 0.575)
	end

	function arg_1_0:__load_map(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		local var_13_0 = var_0_3:get_abyss_level_cfg(arg_13_1) or {}

		self._map_dic[arg_13_1] = {}
		arg_13_2.sizeDelta = self._control.middle.window.rectTransform.sizeDelta
		arg_13_2.localPosition = var_0_11(0, 75, 0)

		if arg_13_4 then
			arg_13_4:ClearOptions()
			arg_13_4.onValueChanged:RemoveAllListeners()
			arg_13_4.onValueChanged:AddListener(function()
				local var_14_0 = {}

				var_0_20(arg_13_4.options[arg_13_4.value].text, "[^_]+", function(arg_15_0)
					var_0_7(var_14_0, arg_15_0)
				end)

				self._gm_node_id = tonumber(var_14_0[2])
			end)
		end

		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			if arg_13_4 then
				if iter_13_1.node_type == var_0_4.abyss_map_node_type.start then
					arg_13_4.options:Add(var_0_19("SELECT NODE"))
				else
					arg_13_4.options:Add(var_0_19((iter_13_1.flag or "null") .. "_" .. (iter_13_1.id or "null")))
				end
			end

			local var_13_2

			if not self._is_select_team then
				var_13_2 = var_0_3:get_abyss_pass_point_info(iter_13_1.id) or var_0_3:is_fight_info_pass(iter_13_1.id)
			end

			local var_13_3 = var_0_3:check_if_get_abyss_buff(iter_13_1.id)
			local var_13_4, var_13_5 = self:loadUIPrefab("map_node_obj", arg_13_2)

			var_0_7(self._collect_rubbish, var_13_4._panel)

			var_13_4._panel.name = iter_13_1.flag == "" and "start" or iter_13_1.flag

			local var_13_6 = {
				control = var_13_5.night_atk_point,
				path = {}
			}

			if iter_13_1.node_type == var_0_4.abyss_map_node_type.start then
				-- block empty
			else
				var_13_5.node_image.image.sprite = iter_13_1.node_type == var_0_4.abyss_map_node_type.prepare and (var_13_2 and self:loadSprite(var_0_4.abyss_const.abyss_repair_point_pass) or self:loadSprite(var_0_4.abyss_const.abyss_repair_point_normal)) or iter_13_1.node_type == var_0_4.abyss_map_node_type.boss and self:loadSprite(var_0_4.fight_point.pve_boss) or self:loadSprite(var_0_4.fight_point.pve_white)
			end

			local var_13_7 = false
			local var_13_8

			if iter_13_1.roundabout == 1 then
				var_13_8 = var_0_4.pve_g
				var_13_7 = true
			elseif iter_13_1.night_atk == 1 then
				var_13_8 = var_0_4.pve_night_atk_l
				var_13_7 = true
			elseif iter_13_1.node_type == 10 then
				var_13_8 = var_0_4.pve_air
				var_13_7 = true
			end

			if var_13_7 then
				var_13_5.night_atk_point.image.sprite = self:loadSprite(var_13_8)

				var_0_7(var_13_6.path, var_13_8)

				self._flash_obj_list[iter_13_1.id] = var_13_6
			end

			if self._is_select_team and var_0_3:get_abyss_ship_node_buff(iter_13_1.id) then
				var_13_7 = true
				var_13_8 = var_13_2 and var_13_3 and var_0_4.abyss_select_buff_bg_air_pass or var_0_4.abyss_select_buff_bg_air
				var_13_5.night_atk_point.image.sprite = self:loadSprite(var_13_8)

				var_0_7(var_13_6.path, var_13_8)

				self._flash_obj_list[iter_13_1.id] = var_13_6
			end

			var_13_5.night_atk_point:SetActive(var_13_7)
			var_13_5.night_atk_point.image:SetNativeSize()

			var_13_4._panel.transform.localPosition = var_0_12(0, 0)
			var_13_4._panel.transform.sizeDelta = var_0_12(0, 0)

			local var_13_9 = self:__get_real_pos(iter_13_1.position.x, iter_13_1.position.y)

			var_13_5.node_image.transform.anchoredPosition = var_13_9
			var_13_5.night_atk_point.transform.anchoredPosition = var_13_9
			self._map_dic[arg_13_1][iter_13_1.id] = {}
			self._map_dic[arg_13_1][iter_13_1.id].node = var_13_5

			self:__generate_line(iter_13_1, arg_13_2, self._map_dic[arg_13_1][iter_13_1.id], arg_13_3)

			local var_13_10, var_13_11 = self:loadUIPrefab("fearlessness_sea_letter_obj", arg_13_2)

			var_0_7(self._collect_rubbish, var_13_10._panel)

			var_13_10._panel.name = iter_13_1.id
			var_13_10._panel.transform.localPosition = var_0_12(0, 0)
			var_13_10._panel.transform.sizeDelta = var_0_12(0, 0)
			var_13_11.node_letter_image.transform.anchoredPosition = self:__get_real_pos(iter_13_1.position_letter.x, iter_13_1.position_letter.y)

			local var_13_12 = 1

			if var_13_2 and iter_13_1.node_type ~= var_0_4.abyss_map_node_type.prepare then
				if arg_13_3 == 1 then
					var_13_5.node_image.image.color = var_0_17
					var_13_12 = 2
				else
					var_13_5.node_image.image.color = var_0_17
					var_13_12 = 3
				end
			elseif var_13_2 and iter_13_1.node_type == var_0_4.abyss_map_node_type.prepare then
				var_13_12 = arg_13_3 == 1 and 2 or 3
			end

			var_13_11.node_letter_image.image.sprite = nil

			if iter_13_1.flag and iter_13_1.flag ~= "" then
				var_13_11.node_letter_image:SetActive(true)

				var_13_11.node_letter_image.image.sprite = self:loadSprite((var_0_8(var_0_4.fearlessness_sea_node_letter, iter_13_1.flag .. var_13_12)))
			else
				var_13_11.node_letter_image:SetActive(false)
			end

			var_13_4:setVisible(true)
			var_13_10:setVisible(true)
		end
	end

	function arg_1_0:__generate_line(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		if not arg_16_1 or not arg_16_1.next_node or not arg_16_1.next_node_path then
			return
		end

		arg_16_3.line = {}

		local var_16_0 = arg_16_1.node_type == var_0_4.map_node_type.null and 0 or arg_16_1.flag
		local var_16_1 = arg_16_1.pve_level_id

		for iter_16_0, iter_16_1 in pairs(arg_16_1.next_node) do
			local var_16_2 = var_0_6.find_object_by_id(iter_16_1) or {}
			local var_16_3 = (var_0_3:is_fight_info_pass(arg_16_1.id) or arg_16_1.node_type == var_0_4.abyss_map_node_type.prepare or arg_16_1.node_type == var_0_4.abyss_map_node_type.start) and var_0_3:is_fight_info_pass(var_16_2.id)
			local var_16_4 = var_0_8("%s-%s-%s", var_16_1, var_16_0, var_16_2.flag)
			local var_16_5 = arg_16_1.next_node_path[var_16_4] or {
				x = 2000,
				y = 2000
			}
			local var_16_6, var_16_7 = self:loadUIPrefab("map_line_obj", arg_16_2)

			var_0_7(self._collect_rubbish, var_16_6._panel)

			var_16_6._panel.name = var_16_4
			var_16_7.line_image.image.sprite = self:loadSprite(var_0_8(var_0_4.mapline_path, arg_16_1.pve_level_id, var_16_4))

			var_16_7.line_image.image:SetNativeSize()

			var_16_7.line_image.image.color = var_16_3 and var_0_3:get_abyss_pass_point_info(iter_16_1) and (arg_16_4 == 1 and var_0_16 or var_0_17) or var_0_15.New(1, 1, 1)
			var_16_6._panel.transform.localPosition = var_0_12(0, 0)
			var_16_6._panel.transform.sizeDelta = var_0_12(0, 0)
			var_16_7.line_image.transform.anchoredPosition = self:__get_real_pos(var_16_5.x, var_16_5.y)

			var_16_6:setVisible(true)

			arg_16_3.line[var_16_4] = var_16_7
		end
	end

	function arg_1_0.__load_level_config(arg_17_0)
		if var_0_3:abyss_level_cfg_load_comp() then
			return
		end

		local var_17_0 = {}

		for iter_17_0, iter_17_1 in ipairs((var_0_6.get_sequence())) do
			for iter_17_2, iter_17_3 in ipairs(var_0_5.get_sequence()) do
				if iter_17_3.id == iter_17_1.pve_level_id then
					var_17_0[iter_17_3.id] = var_17_0[iter_17_3.id] or {}

					var_0_7(var_17_0[iter_17_3.id], iter_17_1)
				end
			end
		end

		var_0_3:set_abyss_level_cfg(var_17_0)
	end

	function arg_1_0:__set_ui_layout()
		self._control.top.title:SetActive(not self._is_select_team)
		self._control.top.chap_title:SetActive(self._is_select_team)
		self._control.top.line:SetActive(self._is_select_team)

		local var_18_0

		if self._is_select_team then
			var_18_0 = var_0_4.abyss_const.abyss_select_team_bg or var_0_4.abyss_const.abyss_chapter_team_bg

			local var_18_1

			if self._is_select_team then
				var_18_1 = var_0_4.abyss_const.abyss_select_team_widow or var_0_4.abyss_const.abyss_chapter_widow
			end
		end

		self._control.bg.image.sprite = self:loadSprite(var_18_0)
		self._control.middle.window.image.sprite = self:loadSprite(var_18_1)

		if self._is_select_team then
			self._control.middle.transform.anchoredPosition = var_0_4.abyss_const.team_pos or var_0_4.abyss_const.chapter_pos
		end

		self._control.bottom.boss_frame:SetActive(not self._is_select_team)
		self._control.bottom.item_preview:SetActive(not self._is_select_team)
		self._control.bottom.team_select:SetActive(self._is_select_team)

		if app:isPC() then
			self._control.bottom.team_select.gm:SetActive(self._is_select_team)
		else
			self._control.bottom.team_select.gm:SetActive(false)
		end

		if self._is_select_team then
			self._control.middle.last_btn:SetActive(not self._is_select_team)
			self._control.middle.next_btn:SetActive(not self._is_select_team)

			local var_18_2, var_18_3 = math.modf(var_0_3:get_abyss_enter_repair_time() / 2)
			local var_18_4, var_18_5 = var_0_3:get_abyss_repair_team()
			local var_18_6 = var_18_2 == 0 and not var_18_4 or var_18_3 == 0

			self:__set_team_select_state((var_18_2 == 0 and not var_18_4 or var_18_3 == 0 or nil) and (var_0_4.team_type.abyss_owner_team or var_18_5))

			if not var_18_6 then
				local var_18_7 = self:loadMaterial(var_0_4.common_icon.furniture_gray_material)

				if var_18_4 == var_0_4.team_type.abyss_owner_team then
					self._control.bottom.team_select.player_team.button.enabled = false
					self._control.bottom.team_select.player_team.image.material = var_18_7
				else
					self._control.bottom.team_select.abyss_team.button.enabled = false
					self._control.bottom.team_select.abyss_team.image.material = var_18_7
				end
			end
		end
	end

	function arg_1_0:__team_select_return_func()
		if var_0_3:check_abyss_state() then
			var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("leaveconfirmdetail"), function()
				local var_20_0 = var_0_2:createInstance("abyss_event")
				local var_20_1 = var_20_0:create_chapter_cfg()

				if var_20_1 and var_0_23(var_20_1) then
					self:__destroy_panel()

					if var_0_2:getInstance("fight_info") then
						var_0_2:destroyInstance("fight_info")
					end

					if var_0_2:getInstance("combat_result") then
						var_0_2:destroyInstance("combat_result")
					end

					local var_20_2 = var_0_2:getInstance("home")

					if var_20_2 then
						var_20_2:setVisible(false)
					end

					var_20_0:show()
					var_0_3:req_AbyssQuitMapReq()
				end
			end, nil, (var_0_1:getNowLang("leaveconfirm")))

			return
		end

		self:__destroy_panel()

		self._is_select_team = false

		local var_19_0 = var_0_2:getInstance("abyss_event")

		if var_19_0 then
			var_19_0:show()
		end
	end

	function arg_1_0:__enter_abyss_model_fight_prepare()
		if self:_get_is_in_abyss_active_time() == false then
			var_0_22:show(var_0_1:getNowLang("active_outtime_tip"))

			return
		end

		self:setVisible(false)
		var_0_2:destroyInstance("abyss_preview")
		var_0_2:createInstance("fight_prepare"):show({
			fight_prepare_type = var_0_4.fight_type.abyss_model_first_phase,
			go_to_map_id = self._chapter_cfg.chapter_id
		})
	end

	function arg_1_0:__go_to_fight()
		if not self._now_page or not self._level_data or not self._level_data[self._now_page + 1] or not self._level_cfg or not self._level_cfg[self._now_page + 1] then
			return
		end

		var_0_3:gm_abyss_record_jump_node(self._gm_node_id)

		local var_22_0 = var_0_2:createInstance("fight_prepare")

		if var_22_0 then
			local var_22_1

			if self._team_type == var_0_4.team_type.abyss_owner_team then
				var_22_1 = var_0_4.fight_prepare_right_panel_type.props
			elseif self._team_type == var_0_4.team_type.abyss_team then
				var_22_1 = var_0_4.fight_prepare_right_panel_type.abyss_model
			end

			var_22_0:update_abyss_model_team_list(var_22_1, self._team_type)
			var_0_3:set_abyss_fight_team_detail(var_22_0._team_detail_data)
			var_22_0:setVisible(false)
		end

		local var_22_2 = var_0_3:get_abyss_fight_team_detail()
		local var_22_3 = var_22_2 and var_0_24.little_clone(var_22_2) or {}
		local var_22_4 = {
			fight_type = var_0_4.fight_type.abyss_model_first_phase,
			team_detail_data = var_22_3,
			map_id = self._level_cfg[self._now_page + 1].id,
			start_node_id = self._level_cfg[self._now_page + 1].init_node_id,
			is_abyss_team = self._team_type == var_0_4.team_type.abyss_team
		}
		local var_22_5 = var_0_3:get_abyss_fight_start_point(self._now_page + 1)

		var_0_3:set_abyss_now_team(self._team_type or var_0_4.team_type.abyss_owner_team)
		var_0_3:is_abyss_fighting(self._now_page + 1)
		var_0_2:destroyInstance("fight_prepare")

		if var_22_5 then
			var_22_4.start_node_id = var_22_5

			self:setVisible(false)
			var_0_3:set_abyss_fight_info_param(var_22_4)
			self:__destroy_panel()
			var_0_2:createInstance("fight_info"):show(var_22_4)

			return
		end

		var_0_3:set_abyss_fight_info_param(var_22_4)

		if not var_0_3:check_abyss_state() then
			var_0_3:reset_fight_info_pass()
			var_0_3:req_AbyssEnterMapReq({
				id = self._level_cfg[self._now_page + 1].id
			})
		else
			local var_22_6 = var_0_2:createInstance("fight_info")

			self:__destroy_panel()
			var_22_6:show(var_22_4)
		end
	end

	function arg_1_0.__destroy_panel(arg_23_0)
		var_0_2:destroyInstance("abyss_preview")
	end

	function arg_1_0:__init_language()
		self._control.bottom.fight_btn.txt.text.text = var_0_1:getNowLang("pvebattleprepare")
		self._control.bottom.team_select.player_team.name_bg.team_name.text.text = var_0_1:getNowLang("ui_ny21_fleet_title_1")
		self._control.bottom.team_select.abyss_team.name_bg.team_name.text.text = var_0_1:getNowLang("ui_ny21_fleet_title_2")
		self._control.bottom.item_preview.title.txt.text.text = var_0_1:getNowLang("ui_ny21_level_reward_title")
		self._control.bottom.item_preview.title.txt.text.fontSize = 22
		self._control.top.title.text.fontSize = 30
		self._control.bottom.fight_btn.txt.text.text = var_0_1:getNowLang("ui_ny21_enter_start_1")
	end

	function arg_1_0:__set_team_select_state(arg_25_1)
		local var_25_0 = self._control.bottom.team_select
		local var_25_1 = arg_25_1 == var_0_4.team_type.abyss_owner_team

		self._control.bottom.team_select.player_team.selected:SetActive(arg_25_1 == var_0_4.team_type.abyss_owner_team)
		var_25_0.abyss_team.selected:SetActive(not var_25_1)

		self._team_type = arg_25_1

		local var_25_2 = var_0_2:getInstance("fight_prepare")

		if var_25_2 then
			local var_25_3

			if arg_25_1 == var_0_4.team_type.abyss_owner_team then
				var_25_3 = var_0_4.fight_prepare_right_panel_type.props
			elseif arg_25_1 == var_0_4.team_type.abyss_team then
				var_25_3 = var_0_4.fight_prepare_right_panel_type.abyss_model
			end

			var_25_2:update_abyss_model_team_list(var_25_3, arg_25_1)
			var_0_3:set_abyss_fight_team_detail(var_25_2._team_detail_data)
		end

		self._now_page = var_25_1 and 0 or 1

		var_0_3:set_abyss_preview_now_page(self._now_page)
		self:__update_page()

		if app:isPC() then
			self:__active_canvas(var_25_0.gm.gm_1.canvasGroup, var_25_1)
			self:__active_canvas(var_25_0.gm.gm_2.canvasGroup, not var_25_1)
		end
	end

	function arg_1_0:__return_main_stage_func()
		self:__destroy_panel()

		local var_26_0 = var_0_2:createInstance("abyss_event")

		if var_26_0 then
			var_26_0:show()
		end
	end

	function arg_1_0.__active_canvas(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
		if not arg_27_1 then
			return
		end

		arg_27_1.alpha = arg_27_2 and 1 or 0

		if arg_27_3 then
			return
		end

		arg_27_1.blocksRaycasts = arg_27_2
		arg_27_1.interactable = arg_27_2
	end

	function arg_1_0:__show_boss_remain_time()
		self._control.bottom.remain_time.text.text = var_0_1:getNowLang("ui_ny21_today_last_times")

		local var_28_0
		local var_28_1 = true
		local var_28_2 = var_0_3:get_abyss_world_boss_info(4)

		if var_28_2 and var_0_23(var_28_2) then
			if self._chapter_cfg.chapter_id == 4 and var_0_3:get_boss_open() then
				if var_28_2.step ~= 3 then
					local var_28_4 = var_0_3:get_user_abyss_boss_count()

					self._control.bottom.remain_time:SetActive(true)

					self._control.bottom.remain_time.time_num.text.text = 3 - var_28_4

					if 3 - var_28_4 == 0 then
						var_28_0 = var_0_4.abyss_const.abyss_start_fight_btn_cant
						var_28_1 = false
					else
						var_28_0 = var_0_4.abyss_const.abyss_start_fight_btn_can
						var_28_1 = true
					end
				else
					self._control.bottom.remain_time:SetActive(false)

					var_28_0 = var_0_4.abyss_const.abyss_start_fight_btn_can
					var_28_1 = true

					self._control.bottom.boss_frame.hp:SetActive(false)
					self._control.bottom.boss_frame.hp_perc:SetActive(false)
				end
			else
				self._control.bottom.remain_time:SetActive(false)

				var_28_0 = var_0_4.abyss_const.abyss_start_fight_btn_can
				var_28_1 = true
			end
		else
			self._control.bottom.remain_time:SetActive(false)

			var_28_0 = var_0_4.abyss_const.abyss_start_fight_btn_can

			self._control.bottom.boss_frame.hp:SetActive(false)
			self._control.bottom.boss_frame.hp_perc:SetActive(false)
		end

		self._control.bottom.fight_btn.image.sprite = self:loadSprite(var_28_0)
		self._control.bottom.fight_btn.button.enabled = var_28_1
	end

	function arg_1_0:_play_into_se(arg_29_1)
		self:playSE(arg_29_1, false)
	end

	function arg_1_0:_play_audio(arg_30_1)
		self:playBackgroundMusic(arg_30_1)
	end

	function arg_1_0:__onReset()
		self._control.bottom.team_select.gm.gm_1.dropdown.value = 0
		self._control.bottom.team_select.gm.gm_2.dropdown.value = 0

		if self._collect_rubbish then
			for iter_31_0, iter_31_1 in ipairs(self._collect_rubbish) do
				self:destroyGameObject(iter_31_1)
			end
		end

		self._collect_rubbish = {}

		if self._level_data then
			for iter_31_2, iter_31_3 in ipairs(self._level_data) do
				iter_31_3.page.transform.localPosition = var_0_12(0, 0)
			end
		end

		self._control.bottom.team_select.player_team.button.enabled = true
		self._control.bottom.team_select.abyss_team.button.enabled = true
		self._control.bottom.team_select.player_team.image.material = nil
		self._control.bottom.team_select.abyss_team.image.material = nil

		self._control.bottom.boss_frame.hp:SetActive(true)
		self._control.bottom.boss_frame.hp_perc:SetActive(true)

		self._init_comp = false

		for iter_31_4, iter_31_5 in pairs(self._flash_tween_seq) do
			if iter_31_5 and iter_31_5:IsPlaying() then
				iter_31_5:Kill()
			end
		end
	end

	function arg_1_0._get_is_in_abyss_active_time(arg_32_0)
		if lx.ServerTime:getUtcTime() > var_0_10.find_object_by_id(var_0_4.pve_active_list.abyss_event).end_time then
			return false
		else
			return true
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_33_0)
	local var_33_0 = var_0_2:class("abyss_preview")

	var_33_0._init_comp = nil
	var_33_0._chapter_cfg = nil
	var_33_0._level_cfg = nil
	var_33_0._level_data = nil
	var_33_0._is_select_team = nil
	var_33_0._show_level_id = nil
	var_33_0._now_page = nil
	var_33_0._page_num = nil
	var_33_0._map_dic = nil
	var_33_0._is_already_bgm = false
	var_33_0._flash_tween_seq = {}

	gamecore.extend_obj(var_33_0)

	return var_33_0
end

return var_0_0
