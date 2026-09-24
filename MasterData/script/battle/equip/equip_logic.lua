local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = gameconfig.equip_config
local var_0_3 = gameenum.battle_type

lx.define_class("equip_logic", function(arg_1_0)
	function arg_1_0:get_owner()
		return self._owner
	end

	function arg_1_0:get_equip_type()
		return self._equip_type
	end

	function arg_1_0:get_equip_bore_type()
		return self._equip_bore_type
	end

	function arg_1_0:get_equip_air_def_rate()
		return self._equip_air_def_rate
	end

	function arg_1_0.set_equip_second_type(arg_6_0, arg_6_1)
		arg_6_0._equip_second_type = arg_6_1
	end

	function arg_1_0:get_equip_second_type()
		return self._equip_second_type
	end

	function arg_1_0:get_carry_type()
		return self._carry_type
	end

	function arg_1_0:get_index()
		return self._index
	end

	function arg_1_0:is_plane()
		return self._equip_type == var_0_3.equip_type.torpedo_plane or self._equip_type == var_0_3.equip_type.fighter or self._equip_type == var_0_3.equip_type.bomber
	end

	function arg_1_0:is_plane_or_spyplane(arg_11_1)
		return self._equip_type == var_0_3.equip_type.torpedo_plane or self._equip_type == var_0_3.equip_type.fighter or self._equip_type == var_0_3.equip_type.bomber or self._equip_type == var_0_3.equip_type.spy_plane and arg_11_1
	end

	function arg_1_0:is_fighter()
		return self._equip_type == var_0_3.equip_type.fighter
	end

	function arg_1_0:is_bomber_or_torpedoplane()
		return self._equip_type == var_0_3.equip_type.torpedo_plane or self._equip_type == var_0_3.equip_type.bomber
	end

	function arg_1_0:is_bomber_torpedoplane_or_spyplane()
		return self._equip_type == var_0_3.equip_type.torpedo_plane or self._equip_type == var_0_3.equip_type.bomber or self._equip_type == var_0_3.equip_type.spy_plane
	end

	function arg_1_0:get_left_plane_num()
		local var_15_0 = 0

		if self:is_plane() then
			var_15_0 = var_15_0 + self._num
		end

		return var_15_0
	end

	function arg_1_0:get_equip_cid()
		return self._cid
	end

	function arg_1_0:get_air_def()
		return self._air_def
	end

	function arg_1_0.set_equip_num(arg_18_0, arg_18_1)
		arg_18_0._num = arg_18_1 < 0 and 0 or arg_18_1
	end

	function arg_1_0.set_real_equip_num(arg_19_0, arg_19_1)
		arg_19_0._real_num = arg_19_1 < 0 and 0 or arg_19_1
	end

	function arg_1_0:get_equip_num()
		return self._num
	end

	function arg_1_0:get_real_equip_num()
		return self._real_num
	end

	function arg_1_0:get_missile_num()
		if self._equip_type == var_0_3.equip_type.anti_ship_missile then
			return self._num
		end

		return 0
	end

	function arg_1_0:equip_missile_launcher()
		return self._equip_type == var_0_3.equip_type.anti_ship_missile_launcher
	end

	function arg_1_0:equip_tmd_missile_launcher()
		return self._equip_type == var_0_3.equip_type.air_defense_missile_launcher
	end

	function arg_1_0:get_tmd_missile_num()
		if self._equip_type == var_0_3.equip_type.air_defense_missile then
			return self._num
		end

		return 0
	end

	function arg_1_0:get_night_missile_num()
		if self._equip_type == var_0_3.equip_type.anti_ship_missile or self._equip_type == var_0_3.equip_type.air_defense_missile then
			return self._num
		end

		return 0
	end

	function arg_1_0:equip_tmd_missile_launcher()
		return self._equip_type == var_0_3.equip_type.air_defense_missile_launcher
	end

	function arg_1_0:get_fly_num(arg_28_1)
		if not arg_28_1 then
			arg_28_1 = self._owner:get_attribute().atk:get_final_value()
			arg_28_1 = arg_28_1 > 0 and arg_28_1 or 0

			if self._owner._battle_scene:get_add_attr_by_ship_number_data() then
				local var_28_0 = self._owner._battle_scene:get_add_attr_by_ship_number_data()

				for iter_28_0, iter_28_1 in pairs(var_28_0.ship_list) do
					if self._owner:getID() == iter_28_1 and var_28_0.attr_type == "atk" then
						arg_28_1 = arg_28_1 + var_28_0.num

						break
					end
				end
			end
		end

		local var_28_2 = self._owner:get_ship_type()

		return (math.min(self._num, 3 + math.floor(arg_28_1 / ((var_28_2 == var_0_3.ship_type.aviation_battle_ship or var_28_2 == var_0_3.ship_type.aviation_cruiser or var_28_2 == var_0_3.ship_type.fortress or var_28_2 == var_0_3.ship_type.airport or var_28_2 == var_0_3.ship_type.port or var_28_2 == var_0_3.ship_type.aviation_cruiser_can_air or var_28_2 == var_0_3.ship_type.Coordination_ship or var_28_2 == var_0_3.ship_type.flag_ship or nil) and 10))))
	end

	function arg_1_0.set_air_def_correct(arg_29_0, arg_29_1)
		arg_29_0._air_def_correct = arg_29_1 or 0
	end

	function arg_1_0:get_air_def_correct()
		return self._air_def_correct
	end

	function arg_1_0:init(arg_31_1, arg_31_2, arg_31_3)
		local var_31_0 = var_0_2.find_object_by_cid(arg_31_1.id)

		self._equip_type = var_31_0.type
		self._equip_bore_type = var_31_0.bore_type
		self._cid = arg_31_1.id
		self._num = arg_31_1.num and arg_31_1.num or (self._equip_type == var_0_3.equip_type.anti_ship_missile or self._equip_type == var_0_3.equip_type.air_defense_missile) and arg_31_1.missile_slot[arg_31_2] or self:is_plane() and arg_31_1.capacity_slot[arg_31_2] or 0
		self._equip_air_def_rate = var_31_0.air_def_rate == 0 and 1 or var_31_0.air_def_rate
		self._air_def_correct = var_31_0.air_def_correct or 0
		self._air_def = var_31_0.air_def
		self._carry_type = arg_31_1.carry_type
		self._index = arg_31_2

		self:__init_equip_attribute(var_31_0)
	end

	function arg_1_0:add_equip_attribute(arg_32_1, arg_32_2)
		if not arg_32_1 or not arg_32_2 then
			return
		end

		if self._equip_base_attribute[arg_32_1] then
			self._equip_base_attribute[arg_32_1] = self._equip_base_attribute[arg_32_1] + arg_32_2
		end
	end

	function arg_1_0:set_equip_attribute(arg_33_1, arg_33_2)
		if not arg_33_1 or not arg_33_2 then
			return
		end

		self._equip_base_attribute[arg_33_1] = arg_33_2
	end

	function arg_1_0:get_equip_attribute(arg_34_1)
		if not arg_34_1 then
			return 0
		end

		return self._equip_base_attribute[arg_34_1] or 0
	end

	function arg_1_0:get_equip_attrs()
		return self._equip_base_attribute
	end

	function arg_1_0.set_equip_carry_other_attribute(arg_36_0, arg_36_1)
		arg_36_0._append_equip_type = arg_36_1
	end

	function arg_1_0:get_equip_carry_other_attribute()
		return self._append_equip_type
	end

	function arg_1_0.__get_equip_type(arg_38_0, arg_38_1, arg_38_2)
		arg_38_0._equip_type = var_0_3.equip_type[arg_38_2[arg_38_1]]
	end

	function arg_1_0:__init_equip_attribute(arg_39_1)
		for iter_39_0, iter_39_1 in pairs(var_0_3.equip_attribute_type) do
			self._equip_base_attribute[iter_39_1] = arg_39_1[iter_39_1] or 0
		end
	end
end)

function var_0_0.create(arg_40_0, arg_40_1)
	local var_40_0 = var_0_1.class("equip_logic")

	var_40_0._equip_type = nil
	var_40_0._carry_type = nil
	var_40_0._num = 0
	var_40_0._cid = 0
	var_40_0._owner = arg_40_1
	var_40_0._index = 0
	var_40_0._equip_base_attribute = {}
	var_40_0._equip_air_def_rate = 1
	var_40_0._is_shout = false

	return var_40_0
end

return var_0_0
