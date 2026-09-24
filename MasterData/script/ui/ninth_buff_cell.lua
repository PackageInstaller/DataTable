local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.util_func
local var_0_3 = gameconfig.pve_ninth_buff_config

gamecore.UILoader:define("ninth_buff_cell", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1, arg_3_2)
		self:setVisible(true)

		self._index = arg_3_1

		self:__init_panel(arg_3_2)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self._control.detail_txt.text.text = var_0_2.convert_rich_text(var_0_3.find_object_by_id(arg_4_1).effect_desc)
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_6_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_1:class("ninth_buff_cell")

	var_7_0:__initia_lize()

	return var_7_0
end

return var_0_0
