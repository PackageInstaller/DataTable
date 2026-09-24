local var_0_0 = {}
local var_0_1 = gameconfig.equip_config
local var_0_2 = gameconfig.ship_config
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.item_config
local var_0_6 = math.floor

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__update_character_attribute(arg_2_1)
		local var_2_0 = var_0_2.find_object_by_cid(arg_2_1.cid)

		arg_2_1.hp = var_2_0.hp
		arg_2_1.atk = var_2_0.atk
		arg_2_1.def = var_2_0.def
		arg_2_1.miss = self:calculate_hit_or_miss(var_2_0.miss, var_2_0.miss_max, arg_2_1.level)
		arg_2_1.capacity = var_2_0.capacity
		arg_2_1.speed = var_2_0.speed
		arg_2_1.range = var_2_0.range
		arg_2_1.torpedo = var_2_0.torpedo
		arg_2_1.air_def = var_2_0.air_def
		arg_2_1.antisub = self:calculate_hit_or_miss(var_2_0.antisub, var_2_0.antisub_max, arg_2_1.level)
		arg_2_1.radar = self:calculate_hit_or_miss(var_2_0.radar, var_2_0.radar_max, arg_2_1.level)
		arg_2_1.hit = self:calculate_hit_or_miss(var_2_0.hit, var_2_0.hit_max, arg_2_1.level)
		arg_2_1.luck = arg_2_1.marry == true and var_2_0.luck + 5 or var_2_0.luck
		arg_2_1.air_def_correct = 0
		arg_2_1.aircraft_atk = 0
		arg_2_1.now_hp = arg_2_1.now_hp
		arg_2_1.now_oil = var_0_6(arg_2_1.now_oil * var_2_0.max_oil / 10)
		arg_2_1.now_bullet = var_0_6(arg_2_1.now_bullet * var_2_0.max_ammo / 10)
		arg_2_1.star = var_2_0.star
		arg_2_1.skills = var_2_0.skills
		arg_2_1.bullet = var_2_0.max_ammo
		arg_2_1.oil = var_2_0.max_oil
		arg_2_1.type = var_2_0.type
		self._character_attribute[arg_2_1.id] = {
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

		self:__calculate_attribute_effect_by_equips(arg_2_1.id)
	end

	function arg_1_0:__remove_character_attribute_by_id(arg_3_1)
		self._character_attribute[arg_3_1] = nil
	end

	function arg_1_0:__calculate_attribute_by_intensify(arg_4_1, arg_4_2)
		local var_4_0 = self:get_character_intensify(arg_4_1)
		local var_4_1 = self:find_character_by_id(arg_4_1)
		local var_4_2

		if var_4_1 then
			var_4_2 = var_0_2.find_object_by_cid(var_4_1.cid)
		else
			return
		end

		if var_4_0 then
			for iter_4_0, iter_4_1 in pairs(var_4_0) do
				arg_4_2[iter_4_1.attr] = iter_4_1.attr == "range" and iter_4_1.exp / var_4_2.strengthen_level_up_exp or arg_4_2[iter_4_1.attr] + iter_4_1.exp / var_4_2.strengthen_level_up_exp
			end
		end
	end

	function arg_1_0:__calculate_attribute_by_items(arg_5_1, arg_5_2)
		local var_5_0 = self:get_character_intensify(arg_5_1)

		for iter_5_0, iter_5_1 in pairs((self:get_player_desk_collection_data())) do
			local var_5_1 = var_0_5.find_object_by_cid(iter_5_1.id)

			for iter_5_2, iter_5_3 in pairs(var_5_1.buff_effect) do
				if iter_5_3.name == "attr" then
					arg_5_2[arg_5_1][string.lower(iter_5_3.value)] = arg_5_2[arg_5_1][string.lower(iter_5_3.value)] + var_5_1.buff_effect[2].value
				end
			end
		end
	end

	function arg_1_0:__calculate_attribute_by_equips(arg_6_1, arg_6_2)
		local var_6_0 = self:__character__find_by_id(arg_6_1)

		for iter_6_0, iter_6_1 in pairs((var_6_0 or nil) and (var_6_0.equips or {})) do
			local var_6_1 = var_0_1.find_object_by_cid(iter_6_1.id)

			if var_6_1 then
				for iter_6_2, iter_6_3 in pairs(var_0_4.equip_attribute) do
					if iter_6_3 == "range" then
						if var_6_1[iter_6_3] > arg_6_2[iter_6_3] then
							arg_6_2[iter_6_3] = var_6_1[iter_6_3] or arg_6_2[iter_6_3]
						end
					else
						arg_6_2[iter_6_3] = arg_6_2[iter_6_3] or 0
						arg_6_2[iter_6_3] = arg_6_2[iter_6_3] + var_6_1[iter_6_3]
					end
				end
			end
		end
	end

	function arg_1_0:__calculate_attribute_effect_by_equips(arg_7_1)
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(var_0_4.equip_attribute) do
			var_7_0[iter_7_1] = 0
		end

		self._attribute_effect_by_equip[arg_7_1] = var_7_0

		for iter_7_2, iter_7_3 in pairs(self:__character__find_by_id(arg_7_1).equips) do
			local var_7_1 = var_0_1.find_object_by_cid(iter_7_3.id)

			if var_7_1 then
				for iter_7_4, iter_7_5 in pairs(var_0_4.equip_attribute) do
					self._attribute_effect_by_equip[arg_7_1][iter_7_5] = iter_7_5 == "range" and (var_7_1[iter_7_5] > self._attribute_effect_by_equip[arg_7_1][iter_7_5] and 1 or 0) or self._attribute_effect_by_equip[arg_7_1][iter_7_5] + var_7_1[iter_7_5]
				end
			end
		end
	end

	function arg_1_0.calculate_hit_or_miss(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		return var_0_6(arg_8_1 + (arg_8_2 - arg_8_1) * arg_8_3 / 100)
	end
end

function var_0_0.extend_obj(arg_9_0)
	arg_9_0._character_attribute = {}
	arg_9_0._attribute_effect_by_equip = {}
end

return var_0_0
