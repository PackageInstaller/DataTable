local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_6 = table.insert
local var_0_7 = gameconfig.ship_config
local var_0_9 = gamecore.util_func
local var_0_10
local var_0_11
local var_0_12

gamecore.UILoader:define("captainroom_fleet", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
		self:setVisible(true)

		self._enter_title = arg_2_1
		self._enter_team = arg_2_2
		self._func_btn_text = arg_2_3
		self._func_btn_tip = arg_2_4
		self._func_btn_callback = arg_2_5
		self._is_active_station = arg_2_6 or false

		self:__init_panel()
	end

	function arg_1_0.show_fleet_layer(arg_3_0, arg_3_1)
		var_0_3:play_in_out_animation(var_0_10, arg_3_1, function()
			if not arg_3_1 then
				arg_3_0._control.bg:SetActive(false)
				arg_3_0:setVisible(false)

				local var_4_0 = var_0_1:getInstance("seven_sea_map")
				local var_4_1 = var_0_1:getInstance("eighth_sea_map")
				local var_4_2 = var_0_1:getInstance("cover")

				if var_4_0 and var_4_2 then
					var_4_2:setVisible(false)
					var_4_0._control.map_preview:SetActive(not arg_3_1)
				elseif var_4_1 and var_4_2 then
					var_4_2:setVisible(false)
					var_4_1._control.map_preview:SetActive(not arg_3_1)
					var_4_1._control.cloud_list:SetActive(true)
				end
			end
		end)
	end

	function arg_1_0:set_fleet_list()
		local var_5_0 = self._enter_team or var_0_4:get_captainroom_garrison()
		local var_5_1 = self._control.bg.role_list_1.transform

		self._team_character_data_list = {}

		for iter_5_0 = 0, var_5_1.childCount - 1 do
			var_5_1:GetChild(iter_5_0).gameObject:SetActive(false)
		end

		for iter_5_1, iter_5_2 in ipairs(var_0_12) do
			if var_5_0[iter_5_1] then
				if iter_5_1 > var_5_1.childCount then
					local var_5_2 = self:loadUI("single_select_team")

					var_5_2._panel.transform:SetParent(var_5_1, false)

					var_5_2._panel.transform:Find("BG"):GetComponent("Image").raycastTarget = true
					self._team_list[#self._team_list + 1] = var_5_2
				end

				local var_5_3 = var_0_4:find_character_by_id(var_5_0[iter_5_1])

				var_0_6(self._team_character_data_list, var_5_3)
				self._team_list[iter_5_1]._panel.gameObject:SetActive(true)
				self._team_list[iter_5_1]:show(var_5_3, (not self._is_active_station or nil) and (var_0_3.dock_team_toggle_type.captainroom_fleet or var_0_3.dock_team_toggle_type.active_station_fleet))
			end
		end

		self:draw_property_map()
	end

	function arg_1_0:show_func_btn(arg_6_1, arg_6_2, arg_6_3)
		if not arg_6_1 or not arg_6_2 then
			self._control.bg.func_btn.gameObject:SetActive(false)

			return
		end

		if arg_6_3 then
			self._control.bg.tip.text.text = arg_6_3
		end

		self._control.bg.func_btn.txt.text.text = arg_6_1

		self._control.bg.func_btn.button.onClick:RemoveAllListeners()
		self._control.bg.func_btn.button.onClick:AddListener(function()
			arg_6_2()
		end)
		self._control.bg.func_btn.gameObject:SetActive(true)
	end

	function arg_1_0:draw_property_map()
		local var_8_0 = {}

		var_8_0[1] = 0
		var_8_0[2] = 0
		var_8_0[3] = 0
		var_8_0[4] = 0
		var_8_0[5] = 0
		var_8_0[6] = 0

		for iter_8_0, iter_8_1 in ipairs(self._team_character_data_list) do
			local var_8_1 = var_0_9:get_ship_attr(iter_8_1, (var_0_7.find_object_by_cid(iter_8_1.cid)))

			var_8_0[1] = math.floor(((var_8_1.hp or nil) and (var_8_1.hp or 0)) + var_8_0[1])
			var_8_0[2] = math.floor(((var_8_1.radar or nil) and (var_8_1.radar or 0)) + var_8_0[2])
			var_8_0[3] = math.floor(((var_8_1.air_def or nil) and (var_8_1.air_def or 0)) + var_8_0[3])
			var_8_0[4] = math.floor(((var_8_1.def or nil) and (var_8_1.def or 0)) + var_8_0[4])
			var_8_0[5] = math.floor(((var_8_1.torpedo or nil) and (var_8_1.torpedo or 0)) + var_8_0[5])
			var_8_0[6] = math.floor(((var_8_1.atk or nil) and (var_8_1.atk or 0)) + var_8_0[6])
		end

		for iter_8_2, iter_8_3 in ipairs(var_0_11) do
			iter_8_3.value.text.text = "" .. var_8_0[iter_8_2]
		end

		local var_8_2 = self._control.bg.property.draw_web.uIPolygon
		local var_8_3 = self:__get_max_num_by_attr(var_8_0)

		for iter_8_4, iter_8_5 in ipairs(var_8_0) do
			var_8_2.VerticesDistances[iter_8_4 - 1] = iter_8_5 / var_8_3 > 1 and 1 or iter_8_5 / var_8_3
		end

		var_8_2:DrawPolygon(#var_0_11, var_8_2.VerticesDistances, 270)
	end

	function arg_1_0.select_ship_req(arg_9_0, arg_9_1)
		var_0_4:req_SaveGarrisonReq(arg_9_1)
	end

	function arg_1_0:disallowed_clicking()
		for iter_10_0, iter_10_1 in pairs(var_0_12) do
			iter_10_1:GetComponent("Button").enabled = true
		end

		if #self._enter_team < 6 then
			for iter_10_2 = #self._enter_team + 1, 6 do
				var_0_12[iter_10_2]:GetComponent("Button").enabled = false
			end
		end
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_constant()
			self:__init_language()
		end

		self:check_for_layer_order()
		self:set_fleet_list()
		self:show_func_btn(self._func_btn_text, self._func_btn_callback, self._func_btn_tip)
		self:show_fleet_layer(true)

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.bg.bg_container.title.text.text = self._enter_title or var_0_2:getNowLang("friendfleettitle")
		self._control.bg.property.title.text.text = var_0_2:getNowLang("pvepreparetotalprops")
		var_0_11[1].txt.text.text = var_0_2:getNowLang("hp")
		var_0_11[2].txt.text.text = var_0_2:getNowLang("radar")
		var_0_11[3].txt.text.text = var_0_2:getNowLang("airdef")
		var_0_11[4].txt.text.text = var_0_2:getNowLang("def")
		var_0_11[5].txt.text.text = var_0_2:getNowLang("torpedo")
		var_0_11[6].txt.text.text = var_0_2:getNowLang("atk")
		self._control.bg.tip.text.text = var_0_2:getNowLang("friendfleettip")
	end

	function arg_1_0:__init_constant()
		var_0_10 = self._control.bg.uITweenSequence
		var_0_11 = {
			self._control.bg.property.attr_item_1,
			self._control.bg.property.attr_item_2,
			self._control.bg.property.attr_item_3,
			self._control.bg.property.attr_item_4,
			self._control.bg.property.attr_item_5,
			self._control.bg.property.attr_item_6
		}
		var_0_12 = {
			self._control.bg.role_list.role_1,
			self._control.bg.role_list.role_2,
			self._control.bg.role_list.role_3,
			self._control.bg.role_list.role_4,
			self._control.bg.role_list.role_5,
			self._control.bg.role_list.role_6
		}
	end

	function arg_1_0:_play_into_se(arg_14_1)
		self:playSE(arg_14_1, false)
	end

	function arg_1_0.__get_max_num_by_attr(arg_15_0, arg_15_1)
		local var_15_0 = 0

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			if var_15_0 < iter_15_1 then
				var_15_0 = iter_15_1
			end
		end

		if var_15_0 <= var_0_3.captainroom_const.polygon_basic_num then
			var_15_0 = var_0_3.captainroom_const.polygon_basic_num
		end

		return var_15_0
	end

	function arg_1_0.__onReset(arg_16_0)
		arg_16_0._is_already_init = false
		arg_16_0._team_character_data_list = {}
	end

	function arg_1_0:check_for_layer_order()
		local var_17_0 = var_0_1:getInstance("score_push_map")

		if var_17_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_17_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		local var_17_1 = var_0_1:getInstance("eighth_sea_map")

		if var_17_1 then
			var_17_1._control.cloud_list:SetActive(false)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_18_0)
	local var_18_0 = var_0_1:class("captainroom_fleet")

	var_18_0._is_already_init = false
	var_18_0._team_list = {}
	var_18_0._team_character_data_list = {}
	var_18_0._is_active_station = false

	return var_18_0
end

return var_0_0
