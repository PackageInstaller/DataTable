local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gameconfig.ocean_map_node_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_ocean_box_1()
		local var_2_0 = var_0_2:getInstance("fight_info")

		var_2_0:__play_ship_move(self._cur_config, (var_0_3.find_object_by_id_start_node_id(self._route_num_list[1], self._cur_config.start_node_id)))
		var_0_2:destroyInstance("ocean_box_unselected")
		var_2_0._control.mask.frame:SetActive(true)
		var_2_0._control.mask:SetActive(false)
	end

	function arg_1_0:__onClick_ocean_box_2()
		local var_3_0 = var_0_2:getInstance("fight_info")

		var_3_0:__play_ship_move(self._cur_config, (var_0_3.find_object_by_id_start_node_id(self._route_num_list[2], self._cur_config.start_node_id)))
		var_0_2:destroyInstance("ocean_box_unselected")
		var_3_0._control.mask.frame:SetActive(true)
		var_3_0._control.mask:SetActive(false)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
