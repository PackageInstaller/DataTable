local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local check_update_mode = require("gamemode.check_update_mode")
local WaitBlockMgr = require("network.network_block_mgr")
local Timer = Global.timer
local Vec3 = require("base.vec3")

function ui:ui_finish_load()
  self.v_wait_rect = self:get_rect_transform(nil, self.v_uiobjects.Waiting)
  self.v_show = false
end

function ui:ui_on_show(data, ...)
  if self.v_show == true then
    return
  end
  self.v_connect_type = data
  self.v_show = true
  Log.Info("reconnecting.lua 18 line " .. self.v_connect_type)
  self.v_object:SetActive(false)
  self.v_timer_1 = Timer:add_timer("waiting1", 3, self._show_wait, self)
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_NETWORK_RCT_SUC, self.response_reconnect_event, self)
  self:bind_auto_mq(Const.MSG_NETWORK_CNT_CLOSE, self.response_connect_failure_event, self)
  self:bind_auto_mq(Const.MSG_NETWORK_FIGHT_RCT_SUC, self.response_reconnect_event, self)
  self:bind_auto_mq(Const.MSG_NETWORK_FIGHT_CNT_CLOSE, self.response_connect_failure_event, self)
end

function ui:response_reconnect_event(msg)
  WaitBlockMgr:clear()
  self:do_check()
  self:ui_hide()
end

function ui:response_connect_failure_event(msg)
  WaitBlockMgr:clear()
  self:_timer_out()
end

function ui:_show_wait()
  WaitBlockMgr:clear()
  Timer:remove_timer(self.v_timer_1)
  self.v_timer_1 = nil
  self.v_object:SetActive(true)
  if self.sequence then
    self.sequence:Kill(false)
    self.sequence = nil
  end
  self.sequence = Util.create_sequence()
  self.sequence:Append(self.v_wait_rect:DOLocalRotate(Vec3.New(0, 0, -252000), 600))
  self.v_timer_2 = Timer:add_timer("waiting", 50, self._timer_out, self)
end

function ui:ui_on_hide()
  self.v_show = false
  if self.v_timer_1 then
    Timer:remove_timer(self.v_timer_1)
    self.v_timer_1 = nil
  end
  if self.v_timer_2 then
    Timer:remove_timer(self.v_timer_2)
    self.v_timer_2 = nil
  end
  if self.sequence then
    self.sequence:Kill(false)
    self.sequence = nil
  end
end

function ui:do_check()
  check_update_mode:do_check_update()
end

function ui:_timer_out()
  if TowerMgr then
    TowerMgr:force_exist_tower()
  end
  Network:close()
  self:unbind_all_auto_mq()
  
  local function callback()
    Global.gamemode:gmode_set_mode(Global.const.MODE_CHECK_UPDATE)
  end
  
  local sure_lab = Util.format_str("确定")
  Util.show_notify_popup_message(callback, "网络连接异常，请检查网络！", nil, sure_lab, nil, nil, true)
  UIMgr:try_hide_ui("ui_reconnect_panel")
  self:ui_hide()
end

return ui
