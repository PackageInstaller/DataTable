local M = Util.create_class()

function M:_init()
  self.target_list = {}
  local hero_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
  for i, hero in ipairs(hero_list) do
    if hero and check_magic(hero, 4032189) then
      table.insert(self.target_list, hero)
    end
  end
end

function M:on_frame()
  for j, target in ipairs(self.target_list) do
    if get_npc_attr(target, 1) < get_npc_attr(target, 4) * 0.2 then
      cast_magic(self.npc, target, 4032905, 0)
    end
  end
end

return M
