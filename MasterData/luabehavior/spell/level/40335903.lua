local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc then
    cast_magic(self.npc, self.npc, 4033590301, 1)
  end
end

return M
