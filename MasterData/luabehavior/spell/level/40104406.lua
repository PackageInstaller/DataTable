local M = Util.create_class()

function M:_init(npc)
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.god_npc = get_god_npc()
  cast_magic(npc, npc, 40104405, 0)
  if self.hero_one then
    cast_magic(self.hero_one, self.hero_one, 40104405, 0)
  end
  if self.hero_two then
    cast_magic(self.hero_two, self.hero_two, 40104405, 0)
  end
end

function M:on_frame()
end

return M
