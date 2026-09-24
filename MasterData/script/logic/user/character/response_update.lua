local var_0_0 = {}
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:ShipInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__character__action(iter_2_1.info, iter_2_1.action)
		end

		self:set_new_ship_info(arg_2_1.updates)

		local var_2_0 = var_0_3:getInstance("dormitory_game")

		if var_2_0 then
			var_2_0:add_love(true)
		end
	end

	function arg_1_0:__character__action(arg_3_1, arg_3_2)
		if arg_3_2 == var_0_2.update_modify then
			self:__character__update_character_info(arg_3_1)
		elseif arg_3_2 == var_0_2.update_add then
			self:__character__add_character_info(arg_3_1)
		elseif arg_3_2 == var_0_2.update_remove then
			self:__character__remove_character_info(arg_3_1)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
