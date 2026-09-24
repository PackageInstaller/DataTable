local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_bg_btn()
		local var_2_0 = var_0_1:getInstance("gotofight")

		if var_2_0 then
			var_2_0:setVisible(false)
		end

		if self._curr_expedition_state == var_0_2.expedition_state.prepare then
			var_0_1:createInstance("fight_prepare"):show({
				fight_prepare_type = var_0_2.fight_type.farfight,
				farfight_data = self._item_data
			})
		elseif self._curr_expedition_state == var_0_2.expedition_state.ongoing then
			local var_2_1 = var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")

			local function var_2_2()
				var_0_3:req_ExpeditionStopReq(self._item_data.id)
			end

			var_2_0:setVisible(true)
			var_2_1:show(var_0_4:getNowLang("pvebacksubtitle"), var_2_2, nil, var_0_4:getNowLang("pvebacktitle"), var_0_2.msg_type.tip)
		elseif self._curr_expedition_state == var_0_2.expedition_state.done then
			local var_2_3 = {}

			for iter_2_0, iter_2_1 in pairs(var_0_3:get_team_by_id(var_0_3:get_expedition_info(self._item_data.id).team).members) do
				var_2_3[iter_2_1] = var_0_3:find_character_by_id(iter_2_1).level
			end

			var_0_3:set_expedition_level(var_2_3)
			var_0_3:req_ExpeditionFinishReq(self._item_data.id)
		end
	end

	function arg_1_0:__onClick_bg_bg_btn_prepare_group_fight_btn()
		local var_4_0 = var_0_1:getInstance("gotofight")

		if var_4_0 then
			var_4_0:setVisible(false)
		end

		var_0_1:createInstance("fight_prepare"):show({
			fight_prepare_type = var_0_2.fight_type.farfight,
			farfight_data = self._item_data
		})
	end

	function arg_1_0.__onClick_bg_bg_btn_going_group_cancel_btn(arg_5_0)
		(var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")):show(var_0_4:getNowLang("pvebacksubtitle"), function()
			var_0_3:req_ExpeditionStopReq(arg_5_0._item_data.id)

			if app:getSystem():getChannel() == "hm_android" and var_0_2:get_now_appversion_num() > var_0_2.version_init_num then
				local var_6_0 = var_0_3:get_expedition_info(arg_5_0._item_data.id)

				log.print_r(var_6_0.team, "确定取消的id：")
				NotifyManager.CancelNotificationById(var_6_0.team)
			end

			arg_5_0:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		end, function()
			arg_5_0:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		end, var_0_4:getNowLang("pvebacktitle"), var_0_2.msg_type.tip)
	end

	function arg_1_0:__onClick_bg_bg_btn_done_group_done_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.get_ship_equip))

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(var_0_3:get_team_by_id(var_0_3:get_expedition_info(self._item_data.id).team).members) do
			var_8_0[iter_8_1] = var_0_3:find_character_by_id(iter_8_1).level
		end

		var_0_3:set_expedition_level(var_8_0)
		var_0_3:req_ExpeditionFinishReq(self._item_data.id)
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
