local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.UILoader
local var_0_5 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_right_weight_clear_team()
		if self._team_data and #self._team_data.members == 0 then
			return
		end

		local var_2_0 = var_0_4:getInstance("pre_formation")

		if var_2_0 then
			var_2_0:save_team_info_all({}, self._index + 8)
		end
	end

	function arg_1_0:__onClick_right_weight_confirm_team()
		for iter_3_0, iter_3_1 in pairs(self._team_data.members) do
			if var_0_1:find_character_by_id(iter_3_1).state == var_0_5.ship_state.expedition then
				var_0_2:show(var_0_3:getNowLang("refuse_join_formation"))

				return
			elseif var_0_1:find_character_by_id(iter_3_1).state == var_0_5.ship_state.station then
				var_0_2:show(var_0_3:getNowLang("noticeshipisinguard"))

				return
			end
		end

		local var_3_0 = var_0_4:getInstance("pre_formation")

		if var_3_0 then
			var_3_0:set_is_from_confirm(true)
		end

		if self._from_type == var_0_5.enter_select_member_type.fight then
			local var_3_1 = var_0_4:getInstance("fight_prepare")

			if self._sub_type ~= var_0_5.fight_prepare_right_panel_type.sixth and self._sub_type ~= var_0_5.fight_prepare_right_panel_type.ocean_attack and self._sub_type ~= var_0_5.fight_prepare_right_panel_type.strike and self._sub_type ~= var_0_5.fight_prepare_right_panel_type.abyss_model and self._sub_type ~= var_0_5.fight_prepare_right_panel_type.war_concerto_play then
				if var_3_1 and not var_3_1:save_team_info_all(self._team_data.members) and var_3_0 then
					var_0_2:show(var_0_3:getNowLang("pre_formation_cannot_use"))
					var_3_0:set_is_from_confirm(false)
				end
			elseif self._sub_type == var_0_5.fight_prepare_right_panel_type.strike then
				var_0_1:req_SolidSaveTeamReq(self._team_data.members)
			elseif self._sub_type == var_0_5.fight_prepare_right_panel_type.ocean_attack then
				var_0_1:req_OceanSaveTeamReq(self._team_data.members)
			else
				var_0_2:show("Wrong self._sub_type")
			end
		elseif self._from_type == var_0_5.enter_select_member_type.abyss_normal_prepare_team then
			var_0_1:req_AbyssSaveTeamReq(self._team_data.members)
		elseif self._from_type == var_0_5.enter_select_member_type.dock_team then
			local var_3_2 = var_0_4:getInstance("dock_team")

			if var_3_2 then
				local var_3_3 = var_3_2:save_team_info_all(self._team_data.members)

				if not var_3_3 and var_3_0 then
					var_0_2:show(var_0_3:getNowLang("pre_formation_cannot_use"))
					var_3_0:set_is_from_confirm(false)
					var_3_2:setVisible(false)
				end

				if var_3_3 then
					var_3_2:setVisible(true)

					var_3_2._panel.transform:GetComponent("Canvas").sortingOrder = 500
				end
			end
		end
	end

	function arg_1_0:__onClick_top_weight_close()
		if self._team_data and #self._team_data.members == 0 then
			return
		end

		;(var_0_4:getInstance("msgbox") or var_0_4:createInstance("msgbox")):show(string.format(var_0_3:getNowLang("pre_formation_clear2"), self._team_data.name), function()
			var_0_4:destroyInstance("msgbox")

			local var_5_0 = var_0_4:getInstance("pre_formation")

			if var_5_0 then
				var_5_0:save_team_info_all({}, self._index + (self._now_page_num - 1) * 5 + 8)
			end
		end, function()
			var_0_4:destroyInstance("msgbox")
		end, var_0_3:getNowLang("pre_formation_clear"), var_0_5.msg_type.tip)
	end

	function arg_1_0:__onClick_right_weight_record_team()
		local var_7_0 = {}

		if self._sub_type == var_0_5.fight_prepare_right_panel_type.strike then
			var_7_0 = {
				quick = true,
				id = self._index + (self._now_page_num - 1) * 5 + 8,
				members = var_0_1:get_strike_team_data()
			}
		elseif self._enter_team then
			local var_7_1

			if self._enter_team < 5 then
				var_7_1 = var_0_1:get_team_data(1, self._enter_team)
			elseif self._enter_team < 9 and self._enter_team > 4 then
				var_7_1 = var_0_1:get_team_data(2, self._enter_team)
			end

			var_7_0 = {
				quick = true,
				id = self._index + (self._now_page_num - 1) * 5 + 8,
				members = var_7_1.members
			}
		else
			local var_7_2 = {
				quick = true,
				id = self._index + (self._now_page_num - 1) * 5 + 8
			}

			var_7_2.members = var_0_1:get_team_data(1, 1).members
			var_7_0 = var_7_2
		end

		var_0_1:req_TeamSave(var_7_0)
	end

	function arg_1_0:__onClick_top_weight_team_name_Button()
		self._control.top_weight.fleet_name.inputField.text = ""

		self._control.top_weight.fleet_name:SetActive(true)
		self._control.top_weight.team_name:SetActive(false)
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
