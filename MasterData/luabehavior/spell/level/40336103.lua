local M = Util.create_class()

function M:_init()
  self.nowTime = 0
  self.intervalTime = 0
end

function M:on_start()
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and self.nowTime >= self.intervalTime then
    cast_magic(self.npc, self.npc, 4033610301, 1)
    self.intervalTime = self.nowTime + 8
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
end

function M:on_frame()
  self.nowTime = get_npc_time(self.npc)
end

return M
