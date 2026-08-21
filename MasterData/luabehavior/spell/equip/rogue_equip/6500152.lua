local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  self.check_counting = 0
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 10, nil, 1)
end

function M:battle_begin()
  if self.target then
    self.check_counting = 1
    cast_magic(self.npc, self.npc, 650015021, 0)
    if self.hero_one then
      cast_magic(self.npc, self.hero_one, 650015021, 0)
    end
    if self.hero_two then
      cast_magic(self.npc, self.hero_two, 650015021, 0)
    end
  end
end

function M:on_room_change(npc)
  if npc == self.npc then
    self.check_counting = 0
  end
end

function M:on_frame()
  if 0 == self.check_counting then
    self:battle_begin()
  end
  self:search_target()
end

return M
