local M = Util.create_class()
local CommonRole = import("common.role")
local team_hero_list = {}
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local rogueMgr = import("common.rogueManager")
local skill_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 5
}
local skill_indi_cfg = {
  type = 1,
  res = "Fx_skillarea_N1",
  sizex = 1
}
local skill_id = 617089101
local skill_cd = get_skill_cfg(skill_id).CdChargePerCost
local emplacement = 6170892
local skill_level = 1

function M:_init(npc)
  self.npc = get_god_npc()
  set_ui_object_visible("fight", "Btn_skill8", true)
  self:get_level()
end

function M:on_input(input_id)
  if 60 == input_id then
    print("paotai", rogueMgr.paotai_limit)
    if get_npc_cd_charge(self.npc, skill_id) >= skill_cd and get_npc_count_by_res_id(6170892) < rogueMgr.paotai_limit then
      update_skill_indicator(60, skill_area, skill_indi_cfg, 0.5)
      set_indicator_active(60, true, true)
    else
      cast_magic(self.npc, self.npc, 100158, 1)
    end
  end
end

function M:on_touch_up(output_id, iscancel)
  if 60 == output_id and not iscancel and get_npc_count_by_res_id(6170892) < rogueMgr.paotai_limit then
    self.pos = {}
    self.pos.x, self.pos.y = get_indicator_pos(output_id)
    self.now_pos = {}
    self.now_pos = get_npc_pos(get_come_on_hero())
    cast_skill_to_position(self.npc, skill_id, self.pos.x, self.pos.y)
    add_npc2(1, emplacement, self.pos.x, self.pos.y, self.now_pos.x, self.now_pos.z, 2, 1)
    set_indicator_active(60, false)
    CommonRole.indicator_slowdown_off(self)
  end
end

function M:get_level()
  skill_level = get_god_skill_level()
  local skill_id_list = {
    [1] = 617089101,
    [2] = 617089102,
    [3] = 617089103
  }
  if skill_id_list[skill_level] then
    skill_id = skill_id_list[skill_level]
    skill_cd = get_skill_cfg(skill_id).CdChargePerCost
    replace_hero_skill(8, skill_id)
    replace_tower_skill(skill_level)
    if 3 == skill_level then
      rogueMgr.paotai_limit = 3
    end
  end
end

function M:on_fate_book_battle_start()
  self:get_level()
end

function M:on_start()
  self:get_level()
end

function M:on_frame()
end

return M
