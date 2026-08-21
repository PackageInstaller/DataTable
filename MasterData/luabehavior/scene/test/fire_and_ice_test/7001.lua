local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config", "common")

function M:_init(...)
  Base._init(self, ...)
  self.monsternum = 0
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
  self.level_sign = 0
end

function M:on_enter()
  if self:is_pass_room() then
    self:set_scene_camera(9901)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    self:open_all_transmit()
    self:actvie_obstacle("AW1", "wall", true)
  elseif not self:is_pass_room() then
    self:set_scene_camera(9902)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    self:actvie_obstacle("AW1", "wall", true)
    self:end_perform(self.room_type)
    self:end_perform(self.room_type)
  end
end

function M:add_monster(...)
end

function M:on_npc_dead(npc)
  if not self:check_activate(self.monster1) then
    self:fight_end(true)
    self:end_perform(self.room_type)
    self.settlementTime = os.time()
    self:open_all_transmit()
    self:set_scene_camera(9901)
  end
end

function M:on_frame()
  if self.settlementTime and os.time() - self.settlementTime >= 2 then
    self.settlementTime = nil
    self:set_scene_camera(9901)
  end
end

function M:on_hero_dead()
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  if not self:is_pass_room() then
    self.fire_and_ice(self, area)
  end
  if area.Key == "fire" and 0 == self.level_sign then
    self:set_scene_tips(700101, true)
    self.level_sign = 1
  end
  if area.Key == "ice" and 1 == self.level_sign then
    self:set_scene_tips(700102, true)
    self.level_sign = 2
    self.monster1 = self:add_npc_by_pos_key(1, 201010, "M7", 0, 0, "bornpoint", 0, 0, 4, self.normal_level)
  end
  self:judge_all_tp(area)
end

function M:on_leave_area(npc, area)
  if not npc:is_hero() then
    return
  end
  if not self:is_pass_room() then
    if area.Key == "fire" then
      self:timer_call_out_remove("fire_count")
    end
    if area.Key == "ice" then
      self:timer_call_out_remove("ice_count")
    end
  end
end

return M
