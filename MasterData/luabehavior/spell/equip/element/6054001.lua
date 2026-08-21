local M = Util.create_class()

function M:_init()
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  if check_magic(hit_target, 1999040) then
    cast_magic(self.npc, self.npc, 60540011, 1)
  end
end

return M
