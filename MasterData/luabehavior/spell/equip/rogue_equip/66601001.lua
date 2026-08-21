local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 66601001) then
    cast_magic(self.npc, self.hero_one, 66601001, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 66601001) then
    cast_magic(self.npc, self.hero_two, 66601001, 0)
  end
  cast_magic(self.npc, self.npc, 66601002, 0)
end

function M:on_frame()
end

return M
