local M = Util.create_class()

function M:_init()
  self.npc1 = nil
  self.npc2 = nil
  self.npc3 = nil
  self.npc1_get = 0
  self.npc2_get = 0
  self.npc3_get = 0
  self.room = 0
  self.count = 0
end

function M:on_start()
  if get_come_on_hero() then
    self.npc1 = get_come_on_hero()
  end
  if get_scene_hero_by_poskey(21) then
    self.npc2 = get_scene_hero_by_poskey(21)
  end
  if get_scene_hero_by_poskey(22) then
    self.npc3 = get_scene_hero_by_poskey(22)
  end
  if self.npc1 then
    cast_magic(self.npc1, self.npc1, 60730801, 1)
    self.npc1_get = 1
  end
  if self.npc2 then
    cast_magic(self.npc2, self.npc2, 60730801, 1)
    self.npc2_get = 1
  end
  if self.npc3 then
    cast_magic(self.npc3, self.npc3, 60730801, 1)
    self.npc3_get = 1
  end
end

function M:on_floor_finished(npc1, npc2, npc3, floor)
  self.count = self.count + 1
  if self.npc1 then
    cast_magic(self.npc1, self.npc1, 60730802, 1)
    if get_npc_attr(self.npc1, 1) > get_npc_attr(self.npc1, 4) then
      cast_magic(self.npc1, self.npc1, 60730703, 0)
    end
  end
  if self.npc2 then
    cast_magic(self.npc2, self.npc2, 60730802, 1)
    if get_npc_attr(self.npc2, 1) > get_npc_attr(self.npc2, 4) then
      cast_magic(self.npc2, self.npc2, 60730703, 0)
    end
  end
  if self.npc3 then
    cast_magic(self.npc3, self.npc3, 60730802, 1)
    if get_npc_attr(self.npc3, 1) > get_npc_attr(self.npc3, 4) then
      cast_magic(self.npc3, self.npc3, 60730703, 0)
    end
  end
end

return M
