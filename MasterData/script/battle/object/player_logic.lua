local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = table.insert
local var_0_3 = gameenum.battle_type
local var_0_4 = gameconfig.ship_config
local var_0_5 = gamecore.character_logic
local var_0_6 = gamecore.equip_logic

lx.define_class("player_logic", function(arg_1_0)
	function arg_1_0:__onExecute_attack(arg_2_1)
		self:process(self._battle_event.event.attack, arg_2_1)
	end

	function arg_1_0:__init_obj(arg_3_1)
		local var_3_0 = var_0_4.find_object_by_cid(arg_3_1.cid)

		arg_3_1.hp = var_3_0.hp
		arg_3_1.attrs.hp = var_3_0.hp

		self:set_ship_type(var_3_0.type)
		self:set_side(var_0_3.obj_side.player)
		self:set_cid(arg_3_1.cid)
		self:set_level(arg_3_1.level)
		self:set_pos(arg_3_1.pos)
		self:set_oil(arg_3_1.oil)
		self:set_ammo(arg_3_1.ammo)
		self:set_index(arg_3_1.index)
		self:set_love(arg_3_1.love)
		self:set_luck(arg_3_1.attrs.luck)
		self:set_ship_ton(var_3_0.ship_ton)
		self:set_night_attack_type(var_3_0.night_atk_type)
		self:set_country(var_3_0.country)
		self:set_pic_id(var_3_0.pic_id)
		self:set_character_id(arg_3_1.character_id)
		self:set_skin_id(arg_3_1.skin_id)
		self:set_is_alive(arg_3_1.attrs.now_hp > 0)
		self:set_init_hp(arg_3_1.attrs.now_hp)
		self:set_tactics(arg_3_1.tactics)
		self:set_learning_tactic(arg_3_1.learning_tactic)
		self:set_ship_speed(arg_3_1.speed)
		self:set_ship_guard_type(var_3_0.guard_type)
		self:set_ship_name(var_3_0.title)

		self._kill_npc = {}
		self._max_oil = 10
		self._max_ammo = 10
		self.skill_num = {}
		self._equip_list = self._equip_list or {}

		for iter_3_0, iter_3_1 in pairs(arg_3_1.equips) do
			if iter_3_1.id ~= 0 then
				local var_3_1 = var_0_6:create(self)

				var_3_1:init(iter_3_1, iter_3_0, arg_3_1.attrs.atk)
				var_0_2(self._equip_list, var_3_1)
			end
		end

		self._skill_data = arg_3_1

		self:__init_player_attribute(var_0_1.clone_table(arg_3_1.attrs), arg_3_1.intensify, arg_3_1.marry)
		self:set_reduce_hp(self:get_attribute().hp:get_final_value() - arg_3_1.attrs.now_hp)
		self:set_is_ignore_damage_protect(self:is_lowhp())
		self:process(self._battle_event.event.register)
	end

	gamecore.extend_method(arg_1_0)
end, "character_logic")

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_1.class("player_logic", var_0_5:inherit())

	gamecore.extend_obj(var_4_0)

	return var_4_0
end

return var_0_0
