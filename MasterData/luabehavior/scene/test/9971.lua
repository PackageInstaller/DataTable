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

function M:on_func_npc_interact_end(func_npc_id)
  if 22001 == func_npc_id then
    Log.Info(Global.hero, "ssssssssssss")
    self:set_scene_tips(50004, true)
  end
end

function M:on_enter()
  if not self.is_add_npc then
    self:add_functional_npc(2, "center", "center", {npc_id = 22001})
    self.is_add_npc = true
  end
  self:set_scene_camera(9901)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_ui_object_visible("fight", "Main", true)
  if not self:is_pass_room() then
    self:remove_world_model("tppoint1")
  end
  self:open_all_transmit(3)
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

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
end

return M
