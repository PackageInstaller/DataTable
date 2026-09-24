local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = gameconfig.support_atk_config
local var_0_4 = gamecore.damage_info

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:enter_support_attack_step()
		if self._support_id ~= 0 then
			return true
		end

		return false
	end

	function arg_1_0:support_attack()
		if not self._support_id then
			return
		end

		local var_3_0 = var_0_2.find_object_by_id(self._support_id)
		local var_3_1 = {
			type = var_3_0.type,
			info = {}
		}

		for iter_3_0, iter_3_1 in pairs((self._battle_obj_mgr:get_sea_ships_by_side(var_0_1.obj_side.enemy))) do
			local var_3_2 = var_0_4:create()

			var_3_2:bind(self._battlefield)
			var_3_2:set_support_power(var_3_0.num_min, var_3_0.num_max)
			var_3_2:init({
				type = "support_attack",
				target_id = iter_3_1:getID()
			})

			local var_3_3 = self._battle_obj_mgr:get_flag_ship(var_0_1.obj_side.player)
			local var_3_4 = {
				owner_id = var_3_3:getID()
			}
			local var_3_5 = {}
			local var_3_6

			if var_3_0.type == var_0_1.support_attack_type.bombs_attack then
				for iter_3_2 = 1, self._battle_random:randRange(1, 4) do
					var_3_5[iter_3_2] = self._battle_obj_mgr:createObject(gamecore.bomb_logic, var_3_4):getID()
				end
			end

			if var_3_0.type == var_0_1.support_attack_type.water_attack then
				var_3_6 = self._battle_obj_mgr:createObject(gamecore.torpedo_logic, var_3_4)
			end

			local var_3_7 = var_3_1.info
			local var_3_8 = {
				target_id = iter_3_1:getID(),
				damage_info = var_3_2:get_damageattr()
			}

			var_3_8.torpedo_id = var_3_6 and var_3_6:getID() or 0
			var_3_8.bomb_id = var_3_5
			var_3_8.target_now_hp = iter_3_1:get_attribute().now_hp:get_final_value()
			var_3_7[iter_3_0] = var_3_8

			self._battlefield:append_result("支援攻击", "支援攻击详情", {
				name = "支援攻击",
				target_cid = iter_3_1:get_cid(),
				damage_record = var_3_2:get_damage_record()
			})
		end

		self._battlefield._battle_report.support_attack = var_3_1
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
