local var_0_0 = {}
local var_0_1 = next
local var_0_2 = table.insert
local var_0_3 = table.remove
local var_0_4 = table.getn
local var_0_5 = lan_rand
local var_0_6 = lx.Time
local var_0_7 = gamecore.Language
local var_0_8 = gamecore.UILoader
local var_0_9 = gameenum.common_type
local var_0_10 = string.format
local var_0_11 = string.gsub
local var_0_12 = string.sub
local var_0_13 = string.find
local var_0_14 = string.lower
local var_0_15 = DG.Tweening.DOTween
local var_0_16 = UnityEngine.CanvasGroup
local var_0_17 = lx.clone_table

function var_0_0:set_shader_type(arg_1_1)
	if not self or not self.skeletonGraphic or not arg_1_1 then
		return
	end

	self.skeletonGraphic.material.shader = arg_1_1
end

function var_0_0.set_type_of_shader_tint(arg_2_0)
	var_0_0.set_shader_type(arg_2_0, var_0_9.shader_tint)
end

function var_0_0.show_what_panel(arg_3_0)
	local var_3_0 = var_0_8:getInstance(arg_3_0)

	if var_3_0 then
		var_3_0:setVisible(true)
	else
		var_3_0 = var_0_8:createInstance(arg_3_0)

		var_3_0:show()
	end

	return var_3_0
end

function var_0_0.return_home_with_menu_active()
	local var_4_0 = var_0_0.show_what_panel("home")
	local var_4_1 = var_0_8:getInstance("main_menu")

	if not var_4_1 then
		var_4_0:create_menu_panel()
	else
		var_4_1:setVisible(true)
	end

	return var_4_0, var_4_1
end

function var_0_0.clear_all_friend_visit_panel()
	var_0_8:destroyInstance("show_room")
	var_0_8:destroyInstance("captainroom")
	var_0_8:destroyInstance("music")
	var_0_8:destroyInstance("restaurant")
end

function var_0_0.play_home_bgm()
	var_0_8:createInstance("home"):into_home_bgm()
end

function var_0_0:add_canvas_group_component_to_panel()
	return self._panel:GetComponent(typeof(var_0_16)) or self._panel:AddComponent(typeof(var_0_16))
end

function var_0_0:get_or_add_canvas_group_component_to_it()
	return self:GetComponent(typeof(var_0_16)) or self:AddComponent(typeof(var_0_16))
end

