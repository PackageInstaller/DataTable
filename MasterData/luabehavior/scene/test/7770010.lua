local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config", "common")

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.room_type = self:get_room_type()
  self.monster_list = {}
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.tp_control1 = 0
end

function M:on_enter()
  self:set_scene_camera(9901)
  self:set_ui_object_visible("fight", "Main", true)
  self:actvie_obstacle("AW1", "wall1", true)
  self:actvie_obstacle("AW2", "wall2", false)
  if not self:is_pass_room() then
    self:remove_world_model("tppoint1")
  end
  self:open_all_transmit()
  self:fight_end(true)
  self:end_perform(self.room_type)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
end

function M:add_monster(...)
end

function M:on_npc_dead(npc)
end

function M:on_frame()
end

function M:on_hero_dead()
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
end

function M:on_leave_area(npc, area)
end

return M
