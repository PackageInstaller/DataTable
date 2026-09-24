local var_0_0 = {}
local var_0_1 = gameconfig.equip_config
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__update_abyss_character_attribute(arg_2_1)
		self._abyss_character_attribute_by_calculate[arg_2_1.id] = nil
		self._abyss_character_attribute_by_calculate_no_equips[arg_2_1.id] = nil
		self._abyss_character_attribute[arg_2_1.id] = {
			air_def_correct = 0,
			aircraft_atk = 0,
			id = arg_2_1.id,
			hp = arg_2_1.hp,
			atk = arg_2_1.atk,
			def = arg_2_1.def,
			miss = arg_2_1.miss,
			capacity = arg_2_1.capacity,
			speed = arg_2_1.speed,
			range = arg_2_1.range,
			torpedo = arg_2_1.torpedo,
			air_def = arg_2_1.air_def,
			antisub = arg_2_1.antisub,
			radar = arg_2_1.radar,
			hit = arg_2_1.hit,
			luck = arg_2_1.luck,
			now_hp = arg_2_1.now_hp,
			now_oil = arg_2_1.now_oil,
			now_bullet = arg_2_1.now_bullet
		}

		self:__calculate_abyss_attribute_effect_by_equips(arg_2_1.id)
	end

	function arg_1_0:__remove_abyss_character_attribute_by_id(arg_3_1)
		self._abyss_character_attribute_by_calculate[arg_3_1] = nil
		self._abyss_character_attribute_by_calculate_no_equips[arg_3_1] = nil
		self._abyss_character_attribute[arg_3_1] = nil
	end

	function arg_1_0:__calculate_abyss_attribute_by_intensify(arg_4_1, arg_4_2)
		local var_4_0 = self:get_abyss_character_intensify(arg_4_1)

		if var_4_0 then
			for iter_4_0, iter_4_1 in pairs(var_4_0) do
				arg_4_2[arg_4_1][iter_4_1.attr] = iter_4_1.attr == "range" and iter_4_1.level or arg_4_2[arg_4_1][iter_4_1.attr] + iter_4_1.level
			end
		end
	end

	function arg_1_0:__calculate_abyss_attribute_by_equips(arg_5_1, arg_5_2)
		local var_5_0 = self:find_abyss_character_by_id(arg_5_1)

		for iter_5_0, iter_5_1 in pairs((var_5_0 or nil) and (var_5_0.equips or {})) do
			local var_5_1 = var_0_1.find_object_by_cid(iter_5_1.id)

			if var_5_1 then
				for iter_5_2, iter_5_3 in pairs(var_0_3.equip_attribute) do
					if iter_5_3 == "range" then
						if var_5_1[iter_5_3] > arg_5_2[arg_5_1][iter_5_3] then
							arg_5_2[arg_5_1][iter_5_3] = var_5_1[iter_5_3] or arg_5_2[arg_5_1][iter_5_3]
						end
					else
						arg_5_2[arg_5_1][iter_5_3] = arg_5_2[arg_5_1][iter_5_3] or 0
						arg_5_2[arg_5_1][iter_5_3] = arg_5_2[arg_5_1][iter_5_3] + var_5_1[iter_5_3]
					end
				end
			end
		end
	end

	function arg_1_0:__calculate_abyss_attribute_effect_by_equips(arg_6_1)
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(var_0_3.equip_attribute) do
			var_6_0[iter_6_1] = 0
		end

		self._abyss_attribute_effect_by_equip[arg_6_1] = var_6_0

		for iter_6_2, iter_6_3 in pairs(self:find_abyss_character_by_id(arg_6_1).equips) do
			local var_6_1 = var_0_1.find_object_by_cid(iter_6_3.id)

			if var_6_1 then
				for iter_6_4, iter_6_5 in pairs(var_0_3.equip_attribute) do
					self._abyss_attribute_effect_by_equip[arg_6_1][iter_6_5] = iter_6_5 == "range" and (var_6_1[iter_6_5] > self._abyss_attribute_effect_by_equip[arg_6_1][iter_6_5] and 1 or 0) or self._abyss_attribute_effect_by_equip[arg_6_1][iter_6_5] + var_6_1[iter_6_5]
				end
			end
		end
	end
end

function var_0_0.extend_obj(arg_7_0)
	arg_7_0._abyss_character_attribute = {}
	arg_7_0._abyss_character_attribute_by_calculate = {}
	arg_7_0._abyss_character_attribute_by_calculate_no_equips = {}
	arg_7_0._abyss_attribute_effect_by_equip = {}
end

return var_0_0
