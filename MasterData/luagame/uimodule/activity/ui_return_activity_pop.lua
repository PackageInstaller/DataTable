local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local JUMP_TO_ACT = 30006

function ui:ui_finish_load()
  self.v_full_bg = Util.get_child_gameobj("FullScreenBackground", self.v_object)
  self.v_safe_area = Util.get_child_gameobj("SafeArea", self.v_object)
  self.v_full_bg:SetActive(false)
  self.v_safe_area:SetActive(false)
end

function ui:ui_on_show(id, polt_id)
  self.v_ret_act_info = NoviceMgr:get_activity_flyback_info()
  self.v_end_time = self.v_ret_act_info.end_time
  local first_trigger = NoviceMgr:get_story_state()
  if polt_id and first_trigger then
    UIMgr:get_ui("uistory"):ui_show(polt_id[1])
  end
  if first_trigger then
    SysOpenMgr:jump_to_sys(JUMP_TO_ACT, true)
  end
  NoviceMgr:clear_ret_act_story()
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.response_show_ui_event, self)
end

function ui:pop_up_precondition()
  return true
end

function ui:response_show_ui_event(msg)
  if nil == msg then
    return
  end
  local ui_name = msg.mm_obj
  if "uimain" == ui_name then
    local ui_mian = UIMgr:try_get_visible_ui("uimain")
    if ui_mian then
      ui_mian:check_pop_window()
    end
  end
end

return ui
