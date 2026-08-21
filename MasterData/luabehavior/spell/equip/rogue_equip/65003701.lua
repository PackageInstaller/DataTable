local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.kill_count = 0
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 65003701) then
    cast_magic(self.npc, self.hero_one, 65003701, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 65003701) then
    cast_magic(self.npc, self.hero_two, 65003701, 0)
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    return
  else
    self.kill_count = self.kill_count + 1
    if self.kill_count > 100 then
      return
    end
    cast_magic(self.npc, self.npc, 65003702, self.kill_count)
    cast_magic(self.npc, self.npc, 65003703, self.kill_count)
  end
end

function M:on_frame()
end

return M
