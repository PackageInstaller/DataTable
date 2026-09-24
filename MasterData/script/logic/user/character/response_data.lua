local var_0_0 = {}
local var_0_1 = gameenum.error_type
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.UILoader
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.user
local var_0_7 = gameconfig.ship_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.ShipRenameResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_4:getInstance("ship_detail")

			if var_2_0 then
				var_2_0:update_name()
			end

			local var_2_1 = var_0_4:getInstance("select_member")

			if var_2_1 then
				var_2_1:update_data()
			end
		else
			var_0_2:show(var_0_1:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0:ShipLockResp(arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_4:getInstance("ship_detail")

			if var_3_0 and var_3_0._panel.activeSelf then
				var_3_0:update_lock()
			end

			if var_0_4:getInstance("mail") and var_0_6:get_get_all_mail_state() then
				self:__show_special_ship_detail()

				return
			end

			local var_3_1 = var_0_4:getInstance("new_ship_or_equip")

			if var_3_1 and not var_3_0 then
				if var_3_1._back_func then
					var_3_1:update_lock()
					var_3_1:__set_guide_data()

					return
				end

				if var_3_1:get_lock_type() then
					var_3_1:update_lock()
					var_3_1:__set_guide_data()
					var_3_1:__show_next()

					if var_3_1._data_length == 1 then
						var_3_1:leave_ship()

						return
					end

					if var_3_1._is_click_num == var_3_1._data_length then
						if var_3_1._is_first_equal then
							var_3_1._is_first_equal = false
						else
							var_3_1:leave_ship()
						end
					end
				else
					var_3_1:update_lock()
				end
			end

			local var_3_2 = var_0_4:getActiveInstance("remake")

			if var_3_2 then
				var_3_2:update_data()
			end

			if var_0_4:getInstance("bootyshop") then
				var_0_4:destroyInstance("new_ship_or_equip")
			end

			local var_3_3 = var_0_4:getInstance("select_member")

			if var_3_3 then
				var_3_3:update_data()
			end
		end
	end

	function arg_1_0.ChangeSecretaryResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_4:getInstance("ship_detail")

			if var_4_0 then
				var_4_0:update_secretary()
			end
		else
			var_0_2:show(var_0_1:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.ResetSecretaryResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_4:getInstance("ship_detail")

			if var_5_0 then
				var_5_0:update_secretary()
			end
		else
			var_0_2:show(var_0_1:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0.ShipEquipResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			local var_6_0 = var_0_4:getInstance("equip_list")

			if var_6_0 then
				var_6_0:hide()
			end
		else
			var_0_2:show(var_0_1:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.ShipRemoveEquipResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			if var_0_6:get_remove_equip_temp() == 2 then
				local var_7_0 = var_0_4:getInstance("ship_detail")

				if var_7_0 then
					var_7_0:update_data()
				end

				local var_7_1 = var_0_4:getInstance("equip_list")

				if var_7_1 and not var_7_1._is_use_equip then
					var_7_1:update_data()
					var_7_1:set_equip_input_fidle()
					var_7_1:show_input_equip()
				elseif var_7_1 and var_7_1._is_use_equip then
					var_7_1:update_data()
					var_7_1:_show_already_use_equip(var_7_1._is_use_equip)
					var_7_1:show_input_equip()
				end
			else
				local var_7_2 = var_0_4:getInstance("ship_detail")

				if var_7_2 then
					var_7_2:update_data()
				end

				local var_7_3 = var_0_4:getInstance("equip_list")

				if var_7_3 then
					var_7_3:hide()
				end
			end
		else
			var_0_2:show(var_0_1:get_err_msg(arg_7_1.result))
		end
	end

	function arg_1_0:EquipLockResp(arg_8_1)
		if arg_8_1.result == 0 then
			local var_8_0 = var_0_4:getInstance("equip_list")
			local var_8_1 = var_0_4:getInstance("equip_list")

			if var_0_4:getInstance("mail") and var_0_6:get_get_all_mail_state() then
				self:__show_special_equip_info_detail()
			end

			if var_8_1 then
				var_8_1:update_data(true)
				var_8_1:set_can_lock_seq()
				var_8_1:set_equip_input_fidle_type_out()

				if var_8_1._is_use_equip then
					var_8_1:_show_already_use_equip(true)
				else
					var_8_1:__update_cell_list()
				end
			else
				local var_8_2 = var_0_4:getInstance("mix_main_map")

				if var_8_2 then
					var_8_2:check_if_first_pass_and_switch()
				end
			end

			local var_8_3 = var_0_4:getInstance("ship_detail")

			if var_8_3 then
				var_8_3:__init_equips()
			end
		else
			var_0_2:show(var_0_1:get_err_msg(arg_8_1.result))
		end
	end

	function arg_1_0.ShipMarryResp(arg_9_0, arg_9_1)
		if arg_9_1.result == 0 then
			local var_9_0 = var_0_4:getInstance("marry")

			if var_9_0 then
				var_9_0:marry_ok()
			end
		else
			var_0_2:show(var_0_1:get_err_msg(arg_9_1.result))
		end
	end

	function arg_1_0.ShipChangeTacticsResp(arg_10_0, arg_10_1)
		if arg_10_1.result == 0 then
			local var_10_0 = var_0_4:getInstance("ship_detail")

			if var_10_0 then
				var_10_0:update_data()
				var_10_0:__onClick_right_ship_detail_detail_info_right_arrow()

				local var_10_1 = var_0_4:getInstance("change_tactics")

				if var_10_1 then
					var_10_1:update_data(var_10_0._data)
				end
			end
		elseif arg_10_1.result == 167 then
			var_0_2:show(var_0_3:getNowLang("battlecanttactic"))
		else
			var_0_2:show(var_0_3:getNowLang("cannotequiplearning"))
		end

		var_0_4:destroyInstance("loading")
	end

	function arg_1_0.IntensifyShipResp(arg_11_0, arg_11_1)
		if arg_11_1.result == 0 then
			local var_11_0 = var_0_4:getInstance("remake")

			if var_11_0 then
				var_11_0:reset_strengther_res_data()
				var_11_0:update_data()
				var_11_0:clear_strengther_res_data()
			end

			var_11_0:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.streng_success))
		else
			var_0_2:show(var_0_1:get_err_msg(arg_11_1.result))
		end
	end

	function arg_1_0.IntensifySkillResp(arg_12_0, arg_12_1)
		local var_12_0 = var_0_4:getInstance("remake")

		if arg_12_1.result == 0 then
			if var_12_0 then
				var_12_0:update_data()
				var_12_0:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.get_ship_equip))
			end
		elseif arg_12_1.result == 3 then
			var_0_2:show(var_0_3:getNowLang("errorcode_114"))
		else
			var_0_2:show(var_0_1:get_err_msg(arg_12_1.result))
		end

		var_12_0:uplevel(true)
	end

	function arg_1_0.ShipChangeSkillResp(arg_13_0, arg_13_1)
		if arg_13_1.result == 0 then
			local var_13_0 = var_0_6:get_save_remake_skill()
			local var_13_1
			local var_13_2
			local var_13_3 = var_0_4:getInstance("remake")
			local var_13_4 = 0

			if var_13_3 then
				var_13_4 = var_13_3:get_panel_type()
			end

			if var_13_0 then
				var_13_1 = var_0_6:find_character_by_id(var_13_0.id)
			end

			if var_13_1 then
				var_13_2 = var_0_7.find_object_by_cid(var_13_1.cid).skills
			end

			if var_13_2 and #var_13_2 > 1 and (var_13_2[1] == var_13_0.skill_id or var_13_2[2] == var_13_0.skill_id) and var_13_4 == var_0_5.enter_select_member_type.evo then
				var_0_2:show(var_0_3:getNowLang("free_change_skill"))
			end

			local var_13_5 = var_0_4:getActiveInstance("new_ship_or_equip")

			if var_13_5 then
				var_13_5:change_skill_result()
			elseif var_13_3 then
				var_13_3:update_data()
			end
		elseif arg_13_1.result == 3 then
			var_0_2:show(var_0_3:getNowLang("errorcode_114"))
		else
			var_0_2:show(var_0_1:get_err_msg(arg_13_1.result))
		end
	end

	function arg_1_0.ShipEvoResp(arg_14_0, arg_14_1)
		local var_14_0 = var_0_4:getInstance("remake")

		if arg_14_1.result == 0 then
			if var_14_0 then
				var_14_0:setVisible(false)
				var_0_4:createInstance("new_ship_or_equip"):show(true, {
					data = var_14_0:get_evo_data(),
					is_new = arg_14_1.is_new,
					get_skin = arg_14_1.get_skin
				}, var_0_5.enter_get_ship_type.remake)
			end
		else
			if var_14_0 then
				var_14_0:setVisible(true)
			end

			var_0_2:show(var_0_1:get_err_msg(arg_14_1.result))
		end
	end

	function arg_1_0.ShipEquipRecordResp(arg_15_0, arg_15_1)
		if arg_15_1.result == 0 then
			var_0_4:createInstance("equip_record"):update_data()
		else
			var_0_2:show(var_0_1:get_err_msg(arg_15_1.result))
		end
	end

	function arg_1_0.UseEquipRecordResp(arg_16_0, arg_16_1)
		if arg_16_1.result == 0 then
			var_0_4:createInstance("equip_record"):use_equip_recore()
			var_0_2:show(var_0_3:getNowLang("equipchangesuccess"))
		else
			var_0_2:show(var_0_1:get_err_msg(arg_16_1.result))
		end
	end

	function arg_1_0.ShipChangeSkinResp(arg_17_0, arg_17_1)
		if arg_17_1.result == 0 then
			local var_17_0 = var_0_4:createInstance("ship_detail")

			if var_17_0 then
				var_17_0:change_skin()
			end

			local var_17_1 = var_0_4:getInstance("captainroom_fleet")

			if var_17_1 then
				var_17_1:__init_panel()
			end
		elseif arg_17_1.result == 129 then
			var_0_2:show(var_0_1:get_err_msg(arg_17_1.result))
		else
			var_0_2:show(var_0_1:get_err_msg(arg_17_1.result))
		end
	end

	function arg_1_0.MultiShipChangeSkinResp(arg_18_0, arg_18_1)
		if arg_18_1.result == 0 then
			local var_18_0 = var_0_4:getInstance("ship_detail")

			if var_18_0 and (var_18_0._is_single or var_18_0._is_team) then
				var_18_0:change_skin()
			end

			local var_18_1 = var_0_4:getInstance("new_ship_or_equip")

			if var_18_1 then
				var_18_1:leave_ship()
			end

			local var_18_2 = var_0_4:getInstance("ship_detail")
			local var_18_3 = var_0_4:getInstance("mall_shop")

			if var_18_3 and not var_18_2 then
				var_18_3:setVisible(true)
			elseif var_18_3 and var_18_2 then
				var_18_3:clear_search_text()
				var_18_3:__update_skin_cell()
			end

			local var_18_4 = var_0_4:getInstance("voucher_shop")

			if var_18_4 then
				var_18_4:setVisible(true)

				if var_18_3 then
					var_18_3:setVisible(false)
				end
			end

			if var_0_4:getInstance("change_skin_panel") then
				gamecore.prompt:show(var_0_3:getNowLang("replace_success"))
				var_0_4:destroyInstance("change_skin_panel")

				return
			end
		elseif arg_18_1.result == 129 then
			var_0_2:show(var_0_1:get_err_msg(arg_18_1.result))
		else
			var_0_2:show(var_0_1:get_err_msg(arg_18_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_19_0)
	return
end

return var_0_0
