local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.boom = 2010340301
  self.boom_hit = 2010340302
  self.allow_boom = 0
  self.allow_boom_time = 0
  self.boom_hit_time = 0
  self.control = 0
  self.born_skill = 2010340403
  set_npc_hp_visible(npc, false)
end

function M:on_start()
  enable_shadow(self.npc, false)
  cast_magic(self.npc, self.npc, 20103401001, 1)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    return
  end
  if 30010390201 == skill_id then
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  local now_time = get_npc_time(self.npc)
  if missile_cfg.Id == 201034011011 and now_time >= self.allow_boom_time then
    cast_skill(self.npc, self.npc, self.boom)
    self.allow_boom_time = now_time + 1.5
    self.allow_boom = 8
  end
end

function M:time_to_boom()
  local now_time = get_npc_time(self.npc)
  if 8 == self.allow_boom and now_time >= self.boom_hit_time and now_time >= self.allow_boom_time then
    cast_skill(self.npc, self.npc, self.boom_hit)
    self.boom_hit_time = now_time + 100
    self.allow_boom = 9
  end
end

function M:on_frame()
  self:time_to_boom()
  if 9 == self.allow_boom then
    remove_npc(self.npc)
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

return M
