local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local SceneDefine = require("cs_share.scene_define")
local AREA_TYPE = SceneDefine.AREA_TYPE

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.room_type = self:get_room_type()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:create_world_model_on_position("Fx_linshi", "jiaohu", "center", 0)
  self:set_scene_camera(9901)
  self:fight_end(true)
  self:open_all_transmit()
end

function M:on_npc_dead(npc)
end

function M:on_frame()
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
  if area.Key == "shop" and self:is_pass_room() then
    self:enter_special_area(AREA_TYPE.shop)
  end
end

function M:on_leave_area(npc, area)
  if area.Key == "shop" then
    self:leave_special_area(AREA_TYPE.shop)
  end
end

return M
