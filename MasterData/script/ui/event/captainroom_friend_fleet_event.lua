local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_close_btn()
		self:setVisible(false)
		var_0_3:set_other_info(nil)
	end

	function arg_1_0:__onClick_bg_challenge_btn()
		self:setVisible(false)
		var_0_3:set_other_info(nil)
		self:__enter_friend_fight()
		var_0_1:createInstance("fight_prepare"):show({
			firend_account_id = self._friend_data.account_id,
			fight_prepare_type = self._now_enter_type
		})
		var_0_3:set_maneuver_target_info(self._friend_data)
		self:show_layer(false)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
