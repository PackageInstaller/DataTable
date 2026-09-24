local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_tip_layer_setting_rule_button_1()
		var_0_1:createInstance("settingrule_childbox"):show(1)
		self:setVisible(false)
	end

	function arg_1_0:__onClick_tip_layer_setting_rule_button_2()
		var_0_1:createInstance("settingrule_childbox"):show(2)
		self:setVisible(false)
	end

	function arg_1_0:__onClick_tip_layer_setting_rule_button_3()
		var_0_1:createInstance("settingrule_childbox"):show(3)
		self:setVisible(false)
	end

	function arg_1_0:__onClick_tip_layer_setting_rule_button_4()
		var_0_1:createInstance("settingrule_childbox"):show(4)
		self:setVisible(false)
	end

	function arg_1_0:__onClick_tip_layer_close()
		var_0_2:play_in_out_animation(self._control.tip_layer.uITweenSequence, false, function()
			var_0_1:destroyInstance("jp_setting_rule_page")
			var_0_1:destroyInstance("settingrule_childbox")
			var_0_1:createInstance("setting"):show()
		end)
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
