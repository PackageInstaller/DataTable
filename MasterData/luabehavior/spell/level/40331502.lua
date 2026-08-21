local M = Util.create_class()

function M:_init()
  self.kind = 0
  self.magicAdd = false
end

function M:on_start()
  self.kind = get_role_kind(self.npc)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 2 == self.kind then
    self.magicAdd = true
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and 2 == missile_cfg.MissileTypeTag and self.magicAdd then
    self.magicAdd = false
    pos = get_npc_pos(hit_target)
    cast_missile(self.npc, nil, pos.x, pos.z, 30020200105, 1)
  end
end

return M
