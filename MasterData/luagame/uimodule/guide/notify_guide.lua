local Base = require("ui.uiobject")
local GuideHelper = require("uimodule.guide.guide_helper")
local ui = Util.create_child_mt(Base)
local UnityDestroy = _ENV.UnityDestroy
local CTL_TYPE = {
  AREA_ACT = 1,
  AREA_NO_ACT = 2,
  ACT = 3,
  NO_ACT = 4
}

function ui:ui_finish_load(...)
  self.v_guide_frame = self.v_object
  self.v_frame_rect = self:get_rect_transform(nil, self.v_guide_frame)
end

function ui:ui_on_show(guider, param, ...)
  self.v_guider = guider
  self:_copy_ui_control(param.ui_name, param.control_path, param.hide_frame)
  self:_regist_client_event()
end

function ui:ui_on_hide()
  if self.v_copy_obj then
    UnityDestroy(self.v_copy_obj)
    self.v_copy_obj = nil
  end
  self.v_guider = nil
  self.v_target_obj = nil
  self.v_guide_area = nil
end

function ui:update_cope_obj_location()
  if self.v_copy_obj and self.v_target_obj then
    if self.v_guide_area then
      GuideHelper.adjust_frame_rect(self, self.v_copy_obj, self.v_guide_area, self.v_frame_rect)
    else
      GuideHelper.adjust_frame_rect(self, self.v_copy_obj, self.v_target_obj, self.v_frame_rect)
    end
  end
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_CLICK_TARGET_UI, self._response_guide_click_event, self)
end

function ui:_response_guide_click_event(msg)
  if msg.mm_x ~= self.v_guider:get_target_ui() then
    return
  end
  self.v_parent_ui:resume_game()
  self.v_guider:complete_step()
end

function ui:_copy_ui_control(ui_name, ctr_path, hide_frame)
  local uiobj = UIMgr:try_get_visible_ui(ui_name)
  if not uiobj then
    Log.Error("get ui failure !!, ui_name=", ui_name)
    self.v_parent_ui:ui_hide()
    return
  end
  if not ctr_path then
    return
  end
  local target_obj = GuideHelper.get_obj_by_path(self, ctr_path, uiobj)
  local guide_area = self:get_child_gameobj("Guide_Area", target_obj)
  self.v_target_obj = target_obj
  self.v_guide_area = guide_area
  if not target_obj then
    Log.Error("get ui control by path failure !!, path=", ctr_path, " ui name=", uiobj:ui_get_name())
    self.v_parent_ui:ui_hide()
    return
  end
  GuideHelper._reset_joystick(target_obj)
  GuideHelper._reset_joystick_pos(target_obj)
  self.v_copy_obj = UnityGameObject.Instantiate(target_obj, self.v_guide_frame.transform).gameObject
  GuideHelper.copy_image(target_obj, self.v_copy_obj)
  if guide_area then
    GuideHelper.adjust_frame_rect(self, self.v_copy_obj, guide_area, self.v_frame_rect)
  else
    GuideHelper.adjust_frame_rect(self, self.v_copy_obj, target_obj, self.v_frame_rect)
  end
  self:_get_ctl_event(target_obj, hide_frame, guide_area)
  self.v_guide_frame:SetActive(not hide_frame)
end

function ui:_get_ctl_event(target_obj, hide_frame, guide_area)
  self.v_copy_obj:SetActive(false)
  self.v_ctl_type = guide_area and CTL_TYPE.AREA_NO_ACT or CTL_TYPE.NO_ACT
end

function ui:get_copy_obj()
  return self.v_copy_obj
end

function ui:get_pivot(idx)
  return self:get_rect_transform("Pivot_" .. idx, self.v_guide_frame)
end

function ui:get_frame_rect()
  return self.v_frame_rect
end

function ui:get_click_event()
  return self.v_click_cb
end

function ui:get_ctl_type()
  return self.v_ctl_type
end

function ui:set_complete()
  self.v_is_complete = true
end

return ui
