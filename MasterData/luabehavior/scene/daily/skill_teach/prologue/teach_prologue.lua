local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local _tunpack = table.unpack

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
  self.monster_list = {}
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("M1")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(100010001)
  self:set_sync_var("cancel_born_skill", true)
  self:skip_finish_anim(true)
  self:set_ui_object_visible("fight", "Btn_skill1", false)
  self:set_ui_object_visible("fight", "Btn_skill3", false)
  self:set_ui_object_visible("fight", "Btn_skill4", false)
  self:set_ui_object_visible("fight", "Btn_skill5", false)
  self:set_ui_object_visible("fight", "Btn_skill8", false)
  self:set_ui_object_visible("fight", "Btn_skill7", false)
  self:set_ui_object_visible("fight", "JoystickContent", false)
  self:set_ui_object_visible("fight", "Button_rune", false)
  self:cast_magic(Global.hero, Global.hero, 10001000, 3)
end

function M:on_teach_scene_create_monster(monster_group)
  if "monster_group1" == monster_group then
    self:add_monster1()
    self:set_sync_var("had_created_" .. monster_group, true)
  elseif "monster_group2" == monster_group then
    self:add_monster2()
    self:set_sync_var("had_created_" .. monster_group, true)
  end
end

function M:on_frame()
end

function M:on_end_teach_level(win)
  self:fight_end(true)
  self:tower_settle()
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
