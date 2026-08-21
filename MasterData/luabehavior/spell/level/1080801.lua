local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local Visualgame_controller = require("gamelogic.visual_gameplay.visualgame_controller")

function M:_init(...)
  Base._init(self, ...)
  self.vgc_sculpture = Visualgame_controller:new()
  self.vgc_sculpture:initialize("10808_Profile_Sculpture")
  self.vgc_sculpture:apply_camera(Global.camera:get_camera())
  self.vgc_sculpture.on_visibility_change = self.on_visibility_change_sculpture
  self.vgc_sculpture.on_obj_move = self.on_obj_move_sculpture
  self.vgc_sculpture.parent = self
  self.vgc_sculpture.find_change = false
  self.cur_change_times = 0
  self.max_change_times = 4
  self.sculpture_list = {
    "/10808_Profile_Sculpture/BackupLocation/sc08_prop_66a_01_pre(Clone)",
    "/10808_Profile_Sculpture/BackupLocation/sc08_prop_66b_01_pre(Clone)",
    "/10808_Profile_Sculpture/BackupLocation/sc08_prop_66c_01_pre(Clone)"
  }
  self.current_state = 1
  set_sceneobj_visible(self.sculpture_list[2], false)
  set_sceneobj_visible(self.sculpture_list[3], false)
end

function M:on_visibility_change_sculpture(obj_index, is_visible)
  if obj_index == self.parent.current_state - 1 and false == is_visible and self.find_change then
    local new_state = math.random(#self.parent.sculpture_list)
    if new_state == self.parent.current_state then
      if new_state - 1 > 0 then
        self.parent.current_state = new_state - 1
      elseif new_state + 1 < #self.parent.sculpture_list then
        self.parent.current_state = new_state + 1
      end
    else
      self.parent.current_state = new_state
    end
    self.parent.cur_change_times = self.parent.cur_change_times + 1
    if self.parent.cur_change_times >= self.parent.max_change_times then
      call_scene_logic_custom_event("to_second_floor")
    end
    for i, v in ipairs(self.parent.sculpture_list) do
      if i == self.parent.current_state then
        set_sceneobj_visible(self.parent.sculpture_list[i], true)
      else
        set_sceneobj_visible(self.parent.sculpture_list[i], false)
      end
    end
    self.find_change = false
  end
  if obj_index == self.parent.current_state - 1 and is_visible and false == self.find_change then
    self.find_change = true
  end
end

function M:on_story_finish(story_id)
  if 4081001 == story_id then
    self.vgc_sculpture:start_game()
  elseif 4081002 == story_id then
    self.vgc_sculpture:resume_game()
  end
end

function M:on_enter_area(npc, area)
  if npc == get_come_on_hero() and area.Key == "camera" and get_sync_var("camera") then
    self:timer_call_out("pause_delay", function()
      self.vgc_sculpture:pause_game()
    end, 0.75)
  end
end

function M:on_remove()
  self.vgc_sculpture:end_game()
  self.vgc_sculpture:destroy()
end

return M
