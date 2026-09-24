return {
	extend_method = function(arg_1_0)
		function arg_1_0:get_unlock_ship_info()
			return self._unlock_ship
		end

		function arg_1_0:get_equip_task_info()
			return self._equip_task
		end

		function arg_1_0:get_unlock_equips_info()
			return self._unlock_equips
		end

		function arg_1_0:get_ship_task_info()
			return self._ship_task
		end

		function arg_1_0.set_need_research_ship_task_info(arg_6_0, arg_6_1)
			arg_6_0._research_ship_task = arg_6_1
		end

		function arg_1_0:get_need_research_ship_task_info()
			return self._research_ship_task
		end

		function arg_1_0.set_research_ship_select_ship_num(arg_8_0, arg_8_1)
			arg_8_0._research_ship_select_ship_num = arg_8_1
		end

		function arg_1_0:get_research_ship_select_ship_num()
			return self._research_ship_select_ship_num
		end

		function arg_1_0.set_research_equip_id(arg_10_0, arg_10_1)
			arg_10_0.research_equip_id = arg_10_1
		end

		function arg_1_0:get_research_equip_id()
			return self.research_equip_id
		end

		function arg_1_0.set_research_ship_id(arg_12_0, arg_12_1)
			arg_12_0.research_ship_id = arg_12_1
		end

		function arg_1_0:get_research_ship_id()
			return self.research_ship_id
		end

		function arg_1_0.set_research_equip_stage(arg_14_0, arg_14_1)
			arg_14_0._research_equip_stage = arg_14_1
		end

		function arg_1_0:get_research_equip_stage()
			return self._research_equip_stage
		end

		function arg_1_0.set_now_research_ship_id(arg_16_0, arg_16_1)
			arg_16_0.now_research_ship_id = arg_16_1
		end

		function arg_1_0:get_now_research_ship_id()
			return self.now_research_ship_id
		end

		function arg_1_0.set_come_in(arg_18_0, arg_18_1)
			arg_18_0.__come_in = arg_18_1
		end

		function arg_1_0:get_come_in()
			return self.__come_in
		end

		function arg_1_0.set_come_research_development_panel_id(arg_20_0, arg_20_1)
			arg_20_0._come_research_development_panel_id = arg_20_1
		end

		function arg_1_0:get_come_research_development_panel_id()
			return self._come_research_development_panel_id
		end

		function arg_1_0.set_come_in_nums(arg_22_0, arg_22_1)
			arg_22_0._come_in_num = arg_22_1
		end

		function arg_1_0:get_come_in_nums(arg_23_1)
			return self._come_in_num
		end

		function arg_1_0:get_init_ship_research_id()
			return self._init_ship_research_id
		end
	end,
	extend_obj = function(arg_25_0)
		arg_25_0._equip_task = {}
		arg_25_0._unlock_ship = {}
		arg_25_0._ship_task = {}
		arg_25_0._unlock_equips = {}
		arg_25_0._research_ship_task = {}
		arg_25_0.research_ship_id = 0
		arg_25_0._research_ship_select_ship_num = 0
		arg_25_0._init_select_member_panel = 0
		arg_25_0.now_research_ship_id = nil
		arg_25_0.__come_in = false
		arg_25_0._come_research_development_panel_id = nil
		arg_25_0._come_in_num = 2
		arg_25_0._init_ship_research_id = 0
		arg_25_0._research_equip_stage = 0
	end
}
