local M = Util.create_class()

function M:_init()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_start()
end

function M:on_magic_begin(npc, target, magic_id)
  if 3001039001 == magic_id then
    cast_magic(npc, target, 65004802)
  end
end

function M:on_magic_end(npc, target, magic_id)
  if 3001039001 == magic_id then
    abort_magic_by_id(target, 65004802)
  end
end

function M:on_frame()
end

return M
