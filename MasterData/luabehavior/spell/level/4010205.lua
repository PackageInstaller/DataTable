local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.timer_set = 0
  self.blooding_set = 0
  self.over_timer = 0
end

function M:on_frame()
  local teammate1 = get_scene_hero_by_poskey(21)
  local teammate2 = get_scene_hero_by_poskey(22)
  if 0 == self.timer_set then
    self.over_timer = get_npc_time(self.npc) + 1
    self.timer_set = 1
  end
  local now_time = get_npc_time(self.npc)
  if now_time > self.over_timer and 1 == self.timer_set then
    self.over_timer = now_time + 1
    self.blooding_set = self.blooding_set + 1
    if self.npc == teammate1 then
      return
    end
    if self.npc == teammate2 then
      return
    end
    cast_magic(self.npc, self.npc, 4010206, 1)
  end
  if 50 == self.blooding_set then
    self.timer_set = 2
  end
end

return M
