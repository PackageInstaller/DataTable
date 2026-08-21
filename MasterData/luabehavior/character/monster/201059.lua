local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.hit = false
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc then
    self.hit = false
    if not self.hit then
      play_common_sound("Sound_M201013_hit_shiled")
      self.hit = true
    end
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    set_npc_dead(npc, nil, true)
    remove_npc(self.npc)
  end
end

function M:on_born_behavior()
  enable_shadow(self.npc, false)
  set_npc_hp_visible(self.npc, false)
  CommonMonster.born_animation(self, self.born_skill)
end

return M
