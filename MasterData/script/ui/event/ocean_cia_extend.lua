local var_0_0 = {}
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.util_func
local var_0_7 = gameconfig.pve_ocean_cia_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:check_ocean_buff_limit(arg_2_1, arg_2_2, arg_2_3)
		for iter_2_0, iter_2_1 in pairs(arg_2_2) do
			local var_2_0 = {}

			for iter_2_2, iter_2_3 in pairs(arg_2_3) do
				local var_2_1 = var_0_7.find_object_by_id(iter_2_3.id)

				if var_2_1.effect.type == iter_2_1.unlock_type then
					var_2_0[iter_2_2] = var_2_1.effect
				end
			end

			if not self:__check_one_ocean_buff_limit(arg_2_1, iter_2_1.effect.type, iter_2_1.effect, var_2_0) then
				return false
			end
		end

		return true
	end

	function arg_1_0.__check_one_ocean_buff_limit(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		if arg_3_2 == var_0_3.ocean_debuff_effect_type.type_105 then
			local var_3_1 = true
			local var_3_2 = arg_3_1.config.type
			local var_3_3 = arg_3_1.config.country

			var_3_1 = (not arg_3_3.shipTypes or not arg_3_3.countrys or var_0_4.have_data(arg_3_3.shipTypes, var_3_2) and var_0_4.have_data(arg_3_3.countrys, var_3_3) and false) and (not arg_3_3.shipTypes or var_0_4.have_data(arg_3_3.shipTypes, var_3_2) and false) and arg_3_3.countrys and var_0_4.have_data(arg_3_3.countrys, var_3_3) and false

			if not var_3_1 and arg_3_4 then
				for iter_3_0, iter_3_1 in ipairs(arg_3_4) do
					if iter_3_1.shipType and iter_3_1.country then
						if var_3_2 == iter_3_1.shipType and var_3_3 == iter_3_1.country then
							var_3_1 = true

							break
						end
					elseif iter_3_1.shipType and var_3_2 == iter_3_1.shipType then
						var_3_1 = true

						break
					elseif iter_3_1.country and var_3_3 == iter_3_1.country then
						var_3_1 = true

						break
					end
				end
			end

			return var_3_1
		elseif arg_3_2 == var_0_3.ocean_debuff_effect_type.type_106 then
			local var_3_4 = not (arg_3_3.shipType and arg_3_1.config.type == arg_3_3.shipType and arg_3_3.num == 0)

			if not var_3_4 and arg_3_4 then
				for iter_3_2, iter_3_3 in ipairs(arg_3_4) do
					if iter_3_3.shipType == arg_3_3.shipType and iter_3_3.num > 0 then
						var_3_4 = true

						break
					end
				end
			end

			return var_3_4
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
