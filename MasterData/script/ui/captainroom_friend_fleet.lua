local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_7 = gameconfig.ship_config
local var_0_8 = gameconfig.ship_rule_config
local var_0_9 = gamecore.util_func
local var_0_10
local var_0_11

gamecore.UILoader:define("captainroom_friend_fleet", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._now_enter_type = arg_2_2

		local var_2_0 = arg_2_1 and var_0_9.little_clone(arg_2_1) or {}

		self._friend_data = var_2_0

		var_0_4:set_other_info(var_2_0)
		self:__init_panel()
	end

	function arg_1_0.__show_fleet_layer(arg_3_0, arg_3_1)
		var_0_3:play_in_out_animation(var_0_10, arg_3_1, function()
			if not arg_3_1 then
				arg_3_0._control.bg:SetActive(false)
				var_0_1:destroyInstance("captainroom_friend_fleet")
			end
		end)
	end

	function arg_1_0:__set_layer_info()
		self._control.bg.fleet_info.captain_name.level.text.text = "Lv." .. self._friend_data.level
		self._control.bg.fleet_info.captain_name.caprain_name_txt.caprain_name_txt_1.text.text = self._friend_data.name

		self._control.bg.fleet_info.captain_name.caprain_name_txt:GetComponent("TextHorizonScroller"):SetText(self._friend_data.name)

		local var_5_0 = self._friend_data.pve.battle_count == 0 and 0 or math.floor(self._friend_data.pvp.win_count / self._friend_data.pvp.battle_count * 100)

		self._control.bg.fleet_info.drill_odds.num.text.text = ((self._friend_data.pvp.battle_count == 0 or nil) and 0) .. "%"
		self._control.bg.fleet_info.cardbook_collect.num.text.text = self._friend_data.archive_ship .. "/" .. var_0_8.find_object_by_id(var_0_3.ship_rule.num_config).content.boatNumMax
		self._control.bg.fleet_info.captain_name.captain_img.image.sprite = self:loadSprite(var_0_3:get_format_url(var_0_3.common_icon.friend_badge_path, 11 - ((self._friend_data.exploit == 0 or nil) and 10)))

		if next(self._friend_data.mansion.garrison) and self._user_data.friend_maneuver_count < var_0_3.friend_challenge_num then
			-- block empty
		end

		if self._friend_data.mansion.garrison and #self._friend_data.mansion.garrison > 0 then
			self._control.bg.challenge_mask:SetActive(false)
		else
			self._control.bg.challenge_mask:SetActive(true)
		end

		self:__set_maneuver_friend_rival()
		self._control.bg.challenge_btn:SetActive(true)

		local var_5_4 = var_0_2:getNowLang("pvpbtnc") .. "    (" .. (var_0_3.friend_challenge_num - self._user_data.friend_maneuver_count < 0 and 0 or var_0_3.friend_challenge_num - self._user_data.friend_maneuver_count) .. "/" .. var_0_3.friend_challenge_num .. ")"

		self._control.bg.challenge_btn.txt.text.text = var_5_4
		self._control.bg.challenge_mask.txt.text.text = var_5_4
	end

	function arg_1_0:__set_fleet_list()
		local var_6_1 = var_0_9.little_clone(self._friend_data.mansion.garrison or {})

		for iter_6_0 = 0, self._control.bg.role_list_1.transform.childCount - 1 do
			self._control.bg.role_list_1.transform:GetChild(iter_6_0).gameObject:SetActive(false)
		end

		for iter_6_1, iter_6_2 in ipairs(var_0_11) do
			local var_6_2 = var_6_1[iter_6_1]

			if var_6_1[iter_6_1] then
				if iter_6_1 > self._control.bg.role_list_1.transform.childCount then
					local var_6_3 = self:loadUI("single_select_team")

					var_6_3._panel.transform:SetParent(self._control.bg.role_list_1.transform, false)

					var_6_3._panel.transform:Find("BG"):GetComponent("Image").raycastTarget = true
					self._team_list[#self._team_list + 1] = var_6_3
				end

				local var_6_4 = var_0_7.find_object_by_cid(var_6_2.cid)

				var_6_2.star = var_6_4.star
				var_6_2.name = var_6_4.title
				var_6_2.equipment_num = var_6_4.equipment_num

				self._team_list[iter_6_1]._panel.gameObject:SetActive(true)
				self._team_list[iter_6_1]:show(var_6_2, var_0_3.dock_team_toggle_type.captainroom_friend_fleet, nil, nil, self._now_enter_type == var_0_3.fight_type.tower_rank_list and var_0_3.fight_type.show_room_friend or self._now_enter_type)
			end
		end
	end

	function arg_1_0:__set_maneuver_friend_rival()
		self._control.bg.challenge_result:SetActive(false)

		for iter_7_0, iter_7_1 in pairs((var_0_4:get_maneuver_friend_rival())) do
			if iter_7_1.id == self._friend_data.account_id and self._user_data.friend_maneuver_count ~= 0 then
				self._control.bg.challenge_result:SetActive(true)

				self._control.bg.challenge_result.text.text = var_0_2:getNowLang("pvpresultdesc") .. var_0_3.rank_sore[iter_7_1.grade]

				return
			end
		end

		self._control.bg.challenge_result:SetActive(false)
	end

	function arg_1_0:show_layer(arg_8_1)
		local var_8_0 = var_0_1:getInstance("captainroom")

		if var_8_0 then
			var_8_0:setVisible(arg_8_1)
		end

		local var_8_1 = var_0_1:getInstance("show_room")

		if var_8_1 then
			var_8_1:setVisible(arg_8_1)
		end

		self:setVisible(arg_8_1)
	end

	function arg_1_0:show_layer_of_captainroom(arg_9_1)
		local var_9_0 = var_0_1:getInstance("captainroom")

		if var_9_0 then
			var_9_0:setVisible(arg_9_1)
		end

		self:setVisible(false)
	end

	function arg_1_0:show_layer_of_show_room(arg_10_1)
		local var_10_0 = var_0_1:getInstance("show_room")

		if var_10_0 then
			var_10_0:setVisible(arg_10_1)
		end

		self:setVisible(false)
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_constant()
			self:__init_language()
		end

		self._user_data = var_0_4:get_use_info_data()

		self:__set_layer_info()
		self:__set_fleet_list()
		self:__show_fleet_layer(true)

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.bg.bg_container.title_node.title.text.text = var_0_2:getNowLang("otherfleettitle")
		self._control.bg.fleet_info.fleet_name.fleet_name_txt.text.text = var_0_2:getNowLang("pvpoppofleet")
		self._control.bg.fleet_info.fleet_name.garrison_fleet.text.text = var_0_2:getNowLang("viewotherfleettip")
		self._control.bg.fleet_info.captain_name.fleet_name_txt.text.text = var_0_2:getNowLang("leaderboardusername")
		self._control.bg.fleet_info.drill_odds.title.text.text = var_0_2:getNowLang("pvpoppowinrate")
		self._control.bg.fleet_info.cardbook_collect.title.text.text = var_0_2:getNowLang("pvpoppocardrate")
		self._control.bg.tip.tip_1.text.text = var_0_2:getNowLang("viewothertip1")

		self._control.bg.tip:GetComponent("TextHorizonScroller"):SetText(var_0_2:getNowLang("viewothertip1"))
	end

	function arg_1_0:__init_constant()
		var_0_10 = self._control.bg.uITweenSequence
		var_0_11 = {
			self._control.bg.role_list.role_1,
			self._control.bg.role_list.role_2,
			self._control.bg.role_list.role_3,
			self._control.bg.role_list.role_4,
			self._control.bg.role_list.role_5,
			self._control.bg.role_list.role_6
		}
	end

	function arg_1_0:__enter_friend_fight()
		self:__close_other_ui("friendsmain")
		self:__close_other_ui("show_room")
	end

	function arg_1_0.__close_other_ui(arg_15_0, arg_15_1)
		local var_15_0 = var_0_1:getInstance(arg_15_1)

		if var_15_0 then
			var_15_0:setVisible(false)
		end
	end

	function arg_1_0.__onReset(arg_16_0)
		arg_16_0._is_already_init = false
		arg_16_0._friend_data = nil
		arg_16_0._user_data = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_17_0)
	local var_17_0 = var_0_1:class("captainroom_friend_fleet")

	var_17_0._is_already_init = false
	var_17_0._friend_data = nil
	var_17_0._user_data = {}
	var_17_0._team_list = {}
	var_17_0._now_enter_type = nil

	return var_17_0
end

return var_0_0
