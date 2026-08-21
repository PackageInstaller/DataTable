local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Visualgame_controller = require("gamelogic.visual_gameplay.visualgame_controller")

function ui:ui_finish_load()
  self:set_button("TakePictureBtn", function()
    self:screenshot()
  end)
  self:set_button("BtnRet1", function()
    UIMgr:get_ui("ui_blackfade"):ui_show(0, 0, 1, function()
      VisualGameManager:deactivate_pov_camera()
    end)
  end)
  self.v_clue_obj_list = {
    self.v_uiobjects.ClueItem
  }
end

function ui:ui_on_show()
  local transform = self:get_object_transform()
  self.v_size_delta_x, self.v_size_delta_y = transform:GetSizeDeltaA()
  local activated_pov_index = VisualGameManager:get_activated_pov_index()
  local capture_system_data = VisualGameManager:get_capture_system_data()
  local index
  for i, pov_index in ipairs(capture_system_data.PovID) do
    if pov_index == activated_pov_index then
      index = i
    end
  end
  self.v_uicompents.LocationName_txt.text = capture_system_data.Desc[index]
end

function ui:ui_on_update()
  VisualGameManager:update_visible_state()
  self:update_clue_ui()
end

function ui:ui_on_hide()
  for _, clueitem in ipairs(self.v_clue_obj_list) do
    clueitem:SetActiveEx(false)
  end
  self.v_uiobjects.FoundBox:SetActiveEx(false)
  self.v_uiobjects.NoFoundBox:SetActiveEx(false)
end

function ui:ui_on_destroy()
end

function ui:screenshot()
  VisualGameManager:screenshot(function(rt)
    UIMgr:get_ui("ui_quantum_capture"):ui_show(rt)
  end)
end

function ui:update_clue_ui()
  local is_any_obj_visible, count, pos_buffer = VisualGameManager:is_any_obj_visible()
  self.v_uiobjects.FoundBox:SetActiveEx(is_any_obj_visible)
  self.v_uiobjects.NoFoundBox:SetActiveEx(not is_any_obj_visible)
  local addcount = count - #self.v_clue_obj_list
  for i = 1, addcount do
    local clueitem = UnityGameObject.Instantiate(self.v_uiobjects.ClueItem, self.v_uiobjects.ClueContainer.transform)
    self.v_clue_obj_list[#self.v_clue_obj_list + 1] = clueitem
  end
  for i = 1, #self.v_clue_obj_list do
    local clueitem = self.v_clue_obj_list[i]
    if i > count then
      clueitem:SetActiveEx(false)
    else
      local world_x = pos_buffer[(i - 1) * 3 + 1]
      local world_y = pos_buffer[(i - 1) * 3 + 2]
      local world_z = pos_buffer[(i - 1) * 3 + 3]
      local viewport_point_x, viewport_point_y = Global.camera:get_camera():WorldToViewPointA(world_x, world_y, world_z)
      local screen_pos_x = self.v_size_delta_x * viewport_point_x
      local screen_pos_y = self.v_size_delta_y * viewport_point_y
      local rect = Util.get_rect_transform(nil, clueitem)
      rect:SetAnchoredPosition3DA(screen_pos_x, screen_pos_y, 0)
      clueitem:SetActiveEx(true)
    end
  end
end

return ui
