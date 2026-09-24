local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_4 = gameconfig.equip_config
local var_0_5 = gameconfig.ship_config
local var_0_6 = gameconfig.item_config
local var_0_7 = string.lower
local var_0_8 = gamecore.condition_logic
local var_0_9 = gameconfig.skill_config
local var_0_10 = gamecore.battle_util
local var_0_11 = gameconfig.workshop_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_character_attribute()
		return self._attribute
	end

	function arg_1_0:__init_enemy_attribute(arg_3_1)
		local var_3_0 = self:get_ship_cfg()
		local var_3_1 = {}

		for iter_3_0, iter_3_1 in pairs(var_0_1.skil_attribute_type) do
			var_3_1[iter_3_1] = var_3_0[iter_3_1]
		end

		self._attrs = var_3_1

		if arg_3_1.marry then
			self._attrs.luck = self._attrs.luck or 0
			self._attrs.luck = self._attrs.luck + 5
		end

		self._attrs.normal_attack_atk_rate = 0
		self._attrs.aircraft_torpedo_plane_hit = 0
		self._attrs.normal_attack_hit = 0
		self._attrs.reduce_enemy_aircraft_hit = 0
		self._attrs.reduce_enemy_torpedo_plane_hit = 0
		self._attrs.torpedo_attack_hit = 0
		self._attrs.aircraft_attack_bomber = 1
		self._attrs.aircraft_attack_torpedo = 1
		self._attrs.reduce_enemy_missile_hit = 0
		self._attrs.ship_air_def = 0
		self._attrs.ship_atk = 0
		self._attrs.pre_torpedo = 0
		self._attrs.normal_attack = 1
		self._attrs.torpedo_attack = 1
		self._attrs.night_attack = 1
		self._attrs.missile_attack = 1
		self._attrs.antisub_attack = 1
		self._attrs.aircraft_attack = 1
		self._attrs.open_torpedo_power = 1
		self._attrs.open_missile_power = 1
		self._attrs.increase_all_power = 1
		self._attrs.decrease_all_power = 1
		self._attrs.decrease_aircraft_injured = 1
		self._attrs.decrease_antisub_injured = 1
		self._attrs.decrease_open_torpedo_injured = 1
		self._attrs.decrease_normal_injured = 1
		self._attrs.decrease_close_torpedo_injured = 1
		self._attrs.decrease_night_injured = 1
		self._attrs.decrease_open_missile_injured = 1
		self._attrs.ap = self._attrs.ap or 0
		self._attrs.crit_repair = 5
		self._attrs.hit_repair = 0
		self._attrs.miss_repair = 0

		self:__calculate_players_attrs_by_level()
		self:__calculate_ship_intensify_buff(arg_3_1.intensify)
		self:__calculate_enemy_collection_buff()
		self:__calculate_ship_skill_by_passive()
		self:__attribute_by_workshop(var_3_1)

		if self._attrs.antisub then
			self._attrs.ship_antisub = self._attrs.antisub
		end

		if self._attrs.atk then
			self._attrs.ship_atk = self._attrs.atk
		end

		if self._attrs.air_def then
			self._attrs.ship_air_def = self._attrs.air_def
		end

		if self._attrs.torpedo then
			self._attrs.pre_torpedo = self._attrs.torpedo
		end

		self:__calculate_ship_skill_by_passive_by_equips()
		self:__attribute_by_equips()

		self._attrs.now_hp = self._attrs.hp

		if arg_3_1.now_hp then
			self._attrs.now_hp = arg_3_1.now_hp
		end

		self._battlefield:append_result(self:get_cid(), "属性初始化", self._attrs)
		self:__add_special_attribute()

		local var_3_2 = self._battle_scene:get_buff_list()

		if var_3_2 then
			for iter_3_2, iter_3_3 in pairs(var_3_2) do
				iter_3_3:do_buff_logic(self, nil, "init_attr")
			end
		end

		local var_3_3 = self:get_attribute().hp:get_final_value()

		self:get_attribute().now_hp:modify_to_value((arg_3_1.now_hp or nil) and arg_3_1.now_hp)
	end

	function arg_1_0:__calculate_ship_skill_by_passive()
		local var_4_0 = var_0_9.find_object_by_skill_type_skill_level(self._skill_data.skill, self._skill_data.skill_level)

		if not var_4_0 then
			return
		end

		if not var_4_0.effect[1] then
			return
		end

		for iter_4_0, iter_4_1 in pairs(var_4_0.effect) do
			if iter_4_1.stage[1] == 1 then
				self:set_multiple_attr_value(1)

				if self:__get_conditioin_by_config_by_skill(iter_4_1, self:getID()) then
					for iter_4_2, iter_4_3 in pairs(iter_4_1.effect) do
						if iter_4_3.type == 3 or iter_4_3.type == 4 or iter_4_3.type == 5 or iter_4_3.type == 131 then
							self:__set_ower_attr_by_skill_type(iter_4_3)
						end

						if iter_4_3.type == 94 then
							self._attrs.range = iter_4_3.num
						end
					end
				end
			end
		end
	end

	function arg_1_0:__calculate_ship_skill_by_passive_by_equips()
		local var_5_0 = var_0_9.find_object_by_skill_type_skill_level(self._skill_data.skill, self._skill_data.skill_level)

		if not var_5_0 then
			return
		end

		if not var_5_0.effect[1] then
			return
		end

		for iter_5_0, iter_5_1 in pairs(var_5_0.effect) do
			if iter_5_1.stage[1] == 1 and self:__get_conditioin_by_config_by_skill(iter_5_1, self:getID()) then
				for iter_5_2, iter_5_3 in pairs(iter_5_1.effect) do
					if iter_5_3.type == 50 or iter_5_3.type == 51 or iter_5_3.type == 52 or iter_5_3.type == 54 or iter_5_3.type == 49 then
						self:__set_equip_attr_by_skill_type(iter_5_3)
					end
				end
			end
		end
	end

	function arg_1_0:__get_conditioin_by_config_by_skill(arg_6_1, arg_6_2)
		if not arg_6_1.condition then
			return true
		end

		local var_6_0 = false
		local var_6_1 = var_0_8:create()

		var_6_1:bind(self._battlefield)

		for iter_6_0, iter_6_1 in pairs(arg_6_1.condition) do
			var_6_1:init(iter_6_1, arg_6_2)

			local var_6_2 = var_6_1:onConditionFunc(iter_6_1)

			if var_6_2 then
				var_6_0 = var_6_2

				break
			end
		end

		return var_6_0
	end

	function arg_1_0:__set_ower_attr_by_skill_type(arg_7_1)
		local var_7_0
		local var_7_1 = {}
		local var_7_2 = self:get_multiple_attr_value() or 1

		for iter_7_0, iter_7_1 in pairs(self._equip_list) do
			local var_7_3 = var_0_4.find_object_by_cid(iter_7_1:get_equip_cid())

			for iter_7_2, iter_7_3 in pairs(var_0_1.equip_attribute_type) do
				if iter_7_3 == "range" then
					var_7_1[iter_7_3] = var_7_1[iter_7_3] or 0

					if var_7_3[iter_7_3] > var_7_1[iter_7_3] then
						var_7_1[iter_7_3] = var_7_3[iter_7_3] or var_7_1[iter_7_3]
					end
				else
					var_7_1[iter_7_3] = var_7_1[iter_7_3] or 0

					local var_7_4 = iter_7_1:get_equip_attribute(iter_7_3)

					if var_7_4 then
						var_7_1[iter_7_3] = var_7_1[iter_7_3] + var_7_4
					end
				end
			end
		end

		for iter_7_4, iter_7_5 in pairs(arg_7_1) do
			for iter_7_6, iter_7_7 in pairs(var_0_1.skil_attribute_type) do
				if iter_7_4 == iter_7_7 then
					var_7_0 = iter_7_4

					break
				end
			end
		end

		if arg_7_1.type == 3 then
			if var_7_0 == "range" and var_7_1[var_7_0] then
				self._attrs[var_7_0] = math.max(var_7_1[var_7_0], self._attrs[var_7_0])
			end

			self._attrs[var_7_0] = self._attrs[var_7_0] + nil * var_7_2

			self._battlefield:append_result(self._cid, "技能被动（请查看“技能效果”子表中的type）", (string.format("属性名:%s,修改前的值:%1.f,修改后的值:%1.f", var_7_0, self._attrs[var_7_0], self._attrs[var_7_0])))
		elseif arg_7_1.type == 4 then
			self.skill_type_4 = self.skill_type_4 or {}

			local var_7_6 = lx.clone_table(arg_7_1)

			var_7_6.multiple = var_7_2

			table.insert(self.skill_type_4, var_7_6)
		elseif arg_7_1.type == 5 then
			self.skill_type_5 = self.skill_type_5 or {}

			local var_7_7 = lx.clone_table(arg_7_1)

			var_7_7.multiple = var_7_2

			table.insert(self.skill_type_5, var_7_7)
		elseif arg_7_1.type == 131 then
			if self._attrs[var_0_1.skil_attribute_type[arg_7_1.attribute]] then
				var_7_1[var_0_1.skil_attribute_type[arg_7_1.attribute]] = var_7_1[var_0_1.skil_attribute_type[arg_7_1.attribute]] or 0
				var_7_1.speed = var_7_1.speed or 0
				self._attrs[var_0_1.skil_attribute_type[arg_7_1.attribute]] = var_0_10:attr_impact_by_speed(self._attrs.speed + var_7_1.speed, self._attrs[var_0_1.skil_attribute_type[arg_7_1.attribute]] + var_7_1[var_0_1.skil_attribute_type[arg_7_1.attribute]], arg_7_1.num1, arg_7_1.num2) - var_7_1[var_0_1.skil_attribute_type[arg_7_1.attribute]]
			end
		end
	end

	function arg_1_0:__set_equip_attr_by_skill_type(arg_8_1)
		local var_8_2
		local var_8_3

		if not self._equip_list then
			return
		end

		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			for iter_8_2, iter_8_3 in pairs(var_0_1.equip_attribute_type) do
				if iter_8_0 == iter_8_3 then
					var_8_2 = iter_8_0
					var_8_3 = iter_8_1

					break
				end
			end
		end

		for iter_8_4, iter_8_5 in pairs(self._equip_list) do
			if arg_8_1.equipment_type then
				for iter_8_6, iter_8_7 in pairs(arg_8_1.equipment_type) do
					if iter_8_5:get_equip_bore_type() == iter_8_7 then
						if arg_8_1.type == 51 then
							iter_8_5:add_equip_attribute(var_8_2, var_8_3)
							self._battlefield:append_result(self._cid, "触发武器相关技能被动51")
						end

						if arg_8_1.type == 52 then
							iter_8_5:add_equip_attribute(var_8_2, iter_8_5:get_equip_attribute(var_8_2) * var_8_3)
							self._battlefield:append_result(self._cid, "触发武器相关技能被动52")
						end

						if arg_8_1.type == 54 then
							local var_8_5 = var_0_1.equip_bore_type.anti_submarine_equipment

							if iter_8_7 == var_0_1.equip_bore_type.anti_submarine_equipment then
								var_8_5 = var_0_1.equip_bore_type.air_defense_machine_gun
							end

							local var_8_6 = iter_8_5:get_equip_attribute(var_0_1.skil_attribute_type[arg_8_1.attribute])

							iter_8_5:set_equip_second_type(var_8_5)
							iter_8_5:add_equip_attribute(var_0_1.skil_attribute_type[arg_8_1.attribute2], arg_8_1.rate * var_8_6)
							self._battlefield:append_result(self._cid, "触发武器相关技能被动54")
						end
					end
				end
			end

			if arg_8_1.type == 50 then
				local var_8_7 = iter_8_5:get_equip_attribute(var_0_1.skil_attribute_type[arg_8_1.attribute2])

				iter_8_5:add_equip_attribute(var_0_1.skil_attribute_type[arg_8_1.attribute2], iter_8_5:get_equip_attribute(var_0_1.skil_attribute_type[arg_8_1.attribute]) * arg_8_1.rate)
				self._battlefield:append_result(self._cid, "触发武器相关技能被动50")
			end

			if arg_8_1.type == 49 then
				for iter_8_8, iter_8_9 in pairs((iter_8_5:get_equip_attrs())) do
					if iter_8_8 ~= "range" and iter_8_8 ~= "hp" then
						iter_8_5:add_equip_attribute(iter_8_8, arg_8_1.rate * iter_8_9)
						self._battlefield:append_result(self._cid, "触发武器相关技能被动49" .. iter_8_8 .. "增加了" .. arg_8_1.rate * iter_8_9)
					end
				end
			end
		end
	end

	function arg_1_0:__attribute_by_equips()
		if not self._equip_list then
			return
		end

		local var_9_0 = 0
		local var_9_1 = 0

		for iter_9_0, iter_9_1 in pairs(self._equip_list) do
			local var_9_2 = var_0_4.find_object_by_cid(iter_9_1:get_equip_cid())
			local var_9_3 = var_9_2.special_effect

			for iter_9_2, iter_9_3 in pairs(var_9_2.effect) do
				if var_9_3 == var_0_1.equip_special_effect_type.ap and self._attrs[iter_9_3.name] then
					if iter_9_3.value > self._attrs[iter_9_3.name] then
						self._attrs[iter_9_3.name] = iter_9_3.value or self._attrs[iter_9_3.name]
					end
				end

				if var_9_3 == var_0_1.equip_special_effect_type.normal_attack_atk_rate then
					self._attrs.normal_attack_atk_rate = self._attrs.normal_attack_atk_rate or 0

					if iter_9_3.value > self._attrs.normal_attack_atk_rate then
						self._attrs.normal_attack_atk_rate = iter_9_3.value or self._attrs.normal_attack_atk_rate
					end
				end

				if var_9_3 == var_0_1.equip_special_effect_type.torpedo_plane_hit then
					if iter_9_3.name == "num1" then
						self._attrs.aircraft_torpedo_plane_hit = self._attrs.aircraft_torpedo_plane_hit + iter_9_3.value / 100
					end

					if iter_9_3.name == "num2" then
						self._attrs.normal_attack_hit = self._attrs.normal_attack_hit + iter_9_3.value / 100
					end
				end

				if var_9_3 == var_0_1.equip_special_effect_type.reduce_enemy_aircraft_hit then
					self._attrs.reduce_enemy_aircraft_hit = self._attrs.reduce_enemy_aircraft_hit + iter_9_3.value / 100
				end

				if var_9_3 == var_0_1.equip_special_effect_type.reduce_enemy_torpedo_plane_hit then
					self._attrs.reduce_enemy_torpedo_plane_hit = self._attrs.reduce_enemy_torpedo_plane_hit + iter_9_3.value / 100
				end

				if var_9_3 == var_0_1.equip_special_effect_type.torpedo_attack_hit then
					self._attrs.torpedo_attack_hit = self._attrs.torpedo_attack_hit + iter_9_3.value / 100
				end

				if var_9_3 == var_0_1.equip_special_effect_type.aircraft_normal_hit or var_9_3 == var_0_1.equip_special_effect_type.aircraft_attack_bomber then
					if iter_9_3.name == "boom" then
						self._attrs.aircraft_attack_bomber = self._attrs.aircraft_attack_bomber + iter_9_3.value
					end

					if iter_9_3.name == "num" then
						self._attrs.aircraft_attack_bomber = self._attrs.aircraft_attack_bomber * (1 + iter_9_3.value)
					end

					if iter_9_3.name == "hit" then
						self._attrs.normal_attack_hit = self._attrs.normal_attack_hit + iter_9_3.value / 100
					end
				end

				if var_9_3 == var_0_1.equip_special_effect_type.aircraft_attack_torpedo and iter_9_3.name == "num" then
					self._attrs.aircraft_attack_torpedo = self._attrs.aircraft_attack_torpedo * (1 + iter_9_3.value)
				end

				if var_9_3 == var_0_1.equip_special_effect_type.reduce_enemy_missile_hit then
					self._attrs.reduce_enemy_missile_hit = self._attrs.reduce_enemy_missile_hit + iter_9_3.value / 100
				end
			end

			for iter_9_4, iter_9_5 in pairs(var_0_1.equip_attribute_type) do
				if iter_9_5 == "range" then
					if var_9_2[iter_9_5] > self._attrs[iter_9_5] then
						self._attrs[iter_9_5] = var_9_2[iter_9_5] or self._attrs[iter_9_5]
					end
				else
					self._attrs[iter_9_5] = self._attrs[iter_9_5] or 0

					if iter_9_1:get_equip_attribute(iter_9_5) then
						self._attrs[iter_9_5] = self._attrs[iter_9_5] + iter_9_1:get_equip_attribute(iter_9_5)
					end
				end
			end

			if next(var_9_2.exclusive_cid) and next(var_9_2.exclusive_buff) then
				for iter_9_6, iter_9_7 in pairs(var_9_2.exclusive_cid) do
					if iter_9_7 == self:get_cid() then
						for iter_9_8, iter_9_9 in pairs(var_9_2.exclusive_buff) do
							if iter_9_9.type == 1 then
								for iter_9_10, iter_9_11 in pairs(var_0_1.skil_attribute_type) do
									if iter_9_10 == iter_9_9.num4 and self._attrs[iter_9_11] then
										self._attrs[iter_9_11] = self._attrs[iter_9_11] + iter_9_9.num
									end
								end
							elseif iter_9_9.type == 2 then
								for iter_9_12, iter_9_13 in pairs(var_0_1.skil_attribute_type) do
									if iter_9_12 == iter_9_9.num4 and self._attrs[iter_9_13] then
										self._attrs[iter_9_13] = iter_9_13 == "crit_repair" and self._attrs[iter_9_13] + iter_9_9.num or math.ceil(self._attrs[iter_9_13] * (1 + iter_9_9.num / 100))
									end
								end
							elseif iter_9_9.type == 5 then
								if self._attrs.ap then
									var_9_0 = var_9_0 + iter_9_9.num / 100
								end
							elseif iter_9_9.type == 10 and self._attrs.ap then
								var_9_1 = math.max(var_9_1, iter_9_9.num)
							end
						end
					end
				end
			elseif not next(var_9_2.exclusive_cid) and next(var_9_2.exclusive_buff) then
				for iter_9_14, iter_9_15 in pairs(var_9_2.exclusive_buff) do
					if iter_9_15.type == 1 then
						for iter_9_16, iter_9_17 in pairs(var_0_1.skil_attribute_type) do
							if iter_9_16 == iter_9_15.num4 and self._attrs[iter_9_17] then
								self._attrs[iter_9_17] = self._attrs[iter_9_17] + iter_9_15.num
							end
						end
					elseif iter_9_15.type == 2 then
						for iter_9_18, iter_9_19 in pairs(var_0_1.skil_attribute_type) do
							if iter_9_18 == iter_9_15.num4 and self._attrs[iter_9_19] then
								self._attrs[iter_9_19] = iter_9_19 == "crit_repair" and self._attrs[iter_9_19] + iter_9_15.num or math.ceil(self._attrs[iter_9_19] * (1 + iter_9_15.num / 100))
							end
						end
					elseif iter_9_15.type == 5 then
						if self._attrs.ap then
							var_9_0 = var_9_0 + iter_9_15.num / 100
						end
					elseif iter_9_15.type == 10 and self._attrs.ap then
						var_9_1 = math.max(var_9_1, iter_9_15.num)
					end
				end
			end
		end

		if self._attrs.ap then
			self._attrs.ap = math.max(self._attrs.ap, var_9_1) + var_9_0
		end
	end

	function arg_1_0:__add_special_attribute()
		for iter_10_0, iter_10_1 in pairs(self._attrs) do
			local var_10_0 = gamecore.attribute_item:create(iter_10_1)

			var_10_0:__init_value()

			self._attribute[iter_10_0] = var_10_0
		end

		local var_10_1 = 0
		local var_10_2 = 0
		local var_10_3 = 0
		local var_10_4 = 0

		for iter_10_2, iter_10_3 in pairs(self._equip_list) do
			local var_10_5 = var_0_4.find_object_by_cid((iter_10_3:get_equip_cid()))

			var_10_4 = var_10_4 + var_10_5.air_def * var_10_5.air_def_rate

			if iter_10_3:get_equip_type() == var_0_1.equip_type.anti_sub then
				var_10_1 = var_10_1 + var_10_5.antisub
			else
				var_10_2 = var_10_2 + var_10_5.antisub
			end

			var_10_3 = var_10_3 + var_10_5.antisub
		end

		local var_10_6 = gamecore.attribute_item:create(var_10_1)

		var_10_6:__init_value()

		self._attribute.antisub_equips = var_10_6

		local var_10_7 = gamecore.attribute_item:create(var_10_2)

		var_10_7:__init_value()

		self._attribute.other_antisub = var_10_7

		local var_10_8 = gamecore.attribute_item:create(var_10_3)

		var_10_8:__init_value()

		self._attribute.antisub_all_equip = var_10_8

		local var_10_9 = gamecore.attribute_item:create(var_10_3)

		var_10_9:__init_value()

		self._attribute.all_equip_airdef = var_10_9
	end

	function arg_1_0:__calculate_ship_intensify_buff(arg_11_1)
		if not arg_11_1 then
			return
		end

		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			for iter_11_2, iter_11_3 in pairs(self._attrs) do
				if iter_11_2 == iter_11_1.attr then
					self._attrs[iter_11_2] = self._attrs[iter_11_2] + iter_11_1.level
				end
			end
		end
	end

	function arg_1_0:__attribute_by_workshop(arg_12_1)
		local var_12_0 = self._battle_scene:get_enemy_workshop_cfg()

		if not var_12_0 then
			return
		end

		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			local var_12_1 = var_0_11.find_object_by_id(iter_12_1).effect[1]

			if var_12_1.shipTypes and var_12_1.shipTypes[1] == self:get_ship_type() then
				if var_12_1.type == var_0_1.work_type.add_attribute then
					if var_12_1.countrys then
						for iter_12_2, iter_12_3 in pairs(var_12_1.countrys) do
							if iter_12_3 == self:get_country() then
								self._attrs[var_0_1.skil_attribute_type[var_12_1.num4]] = self._attrs[var_0_1.skil_attribute_type[var_12_1.num4]] + var_12_1.num

								self._battlefield:append_result(self._cid, "工坊buff", (string.format("工坊buff增加属性名:%s, 修改前的值:%f, 修改后的值:%f", var_0_1.skil_attribute_type[var_12_1.num4], self._attrs[var_0_1.skil_attribute_type[var_12_1.num4]], self._attrs[var_0_1.skil_attribute_type[var_12_1.num4]])))
							end
						end
					end
				elseif var_12_1.type == var_0_1.work_type.add_torpedo_damage then
					if self._attrs[var_0_1.skil_attribute_type[var_12_1.num4]] ~= 0 then
						self._attrs[var_0_1.skil_attribute_type[var_12_1.num4]] = self._attrs[var_0_1.skil_attribute_type[var_12_1.num4]] + var_12_1.num
					end

					self._battlefield:append_result(self._cid, "工坊buff，前后都为0说明该船只无法拥有该buff", (string.format("工坊buff增加属性名:%s, 修改前的值:%f, 修改后的值:%f", var_0_1.skil_attribute_type[var_12_1.num4], self._attrs[var_0_1.skil_attribute_type[var_12_1.num4]], self._attrs[var_0_1.skil_attribute_type[var_12_1.num4]])))
				elseif var_12_1.type == var_0_1.work_type.add_shelling_damage then
					-- block empty
				end
			end
		end
	end

	function arg_1_0:__calculate_enemy_collection_buff()
		local var_13_0 = self._battle_scene:get_enemy_collectionbuff()

		if not var_13_0 then
			return
		end

		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			local var_13_1 = var_0_6.find_object_by_cid(iter_13_1)

			if var_13_1 then
				local var_13_2 = var_0_7(var_13_1.buff_effect.attr)

				if (var_13_1.buff_effect.ship_type == 0 or var_13_1.buff_effect.ship_type == self._ship_type) and (var_13_1.buff_effect.country == 0 or var_13_1.buff_effect.country == self._country) then
					self._attrs[var_13_2] = self._attrs[var_13_2] + var_13_1.buff_effect.val

					self._battlefield:append_result(self._cid, "收藏品信息", (string.format("收藏品名字:%s, 修改前的值:%f, 修改后的值:%f", var_13_1.title, self._attrs[var_13_2], self._attrs[var_13_2])))
				end
			end
		end
	end

	function arg_1_0:__calculate_players_attrs_by_level()
		if self._monster_type ~= var_0_1.enemy_type.player then
			return
		end

		local var_14_0 = var_0_5.find_object_by_cid(self._cid)

		if not var_14_0 then
			return
		end

		self._attrs.hit = var_0_10:calculate_some_attr_by_level(var_14_0.hit, var_14_0.hit_max, var_14_0.hit_max2, self._level)
		self._attrs.miss = var_0_10:calculate_some_attr_by_level(var_14_0.miss, var_14_0.miss_max, var_14_0.miss_max2, self._level)
		self._attrs.antisub = var_0_10:calculate_some_attr_by_level(var_14_0.antisub, var_14_0.antisub_max, var_14_0.antisub_max2, self._level)
		self._attrs.radar = var_0_10:calculate_some_attr_by_level(var_14_0.radar, var_14_0.radar_max, var_14_0.radar_max2, self._level)
	end
end

function var_0_0.extend_obj(arg_15_0)
	arg_15_0._attribute = {}
end

return var_0_0