function var_0_0:role_talk(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self.label_txt.text.text = ""

	return var_0_0.dialog_animation_play(self, var_0_0.set_dialog_box_width(self, arg_9_1, arg_9_2, arg_9_3), arg_9_4)
end

function var_0_0:dialog_animation_play(arg_10_1, arg_10_2)
	local var_10_0 = 1

	self.canvasGroup.alpha = 0

	if arg_10_1 then
		var_10_0 = #arg_10_1 * 0.03
	end

	local var_10_1 = var_0_15.Sequence()

	var_10_1:Append(self.canvasGroup:DOFade(1, 0.5))
	var_10_1:Append(self.label_txt.text:DOText(arg_10_1 or "", var_10_0))
	var_10_1:AppendInterval(var_10_0 + 3)

	if arg_10_2 then
		var_10_1:Append(self.canvasGroup:DOFade(0, 1))
	end

	var_10_1:OnKill(function()
		if self and not self:Equals(nil) and arg_10_2 then
			self:SetActive(false)
		end
	end)

	return var_10_1
end

function var_0_0:set_dialog_box_width(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = not (not arg_12_1 or arg_12_1 == "") and arg_12_1 or "                     \n                     "

	self.text.text = not (not arg_12_1 or arg_12_1 == "") and arg_12_1 or "                     \n                     "
	self.rectTransform.sizeDelta = Vector2.New(var_0_0.num_clamp(self.text.preferredWidth, arg_12_2, arg_12_3) + 2 * ((arg_12_4 or nil) and (1 / arg_12_4 or 2)), 0)

	return var_12_0
end

function var_0_0:calculate_angle_by_mouse_pos()
	local var_13_0 = self.y

	if self.x == 0 then
		return var_13_0 > 0 and 90 or 270
	end

	local var_13_1 = math.atan(var_13_0 / self.x) / math.pi * 180

	if self.x > 0 and var_13_0 >= 0 then
		return var_13_1
	elseif self.x < 0 and var_13_0 > 0 then
		return var_13_1 + 180
	elseif self.x < 0 and var_13_0 <= 0 then
		return 180 + var_13_1
	elseif self.x > 0 and var_13_0 < 0 then
		return var_13_1 + 360
	else
		return var_13_1
	end
end

function var_0_0.num_clamp(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 and arg_14_1 < arg_14_0 then
		return arg_14_1
	end

	if arg_14_2 and arg_14_0 < arg_14_2 then
		return arg_14_2
	end

	return arg_14_0
end

function var_0_0.get_team_data_by_team_id(arg_15_0)
	local var_15_0 = 0

	if arg_15_0 > 0 and arg_15_0 <= 4 then
		var_15_0 = 1
	elseif arg_15_0 > 4 and arg_15_0 <= 8 then
		var_15_0 = 2
	elseif arg_15_0 > 8 and arg_15_0 <= 12 then
		var_15_0 = 3
	end

	if var_15_0 == 0 then
		return
	end

	return gamecore.user:get_team_data(var_15_0, arg_15_0)
end

function var_0_0.check_single_team_member_change_saveable(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = 0

	if arg_16_1 then
		var_16_0 = arg_16_1.team_num and arg_16_1.team_num or 0
	end

	if arg_16_2[arg_16_0] and arg_16_2[arg_16_0] ~= 0 and var_16_0 ~= 0 and arg_16_3 ~= 0 and var_16_0 ~= arg_16_3 and var_16_0 <= 8 then
		local var_16_1 = var_0_0.get_team_data_by_team_id(var_16_0)
		local var_16_2 = var_16_1 and var_0_17(var_16_1) or {}
		local var_16_3

		if var_16_2 then
			var_16_3 = var_16_2.members or {}
		end

		local var_16_4 = 0

		for iter_16_0, iter_16_1 in pairs(var_16_3) do
			if iter_16_1 == arg_16_1.id then
				var_16_4 = iter_16_0
			end
		end

		var_16_3[var_16_4] = arg_16_2[arg_16_0]
		arg_16_2[arg_16_0] = arg_16_1.id

		if var_0_0.check_team_if_has_same_ship(arg_16_2) or var_0_0.check_team_if_has_same_ship(var_16_3) then
			gamecore.prompt:show(var_0_7:getNowLang("nosameshipinteam"))

			return false
		end

		return {
			id = arg_16_3,
			members = arg_16_2
		}
	end

	local var_16_5 = gamecore.user:get_team_data(1, 1)

	if arg_16_0 == 1 and var_0_4(arg_16_2) == 1 and not arg_16_1 and arg_16_3 == 1 then
		gamecore.prompt:show(var_0_7:getNowLang("errorcode_112"))

		return false
	elseif var_0_4(arg_16_2) ~= 1 and arg_16_1 and var_16_5.id == 1 and #var_16_5.members <= 1 and arg_16_1.id == var_16_5.members[1] and arg_16_3 ~= 1 then
		gamecore.prompt:show(var_0_7:getNowLang("errorcode_112"))

		return false
	end

	if arg_16_2[arg_16_0] then
		if arg_16_1 and not arg_16_1.is_exist then
			local var_16_6

			for iter_16_2, iter_16_3 in pairs(arg_16_2) do
				if iter_16_3 == arg_16_1.id then
					arg_16_2[iter_16_2], arg_16_2[arg_16_0] = arg_16_2[arg_16_0], iter_16_3
					var_16_6 = true

					break
				end
			end

			if not var_16_6 then
				arg_16_2[arg_16_0] = arg_16_1.id
			end
		else
			var_0_3(arg_16_2, arg_16_0)
		end
	else
		local var_16_7

		if arg_16_1 then
			local var_16_8 = gamecore.user:find_character_by_id(arg_16_1.id)

			if var_16_8 then
				var_16_7 = gameconfig.ship_config.find_object_by_cid(var_16_8.cid)
			end
		end

		local var_16_9

		for iter_16_4, iter_16_5 in pairs(arg_16_2) do
			local var_16_10 = gameconfig.ship_config.find_object_by_cid(gamecore.user:find_character_by_id(iter_16_5).cid)
			local var_16_11 = var_16_10.cid == var_16_7.cid or var_16_10.evo_cid == var_16_7.evo_cid

			if iter_16_5 ~= arg_16_1.id and var_16_11 then
				gamecore.prompt:show(var_0_7:getNowLang("nosameshipinteam"))

				return false
			elseif iter_16_5 == arg_16_1.id and var_16_11 then
				var_16_9 = iter_16_4
			end
		end

		if var_16_9 then
			var_0_3(arg_16_2, var_16_9)
		end

		var_0_2(arg_16_2, arg_16_1.id)
	end

	return {
		id = arg_16_3,
		members = arg_16_2
	}
end

function var_0_0.check_team_if_has_same_ship(arg_17_0)
	if not arg_17_0 then
		return false
	end

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0) do
		local var_17_1 = gameconfig.ship_config.find_object_by_cid(gamecore.user:find_character_by_id(iter_17_1).cid)

		if not var_17_0[var_17_1.evo_cid] then
			var_17_0[var_17_1.evo_cid] = 1
		else
			return true
		end
	end

	return false
end

function var_0_0.eliminate_repetitive_ships(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		if not var_18_1[iter_18_1.id] then
			var_18_1[iter_18_1.id] = true

			var_0_2(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function var_0_0.eliminate_repetitive_equips(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_0) do
		if not var_19_1[iter_19_1.id] then
			var_19_1[iter_19_1.id] = true

			var_0_2(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.incorporate_repetitive_equips(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_0) do
		if not var_20_1[iter_20_1.id] then
			if iter_20_1.num > 0 then
				var_20_1[iter_20_1.id] = true

				var_0_2(var_20_0, iter_20_1)
			end
		else
			for iter_20_2, iter_20_3 in pairs(var_20_0) do
				if iter_20_3.id == iter_20_1.id then
					iter_20_3.num = iter_20_3.num + iter_20_1.num
				end
			end
		end
	end

	return var_20_0
end

function var_0_0.check_team_if_has_member(arg_21_0)
	if arg_21_0 then
		for iter_21_0, iter_21_1 in pairs(arg_21_0) do
			if iter_21_1 ~= 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.dict_to_array(arg_22_0)
	local var_22_0 = {}

	if not arg_22_0 then
		return var_22_0
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0) do
		var_0_2(var_22_0, iter_22_1)
	end

	return var_22_0
end

function var_0_0.array_to_dict(arg_23_0)
	local var_23_0 = {}

	if not arg_23_0 or not var_0_1(arg_23_0) then
		return var_23_0
	end

	for iter_23_0, iter_23_1 in pairs(arg_23_0) do
		var_23_0[iter_23_1] = iter_23_1
	end

	return var_23_0
end

function var_0_0.dict_lenght(arg_24_0)
	local var_24_0 = 0

	if not arg_24_0 then
		return var_24_0
	end

	for iter_24_0, iter_24_1 in pairs(arg_24_0) do
		var_24_0 = var_24_0 + 1
	end

	return var_24_0
end

function var_0_0.concat_array(arg_25_0, arg_25_1)
	local var_25_0 = {}

	if arg_25_0 then
		for iter_25_0, iter_25_1 in pairs(arg_25_0) do
			var_0_2(var_25_0, iter_25_1)
		end
	end

	if arg_25_1 then
		for iter_25_2, iter_25_3 in pairs(arg_25_1) do
			var_0_2(var_25_0, iter_25_3)
		end
	end

	return var_25_0
end

function var_0_0.have_data(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_0) do
		if iter_26_1 == arg_26_1 then
			return true
		end
	end

	return false
end

function var_0_0.have_index(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in pairs(arg_27_0) do
		if iter_27_0 == arg_27_1 then
			return true
		end
	end

	return false
end

function var_0_0.get_index(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in pairs(arg_28_0) do
		if iter_28_1 == arg_28_1 then
			return iter_28_0
		end
	end
end

function var_0_0.get_repeat_table(arg_29_0, arg_29_1)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_0) do
		if var_0_0.have_data(arg_29_1, iter_29_1) then
			var_0_2(var_29_0, iter_29_1)
		end
	end

	return var_29_0
end

function var_0_0.get_diff_table(arg_30_0, arg_30_1)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(arg_30_0) do
		if not var_0_0.have_data(arg_30_1, iter_30_1) then
			var_0_2(var_30_0, iter_30_1)
		end
	end

	return var_30_0
end

function var_0_0:pick_random_from_array()
	return self[var_0_5(1, #self)]
end

function var_0_0:pick_loot_by_weight()
	if not self then
		return nil
	end

	local var_32_0 = 0
	local var_32_1 = self[1]
	local var_32_2 = 1

	if not self[1] then
		return nil
	end

	local var_32_3 = {}

	for iter_32_0, iter_32_1 in ipairs(self) do
		var_32_0 = var_32_0 + iter_32_1.weight

		var_0_2(var_32_3, var_32_0)
	end

	local var_32_4 = var_0_5(1, var_32_0)

	for iter_32_2, iter_32_3 in ipairs(var_32_3) do
		if var_32_4 <= iter_32_3 then
			var_32_1 = self[iter_32_2]
			var_32_2 = iter_32_2

			break
		end
	end

	return var_32_1, var_32_2
end

function var_0_0:pick_item_by_weight()
	if not self then
		return nil
	end

	local var_33_0 = self.weight_set[1]
	local var_33_1 = 1

	if not self.weight_set[1] then
		return nil
	end

	local var_33_2 = var_0_5(1, self.weight_total)

	for iter_33_0, iter_33_1 in ipairs(self.weight_set) do
		if var_33_2 <= iter_33_1.weight then
			var_33_0 = self.weight_set[iter_33_0]
			var_33_1 = iter_33_0

			break
		end
	end

	return var_33_0, var_33_1
end

function var_0_0.check_str_valid(arg_34_0)
	local var_34_0 = 1

	while var_34_0 <= #arg_34_0 do
		local var_34_1 = string.byte(arg_34_0, var_34_0)

		if var_34_1 < 48 or var_34_1 > 57 and var_34_1 < 65 or var_34_1 > 90 and var_34_1 < 97 or var_34_1 > 122 and var_34_1 < 128 then
			return false
		end

		if var_34_1 >= 128 then
			if #arg_34_0 < var_34_0 + 1 or #arg_34_0 < var_34_0 + 2 then
				return false
			end

			local var_34_2 = string.byte(arg_34_0, var_34_0)
			local var_34_3 = string.byte(arg_34_0, var_34_0 + 1)
			local var_34_4 = string.byte(arg_34_0, var_34_0 + 2)

			if var_34_2 < 228 or var_34_2 > 233 then
				return false
			elseif var_34_2 == 228 then
				if var_34_3 < 184 then
					return false
				elseif var_34_3 == 184 and var_34_4 < 128 then
					return false
				end
			elseif var_34_2 == 233 then
				if var_34_3 > 191 then
					return false
				elseif var_34_3 == 191 and var_34_4 > 191 then
					return false
				end
			end

			var_34_0 = var_34_0 + 3
		else
			var_34_0 = var_34_0 + 1
		end
	end

	return true
end

function var_0_0.check_card_str_valid(arg_35_0)
	if not arg_35_0 then
		return false
	end

	local var_35_0 = 1
	local var_35_1 = false

	while true do
		if #arg_35_0 < var_35_0 then
			break
		end

		local var_35_2 = string.byte(arg_35_0, var_35_0)

		if var_35_2 >= 228 and var_35_2 <= 233 then
			local var_35_3 = string.byte(arg_35_0, var_35_0 + 1)
			local var_35_4 = string.byte(arg_35_0, var_35_0 + 2)

			if var_35_3 and var_35_4 then
				local var_35_5 = 128
				local var_35_6 = 191
				local var_35_7 = 191

				if var_35_2 == 228 then
					var_35_5 = 184
				elseif var_35_2 == 233 then
					var_35_6, var_35_7 = 190, var_35_3 ~= 190 and 191 or 165
				end

				if var_35_5 <= var_35_3 and var_35_3 <= var_35_6 and 128 <= var_35_4 and var_35_4 <= var_35_7 then
					-- block empty
				end

				var_35_1 = true

				local var_35_8 = true
			end

			var_35_0 = var_35_0 + 3
		elseif var_35_2 == 194 or var_35_2 == 183 then
			var_35_1 = true
			var_35_8 = true
			var_35_0 = var_35_0 + 1
		else
			var_35_1 = false
			var_35_8 = false
			var_35_0 = var_35_0 + 1
		end
	end

	return var_35_1
end

function var_0_0.filter_spec_chars(arg_36_0, arg_36_1)
	local var_36_0 = false
	local var_36_1 = 1

	while true do
		if var_36_1 > #arg_36_1 then
			break
		end

		local var_36_2 = string.byte(arg_36_1, var_36_1)

		if not var_36_2 then
			break
		end

		if var_36_2 < 192 then
			if var_36_2 >= 48 and var_36_2 <= 57 or var_36_2 >= 65 and var_36_2 <= 90 or var_36_2 >= 97 and var_36_2 <= 122 or var_36_2 == 95 or var_36_2 == 45 then
				-- block empty
			else
				var_36_0 = true

				local var_36_3 = false
			end

			var_36_1 = var_36_1 + 1
		elseif var_36_2 == 194 or var_36_2 == 183 then
			var_36_0 = false
			var_36_3 = false
			var_36_1 = var_36_1 + 1
		elseif var_36_2 == 195 then
			var_36_0 = false
			var_36_3 = false
			var_36_1 = var_36_1 + 1
		elseif var_36_2 >= 208 and var_36_2 <= 212 then
			var_36_0 = false
			var_36_3 = false
			var_36_1 = var_36_1 + 1
		elseif var_36_2 < 224 then
			var_36_0 = true
			var_36_3 = false
			var_36_1 = var_36_1 + 2
		elseif var_36_2 < 240 then
			if var_36_2 >= 228 and var_36_2 <= 233 then
				local var_36_4 = string.byte(arg_36_1, var_36_1 + 1)
				local var_36_5 = string.byte(arg_36_1, var_36_1 + 2)

				if var_36_4 and var_36_5 then
					local var_36_6 = 128
					local var_36_7 = 191
					local var_36_8 = 191

					if var_36_2 == 228 then
						var_36_6 = 184
					elseif var_36_2 == 233 then
						var_36_7, var_36_8 = 190, var_36_4 ~= 190 and 191 or 165
					end

					if var_36_6 <= var_36_4 and var_36_4 <= var_36_7 and 128 <= var_36_5 and var_36_5 <= var_36_8 then
						-- block empty
					else
						var_36_0 = true
						var_36_3 = false
					end
				end
			end

			var_36_1 = var_36_1 + 3
		elseif var_36_2 < 248 then
			var_36_0 = true
			var_36_3 = false
			var_36_1 = var_36_1 + 4
		elseif var_36_2 < 252 then
			var_36_0 = true
			var_36_3 = false
			var_36_1 = var_36_1 + 5
		elseif var_36_2 < 254 then
			var_36_0 = true
			var_36_3 = false
			var_36_1 = var_36_1 + 6
		end
	end

	return var_36_0
end

function var_0_0.string_split(arg_37_0, arg_37_1)
	local var_37_0 = {}

	string.gsub(arg_37_0, "[^" .. arg_37_1 .. "]+", function(arg_38_0)
		table.insert(var_37_0, arg_38_0)
	end)

	return var_37_0
end

function var_0_0.unpack_global_config_value(arg_39_0)
	return loadstring("return " .. arg_39_0)()
end

function var_0_0:check_in_forbitan(arg_40_1)
	local var_40_0 = self:lower()

	for iter_40_0, iter_40_1 in pairs((arg_40_1.get_sequence())) do
		if var_40_0:find(iter_40_1.id:lower(), 1, true) then
			return true
		end
	end

	return false
end

function var_0_0.name_filter_match(arg_41_0, arg_41_1)
	return var_0_13(var_0_14(arg_41_0), var_0_14(arg_41_1)) ~= nil
end

function var_0_0.split(arg_42_0, arg_42_1)
	arg_42_0 = tostring(arg_42_0)
	arg_42_1 = tostring(arg_42_1)

	if arg_42_1 == "" then
		return false
	end

	local var_42_0 = 0
	local var_42_1 = {}

	for iter_42_0, iter_42_1 in function()
		return string.find(arg_42_0, arg_42_1, var_42_0, true)
	end do
		table.insert(var_42_1, string.sub(arg_42_0, var_42_0, iter_42_0 - 1))

		var_42_0 = iter_42_1 + 1
	end

	table.insert(var_42_1, string.sub(arg_42_0, var_42_0))

	return var_42_1
end

function var_0_0.check_str_all_number(arg_44_0)
	if arg_44_0 == nil then
		return false
	end

	while 1 <= #arg_44_0 do
		local var_44_0 = string.byte(arg_44_0, 1)

		if var_44_0 < 48 or var_44_0 > 57 then
			return false
		end
	end

	return true, 1
end

function var_0_0.now_week_time()
	local var_45_0 = var_0_6:getDate()

	var_45_0.day = var_45_0.day - var_45_0.wday + 1
	var_45_0.hour = 0
	var_45_0.min = 0
	var_45_0.sec = 0

	return var_0_6:tmObjToUtcTime(var_45_0)
end

function var_0_0.now_day_time()
	local var_46_0 = var_0_6:getDate()

	var_46_0.hour = 0
	var_46_0.min = 0
	var_46_0.sec = 0

	return var_0_6:tmObjToUtcTime(var_46_0)
end

function var_0_0.get_date_by_time(arg_47_0)
	return (os.date("*t", arg_47_0))
end

function var_0_0:check_in_same_day(arg_48_1)
	return self.year == arg_48_1.year and self.month == arg_48_1.month and self.day == arg_48_1.day
end

function var_0_0.check_can_daily_refresh(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	local var_49_0 = var_0_0.get_date_by_time(var_0_0.now_day_time(arg_49_2, arg_49_3, arg_49_4))
	local var_49_1 = var_0_0.get_date_by_time(arg_49_0)
	local var_49_2 = var_0_0.get_date_by_time(arg_49_1)
	local var_49_3 = var_0_0.check_in_same_day(var_49_1, var_49_2)

	if var_49_3 == true then
		if (var_49_1.hour < var_49_0.hour or var_49_1.hour == var_49_0.hour and var_49_1.min < var_49_0.min or var_49_1.hour == var_49_0.hour and var_49_1.min == var_49_0.min and var_49_1.sec < var_49_0.sec) and (var_49_0.hour < var_49_2.hour or var_49_0.hour == var_49_2.hour and var_49_0.min < var_49_2.min or var_49_0.hour == var_49_2.hour and var_49_0.min == var_49_2.min and var_49_0.sec <= var_49_2.sec) then
			return true
		end
	elseif var_49_3 == false then
		local var_49_4 = var_0_0.get_diff_day(arg_49_0, arg_49_1)

		if var_49_4 == 1 then
			if var_49_0.hour < var_49_2.hour or var_49_0.hour == var_49_2.hour and var_49_0.min < var_49_2.min or var_49_0.hour == var_49_2.hour and var_49_0.min == var_49_2.min and var_49_0.sec <= var_49_2.sec or var_49_1.hour < (var_49_0 - 86400).hour or var_49_1.hour == (var_49_0 - 86400).hour and var_49_1.min < (var_49_0 - 86400).min or var_49_1.hour == (var_49_0 - 86400).hour and var_49_1.min == (var_49_0 - 86400).min and var_49_1.sec < (var_49_0 - 86400).sec then
				return true
			end
		elseif var_49_4 > 1 then
			return true
		end
	end

	return false
end

function var_0_0.check_can_week_refresh(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	if var_0_0.get_date_by_time(arg_50_1).wday ~= 1 then
		return false
	end

	return var_0_0.check_can_daily_refresh(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
end

function var_0_0.check_can_month_refresh(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	if var_0_0.get_date_by_time(arg_51_1).day ~= 1 then
		return false
	end

	return var_0_0.check_can_daily_refresh(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4)
end

function var_0_0.get_year_days(arg_52_0)
	return (arg_52_0 % 4 == 0 and arg_52_0 % 100 ~= 0 or arg_52_0 % 400 == 0) and 366 or 365
end

function var_0_0.get_diff_day(arg_53_0, arg_53_1)
	local var_53_0 = var_0_0.get_date_by_time(arg_53_0)
	local var_53_1 = var_0_0.get_date_by_time(arg_53_1)
	local var_53_2 = 0
	local var_53_3 = 0
	local var_53_4 = 0

	if var_53_0.year - var_53_1.year > 0 then
		var_53_2 = var_53_0.year + 1
		var_53_3 = var_53_1.year - 1
		var_53_4 = var_0_0.get_year_days(var_53_0.year) + var_0_0.get_year_days(var_53_1.year) - var_53_0.yday - var_53_1.yday
	elseif var_53_0.year - var_53_1.year < 0 then
		var_53_2 = var_53_1.year + 1
		var_53_3 = var_53_0.year - 1
		var_53_4 = var_0_0.get_year_days(var_53_0.year) + var_0_0.get_year_days(var_53_1.year) - var_53_0.yday - var_53_1.yday
	else
		var_53_4 = math.abs(var_53_0.yday - var_53_1.yday)
	end

	for iter_53_0 = var_53_2, var_53_3 do
		var_53_4 = var_53_4 + var_0_0.get_year_days(iter_53_0)
	end

	return math.abs(var_53_4)
end

function var_0_0.check_in_zero_time(...)
	return lx.ServerTime:getUtcTime() == var_0_0.now_daytime_start(0)
end

function var_0_0.now_daytime_end(arg_55_0)
	local var_55_0 = os.date("*t", (lx.ServerTime:getUtcTime()))

	var_55_0.hour = 0
	var_55_0.min = 0
	var_55_0.sec = 0

	return (tonumber(os.time(var_55_0) + 86400))
end

function var_0_0.get_new_date(arg_56_0)
	if arg_56_0 == nil or arg_56_0 == "" or arg_56_0 == 0 then
		return 0
	end

	local var_56_0

	if type(arg_56_0) ~= "string" or string.len(arg_56_0) < 19 then
		do return 0 end

		var_56_0 = {}
	end

	var_56_0.year = string.sub(arg_56_0, 1, 4)
	var_56_0.month = string.sub(arg_56_0, 6, 7)
	var_56_0.day = string.sub(arg_56_0, 9, 10)
	var_56_0.hour = string.sub(arg_56_0, 12, 13)
	var_56_0.min = string.sub(arg_56_0, 15, 16)
	var_56_0.sec = string.sub(arg_56_0, 18, 19)

	return os.time(var_56_0)
end

function var_0_0.secondsToTime(arg_57_0)
	local var_57_0 = math.floor(arg_57_0 / 60)
	local var_57_1 = math.floor(var_57_0 / 60)
	local var_57_2 = ""

	var_57_2 = arg_57_0 % 60 > 0 and (arg_57_0 % 60 >= 10 and "" .. arg_57_0 % 60 or "0" .. arg_57_0 % 60) or "00"

	local var_57_3 = var_57_0 - var_57_1 * 60

	var_57_2 = var_57_0 - var_57_1 * 60 > 0 and (var_57_3 >= 10 and var_57_3 .. ":" .. var_57_2 or "0" .. var_57_3 .. ":" .. var_57_2) or "00:" .. var_57_2
	var_57_2 = var_57_1 > 0 and (var_57_1 >= 10 and var_57_1 .. ":" .. var_57_2 or "0" .. var_57_1 .. ":" .. var_57_2) or "00:" .. var_57_2

	return var_57_2
end

function var_0_0.threshold(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_2 and arg_58_2 < arg_58_0 then
		arg_58_0 = arg_58_2
	end

	if arg_58_1 and arg_58_0 < arg_58_1 then
		arg_58_0 = arg_58_1
	end

	return arg_58_0
end

local var_0_18 = 1e-07

function var_0_0.isLTZero(arg_59_0)
	if arg_59_0 < var_0_18 then
		return true
	end

	return false
end

function var_0_0.isMTZero(arg_60_0)
	if arg_60_0 > var_0_18 * -1 then
		return true
	end

	return false
end

function var_0_0.isEqZero(arg_61_0)
	if arg_61_0 <= var_0_18 and arg_61_0 >= var_0_18 * -1 then
		return true
	end

	return false
end

function var_0_0.serialize(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_1

	if arg_62_1 == nil then
		var_62_0 = {}
	end

	local var_62_1 = type(arg_62_0)

	if var_62_1 == "number" then
		table.insert(var_62_0, arg_62_0)
	elseif var_62_1 == "boolean" then
		table.insert(var_62_0, tostring(arg_62_0))
	elseif var_62_1 == "string" then
		table.insert(var_62_0, string.format("%q", arg_62_0))
	elseif var_62_1 == "table" then
		table.insert(var_62_0, "{\n")

		for iter_62_0, iter_62_1 in pairs(arg_62_0) do
			table.insert(var_62_0, "[")
			var_0_0.serialize(iter_62_0, var_62_0)
			table.insert(var_62_0, "]=")
			var_0_0.serialize(iter_62_1, var_62_0)
			table.insert(var_62_0, ",\n")
		end

		local var_62_2 = getmetatable(arg_62_0)

		if var_62_2 ~= nil and type(var_62_2.__index) == "table" then
			for iter_62_2, iter_62_3 in pairs(var_62_2.__index) do
				table.insert(var_62_0, "[")
				var_0_0.serialize(iter_62_2, var_62_0)
				table.insert(var_62_0, "]=")
				var_0_0.serialize(iter_62_3, var_62_0)
				table.insert(var_62_0, ",\n")
			end
		end

		table.insert(var_62_0, "}")
	elseif var_62_1 == "nil" then
		return nil
	else
		error("can not serialize a " .. var_62_1 .. " type.")
	end

	if arg_62_1 == nil then
		return table.concat(var_62_0)
	end
end

function var_0_0.unserialize(arg_63_0)
	local var_63_0 = type(arg_63_0)

	if var_63_0 == "nil" or arg_63_0 == "" then
		return nil
	else
		arg_63_0 = (var_63_0 == "number" or var_63_0 == "string" or var_63_0 == "boolean") and tostring(arg_63_0) or arg_63_0
	end

	arg_63_0 = "return " .. arg_63_0

	local var_63_1 = load(arg_63_0)

	if var_63_1 == nil then
		return nil
	end

	return var_63_1()
end

function var_0_0.band(arg_64_0, arg_64_1)
	return bit_and(arg_64_0, arg_64_1)
end

function var_0_0.bor(arg_65_0, arg_65_1)
	return bit_or(arg_65_0, arg_65_1)
end

function var_0_0.bnot(arg_66_0)
	return bit_not(arg_66_0)
end

function var_0_0.lshift(arg_67_0, arg_67_1)
	return bit_left_shift(arg_67_0, arg_67_1)
end

function var_0_0.table_unpack(arg_68_0)
	if unpack then
		return unpack(arg_68_0)
	else
		table.unpack(arg_68_0)
	end
end

function var_0_0.is_prob(arg_69_0)
	return arg_69_0 >= var_0_5(0, 100) / 100
end

function var_0_0.chance(arg_70_0)
	return var_0_0.is_prob(arg_70_0 / 100)
end

function var_0_0.threshold(arg_71_0, arg_71_1, arg_71_2)
	if arg_71_2 and arg_71_2 < arg_71_0 then
		arg_71_0 = arg_71_2
	end

	if arg_71_1 and arg_71_0 < arg_71_1 then
		arg_71_0 = arg_71_1
	end

	return arg_71_0
end

function var_0_0.str_to_table(arg_72_0)
	if arg_72_0 == nil or arg_72_0 == "" or type(arg_72_0) ~= "string" then
		return {}
	end

	return loadstring("return " .. arg_72_0)()
end

function var_0_0:table_to_string(arg_73_1, arg_73_2)
	local var_73_0 = {}

	if arg_73_1 == "array" then
		for iter_73_0, iter_73_1 in pairs(self) do
			local var_73_1 = {}

			for iter_73_2, iter_73_3 in pairs(arg_73_2) do
				table.insert(var_73_1, iter_73_1[iter_73_3])
			end

			table.insert(var_73_0, var_73_1)
		end
	elseif arg_73_1 == "table" then
		var_73_0 = self
	elseif arg_73_1 == "table2" then
		for iter_73_4, iter_73_5 in pairs(arg_73_2) do
			table.insert(var_73_0, self[iter_73_5])
		end
	end

	if var_73_0 == nil or var_73_0 == {} then
		return ""
	end

	local var_73_2 = "{"
	local var_73_3 = 1

	for iter_73_6, iter_73_7 in pairs(var_73_0) do
		local var_73_4 = ","

		if var_73_3 == 1 then
			var_73_4 = ""
		end

		var_73_2 = type(iter_73_7) == "table" and var_73_2 .. var_73_4 .. var_0_0.table_to_string(iter_73_7, "table") or var_73_2 .. var_73_4 .. tostring(iter_73_7)
		var_73_3 = var_73_3 + 1
	end

	return (var_73_3 == 1 or nil) and ""
end

function var_0_0:pick_loot_by_weight()
	if not self then
		return nil
	end

	local var_74_0 = 0
	local var_74_1 = self[1]
	local var_74_2 = 1

	if not self[1] then
		return nil
	end

	local var_74_3 = {}

	for iter_74_0, iter_74_1 in ipairs(self) do
		var_74_0 = var_74_0 + iter_74_1.weight

		var_0_2(var_74_3, var_74_0)
	end

	local var_74_4 = var_0_5(1, var_74_0)

	for iter_74_2, iter_74_3 in ipairs(var_74_3) do
		if var_74_4 <= iter_74_3 then
			var_74_1 = self[iter_74_2]
			var_74_2 = iter_74_2

			break
		end
	end

	return var_74_1, var_74_2
end

function var_0_0.get_ui_camera()
	return var_0_8:getUIRoot().parent.transform:Find("UICamera"):GetComponent("Camera")
end

function var_0_0.get_ui_root_canvas_rect()
	return var_0_8:getUIRoot().parent.transform:GetComponent("RectTransform")
end

function var_0_0.get_simplify_num(arg_77_0)
	if math.floor(arg_77_0 / 1000000) > 0 then
		local var_77_0, var_77_1 = math.modf(math.modf(arg_77_0 / 100000) / 10)

		var_77_0 = var_77_1 == 0 and var_77_0 .. ".0" or var_77_0 + var_77_1

		return var_77_0 .. "M"
	end

	if math.floor(arg_77_0 / 100000) > 0 then
		local var_77_2, var_77_3 = math.modf(math.modf(arg_77_0 / 100) / 10)

		var_77_2 = var_77_3 == 0 and var_77_2 .. ".0" or var_77_2 + var_77_3

		return var_77_2 .. "K"
	end

	return arg_77_0
end

function var_0_0._time_format(arg_78_0)
	local var_78_0 = lx.ServerTime:getUtcTime()
	local var_78_2 = tonumber(os.date("%M", var_78_0))
	local var_78_3 = tonumber(os.date("%M", arg_78_0))
	local var_78_4 = math.abs(tonumber(os.date("%H", var_78_0)) - tonumber(os.date("%H", arg_78_0)))
	local var_78_5 = math.abs(var_78_2 - var_78_3)

	return math.abs(tonumber(os.date("%d", var_78_0)) - tonumber(os.date("%d", arg_78_0))) > 0 and os.date("%Y-%m-%d\n%H:%M:%S", arg_78_0) or var_78_4 > 0 and (var_78_4 == 1 and (math.abs(60 - var_78_3 + var_78_2) >= 60 and string.format("%s 时前", var_78_4) or string.format("%s 分前", 60 - var_78_3 + var_78_2)) or math.abs(60 - var_78_3 + var_78_2) >= 60 and string.format("%s 时前", var_78_4) or string.format("%s 时前", var_78_4 - 1)) or var_78_5 == 0 and string.format("%s ", var_0_7:getNowLang("recently")) or string.format("%s 分前", var_78_5)
end

function var_0_0._get_interval_time_format(arg_79_0)
	local var_79_0 = true

	if arg_79_0 == 0 then
		return var_79_0
	end

	local var_79_1

	if lx.ServerTime:getUtcTime() < arg_79_0 then
		var_79_0 = false
		var_79_1 = os.date("%Y-%m-%d", arg_79_0)
	end

	return var_79_0, var_79_1
end

function var_0_0._get_open_time(arg_80_0, arg_80_1)
	local var_80_0 = lx.ServerTime:getUtcTime()

	if arg_80_0 == "0" and arg_80_1 == "0" then
		return true
	end

	if arg_80_0 == 0 and arg_80_1 == 0 then
		return true
	end

	if not tonumber(arg_80_0) then
		arg_80_0 = var_0_0.get_new_date(arg_80_0)
	end

	if not tonumber(arg_80_1) then
		arg_80_1 = var_0_0.get_new_date(arg_80_1)
	end

	if var_80_0 >= tonumber(arg_80_0) and var_80_0 <= arg_80_1 then
		return true
	end

	return false
end

function var_0_0.convert_rich_text(arg_81_0, arg_81_1)
	return (var_0_11(var_0_11(arg_81_0, "%^C[^%^]+", function(arg_82_0)
		local var_82_0 = var_0_12(arg_82_0, 3, 10)

		if arg_81_1 and var_82_0 ~= "454545FF" then
			var_82_0 = arg_81_1
		end

		return var_0_10("<color=#%s>%s</color>", var_82_0, (var_0_12(arg_82_0, 19, #arg_82_0)))
	end), "{%d}", "%%s"))
end

function var_0_0.convert_rich_text2(arg_83_0, arg_83_1)
	return (var_0_11(var_0_11(arg_83_0, "%^C[^%^]+", function(arg_84_0)
		local var_84_0 = var_0_12(arg_84_0, 3, 10)

		if var_84_0 == "454545FF" then
			var_84_0 = "45454500"
		end

		if var_84_0 == "1C8BE5FF" then
			var_84_0 = "1C8BE500"
		end

		return var_0_10("<color=#%s>%s</color>", var_84_0, (var_0_12(arg_84_0, 19, #arg_84_0)))
	end), "{%d}", "%%s"))
end

function var_0_0.only_extract_word(arg_85_0)
	return (var_0_11(arg_85_0, "%^C[^%^]+", function(arg_86_0)
		return (var_0_12(arg_86_0, 19, #arg_86_0))
	end))
end

function var_0_0.parseSpecialWord(arg_87_0)
	while var_0_13(arg_87_0, "#s") do
		local var_87_0, var_87_1 = var_0_13(arg_87_0, "#s")
		local var_87_2 = var_0_12(arg_87_0, var_87_1 + 1, var_87_1 + 8)

		arg_87_0 = var_0_11(arg_87_0, var_87_2, gameconfig.ship_config.find_object_by_cid(tonumber(var_87_2)).title)
		arg_87_0 = var_0_11(arg_87_0, "%#s", "", 1)
		arg_87_0 = var_0_11(arg_87_0, "%#n", "", 1)
	end

	return arg_87_0
end

function var_0_0._get_receive_time(arg_88_0)
	return "(" .. tonumber(os.date("%Y", arg_88_0)) .. "." .. tonumber(os.date("%m", arg_88_0)) .. "." .. tonumber(os.date("%d", arg_88_0)) .. ")"
end

function var_0_0.convert_decimals(arg_89_0)
	local var_89_0, var_89_1 = math.modf(arg_89_0)

	if var_89_1 > 0 then
		return var_0_10("%0.1f", arg_89_0), var_89_1
	else
		return var_0_10("%s", arg_89_0), 0
	end
end

function var_0_0.convert_resert_decimals(arg_90_0)
	local var_90_0, var_90_1 = math.modf(arg_90_0)

	if var_90_1 > 0 then
		return math.floor(arg_90_0 * 100) / 100, var_90_1
	else
		return var_0_10("%s", arg_90_0), 0
	end
end

function var_0_0._str_length(arg_91_0)
	if not arg_91_0 or type(arg_91_0) ~= "string" or #arg_91_0 <= 0 then
		return nil
	end

	local var_91_0 = 0
	local var_91_1 = 1

	repeat
		local var_91_2 = string.byte(arg_91_0, var_91_1)

		var_91_1 = var_91_1 + (var_91_2 > 239 and 4 or var_91_2 > 223 and 3 or var_91_2 > 128 and 2 or 1)
		var_91_0 = var_91_0 + 1
	until var_91_1 > #arg_91_0

	return var_91_0
end

function var_0_0._str_insert(arg_92_0, arg_92_1, arg_92_2, arg_92_3)
	if arg_92_3 and string.find(arg_92_0, arg_92_3) ~= nil then
		arg_92_1 = arg_92_1 + #arg_92_3
	end

	return (string.format("%s%s%s", string.sub(arg_92_0, 1, arg_92_1 - 1), arg_92_2, (string.sub(arg_92_0, arg_92_1, -1))))
end

function var_0_0.use_big_break_painting(arg_93_0, arg_93_1, arg_93_2, arg_93_3, arg_93_4)
	local var_93_0

	local function var_93_1(arg_94_0)
		if arg_94_0 == gameenum.common_type.ship_icon_type.model_l then
			var_93_0 = gameenum.common_type.ship_icon.model_normal_l

			if arg_93_4 ~= nil and arg_93_4 == true then
				var_93_0 = gameenum.common_type.ship_icon.model_normal_l_battle
			end
		elseif arg_94_0 == gameenum.common_type.ship_icon_type.model_m then
			var_93_0 = gameenum.common_type.ship_icon.model_normal_m

			if arg_93_4 ~= nil and arg_93_4 == true then
				var_93_0 = gameenum.common_type.ship_icon.model_normal_m_battle
			end
		elseif arg_94_0 == gameenum.common_type.ship_icon_type.model_s then
			var_93_0 = gameenum.common_type.ship_icon.model_normal_s

			if arg_93_4 ~= nil and arg_93_4 == true then
				var_93_0 = gameenum.common_type.ship_icon.model_normal_s_battle
			end
		elseif arg_94_0 == gameenum.common_type.ship_icon_type.model_xm then
			var_93_0 = gameenum.common_type.ship_icon.model_normal_xm

			if arg_93_4 ~= nil and arg_93_4 == true then
				var_93_0 = gameenum.common_type.ship_icon.model_normal_xm_battle
			end
		elseif arg_94_0 == gameenum.common_type.ship_icon_type.model_l_hd then
			var_93_0 = gameenum.common_type.ship_icon.model_normal_l_hd

			if arg_93_4 ~= nil and arg_93_4 == true then
				var_93_0 = gameenum.common_type.ship_icon.model_normal_l_hd_battle
			end
		end

		return var_93_0
	end

	local var_93_2 = lx.UserData:getKeyData(var_0_9.setting_key_list.setting_broken)
	local var_93_3 = true

	if var_93_2 ~= "" and var_93_2 ~= " " then
		var_93_3 = lx.json_decode(var_93_2).value
	end

	if var_93_3 ~= "" and var_93_3 ~= " " and type(var_93_3) == "boolean" then
		var_93_3 = var_93_3 or false
	end

	if not gameenum.common_type.open_broken or not arg_93_3 or not arg_93_1 then
		return var_93_1(arg_93_2)
	end

	if not var_93_3 then
		return var_93_1(arg_93_2)
	end

	local var_93_4 = arg_93_1 and var_0_0.little_clone(arg_93_1) or {}

	var_93_4.now_hp = var_93_4.now_hp or var_93_4.hp

	if not ((var_93_4.cid or nil) and tonumber(string.sub(var_93_4.cid, 7)) == 18) and var_93_4.hp and var_93_4.now_hp and var_93_4.now_hp / var_93_4.hp < gameenum.common_type.health_sprite_rule.yellow.max_value then
		if arg_93_2 == gameenum.common_type.ship_icon_type.model_l then
			var_93_0 = gameenum.common_type.ship_icon.model_broken_l

			if arg_93_4 ~= nil and arg_93_4 == true then
				var_93_0 = gameenum.common_type.ship_icon.model_broken_l_battle
			end
		elseif arg_93_2 == gameenum.common_type.ship_icon_type.model_m then
			var_93_0 = gameenum.common_type.ship_icon.model_broken_m

			if arg_93_4 ~= nil and arg_93_4 == true then
				var_93_0 = gameenum.common_type.ship_icon.model_broken_m_battle
			end
		elseif arg_93_2 == gameenum.common_type.ship_icon_type.model_s then
			var_93_0 = gameenum.common_type.ship_icon.model_broken_s

			if arg_93_4 ~= nil and arg_93_4 == true then
				var_93_0 = gameenum.common_type.ship_icon.model_broken_s_battle
			end
		elseif arg_93_2 == gameenum.common_type.ship_icon_type.model_xm then
			var_93_0 = gameenum.common_type.ship_icon.model_broken_xm

			if arg_93_4 ~= nil and arg_93_4 == true then
				var_93_0 = gameenum.common_type.ship_icon.model_broken_xm_battle
			end
		elseif arg_93_2 == gameenum.common_type.ship_icon_type.model_l_hd then
			var_93_0 = gameenum.common_type.ship_icon.model_broken_l_hd

			if arg_93_4 ~= nil and arg_93_4 == true then
				var_93_0 = gameenum.common_type.ship_icon.model_broken_l_hd_battle
			end
		end

		return var_93_0
	end

	return var_93_1(arg_93_2)
end

function var_0_0.use_big_break_painting_2(arg_95_0, arg_95_1, arg_95_2, arg_95_3, arg_95_4)
	local var_95_0

	local function var_95_1(arg_96_0)
		if arg_96_0 == gameenum.common_type.ship_icon_type.model_l then
			var_95_0 = gameenum.common_type.ship_icon.model_normal_l

			if arg_95_4 ~= nil and arg_95_4 == true then
				var_95_0 = gameenum.common_type.ship_icon.model_normal_l_battle
			end
		elseif arg_96_0 == gameenum.common_type.ship_icon_type.model_m then
			var_95_0 = gameenum.common_type.ship_icon.model_normal_m

			if arg_95_4 ~= nil and arg_95_4 == true then
				var_95_0 = gameenum.common_type.ship_icon.model_normal_m_battle
			end
		elseif arg_96_0 == gameenum.common_type.ship_icon_type.model_s then
			var_95_0 = gameenum.common_type.ship_icon.model_normal_s

			if arg_95_4 ~= nil and arg_95_4 == true then
				var_95_0 = gameenum.common_type.ship_icon.model_normal_s_battle
			end
		elseif arg_96_0 == gameenum.common_type.ship_icon_type.model_xm then
			var_95_0 = gameenum.common_type.ship_icon.model_normal_xm

			if arg_95_4 ~= nil and arg_95_4 == true then
				var_95_0 = gameenum.common_type.ship_icon.model_normal_xm_battle
			end
		elseif arg_96_0 == gameenum.common_type.ship_icon_type.model_l_hd then
			var_95_0 = gameenum.common_type.ship_icon.model_normal_l_hd

			if arg_95_4 ~= nil and arg_95_4 == true then
				var_95_0 = gameenum.common_type.ship_icon.model_normal_l_hd_battle
			end
		end

		return var_95_0
	end

	if not gameenum.common_type.open_broken or not arg_95_3 or not arg_95_1 then
		return var_95_1(arg_95_2)
	end

	local var_95_2 = lx.UserData:getKeyData(var_0_9.setting_key_list.setting_broken)
	local var_95_3 = true

	if var_95_2 ~= "" and var_95_2 ~= " " then
		var_95_3 = lx.json_decode(var_95_2).value
	end

	if var_95_3 ~= "" and var_95_3 ~= " " and type(var_95_3) == "boolean" then
		var_95_3 = var_95_3 or false
	end

	if not var_95_3 then
		return var_95_1(arg_95_2)
	end

	local var_95_4 = arg_95_1 and var_0_0.little_clone(arg_95_1) or {}

	var_95_4.now_hp = var_95_4.now_hp or var_95_4.hp

	if var_95_4.hp and var_95_4.now_hp then
		if arg_95_2 == gameenum.common_type.ship_icon_type.model_l then
			var_95_0 = gameenum.common_type.ship_icon.model_broken_l

			if arg_95_4 ~= nil and arg_95_4 == true then
				var_95_0 = gameenum.common_type.ship_icon.model_broken_l_battle
			end
		elseif arg_95_2 == gameenum.common_type.ship_icon_type.model_m then
			var_95_0 = gameenum.common_type.ship_icon.model_broken_m

			if arg_95_4 ~= nil and arg_95_4 == true then
				var_95_0 = gameenum.common_type.ship_icon.model_broken_m_battle
			end
		elseif arg_95_2 == gameenum.common_type.ship_icon_type.model_s then
			var_95_0 = gameenum.common_type.ship_icon.model_broken_s

			if arg_95_4 ~= nil and arg_95_4 == true then
				var_95_0 = gameenum.common_type.ship_icon.model_broken_s_battle
			end
		elseif arg_95_2 == gameenum.common_type.ship_icon_type.model_xm then
			var_95_0 = gameenum.common_type.ship_icon.model_broken_xm

			if arg_95_4 ~= nil and arg_95_4 == true then
				var_95_0 = gameenum.common_type.ship_icon.model_broken_xm_battle
			end
		elseif arg_95_2 == gameenum.common_type.ship_icon_type.model_l_hd then
			var_95_0 = gameenum.common_type.ship_icon.model_broken_l_hd

			if arg_95_4 ~= nil and arg_95_4 == true then
				var_95_0 = gameenum.common_type.ship_icon.model_broken_l_hd_battle
			end
		end

		return var_95_0
	end

	return var_95_1(arg_95_2)
end

function var_0_0.get_skill_level_by_adjutant_level(arg_97_0)
	if arg_97_0 < 2 then
		-- block empty
	elseif arg_97_0 >= 2 and arg_97_0 < 5 then
		-- block empty
	elseif arg_97_0 >= 5 and arg_97_0 < 8 then
		-- block empty
	elseif arg_97_0 >= 8 then
		-- block empty
	end
end

function var_0_0.get_str_limit_state(arg_98_0)
	if not arg_98_0 or type(arg_98_0) ~= "string" or #arg_98_0 <= 0 then
		return nil
	end

	local var_98_0 = false
	local var_98_1 = false
	local var_98_2 = 1

	repeat
		local var_98_3 = string.byte(arg_98_0, var_98_2)
		local var_98_4 = 1

		if var_98_3 > 239 then
			var_98_4 = 4
		elseif var_98_3 > 223 then
			var_98_4 = 3
			var_98_0 = true
		elseif var_98_3 > 128 then
			var_98_4 = 2
		else
			var_98_4 = 1
			var_98_1 = true
		end

		var_98_2 = var_98_2 + var_98_4
	until var_98_2 > #arg_98_0

	return var_98_0, var_98_1
end

function var_0_0.little_clone(arg_99_0)
	local var_99_0 = {}

	if arg_99_0 then
		for iter_99_0, iter_99_1 in pairs(arg_99_0) do
			var_99_0[iter_99_0] = iter_99_1
		end
	end

	return var_99_0
end

function var_0_0.get_curr_exist_state(arg_100_0, arg_100_1)
	for iter_100_0, iter_100_1 in pairs(arg_100_0) do
		if iter_100_1 == arg_100_1 then
			return true
		end
	end

	return false
end

function var_0_0.get_curr_data_state_by_id(arg_101_0, arg_101_1)
	for iter_101_0, iter_101_1 in pairs(arg_101_0) do
		if iter_101_1.id == arg_101_1.id then
			return true
		end
	end

	return false
end

function var_0_0.get_value_greater_than_zero(arg_102_0)
	local var_102_0 = 0

	for iter_102_0, iter_102_1 in pairs(arg_102_0) do
		if iter_102_1 > 0 then
			var_102_0 = var_102_0 + 1
		end
	end

	return var_102_0
end

function var_0_0.calculate_utf8_char_length(arg_103_0)
	local var_103_0, var_103_1, var_103_2 = lx.utf8_charinfo(arg_103_0)

	return var_103_1 * 2 + var_103_2, var_103_0
end

function var_0_0.chsize(arg_104_0)
	if not arg_104_0 then
		print("not char")

		return 0
	elseif arg_104_0 > 240 then
		return 4
	elseif arg_104_0 > 225 then
		return 3
	elseif arg_104_0 > 192 then
		return 2
	else
		return 1
	end
end

function var_0_0.utf8len(arg_105_0)
	local var_105_0 = 0

	if not arg_105_0 then
		return var_105_0
	end

	while 1 <= #arg_105_0 do
		local var_105_1 = 1 + var_0_0.chsize((string.byte(arg_105_0, 1)))

		var_105_0 = var_105_0 + 1
	end

	return var_105_0
end

function var_0_0:utf8sub(arg_106_1, arg_106_2)
	local var_106_0 = 1

	while arg_106_1 > 1 do
		var_106_0 = var_106_0 + var_0_0.chsize((string.byte(self, var_106_0)))
		arg_106_1 = arg_106_1 - 1
	end

	local var_106_1 = var_106_0

	while arg_106_2 > 0 and var_106_1 <= #self do
		var_106_1 = var_106_1 + var_0_0.chsize((string.byte(self, var_106_1)))
		arg_106_2 = arg_106_2 - 1
	end

	return self:sub(var_106_0, var_106_1 - 1)
end

function var_0_0.is_add_hp(arg_107_0, arg_107_1, arg_107_2)
	local var_107_0 = {
		"hp",
		"atk",
		"def",
		"torpedo",
		"miss",
		"air_def",
		nil,
		nil,
		"antisub",
		"speed",
		"radar",
		"range",
		"luck",
		"hit_repair",
		"miss_repair",
		"crit_repair",
		"hit",
		"now_hp",
		"ext"
	}

	if not arg_107_1 then
		return
	end

	local var_107_1 = gamecore.user:get_attribute_effect_by_equip(arg_107_1.id)
	local var_107_2 = not arg_107_1.now_skill and gameconfig.skill_config.find_object_by_skill_id(arg_107_1.skill_id) or gameconfig.skill_config.find_object_by_skill_type_skill_level(arg_107_1.now_skill, arg_107_1.skill_level)
	local var_107_3
	local var_107_4
	local var_107_5 = 0
	local var_107_6 = false

	if var_107_2 and var_107_2.effect[1] then
		for iter_107_0, iter_107_1 in pairs(var_107_2.effect) do
			if var_107_2.effect[iter_107_0].type == 1 and var_107_2.effect[iter_107_0].stage[1] == 1 then
				for iter_107_2, iter_107_3 in pairs(var_107_2.effect[iter_107_0].effect) do
					if iter_107_3.type == 3 then
						for iter_107_4, iter_107_5 in pairs(var_107_0) do
							if iter_107_3[var_107_0[iter_107_4]] then
								var_107_3 = var_107_0[iter_107_4]
								var_107_4 = iter_107_3[var_107_0[iter_107_4]]
							end
						end

						if var_107_3 == "hp" then
							var_107_5 = var_107_5 + var_107_4
							var_107_6 = true
						end
					end
				end
			end
		end
	end

	arg_107_1.cid = arg_107_1.cid or arg_107_1.id

	for iter_107_6, iter_107_7 in pairs((arg_107_1 and arg_107_1.cid and tonumber(string.sub(arg_107_1.cid, 7)) == 18 or nil) and gamecore.user:get_abyss_attribute_effect_by_equip(arg_107_1.id)) do
		if iter_107_6 == "hp" and iter_107_7 ~= 0 then
			var_107_5 = var_107_5 + iter_107_7
			var_107_6 = true
		end
	end

	return var_107_6, var_107_5
end

function var_0_0.match_collection_ship_type(arg_108_0, arg_108_1, arg_108_2)
	if arg_108_1 == nil or arg_108_1 == 0 then
		return true
	end

	if type(arg_108_1) == "table" then
		if not var_0_1(arg_108_1) then
			return true
		end

		for iter_108_0, iter_108_1 in pairs(arg_108_1) do
			if iter_108_1 == 0 or iter_108_1 == arg_108_2 then
				return true
			end
		end

		return false
	end

	return arg_108_1 == arg_108_2
end

function var_0_0.caculate_ship_attr_with_equips(arg_109_0, arg_109_1)
	local var_109_0 = {
		"hp",
		"atk",
		"def",
		"torpedo",
		"miss",
		"air_def",
		nil,
		nil,
		"antisub",
		"speed",
		"radar",
		"range",
		"luck",
		"hit_repair",
		"miss_repair",
		"crit_repair",
		"hit",
		"now_hp",
		"ext"
	}
	local var_109_1 = arg_109_1.equips and lx.clone_table(arg_109_1.equips) or {}

	for iter_109_0, iter_109_1 in ipairs(var_109_1) do
		var_109_1[iter_109_0] = gameconfig.equip_config.find_object_by_cid(iter_109_1.id)
	end

	for iter_109_2, iter_109_3 in ipairs(var_109_1) do
		for iter_109_4, iter_109_5 in ipairs(var_109_0) do
			if arg_109_1[iter_109_5] and iter_109_3[iter_109_5] then
				arg_109_1[iter_109_5] = arg_109_1[iter_109_5] + iter_109_3[iter_109_5]
			end
		end
	end
end

function var_0_0.get_ship_attr(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0 = {
		"hp",
		"atk",
		"def",
		"torpedo",
		"miss",
		"air_def",
		nil,
		nil,
		"antisub",
		"speed",
		"radar",
		"range",
		"luck",
		"hit_repair",
		"miss_repair",
		"crit_repair",
		"hit",
		"now_hp",
		"ext"
	}
	local var_110_1
	local var_110_2

	if not arg_110_2 then
		if arg_110_1.equips then
			for iter_110_0, iter_110_1 in pairs(arg_110_1.equips) do
				local var_110_4 = gameconfig.equip_config.find_object_by_cid(iter_110_1)
			end

			var_110_1 = arg_110_1 and var_0_0.little_clone(arg_110_1) or {}
		end
	elseif arg_110_1 then
		if tonumber(string.sub(arg_110_1.cid, 7)) == 18 then
			local var_110_9 = gamecore.user:get_abyss_character_attribute_by_calculate(arg_110_1.id)

			var_110_1 = var_110_9 and var_0_0.little_clone(var_110_9) or {}

			local var_110_10 = gamecore.user:get_abyss_character_attribute_by_calculate_no_equips(arg_110_1.id)

			var_110_2 = nil and var_0_0.little_clone(nil) or {}
		else
			local var_110_11 = gamecore.user:get_attribute_effect_by_equip(arg_110_1.id)
			local var_110_12 = var_110_11 and var_0_0.little_clone(var_110_11) or {}
			local var_110_13 = gamecore.user:get_character_attribute_by_calculate(arg_110_1.id)

			var_110_1 = var_110_13 and var_0_0.little_clone(var_110_13) or {}

			local var_110_14 = gamecore.user:get_character_attribute_by_calculate_no_equips(arg_110_1.id)

			var_110_2 = var_110_14 and var_0_0.little_clone(var_110_14) or {}
		end
	end

	for iter_110_2, iter_110_3 in pairs(var_110_0) do
		if var_110_1 and not var_110_1[iter_110_3] then
			var_110_1[iter_110_3] = 0
		end
	end

	if arg_110_2 then
		local var_110_16 = arg_110_2

		for iter_110_4, iter_110_5 in pairs((gamecore.user:get_player_desk_collection_data())) do
			local var_110_17 = gameconfig.item_config.find_object_by_cid(iter_110_5.id)

			if var_110_17 and tonumber(arg_110_2.cid) % 100 ~= 18 then
				if var_0_0:match_collection_ship_type(var_110_17.buff_effect.ship_type, var_110_16.type) and (var_110_17.buff_effect.country == 0 or var_110_17.buff_effect.country == var_110_16.country) and var_110_1[var_110_17.buff_effect.attr] then
					var_110_1[var_110_17.buff_effect.attr] = var_110_1[var_110_17.buff_effect.attr] + var_110_17.buff_effect.val
				end
			end
		end

		local var_110_18 = {}

		if arg_110_1.equips then
			for iter_110_6, iter_110_7 in pairs(arg_110_1.equips) do
				var_0_2(var_110_18, (gameconfig.equip_config.find_object_by_cid(iter_110_7.id)))
			end

			if var_0_1(var_110_18) then
				for iter_110_8, iter_110_9 in pairs(var_110_18) do
					if var_0_1(iter_110_9.exclusive_cid) then
						for iter_110_10, iter_110_11 in pairs(iter_110_9.exclusive_cid) do
							if arg_110_1.cid == iter_110_11 then
								for iter_110_12, iter_110_13 in pairs(iter_110_9.exclusive_buff) do
									if iter_110_13.type == 1 then
										local var_110_19 = var_0_9:get_attr_name(iter_110_13.num4)

										if var_110_1[var_110_19] then
											var_110_1[var_110_19] = var_110_1[var_110_19] + iter_110_13.num
										end
									end
								end
							end
						end
					elseif var_0_1(iter_110_9.exclusive_buff) then
						for iter_110_14, iter_110_15 in pairs(iter_110_9.exclusive_buff) do
							if iter_110_15.type == 1 then
								local var_110_20 = var_0_9:get_attr_name(iter_110_15.num4)

								if var_110_1[var_110_20] then
									var_110_1[var_110_20] = var_110_1[var_110_20] + iter_110_15.num
								end
							end
						end
					end
				end
			end
		end

		local var_110_21 = gamecore.user:get_restaurant_cookbook_buff()

		if var_110_21 and tonumber(arg_110_2.cid) % 100 ~= 18 and tonumber(arg_110_2.cid) % 100 ~= 19 and lx.ServerTime:getUtcTime() < var_110_21.end_time then
			local var_110_22 = gameconfig.cook_book_config.find_object_by_cid(var_110_21.id)
			local var_110_23 = var_110_22.effect.attr

			if var_110_1[var_110_22.effect.attr] and var_110_21.end_time >= lx.ServerTime:getUtcTime() and (var_110_22.effect.type == 5 or var_110_22.effect.type == 6) then
				local var_110_25 = var_110_22.effect.country or 0
				local var_110_26 = var_110_22.effect.ship_type or 0
				local var_110_27 = var_110_22.effect.ship_ton or 0

				if (var_110_26 == 0 or var_110_26 == var_110_16.type) and (var_110_25 == 0 or var_110_25 == var_110_16.country) and (var_110_27 == 0 or var_110_27 == var_110_16.ship_ton) then
					var_110_1[var_110_23] = var_110_1[var_110_23] + var_110_22.effect.value
				end
			end
		end

		local var_110_28 = gamecore.user:get_dormitory_race_buff()

		if var_110_28 and tonumber(arg_110_2.cid) % 100 ~= 18 and tonumber(arg_110_2.cid) % 100 ~= 19 and lx.ServerTime:getUtcTime() < var_110_28.end_time then
			local var_110_29 = gameconfig.furniture_config.find_object_by_cid(var_110_28.id).buff
			local var_110_30 = var_110_29.ship_type or 0
			local var_110_31 = var_110_29.shipTon or 0
			local var_110_32 = gameenum.common_type:get_attr_name(var_110_29.num4)

			if var_110_29.type == 1 and (var_110_30 == 0 or var_110_30 == var_110_16.type) and (var_110_28.country == 0 or var_110_28.country == var_110_16.country) and (var_110_31 == 0 or var_110_31 == var_110_16.ship_ton) then
				var_110_1[var_110_32] = var_110_1[var_110_32] + var_110_29.num
			end
		end

		local var_110_33 = gamecore.user:get_workshop_data()

		if var_0_1(var_110_33) and tonumber(arg_110_2.cid) % 100 ~= 18 and tonumber(arg_110_2.cid) % 100 ~= 19 then
			for iter_110_16, iter_110_17 in pairs(var_110_33) do
				local var_110_34 = gameconfig.workshop_config.find_object_by_id(iter_110_17.id).effect[1]

				if var_110_34.shipTypes then
					for iter_110_18, iter_110_19 in pairs(var_110_34.shipTypes) do
						if var_110_34.shipTypes and var_110_34.shipTypes[iter_110_18] == var_110_16.type then
							local var_110_35 = var_0_9:get_attr_name(var_110_34.num4)

							if var_110_34.type == var_0_9.workshop_const.work_type.add_attribute then
								if var_110_34.countrys then
									for iter_110_20, iter_110_21 in pairs(var_110_34.countrys) do
										if iter_110_21 == var_110_16.country and var_110_1[var_110_35] then
											var_110_1[var_110_35] = var_110_1[var_110_35] + var_110_34.num
										end
									end
								else
									var_110_1[var_110_35] = var_110_1[var_110_35] + var_110_34.num
								end
							elseif var_110_34.type == var_0_9.workshop_const.work_type.add_torpedo_damage and var_110_16[var_110_35] ~= 0 and var_110_1[var_110_35] then
								var_110_1[var_110_35] = var_110_1[var_110_35] + var_110_34.num
							end
						end
					end
				end
			end
		end

		local var_110_36 = not arg_110_1.now_skill and gameconfig.skill_config.find_object_by_skill_id(arg_110_1.skill_id) or gameconfig.skill_config.find_object_by_skill_type_skill_level(arg_110_1.now_skill, arg_110_1.skill_level)
		local var_110_37
		local var_110_38

		if var_110_36 and var_110_36.effect[1] then
			for iter_110_22, iter_110_23 in pairs(var_110_36.effect) do
				if var_110_36.effect[iter_110_22].type == 1 and var_110_36.effect[iter_110_22].stage[1] == 1 then
					for iter_110_24, iter_110_25 in pairs(var_110_36.effect[iter_110_22].effect) do
						if iter_110_25.type == 3 then
							for iter_110_26, iter_110_27 in pairs(var_110_0) do
								if iter_110_25[var_110_0[iter_110_26]] then
									var_110_37 = var_110_0[iter_110_26]
									var_110_38 = iter_110_25[var_110_0[iter_110_26]]
								end
							end

							if var_110_37 and var_110_38 and var_110_1[var_110_37] then
								var_110_38 = var_110_38 * var_0_0.get_attr_multiple_by_config(var_110_36, arg_110_1, iter_110_22)
								var_110_1[var_110_37] = var_110_1[var_110_37] + var_110_38
								var_110_2[var_110_37] = var_110_2[var_110_37] + var_110_38
							end
						elseif iter_110_25.type == 4 then
							for iter_110_28, iter_110_29 in pairs(var_110_0) do
								if iter_110_25[var_110_0[iter_110_28]] then
									var_110_37 = var_110_0[iter_110_28]
									var_110_38 = iter_110_25[var_110_0[iter_110_28]]
								end
							end

							var_110_1[var_110_37] = var_110_1[var_110_37] or 1
							var_110_1[var_110_37] = var_110_1[var_110_37] + var_110_1[var_110_37] * var_110_38
							var_110_2[var_110_37] = var_110_2[var_110_37] or 1
							var_110_2[var_110_37] = var_110_2[var_110_37] + var_110_2[var_110_37] * var_110_38
						elseif iter_110_25.type == 5 then
							if var_110_1[var_110_0[iter_110_25.attribute]] and var_110_1[var_110_0[iter_110_25.attribute2]] then
								var_110_1[var_110_0[iter_110_25.attribute2]] = var_110_1[var_110_0[iter_110_25.attribute2]] + var_110_1[var_110_0[iter_110_25.attribute]] * iter_110_25.rate
							end

							if var_110_2[var_110_0[iter_110_25.attribute]] and var_110_2[var_110_0[iter_110_25.attribute2]] then
								var_110_2[var_110_0[iter_110_25.attribute2]] = var_110_2[var_110_0[iter_110_25.attribute2]] + var_110_2[var_110_0[iter_110_25.attribute]] * iter_110_25.rate
							end
						elseif iter_110_25.type == 94 then
							if var_110_1.range >= iter_110_25.num then
								var_110_1.range = var_110_1.range or iter_110_25.num
							end

							if var_110_2.range >= iter_110_25.num then
								var_110_2.range = var_110_2.range or iter_110_25.num
							end
						elseif iter_110_25.type == 49 then
							for iter_110_30, iter_110_31 in ipairs(arg_110_1.equips) do
								local var_110_40 = gameconfig.equip_config.find_object_by_cid(iter_110_31.id)

								if var_110_40 then
									for iter_110_32, iter_110_33 in pairs(var_110_40) do
										if iter_110_33 ~= 0 and iter_110_32 ~= "range" and iter_110_32 ~= "hp" then
											if var_110_1[iter_110_32] then
												var_110_1[iter_110_32] = var_110_1[iter_110_32] + iter_110_33 * iter_110_25.rate
											end

											if var_110_2[iter_110_32] then
												var_110_2[iter_110_32] = var_110_2[iter_110_32] + iter_110_33 * iter_110_25.rate
											end
										end
									end
								end
							end
						elseif iter_110_25.type == 50 then
							for iter_110_34, iter_110_35 in ipairs(arg_110_1.equips) do
								if iter_110_35.id > 0 then
									local var_110_41 = gameconfig.equip_config.find_object_by_cid(iter_110_35.id)

									if var_110_1[var_110_0[iter_110_25.attribute]] and var_110_41[var_110_0[iter_110_25.attribute]] and var_110_1[var_110_0[iter_110_25.attribute2]] then
										var_110_1[var_110_0[iter_110_25.attribute2]] = var_110_1[var_110_0[iter_110_25.attribute2]] + var_110_41[var_110_0[iter_110_25.attribute]] * iter_110_25.rate
									end

									if var_110_2[var_110_0[iter_110_25.attribute]] and var_110_41[var_110_0[iter_110_25.attribute]] and var_110_2[var_110_0[iter_110_25.attribute2]] then
										var_110_2[var_110_0[iter_110_25.attribute2]] = var_110_2[var_110_0[iter_110_25.attribute2]] + var_110_41[var_110_0[iter_110_25.attribute]] * iter_110_25.rate
									end
								end
							end
						elseif iter_110_25.type == 51 then
							local var_110_42 = 0

							for iter_110_36, iter_110_37 in ipairs(arg_110_1.equips) do
								for iter_110_38, iter_110_39 in pairs(iter_110_25.equipment_type) do
									local var_110_43 = gameconfig.equip_config.find_object_by_cid(iter_110_37.id)

									if var_110_43 and var_110_43.bore_type == iter_110_39 then
										var_110_42 = var_110_42 + 1
									end
								end
							end

							for iter_110_40, iter_110_41 in pairs(iter_110_25) do
								if var_110_1[iter_110_40] then
									var_110_1[iter_110_40] = var_110_1[iter_110_40] + iter_110_41 * var_110_42

									break
								end

								if var_110_2[iter_110_40] then
									var_110_2[iter_110_40] = var_110_2[iter_110_40] + iter_110_41 * var_110_42

									break
								end
							end
						elseif iter_110_25.type == 52 then
							for iter_110_42, iter_110_43 in ipairs(arg_110_1.equips) do
								for iter_110_44, iter_110_45 in pairs(iter_110_25.equipment_type) do
									local var_110_44 = gameconfig.equip_config.find_object_by_cid(iter_110_43.id)

									if iter_110_43.id > 0 and var_110_44.type == iter_110_45 then
										for iter_110_46, iter_110_47 in pairs(iter_110_25) do
											if var_110_1[iter_110_46] and var_110_44[iter_110_46] then
												var_110_1[iter_110_46] = var_110_1[iter_110_46] + var_110_44[iter_110_46] * iter_110_25[iter_110_46]
											end

											if var_110_2[iter_110_46] and var_110_44[iter_110_46] then
												var_110_2[iter_110_46] = var_110_2[iter_110_46] + var_110_44[iter_110_46] * iter_110_25[iter_110_46]
											end
										end
									end
								end
							end
						elseif iter_110_25.type == 54 then
							for iter_110_48, iter_110_49 in ipairs(arg_110_1.equips) do
								if iter_110_49.id > 0 then
									for iter_110_50, iter_110_51 in pairs(iter_110_25.equipment_type) do
										local var_110_45 = gameconfig.equip_config.find_object_by_cid(iter_110_49.id)

										if iter_110_49.id > 0 and var_110_45.type == iter_110_51 then
											for iter_110_52, iter_110_53 in pairs(iter_110_25) do
												if var_110_1[var_110_0[iter_110_25.attribute]] and var_110_45[var_110_0[iter_110_25.attribute]] and var_110_1[var_110_0[iter_110_25.attribute2]] then
													var_110_1[var_110_0[iter_110_25.attribute2]] = var_110_1[var_110_0[iter_110_25.attribute2]] + var_110_45[var_110_0[iter_110_25.attribute]] * iter_110_25.rate

													break
												end

												if var_110_2[var_110_0[iter_110_25.attribute]] and var_110_45[var_110_0[iter_110_25.attribute]] and var_110_2[var_110_0[iter_110_25.attribute2]] then
													var_110_2[var_110_0[iter_110_25.attribute2]] = var_110_2[var_110_0[iter_110_25.attribute2]] + var_110_45[var_110_0[iter_110_25.attribute]] * iter_110_25.rate

													break
												end
											end
										end
									end
								end
							end
						elseif iter_110_25.type == 131 then
							local var_110_46

							if var_110_1[var_110_0[iter_110_25.attribute]] then
								var_110_46 = var_0_0.attr_impact_by_speed(var_110_2.speed, var_110_1[var_110_0[iter_110_25.attribute]], iter_110_25.num1, iter_110_25.num2) - var_110_1[var_110_0[iter_110_25.attribute]]
							end

							if var_110_46 then
								var_110_1[var_110_0[iter_110_25.attribute]] = var_110_1[var_110_0[iter_110_25.attribute]] + var_110_46
							end
						end
					end
				end
			end
		end
	end

	return var_110_1, var_110_2
end

function var_0_0.attr_impact_by_speed(arg_111_0, arg_111_1, arg_111_2, arg_111_3)
	if not arg_111_0 then
		return arg_111_1
	end

	arg_111_2 = arg_111_2 or 0
	arg_111_3 = arg_111_3 or 0

	return math.floor(arg_111_1 * (1 + ((arg_111_0 < 12.2 or nil) and arg_111_2 + (12.2 - arg_111_0) * (arg_111_3 - arg_111_2) / 12.2)))
end

function var_0_0:get_attr_multiple_by_config(arg_112_1, arg_112_2)
	local var_112_0 = 1

	if not self.effect[arg_112_2].condition then
		return 1
	end

	for iter_112_0, iter_112_1 in pairs(self.effect[arg_112_2].condition) do
		if iter_112_1.type == gameenum.common_type.ship_detail_const.ships_count_of_map_mul_effect then
			local var_112_2 = {}

			for iter_112_2, iter_112_3 in pairs((gamecore.user:get_cardbook_ship_list())) do
				for iter_112_4, iter_112_5 in pairs(iter_112_1.shipCids) do
					if iter_112_3.id == iter_112_5 then
						table.insert(var_112_2, iter_112_5)
					end
				end
			end

			var_112_0 = #var_112_2
		elseif iter_112_1.type == gameenum.common_type.ship_detail_const.gofight_count_div_num_mul_effect then
			local var_112_3 = gamecore.user:get_user_info().map_total / iter_112_1.num

			var_112_3 = var_112_3 > 1 and 1 or var_112_3
			var_112_0 = var_112_3
		elseif iter_112_1.type == gameenum.common_type.ship_detail_const.level_div_num_mul_effect then
			var_112_0 = math.floor(arg_112_1.level / iter_112_1.num)
		end
	end

	return var_112_0
end

function var_0_0.get_item_star_bg_by_item_id(arg_113_0)
	if not arg_113_0 then
		return
	end

	local var_113_0 = gameenum.common_type.ship_equip_pic.have_sign

	if arg_113_0 >= 10000000 then
		if arg_113_0 % 100 == 21 then
			var_113_0 = string.format(gameenum.common_type.equip_back.equip_back_normal, gameconfig.equip_config.find_object_by_cid(arg_113_0).star)
		elseif arg_113_0 % 100 ~= 11 and arg_113_0 % 100 ~= 12 then
			if arg_113_0 % 100 == 13 then
				var_113_0 = string.format(gameenum.common_type.equip_back.equip_back_normal, gameconfig.ship_config.find_object_by_cid(arg_113_0).star)
			end
		end
	end

	return var_113_0
end

function var_0_0.file_exist(arg_114_0)
	local var_114_0 = io.open(arg_114_0, "rb")

	if not var_114_0 then
		return false
	end

	var_114_0:close()

	return true
end

function var_0_0.input_del_emoji(arg_115_0, arg_115_1)
	if not arg_115_1 then
		return
	end

	function arg_115_1.onValidateInput(arg_116_0, arg_116_1, arg_116_2)
		if arg_116_2 <= 10160 and arg_116_2 >= 9986 then
			return string.byte("\x00")
		end

		if arg_116_2 >= 55357 then
			return string.byte("\x00")
		end

		return arg_116_2
	end
end

function var_0_0.limit_omit_string(arg_117_0, arg_117_1)
	local var_117_0 = {}
	local var_117_1 = 0

	for iter_117_0, iter_117_1 in pairs((encode.unicode_make_by_utf8(arg_117_0))) do
		local var_117_2 = encode.unicode_to_utf8(iter_117_1)
		local var_117_3, var_117_4, var_117_5 = encode.utf8_charinfo(var_117_2)

		var_0_2(var_117_0, var_117_2)

		var_117_1 = var_117_1 + (var_117_4 * 2 + var_117_5)

		if arg_117_1 <= var_117_1 then
			var_0_2(var_117_0, "...")

			return table.concat(var_117_0)
		end
	end

	return arg_117_0
end

function var_0_0.secondsToTime_not_hour(arg_118_0)
	local var_118_9000
	local var_118_0 = ""

	var_118_0 = arg_118_0 % 60 > 0 and (arg_118_0 % 60 >= 10 and "" .. arg_118_0 % 60 or "0" .. arg_118_0 % 60) or "00"

	local var_118_1 = math.floor(arg_118_0 / 60)

	var_118_0 = var_118_9000 > 0 and (var_118_1 >= 10 and var_118_1 .. ":" .. var_118_0 or "0" .. var_118_1 .. ":" .. var_118_0) or "00:" .. var_118_0

	return var_118_0
end

function var_0_0.check_channel_is_en()
	return app:getSystem():getChannel() == "hm_android_en"
end

function var_0_0:setTextHorizonInfo(arg_120_1)
	self:GetComponent("TextHorizonScroller"):SetText(arg_120_1)
end

function var_0_0:setTextColor(arg_121_1)
	for iter_121_0 = 0, self.transform.childCount - 1 do
		self.transform:GetChild(iter_121_0).gameObject:GetComponent("Text").color = arg_121_1
	end
end

function var_0_0:setTextFontSize(arg_122_1, arg_122_2)
	for iter_122_0 = 0, self.transform.childCount - 1 do
		local var_122_0 = self.transform:GetChild(iter_122_0).gameObject

		var_122_0:GetComponent("Text").fontSize = arg_122_1

		local var_122_1 = var_122_0:GetComponent("Text").text

		if true and var_122_1 ~= "" then
			var_0_0.setTextHorizonInfo(self, var_122_1)
		end
	end
end

function var_0_0.setTableReverse(arg_123_0)
	local var_123_0 = {}

	for iter_123_0 = 1, #arg_123_0 do
		var_123_0[iter_123_0] = var_0_3(arg_123_0)
	end

	return var_123_0
end

return var_0_0
