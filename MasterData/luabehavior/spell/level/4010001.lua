local M = Util.create_class()

function M:_init()
  self.god = get_god_npc()
  self.teammate1 = get_scene_hero_by_poskey(21)
  self.teammate2 = get_scene_hero_by_poskey(22)
end

function M:on_room_pass()
  if not check_magic(self.npc, 4032097) then
    cast_magic(self.npc, self.npc, 4032097, 0)
    if self.teammate1 then
      cast_magic(self.npc, self.teammate1, 4032097, 0)
    end
    if self.teammate2 then
      cast_magic(self.npc, self.teammate2, 4032097, 0)
    end
  end
end

function M:on_room_change(npc)
  if not is_pass_room() and check_magic(self.npc, 4032097) then
    abort_magic_by_id(self.npc, 4032097)
    if self.teammate1 then
      abort_magic_by_id(self.teammate1, 4032097)
    end
    if self.teammate2 then
      abort_magic_by_id(self.teammate2, 4032097)
    end
  end
end

return M
