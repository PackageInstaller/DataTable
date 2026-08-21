local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("TakePictureBtn", function()
    self:screenshot()
  end)
  self:set_button("BtnRet1", function()
    UIMgr:get_ui("ui_blackfade"):ui_show(0, 0, 1, function()
      CaptureMgr:deactivate_pov_camera()
    end)
  end)
  self.v_clue_obj_list = {
    self.v_uiobjects.ClueItem
  }
end

function ui:ui_on_show()
  self.v_uiobjects.FoundBox:SetActiveEx(false)
  self.v_uiobjects.NoFoundBox:SetActiveEx(false)
  local activated_pov_index = CaptureMgr:get_activated_pov_index()
  local capture_system_data = CaptureMgr:get_capture_system_data()
  local index
  for i, pov_index in ipairs(capture_system_data.PovID) do
    if pov_index == activated_pov_index then
      index = i
    end
  end
  self.v_uicompents.LocationName_txt.text = capture_system_data.Desc[index]
  for _, clueitem in ipairs(self.v_clue_obj_list) do
    clueitem:SetActiveEx(false)
  end
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:screenshot()
  CaptureMgr:screenshot(function(rt)
    UIMgr:get_ui("ui_capture"):ui_show(rt)
  end)
end

return ui
