local var_0_0 = {}
local var_0_1 = math
local var_0_2 = gameconfig.equip_config
local var_0_3 = gameconfig.cook_book_config
local var_0_4 = gameconfig.item_config
local var_0_5 = gameconfig.skill_config
local var_0_6 = gameenum.battle_type
local var_0_7 = string.lower
local var_0_8 = gamecore.attribute_item
local var_0_9 = gamecore.condition_logic
local var_0_10 = gamecore.battle_util
local var_0_11 = gameconfig.furniture_config
local var_0_12 = gameconfig.workshop_config
local var_0_13 = gameconfig.joy_buff_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_character_attribute()
		return self._attribute
	end

	function arg_1_0:__init_player_attribute(arg_3_1, arg_3_2, arg_3_3)
		if arg_3_3 then
			arg_3_1.luck = arg_3_1.luck + 5
		end

		self._attrs = arg_3_1
		self._attrs.crit_repair = 5
		self._attrs.hit_repair = 0
		self._attrs.miss_repair = 0
		self._attrs.ap = self._attrs.ap or 0
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

		self:__attribute_by_cookbuff()
		self:__attribute_by_racingbuff(arg_3_1)
		self:__calculate_ship_intensify_buff(arg_3_2)
		self:__calculate_ship_collection_buff()
		self:__calculate_ship_skill_by_passive()
		self:__attribute_by_workshop(arg_3_1)

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

		self:__calculate_ship_skill_by_passive_by_equips(arg_3_2)
		self:__attribute_by_equips()
		self:__abyss_power_buff()
		self._battlefield:append_result(self:get_cid(), "属性初始化", self._attrs)
		self:__add_special_attribute()

		local var_3_0 = self._battle_scene:get_buff_list()

		if var_3_0 then
			for iter_3_0, iter_3_1 in pairs(var_3_0) do
				iter_3_1:do_buff_logic(self, nil, "init_attr")
			end
		end
	end

	function arg_1_0:__add_special_attribute()
		for iter_4_0, iter_4_1 in pairs(self._attrs) do
			local var_4_0 = var_0_8:create(iter_4_1)

			var_4_0:__init_value()

			self._attribute[iter_4_0] = var_4_0
		end

		local var_4_1 = 0
		local var_4_2 = 0
		local var_4_3 = 0
		local var_4_4 = 0

		for iter_4_2, iter_4_3 in pairs(self._equip_list) do
			local var_4_5 = var_0_2.find_object_by_cid((iter_4_3:get_equip_cid()))

			var_4_4 = var_4_4 + var_4_5.air_def * var_4_5.air_def_rate

			if iter_4_3:get_equip_type() == var_0_6.equip_type.anti_sub then
				var_4_1 = var_4_1 + var_4_5.antisub
			else
				var_4_2 = var_4_2 + var_4_5.antisub
			end

			var_4_3 = var_4_3 + var_4_5.antisub
		end

		local var_4_6 = var_0_8:create(var_4_1)

		var_4_6:__init_value()

		self._attribute.antisub_equips = var_4_6

		local var_4_7 = var_0_8:create(var_4_2)

		var_4_7:__init_value()

		self._attribute.other_antisub = var_4_7

		local var_4_8 = var_0_8:create(var_4_3)

		var_4_8:__init_value()

		self._attribute.antisub_all_equip = var_4_8

		local var_4_9 = var_0_8:create(var_4_4)

		var_4_9:__init_value()

		self._attribute.all_equip_airdef = var_4_9
	end

	function arg_1_0:__attribute_by_equips()
		if not self._equip_list then
			return
		end

		local var_5_0 = 0
		local var_5_1 = 0

		for iter_5_0, iter_5_1 in pairs(self._equip_list) do
			local var_5_2 = var_0_2.find_object_by_cid(iter_5_1:get_equip_cid())
			local var_5_3 = var_5_2.special_effect

			for iter_5_2, iter_5_3 in pairs(var_5_2.effect) do
				if var_5_3 == var_0_6.equip_special_effect_type.ap and self._attrs[iter_5_3.name] then
					if iter_5_3.value > self._attrs[iter_5_3.name] then
						self._attrs[iter_5_3.name] = iter_5_3.value or self._attrs[iter_5_3.name]
					end
				end

				if var_5_3 == var_0_6.equip_special_effect_type.normal_attack_atk_rate then
					self._attrs.normal_attack_atk_rate = self._attrs.normal_attack_atk_rate or 0

					if iter_5_3.value > self._attrs.normal_attack_atk_rate then
						self._attrs.normal_attack_atk_rate = iter_5_3.value or self._attrs.normal_attack_atk_rate
					end
				end

				if var_5_3 == var_0_6.equip_special_effect_type.torpedo_plane_hit then
					if iter_5_3.name == "num1" then
						self._attrs.aircraft_torpedo_plane_hit = self._attrs.aircraft_torpedo_plane_hit + iter_5_3.value / 100
					end

					if iter_5_3.name == "num2" then
						self._attrs.normal_attack_hit = self._attrs.normal_attack_hit + iter_5_3.value / 100
					end
				end

				if var_5_3 == var_0_6.equip_special_effect_type.reduce_enemy_aircraft_hit then
					self._attrs.reduce_enemy_aircraft_hit = self._attrs.reduce_enemy_aircraft_hit + iter_5_3.value / 100
				end

				if var_5_3 == var_0_6.equip_special_effect_type.reduce_enemy_torpedo_plane_hit then
					self._attrs.reduce_enemy_torpedo_plane_hit = self._attrs.reduce_enemy_torpedo_plane_hit + iter_5_3.value / 100
				end

				if var_5_3 == var_0_6.equip_special_effect_type.torpedo_attack_hit then
					self._attrs.torpedo_attack_hit = self._attrs.torpedo_attack_hit + iter_5_3.value / 100
				end

				if var_5_3 == var_0_6.equip_special_effect_type.aircraft_normal_hit or var_5_3 == var_0_6.equip_special_effect_type.aircraft_attack_bomber then
					if iter_5_3.name == "boom" then
						self._attrs.aircraft_attack_bomber = self._attrs.aircraft_attack_bomber + iter_5_3.value
					end

					if iter_5_3.name == "num" then
						self._attrs.aircraft_attack_bomber = self._attrs.aircraft_attack_bomber * (1 + iter_5_3.value)
					end

					if iter_5_3.name == "hit" then
						self._attrs.normal_attack_hit = self._attrs.normal_attack_hit + iter_5_3.value / 100
					end
				end

				if var_5_3 == var_0_6.equip_special_effect_type.aircraft_attack_torpedo and iter_5_3.name == "num" then
					self._attrs.aircraft_attack_torpedo = self._attrs.aircraft_attack_torpedo * (1 + iter_5_3.value)
				end

				if var_5_3 == var_0_6.equip_special_effect_type.reduce_enemy_missile_hit then
					self._attrs.reduce_enemy_missile_hit = self._attrs.reduce_enemy_missile_hit + iter_5_3.value / 100
				end
			end

			for iter_5_4, iter_5_5 in pairs(var_0_6.equip_attribute_type) do
				if iter_5_5 == "range" then
					if var_5_2[iter_5_5] > self._attrs[iter_5_5] then
						self._attrs[iter_5_5] = var_5_2[iter_5_5] or self._attrs[iter_5_5]
					end
				else
					self._attrs[iter_5_5] = self._attrs[iter_5_5] or 0

					local var_5_6 = iter_5_1:get_equip_attribute(iter_5_5)

					if var_5_6 then
						self._attrs[iter_5_5] = self._attrs[iter_5_5] + var_5_6
					end
				end
			end

			if next(var_5_2.exclusive_cid) and next(var_5_2.exclusive_buff) then
				for iter_5_6, iter_5_7 in pairs(var_5_2.exclusive_cid) do
					if iter_5_7 == self:get_cid() then
						for iter_5_8, iter_5_9 in pairs(var_5_2.exclusive_buff) do
							if iter_5_9.type == 1 then
								for iter_5_10, iter_5_11 in pairs(var_0_6.skil_attribute_type) do
									if iter_5_10 == iter_5_9.num4 and self._attrs[iter_5_11] then
										self._attrs[iter_5_11] = self._attrs[iter_5_11] + iter_5_9.num
									end
								end
							elseif iter_5_9.type == 2 then
								for iter_5_12, iter_5_13 in pairs(var_0_6.skil_attribute_type) do
									if iter_5_12 == iter_5_9.num4 and self._attrs[iter_5_13] then
										self._attrs[iter_5_13] = iter_5_13 == "crit_repair" and self._attrs[iter_5_13] + iter_5_9.num or var_0_1.ceil(self._attrs[iter_5_13] * (1 + iter_5_9.num / 100))
									end
								end
							elseif iter_5_9.type == 5 then
								if self._attrs.ap then
									var_5_0 = var_5_0 + iter_5_9.num
								end
							elseif iter_5_9.type == 10 and self._attrs.ap then
								var_5_1 = var_0_1.max(var_5_1, iter_5_9.num)
							end
						end
					end
				end
			elseif not next(var_5_2.exclusive_cid) and next(var_5_2.exclusive_buff) then
				for iter_5_14, iter_5_15 in pairs(var_5_2.exclusive_buff) do
					if iter_5_15.type == 1 then
						for iter_5_16, iter_5_17 in pairs(var_0_6.skil_attribute_type) do
							if iter_5_16 == iter_5_15.num4 and self._attrs[iter_5_17] then
								self._attrs[iter_5_17] = self._attrs[iter_5_17] + iter_5_15.num
							end
						end
					elseif iter_5_15.type == 2 then
						for iter_5_18, iter_5_19 in pairs(var_0_6.skil_attribute_type) do
							if iter_5_18 == iter_5_15.num4 and self._attrs[iter_5_19] then
								self._attrs[iter_5_19] = iter_5_19 == "crit_repair" and self._attrs[iter_5_19] + iter_5_15.num or var_0_1.ceil(self._attrs[iter_5_19] * (1 + iter_5_15.num / 100))
							end
						end
					elseif iter_5_15.type == 5 then
						if self._attrs.ap then
							var_5_0 = var_5_0 + iter_5_15.num
						end
					elseif iter_5_15.type == 10 and self._attrs.ap then
						var_5_1 = var_0_1.max(var_5_1, iter_5_15.num)
					end
				end
			end
		end

		if self._attrs.ap then
			self._attrs.ap = var_0_1.max(self._attrs.ap, var_5_1) + var_5_0
		end

		for iter_5_20, iter_5_21 in pairs(var_0_6.equip_attribute_type) do
			self._attrs[iter_5_21] = self._attrs[iter_5_21] or 0

			if self._attrs[iter_5_21] > 1 then
				self._attrs[iter_5_21] = var_0_1.floor(self._attrs[iter_5_21])
			end
		end
	end

	function arg_1_0:__attribute_by_cookbuff()
		local var_6_0 = self._battle_scene:get_player_cookbuff()

		if not var_6_0 then
			return
		end

		local var_6_1 = var_0_3.find_object_by_cid(var_6_0)

		if not var_6_1 then
			return
		end

		local var_6_2 = {}

		var_6_2.ship_type = var_6_1.effect.ship_type or 0
		var_6_2.ship_ton = var_6_1.effect.ship_ton or 0
		var_6_2.country = var_6_1.effect.country or 0

		if not self:__conform_with_data(var_6_2) then
			return
		end

		if var_6_1.effect.type == var_0_6.cookbuff_type.normal_attack_damage or var_6_1.effect.type == var_0_6.cookbuff_type.night_attack_damage or var_6_1.effect.type == var_0_6.cookbuff_type.torpedo_attack_damage then
			local var_6_3 = "normal_attack"

			for iter_6_0, iter_6_1 in pairs(var_0_6.cookbuff_damage_attr) do
				if iter_6_1 == var_6_1.effect.type then
					var_6_3 = iter_6_0
				end
			end

			if self._attrs[var_6_3] then
				self._attrs[var_6_3] = self._attrs[var_6_3] + var_6_1.effect.value
			end

			self._battlefield:append_result(self._cid, "菜谱buff", (string.format("伤害加成阶段:%s,数值:%.2f", var_6_3, var_6_1.effect.value)))

			return
		end

		if var_6_1.effect.type == var_0_6.cookbuff_type.exp then
			return
		end

		for iter_6_2, iter_6_3 in pairs(self._attrs) do
			if iter_6_2 == var_6_1.effect.attr then
				self._attrs[iter_6_2] = self._attrs[iter_6_2] + var_6_1.effect.value

				self._battlefield:append_result(self._cid, "菜谱buff", (string.format("属性名:%s,修改前的值:%1.f,修改后的值:%1.f", iter_6_2, iter_6_3, self._attrs[iter_6_2])))
			end
		end
	end

	function arg_1_0:__attribute_by_racingbuff()
		local var_7_0 = self._battle_scene:get_player_racingbuff()

		if not var_7_0 then
			return
		end

		local var_7_1 = var_0_11.find_object_by_cid(var_7_0.id)

		if not var_7_1 then
			return
		end

		if not var_7_1.buff then
			return
		end

		local var_7_2 = var_7_1.buff.ship_type or 0
		local var_7_3 = var_7_1.buff.shipTon or 0
		local var_7_4 = var_0_6.skil_attribute_type[var_7_1.buff.num4]

		if var_7_1.buff.type == 1 and (var_7_2 == 0 or var_7_2 == self._ship_type) and (var_7_0.country == 0 or var_7_0.country == self._country) and (var_7_3 == 0 or var_7_3 == self._ship_ton) and self._attrs[var_7_4] then
			self._attrs[var_7_4] = self._attrs[var_7_4] + var_7_1.buff.num

			self._battlefield:append_result(self._cid, "赛车buff", (string.format("属性名:%s, 修改前的值:%f, 修改后的值:%f", var_7_4, self._attrs[var_7_4], self._attrs[var_7_4])))
		end
	end

	function arg_1_0:__abyss_power_buff()
		local var_8_0 = self._battle_scene:get_abyss_power()

		if not var_8_0 then
			return
		end

		local var_8_1 = var_0_13.find_object_by_level((gameenum.battle_type:get_abyss_power_level(var_8_0)))

		if var_8_1 then
			for iter_8_0, iter_8_1 in pairs(var_8_1.effect) do
				if iter_8_0 == "hit" then
					self._attrs[iter_8_0] = self._attrs[iter_8_0] or 0
					self._attrs[iter_8_0] = self._attrs[iter_8_0] * (1 + iter_8_1)
					self._attrs[iter_8_0] = var_0_1.ceil(self._attrs[iter_8_0])
				elseif iter_8_0 == "miss" then
					self._attrs[iter_8_0] = self._attrs[iter_8_0] or 0
					self._attrs[iter_8_0] = self._attrs[iter_8_0] * (1 + iter_8_1)
					self._attrs[iter_8_0] = var_0_1.ceil(self._attrs[iter_8_0])
				elseif iter_8_0 == "atk" then
					self._attrs[iter_8_0] = self._attrs[iter_8_0] or 0
					self._attrs[iter_8_0] = self._attrs[iter_8_0] * (1 + iter_8_1)
					self._attrs[iter_8_0] = var_0_1.ceil(self._attrs[iter_8_0])
				end
			end
		end
	end

	function arg_1_0:__attribute_by_workshop(arg_9_1)
		local var_9_0 = self._battle_scene:get_player_workshop_cfg()

		if not var_9_0 then
			return
		end

		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			local var_9_1 = var_0_12.find_object_by_id(iter_9_1).effect[1]

			if var_9_1.shipTypes then
				for iter_9_2, iter_9_3 in pairs(var_9_1.shipTypes) do
					if iter_9_3 == self:get_ship_type() then
						if var_9_1.type == var_0_6.work_type.add_attribute then
							if var_9_1.countrys then
								for iter_9_4, iter_9_5 in pairs(var_9_1.countrys) do
									if iter_9_5 == self:get_country() then
										self._attrs[var_0_6.skil_attribute_type[var_9_1.num4]] = self._attrs[var_0_6.skil_attribute_type[var_9_1.num4]] + var_9_1.num

										self._battlefield:append_result(self._cid, "工坊buff", (string.format("工坊buff增加属性名:%s, 修改前的值:%f, 修改后的值:%f", var_0_6.skil_attribute_type[var_9_1.num4], self._attrs[var_0_6.skil_attribute_type[var_9_1.num4]], self._attrs[var_0_6.skil_attribute_type[var_9_1.num4]])))
									end
								end
							end
						elseif var_9_1.type == var_0_6.work_type.add_torpedo_damage then
							if self._attrs[var_0_6.skil_attribute_type[var_9_1.num4]] ~= 0 then
								self._attrs[var_0_6.skil_attribute_type[var_9_1.num4]] = self._attrs[var_0_6.skil_attribute_type[var_9_1.num4]] + var_9_1.num
							end

							self._battlefield:append_result(self._cid, "工坊buff，前后都为0说明该船只无法拥有该buff", (string.format("工坊buff增加属性名:%s, 修改前的值:%f, 修改后的值:%f", var_0_6.skil_attribute_type[var_9_1.num4], self._attrs[var_0_6.skil_attribute_type[var_9_1.num4]], self._attrs[var_0_6.skil_attribute_type[var_9_1.num4]])))
						elseif var_9_1.type == var_0_6.work_type.add_shelling_damage then
							-- block empty
						end
					end
				end
			end
		end
	end

	function arg_1_0:__conform_with_data(arg_10_1)
		local var_10_0
		local var_10_1

		if not arg_10_1 then
			do return false end

			var_10_0 = arg_10_1.ship_ton == 0 and true or self._ship_ton == arg_10_1.ship_ton
			var_10_1 = arg_10_1.country == 0 and true or self._country == arg_10_1.country
		end

		if (arg_10_1.ship_type == 0 and true or self._ship_type == arg_10_1.ship_type) and var_10_0 and var_10_1 then
			return true
		end

		return false
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

	function arg_1_0:__calculate_ship_collection_buff()
		if not self._battle_scene._collectionbuff then
			return
		end

		for iter_12_0, iter_12_1 in pairs(self._battle_scene._collectionbuff) do
			local var_12_0 = var_0_4.find_object_by_cid(iter_12_1)

			if var_12_0 then
				local var_12_1 = var_0_7(var_12_0.buff_effect.attr)
				local var_12_2 = false

				for iter_12_2, iter_12_3 in ipairs(var_12_0.buff_effect.ship_type) do
					if iter_12_3 == self._ship_type then
						var_12_2 = true

						break
					end
				end

				if var_12_2 and (var_12_0.buff_effect.country == 0 or var_12_0.buff_effect.country == self._country) then
					self._attrs[var_12_1] = self._attrs[var_12_1] + var_12_0.buff_effect.val
				end
			end
		end
	end

	function arg_1_0:__calculate_ship_skill_by_passive()
		local var_13_0 = var_0_5.find_object_by_skill_type_skill_level(self._skill_data.skill, self._skill_data.skill_level)

		if not var_13_0 then
			return
		end

		if not var_13_0.effect[1] then
			return
		end

		for iter_13_0, iter_13_1 in pairs(var_13_0.effect) do
			if iter_13_1.stage[1] == 1 then
				self:set_multiple_attr_value(1)

				if self:__get_conditioin_by_config_by_skill(iter_13_1, self:getID()) then
					for iter_13_2, iter_13_3 in pairs(iter_13_1.effect) do
						if iter_13_3.type == 3 or iter_13_3.type == 4 or iter_13_3.type == 5 or iter_13_3.type == 131 then
							self:__set_ower_attr_by_skill_type(iter_13_3)
						end

						if iter_13_3.type == 94 then
							self._attrs.range = iter_13_3.num
						end
					end
				end
			end
		end
	end

	function arg_1_0:__calculate_ship_skill_by_passive_by_equips()
		local var_14_0 = var_0_5.find_object_by_skill_type_skill_level(self._skill_data.skill, self._skill_data.skill_level)

		if not var_14_0 then
			return
		end

		if not var_14_0.effect[1] then
			return
		end

		for iter_14_0, iter_14_1 in pairs(var_14_0.effect) do
			if iter_14_1.stage[1] == 1 and self:__get_conditioin_by_config_by_skill(iter_14_1, self:getID()) then
				for iter_14_2, iter_14_3 in pairs(iter_14_1.effect) do
					if iter_14_3.type == 50 or iter_14_3.type == 51 or iter_14_3.type == 52 or iter_14_3.type == 54 or iter_14_3.type == 49 then
						self:__set_equip_attr_by_skill_type(iter_14_3)
					end
				end
			end
		end
	end

	function arg_1_0:__get_conditioin_by_config_by_skill(arg_15_1, arg_15_2)
		if not arg_15_1.condition then
			return true
		end

		local var_15_0 = false
		local var_15_1 = var_0_9:create()

		var_15_1:bind(self._battlefield)

		for iter_15_0, iter_15_1 in pairs(arg_15_1.condition) do
			var_15_1:init(iter_15_1, arg_15_2)

			local var_15_2 = var_15_1:onConditionFunc(iter_15_1)

			if var_15_2 then
				var_15_0 = var_15_2

				break
			end
		end

		return var_15_0
	end

	function arg_1_0:__set_ower_attr_by_skill_type(arg_16_1)
		local var_16_0
		local var_16_1 = {}
		local var_16_2 = self:get_multiple_attr_value() or 1

		for iter_16_0, iter_16_1 in pairs(self._equip_list) do
			local var_16_3 = var_0_2.find_object_by_cid(iter_16_1:get_equip_cid())

			for iter_16_2, iter_16_3 in pairs(var_0_6.equip_attribute_type) do
				if iter_16_3 == "range" then
					var_16_1[iter_16_3] = var_16_1[iter_16_3] or 0

					if var_16_3[iter_16_3] > var_16_1[iter_16_3] then
						var_16_1[iter_16_3] = var_16_3[iter_16_3] or var_16_1[iter_16_3]
					end
				else
					var_16_1[iter_16_3] = var_16_1[iter_16_3] or 0

					local var_16_4 = iter_16_1:get_equip_attribute(iter_16_3)

					if var_16_4 then
						var_16_1[iter_16_3] = var_16_1[iter_16_3] + var_16_4
					end
				end
			end
		end

		for iter_16_4, iter_16_5 in pairs(arg_16_1) do
			for iter_16_6, iter_16_7 in pairs(var_0_6.skil_attribute_type) do
				if iter_16_4 == iter_16_7 then
					var_16_0 = iter_16_4

					break
				end
			end
		end

		if arg_16_1.type == 3 then
			if var_16_0 == "range" and var_16_1[var_16_0] then
				self._attrs[var_16_0] = var_0_1.max(var_16_1[var_16_0], self._attrs[var_16_0])
			end

			self._attrs[var_16_0] = self._attrs[var_16_0] + nil * var_16_2

			self._battlefield:append_result(self._cid, "技能被动（请查看“技能效果”子表中的type）", (string.format("属性名:%s,修改前的值:%1.f,修改后的值:%1.f", var_16_0, self._attrs[var_16_0], self._attrs[var_16_0])))
		elseif arg_16_1.type == 4 then
			self.skill_type_4 = self.skill_type_4 or {}

			local var_16_6 = lx.clone_table(arg_16_1)

			var_16_6.multiple = var_16_2

			table.insert(self.skill_type_4, var_16_6)
		elseif arg_16_1.type == 5 then
			self.skill_type_5 = self.skill_type_5 or {}

			local var_16_7 = lx.clone_table(arg_16_1)

			var_16_7.multiple = var_16_2

			table.insert(self.skill_type_5, var_16_7)
		elseif arg_16_1.type == 131 then
			if self._attrs[var_0_6.skil_attribute_type[arg_16_1.attribute]] then
				var_16_1[var_0_6.skil_attribute_type[arg_16_1.attribute]] = var_16_1[var_0_6.skil_attribute_type[arg_16_1.attribute]] or 0
				var_16_1.speed = var_16_1.speed or 0
				self._attrs[var_0_6.skil_attribute_type[arg_16_1.attribute]] = var_0_10:attr_impact_by_speed(self._attrs.speed + var_16_1.speed, self._attrs[var_0_6.skil_attribute_type[arg_16_1.attribute]] + var_16_1[var_0_6.skil_attribute_type[arg_16_1.attribute]], arg_16_1.num1, arg_16_1.num2) - var_16_1[var_0_6.skil_attribute_type[arg_16_1.attribute]]
			end
		end
	end

	function arg_1_0:__set_equip_attr_by_skill_type(arg_17_1)
		local var_17_2
		local var_17_3

		if not self._equip_list then
			return
		end

		for iter_17_0, iter_17_1 in pairs(arg_17_1) do
			for iter_17_2, iter_17_3 in pairs(var_0_6.equip_attribute_type) do
				if iter_17_0 == iter_17_3 then
					var_17_2 = iter_17_0
					var_17_3 = iter_17_1

					break
				end
			end
		end

		for iter_17_4, iter_17_5 in pairs(self._equip_list) do
			if arg_17_1.equipment_type then
				for iter_17_6, iter_17_7 in pairs(arg_17_1.equipment_type) do
					if iter_17_5:get_equip_bore_type() == iter_17_7 then
						if arg_17_1.type == 51 then
							iter_17_5:add_equip_attribute(var_17_2, var_17_3)
							self._battlefield:append_result(self._cid, "触发武器相关技能被动51")
						end

						if arg_17_1.type == 52 then
							iter_17_5:add_equip_attribute(var_17_2, iter_17_5:get_equip_attribute(var_17_2) * var_17_3)
							self._battlefield:append_result(self._cid, "触发武器相关技能被动52")
						end

						if arg_17_1.type == 54 then
							local var_17_5 = var_0_6.equip_bore_type.anti_submarine_equipment

							if iter_17_7 == var_0_6.equip_bore_type.anti_submarine_equipment then
								var_17_5 = var_0_6.equip_bore_type.air_defense_machine_gun
							end

							local var_17_6 = iter_17_5:get_equip_attribute(var_0_6.skil_attribute_type[arg_17_1.attribute])

							iter_17_5:set_equip_second_type(var_17_5)
							iter_17_5:add_equip_attribute(var_0_6.skil_attribute_type[arg_17_1.attribute2], arg_17_1.rate * var_17_6)
							self._battlefield:append_result(self._cid, "触发武器相关技能被动54")
						end
					end
				end
			end

			if arg_17_1.type == 50 then
				local var_17_7 = iter_17_5:get_equip_attribute(var_0_6.skil_attribute_type[arg_17_1.attribute2])

				iter_17_5:add_equip_attribute(var_0_6.skil_attribute_type[arg_17_1.attribute2], iter_17_5:get_equip_attribute(var_0_6.skil_attribute_type[arg_17_1.attribute]) * arg_17_1.rate)
				self._battlefield:append_result(self._cid, "触发武器相关技能被动50")
			end

			if arg_17_1.type == 49 then
				for iter_17_8, iter_17_9 in pairs((iter_17_5:get_equip_attrs())) do
					if iter_17_8 ~= "range" and iter_17_8 ~= "hp" then
						iter_17_5:add_equip_attribute(iter_17_8, arg_17_1.rate * iter_17_9)
						self._battlefield:append_result(self._cid, "触发武器相关技能被动49" .. iter_17_8 .. "增加了" .. arg_17_1.rate * iter_17_9)
					end
				end
			end
		end
	end

	function arg_1_0:__attr_by_love()
		self._attrs.hit = var_0_1.floor(self._attrs.hit + (self._love - 5000) / 1000)
		self._attrs.miss = var_0_1.floor(self._attrs.miss + (self._love - 5000) / 1000)

		self._battlefield:append_result(self._cid, "好感度补正", (string.format("好感度补正,命中影响前:%d,命中影响后:%d,闪避影响前:%d,闪避影响后:%d", self._attrs.hit, self._attrs.hit, self._attrs.miss, self._attrs.miss)))
	end
end

function var_0_0.extend_obj(arg_19_0)
	arg_19_0._attribute = {}
	arg_19_0._attrs = {}
end

return var_0_0
