local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = gamecore.BaseObject
local var_0_3 = gamecore.trigger_logic
local var_0_4 = gameconfig.skill_config
local var_0_5 = table.insert
local var_0_6 = gameenum.battle_type

lx.define_class("skill_logic", function(arg_1_0)
	function arg_1_0:get_owner()
		return self._owner
	end

	function arg_1_0.eventOnFrame(arg_3_0, arg_3_1, arg_3_2)
		return
	end

	function arg_1_0:__init(arg_4_1)
		self._owner = self._battle_obj_mgr:findObject(arg_4_1)

		local var_4_0 = var_0_4.find_object_by_skill_id(self._owner:get_skill())
		local var_4_1 = {}

		for iter_4_0, iter_4_1 in pairs(var_4_0.effect) do
			if self._owner:get_now_satge_skill() and self._owner:get_now_satge_skill()[iter_4_0] == true then
				var_0_5(var_4_1, #var_4_1 + 1, {
					type = var_4_0.effect[iter_4_0].type,
					stage = var_4_0.effect[iter_4_0].stage,
					condition = self:__get_total_list(var_4_0.effect[iter_4_0].condition),
					buff_target = self:__get_total_list(var_4_0.effect[iter_4_0].buff_target),
					effect = self:__get_total_list(var_4_0.effect[iter_4_0].effect),
					rate = var_4_0.effect[iter_4_0].rate,
					rate1 = var_4_0.effect[iter_4_0].rate1,
					atk_type = var_4_0.atk_type
				})
			end
		end

		if self._owner.copy_skill then
			for iter_4_2, iter_4_3 in pairs(self._owner.copy_skill) do
				if self._owner:get_now_satge_skill() and self._owner:get_now_satge_skill()[iter_4_2 + #var_4_0.effect] == true then
					var_0_5(var_4_1, #var_4_1 + 1, {
						type = self._owner.copy_skill[iter_4_2].type,
						stage = self._owner.copy_skill[iter_4_2].stage,
						condition = self:__get_total_list(self._owner.copy_skill[iter_4_2].condition),
						buff_target = self:__get_total_list(self._owner.copy_skill[iter_4_2].buff_target),
						effect = self:__get_total_list(self._owner.copy_skill[iter_4_2].effect),
						rate = self._owner.copy_skill[iter_4_2].rate,
						rate1 = self._owner.copy_skill[iter_4_2].rate1,
						atk_type = self._owner.copy_skill.atk_type
					})
				end
			end
		end

		local var_4_2 = {}

		for iter_4_4, iter_4_5 in pairs(var_4_1) do
			for iter_4_6, iter_4_7 in pairs(iter_4_5.effect or {}) do
				if type(iter_4_7) == "table" and iter_4_7.type == var_0_6.action_type.owner_attribute_change_buff_target_attr then
					local var_4_4 = var_0_6.skil_attribute_type[iter_4_7.attribute] and self._owner:get_attribute()[var_0_6.skil_attribute_type[iter_4_7.attribute]]

					if var_4_4 and var_4_2[var_0_6.skil_attribute_type[iter_4_7.attribute]] == nil then
						var_4_2[var_0_6.skil_attribute_type[iter_4_7.attribute]] = var_4_4:get_final_value()
					end
				end
			end
		end

		for iter_4_8, iter_4_9 in pairs(var_4_1) do
			local var_4_5 = var_0_3:create(self._owner)

			var_4_5:bind(self._battlefield)
			var_4_5:init({
				trigger_type = iter_4_9.stage,
				conditions = iter_4_9.condition,
				buff_target = iter_4_9.buff_target,
				actions = iter_4_9.effect,
				attr_snapshot = var_4_2,
				owner_id = arg_4_1,
				rate = iter_4_9.rate,
				rate1 = iter_4_9.rate1,
				atk_type = iter_4_9.atk_type
			})
		end
	end

	function arg_1_0.__get_total_list(arg_5_0, arg_5_1)
		local var_5_0 = {}

		if not arg_5_1 then
			return nil
		end

		for iter_5_0, iter_5_1 in pairs(arg_5_1) do
			var_0_5(var_5_0, iter_5_1)
		end

		return var_5_0
	end
end, "BaseObject")

function var_0_0.create(arg_6_0)
	local var_6_0 = var_0_1.class("skill_logic", var_0_2:inherit())

	var_6_0._owner = nil

	return var_6_0
end

return var_0_0
