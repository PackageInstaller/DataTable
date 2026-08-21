local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local Visualgame_controller = require("gamelogic.visual_gameplay.visualgame_controller")

function M:_init(...)
  Base._init(self, ...)
  self.vgc_sculpture1 = Visualgame_controller:new()
  self.vgc_sculpture1:initialize("10813_Profile_Puzzle2-1")
  self.vgc_sculpture1:apply_camera(Global.camera:get_camera())
  self.vgc_sculpture2 = Visualgame_controller:new()
  self.vgc_sculpture2:initialize("10813_Profile_Puzzle2-2")
  self.vgc_sculpture2:apply_camera(Global.camera:get_camera())
  self.scene_timeline_finalPuzzle2 = "/Root/Level/10813/scene_timeline_1081301_finalPuzzle2"
  self.sculpture1_hint_effect = "/Root/Scene/Zone_08/Prop_08/sc08_prop_73_08_pre2/Fx_SculptureHint3"
  self.sculpture2_hint_effect = "/Root/Scene/Zone_08/Prop_08/sc08_prop_73_08_pre3/Fx_SculptureHint3"
  self.sculpture1_ready = false
  self.sculpture2_ready = false
  self.finalPuzzle2_ready = false
  self.vgc_sculpture1.on_visibility_change = self.on_visibility_change_sculpture1
  self.vgc_sculpture1.on_obj_move = self.on_obj_move_sculpture1
  self.vgc_sculpture1.parent = self
  self.vgc_sculpture2.on_visibility_change = self.on_visibility_change_sculpture2
  self.vgc_sculpture2.on_obj_move = self.on_obj_move_sculpture2
  self.vgc_sculpture2.parent = self
end

function M:on_obj_move_sculpture1(obj_index)
  if 2 == self:get_obj_activated_index(obj_index) then
    self.parent.sculpture1_ready = true
    set_sceneobj_visible(self.parent.sculpture1_hint_effect, true)
    if self.parent.sculpture2_ready then
      self.parent.finalPuzzle2_ready = true
      set_sync_var("finalPuzzle2_ready", true)
    end
  else
    self.parent.sculpture1_ready = false
    set_sceneobj_visible(self.parent.sculpture1_hint_effect, false)
    if self.parent.finalPuzzle2_ready then
      self.parent.finalPuzzle2_ready = false
      set_sync_var("finalPuzzle2_ready", false)
    end
  end
end

function M:on_obj_move_sculpture2(obj_index)
  if 0 == self:get_obj_activated_index(obj_index) then
    self.parent.sculpture2_ready = true
    set_sceneobj_visible(self.parent.sculpture2_hint_effect, true)
    if self.parent.sculpture1_ready then
      self.parent.finalPuzzle2_ready = true
      set_sync_var("finalPuzzle2_ready", true)
    end
  else
    self.parent.sculpture2_ready = false
    set_sceneobj_visible(self.parent.sculpture2_hint_effect, false)
    if self.parent.finalPuzzle2_ready then
      self.parent.finalPuzzle2_ready = false
      set_sync_var("finalPuzzle2_ready", false)
    end
  end
end

function M:on_story_finish(story_id)
  if 4081703 == story_id then
    self:timer_call_out("start_delay", function()
      self.vgc_sculpture1:start_game()
      self.vgc_sculpture2:start_game()
      VisualGameManager:open_capture_system(108130301)
    end, 0.75)
  end
end

function M:on_remove()
  self.vgc_sculpture1:end_game()
  self.vgc_sculpture1:destroy()
  self.vgc_sculpture2:end_game()
  self.vgc_sculpture2:destroy()
  VisualGameManager:close_capture_system()
end

function M:on_activate_pov_camera(pov_index)
  self:set_functional_npc_visible(1081303, false)
  self:set_functional_npc_visible(1089999, false)
  char_visible(true)
end

function M:on_deactivate_pov_camera()
  self:set_functional_npc_visible(1081303, true)
  self:set_functional_npc_visible(1089999, true)
  char_visible(false)
end

return M
