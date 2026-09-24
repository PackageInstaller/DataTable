local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gameconfig.ship_config
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.UILoader
local var_0_5 = gamecore.Language
local var_0_6 = table.insert
local var_0_7 = table.remove
local var_0_8 = table.getn
local var_0_9 = string.format
local var_0_10 = gamecore.util_func
local var_0_11 = gamecore.prompt
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = gameconfig.abyss_combination_quality_config
local var_0_14 = gameconfig.abyss_combination_type_config
local var_0_15 = gameenum.config_data

gamecore.UILoader:define("abyss_dock_team", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:get_current_team_index()
		return self._current_team_index
	end

	function arg_1_0:update_content(arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = not arg_4_2 or arg_4_2 < 5

		self._control.bg.middle_menu.team_content_obj:SetActive((not arg_4_2 or arg_4_2 < 5) and true or false)

		self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.text = var_0_5:getNowLang("ui_ny21_deep_tab_1")
		self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.text = var_0_5:getNowLang("ui_ny21_deep_tab_2")
		self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.text = var_0_5:getNowLang("ui_ny21_deep_tab_3")
		self._control.bg.bot_menu.rectTransform.anchoredPosition = Vector2(0, 242)
		self._control.bg.abyss_title.rectTransform.anchoredPosition = Vector2(-130, 30)
		self._control.bg.middle_menu.team_content_obj.rectTransform.anchoredPosition = Vector2(56.5, -40)
		self._control.bg.top_menu.rectTransform.anchoredPosition = Vector2(0, -122)

		if var_4_0 then
			if arg_4_1 == var_0_3.abyss_dock_team_toggle_type.formation then
				self._control.bg.bot_menu.tips:SetActive(true)
				self._control.bg.abyss_title:SetActive(true)

				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.color = Color.New(1, 1, 1, 1)
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.fontSize = 28
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.fontSize = 26
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.fontSize = 26
			elseif arg_4_1 == var_0_3.abyss_dock_team_toggle_type.remake then
				self._control.bg.bot_menu.tips:SetActive(false)
				self._control.bg.abyss_title:SetActive(false)

				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.color = Color.New(1, 1, 1, 1)
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.fontSize = 26
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.fontSize = 28
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.fontSize = 26
			elseif arg_4_1 == var_0_3.abyss_dock_team_toggle_type.synthetise then
				self._control.bg.bot_menu.tips:SetActive(false)
				self._control.bg.abyss_title:SetActive(false)

				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.color = Color.New(1, 1, 1, 1)
				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.fontSize = 26
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.fontSize = 26
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.fontSize = 28
			end

			local function var_4_1()
				self._current_team_index = arg_4_2 or 1
				self._current_content_type = arg_4_1

				self:__update_info_list(self._current_content_type, self._current_team_index, arg_4_3)
			end

			if self._is_already_init then
				if arg_4_1 ~= self._current_content_type or self.switch_content_not_first_team then
					var_4_1()

					self.switch_content_not_first_team = false
				else
					var_4_1()
				end
			else
				var_4_1()
			end
		end
	end

	function arg_1_0:__update_info_list(arg_6_1, arg_6_2, arg_6_3)
		self._team_data = {}

		local var_6_0 = var_0_1:get_abyss_team_info()

		if self._is_already_init then
			self._control.bg.middle_menu.remake_content:SetActive(false)
			self._control.bg.middle_menu.synthesis_interface:SetActive(false)

			self._is_goto_formation = true
			self._is_goto_remake = false
			self._is_goto_synthesis = false

			for iter_6_0 = 1, 6 do
				local var_6_1 = self._info_list[iter_6_0]

				if var_6_0[iter_6_0] then
					local var_6_2 = var_0_1:find_abyss_character_by_id(var_6_0[iter_6_0])

					var_6_1:show(var_6_2, arg_6_1, iter_6_0)

					var_6_1._control.BG.all_layer.drag_layer.rankableLayoutItem.isFilled = true

					if arg_6_1 == var_0_3.abyss_dock_team_toggle_type.formation then
						var_6_1:set_active_rankable_layout_item(true)
						var_0_6(self._team_data, var_6_2.id)
					else
						var_6_1:set_active_rankable_layout_item(false)
					end

					if arg_6_1 == var_0_3.abyss_dock_team_toggle_type.remake or arg_6_1 == var_0_3.abyss_dock_team_toggle_type.synthetise then
						var_6_1:setVisible(false)
					end
				elseif arg_6_1 == var_0_3.abyss_dock_team_toggle_type.formation then
					var_6_1:show(nil, nil, iter_6_0)

					var_6_1._control.BG.all_layer.drag_layer.rankableLayoutItem.isFilled = false
				else
					var_6_1:setVisible(false)
				end
			end
		else
			self._control.bg.middle_menu.remake_content:SetActive(false)
			self._control.bg.middle_menu.synthesis_interface:SetActive(false)

			self._is_goto_formation = true
			self._is_goto_remake = false
			self._is_goto_synthesis = false

			local var_6_3 = self:autoKillDOTween(var_0_12.Sequence())

			for iter_6_1 = 1, 6 do
				local var_6_4 = self:loadUI("abyss_single_ship")

				var_6_4._panel.transform:SetParent(self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rectTransform, false)

				if var_6_0[iter_6_1] then
					local var_6_5 = var_0_1:find_abyss_character_by_id(var_6_0[iter_6_1])

					var_6_4._control.BG.all_layer.drag_layer.rankableLayoutItem.isFilled = true

					var_6_4:show(var_6_5, arg_6_1, iter_6_1)
					var_0_6(self._team_data, var_6_5.id)
				else
					var_6_4._control.BG.all_layer.drag_layer.rankableLayoutItem.isFilled = false

					var_6_4:show(nil, nil, iter_6_1)
				end

				var_0_6(self._info_list, var_6_4)
			end

			self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup.onItemExchange:AddListener(function(arg_7_0, arg_7_1)
				self._team_data[arg_7_0] = self._team_data[arg_7_1]
				self._team_data[arg_7_1] = self._team_data[arg_7_0]
				self._info_list[arg_7_0] = self._info_list[arg_7_1]
				self._info_list[arg_7_1] = self._info_list[arg_7_0]
			end)
			self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup.onEndDrag:AddListener(function()
				if not self:save_team_info_all() then
					var_0_11:show(var_0_5:getNowLang("needflagshipinfleet"))
				end
			end)
			self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup:Init()

			self._is_already_init = true
		end

		if arg_6_1 == var_0_3.abyss_dock_team_toggle_type.remake then
			self:set_ship_info()

			self._is_goto_formation = false
			self._is_goto_remake = true
			self._is_goto_synthesis = false

			self._control.bg.middle_menu.remake_content:SetActive(true)
			self:init_remake_language()
		end

		if arg_6_1 == var_0_3.abyss_dock_team_toggle_type.synthetise then
			self._is_goto_formation = false
			self._is_goto_remake = false
			self._is_goto_synthesis = true

			self._control.bg.middle_menu.synthesis_interface:SetActive(true)

			self._star_layer_list = {
				self._control.bg.middle_menu.synthesis_interface.right_all.star_layer_1,
				self._control.bg.middle_menu.synthesis_interface.right_all.star_layer_2,
				self._control.bg.middle_menu.synthesis_interface.right_all.star_layer_3
			}

			self:_ui_static_loading()
			self:_initialize_star_layer()
			self:_initialize_type_layer()
			self:_initialize_right_button()
		end
	end

	function arg_1_0.team_save_error(arg_9_0, arg_9_1)
		local var_9_0 = ""

		if arg_9_1 == 6 then
			var_9_0 = var_0_5:getNowLang("nosameshipinteam")
		elseif arg_9_1 == 60 then
			var_9_0 = var_0_5:getNowLang("needflagshipinfleet")
		end

		var_0_11:show(var_9_0)
	end

	function arg_1_0:save_team_info_single(arg_10_1, arg_10_2)
		local var_10_0 = var_0_1:get_abyss_team_info()

		if arg_10_1 == 1 and var_0_8(self._team_data) == 1 and not arg_10_2 and self._current_team_index == 1 then
			var_0_11:show(var_0_5:getNowLang("needflagshipinfleet"))

			return
		elseif var_0_8(self._team_data) ~= 1 and arg_10_2 and #var_10_0 <= 1 and arg_10_2.id == var_10_0[1] and self._current_team_index ~= 1 then
			var_0_11:show(var_0_5:getNowLang("needflagshipinfleet"))

			return
		end

		if self._team_data[arg_10_1] then
			if arg_10_2 and not arg_10_2.is_exist then
				local var_10_1

				for iter_10_0, iter_10_1 in pairs(self._team_data) do
					if iter_10_1 == arg_10_2.id or var_0_1:find_abyss_character_by_id(iter_10_1).cid == arg_10_2.cid then
						self._team_data[arg_10_1] = iter_10_1
						self._team_data[iter_10_0] = self._team_data[arg_10_1]
						var_10_1 = true

						break
					end
				end

				if var_10_1 then
					var_0_11:show(var_0_5:getNowLang("nosameshipinteam"))

					return
				end

				if not var_10_1 then
					self._team_data[arg_10_1] = arg_10_2.id
				end
			else
				var_0_7(self._team_data, arg_10_1)
			end
		else
			local var_10_2

			if arg_10_2 then
				local var_10_3 = var_0_1:find_abyss_character_by_id(arg_10_2.id)

				if var_10_3 then
					var_10_2 = var_0_2.find_abyss_object_by_cid(var_10_3.cid)
				end
			end

			local var_10_4

			for iter_10_2, iter_10_3 in pairs(self._team_data) do
				local var_10_5 = var_0_2.find_abyss_object_by_cid(var_0_1:find_abyss_character_by_id(iter_10_3).cid)
				local var_10_6 = var_10_5.cid == var_10_2.cid or var_10_5.evo_cid == var_10_2.evo_cid

				if iter_10_3 ~= arg_10_2.id and var_10_6 then
					var_0_11:show(var_0_5:getNowLang("nosameshipinteam"))

					return
				elseif iter_10_3 == arg_10_2.id and var_10_6 then
					var_10_4 = iter_10_2
				end
			end

			if var_10_4 then
				var_0_7(self._team_data, var_10_4)
			end

			var_0_6(self._team_data, arg_10_2.id)
		end

		var_0_1:req_AbyssAbyssSaveTeamReq(({
			id = self._current_team_index,
			members = self._team_data
		}).members)
	end

	function arg_1_0:save_team_info_all(arg_11_1)
		local var_11_0 = {}
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in pairs(arg_11_1 or self._team_data) do
			var_0_6(var_11_0, {
				keys = iter_11_0,
				id = iter_11_1
			})
		end

		table.sort(var_11_0, function(arg_12_0, arg_12_1)
			return arg_12_0.keys < arg_12_1.keys
		end)

		for iter_11_2, iter_11_3 in ipairs(var_11_0) do
			var_11_1[iter_11_2] = iter_11_3.id
		end

		var_0_1:req_AbyssAbyssSaveTeamReq(({
			id = self._current_team_index,
			members = var_11_1
		}).members)

		return true
	end

	function arg_1_0:refresh_info_list()
		self:__update_info_list(self._current_content_type, self._current_team_index)
		self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup:ReSetBoundaryPosXList()
		self:update_content(self._current_content_type or var_0_3.abyss_dock_team_toggle_type.formation, self._current_team_index)
	end

	function arg_1_0:__init_panel()
		self:update_content(self._current_content_type or var_0_3.abyss_dock_team_toggle_type.formation, 1)
	end

	function arg_1_0:__init_content()
		self:play_in_animation()
	end

	function arg_1_0:__play_bot_menu_in_animation()
		self._control.bg.bot_menu.rectTransform.anchoredPosition = Vector2(0, 100)
		self._control.bg.bot_menu.rectTransform:DOAnchorPos(Vector2(0, 242), 0.4):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0.2):SetAutoKill(true).onComplete = function()
			return
		end
	end

	function arg_1_0:__play_abyss_title_in_animation()
		self._control.bg.abyss_title.rectTransform.anchoredPosition = Vector2(-130, 150)
		self._control.bg.abyss_title.rectTransform:DOAnchorPos(Vector2(-130, 30), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0.15):SetAutoKill(true).onComplete = function()
			return
		end
	end

	function arg_1_0:play_in_animation(arg_20_1)
		self._control.bg.uITweenSequence:Play(function()
			if arg_20_1 then
				arg_20_1()
			end
		end)

		self._control.bg.abyss_title.rectTransform.anchoredPosition = Vector2(-130, 150)
		self._control.bg.abyss_title.rectTransform:DOAnchorPos(Vector2(-130, 30), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0.15):SetAutoKill(true).onComplete = function()
			return
		end
	end

	function arg_1_0:play_out_animation(arg_23_1)
		self._control.bg.uITweenSequence:PlayReverse(function()
			if arg_23_1 then
				arg_23_1()
			end
		end)

		self._control.bg.abyss_title.rectTransform.anchoredPosition = Vector2(-130, 30)
		self._control.bg.abyss_title.rectTransform:DOAnchorPos(Vector2(-130, 150), 0.2):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true).onComplete = function()
			return
		end
	end

	function arg_1_0:play_switch_tab_animation(arg_26_1)
		if arg_26_1 then
			arg_26_1()
		end

		if not self._is_already_init then
			self:play_switch_tab_in_animation()
		else
			self:play_switch_tab_in_animation()
		end
	end

	function arg_1_0:play_switch_tab_in_animation(arg_27_1)
		self._control.bg.middle_menu.uITweenSequence:Play(function()
			if arg_27_1 then
				arg_27_1()
			end
		end)
	end

	function arg_1_0:play_switch_tab_out_animation(arg_29_1)
		self._control.bg.middle_menu.uITweenSequence:PlayReverse(function()
			if arg_29_1 then
				arg_29_1()
			end
		end)
	end

	function arg_1_0:__destroy_info_list()
		for iter_31_0, iter_31_1 in pairs(self._info_list) do
			iter_31_1:destroy()
		end

		self._info_list = {}

		self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup:OnDestroy()
	end

	function arg_1_0:_get_abyss_ship_data()
		local var_32_0
		local var_32_1 = {}
		local var_32_3 = var_0_1:get_abyss_team_info()
		local var_32_4 = var_32_3 and var_0_10.little_clone(var_32_3) or {}
		local var_32_5 = var_0_1:get_abyss_character_list()

		for iter_32_0, iter_32_1 in pairs(var_0_15.abyss_not_combine_cid) do
			for iter_32_2, iter_32_3 in pairs(var_32_5) do
				if iter_32_1 == iter_32_3.cid then
					var_32_4.no_sys = iter_32_2
				end
			end
		end

		if self._synthesis_need_ship_table["id_" .. self._onclick_right_or_left_pos] == nil then
			var_32_0 = nil

			for iter_32_4, iter_32_5 in pairs(self._synthesis_need_ship_table) do
				if iter_32_5 ~= nil then
					var_32_4[iter_32_4] = iter_32_5
				end
			end
		else
			var_32_0 = var_0_1:find_abyss_character_by_id(self._synthesis_need_ship_table["id_" .. self._onclick_right_or_left_pos]).id

			for iter_32_6, iter_32_7 in pairs(self._synthesis_need_ship_table) do
				if iter_32_7 ~= nil then
					var_32_4[iter_32_6] = iter_32_7
				end
			end
		end

		for iter_32_8, iter_32_9 in pairs(var_32_4) do
			var_32_1[iter_32_8] = var_0_1:find_abyss_character_by_id(iter_32_9).id
		end

		for iter_32_10, iter_32_11 in pairs(var_32_5) do
			if iter_32_11.cid ~= iter_32_11.evo_cid then
				var_32_1[iter_32_10] = iter_32_11.id
			end
		end

		return var_32_0, var_32_1
	end

	function arg_1_0:_eturn_synthesis_interface()
		if self._is_goto_synthesis then
			var_0_4:createInstance("abyss_dock_team"):setVisible(true)
		end
	end

	function arg_1_0:_onclick_ship_return_abyss_dock_team(arg_34_1)
		local var_34_0 = var_0_4:createInstance("abyss_dock_team")

		var_34_0._synthesis_need_ship_table["id_" .. var_34_0._onclick_right_or_left_pos] = arg_34_1[1].id

		var_34_0:_ui_dynamic_loading(var_34_0._synthesis_need_ship_table["id_" .. var_34_0._onclick_right_or_left_pos], var_34_0._onclick_right_or_left_pos)

		local var_34_2 = 0

		for iter_34_0, iter_34_1 in pairs(self._synthesis_need_ship_table) do
			var_34_2 = var_34_2 + 1
		end

		if var_34_2 == 2 then
			var_34_0:_you_can_get_star_type_info()
		end

		var_0_4:createInstance("abyss_select_member"):setVisible(false)
		self:setVisible(true)
	end

	function arg_1_0:_onclick_leave_team_return_abyss_dock_team(arg_35_1)
		self:setVisible(true)

		self._synthesis_need_ship_table["id_" .. self._onclick_right_or_left_pos] = nil

		self:_ui_dynamic_loading(self._synthesis_need_ship_table["id_" .. self._onclick_right_or_left_pos], self._onclick_right_or_left_pos)
		self:_initialize_star_layer()
		self:_initialize_type_layer()
		self:_initialize_right_button()
	end

	function arg_1_0:_show_synthesis_panel_info(arg_36_1)
		if arg_36_1 == nil then
			self._abyss_synthesis_ship_info = {}

			self:_synthesis_clear_data_Active()

			return
		end

		self:_synthesis_clear_data_Active()

		self._abyss_synthesis_ship_info = arg_36_1

		if #arg_36_1 == 1 then
			self:_ui_dynamic_loading(arg_36_1[1].id, #arg_36_1)
			self._control.bg.middle_menu.synthesis_interface.right_all.clear_btn:SetActive(true)
		else
			self:_ui_dynamic_loading(arg_36_1[1].id, 1)
			self:_ui_dynamic_loading(arg_36_1[2].id, 2)
			self:_you_can_get_star_type_info()
		end
	end

	function arg_1_0:__onclik_msgbox_yes_req()
		if self._is_two_97_no_synthesis then
			var_0_11:show(var_0_5:getNowLang("ui_ny21_combine_type97"))

			return
		end

		var_0_1:req_AbyssCombineReq({
			id_1 = self._abyss_synthesis_ship_info[1].id,
			id_2 = self._abyss_synthesis_ship_info[2].id
		})

		self._abyss_synthesis_ship_info = {}
	end

	function arg_1_0:__response_data_back()
		self:_synthesis_clear_data_Active()
	end

	function arg_1_0.__onclik_msgbox_no_back(arg_39_0)
		var_0_4:destroyInstance("msgbox")
	end

	function arg_1_0:_synthesis_clear_data_Active()
		self:_initialize_all_list()

		local var_40_0 = 0

		for iter_40_0, iter_40_1 in pairs(self._synthesis_need_ship_table) do
			var_40_0 = var_40_0 + 1
		end

		if var_40_0 == 0 then
			self:_initialize_star_layer()
			self:_initialize_type_layer()
			self:_initialize_right_button()
			self:_initialize_ship_layer()
		end
	end

	function arg_1_0:_initialize_ship_layer()
		local var_41_0 = 0

		for iter_41_0, iter_41_1 in pairs(self._synthesis_need_ship_table) do
			var_41_0 = var_41_0 + 1
		end

		if var_41_0 == 0 then
			self._control.bg.middle_menu.synthesis_interface.left_all.right_material.ship_bg:SetActive(false)
			self._control.bg.middle_menu.synthesis_interface.left_all.left_material.ship_bg:SetActive(false)
		end
	end

	function arg_1_0:_you_can_get_star_type_info()
		local var_42_0 = 0

		for iter_42_0, iter_42_1 in pairs(self._abyss_synthesis_ship_info) do
			var_42_0 = var_42_0 + 1
		end

		if var_42_0 == 2 then
			self._is_two_97_no_synthesis = false
			self._get_type_list = {}

			local var_42_1 = var_0_2.find_abyss_object_by_cid(var_0_1:find_abyss_character_by_id(self._abyss_synthesis_ship_info[1].id).cid)
			local var_42_2 = var_0_2.find_abyss_object_by_cid(var_0_1:find_abyss_character_by_id(self._abyss_synthesis_ship_info[2].id).cid)

			self._get_star_list[1] = var_42_1.star
			self._get_star_list[2] = var_42_2.star
			self._get_type_list[1] = var_42_1.type
			self._get_type_list[2] = var_42_2.type

			if self._get_type_list[1] == 97 and self._get_type_list[2] == 97 then
				self._is_two_97_no_synthesis = true
				self._get_type_list = {}
				self._get_star_list = {}

				self:_initialize_star_layer()
				self:_initialize_type_layer()
				self:_open_right_button()

				return
			elseif self._get_type_list[1] == 97 and self._get_type_list[2] ~= 97 then
				self._get_type_list[1] = self._get_type_list[2]
			elseif self._get_type_list[1] ~= 97 and self._get_type_list[2] == 97 then
				self._get_type_list[2] = self._get_type_list[1]
			end

			table.sort(self._get_star_list, function(arg_43_0, arg_43_1)
				return arg_43_0 < arg_43_1
			end)
			self:_need_star_info(var_0_13.find_object_by_material1_material2(self._get_star_list[1], self._get_star_list[2]).weight)
			self:_need_type_info(var_0_14.find_object_by_materialid(self._get_type_list[1]), (var_0_14.find_object_by_materialid(self._get_type_list[2])))
			self:_open_right_button()
		end
	end

	function arg_1_0:_need_star_info(arg_44_1)
		if arg_44_1 == nil then
			return
		end

		self:_initialize_star_layer()

		local var_44_0 = {}

		for iter_44_0, iter_44_1 in pairs(arg_44_1) do
			var_44_0[iter_44_0] = iter_44_1.star
		end

		for iter_44_2 = 1, #var_44_0 do
			self._star_layer_list[iter_44_2].bg:SetActive(true)

			for iter_44_3 = 2, self._star_layer_list[iter_44_2].transform.childCount do
				if iter_44_3 - 1 <= var_44_0[iter_44_2] then
					self._star_layer_list[iter_44_2]["star_" .. iter_44_3 - 1].image.sprite = self:loadSprite(var_0_3.abyss_ui_path.card .. "star_icon.png")

					self._star_layer_list[iter_44_2]["star_" .. iter_44_3 - 1]:SetActive(true)
				elseif iter_44_3 == 8 then
					self._star_layer_list[iter_44_2]["star_" .. iter_44_3 - 1]:SetActive(false)
				else
					self._star_layer_list[iter_44_2]["star_" .. iter_44_3 - 1].image.sprite = self:loadSprite(var_0_3.abyss_ui_path.card .. "star_blank_icon.png")

					self._star_layer_list[iter_44_2]["star_" .. iter_44_3 - 1]:SetActive(true)
				end
			end
		end
	end

	function arg_1_0:_initialize_star_layer()
		for iter_45_0 = 1, #self._star_layer_list do
			for iter_45_1 = 1, 7 do
				self._star_layer_list[iter_45_0].bg:SetActive(false)
				self._star_layer_list[iter_45_0]["star_" .. iter_45_1]:SetActive(false)
			end
		end
	end

	function arg_1_0:_initialize_right_button()
		self._control.bg.middle_menu.synthesis_interface.right_all.clear_btn:SetActive(false)
		self._control.bg.middle_menu.synthesis_interface.right_all.streng_btn:SetActive(false)
	end

	function arg_1_0:_open_right_button()
		self._control.bg.middle_menu.synthesis_interface.right_all.clear_btn:SetActive(true)
		self._control.bg.middle_menu.synthesis_interface.right_all.streng_btn:SetActive(true)
	end

	function arg_1_0:_need_type_info(arg_48_1, arg_48_2)
		self:_initialize_type_layer()

		if arg_48_1 == nil or arg_48_2 == nil then
			return
		end

		self._you_can_get_type_list = {}

		if arg_48_1.materialid == arg_48_2.materialid then
			for iter_48_0 = 1, #arg_48_1.target do
				self._you_can_get_type_list[iter_48_0] = arg_48_1.target[iter_48_0].id
			end
		else
			local var_48_0 = {}
			local var_48_1 = {}

			for iter_48_1 = 1, #arg_48_1.target do
				var_48_0[iter_48_1] = arg_48_1.target[iter_48_1].id
			end

			for iter_48_2 = 1, #arg_48_2.target do
				var_48_1[iter_48_2] = arg_48_2.target[iter_48_2].id
			end

			local var_48_2 = 0

			for iter_48_3, iter_48_4 in pairs(var_48_0) do
				for iter_48_5, iter_48_6 in pairs(var_48_1) do
					if iter_48_4 == iter_48_6 then
						var_48_2 = var_48_2 + 1
						self._you_can_get_type_list[var_48_2] = iter_48_4
					end
				end
			end
		end

		if #self._you_can_get_type_list ~= 0 then
			local var_48_3 = {}
			local var_48_4 = 0

			for iter_48_7 = 1, #self._you_can_get_type_list do
				for iter_48_8, iter_48_9 in pairs(var_0_3.ship_type_rule) do
					if self._you_can_get_type_list[iter_48_7] == iter_48_9.value then
						var_48_4 = var_48_4 + 1
						var_48_3[var_48_4] = iter_48_9.simplified_lan
					end
				end
			end

			for iter_48_10 = 1, #self._you_can_get_type_list do
				self._control.bg.middle_menu.synthesis_interface.right_all.type_layer["type_" .. iter_48_10].Label.text.text = var_0_5:getNowLang(var_48_3[iter_48_10])

				self._control.bg.middle_menu.synthesis_interface.right_all.type_layer["type_" .. iter_48_10]:SetActive(true)
			end
		else
			self:_initialize_type_layer()

			return
		end
	end

	function arg_1_0:_initialize_type_layer()
		for iter_49_0 = 1, self._control.bg.middle_menu.synthesis_interface.right_all.type_layer.transform.childCount do
			self._control.bg.middle_menu.synthesis_interface.right_all.type_layer["type_" .. iter_49_0]:SetActive(false)
		end
	end

	function arg_1_0:_ui_static_loading()
		self._control.bg.middle_menu.synthesis_interface.right_all.text_layer.top_text.text.text = var_0_5:getNowLang("ui_ny21_synthesis_interface_get_star")
		self._control.bg.middle_menu.synthesis_interface.right_all.text_layer.middle_text.text.text = var_0_5:getNowLang("ui_ny21_synthesis_interface_get_type")
		self._control.bg.middle_menu.synthesis_interface.right_all.clear_btn.title.text.text = var_0_5:getNowLang("clearsave")
		self._control.bg.middle_menu.synthesis_interface.right_all.streng_btn.title.text.text = var_0_5:getNowLang("ui_ny21_synthesis_interface_synthesis_btn")
		self._control.bg.middle_menu.synthesis_interface.right_all.button_ship_detail.Text.text.text = var_0_5:getNowLang("ui_ny21_synthesis_interface_synthesis_talk")
	end

	function arg_1_0:_ui_dynamic_loading(arg_51_1, arg_51_2)
		local var_51_0

		if arg_51_2 == 1 then
			var_51_0 = self._control.bg.middle_menu.synthesis_interface.left_all.left_material
		elseif arg_51_2 == 2 then
			var_51_0 = self._control.bg.middle_menu.synthesis_interface.left_all.right_material
		else
			return
		end

		if arg_51_1 == nil then
			var_51_0.ship_bg:SetActive(false)

			return
		else
			self:_ui_dynamic_ship_star_info(arg_51_1, var_51_0)
			self:_ui_dynamic_ship_other_info(arg_51_1, var_51_0)
			var_51_0.ship_bg:SetActive(true)
		end
	end

	function arg_1_0:_ui_dynamic_ship_star_info(arg_52_1, arg_52_2)
		local var_52_0 = var_0_1:find_abyss_character_by_id(arg_52_1).star

		for iter_52_0 = 1, arg_52_2.ship_bg.info_layer.star_layer.transform.childCount do
			if iter_52_0 <= var_52_0 then
				arg_52_2.ship_bg.info_layer.star_layer["star_" .. iter_52_0].image.sprite = self:loadSprite(var_0_3.abyss_ui_path.card .. "star_icon.png")

				arg_52_2.ship_bg.info_layer.star_layer["star_" .. iter_52_0]:SetActive(true)
			elseif iter_52_0 == 7 then
				arg_52_2.ship_bg.info_layer.star_layer["star_" .. iter_52_0]:SetActive(false)
			else
				arg_52_2.ship_bg.info_layer.star_layer["star_" .. iter_52_0].image.sprite = self:loadSprite(var_0_3.abyss_ui_path.card .. "star_blank_icon.png")

				arg_52_2.ship_bg.info_layer.star_layer["star_" .. iter_52_0]:SetActive(true)
			end
		end
	end

	function arg_1_0:_ui_dynamic_ship_other_info(arg_53_1, arg_53_2)
		local var_53_0 = var_0_1:find_abyss_character_by_id(arg_53_1)
		local var_53_1 = var_0_2.find_abyss_object_by_cid(var_53_0.cid)
		local var_53_2 = ""

		for iter_53_0, iter_53_1 in pairs(var_0_3.ship_type_rule) do
			if iter_53_1.value == var_53_0.type then
				var_53_2 = iter_53_1.simplified_lan
			end
		end

		arg_53_2.ship_bg.image.sprite = var_53_0.boss == 1 and self:loadSprite(var_0_3.abyss_ui_path.main .. "abyss_ship_bg_L_2.png") or self:loadSprite(var_0_3.abyss_ui_path.main .. "abyss_ship_bg_L_1.png")

		local var_53_3 = var_0_9(var_0_3.ship_icon.model_normal_m, var_53_1.pic_id, var_53_1.pic_id)

		arg_53_2.ship_bg.info_layer.level_txt.text.color = Color.New(0.996078431372549, 0.9882352941176471, 0, 1)
		arg_53_2.ship_bg.name_layer.name_level.name_level_1.text.text = var_53_0.name

		arg_53_2.ship_bg.name_layer.name_level:GetComponent("TextHorizonScroller"):SetText(var_53_0.name)

		arg_53_2.ship_bg.hp_layer.desc.text.text = var_0_5:getNowLang("hp")
		arg_53_2.ship_bg.hp_layer.txt.text.text = var_0_9("%d/%d", var_53_0.now_hp, var_53_0.hp)
		arg_53_2.ship_bg.info_layer.type_txt.text.text = var_0_5:getNowLang(var_53_2)
		arg_53_2.ship_bg.info_layer.level_txt.text.text = var_0_9("LV.%d", var_53_0.level)
		arg_53_2.ship_bg.info_layer.country_txt.text.text = var_0_9("(%s)", var_0_5:getNowLang(var_0_3:get_country_language_key(var_53_1.country)))
		arg_53_2.ship_bg.mask_image.ship.image.sprite = self:loadSprite(var_53_3)
	end

	function arg_1_0:_is_have_boss_ship()
		local var_54_0 = false
		local var_54_1 = 0

		for iter_54_0, iter_54_1 in pairs(self._synthesis_need_ship_table) do
			var_54_1 = var_54_1 + 1
		end

		if var_54_1 == 2 then
			for iter_54_2, iter_54_3 in pairs({
				var_0_2.find_abyss_object_by_cid(var_0_1:find_abyss_character_by_id(self._synthesis_need_ship_table.id_1).cid).boss,
				var_0_2.find_abyss_object_by_cid(var_0_1:find_abyss_character_by_id(self._synthesis_need_ship_table.id_2).cid).boss
			}) do
				if iter_54_3 == 1 then
					var_54_0 = true
				end
			end
		end

		return var_54_0
	end

	function arg_1_0:_is_have_boss_ship_2()
		local var_55_0 = false
		local var_55_1 = 0

		for iter_55_0, iter_55_1 in pairs(self._abyss_synthesis_ship_info) do
			var_55_1 = var_55_1 + 1
		end

		if var_55_1 == 2 then
			for iter_55_2, iter_55_3 in pairs({
				var_0_2.find_abyss_object_by_cid(var_0_1:find_abyss_character_by_id(self._abyss_synthesis_ship_info[1].id).cid).boss,
				var_0_2.find_abyss_object_by_cid(var_0_1:find_abyss_character_by_id(self._abyss_synthesis_ship_info[2].id).cid).boss
			}) do
				if iter_55_3 == 1 then
					var_55_0 = true
				end
			end
		end

		return var_55_0
	end

	function arg_1_0:__long_click_goto_abyss_ship_detail(arg_56_1, arg_56_2)
		local var_56_0 = var_0_1:find_abyss_character_by_id(arg_56_2)
		local var_56_1 = var_56_0 and var_0_10.little_clone(var_56_0) or {}

		for iter_56_0, iter_56_1 in pairs(var_56_1) do
			if iter_56_0 == "equipment" then
				var_56_1.equips = var_56_1.k
			end
		end

		self:setVisible(false)
		var_0_4:createInstance("abyss_ship_detail"):show(arg_56_1, var_56_1)
	end

	function arg_1_0.__onclick_button_show_abyss_synthesis_explain(arg_57_0)
		var_0_4:createInstance("abyss_synthesis_explain"):show()
	end

	function arg_1_0._initialize_all_list(arg_58_0)
		arg_58_0._synthesis_need_ship_table = {}
		arg_58_0._get_star_list = {}
		arg_58_0._get_type_list = {}
		arg_58_0._you_can_get_type_list = {}
		arg_58_0._onclick_right_or_left_pos = 0
		arg_58_0._is_two_97_no_synthesis = false
	end

	function arg_1_0:init_remake_language()
		self._control.bg.middle_menu.remake_content.right.right_bg_1.text_layer.top_text.text.text = var_0_5:getNowLang("ui_ny21_reform_need_level")
		self._control.bg.middle_menu.remake_content.right.right_bg_1.text_layer.middle_text.text.text = var_0_5:getNowLang("ui_ny21_reform_need_item")
		self._control.bg.middle_menu.remake_content.right.right_bg_1.text_layer.floor_text.text.text = var_0_5:getNowLang("ui_ny21_reform_tip_1")
		self._control.bg.middle_menu.remake_content.right.right_bg_2.top_text.text.text = var_0_5:getNowLang("ui_ny21_reform_after")
		self._control.bg.middle_menu.remake_content.right.right_bg_2.skill.skill_stage.text.text = var_0_5:getNowLang("skillstage")

		for iter_59_0 = 1, self._control.bg.middle_menu.remake_content.right.right_bg_2.detail.transform.childCount do
			var_0_6(self._evo_res_contents, self._control.bg.middle_menu.remake_content.right.right_bg_2.detail.transform:GetChild(iter_59_0 - 1).gameObject)
		end

		self:__init_detail_attr_title(self._control.bg.middle_menu.remake_content.right.right_bg_2.detail)
		self:__init_ship_evo_detail()
	end

	function arg_1_0.__init_detail_attr_title(arg_60_0, arg_60_1)
		arg_60_1.attr_hp.hp.text.text = var_0_5:getNowLang("hp")
		arg_60_1.attr_atk.atk.text.text = var_0_5:getNowLang("atk")
		arg_60_1.attr_def.def.text.text = var_0_5:getNowLang("def")
		arg_60_1.attr_torpedo.torpedo.text.text = var_0_5:getNowLang("torpedo")
		arg_60_1.attr_miss.miss.text.text = var_0_5:getNowLang("miss")
		arg_60_1.attr_airdef.airdef.text.text = var_0_5:getNowLang("airdef")
		arg_60_1.attr_capacity.capacity.text.text = var_0_5:getNowLang("capacity")
		arg_60_1.attr_antisub.antisub.text.text = var_0_5:getNowLang("antisub")
		arg_60_1.attr_speed.speed.text.text = var_0_5:getNowLang("speed")
		arg_60_1.attr_radar.radar.text.text = var_0_5:getNowLang("radar")
		arg_60_1.attr_range.range.text.text = var_0_5:getNowLang("range")
		arg_60_1.attr_luck.luck.text.text = var_0_5:getNowLang("luck")
	end

	function arg_1_0:__init_ship_evo_detail()
		for iter_61_0 = 1, self._control.bg.middle_menu.remake_content.right.right_bg_2.detail.transform.childCount do
			var_0_6(self._evo_res_contents, self._control.bg.middle_menu.remake_content.right.right_bg_2.detail.transform:GetChild(iter_61_0 - 1).gameObject)
		end

		for iter_61_1, iter_61_2 in pairs(self._evo_res_contents) do
			iter_61_2.attr_num.text.text = "---"

			iter_61_2.tip_icon:SetActive(false)
			iter_61_2.attr_bg:SetActive(false)
			iter_61_2.tip_icon_down:SetActive(false)
			iter_61_2.attr_bg_down:SetActive(false)

			iter_61_2.attr_num.text.color = Color.New(0.23529411764705882, 0.6196078431372549, 1)
		end

		self._control.bg.middle_menu.remake_content.left.shipinfo.ship.gameObject:SetActive(false)

		self._control.bg.middle_menu.remake_content.right.right_bg_1.num_top_text.text.text.text = "---"
		self._control.bg.middle_menu.remake_content.right.right_bg_1.remoud_have_info.num_text.need_text.text.text = "---"
		self._control.bg.middle_menu.remake_content.right.right_bg_2.skill.skill_stage.skill_stage_text.text.text = "---"
		self._control.bg.middle_menu.remake_content.right.right_bg_1.remoud_have_info.num_text.sum_text.text.text = "/" .. var_0_1:get_item_count(10641)

		self._control.bg.middle_menu.remake_content.right.right_bg_2.skill.skill_image:SetActive(false)

		self._control.bg.middle_menu.remake_content.right.right_bg_2.skill.skill_name.title.title_1.text.text = "---"
		self._control.bg.middle_menu.remake_content.right.right_bg_2.skill.skill_name.title.title_2.text.text = ""
		self._control.bg.middle_menu.remake_content.right.right_bg_2.skill.scrollview.content.skill_desc.text.text = ""
		self._control.bg.middle_menu.remake_content.right.right_bg_2.skill.skill_level.left_level.text.text = "---"
		self._control.bg.middle_menu.remake_content.right.right_bg_2.skill.skill_level.right_level.text.text = "---"

		self._control.bg.middle_menu.remake_content.right.right_bg_2.streng_btn:SetActive(false)
	end

	function arg_1_0:set_ship_info(arg_62_1)
		self:__set_ship_info(arg_62_1)
	end

	function arg_1_0:__set_ship_info(arg_63_1)
		if arg_63_1 then
			self._data = var_0_2.find_abyss_object_by_cid(arg_63_1.cid)
			self._data2 = arg_63_1
		end

		self:__update_evo_info()
		self:__set_ship_attr()
	end

	function arg_1_0.__update_evo_info(arg_64_0)
		return
	end

	function arg_1_0:__set_ship_attr()
		for iter_65_0, iter_65_1 in pairs(self._evo_res_contents) do
			iter_65_1.tip_icon:SetActive(false)
			iter_65_1.attr_bg:SetActive(false)
			iter_65_1.tip_icon_down:SetActive(false)
			iter_65_1.attr_bg_down:SetActive(false)

			iter_65_1.attr_num.text.color = Color.New(0.23529411764705882, 0.6196078431372549, 1)
		end

		if not self._data then
			return
		end

		local var_65_0 = var_0_2.find_abyss_object_by_cid(self._data.cid + 1000000)
		local var_65_1 = var_0_2.find_abyss_object_by_cid(self._data.cid)

		self._ship_config = var_0_2.find_abyss_object_by_cid(self._data.cid)

		local var_65_2 = self._control.bg.middle_menu.remake_content.right.right_bg_2.detail
		local var_65_3 = self._control.bg.middle_menu.remake_content.right
		local var_65_4 = self._control.bg.middle_menu.remake_content.left.shipinfo.ship

		if var_65_0 ~= nil then
			var_65_2.attr_hp.attr_num.text.text = var_65_0.hp
			var_65_2.attr_atk.attr_num.text.text = var_65_0.atk
			var_65_2.attr_def.attr_num.text.text = var_65_0.def
			var_65_2.attr_torpedo.attr_num.text.text = var_65_0.torpedo
			var_65_2.attr_miss.attr_num.text.text = var_65_0.miss
			var_65_2.attr_airdef.attr_num.text.text = var_65_0.air_def
			var_65_2.attr_capacity.attr_num.text.text = var_65_0.capacity
			var_65_2.attr_antisub.attr_num.text.text = var_65_0.antisub
			var_65_2.attr_speed.attr_num.text.text = var_65_0.speed .. var_0_5:getNowLang("speedtext")
			var_65_2.attr_radar.attr_num.text.text = var_65_0.radar

			local var_65_5 = ""

			if var_65_0.range == var_0_3.range_type.none then
				var_65_5 = var_0_5:getNowLang("range0")
			elseif var_65_0.range == var_0_3.range_type.short then
				var_65_5 = var_0_5:getNowLang("range1")
			elseif var_65_0.range == var_0_3.range_type.middle then
				var_65_5 = var_0_5:getNowLang("range2")
			elseif var_65_0.range == var_0_3.range_type.long then
				var_65_5 = var_0_5:getNowLang("range3")
			elseif var_65_0.range == var_0_3.range_type.very_long then
				var_65_5 = var_0_5:getNowLang("range4")
			end

			var_65_2.attr_range.attr_num.text.text = var_65_5
			var_65_2.attr_luck.attr_num.text.text = var_65_0.luck

			var_65_4:SetActive(true)

			if var_65_0.hp > self._data.hp then
				var_65_2.attr_hp.tip_icon:SetActive(true)
				var_65_2.attr_hp.attr_bg:SetActive(true)

				var_65_2.attr_hp.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.atk > self._data.atk then
				var_65_2.attr_atk.tip_icon:SetActive(true)
				var_65_2.attr_atk.attr_bg:SetActive(true)

				var_65_2.attr_atk.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.def > self._data.def then
				var_65_2.attr_def.tip_icon:SetActive(true)
				var_65_2.attr_def.attr_bg:SetActive(true)

				var_65_2.attr_def.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.torpedo > self._data.torpedo then
				var_65_2.attr_torpedo.tip_icon:SetActive(true)
				var_65_2.attr_torpedo.attr_bg:SetActive(true)

				var_65_2.attr_torpedo.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.miss > self._data.miss then
				var_65_2.attr_miss.tip_icon:SetActive(true)
				var_65_2.attr_miss.attr_bg:SetActive(true)

				var_65_2.attr_miss.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.air_def > self._data.air_def then
				var_65_2.attr_airdef.tip_icon:SetActive(true)
				var_65_2.attr_airdef.attr_bg:SetActive(true)

				var_65_2.attr_airdef.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.capacity > self._data.capacity then
				var_65_2.attr_capacity.tip_icon:SetActive(true)
				var_65_2.attr_capacity.attr_bg:SetActive(true)

				var_65_2.attr_capacity.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.antisub > self._data.antisub then
				var_65_2.attr_antisub.tip_icon:SetActive(true)
				var_65_2.attr_antisub.attr_bg:SetActive(true)

				var_65_2.attr_antisub.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.speed > self._data.speed then
				var_65_2.attr_speed.tip_icon:SetActive(true)
				var_65_2.attr_speed.attr_bg:SetActive(true)

				var_65_2.attr_speed.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.radar > self._data.radar then
				var_65_2.attr_radar.tip_icon:SetActive(true)
				var_65_2.attr_radar.attr_bg:SetActive(true)

				var_65_2.attr_radar.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.range > self._data.range then
				var_65_2.attr_range.tip_icon:SetActive(true)
				var_65_2.attr_range.attr_bg:SetActive(true)

				var_65_2.attr_range.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.luck > self._data.luck then
				var_65_2.attr_luck.tip_icon:SetActive(true)
				var_65_2.attr_luck.attr_bg:SetActive(true)

				var_65_2.attr_luck.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.hp < self._data.hp then
				var_65_2.attr_hp.tip_icon_down:SetActive(true)
				var_65_2.attr_hp.attr_bg_down:SetActive(true)

				var_65_2.attr_hp.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.atk < self._data.atk then
				var_65_2.attr_atk.tip_icon_down:SetActive(true)
				var_65_2.attr_atk.attr_bg_down:SetActive(true)

				var_65_2.attr_atk.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.def < self._data.def then
				var_65_2.attr_def.tip_icon_down:SetActive(true)
				var_65_2.attr_def.attr_bg_down:SetActive(true)

				var_65_2.attr_def.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.torpedo < self._data.torpedo then
				var_65_2.attr_torpedo.tip_icon_down:SetActive(true)
				var_65_2.attr_torpedo.attr_bg_down:SetActive(true)

				var_65_2.attr_torpedo.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.miss < self._data.miss then
				var_65_2.attr_miss.tip_icon_down:SetActive(true)
				var_65_2.attr_miss.attr_bg_down:SetActive(true)

				var_65_2.attr_miss.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.air_def < self._data.air_def then
				var_65_2.attr_airdef.tip_icon_down:SetActive(true)
				var_65_2.attr_airdef.attr_bg_down:SetActive(true)

				var_65_2.attr_airdef.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.capacity < self._data.capacity then
				var_65_2.attr_capacity.tip_icon_down:SetActive(true)
				var_65_2.attr_capacity.attr_bg_down:SetActive(true)

				var_65_2.attr_capacity.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.antisub < self._data.antisub then
				var_65_2.attr_antisub.tip_icon_down:SetActive(true)
				var_65_2.attr_antisub.attr_bg_down:SetActive(true)

				var_65_2.attr_antisub.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.speed < self._data.speed then
				var_65_2.attr_speed.tip_icon_down:SetActive(true)
				var_65_2.attr_speed.attr_bg_down:SetActive(true)

				var_65_2.attr_speed.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.radar < self._data.radar then
				var_65_2.attr_radar.tip_icon_down:SetActive(true)
				var_65_2.attr_radar.attr_bg_down:SetActive(true)

				var_65_2.attr_radar.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.range < self._data.range then
				var_65_2.attr_range.tip_icon_down:SetActive(true)
				var_65_2.attr_range.attr_bg_down:SetActive(true)

				var_65_2.attr_range.attr_num.text.color = Color.New(1, 1, 1)
			end

			if var_65_0.luck < self._data.luck then
				var_65_2.attr_luck.tip_icon_down:SetActive(true)
				var_65_2.attr_luck.attr_bg:SetActive(true)

				var_65_2.attr_luck.attr_num.text.color = Color.New(1, 1, 1)
			end

			local var_65_6 = gameconfig.skill_config.find_object_by_skill_id(self._data.skill_id)
			local var_65_7 = gameconfig.skill_config.find_object_by_skill_id(var_65_0.skill_id)

			if var_65_6 and var_65_7 then
				var_65_3.right_bg_2.skill.skill_level.left_level.text.text = "Lv." .. var_65_6.skill_level
				var_65_3.right_bg_2.skill.skill_level.right_level.text.text = "Lv." .. var_65_7.skill_level
				var_65_3.right_bg_2.skill.skill_name.title.title_1.text.text = var_65_7.title

				var_65_3.right_bg_2.skill.skill_name.title:GetComponent("TextHorizonScroller"):SetText(var_65_7.title)

				var_65_3.right_bg_2.skill.scrollview.content.skill_desc.text.text = var_0_10.convert_rich_text(var_65_7.desc)
				var_65_3.right_bg_2.skill.skill_stage.skill_stage_text.text.text = var_65_6.phase_desc
			end

			local var_65_8 = var_0_9(var_0_3.skill_icon, var_65_1.skills[1])
			local var_65_9 = self:findPath(var_65_8) and self:loadSprite(var_65_8) or self:loadSprite(var_0_9(var_0_3.skill_default))

			var_65_3.right_bg_2.skill.skill_image:SetActive(true)

			var_65_3.right_bg_2.skill.skill_image.image.sprite = var_65_9
			var_65_3.right_bg_2.streng_btn:GetComponent("ScaleButton").enabled = true

			if var_0_1:get_item_count(10641) >= self._data.evo_need_resource[1].value then
				var_65_3.right_bg_2.streng_btn.image.sprite = self:loadSprite(var_0_3.abyss_select_ok_evo_image)

				var_65_3.right_bg_2.streng_btn.streng_btn_image:SetActive(false)
			else
				var_65_3.right_bg_2.streng_btn:GetComponent("ScaleButton").enabled = false
				var_65_3.right_bg_2.streng_btn.image.sprite = self:loadSprite(var_0_3.abyss_select_no_evo_image)

				var_65_3.right_bg_2.streng_btn.streng_btn_image:SetActive(true)
			end

			self._control.bg.middle_menu.remake_content.left.image.sprite = self:loadSprite(var_0_3.remake_abyss_select)
			self._control.bg.middle_menu.remake_content.left.shipinfo.ship.up.quality.image.sprite = self._data.boss == 1 and self:loadSprite(var_0_3.abyss_ui_path.main .. "abyss_ship_bg_L_2.png") or self:loadSprite(var_0_3.abyss_ui_path.main .. "abyss_ship_bg_L_1.png")
			var_65_3.right_bg_1.remoud_have_info.num_text.need_text.text.text = self._data.evo_need_resource[1].value
		else
			self:__init_ship_evo_detail()

			var_65_3.right_bg_2.streng_btn:GetComponent("ScaleButton").enabled = false
			var_65_3.right_bg_2.streng_btn.image.sprite = self:loadSprite(var_0_3.abyss_select_no_evo_image)

			var_65_3.right_bg_2.streng_btn.streng_btn_image:SetActive(true)
		end

		var_65_4.up.icon.image.sprite = self:loadSprite((var_0_3:get_ship_icon(var_0_10:use_big_break_painting(self._data, var_0_3.ship_icon_type.model_m, true), tostring(self._ship_config.pic_id), tostring(self._ship_config.pic_id))))
		var_65_4.detail.ship_type.text.text = var_0_5:getNowLang(var_0_3:get_ship_type_language_key(self._data.type, 1))
		var_65_4.detail.level.text.text = "LV." .. self._data.max_level
		var_65_4.detail.name_layer.name_bg.name_txt.text.text = self._data.name
		var_65_4.detail.hp_layer.count.text.text = var_0_9("%d/%d", self._data.hp, self._data.hp_max)

		var_65_4.detail.name_layer.name_bg:GetComponent("TextHorizonScroller"):SetText(self._data.title)

		var_65_4.detail.country.text.text = var_0_9("(%s)", var_0_5:getNowLang(var_0_3:get_country_language_key(self._data.country)))

		var_65_3.right_bg_2.streng_btn:SetActive(true)

		local var_65_11 = var_0_1:get_item_count(10641)

		for iter_65_2 = 1, var_65_4.detail.star_layer.transform.childCount do
			if iter_65_2 <= var_65_1.star then
				var_65_4.detail.star_layer.transform:GetChild(iter_65_2 - 1).gameObject:SetActive(true)
			else
				var_65_4.detail.star_layer.transform:GetChild(iter_65_2 - 1).gameObject:SetActive(false)
			end
		end

		self._control.bg.middle_menu.remake_content.left.shipinfo.ship.gameObject:SetActive(true)
	end

	function arg_1_0:get_evo_data()
		if self._data2 then
			local var_66_0 = var_0_1:find_abyss_character_by_id(self._data2.id)

			return var_66_0 and var_0_10.little_clone(var_66_0) or {}
		end

		return nil
	end

	function arg_1_0:__onReset()
		self._control.bg.top_menu.tab_toggle.tab_1.toggle.isOn = true
		self._control.bg.top_menu.tab_toggle.tab_3.toggle.isOn = false
		self._control.bg.top_menu.tab_toggle.tab_4.toggle.isOn = false
		self._is_already_init = false
		self._current_team_index = 1
		self._team_data = {}
		self._current_content_type = nil
		self.switch_content_not_first_team = false
		self._is_goto_formation = false
		self._is_goto_remake = false
		self._is_goto_synthesis = false
		self._synthesis_need_ship_table = {}
		self._get_star_list = {}
		self._get_type_list = {}
		self._you_can_get_type_list = {}
		self._star_layer_list = {}
		self._onclick_right_or_left_pos = 0
		self._evo_res_contents = {}
		self.evo_ship_data = {}
		self._data = nil
		self._ship_attr = {}
		self._no_ship_attr = {}
		self._evo_res_contents_detail = {}

		self:__destroy_info_list()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_68_0)
	local var_68_0 = var_0_4:class("abyss_dock_team")

	var_68_0._is_already_init = false
	var_68_0._current_team_index = 1
	var_68_0._team_data = {}
	var_68_0._info_list = {}
	var_68_0._current_content_type = nil
	var_68_0.switch_content_not_first_team = false
	var_68_0._is_goto_formation = false
	var_68_0._is_goto_remake = false
	var_68_0._is_goto_synthesis = false
	var_68_0._is_two_97_no_synthesis = false
	var_68_0._synthesis_need_ship_table = {}
	var_68_0._get_star_list = {}
	var_68_0._get_type_list = {}
	var_68_0._you_can_get_type_list = {}
	var_68_0._star_layer_list = {}
	var_68_0._onclick_right_or_left_pos = 0
	var_68_0._evo_res_contents = {}
	var_68_0.evo_ship_data = {}
	var_68_0._data = nil
	var_68_0._data2 = nil
	var_68_0._ship_attr = {}
	var_68_0._no_ship_attr = {}
	var_68_0._evo_res_contents_detail = {}
	var_68_0._abyss_synthesis_ship_info = nil

	gamecore.extend_obj(var_68_0)

	return var_68_0
end

return var_0_0
