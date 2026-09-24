local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gameconfig.workshop_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:WorkshopInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__workshop_info__action(iter_2_1)
		end
	end

	function arg_1_0:WorkshopScoreUpdate(arg_3_1)
		self._workshop_data.score = arg_3_1.info
	end

	function arg_1_0:__workshop_info__action(arg_4_1)
		if arg_4_1.action == var_0_1.update_modify then
			self:__workshop_info__update(arg_4_1)
		elseif arg_4_1.action == var_0_1.update_add then
			self:__workshop_info__add(arg_4_1)
		elseif arg_4_1.action == var_0_1.update_remove then
			self:__workshop_info__remove(arg_4_1)
		end
	end

	function arg_1_0.__init_constant(arg_5_0)
		local var_5_0 = {}
		local var_5_1 = {}
		local var_5_2, var_5_3 = var_0_2.get_sequence()

		for iter_5_0, iter_5_1 in pairs(var_5_2) do
			if var_5_1[iter_5_1.ship_type] == nil then
				var_5_1[iter_5_1.ship_type] = {}
			end

			if var_5_1[iter_5_1.ship_type][iter_5_1.base_id] == nil then
				var_5_1[iter_5_1.ship_type][iter_5_1.base_id] = {}
			end

			table.insert(var_5_1[iter_5_1.ship_type][iter_5_1.base_id], iter_5_1)
		end

		for iter_5_2, iter_5_3 in pairs(var_5_1) do
			if var_5_0[iter_5_2] == nil then
				var_5_0[iter_5_2] = {}
			end

			for iter_5_4, iter_5_5 in pairs(iter_5_3) do
				table.insert(var_5_0[iter_5_2], iter_5_5)
			end
		end

		arg_5_0._allShipTonTb = var_5_0
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
