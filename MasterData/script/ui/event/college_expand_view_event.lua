local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_base_panel_return_btn()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_parent_expand_btn()
		local var_3_0, var_3_1 = self:__get_expand_need_diamond()

		var_0_1:createInstance("shop_bounced"):show({
			price = var_3_0,
			title = var_0_2:getNowLang("schoolexpand"),
			is_get = var_3_1
		}, var_0_3.buy_enter_type.school)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
