local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_btn_confirm()
		self:setVisible(false)
		var_0_1:createInstance("jp_setting_rule_page"):show()
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
