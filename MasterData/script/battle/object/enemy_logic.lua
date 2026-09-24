local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = table.insert
local var_0_3 = gameenum.battle_type
local var_0_4 = gameconfig.monster_config
local var_0_5 = gamecore.character_logic
local var_0_6 = gamecore.equip_logic
local var_0_7 = gameconfig.ship_config
local var_0_8 = gameconfig.skill_config

lx.define_class("enemy_logic", function(arg_1_0)
	function arg_1_0:__onExecute_attack(arg_2_1)
		self:process(self._battle_event.event.attack, arg_2_1)
	end

	function arg_1_0:__init_obj(arg_3_1)
		local var_3_0
		local var_3_1

		self._monster_type = arg_3_1.monster_type

		if arg_3_1.monster_type == var_0_3.enemy_type.monster or arg_3_1.monster_type == var_0_3.enemy_type.robot then
			var_3_0 = var_0_4.find_object_by_id(arg_3_1.cid)
			var_3_1 = var_3_0.equipment

			local var_3_2 = var_0_8.find_object_by_skill_id(arg_3_1.skill_id) or {}
			local var_3_3 = {}

			var_3_3.skill = var_3_2.skill_type or 0
			var_3_3.skill_level = var_3_2.skill_level or 0
			var_3_3.skill_id = var_3_2.skill_id or 0
			self._skill_data = var_3_3
		elseif arg_3_1.monster_type == var_0_3.enemy_type.player then
			var_3_0 = var_0_7.find_object_by_cid(arg_3_1.cid)
			var_3_1 = arg_3_1.equips
			var_3_0.oil = 200
			var_3_0.ammo = 200

			local var_3_4 = {}

			var_3_4.skill = arg_3_1.skill or 0
			var_3_4.skill_level = arg_3_1.skill_level or 0
			var_3_4.skill_id = arg_3_1.skill_id or 0
			self._skill_data = var_3_4
		end

		arg_3_1.hp = var_3_0.hp

		self:set_ship_type(var_3_0.type)
		self:set_side(var_0_3.obj_side.enemy)
		self:set_cid(arg_3_1.cid)
		self:set_level(arg_3_1.level)
		self:set_pos(arg_3_1.pos)
		self:set_oil(arg_3_1.oil)
		self:set_ammo(arg_3_1.ammo)
		self:set_index(arg_3_1.index)
		self:set_love(arg_3_1.love)
		self:set_ship_ton(var_3_0.ship_ton)
		self:set_night_attack_type(var_3_0.night_atk_type)
		self:set_country(var_3_0.country)
		self:set_pic_id(var_3_0.pic_id)
		self:set_character_id(arg_3_1.character_id)
		self:set_skin_id(arg_3_1.skin_id)
		self:set_is_alive(arg_3_1.hp > 0)
		self:set_reduce_hp(0)

		if arg_3_1.now_hp then
			self:set_reduce_hp(arg_3_1.hp - arg_3_1.now_hp)
		end

		if arg_3_1.tactics then
			self:set_tactics(arg_3_1.tactics)
		end

		self:set_ship_guard_type(var_3_0.guard_type or var_0_3:get_ship_guard_type(self._ship_type))
		self:set_enemy_type(arg_3_1.monster_type)
		self:set_enemy_collection_data(arg_3_1.enemy_collectionbuff)
		self:set_ship_name(var_3_0.title)

		self._kill_npc = {}
		self._max_oil = 10
		self._max_ammo = 10
		self._equip_list = self._equip_list or {}

		for iter_3_0, iter_3_1 in pairs(var_3_1) do
			local var_3_5 = var_0_6:create(self)

			if arg_3_1.monster_type == var_0_3.enemy_type.monster or arg_3_1.monster_type == var_0_3.enemy_type.robot then
				if iter_3_1 ~= 0 then
					var_3_5:init({
						id = iter_3_1,
						capacity_slot = var_3_0.capacity_slot,
						missile_slot = var_3_0.missile_slot
					}, iter_3_0, var_3_0.atk)
					var_0_2(self._equip_list, var_3_5)
				end
			elseif arg_3_1.monster_type == var_0_3.enemy_type.player and iter_3_1.id ~= 0 then
				var_3_5:init(iter_3_1, iter_3_0, var_3_0.atk)
				var_0_2(self._equip_list, var_3_5)
			end
		end

		self:__init_enemy_attribute(var_0_1.clone_table(arg_3_1))
		self:set_is_ignore_damage_protect(true)
		self:set_init_hp(self._attribute.hp:get_final_value())

		if arg_3_1.now_hp then
			self:set_init_hp(arg_3_1.now_hp)
			self:set_is_alive(arg_3_1.now_hp > 0)
		end

		self:process(self._battle_event.event.register)
	end

	gamecore.extend_method(arg_1_0)
end, "character_logic")

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_1.class("enemy_logic", var_0_5:inherit())

	gamecore.extend_obj(var_4_0)

	return var_4_0
end

return var_0_0
