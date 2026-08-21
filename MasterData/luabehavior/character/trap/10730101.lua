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
  self.skill = 1073010101
  self.magic = 10730101012
end

function M:on_start()
  cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
  cast_skill(self.npc, self.npc, self.skill)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and skill_id == self.skill and (2 == get_role_kind(hit_target) or 3 == get_role_kind(hit_target) or 4 == get_role_kind(hit_target)) and check_npc_status(hit_target, 10) then
    cast_magic(self.npc, hit_target, self.magic, 1)
  end
end

function M:on_frame()
  if check_magic(self.npc, 3010101011) then
  end
end

return M
