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
  self:set_sync_var("cancel_born_skill", true)
  self:skip_finish_anim(true)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(111)
  self:set_ui_object_visible("fight", "Btn_skill1", false)
  self:set_ui_object_visible("fight", "Btn_skill3", false)
  self:set_ui_object_visible("fight", "Btn_skill4", false)
  self:set_ui_object_visible("fight", "Btn_skill5", false)
  self:set_ui_object_visible("fight", "Btn_lock7", false)
  self:set_ui_object_visible("fight", "JoystickContent", false)
  self:set_ui_object_visible("fight", "Button_rune", false)
  self:timer_call_out(nil, function()
    self:cast_magic(Global.hero, Global.hero, 4032073, 3)
  end, 1)
end

function M:on_frame()
  if not self.combo_guide and 0 == self:get_sync_var("combo_guide") then
    self.combo_guide = 0
    self:add_monster()
  end
  if 1 == self.combo_guide and 92 == self:get_sync_var("combo_guide") then
    self.combo_guide = 92
    self:set_sync_var("in_daze", nil)
  end
  if 92 == self.combo_guide and 99 == self:get_sync_var("combo_guide") then
    self.combo_guide = 99
    if not self:check_npc_status(self.monster1, 5) then
      self:remove_npc(self.monster1)
    end
    if not self:check_npc_status(self.monster2, 5) then
      self:remove_npc(self.monster2)
    end
    if not self:check_npc_status(self.monster3, 5) then
      self:remove_npc(self.monster3)
    end
    if not self:check_npc_status(self.monster4, 5) then
      self:remove_npc(self.monster4)
    end
    self:fight_end(true)
  end
end

function M:add_monster()
  if 0 == self.combo_guide then
    self.monster1 = self:add_npc_by_pos_key(1, 20106001, "M31", 0, 0, "tp3", 0, 0, 4, 99)
    self.monster2 = self:add_npc_by_pos_key(1, 20106001, "M32", 0, 0, "tp3", 0, 0, 4, 99)
    self.monster3 = self:add_npc_by_pos_key(1, 20106001, "M33", 0, 0, "tp3", 0, 0, 4, 99)
    self.monster4 = self:add_npc_by_pos_key(1, 20106001, "M34", 0, 0, "tp3", 0, 0, 4, 99)
    self:cast_magic(self.monster1, self.monster1, 4032901, 1)
    self:cast_magic(self.monster2, self.monster2, 4032901, 1)
    self:cast_magic(self.monster3, self.monster3, 4032901, 1)
    self:cast_magic(self.monster4, self.monster4, 4032901, 1)
    self:set_sync_var("in_daze", 1)
    self:set_sync_var("close_counterattack", 1)
    self:set_sync_var("combo_guide", 1)
    self.combo_guide = 1
  end
end

function M:on_npc_dead(npc)
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
end

function M:on_load(data)
end

return M
