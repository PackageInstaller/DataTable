local Base = import("character.base.base_monster")
local CommonMonster = import("common.monster")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.target = nil
  self.part_timer = 0
  self.wander_timer_skill_makeup = 0
  self.part1 = nil
  self.part_create = 0
  self.skill_test_set = false
end

function M:on_born_behavior()
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, is_crit)
  if npc == self.npc then
    return
  end
  if check_magic(self.npc, 100447) then
    cast_magic(self.npc, self.target, 100448, 1)
  end
end

function M:on_part_damage(npc, target, part_id, cur_hp, is_crit, damage_val)
  if npc == self.npc then
    return
  end
  if 1 == part_id and cur_hp / get_part_attr(self.npc, 1, 4) <= 0.0 then
    cast_magic(self.npc, self.npc, 100446, 1)
    cast_magic(self.npc, self.npc, 100447, 1)
    cast_magic(self.npc, self.npc, 100449, 1)
    cast_magic(self.npc, self.npc, 100450, 1)
    cast_magic(self.npc, self.target, 100452, 1)
    enable_part_damage(self.npc, 1, false)
    remove_npc(self.part1)
    self.part_timer = get_npc_time(self.npc) + 3
    self.part_create = 2
  end
end

function M:skill_test()
  if self.skill_test_set == false then
    cast_skill(self.npc, self.target, 20102401, 1)
    self.skill_test_set = true
  end
end

function M:on_frame()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  if 0 == self.part_create and is_npc_loaded(self.npc) then
    self.part1 = create_part_npc(201022, self.npc, "TestRegion", 1, 2)
    self.part_create = 1
  end
  local now_time = get_npc_time(self.npc)
  if 2 == self.part_create and now_time >= self.part_timer then
    self.part1 = create_part_npc(201022, self.npc, "TestRegion", 1, 2)
    enable_part_damage(self.npc, 1, true)
    cast_magic(self.npc, self.npc, 100451, 1)
    self.part_create = 1
  end
  self:skill_test()
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if npc == self.npc then
    self.part1:on_dead(nil, true)
  end
end

return M
