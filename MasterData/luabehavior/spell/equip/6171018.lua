local M = Util.create_class()
local team_hero_list = {
  get_scene_hero_by_poskey(21),
  get_scene_hero_by_poskey(22),
  get_come_on_hero()
}

function M:_init(npc)
end

function M:on_start()
  if not check_magic(self.npc, 6171001) then
    for k, v in pairs(team_hero_list) do
      cast_magic(self.npc, v, 6171001, 0)
    end
  end
end

return M
