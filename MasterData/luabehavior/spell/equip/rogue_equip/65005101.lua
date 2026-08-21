local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_magic_begin(npc, target, magic_id)
  if 3001039001 == magic_id then
    cast_magic(self.npc, self.npc, 65005102)
    if self.hero_one and not check_magic(self.hero_one, 65005102) then
      cast_magic(self.npc, self.hero_one, 65005102, 0)
    end
    if self.hero_two and not check_magic(self.hero_two, 65005102) then
      cast_magic(self.npc, self.hero_two, 65005102, 0)
    end
  end
end

function M:on_magic_end(npc, target, magic_id)
  if 3001039001 == magic_id then
    abort_magic_by_id(self.npc, 65005102)
    abort_magic_by_id(self.hero_one, 65005102)
    abort_magic_by_id(self.hero_two, 65005102)
  end
end

function M:on_frame()
end

return M
