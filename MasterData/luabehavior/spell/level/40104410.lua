local M = Util.create_class()

function M:_init(npc)
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  self.god_npc = get_god_npc()
  cast_magic(npc, npc, 40104409, 0)
  if self.hero_one then
    cast_magic(self.hero_one, self.hero_one, 40104409, 0)
  end
  if self.hero_two then
    cast_magic(self.hero_two, self.hero_two, 40104409, 0)
  end
end

function M:on_frame()
  if get_sync_var("104501_speed_up") then
    set_sync_var("104501_speed_up", true)
    abort_magic_by_id(self.npc, 40104409)
    if self.hero_one then
      abort_magic_by_id(self.hero_one, 40104409)
    end
    if self.hero_two then
      abort_magic_by_id(self.hero_two, 40104409)
    end
  end
end

function M:on_frame_background()
  if get_sync_var("104501_speed_up") then
    set_sync_var("104501_speed_up", true)
    abort_magic_by_id(self.npc, 40104409)
    if self.hero_one then
      abort_magic_by_id(self.hero_one, 40104409)
    end
    if self.hero_two then
      abort_magic_by_id(self.hero_two, 40104409)
    end
  end
end

return M
