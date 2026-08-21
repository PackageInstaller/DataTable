local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 65056501) then
    cast_magic(self.npc, self.hero_one, 65056501, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 65056501) then
    cast_magic(self.npc, self.hero_two, 65056501, 0)
  end
end

function M:on_frame()
  if self.npc ~= get_come_on_hero() then
    return
  end
  if get_npc_attr(self.npc, 25) > 0 and not check_magic(self.npc, 65056502) then
    cast_magic(self.npc, self.npc, 65056502, 0)
  elseif get_npc_attr(self.npc, 25) <= 0 then
    abort_magic_by_id(self.npc, 65056502, 1)
  end
end

return M
