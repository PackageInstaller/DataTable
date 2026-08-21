local M = Util.create_class()

function M:_init()
  self.addMagic = false
  self.nowTime = 0
  self.durationTime = 0
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if self.addMagic and get_come_on_hero() == self.npc and hit_target == self.npc then
    print("成功")
    cast_missile(npc, self.npc, nil, nil, 30020200113, 1)
    self.addMagic = false
    self.durationTime = get_npc_time(self.npc) + 8
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
end

function M:on_frame()
  self.nowTime = get_npc_time(self.npc)
  if self.nowTime >= self.durationTime and not self.addMagic then
    self.addMagic = true
    print("效果重新出发")
  end
end

return M
