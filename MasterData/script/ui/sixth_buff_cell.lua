local var_0_0 = {}
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.util_func
local var_0_5 = gameconfig.sixth_combat_buff_config

gamecore.UILoader:define("sixth_buff_cell", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._index = arg_2_1

		self:__init_panel(arg_2_2)
	end

	function arg_1_0:__init_panel(arg_3_1)
		self._control.lvl_bg.lvl_text.text.text = string.format("Lv.%s", arg_3_1.level)
		self._control.detail_txt.text.text = var_0_4.convert_rich_text(var_0_5.find_object_by_id(arg_3_1.id * 100 + arg_3_1.level).effect_desc)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	return (var_0_3:class("sixth_buff_cell"))
end

return var_0_0
