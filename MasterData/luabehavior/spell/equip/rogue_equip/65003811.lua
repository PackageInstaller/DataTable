local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 65003811) then
    cast_magic(self.npc, self.hero_one, 65003811, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 65003811) then
    cast_magic(self.npc, self.hero_two, 65003811, 0)
  end
end

function M:on_frame()
  if get_npc_attr(self.npc, 1) <= get_npc_attr(self.npc, 4) * 0.3 and not check_magic(self.npc, 65003812) then
    cast_magic(self.npc, self.npc, 65003812, 0)
  elseif get_npc_attr(self.npc, 1) > get_npc_attr(self.npc, 4) * 0.3 and check_magic(self.npc, 65003812) then
    abort_magic_by_id(self.npc, 65003812)
  end
end

return M
