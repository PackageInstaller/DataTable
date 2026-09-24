local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_bg_btn()
		if var_0_2:getInstance("gotofight") then
			var_0_2:destroyInstance("gotofight")
		end

		local var_2_0 = var_0_2:createInstance("fight_prepare")

		var_0_3:set_campaign_map_id(self._map_id)
		self:__check_remake_ship()
		var_2_0:show({
			campaign = true,
			fight_prepare_type = var_0_1.fight_type.campaign,
			go_to_map_id = self._map_id,
			difficulty = self._difficulty,
			config_data = self._config_data
		})
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
