local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)

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
  if not self.is_add_npc then
    self:add_functional_npc(2, "center", "center", {npc_id = 20205})
    self:set_scene_tips(50141, true)
    self.is_add_npc = true
  end
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(102)
  if self:is_pass_room() then
    self:open_all_transmit()
  end
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
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  return {
    is_add_npc = self.is_add_npc
  }
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
end

function M:on_func_npc_interact_end(func_npc_id)
  if 20205 == func_npc_id then
    self:set_scene_tips(50141, false)
    self:fight_end(true)
    self:open_all_transmit()
  end
end

return M
