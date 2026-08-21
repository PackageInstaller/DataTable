local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, false)
  switch_move_type(npc, 1)
  set_strength_visible(false)
  self.hero = get_come_on_hero()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.god_npc = get_god_npc()
  self.skill = 300106303
  self.mark = 3000001
  self.loop = false
end

function M:on_start()
  cast_magic(self.npc, self.npc, 2010050117, 1)
  cast_magic(self.npc, self.npc, 2010050113, 1)
  cast_magic(self.npc, self.npc, 399932, 1)
  cast_magic(self.npc, self.npc, 399931, 1)
  cast_magic(self.npc, self.npc, 30010570102, 1)
  cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
  if check_magic(self.npc, self.mark) then
    self.loop = true
  end
end

function M:on_target_self_skill_hit(skill_id, attacker, hit_type, missile_cfg, missile)
  if skill_id == self.skill then
    set_sync_var("powerhit", true)
    if self.loop == false then
      cast_magic(self.npc, self.npc, 399933, 1)
    end
  end
end

return M
