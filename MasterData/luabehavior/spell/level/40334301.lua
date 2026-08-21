local M = Util.create_class()

function M:_init()
  self.addMagic = false
  self.timeSwitch = true
  self.nowTime = 0
  self.durationTime = 0
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 2 == skill_type then
    self.addMagic = true
    self.timeSwitch = true
    self.durationTime = get_npc_time(self.npc) + 5
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and self.addMagic then
    cast_magic(self.npc, hit_target, 4033430101, 1)
    if self.timeSwitch then
      self.timeSwitch = false
      self.durationTime = get_npc_time(self.npc) + 0.1
    end
  end
end

function M:on_frame()
  if self.addMagic then
    self.nowTime = get_npc_time(self.npc)
    if self.nowTime >= self.durationTime then
      self.addMagic = false
    end
  end
end

return M
