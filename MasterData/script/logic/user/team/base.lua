local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = table.insert
local var_0_3 = gamecore.util_func
local var_0_4 = gamecore.prompt
local var_0_5 = gameenum.error_type
local var_0_7 = gameenum.common_type
local var_0_8 = gamecore.user
local var_0_9 = gamecore.UserDataManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_all_ship_in_team()
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in pairs(self._team_data) do
			for iter_2_2, iter_2_3 in pairs(iter_2_1) do
				for iter_2_4, iter_2_5 in pairs(iter_2_3.members) do
					local var_2_1 = self:find_character_by_id(iter_2_5)

					if var_2_1 then
						var_0_2(var_2_0, var_2_1)
					end
				end
			end
		end

		return var_2_0
	end

	function arg_1_0.reset_team_data(arg_3_0)
		arg_3_0._team_data = {}
	end

	function arg_1_0:get_team_group(arg_4_1)
		return self._team_data[arg_4_1]
	end

	function arg_1_0:get_campaign_refresh_time()
		return self._campaign_refresh_time
	end

	function arg_1_0:get_campaign_data(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(self._campaign_info) do
			if iter_6_1.info.id == arg_6_1 then
				return iter_6_1
			end
		end
	end

	function arg_1_0:get_campaign_members(arg_7_1)
		local var_7_0 = self:get_campaign_data(arg_7_1)

		if var_7_0 and var_7_0.info then
			return var_7_0.info.members
		end
	end

	function arg_1_0:get_campaign_count()
		return self._campaign_count
	end

	function arg_1_0.__resq_Freshcampaign(arg_9_0)
		local var_9_0 = var_0_1:getInstance("gotofight")

		if var_9_0 then
			var_9_0:__update_campaign_panel_type()
		end
	end

	function arg_1_0:get_team_data(arg_10_1, arg_10_2)
		return self._team_data[arg_10_1][arg_10_2]
	end

	function arg_1_0:get_team_all_data()
		return self._team_data
	end

	function arg_1_0:get_team_config_data(arg_12_1, arg_12_2)
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in pairs(self._team_data[arg_12_1][arg_12_2].members) do
			local var_12_1 = self:find_character_by_id(iter_12_1)
			local var_12_2 = var_12_1 and var_0_3.little_clone(var_12_1) or {}

			if var_12_2 then
				var_12_2.team_num = arg_12_2

				var_0_2(var_12_0, var_12_2)
			end
		end

		return var_12_0
	end

	function arg_1_0:get_current_team()
		return self._current_team
	end

	function arg_1_0.set_current_team(arg_14_0, arg_14_1)
		arg_14_0._current_team = arg_14_1
	end

	function arg_1_0:get_team_by_id(arg_15_1)
		local var_15_0

		for iter_15_0, iter_15_1 in ipairs(self._team_data) do
			for iter_15_2, iter_15_3 in pairs(iter_15_1) do
				if iter_15_3.id == arg_15_1 then
					var_15_0 = iter_15_3
				end
			end
		end

		return var_15_0
	end

	function arg_1_0:get_team_index_by_id(arg_16_1, arg_16_2)
		for iter_16_0, iter_16_1 in pairs(self._team_data[arg_16_1]) do
			if var_0_3.have_data(iter_16_1.members, arg_16_2) then
				return iter_16_0
			end
		end

		return 0
	end

	function arg_1_0:get_team_members(arg_17_1, arg_17_2)
		return self._team_data[arg_17_1][arg_17_2].members
	end

	function arg_1_0:get_campaign_info()
		return self._campain_info
	end

	function arg_1_0:set_gotofight_memory_team_index(arg_19_1)
		var_0_9:setDataByID("gotofight_memory_team_index", self:get_account_id(), tostring(arg_19_1))
	end

	function arg_1_0:get_gotofight_memory_team_index()
		return tonumber((var_0_9:getDataByID("gotofight_memory_team_index", (self:get_account_id())))) or 1
	end

	function arg_1_0:set_team_station_state(arg_21_1, arg_21_2, arg_21_3)
		self._team_data[arg_21_1][arg_21_2].station = arg_21_3
	end

	function arg_1_0.__team_rename_ok(arg_22_0)
		local var_22_0 = var_0_1:getInstance("dock_team")

		if var_22_0 then
			var_22_0:edit_team_name_refresh()
		end
	end

	function arg_1_0.__update_campaign(arg_23_0)
		var_0_1:getInstance("fight_prepare"):__update_campaign_prepare()
	end

	function arg_1_0.__sava_campaign_error(arg_24_0, arg_24_1)
		var_0_1:getInstance("fight_prepare"):sava_campaign_error(arg_24_1)
	end

	function arg_1_0:__resq_EnterCampaignResp(arg_25_1)
		local var_25_0 = var_0_1:getInstance("fight_prepare")

		if var_25_0 then
			var_25_0:__close_prepare()
		end

		local var_25_1 = var_0_1:createInstance("campaign_select")
		local var_25_2 = {}

		for iter_25_0, iter_25_1 in pairs(self:get_campaign_data(var_25_0._go_to_map_id).info.members) do
			if iter_25_1 ~= 0 then
				var_0_2(var_25_2, (self:find_character_by_id(iter_25_1)))
			end
		end

		var_25_1:show(arg_25_1, var_0_7.select_prepare_type.campaign, var_25_2)
	end

	function arg_1_0.__team_rename_error(arg_26_0, arg_26_1)
		var_0_4:show(var_0_5:get_err_msg(arg_26_1))
	end

	function arg_1_0.__resq_SixthQuitMapResp(arg_27_0, arg_27_1)
		var_0_1:getInstance("sixth_map_node"):__close_panel()
	end

	function arg_1_0.__team__save_team_ok(arg_28_0)
		local var_28_0 = var_0_1:getInstance("team_group")
		local var_28_1 = var_0_1:getInstance("dock_team")

		if var_28_0 then
			var_28_0:save_team_ok()
		end

		if var_28_1 then
			var_28_1:refresh_info_list()
		end

		local var_28_2 = var_0_1:getInstance("fight_prepare")

		if var_28_2 and var_28_2._current_content_type ~= var_0_7.enter_select_member_type.pre_formation and var_0_8:get_come_in_panel_style() ~= 12 then
			var_28_2:refresh_info_list()
		end

		local var_28_3 = var_0_1:getInstance("pre_formation")

		if var_28_3 then
			var_28_3:refresh_info_list()
		end
	end

	function arg_1_0.__team__save_team_error(arg_29_0, arg_29_1)
		local var_29_0 = var_0_1:getInstance("pre_formation")

		if var_29_0 then
			var_29_0:team_save_error(arg_29_1)

			return
		end

		local var_29_1 = var_0_1:getInstance("fight_prepare")

		if var_29_1 then
			var_29_1:team_save_error(arg_29_1)
		end

		local var_29_2 = var_0_1:getInstance("dock_team")

		if var_29_2 then
			var_29_2:team_save_error(arg_29_1)
		end
	end

	function arg_1_0.__resq_EnterSixthBigMapResp(arg_30_0, arg_30_1)
		if arg_30_1.result == 0 then
			if var_0_1:getInstance("select_member") then
				var_0_1:destroyInstance("select_member")
			end

			local var_30_0 = var_0_8:find_prev_bigmap(var_0_1:getInstance("six_year_main_interface").now_map_level)
			local var_30_1

			if var_30_0.id <= 10006 then
				var_30_1 = 9301 + var_30_0.id % 10000 * 3 - 3
			elseif var_30_0.id > 10006 then
				var_30_1 = 9301 + var_30_0.id % 10000 * 3
			end

			var_0_8:req_EnterSixthMapReq(var_30_1)
		end
	end

	function arg_1_0.__team__update_team_group(arg_31_0, arg_31_1)
		return
	end

	function arg_1_0.__team__add_team_group(arg_32_0, arg_32_1)
		return
	end

	function arg_1_0.__team__remove_team_group(arg_33_0, arg_33_1)
		return
	end

	function arg_1_0.set_campaign_team_info(arg_34_0, arg_34_1)
		arg_34_0._campaign_team = arg_34_1
	end

	function arg_1_0:get_campaign_team_info()
		return self._campaign_team
	end

	function arg_1_0.set_bvr_state(arg_36_0, arg_36_1)
		arg_36_0._save_bvr_state = arg_36_1
	end

	function arg_1_0:get_bvr_state()
		return self._save_bvr_state
	end
end

function var_0_0.extend_obj(arg_38_0)
	arg_38_0._team_data = {}
	arg_38_0._campaign_info = {}
	arg_38_0._campaign_count = 0
	arg_38_0._campaign_time = 0
	arg_38_0._current_team = 1
	arg_38_0._gotofight_memory_team_index = 1
	arg_38_0._fast_pre_formation = false
	arg_38_0._save_bvr_state = false
end

return var_0_0
