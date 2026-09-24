local var_0_0 = {}
local var_0_1 = gameenum.error_type
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:TeamSaveResp(arg_2_1)
		if arg_2_1.result == 0 then
			self:__team__save_team_ok()
		else
			self:__team__save_team_error(arg_2_1.result)
		end
	end

	function arg_1_0:TeamRenameResp(arg_3_1)
		if arg_3_1.result == 0 then
			self:__team_rename_ok()
		else
			self:__team_rename_error(arg_3_1.result)
		end
	end

	function arg_1_0:CampaignTeamSaveResp(arg_4_1)
		if arg_4_1.result == 0 then
			self:__update_campaign()

			local var_4_0 = var_0_4:getInstance("fight_prepare")

			if var_4_0._is_onclick_quick_supply == true and var_4_0._is_onclick_quick_repair == false then
				var_4_0:__set_total_supply_panel_data()
			elseif var_4_0._is_onclick_quick_supply == false and var_4_0._is_onclick_quick_repair == true then
				var_4_0:__set_total_repair_panel_data()
			end
		else
			self:__sava_campaign_error(arg_4_1.result)
		end
	end

	function arg_1_0:EnterCampaignResp(arg_5_1)
		if arg_5_1.result == 0 then
			self._campain_info = arg_5_1

			self:__resq_EnterCampaignResp(arg_5_1)
		elseif arg_5_1.result == 11 then
			var_0_2:show(var_0_3:getNowLang("pvecampaignshipneedsupply"))
		elseif arg_5_1.result == 10 then
			var_0_2:show(var_0_3:getNowLang("pvecampaignshipinrepair"))
		else
			var_0_2:show(var_0_1:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0:TeamExchangeResp(arg_6_1)
		if arg_6_1.result == 0 then
			self:__team__save_team_ok()
		else
			self:__team__save_team_error(arg_6_1.result)
		end
	end

	function arg_1_0:EnterSixthBigMapResp(arg_7_1)
		self:__resq_EnterSixthBigMapResp(arg_7_1)
	end

	function arg_1_0:RefreshCampaignResp(arg_8_1)
		if arg_8_1.result == 0 then
			self:__resq_Freshcampaign()
		elseif arg_8_1.result == 14 then
			var_0_2:show(var_0_3:getNowLang("money_not_enough"))
		elseif arg_8_1.result == 50 then
			var_0_2:show(var_0_3:getNowLang("errorcode_149"))
		end
	end

	function arg_1_0:SixthQuitMapResp(arg_9_1)
		if arg_9_1.result then
			self:__resq_SixthQuitMapResp(arg_9_1)
		end
	end

	function arg_1_0.BVRAttackChangeResp(arg_10_0, arg_10_1)
		if arg_10_1.result == 0 then
			-- block empty
		else
			var_0_2:show(var_0_1:get_err_msg(arg_10_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
