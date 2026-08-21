local M = Util.create_class()
local teammate1 = get_come_on_hero()
local teammate2 = get_scene_hero_by_poskey(22)
local teammate3 = get_scene_hero_by_poskey(21)

function M:_init()
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651230071)
  if check_magic(self.npc, 65113) then
    cast_magic(self.npc, teammate1, 651230072, self.level)
  end
  if check_magic(self.npc, 65113) and nil ~= teammate2 then
    cast_magic(self.npc, teammate2, 651230072, self.level)
  end
  if check_magic(self.npc, 65113) and nil ~= teammate3 then
    cast_magic(self.npc, teammate3, 651230072, self.level)
  end
end

function M:on_magic_begin(npc, target, magic_id, is_self, magic_level)
  if 65113 == magic_id then
    cast_magic(self.npc, teammate1, 651230072, self.level)
  end
  if 65113 == magic_id and nil ~= teammate2 then
    cast_magic(self.npc, teammate2, 651230072, self.level)
  end
  if 65113 == magic_id and nil ~= teammate3 then
    cast_magic(self.npc, teammate3, 651230072, self.level)
  end
end

return M
