local M = Util.create_class()

function M:_init()
  self.npc1 = nil
  self.npc2 = nil
  self.npc3 = nil
  self.npc1_get = 0
  self.npc2_get = 0
  self.npc3_get = 0
end

function M:on_start()
  self.npc1 = get_come_on_hero()
  cast_magic(self.npc1, self.npc1, 60710801, 1)
  if get_scene_hero_by_poskey(21) then
    self.npc2 = get_scene_hero_by_poskey(21)
    cast_magic(self.npc2, self.npc2, 60710801, 1)
  end
  if get_scene_hero_by_poskey(22) then
    self.npc3 = get_scene_hero_by_poskey(22)
    cast_magic(self.npc3, self.npc3, 60710801, 1)
  end
end

function M:on_remove()
  abort_magic_by_id(self.npc1, 60710801, 1)
  if self.npc2 then
    abort_magic_by_id(self.npc2, 60710801, 1)
  end
  if self.npc3 then
    abort_magic_by_id(self.npc3, 60710801, 1)
  end
end

return M
