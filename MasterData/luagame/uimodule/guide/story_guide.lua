local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local CTL_TYPE = {
  AREA_ACT = 1,
  AREA_NO_ACT = 2,
  ACT = 3,
  NO_ACT = 4
}

function ui:ui_on_show(guider, param, ...)
  self.v_guider = guider
  local story_ui = UIMgr:get_ui("uistory")
  story_ui:ui_show(param.story_id, nil, nil, nil, true)
  self.v_guide_frame = self.v_object
  self.v_guide_frame:SetActive(false)
end

function ui:get_ctl_type()
  return CTL_TYPE.AREA_ACT
end

function ui:update_cope_obj_location()
end

return ui
