local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.error_type
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.OceanSaveTeamResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("fight_prepare")

			if var_2_0 then
				var_2_0:refresh_ocean_info_list()
			end

			local var_2_1 = var_0_1:getInstance("pre_formation")

			if var_2_1 then
				var_2_1:refresh_info_list()

				return
			end
		end
	end

	function arg_1_0.OceanEnterMapResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			var_0_1:createInstance("fight_prepare"):enter_map_resp()
			var_0_1:destroyInstance("ocean_main_map")
		else
			var_0_4:show(var_0_3:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0:OceanBuyResp(arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_1:getInstance("ocean_cia")

			if var_4_0 then
				var_4_0._ocean_map_buff_list = self:get_ocean_map_buff_list()

				var_4_0:after_buy_succeed_update()
				var_0_4:show(var_0_2:getNowLang("settingcouponsuccess"))
			end
		else
			var_0_4:show(var_0_2:getNowLang("settingcouponfail"))
		end
	end

	function arg_1_0.OceanResetBuyResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_1:getInstance("ocean_cia")

			if var_5_0 then
				var_0_5:clear_ocean_map_buff_list()
				var_5_0:after_reset_succeed_update()
				var_0_4:show(var_0_2:getNowLang("ui_4th_buff_reset_tip"))
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0:OceanMoveMapResp(arg_6_1)
		self._map_data.map_move = arg_6_1

		if arg_6_1.result == 0 then
			var_0_1:createInstance("fight_info"):__map_move_response(arg_6_1)
		else
			var_0_4:show(var_0_3:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.OceanQuitMapResp(arg_7_0, arg_7_1)
		return
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
