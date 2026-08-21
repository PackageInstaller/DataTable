local M = Util.create_class()
local CommonRole = import("common.role")
local team_hero_list = {
  get_scene_hero_by_poskey(21),
  get_scene_hero_by_poskey(22),
  get_come_on_hero()
}
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local level = get_god_skill_level() or 1
local skill_id = 617109101
local skill_cd = get_skill_cfg(skill_id).CdChargePerCost

function M:_init(npc)
  self.npc = get_god_npc()
  set_ui_object_visible("fight", "Btn_skill8", true)
end

function M:get_level()
  level = get_god_skill_level() or 1
  local skill_data = {
    [1] = {id = 617109101},
    [2] = {id = 617109102},
    [3] = {id = 617109103}
  }
  if level >= 1 and level <= 3 then
    local data = skill_data[level]
    skill_id = data.id
    skill_cd = get_skill_cfg(skill_id).CdChargePerCost
    replace_hero_skill(8, skill_id)
    replace_tower_skill(level)
  end
end

function M:on_start()
  self:get_level()
  if not check_magic(self.npc, 6171001) then
    for k, v in pairs(team_hero_list) do
      cast_magic(self.npc, v, 6171001, 0)
    end
  end
end

function M:on_input(input_id)
  if 60 == input_id then
    local team_hero_list = {
      get_scene_hero_by_poskey(21),
      get_scene_hero_by_poskey(22),
      get_come_on_hero()
    }
    if get_npc_cd_charge(self.npc, skill_id) >= skill_cd then
      cast_skill(self.npc, team_hero_list[3], skill_id, nil, nil)
      if nil ~= team_hero_list[1] then
        cast_magic(self.npc, team_hero_list[1], 61710026, 0)
      end
      if nil ~= team_hero_list[2] then
        cast_magic(self.npc, team_hero_list[2], 61710026, 0)
      end
      if 1 == level or 2 == level then
        cast_magic(team_hero_list[3], team_hero_list[3], 61710023, 0)
      elseif 3 == level then
        cast_magic(team_hero_list[3], team_hero_list[3], 61710024, 0)
      end
      CommonRole.indicator_slowdown_off(self)
    else
      cast_magic(self.npc, self.npc, 100158, 1)
    end
  end
end

function M:on_fate_book_battle_start()
  self:get_level()
end

return M
