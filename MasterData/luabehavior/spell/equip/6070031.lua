local M = Util.create_class()
local CommonRole = import("common.role")
local team_hero_list = {}
local skill_id = 607000032
local skill_cd = get_skill_cfg(skill_id).CdChargePerCost

function M:_init(npc)
end

function M:on_start()
  team_hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
  for k, v in pairs(team_hero_list) do
    cast_magic(v, v, 6170309, 0)
  end
end

function M:on_input(input_id)
  if 60 == input_id then
    if get_npc_cd_charge(self.npc, skill_id) >= skill_cd then
      cast_skill(self.npc, nil, skill_id, nil, nil)
    else
      cast_magic(self.npc, self.npc, 100158, 1)
    end
  end
end

function M:on_frame()
end

return M
