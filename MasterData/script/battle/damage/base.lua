local var_0_0 = {}
local var_0_1 = next
local var_0_2 = tostring
local var_0_3 = math.ceil
local var_0_4 = string.format
local var_0_5 = gameenum.battle_type
local var_0_6 = gamecore.battle_util
local var_0_7 = gameconfig.equip_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:calculate_damage_increase(arg_2_1, arg_2_2, arg_2_3)
		if not arg_2_1 or not arg_2_2 then
			return
		end

		local var_2_0 = arg_2_3
		local var_2_1 = arg_2_1:get_attribute()
		local var_2_2 = var_2_1.increase_all_power:get_final_value()

		if var_2_2 ~= 1 then
			var_2_0 = var_0_3(var_2_0 * var_2_2)

			self:set_damage_record("伤害buff加成", var_0_4("伤害前:%d, 伤害后:%d, 加成:%f", var_2_0, var_2_0, var_2_2))
		end

		if self._attack_type == "night_attack" then
			local var_2_3 = var_2_1.night_attack:get_final_value()

			if var_2_3 ~= 1 then
				var_2_0 = var_0_3(var_2_0 * var_2_3)

				self:set_damage_record("夜战伤害加成", var_0_4("伤害前:%d, 伤害后:%d, 加成:%f", var_2_0, var_2_0, var_2_3))

				return var_2_0
			end
		end

		if self._attack_type == "aircraft_attack" then
			local var_2_4 = var_2_1.aircraft_attack:get_final_value()

			var_2_0 = var_0_3(var_2_0 * var_2_4)

			if var_2_4 ~= 1 then
				self:set_damage_record("航空战伤害buff加成", var_0_4("伤害前:%d, 伤害后:%d, 加成:%f", var_2_0, var_2_0, var_2_4))
			end
		end

		if self._attack_type == "normal_attack" then
			local var_2_5 = var_2_1.normal_attack:get_final_value()

			var_2_0 = var_0_3(var_2_0 * var_2_5)

			if var_2_5 ~= 1 then
				self:set_damage_record("炮击战伤害buff加成", var_0_4("伤害前:%d, 伤害后:%d, 加成:%f", var_2_0, var_2_0, var_2_5))
			end
		end

		if self._attack_type == "torpedo_attack" and self._battlefield._battle_step == var_0_5.trigger_type.close_torpedo_attack then
			local var_2_6 = var_2_1.torpedo_attack:get_final_value()

			var_2_0 = var_0_3(var_2_0 * var_2_6)

			if var_2_6 ~= 1 then
				self:set_damage_record("鱼雷战伤害buff加成", var_0_4("伤害前:%d, 伤害后:%d, 加成:%f", var_2_0, var_2_0, var_2_6))
			end
		end

		return var_2_0
	end

	function arg_1_0:aircraft_attack_equip_add_attr(arg_3_1)
		local var_3_0 = 1

		for iter_3_0, iter_3_1 in pairs((arg_3_1:get_equip_list())) do
			local var_3_2 = var_0_7.find_object_by_cid(iter_3_1._cid)

			if var_0_1(var_3_2.exclusive_cid) and var_0_1(var_3_2.exclusive_buff) then
				for iter_3_2, iter_3_3 in pairs(var_3_2.exclusive_cid) do
					if arg_3_1:get_cid() == iter_3_3 then
						for iter_3_4, iter_3_5 in pairs(var_3_2.exclusive_buff) do
							if iter_3_5.type == 9 and iter_3_5.stage then
								for iter_3_6, iter_3_7 in pairs(iter_3_5.stage) do
									if var_0_6:judge_stage(iter_3_7, self._battlefield._battle_step) then
										var_3_0 = var_3_0 * (iter_3_5.num + 1)
									end
								end
							end
						end
					end
				end
			elseif not var_0_1(var_3_2.exclusive_cid) and var_0_1(var_3_2.exclusive_buff) then
				for iter_3_8, iter_3_9 in pairs(var_3_2.exclusive_buff) do
					if iter_3_9.type == 9 and iter_3_9.stage then
						for iter_3_10, iter_3_11 in pairs(iter_3_9.stage) do
							if var_0_6:judge_stage(iter_3_11, self._battlefield._battle_step) then
								var_3_0 = var_3_0 * (iter_3_9.num + 1)
							end
						end
					end
				end
			end
		end

		return var_3_0 - 1
	end

	function arg_1_0:calculate_damage_decrease(arg_4_1, arg_4_2)
		if not arg_4_1 or not arg_4_2 then
			return
		end

		local var_4_0 = arg_4_2:get_attribute()

		if var_4_0.reduce_attack_my_ship_power and arg_4_1:get_ship_ton() == var_4_0.reduce_attack_my_ship_power.shipTon_enemy and arg_4_2:get_ship_ton() == var_4_0.reduce_attack_my_ship_power.shipTon then
			self._damage_attr.damage = var_0_3(self._damage_attr.damage * (1 - var_4_0.reduce_attack_my_ship_power.num / 100))

			self._battlefield:append_result("buff伤害降低", arg_4_1:get_ship_ton(), (string.format(" 伤害降低:%s, 前:%f, 后:%f", var_4_0.reduce_attack_my_ship_power.num / 100, self._damage_attr.damage, self._damage_attr.damage)))
			self:set_damage_record("全阶段受伤buff减少", var_0_4("伤害前:%d, 伤害后:%d, 加成:%f", self._damage_attr.damage, self._damage_attr.damage, var_4_0.reduce_attack_my_ship_power.num / 100))
		end

		local var_4_1 = var_4_0.decrease_all_power:get_final_value()

		if var_4_1 ~= 1 then
			self._damage_attr.damage = var_0_3(self._damage_attr.damage * var_4_1)

			self:set_damage_record("全阶段受伤buff减少", var_0_4("伤害前:%d, 伤害后:%d, 加成:%f", self._damage_attr.damage, self._damage_attr.damage, var_4_1))
		end

		if self._attack_type == "aircraft_attack" then
			local var_4_2 = var_4_0.decrease_aircraft_injured:get_final_value()

			if var_4_2 ~= 1 then
				self._damage_attr.damage = var_0_3(self._damage_attr.damage * var_4_2)

				self:set_damage_record("航空战受伤buff减少", var_0_4("伤害前:%d, 伤害后:%d, 加成:%f", self._damage_attr.damage, self._damage_attr.damage, var_4_2))
			end
		end

		if self._attack_type == "normal_attack" then
			local var_4_3 = var_4_0.decrease_normal_injured:get_final_value()

			if var_4_3 ~= 1 then
				self._damage_attr.damage = var_0_3(self._damage_attr.damage * var_4_3)

				self:set_damage_record("炮击战受伤buff减少", var_0_4("伤害前:%d, 伤害后:%d, 加成:%f", self._damage_attr.damage, self._damage_attr.damage, var_4_3))
			end
		end

		if self._attack_type == "torpedo_attack" then
			local var_4_4 = var_4_0.decrease_close_torpedo_injured:get_final_value()

			if var_4_4 ~= 1 then
				self._damage_attr.damage = var_0_3(self._damage_attr.damage * var_4_4)

				self:set_damage_record("鱼雷战受伤buff减少", var_0_4("伤害前:%d, 伤害后:%d, 加成:%f", self._damage_attr.damage, self._damage_attr.damage, var_4_4))
			end
		end
	end

	function arg_1_0:hit_division_half_miss(arg_5_1, arg_5_2, arg_5_3)
		arg_5_3 = arg_5_3 or 0

		local var_5_0 = arg_5_1:get_attribute()
		local var_5_1 = arg_5_2:get_attribute()
		local var_5_2 = var_5_0.hit:get_final_value()

		var_5_2 = var_5_2 < 0 and 0 or var_5_2

		self:set_damage_record("命中", var_5_2)

		local var_5_3 = var_5_1.miss:get_final_value()

		var_5_3 = var_5_3 < 0 and 0 or var_5_3

		self:set_damage_record("闪避", var_5_3)

		local var_5_4 = self:get_miss_by_t_formation(arg_5_1, arg_5_2, var_5_3)

		self:set_damage_record("阵型修正后闪避", var_5_4)

		if var_5_4 == 0 then
			var_5_4 = 1

			self:set_damage_record("敌方闪避为0,当1处理")
		end

		local var_5_5 = var_5_2 / var_5_4 / 2

		self:set_damage_record("基础命中率", var_0_4("命中%f/闪避%f/2", var_5_2, var_5_4))

		local var_5_6 = self:get_hit_rate_by_radar((self:get_hit_rate_by_formation(var_5_5)))

		self:set_damage_record("命中率加上参数", var_0_4("命中率前:%f, 命中率后:%f", var_5_6, var_5_6 + arg_5_3))

		local var_5_7 = self:get_hit_rate_by_enemy_equips_effect(arg_5_2, (self:get_hit_rate_by_equips_effect(arg_5_1, (self:get_formation_correct_additional(arg_5_1, arg_5_2, (self:get_attack_correct_by_shiptype(arg_5_1, arg_5_2, (self:get_hit_rate_by_aircontrol(var_5_6 + arg_5_3))))))))) + var_5_0.hit_repair:get_final_value() - var_5_1.miss_repair:get_final_value()

		self:set_damage_record("双方命中闪避补正", var_0_4("命中补正%f-敌方闪避补正%f,总命中率为%f", var_5_0.hit_repair:get_final_value(), var_5_1.miss_repair:get_final_value(), var_5_7))

		local var_5_8 = self:__handle_rate((self:get_hit_rate_by_love_miss(arg_5_2, (self:get_hit_rate_by_love(arg_5_1, var_5_7)))))

		self:set_damage_record("命中最高为95，最低为5", "当前命中结果为" .. var_5_8)

		if self._is_beat_back then
			var_5_8 = 1
		end

		self._damage_attr.is_miss = self:__roll_hit_rate(var_5_8)

		if var_5_0.sure_to_hit_by_index and arg_5_1:get_index() == arg_5_2:get_index() then
			self._damage_attr.is_miss = false

			self:set_damage_record("触发技能:攻击对应位置目标必定命中", "此次攻击必定命中")
		end

		if var_5_0.sure_to_hit and (not var_5_0.skill_num.sure_to_hit or var_5_0.skill_num.sure_to_hit > 0) then
			self._damage_attr.is_miss = false

			if var_5_0.skill_num.sure_to_hit then
				var_5_0.skill_num.sure_to_hit = var_5_0.skill_num.sure_to_hit - 1
			end

			self:set_damage_record("触发技能:此次攻击必定命中", "此次攻击必定命中")
		end

		local var_5_9 = var_5_0.sure_to_hit_by_shiptype

		if var_5_0.sure_to_hit_by_shiptype then
			local var_5_10

			if var_5_9.type == "shipTypes" then
				var_5_10 = arg_5_2:get_ship_type()
			elseif var_5_9.type == "shipTons" then
				var_5_10 = arg_5_2:get_ship_ton()
			elseif var_5_9.type == "guardTypes" then
				var_5_10 = arg_5_2:get_ship_guard_type()
			end

			for iter_5_0, iter_5_1 in pairs(var_5_9.type_num) do
				if var_5_10 == iter_5_1 then
					self._damage_attr.is_miss = false

					self:set_damage_record("触发技能:攻击xx舰种/大中小型船/主力护卫舰时必定命中", "此次攻击必定命中")

					break
				end
			end
		end

		if var_5_1.in_guardian then
			self._damage_attr.is_miss = false
		end

		local var_5_11 = self._battle_scene:get_attack_infallible_data()

		if var_5_11 then
			for iter_5_2, iter_5_3 in pairs(var_5_11.ship_list) do
				self._damage_attr.is_miss = false

				self:set_damage_record("触发芯片技能:", "此次攻击必定命中")
			end
		end

		if arg_5_1:get_ignore_miss() then
			self._damage_attr.is_miss = false

			self:set_damage_record("活动buff:", "此次攻击必定命中")
		end

		self:set_damage_record("命中率", var_0_4("%f", var_5_8))
		self:set_damage_record("攻击被闪避", var_0_2(self._damage_attr.is_miss))
	end

	function arg_1_0:def_rate_by_armor(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
		local var_6_0 = arg_6_4:get_attribute().ap:get_final_value()

		if arg_6_4:get_attribute().armor_penetration and arg_6_4:get_attribute().armor_penetration > 0 then
			var_6_0 = var_6_0 + arg_6_4:get_attribute().armor_penetration

			self:set_damage_record("触发技能:公式计算护甲穿透效果增加", "护甲穿透效果增加" .. arg_6_4:get_attribute().armor_penetration)
		end

		local var_6_1 = arg_6_1:get_attribute().def:get_final_value()

		var_6_1 = var_6_1 < 0 and 0 or var_6_1

		if arg_6_4:get_attribute().ignore_rate_by_armor_in_crit and self._damage_attr.is_crit or arg_6_4:is_medhp() and arg_6_4:get_attribute().ignore_rate_by_armor_in_special_ship or arg_6_4:is_lowhp() and arg_6_4:get_attribute().ignore_rate_by_armor_in_special_ship then
			var_6_1 = 0

			self:set_damage_record("触发无视护甲的暴击攻击,armor = 0")
		end

		if arg_6_4:get_attribute().ignore_rate_by_armor_in_is_flag and arg_6_1:is_flag() then
			var_6_0 = arg_6_4:get_attribute().ignore_rate_by_armor_in_is_flag + var_6_0

			self:set_damage_record("触发技能:攻击旗舰时护甲穿透效果增加", "护甲穿透效果增加" .. arg_6_4:get_attribute().ignore_rate_by_armor_in_is_flag)
		end

		if var_0_6:judge_stage(var_0_5.trigger_type.normal_attack, self._battlefield._battle_step) and arg_6_4:get_normal_attack_ap() ~= 0 then
			var_6_0 = var_6_0 + arg_6_4:get_normal_attack_ap()

			self:set_damage_record("战术触发护甲穿透", string.format("护甲穿透前:%f, 护甲穿透后:%f", var_6_0, var_6_0))
		end

		if arg_6_5 == var_0_5.calculate_def_type.normal_attack then
			local var_6_2 = self._battle_scene:get_ignore_armor()

			if var_6_2 and arg_6_1:get_side() == var_0_5.obj_side.player and var_0_6:judge_ship(arg_6_1, var_6_2) then
				var_6_1 = 0
			end
		end

		if not self._damage_attr.is_miss then
			local var_6_3 = self._battle_scene:get_rate_of_ignore_armor()

			if var_6_3 and arg_6_4:get_side() == var_0_5.obj_side.player and var_0_6:judge_ship(arg_6_4, var_6_3) and var_0_6.chance(var_6_3.rate, self._battle_random) then
				var_6_1 = 0
			end
		end

		if not self._damage_attr.is_miss then
			local var_6_4 = self._battle_scene:get_ignore_armor_in_open_torpedo_attack()

			if var_6_4 and arg_6_4:get_side() == var_0_5.obj_side.player and var_0_6:judge_ship(arg_6_4, var_6_4) and self._battlefield._battle_step == var_0_5.trigger_type.open_torpedo_attack then
				var_6_1 = 0
			end
		end

		if self:__get_probability_result(arg_6_4, 75) and arg_6_4:get_attribute().ignore_rate_by_armor_in_special_ship then
			local var_6_5 = arg_6_4:get_attribute().ignore_rate_by_armor_in_special_ship.type
			local var_6_7

			if var_6_5 == "shipTypes" then
				var_6_7 = arg_6_1:get_ship_type()
			elseif var_6_5 == "shipTons" then
				var_6_7 = arg_6_1:get_ship_ton()
			elseif var_6_5 == "guardTypes" then
				var_6_7 = arg_6_1:get_ship_guard_type()
			end

			for iter_6_0, iter_6_1 in pairs(arg_6_4:get_attribute().ignore_rate_by_armor_in_special_ship.type_num) do
				if iter_6_1 == var_6_7 then
					arg_6_4:get_attribute().ignore_rate_by_armor = arg_6_4:get_attribute().ignore_rate_by_armor_in_special_ship.rate

					self:set_damage_record("触发技能:攻击特定类型船时，无视部分护甲", "无视护甲增加" .. arg_6_4:get_attribute().ignore_rate_by_armor)
				end
			end
		end

		if arg_6_4:get_attribute().ignore_rate_by_armor_in_crit and self._damage_attr.is_crit then
			arg_6_4:get_attribute().ignore_rate_by_armor = arg_6_4:get_attribute().ignore_rate_by_armor_in_crit

			self:set_damage_record("触发技能:暴击时无视护甲", "无视护甲增加" .. arg_6_4:get_attribute().ignore_rate_by_armor_in_crit)
		end

		if arg_6_4:get_attribute().ignore_rate_by_armor then
			var_6_1 = var_6_1 * (1 - arg_6_4:get_attribute().ignore_rate_by_armor)

			self:set_damage_record("触发技能:无视护甲（总和）", "无视了" .. arg_6_4:get_attribute().ignore_rate_by_armor .. "的护甲")
		end

		if var_6_1 < 0 then
			var_6_1 = 0
		end

		local var_6_8 = 1 - var_6_1 / (var_6_1 * 0.5 + arg_6_2 * (arg_6_3 + var_6_0))
		local var_6_9

		if arg_6_2 == 0 then
			var_6_8 = 0
			var_6_9 = arg_6_6 and var_0_4("[%s]", arg_6_6) or ""
		end

		self:set_damage_record("减伤", var_0_4("1-护甲%f/(护甲%f*0.5+攻击%f%s*(防御减免%f+护甲穿透%f))=%f", var_6_1, var_6_1, arg_6_2, var_6_9, arg_6_3, var_6_0, var_6_8))

		return var_6_8 < 0 and 0 or var_6_8
	end

	function arg_1_0:get_atk_rate(arg_7_1)
		if not arg_7_1 then
			return
		end

		if self._attack_type == "normal_attack" then
			local var_7_0 = arg_7_1:get_attribute().normal_attack_atk_rate:get_final_value()

			if var_7_0 ~= 0 then
				self:set_damage_record("炮击战增加攻击上限", var_0_4("上限前:%f, 上限后:%f", self._atk_rate[2], self._atk_rate[2] + var_7_0))

				self._atk_rate[2] = self._atk_rate[2] + var_7_0
			end
		end

		local var_7_1 = self._battle_random:randRange(self._atk_rate[1], self._atk_rate[2])

		self:set_damage_record("伤害浮动系数", var_0_4("下限:%d, 上限:%d, 值:%d, 随机次数:%d", self._atk_rate[1], self._atk_rate[2], var_7_1, self._battle_random:getRandomCount()))

		return var_7_1 / 100
	end

	function arg_1_0:get_before_bottleneck_correct(arg_8_1)
		self._attack_type = self._attack_type or "normal_attack"

		self:set_damage_record("瓶颈前的补正:", self._formation_power_addition * self._direction_correct * self._damage_correct)

		if not arg_8_1 then
			return self._formation_power_addition * self._direction_correct * self._damage_correct
		end

		return self._formation_power_addition * self._direction_correct * self._damage_correct
	end

	function arg_1_0:set_damage_correct(arg_9_1, arg_9_2)
		if not arg_9_1 or not arg_9_2 then
			return
		end

		local var_9_0 = arg_9_1:get_attribute()
		local var_9_1, var_9_2 = var_0_5:get_ship_state_by_value(var_9_0.now_hp:get_final_value(), (var_9_0.hp:get_final_value()))
		local var_9_3 = arg_9_1:get_battle_damage_state()
		local var_9_4 = arg_9_1:get_alltypes_ignore_damaged()

		arg_9_1.skill_num = arg_9_1.skill_num or {}

		if self._is_beat_back and not arg_9_1.skill_num.is_tactics_back then
			var_9_3 = true

			self:set_damage_record("触发技能：反击,无视战损", var_0_4("反击：非大破时，对攻击自己的敌方发动反击，无视自身战损"))
		end

		if var_9_4 and var_0_1(var_9_4) then
			if var_9_4.typeNum == 1 then
				for iter_9_0, iter_9_1 in pairs(var_9_4.shipType) do
					if arg_9_2:get_ship_type() == iter_9_1 then
						var_9_3 = true

						self:set_damage_record("触发技能：攻击特定类型船只无视战损")
					end
				end
			end

			if var_9_4.typeNum == 2 then
				for iter_9_2, iter_9_3 in pairs(var_9_4.shipType) do
					if arg_9_2:get_ship_ton() == iter_9_3 then
						var_9_3 = true

						self:set_damage_record("触发技能：攻击大小型船只无视战损")
					end
				end
			end

			if var_9_4.typeNum == 3 then
				for iter_9_4, iter_9_5 in pairs(var_9_4.shipType) do
					if arg_9_2:get_ship_guard_type() == iter_9_5 == iter_9_5 then
						var_9_3 = true

						self:set_damage_record("触发技能：攻击主力护卫船只无视战损")
					end
				end
			end
		end

		if var_9_3 then
			var_9_2 = 1

			self:set_damage_record("触发技能：无视战损", "无视战损")
		elseif var_9_2 ~= 1 and arg_9_1:get_reduce_damage() ~= 0 then
			var_9_2 = var_9_2 + arg_9_1:get_reduce_damage() * (1 - var_9_2)

			self:set_damage_record("触发技能：无视部分战损的部分", "无视部分战损的部分" .. arg_9_1:get_reduce_damage())
		end

		if arg_9_1:get_affect_power_by_state() and arg_9_1:is_medhp() then
			var_9_2 = 1

			self:set_damage_record("触发技能:中损状态不影响火力", "中破状态下不影响自身火力")
		end

		self._damage_correct = var_9_2

		self:set_damage_record("损伤补正", var_0_4("%f", self._damage_correct))
	end

	function arg_1_0:set_direction_correct(arg_10_1)
		if not arg_10_1 then
			return
		end

		if arg_10_1:get_atk_type() ~= var_0_5.attack_round.normal and arg_10_1:get_atk_type() ~= var_0_5.attack_round.torpedo then
			return
		end

		if self._attack_type == "night_attack" then
			return
		end

		local var_10_0 = self._battle_scene:get_player_course()

		self._direction_correct = var_0_5:get_direction_addition((arg_10_1:get_side() == var_0_5.obj_side.enemy or nil) and self._battle_scene:get_enemy_course())

		self:set_damage_record("航向伤害补正", var_0_4("%f", self._direction_correct))

		if arg_10_1:get_attribute().can_not_effect_by_course then
			self._direction_correct = arg_10_1:get_attribute().can_not_effect_by_course

			self:set_damage_record("触发技能：修改航向伤害补正修改为", var_0_4("%f", arg_10_1:get_attribute().can_not_effect_by_course))
		end
	end

	function arg_1_0:set_formation_correct(arg_11_1, arg_11_2)
		self._attack_type = self._attack_type or "normal_attack"

		if not arg_11_1 then
			return
		end

		local var_11_0 = self._battle_scene:get_player_formation()
		local var_11_1 = self._battle_scene:get_enemy_formation()

		if arg_11_1:get_side() == var_0_5.obj_side.enemy then
			var_11_0 = self._battle_scene:get_enemy_formation()
			var_11_1 = self._battle_scene:get_player_formation()
		end

		local var_11_2 = var_0_5:get_formation_addition(var_11_0, arg_11_2)
		local var_11_3 = var_0_5:get_formation_addition(var_11_1, arg_11_2)

		self._formation_power_addition = var_11_2.power_addition
		self._formation_hit_addition = var_11_2.hit_addition
		self._formation_miss_addition = var_11_3.miss_addition
		self._formation_crit = var_11_2.crit_rate
		self._formation_crited = var_11_3.crited_rate

		self:set_damage_record("阵型伤害补正", var_0_4("%f", self._formation_power_addition))
	end

	function arg_1_0:set_radar_correct(arg_12_1, arg_12_2)
		if not arg_12_1 then
			return
		end

		if self._battle_scene:get_radar_state() then
			if arg_12_1:get_side() == var_0_5.obj_side.enemy then
				self._radar_miss = 0.05
			else
				self._radar_hit = 0.05
			end
		end
	end

	function arg_1_0:set_aircontrol_correct(arg_13_1)
		if not arg_13_1 then
			return
		end

		local var_13_0 = self._battle_scene:get_player_air_control_type()

		if arg_13_1:get_side() == var_0_5.obj_side.enemy then
			var_13_0 = self._battle_scene:get_enemy_air_control_type()
		end

		if not var_13_0 then
			return
		end

		self._aircontrol_hit, self._aircontrol_power = var_0_5:get_air_control_rate(var_13_0)

		if not arg_13_1:get_ship_aircraft_hurt_state() and (var_13_0 == var_0_5.air_control_type.weakness.value or var_13_0 == var_0_5.air_control_type.loss.value) then
			self._aircontrol_power = 1

			self:set_damage_record("制空状态伤害不受影响", var_0_4("制空劣势或者丧失不影响舰载机威力"))
		end

		self:set_damage_record("制空状态伤害补正", var_0_4("%f", self._aircontrol_power))
		self:set_damage_record("制空状态命中补正", var_0_4("%f", self._aircontrol_hit))
	end

	function arg_1_0:get_bullet_correct(arg_14_1)
		if arg_14_1._battle_scene:get_fight_type() == var_0_5.fight_type.plot_main then
			return 1
		end

		local var_14_0 = var_0_5:get_ammo_addition(math.floor((arg_14_1:get_ammo())))

		if var_14_0 ~= 1 and arg_14_1:get_reduce_loss() ~= 0 then
			var_14_0 = var_14_0 + arg_14_1:get_reduce_damage() * (1 - var_14_0)

			self:set_damage_record("触发buff：无视部分弹药损耗的部分", "无视部分弹药损耗的部分" .. arg_14_1:get_reduce_damage())
		end

		if arg_14_1:get_attribute().without_bullet_correct then
			var_14_0 = 1

			self:set_damage_record("触发buff：无视弹药损耗", "弹药补正都是满的" .. arg_14_1:get_reduce_damage())
		end

		self:set_damage_record("弹药补正", var_0_4("%f", var_14_0))

		return var_14_0
	end

	function arg_1_0:get_crit_value(arg_15_1, arg_15_2, arg_15_3)
		local var_15_9000
		local var_15_0 = arg_15_2.crit_repair:get_final_value() / 100

		self:set_damage_record("基础暴击", var_0_4("基础暴击率:%f", var_15_0))

		local var_15_1 = self:get_crit_rate_by_formation((self:get_crit_rate_by_love(arg_15_1, (self:get_crit_rate_by_luck(arg_15_2, var_15_0)))))

		if arg_15_3:get_attribute().change_be_crit_rate and arg_15_3:get_attribute().change_be_crit_rate ~= 0 then
			var_15_1 = var_15_1 + arg_15_3:get_attribute().change_be_crit_rate

			self:set_damage_record("触发技能:敌人被暴击率增加", "被暴击率增加" .. arg_15_3:get_attribute().change_be_crit_rate * 100 .. "总暴击率为" .. var_15_1)
		end

		local var_15_2 = self:__handle_rate(var_15_1)

		self:set_damage_record("暴击最高为0.95，最低为0.05", "当前暴击结果为" .. var_15_2)

		local var_15_3 = self:__roll_crit_rate(var_15_2)
		local var_15_4 = var_0_5.crit_multiplier.value(var_15_3)

		if arg_15_3:get_attribute().not_crit and arg_15_3:get_attribute().not_crit == true and self:__get_probability_result(arg_15_3, 1) then
			var_15_3 = false
			var_15_4 = 1

			self:set_damage_record("触发技能:不会被暴击", "不会被暴击")
		end

		if arg_15_1:get_attribute().sure_to_crit then
			var_15_3 = true
			var_15_4 = 1.5

			self:set_damage_record("触发技能:必定暴击", "必定暴击")
		end

		if arg_15_1:get_attribute().can_not_crit then
			var_15_3 = false
			var_15_4 = 1

			self:set_damage_record("触发技能:不会暴击", "不会暴击")
		end

		if arg_15_1:get_attribute().sure_to_crit_by_stage and var_0_6:judge_stage(arg_15_1:get_attribute().sure_to_crit_by_stage, self._battlefield._battle_step) then
			var_15_3 = true
			var_15_4 = 1.5

			self:set_damage_record("触发技能:在特定阶段必定暴击", "必定暴击")
		end

		if arg_15_1:get_attribute().sure_to_crit_by_num then
			arg_15_1:get_attribute().skill_num = arg_15_1:get_attribute().skill_num or {}
			arg_15_1:get_attribute().skill_num.sure_to_crit_by_num = arg_15_1:get_attribute().skill_num.sure_to_crit_by_num or {}

			if arg_15_1:get_attribute().skill_num.sure_to_crit_by_num.stage ~= self._battlefield._battle_step then
				arg_15_1:get_attribute().skill_num.sure_to_crit_by_num.num = 1
				arg_15_1:get_attribute().skill_num.sure_to_crit_by_num.stage = self._battlefield._battle_step
			else
				arg_15_1:get_attribute().skill_num.sure_to_crit_by_num.num = arg_15_1:get_attribute().skill_num.sure_to_crit_by_num.num + 1
			end

			if arg_15_1:get_attribute().sure_to_crit_by_num.num == arg_15_1:get_attribute().skill_num.sure_to_crit_by_num.num then
				var_15_3 = true
				var_15_4 = 1.5

				self:set_damage_record("触发技能:必定暴击", "必定暴击")
			end
		end

		if arg_15_3:get_attribute().in_guardian and arg_15_3:get_attribute().skill_num.guardian.crited == 1 then
			var_15_3 = false
			var_15_4 = 1

			self:set_damage_record("触发技能:守护队友时不会被暴击", "守护队友时不会被暴击")
		end

		local var_15_5 = self._battle_scene:get_attack_infallible_data()

		if var_15_5 then
			for iter_15_0, iter_15_1 in pairs(var_15_5.ship_list) do
				if arg_15_1:getID() == iter_15_1 and (arg_15_3:get_ship_ton() == 1 or arg_15_3:get_ship_ton() == 2) then
					var_15_3 = true
					var_15_4 = 1.5 + var_15_5.crit_hurt
				end
			end
		end

		if var_15_3 == true and arg_15_1:get_attribute().up_crit_hurt then
			var_15_4 = var_15_4 + arg_15_1:get_attribute().up_crit_hurt

			self:set_damage_record("触发技能:增加暴击伤害", "增加暴击伤害" .. arg_15_1:get_attribute().up_crit_hurt)
		end

		if var_15_3 == true and arg_15_1:get_attribute().change_crit_hurt_by_hp then
			var_15_4 = var_15_4 + arg_15_1:get_attribute().change_crit_hurt_by_hp.crit_hurt * math.floor(var_15_9000 / (arg_15_1:get_attribute().change_crit_hurt_by_hp.num * arg_15_1:get_attribute().hp:get_final_value()))

			self:set_damage_record("触发技能:自身每损失X%耐久值，暴击伤害变化XX%", "自身每损失X%耐久值，暴击伤害变化" .. arg_15_1:get_attribute().change_crit_hurt_by_hp.crit_hurt .. "x" .. arg_15_1:get_attribute().hp:get_final_value() - arg_15_1:get_attribute().now_hp:get_final_value())
		end

		if var_15_3 == true and arg_15_1:get_attribute().change_crit_hurt_greater_than_targer_attr then
			local var_15_6 = arg_15_1:get_attribute().change_crit_hurt_greater_than_targer_attr.attr_type

			if arg_15_1:get_attribute()[var_15_6]:get_final_value() < arg_15_3:get_attribute()[var_15_6]:get_final_value() then
				var_15_4 = var_15_4 + arg_15_1:get_attribute().change_crit_hurt_greater_than_targer_attr.crit_hurt

				self:set_damage_record("触发技能:某种攻击方式增加暴击伤害", "某种攻击方式增加暴击伤害" .. arg_15_1:get_attribute().change_crit_hurt_greater_than_targer_attr.crit_hurt)
			end
		end

		if var_15_3 == true and arg_15_1:get_attribute().skill_num.add_crit_hurt then
			for iter_15_2, iter_15_3 in ipairs(arg_15_1:get_attribute().skill_num.add_crit_hurt.effect_stage) do
				if var_0_6:judge_stage(iter_15_3, self._battlefield._battle_step) then
					var_15_4 = var_15_4 + arg_15_1:get_attribute().skill_num.add_crit_hurt.num

					self:set_damage_record("触发技能:受xxx舰种攻击在某阶段增加暴击伤害", "受xxx舰种攻击在某阶段增加暴击伤害" .. arg_15_1:get_attribute().skill_num.add_crit_hurt.num)
				end
			end
		end

		arg_15_2.is_crit = var_15_3
		self._damage_attr.is_crit = var_15_3

		if self._damage_attr.is_crit == true then
			self._damage_attr.damage_type = var_0_5.damage_type.crit

			if arg_15_1:get_attribute().ignore_battle_damage_in_crit then
				self._damage_correct = 1
			end
		end

		self:set_damage_record("暴击倍数:", var_0_4("暴击率:%f, 是否暴击:%s, 倍数:%f, 随机次数:%d", var_15_2, var_15_3, var_15_4, self._battle_random:getRandomCount()))

		return var_15_4
	end

	function arg_1_0:get_addition_atk_by_day_or_night()
		return (self._battle_scene:get_day_or_night_attack() == var_0_5.day_or_night.night or nil) and 10
	end

	function arg_1_0:get_equip_correct(arg_17_1)
		local var_17_0 = 1

		for iter_17_0, iter_17_1 in pairs((arg_17_1:get_equip_list())) do
			local var_17_2 = var_0_7.find_object_by_cid(iter_17_1._cid)

			if var_0_1(var_17_2.exclusive_cid) and var_0_1(var_17_2.exclusive_buff) then
				for iter_17_2, iter_17_3 in pairs(var_17_2.exclusive_cid) do
					if arg_17_1:get_cid() == iter_17_3 then
						for iter_17_4, iter_17_5 in pairs(var_17_2.exclusive_buff) do
							if iter_17_5.type == 9 and iter_17_5.stage then
								for iter_17_6, iter_17_7 in pairs(iter_17_5.stage) do
									if var_0_6:judge_stage(iter_17_7, self._battlefield._battle_step) then
										var_17_0 = var_17_0 * (iter_17_5.num + 1)
									end
								end
							end
						end
					end
				end
			elseif not var_0_1(var_17_2.exclusive_cid) and var_0_1(var_17_2.exclusive_buff) then
				for iter_17_8, iter_17_9 in pairs(var_17_2.exclusive_buff) do
					if iter_17_9.type == 9 and iter_17_9.stage then
						for iter_17_10, iter_17_11 in pairs(iter_17_9.stage) do
							if var_0_6:judge_stage(iter_17_11, self._battlefield._battle_step) then
								var_17_0 = var_17_0 * (iter_17_9.num + 1)
							end
						end
					end
				end
			end
		end

		return var_17_0
	end

	function arg_1_0:get_sixth_year_ship_buff(arg_18_1)
		if arg_18_1:get_side() == var_0_5.obj_side.enemy then
			return 1
		end

		local var_18_0 = 1
		local var_18_1 = arg_18_1:get_cid()

		for iter_18_0, iter_18_1 in pairs((self._battle_scene:get_six_year_ship_buff())) do
			if iter_18_1.cid == var_18_1 then
				var_18_0 = var_18_0 + var_0_5:get_six_ship_level_dmg_rate(iter_18_1.level - 1)
			end
		end

		if var_18_0 > 1 then
			self:set_damage_record("强化buff最终伤害倍率", var_18_0)
		end

		return var_18_0
	end

	function arg_1_0:get_hit_rate_by_formation(arg_19_1)
		self:set_damage_record("命中率阵型补正", var_0_4("命中率前:%f,命中率后:%f", arg_19_1, self._formation_hit_addition / self._formation_miss_addition * arg_19_1))

		return self._formation_hit_addition / self._formation_miss_addition * arg_19_1
	end

	function arg_1_0:get_hit_rate_by_radar(arg_20_1)
		self:set_damage_record("命中率索敌补正", var_0_4("命中率前:%f, 命中率后:%f", arg_20_1, arg_20_1 + self._radar_hit - self._radar_miss))

		return arg_20_1 + self._radar_hit - self._radar_miss
	end

	function arg_1_0:get_hit_rate_by_equips_effect(arg_21_1, arg_21_2)
		if not arg_21_1 then
			return
		end

		for iter_21_0, iter_21_1 in pairs(arg_21_1._equip_list) do
			local var_21_0 = var_0_7.find_object_by_cid(iter_21_1._cid)

			if var_0_1(var_21_0.exclusive_cid) and var_0_1(var_21_0.exclusive_buff) then
				for iter_21_2, iter_21_3 in pairs(var_21_0.exclusive_cid) do
					if iter_21_3 == arg_21_1:get_cid() then
						for iter_21_4, iter_21_5 in pairs(var_21_0.exclusive_buff) do
							if not iter_21_5.equip_cid and iter_21_5.type == 6 then
								if iter_21_5.stage and var_0_1(iter_21_5.stage) then
									for iter_21_6, iter_21_7 in pairs(iter_21_5.stage) do
										for iter_21_8, iter_21_9 in pairs(var_0_5.trigger_type) do
											if iter_21_9 == iter_21_7 and var_0_6:judge_stage(iter_21_7, self._battlefield._battle_step) then
												arg_21_2 = arg_21_2 + iter_21_5.num / 100

												self:set_damage_record("我方携带限定船只专属装备后我方命中率阶段增加", var_0_4("当前命中率为%f,增加率=%f, 之前命中率为%f", arg_21_2, iter_21_5.num / 100, arg_21_2))
											end
										end
									end
								else
									arg_21_2 = arg_21_2 + iter_21_5.num / 100

									self:set_damage_record("我方携带限定船只专属装备后我方命中率全阶段增加", var_0_4("当前命中率为%f,增加率=%f, 之前命中率为%f", arg_21_2, iter_21_5.num / 100, arg_21_2))
								end
							end
						end
					end
				end
			elseif not var_0_1(var_21_0.exclusive_cid) and var_0_1(var_21_0.exclusive_buff) then
				for iter_21_10, iter_21_11 in pairs(var_21_0.exclusive_buff) do
					if not iter_21_11.equip_cid and iter_21_11.type == 6 then
						if iter_21_11.stage and var_0_1(iter_21_11.stage) then
							for iter_21_12, iter_21_13 in pairs(iter_21_11.stage) do
								for iter_21_14, iter_21_15 in pairs(var_0_5.trigger_type) do
									if iter_21_15 == iter_21_13 and var_0_6:judge_stage(iter_21_13, self._battlefield._battle_step) then
										arg_21_2 = arg_21_2 + iter_21_11.num / 100

										self:set_damage_record("我方携带非限定船只专属装备后我方命中率阶段增加", var_0_4("当前命中率为%f,增加率=%f, 之前命中率为%f", arg_21_2, iter_21_11.num / 100, arg_21_2))
									end
								end
							end
						else
							arg_21_2 = arg_21_2 + iter_21_11.num / 100

							self:set_damage_record("我方携带非限定船只专属装备后我方命中率全阶段增加", var_0_4("当前命中率为%f,增加率=%f, 之前命中率为%f", arg_21_2, iter_21_11.num / 100, arg_21_2))
						end
					end
				end
			end
		end

		local var_21_3 = arg_21_1:get_attribute()

		if self._attack_type == "normal_attack" then
			local var_21_4 = var_21_3.normal_attack_hit:get_final_value()

			if var_21_4 ~= 0 then
				self:set_damage_record("特殊装备效果炮击战命中率增加", var_0_4("命中率前:%f, 命中率后:%f", arg_21_2, arg_21_2 + var_21_4))

				return arg_21_2 + var_21_4
			end
		end

		if self._attack_type == "aircraft_attack" then
			local var_21_5 = var_21_3.aircraft_torpedo_plane_hit:get_final_value()

			if var_21_5 ~= 0 and self._plane_type == var_0_5.equip_type.torpedo_plane then
				self:set_damage_record("特殊装备效果鱼雷机命中率增加", var_0_4("命中率前:%f, 命中率后:%f", arg_21_2, arg_21_2 + var_21_5))

				return arg_21_2 + var_21_5
			end
		end

		if self._attack_type == "torpedo_attack" then
			local var_21_6 = var_21_3.torpedo_attack_hit:get_final_value()

			if var_21_6 ~= 0 then
				self:set_damage_record("特殊装备效果鱼雷阶段命中增加", var_0_4("命中率前:%f, 命中率后:%f", arg_21_2, arg_21_2 + var_21_6))

				return arg_21_2 + var_21_6
			end
		end

		return arg_21_2
	end

	function arg_1_0:get_hit_rate_by_love(arg_22_1, arg_22_2)
		if not arg_22_1:get_love() then
			self:set_damage_record("该船只没有好感度加成，不会走好感的命中率加成：", var_0_4("船只名称%s", arg_22_1:get_ship_name()))

			return arg_22_2
		else
			self:set_damage_record("该船只的好感度情况：", "有好感度：" .. arg_22_1:get_love())

			arg_22_2 = arg_22_2 + (arg_22_1:get_love() - 5000) / 1000 / 100
		end

		self:set_damage_record("好感对于命中率的加成", var_0_4("命中率前:%f, 命中率后:%f", arg_22_2, arg_22_2))

		return arg_22_2
	end

	function arg_1_0:get_hit_rate_by_love_miss(arg_23_1, arg_23_2)
		if not arg_23_1:get_love() then
			do return arg_23_2 end

			arg_23_2 = arg_23_2 - (arg_23_1:get_love() - 5000) / 1000 / 100
		end

		self:set_damage_record("敌方好感对于命中率的削弱", var_0_4("加成前命中:%f, 加成后命中:%f", arg_23_2, arg_23_2))

		return arg_23_2
	end

	function arg_1_0:get_bomber_power_by_equips_effect(arg_24_1, arg_24_2)
		if not arg_24_1 then
			return
		end

		if self._attack_type == "aircraft_attack" then
			local var_24_0 = arg_24_1:get_attribute().aircraft_attack_bomber:get_final_value()

			if var_24_0 ~= 1 then
				self:set_damage_record("特殊装备效果开幕轰炸攻击力增加", var_0_4("攻击力前:%f, 攻击力后:%f", arg_24_2, arg_24_2 * var_24_0))

				return arg_24_2 * var_24_0
			end
		end

		return arg_24_2
	end

	function arg_1_0:get_torpedo_power_by_equips_effect(arg_25_1, arg_25_2)
		if not arg_25_1 then
			return
		end

		if self._attack_type == "aircraft_attack" then
			local var_25_0 = arg_25_1:get_attribute().aircraft_attack_torpedo:get_final_value()

			if var_25_0 ~= 1 then
				self:set_damage_record("特殊装备效果开幕鱼雷机攻击力增加", var_0_4("攻击力前:%f, 攻击力后:%f", arg_25_2, arg_25_2 * var_25_0))

				return arg_25_2 * var_25_0
			end
		end

		return arg_25_2
	end

	function arg_1_0:get_hit_rate_by_enemy_equips_effect(arg_26_1, arg_26_2)
		if not arg_26_1 then
			return
		end

		if arg_26_1 and arg_26_1:get_side() == var_0_5.obj_side.player then
			for iter_26_0, iter_26_1 in pairs(arg_26_1._equip_list) do
				local var_26_0 = var_0_7.find_object_by_cid(iter_26_1._cid)

				if var_0_1(var_26_0.exclusive_cid) and var_0_1(var_26_0.exclusive_buff) then
					for iter_26_2, iter_26_3 in pairs(var_26_0.exclusive_cid) do
						if iter_26_3 == arg_26_1:get_cid() then
							for iter_26_4, iter_26_5 in pairs(var_26_0.exclusive_buff) do
								if not iter_26_5.equip_cid and iter_26_5.type == 7 then
									if iter_26_5.stage and var_0_1(iter_26_5.stage) then
										for iter_26_6, iter_26_7 in pairs(iter_26_5.stage) do
											for iter_26_8, iter_26_9 in pairs(var_0_5.trigger_type) do
												if iter_26_9 == iter_26_7 and var_0_6:judge_stage(iter_26_7, self._battlefield._battle_step) then
													arg_26_2 = arg_26_2 - iter_26_5.num / 100

													self:set_damage_record("敌人携带专属装备后我方阶段命中率减少", var_0_4("当前命中率为%f,减少率=%f, 之前的命中率%f", arg_26_2, iter_26_5.num / 100, arg_26_2))
												end
											end
										end
									else
										arg_26_2 = arg_26_2 - iter_26_5.num / 100

										self:set_damage_record("敌人携带专属装备后我方全阶段命中率减少", var_0_4("当前命中率为%f,减少率=%f, 之前的命中率%f", arg_26_2, iter_26_5.num / 100, arg_26_2))
									end
								end
							end
						end
					end
				elseif not var_0_1(var_26_0.exclusive_cid) and var_0_1(var_26_0.exclusive_buff) then
					for iter_26_10, iter_26_11 in pairs(var_26_0.exclusive_buff) do
						if not iter_26_11.equip_cid and iter_26_11.type == 7 then
							if iter_26_11.stage and var_0_1(iter_26_11.stage) then
								for iter_26_12, iter_26_13 in pairs(iter_26_11.stage) do
									for iter_26_14, iter_26_15 in pairs(var_0_5.trigger_type) do
										if iter_26_15 == iter_26_13 and var_0_6:judge_stage(iter_26_13, self._battlefield._battle_step) then
											arg_26_2 = arg_26_2 - iter_26_11.num / 100

											self:set_damage_record("敌人携带专属装备后我方阶段命中率减少", var_0_4("当前命中率为%f,减少率=%f, 之前的命中率%f", arg_26_2, iter_26_11.num / 100, arg_26_2))
										end
									end
								end
							else
								arg_26_2 = arg_26_2 - iter_26_11.num / 100

								self:set_damage_record("敌人携带专属装备后我方全阶段命中率减少", var_0_4("当前命中率为%f,减少率=%f, 之前的命中率%f", arg_26_2, iter_26_11.num / 100, arg_26_2))
							end
						end
					end
				end
			end
		end

		if self._attack_type == "missile_attack" then
			local var_26_3 = arg_26_1:get_attribute().reduce_enemy_missile_hit:get_final_value()

			if var_26_3 ~= 0 then
				self:set_damage_record("对方装备特殊效果导弹战命中率降低", var_0_4("命中率前:%f,命中率后:%f", arg_26_2, arg_26_2 - var_26_3))

				return arg_26_2 - var_26_3
			end
		end

		if self._attack_type == "aircraft_attack" and (arg_26_1:get_attribute().down_air_by_enemy or arg_26_1:get_attribute().down_air_by_player) then
			local var_26_4 = arg_26_1:get_attribute().down_air_by_enemy
			local var_26_5 = arg_26_1:get_attribute().down_air_by_player

			if var_26_4 then
				self:set_damage_record("敌方装备buff类装备让玩家方航空战所有命中率降低", var_0_4("降低值:%f,命中率前:%f,命中率后:%f", var_26_4.num, arg_26_2, arg_26_2 + var_26_4.num))

				return arg_26_2 + var_26_4.num
			elseif var_26_5 then
				self:set_damage_record("玩家方装备buff类装备让敌方航空战所有命中率降低", var_0_4("降低值:%f,命中率前:%f,命中率后:%f", var_26_5.num, arg_26_2, arg_26_2 + var_26_5.num))

				return arg_26_2 + var_26_5.num
			end
		end

		return arg_26_2
	end

	function arg_1_0:get_hit_rate_by_aircontrol(arg_27_1)
		if self._attack_type ~= "aircraft_attack" then
			return arg_27_1
		end

		self:set_damage_record("命中率制空状态补正", var_0_4("命中率前:%f, 命中率后:%f", arg_27_1, self._aircontrol_hit + arg_27_1))

		return arg_27_1 + self._aircontrol_hit
	end

	function arg_1_0:get_hit_rate_by_air_love_hit(arg_28_1, arg_28_2)
		if self._attack_type ~= "aircraft_attack" then
			return arg_28_1
		end

		if not arg_28_2:get_love() then
			do return arg_28_1 end

			arg_28_1 = arg_28_1 + (arg_28_2:get_love() - 5000) / 1000 / 100
		end

		self:set_damage_record("我方好感对于航空战命中率的加成", var_0_4("加成前命中:%f, 加成后命中:%f", arg_28_1, arg_28_1))

		return arg_28_1
	end

	function arg_1_0:get_hit_rate_by_air_love_miss(arg_29_1, arg_29_2)
		if self._attack_type ~= "aircraft_attack" then
			return arg_29_1
		end

		if not arg_29_2:get_love() then
			do return arg_29_1 end

			arg_29_1 = arg_29_1 - (arg_29_2:get_love() - 5000) / 1000 / 100
		end

		self:set_damage_record("敌方好感对于航空战命中率的削弱", var_0_4("加成前命中:%f, 加成后命中:%f", arg_29_1, arg_29_1))

		return arg_29_1
	end

	function arg_1_0:get_attack_correct_by_shiptype(arg_30_1, arg_30_2, arg_30_3)
		self._attack_type = self._attack_type or "normal_attack"

		if not arg_30_1 or not arg_30_2 then
			return arg_30_3
		end

		if self._attack_type == "normal_attack" then
			local var_30_0 = 1 - math.max(0, (arg_30_1:get_ship_ton() - arg_30_2:get_ship_ton()) * 0.1)

			self:set_damage_record("命中率船型补正2:", var_0_4("命中率前:%f, 命中率后:%f", arg_30_3, arg_30_3 * var_30_0))

			return arg_30_3 * var_30_0
		end

		if self._attack_type == "aircraft_attack" or self._attack_type == "torpedo_attack" then
			local var_30_1 = self:__get_hit_rate_attach_by_shipton((arg_30_2:get_ship_ton()))

			self:set_damage_record("命中率船型补正攻击对象:", var_0_4("命中率前:%f, 命中率后:%f", arg_30_3, arg_30_3 * var_30_1))

			return arg_30_3 * var_30_1
		end

		return arg_30_3
	end

	function arg_1_0:get_formation_correct_additional(arg_31_1, arg_31_2, arg_31_3)
		if not arg_31_1 or not arg_31_2 then
			return arg_31_3
		end

		local var_31_0 = 0
		local var_31_1 = self._battle_scene:get_player_formation()

		if arg_31_1:get_side() == var_0_5.obj_side.player and self._battle_scene:get_enemy_formation() == var_0_5.formation_type.double then
			var_31_0 = -0.05
		end

		if arg_31_1:get_side() == var_0_5.obj_side.enemy and var_0_5.formation_type.double == self._battle_scene:get_player_formation() then
			var_31_0 = -0.05
			var_31_1 = self._battle_scene:get_enemy_formation()
		end

		if self._battlefield._battle_step == var_0_5.trigger_type.second_normal_attack and var_31_1 == var_0_5.formation_type.single then
			var_31_0 = 0.05

			self:set_damage_record("单纵附加效果", var_0_4("命中率前:%f, 命中率后:%f", arg_31_3, arg_31_3 + 0.05))
		end

		if var_31_0 == -0.05 then
			self:set_damage_record("由于对方复纵的影响", var_0_4("命中率前:%f, 命中率后:%f", arg_31_3, arg_31_3 + var_31_0))
		end

		return arg_31_3 + var_31_0
	end

	function arg_1_0:get_miss_by_t_formation(arg_32_1, arg_32_2, arg_32_3)
		if self._attack_type == "aircraft_attack" or not arg_32_1 or not arg_32_2 then
			return arg_32_3
		end

		local var_32_0 = self._battle_scene:get_player_formation()
		local var_32_1

		if ((arg_32_1:get_side() == var_0_5.obj_side.enemy or nil) and self._battle_scene:get_enemy_formation()) ~= var_0_5.formation_type.trapezoidal then
			do return arg_32_3 end

			var_32_1 = self._battle_obj_mgr:get_ships_by_side(arg_32_2:get_side())
		end

		for iter_32_0, iter_32_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_32_1:get_side()))) do
			local var_32_2
			local var_32_3

			if iter_32_1._battle_scene:get_fight_type() == var_0_5.fight_type.plot_main then
				var_32_2 = iter_32_1:get_ship_type()
			else
				var_32_3 = iter_32_1:get_ship_guard_type()
			end

			if (var_32_3 == 2 or ((var_32_2 == 2 or var_32_2 == 7 or var_32_2 == 8 or var_32_2 == 9 or var_32_2 == 10 or var_32_2 == 11 or var_32_2 == 12 or var_32_2 == 16 or var_32_2 == 23 or var_32_2 == 24 or var_32_2 == 28 or nil) and true) == true) and iter_32_1:get_is_alive() then
				local var_32_5 = iter_32_1:get_index()

				while var_32_5 == 0 or var_32_1[var_32_5] and not var_32_1[var_32_5]:is_submarine() do
					if var_32_1[var_32_5] and not var_32_1[var_32_5].is_be_lock and var_32_1[var_32_5]:get_is_alive() then
						var_32_1[var_32_5].is_be_lock = true

						break
					end

					var_32_5 = var_32_5 - 1
				end
			end
		end

		if arg_32_2.is_be_lock then
			self:set_damage_record("梯形阵附加效果", var_0_4("闪避前:%f, 闪避后:%f", arg_32_3, arg_32_3 - arg_32_3 * 0.4))

			return arg_32_3 - arg_32_3 * 0.4
		end

		return arg_32_3
	end

	function arg_1_0:get_crit_rate_by_formation(arg_33_1)
		self:set_damage_record("暴击率阵型补正", var_0_4("暴击率前:%f,暴击率后:%f", arg_33_1, arg_33_1 + self._formation_crit + self._formation_crited))

		return arg_33_1 + self._formation_crit + self._formation_crited
	end

	function arg_1_0:get_crit_rate_by_luck(arg_34_1, arg_34_2)
		local var_34_0 = arg_34_1.luck:get_final_value() * 0.16 / 100

		self:set_damage_record("暴击率运气补正", var_0_4("暴击率前:%f, 暴击率后:%f", arg_34_2, arg_34_2 + var_34_0))

		return arg_34_2 + var_34_0
	end

	function arg_1_0:get_crit_rate_by_love(arg_35_1, arg_35_2)
		if not arg_35_1 then
			return arg_35_2
		end

		local var_35_0 = 0

		if arg_35_1:get_side() == var_0_5.obj_side.player then
			var_35_0 = (arg_35_1:get_love() - 5000) / 1000 / 100
		end

		self:set_damage_record("暴击率好感度补正", var_0_4("暴击率前:%f, 暴击率后:%f", arg_35_2, arg_35_2 + var_35_0))

		return arg_35_2 + var_35_0
	end

	function arg_1_0.__handle_rate(arg_36_0, arg_36_1)
		if arg_36_1 > 0.95 then
			return 0.95
		elseif arg_36_1 < 0.05 then
			return 0.05
		end

		return arg_36_1
	end

	function arg_1_0:__roll_crit_rate(arg_37_1)
		if arg_37_1 > 0.95 then
			arg_37_1 = 0.95
		elseif arg_37_1 < 0.05 then
			arg_37_1 = 0.05
		end

		local var_37_0 = self._battle_random:randRange(1, 100)

		self:set_damage_record("暴击率roll点", var_0_4("roll值:%f", var_37_0))

		return var_37_0 <= arg_37_1 * 100
	end

	function arg_1_0:__roll_hit_rate(arg_38_1)
		if arg_38_1 > 0.95 then
			arg_38_1 = 0.95
		elseif arg_38_1 < 0.05 then
			arg_38_1 = 0.05
		end

		if self._is_beat_back then
			arg_38_1 = 1
		end

		local var_38_0 = self._battle_random:randRange(1, 100)

		self:set_damage_record("随机roll的命中值，用于和传入的命中大小比", var_38_0)
		self:__set_start_damage_nil(var_38_0 > arg_38_1 * 100)

		return var_38_0 > arg_38_1 * 100
	end

	function arg_1_0:__get_hit_rate_attach_by_shipton(arg_39_1)
		local var_39_0 = 1
		local var_39_1 = {
			small = {
				value = 1,
				hit_rate = 0.5
			},
			middle = {
				value = 2,
				hit_rate = 0.75
			},
			big = {
				value = 3,
				hit_rate = 1
			}
		}

		if self._attack_type == "torpedo_attack" then
			var_39_1.small = {
				value = 1,
				hit_rate = 0.6
			}
			var_39_1.middle = {
				value = 2,
				hit_rate = 0.8
			}
		end

		for iter_39_0, iter_39_1 in pairs(var_39_1) do
			if iter_39_1.value == arg_39_1 then
				var_39_0 = iter_39_1.hit_rate
			end
		end

		return var_39_0
	end

	function arg_1_0:__set_start_damage_nil(arg_40_1)
		if arg_40_1 then
			self:set_damage_record("在__roll_hit_rate这里如果没有命中", "前面加入的固伤伤害置空")

			self._damage_attr.damage = 0
		end
	end
end

function var_0_0.extend_obj(arg_41_0)
	arg_41_0._direction_correct = 1
	arg_41_0._damage_correct = 1
	arg_41_0._radar_hit = 0
	arg_41_0._radar_miss = 0
	arg_41_0._aircontrol_power = 1
	arg_41_0._aircontrol_hit = 1
	arg_41_0._formation_power_addition = 1
	arg_41_0._formation_hit_addition = 0
	arg_41_0._formation_miss_addition = 0
	arg_41_0._formation_crit = 0
	arg_41_0._formation_crited = 0
	arg_41_0._aircontrol_power = 1
	arg_41_0._aircontrol_hit = 1
end

return var_0_0
