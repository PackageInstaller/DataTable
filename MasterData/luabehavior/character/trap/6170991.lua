local M = Util.create_class()
local CommonRole = import("common.role")
local team_hero_list = {}
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local rogueMgr = import("common.rogueManager")
local skill_id = 617099101
local skill_cd = get_skill_cfg(skill_id).CdChargePerCost

function M:_init(npc)
  self.npc = get_god_npc()
  set_ui_object_visible("fight", "Btn_skill8", true)
  self.skill_missile_id = 61709910103
  if 1 == get_god_skill_level() then
    self.skill_missile_id = 61709910101
  elseif 2 == get_god_skill_level() then
    self.skill_missile_id = 61709910101
  elseif 3 == get_god_skill_level() then
    self.skill_missile_id = 61709910103
  end
  rogueMgr.water_level_skill = true
end

function M:on_input(input_id)
  if 60 == input_id then
    if get_npc_cd_charge(self.npc, skill_id) >= skill_cd then
      cast_skill(self.npc, self.npc, skill_id, nil, nil)
      CommonRole.indicator_slowdown_off(self)
    else
      cast_magic(self.npc, self.npc, 100158, 1)
    end
  end
end

function M:on_magic_end(npc, target, magic_id)
end

function M:get_level()
  skill_level = get_god_skill_level()
  local skill_id_list = {
    [1] = 617099101,
    [2] = 617099102,
    [3] = 617099103
  }
  if skill_id_list[skill_level] then
    skill_id = skill_id_list[skill_level]
    skill_cd = get_skill_cfg(skill_id).CdChargePerCost
    replace_hero_skill(8, skill_id)
    replace_tower_skill(skill_level)
  end
end

function M:on_fate_book_battle_start()
  self:get_level()
end

function M:on_start()
  self:get_level()
  rogueMgr:add_water_control_magic(self.npc)
end

function M:on_npc_born(npc)
  rogueMgr:born_add_water_control(self.npc, npc)
end

function M:on_frame()
end

return M
