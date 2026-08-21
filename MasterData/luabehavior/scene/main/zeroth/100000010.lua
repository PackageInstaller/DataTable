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
  self.is_hide_skill = 0
  self.guide1 = 0
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.tp_control1 = 0
end

function M:on_enter()
  self:actvie_obstacle("AW1", "wall1", true)
  if self:is_pass_room() then
    self:set_scene_camera(9901)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    self:open_all_transmit()
  else
    self:set_scene_camera(9901)
    self:set_ui_object_visible("fight", "Button_prepare", false)
    self:set_ui_object_visible("fight", "Button_rune", false)
    self:set_ui_object_visible("fight", "Collection", false)
    self:set_ui_object_visible("fight", "Talent", false)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    if 0 == self.guide1 then
      self:set_ui_object_visible("fight", "Btn_skill1", false)
      self:set_ui_object_visible("fight", "Btn_skill3", false)
      self:set_ui_object_visible("fight", "Btn_skill4", false)
      self:set_ui_object_visible("fight", "Btn_skill5", false)
      self:set_ui_object_visible("fight", "Btn_skill8", false)
      self:set_ui_object_visible("fight", "Btn_lock7", false)
      self:set_ui_object_visible("fight", "JoystickContent", false)
      self:cast_magic(Global.hero, Global.hero, 4010159, 1)
      self:cast_magic(Global.hero, Global.hero, 4010177, 1)
      self:cast_magic(Global.hero, Global.hero, 4010194, 1)
      self:set_sync_var("rock_skip", true)
      self:set_sync_var("rock_in_daze", 0)
      self.guide1 = 1
    end
  end
end

function M:add_monster()
  if 1 == self.zeroth then
    self.monster1 = self:add_npc_by_pos_key(1, 20106001, "M11", 0, 0, "tp3", 0, 0, 4, self.normal_level)
    self.zeroth = 2
    self:set_sync_var("zeroth", 2)
    self:timer_call_out(nil, function()
      self.monster8 = self:add_npc_by_pos_key(1, 20102104, "M31", 0, 0, "tp3", 0, 0, 4, self.normal_level)
      self:cast_magic(self.monster8, self.monster8, 4010198, 1)
      self:cast_magic(self.monster8, self.monster8, 399933, 1)
      self:set_sync_var("zeroth1", 0)
      self:set_ui_object_visible("fight", "MainEnemyBloodList", false)
      local x, y = self:get_scene_map_pos_postion("center")
      self:lookat_position(self.monster8, x, y, true)
    end, 0.5)
  elseif 6 == self.zeroth then
    self.monster4 = self:add_npc_by_pos_key(1, 20106101, "M21", 0, 0, "tp3", 0, 0, 4, self.normal_level)
    self.monster5 = self:add_npc_by_pos_key(1, 20106101, "M22", 0, 0, "tp3", 0, 0, 4, self.normal_level)
    self.zeroth = 7
    self:set_sync_var("zeroth", 7)
  elseif 10 == self.zeroth then
    self.zeroth = 11
    self:set_sync_var("zeroth", 11)
  end
end

function M:on_npc_dead(npc)
  if not self:is_pass_room() then
    if 2 == self.zeroth and self:check_npc_status(self.monster1, 5) then
      self.monster2 = self:add_npc_by_pos_key(1, 20106101, "M12", 0, 0, "tp3", 0, 0, 4, self.normal_level)
      self.monster3 = self:add_npc_by_pos_key(1, 20106101, "M13", 0, 0, "tp3", 0, 0, 4, self.normal_level)
      self:set_sync_var("archer_stop", true)
      self.zeroth = 3
      self:set_sync_var("zeroth", 3)
    elseif 4 == self.zeroth and self:check_npc_status(self.monster2, 5) and self:check_npc_status(self.monster3, 5) then
      self.zeroth = 5
      self:set_sync_var("zeroth", 5)
    elseif 7 == self.zeroth and self:check_npc_status(self.monster4, 5) and self:check_npc_status(self.monster5, 5) then
      self:timer_call_out(nil, function()
        self.monster6 = self:add_npc_by_pos_key(1, 20106001, "M23", 0, 0, "tp3", 0, 0, 4, self.normal_level)
        self.monster7 = self:add_npc_by_pos_key(1, 20106001, "M24", 0, 0, "tp3", 0, 0, 4, self.normal_level)
        self.zeroth = 8
        self:set_sync_var("zeroth", 8)
      end, 0.5)
    elseif 8 == self.zeroth and self:check_npc_status(self.monster6, 5) and self:check_npc_status(self.monster7, 5) then
      self.zeroth = 9
      self:set_sync_var("zeroth", 9)
      self:set_sync_var("zeroth1", 1)
      self:set_ui_object_visible("fight", "MainEnemyBloodList", true)
      self:set_sync_var("rock_in_daze", 1)
    elseif 11 == self.zeroth and self:check_npc_status(self.monster8, 5) then
      self.zeroth = 12
      self:set_sync_var("zeroth", 12)
    end
  end
end

function M:on_frame()
  if 1 == self.guide1 and self:check_magic(Global.hero, 4010194) then
    self.guide1 = 2
  elseif 2 == self.guide1 and not self:check_magic(Global.hero, 4010194) then
    self.guide1 = 3
    self:cast_magic(Global.hero, Global.hero, 4010195, 1)
  elseif 3 == self.guide1 and self:check_magic(Global.hero, 4010195) then
    self.guide1 = 4
  elseif 4 == self.guide1 and not self:check_magic(Global.hero, 4010195) then
    self.guide1 = 5
    self:cast_magic(Global.hero, Global.hero, 4010196, 1)
  elseif 5 == self.guide1 and self:check_magic(Global.hero, 4010196) then
    self.guide1 = 6
  elseif 6 == self.guide1 and not self:check_magic(Global.hero, 4010196) then
    self.guide1 = 7
    self:fight_end(true)
    self.settlementTime = os.time()
    self:open_all_transmit()
    self:start_guide(2005)
  end
  if self.settlementTime and os.time() - self.settlementTime >= 2 then
    self.settlementTime = nil
    self:set_scene_camera(9901)
  end
  if not self.zeroth and 1 == self:get_sync_var("zeroth") then
    self.zeroth = 1
    self:add_monster()
  elseif 3 == self.zeroth then
    self.zeroth = 4
    self:set_sync_var("zeroth", 4)
  elseif 5 == self.zeroth and 6 == self:get_sync_var("zeroth") then
    self.zeroth = 6
    self:add_monster()
  elseif 9 == self.zeroth and 10 == self:get_sync_var("zeroth") then
    self.zeroth = 10
    self:add_monster()
  end
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

function M:on_guide_finished(guide_id)
  if 2003 == guide_id then
    self:set_sync_var("archer_stop", false)
  end
end

function M:on_save()
  local data = {
    is_hide_skill = self.is_hide_skill,
    guide1 = self.guide1
  }
  return data
end

function M:on_load(data)
  self.is_hide_skill = data.is_hide_skill
  self.guide1 = data.guide1
end

return M
