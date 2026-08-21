local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
  if self.hero_one and not check_magic(self.hero_one, 20022002) then
    cast_magic(self.npc, self.hero_one, 20022002, 0)
  end
  if self.hero_two and not check_magic(self.hero_two, 20022002) then
    cast_magic(self.npc, self.hero_two, 20022002, 0)
  end
end

function M:on_frame()
  if get_npc_attr(self.npc, 1) <= get_npc_attr(self.npc, 4) * 0.7 and not check_magic(self.npc, 200220021) then
    cast_magic(self.npc, self.npc, 200220021, 0)
  elseif get_npc_attr(self.npc, 1) > get_npc_attr(self.npc, 4) * 0.7 and check_magic(self.npc, 200220021) then
    abort_magic_by_id(self.npc, 200220021)
  end
end

return M
