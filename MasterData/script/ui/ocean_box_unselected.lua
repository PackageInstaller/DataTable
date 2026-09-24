local var_0_0 = {}
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.util_func
local var_0_5 = gameconfig.ocean_map_node_config

gamecore.UILoader:define("ocean_box_unselected", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self.id = arg_2_1

		self:__init_panel(arg_2_1, arg_2_2)
	end

	function arg_1_0:__init_panel(arg_3_1, arg_3_2)
		self._cur_config = var_0_5.find_object_by_id_start_node_id(arg_3_1, arg_3_2)
		self._control.ocean_box_1.desc_1.text.text = var_0_4.convert_rich_text(self._cur_config.route_desc_1[1].value)
		self._control.ocean_box_1.desc_2.text.text = var_0_4.convert_rich_text(self._cur_config.route_desc_2[1].value)
		self._control.ocean_box_2.desc_1.text.text = var_0_4.convert_rich_text(self._cur_config.route_desc_1[2].value)
		self._control.ocean_box_2.desc_2.text.text = var_0_4.convert_rich_text(self._cur_config.route_desc_2[2].value)

		for iter_3_0 = 1, 2 do
			self._route_num_list[iter_3_0] = self._cur_config.route_desc_1[iter_3_0].id
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_3:class("ocean_box_unselected")

	var_4_0._cur_config = {}
	var_4_0._route_num_list = {}

	return var_4_0
end

return var_0_0
