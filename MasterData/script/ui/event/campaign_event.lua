local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.user
local var_0_5 = lx.UserData

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_difficulty_btn()
		self._difficulty = self._difficulty == 2 and 1 or 2

		self:__play_scroll_animation()
		var_0_4:set_campaign_difficulty(self._difficulty)
		var_0_5:setKeyData("campaign" .. tostring((var_0_4:get_account_id())) .. tostring((var_0_4:get_server_name())), self._difficulty)
	end

	function arg_1_0.__onClick_revent_btn(arg_3_0)
		var_0_2:createInstance("shop_bounced"):show({
			price = var_0_1.campaign_reset_cost,
			lang_title = var_0_3:getNowLang("campaignresettitle")
		}, var_0_1.buy_enter_type.exchangel_campaign_panel)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
