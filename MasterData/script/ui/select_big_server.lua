local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language

gamecore.UILoader:define("select_big_server", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self._control.region_select.text.text = var_0_2:getNowLang("region_select")
		self._control.region_android.Text.text.text = var_0_2:getNowLang("region_android")
		self._control.region_ios.Text.text.text = var_0_2:getNowLang("region_ios")
		self._control.region_desc.text.text = var_0_2:getNowLang("region_desc")
	end

	function arg_1_0.__onReset(arg_4_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	return (var_0_1:class("select_big_server"))
end

return var_0_0
