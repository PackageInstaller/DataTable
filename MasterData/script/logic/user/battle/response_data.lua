local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.SceneManager
local var_0_3 = gameenum.error_type
local var_0_4 = gamecore.prompt
local var_0_6 = gamecore.user
local var_0_7 = gameenum.common_type
local var_0_11 = gameconfig.pve_mix_level_node_config
local var_0_12 = gameconfig.pve_eighth_level_node_config
local var_0_17 = gameconfig.score_map_node_config
local var_0_19 = gameconfig.map_node_config
local var_0_20 = gameconfig.shop_config
local var_0_22 = gameconfig.pve_active_map_node_config
local var_0_23 = string.sub
local var_0_24 = gamecore.AudioManager
local var_0_25 = crypto.md5
local var_0_26 = gameconfig.pve_ninth_level_node_config
local var_0_27 = lx.json_decode

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:StartBattleResp(arg_2_1)
		local var_2_0 = var_0_1:getInstance("fight_info")

		if var_2_0 then
			var_2_0:set_send_req_state(true)
		end

		if arg_2_1.result == 0 then
			local var_2_1 = var_0_1:createInstance("loading")

			var_2_1:show(true, nil, false, "")
			self:set_new_battle_type(arg_2_1.battle_info.type)

			self._battle_data = arg_2_1

			local var_2_2 = var_0_6:get_battle_type()
			local var_2_3 = var_0_1:createInstance(var_0_7:get_battle_name())

			if arg_2_1.lose > 0 then
				if self._battle_data.battle_info.point then
					local var_2_4 = var_0_19.find_object_by_id(self._battle_data.battle_info.point)

					if var_2_2 == 18 then
						var_2_4 = var_0_22.find_object_by_id(self._battle_data.battle_info.point)
					elseif var_2_2 == var_0_7.fight_type.seventh then
						var_2_4 = var_0_11.find_object_by_id(self._battle_data.battle_info.point)
					elseif var_2_2 == var_0_7.fight_type.eighth_attack then
						var_2_4 = var_0_12.find_object_by_id(self._battle_data.battle_info.point)
					end

					if var_2_4 then
						if var_2_4.pve_level_id < 1000 then
							self._last_map_node = {
								chapter_index = tonumber(var_0_23(var_2_4.pve_level_id, 1, 1)),
								small_mapindex = tonumber(var_0_23(var_2_4.pve_level_id, 3, 3))
							}
						end

						if var_2_4.night_atk == 1 then
							var_0_4:show(tostring(arg_2_1.lose), "night_consume")
						else
							var_0_4:show(tostring(arg_2_1.lose), "battle_start_consume")
						end
					elseif arg_2_1.battle_info.type == gameenum.battle_type.fight_type.score then
						if var_0_6:get_to_score() and arg_2_1.lose == 1 and var_0_17.find_object_by_id_start_node_id(arg_2_1.battle_info.point, (var_0_6:get_current_score_map_start_point())).night_atk == 1 then
							var_0_4:show(tostring(arg_2_1.lose), "night_consume")
						else
							var_0_4:show(tostring(arg_2_1.lose), "battle_start_consume")
						end
					elseif arg_2_1.battle_info.type == gameenum.battle_type.fight_type.ninth then
						if var_0_6:get_to_ninth() and arg_2_1.lose == 1 and var_0_26.find_object_by_id_start_node_id(arg_2_1.battle_info.point, (var_0_6:get_ninth_map_start_point())).night_atk == 1 then
							var_0_4:show(tostring(arg_2_1.lose), "night_consume")
						else
							var_0_4:show(tostring(arg_2_1.lose), "battle_start_consume")
						end
					elseif var_0_6:get_to_score() and arg_2_1.lose == 1 then
						var_0_4:show(tostring(arg_2_1.lose), "night_consume")
					else
						var_0_4:show(tostring(arg_2_1.lose), "battle_start_consume")
					end
				else
					var_0_4:show(tostring(arg_2_1.lose), "battle_start_consume")
				end
			end

			local var_2_5 = var_0_1:getInstance("fight_info")
			local var_2_6 = var_0_1:getInstance("campaign_select")
			local var_2_7 = var_0_27(self._battle_data.record)[3].param.data.bg_sea

			if var_2_7 and var_0_7:check_is_revamp(var_2_7) then
				var_0_7:set_is_new_battle(true)
			else
				var_0_7:set_is_new_battle(false)
			end

			if var_2_5 then
				if var_0_6:get_bvr_state() then
					var_2_1:show(false, nil, false, "")
					var_0_1:createInstance("bvr_info_pro"):show(var_2_5._now_into_param, var_2_5._save_enemy_array, arg_2_1, var_2_2, false, var_2_5._save_enemy_id, var_2_5._save_enemy_name)
				else
					var_2_5:__start_battle_response(arg_2_1)
				end
			elseif var_2_6 then
				if var_0_6:get_bvr_state() then
					var_2_6._set_bvr_btn_isOn = false

					var_2_6._control.enemy_info_bg.bvr_btn.spine_effect:SetActive(false)
					var_2_1:show(false, nil, false, "")
					var_0_1:createInstance("bvr_info_pro"):show(var_2_6._team_use_bvr_info, var_2_6._use_bvr_enemy_info, arg_2_1, var_0_6:get_new_battle_type(), true)
				else
					var_2_6:__start_battle_response(arg_2_1)
				end
			else
				var_0_2:loadScene(var_0_7:get_battle_scene_name(), function()
					var_0_1:destroyStateUISet("game")
					var_0_1:createInstance(var_0_7:get_battle_name()):show()
				end)
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0.StartNightBattleResp(arg_4_0, arg_4_1)
		local var_4_0 = var_0_1:getInstance("loading")

		if var_4_0 then
			var_4_0:show(false)
		end

		if arg_4_1.result == 0 then
			if arg_4_1.lose > 0 then
				var_0_4:show(tostring(arg_4_1.lose), "night_consume")
			end

			local var_4_1 = var_0_1:getInstance(var_0_7:get_battle_name())

			var_4_1:hide_night_war_tip()

			local var_4_2 = var_0_6:get_item_count(var_0_20.find_object_by_id(var_0_7.shop_damage_control_cid).content[1].id)
			local var_4_3 = var_0_6:get_battle_info()

			if var_0_7:get_is_new_battle() then
				gamecore.BattleRevampManager:handleBattleScene("night_attack_step", {
					damage_control_num = var_4_2
				})
			else
				gamecore.BattleManager:handleBattleScene("night_attack_step", {
					damage_control_num = var_4_2
				})
			end

			var_4_1:play_night_bgm()

			return
		end

		var_0_4:show(var_0_3:get_err_msg(arg_4_1.result))
	end

	function arg_1_0.BattleFinishResp(arg_5_0, arg_5_1)
		var_0_24:destroyCV()
		var_0_24:init()

		local var_5_0 = var_0_1:getInstance("loading")

		if var_5_0 then
			var_5_0:show(false)
		end

		if arg_5_1.result == 0 then
			arg_5_0._battle_settlement_info = {
				result = arg_5_1.md5_result,
				battle_id = arg_5_1.battle_id,
				reward = arg_5_1.reward,
				state = arg_5_1.state,
				enemy_state = arg_5_1.enemy_state,
				grade = arg_5_1.grade,
				score = arg_5_1.score,
				enemy_score = arg_5_1.enemy_score,
				finish = arg_5_1.finish,
				exp = arg_5_1.exp,
				monster = arg_5_1.monster,
				monster_array = arg_5_1.monster_array
			}
		else
			var_0_4:show(var_0_3:get_err_msg(arg_5_1.result))

			return
		end

		local var_5_1 = gamecore.BattleManager:getBattleResult()

		if var_0_7:get_is_new_battle() then
			var_5_1 = gamecore.BattleRevampManager:getBattleResult()
		end

		if var_0_25.sum(lx.format_to_json(var_5_1, {})) ~= arg_5_1.md5_result then
			local var_5_2 = gamecore.BattleManager:getBattleDamageResult()

			var_0_6:req_BattleLogReq(encode.quicklz_compress(lx.json_format({
				result = var_5_1,
				record = var_0_6:get_battle_data().record,
				battle = (var_0_7:get_is_new_battle() or nil) and gamecore.BattleRevampManager:getBattleDamageResult() or ""
			})))
		end

		var_0_2:loadScene("main", function()
			local var_6_0 = arg_5_0:get_battle_result()

			arg_5_0._battle_settlement_info = var_6_0

			local var_6_1 = var_0_1:createInstance("combat_result")

			var_0_1:destroyInstance("battle")

			local var_6_2 = var_0_6:get_new_battle_type()

			if var_6_2 then
				var_6_1:show(var_6_0, var_6_2)
			else
				var_6_1:show(var_6_0)
			end
		end)
	end

	function arg_1_0.QuitNightBattleResp(arg_7_0, arg_7_1)
		return
	end

	function arg_1_0.BattleLogResp(arg_8_0)
		return
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
