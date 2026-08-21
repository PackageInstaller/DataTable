local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  cast_magic(self.npc, self.npc, 650019031, 0)
end

function M:on_frame()
end

return M
