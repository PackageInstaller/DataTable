local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.Language
local var_0_4 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_content_close_btn(arg_2_0)
		var_0_1:destroyInstance("change_tactics")
	end

	function arg_1_0:__onClick_content_goto_school()
		if self._enter_type == var_0_4.enter_ship_detail_type.sixth_select or self._enter_type == var_0_4.enter_ship_detail_type.sixth_fight_prepare or self._enter_type == var_0_4.enter_ship_detail_type.strike_fight_prepare then
			var_0_2:show(var_0_3:getNowLang("inoutcannotgotoshool"))

			return
		end

		if var_0_1:getInstance("home") then
			var_0_1:destroyInstance("home")
		end

		self:setVisible(false)

		local var_3_0 = var_0_1:createInstance("ship_detail")

		if var_3_0 and var_3_0:__check_strike_battle_number("school") then
			return
		end

		if var_0_1:createInstance("ship_detail") then
			var_0_1:destroyInstance("ship_detail")
		end

		local var_3_1 = var_0_1:getInstance("gotofight")

		if var_3_1 then
			var_3_1:setVisible(false)
		end

		local var_3_2 = var_0_1:getInstance("select_member")

		if var_3_2 then
			var_3_2:__onClick_bg_container_back_btn()
			var_3_2:setVisible(false)
		end

		local var_3_3 = var_0_1:getInstance("bathroom")

		if var_3_3 then
			var_3_3:setVisible(false)
		end

		if var_0_1:getInstance("dock_team") then
			var_0_1:destroyInstance("dock_team")
		end

		if var_0_1:getInstance("pre_formation") then
			var_0_1:destroyInstance("pre_formation")
		end

		if var_0_1:getInstance("mix_main_map") then
			var_0_1:destroyInstance("mix_main_map")
		end

		if var_0_1:getInstance("seven_sea_map") then
			var_0_1:destroyInstance("seven_sea_map")
		end

		if var_0_1:getInstance("captainroom_fleet") then
			var_0_1:destroyInstance("captainroom_fleet")
		end

		if var_0_1:getInstance("fight_prepare") then
			var_0_1:destroyInstance("fight_prepare")
		end

		if var_0_1:getInstance("change_tactics") then
			var_0_1:destroyInstance("change_tactics")
		end

		if var_0_1:getInstance("remake") then
			var_0_1:destroyInstance("remake")
		end

		if var_0_1:getInstance("select_member") then
			var_0_1:destroyInstance("select_member")
		end

		local var_3_4 = var_0_1:getInstance("ship_clerk_prepare")

		if var_3_4 then
			var_3_4:setVisible(false)
			var_0_1:destroyInstance("ship_clerk_prepare")
		end

		var_0_1:createInstance("school"):show()
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
