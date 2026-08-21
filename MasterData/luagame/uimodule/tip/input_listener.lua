local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Setting_Cfg = require("uimodule.battle_setting.battle_setting_cfg")

function ui:ui_finish_load()
  self.v_key_name = nil
  self.v_key_code = nil
end

function ui:ui_on_show(btn_name, key_name)
  self.v_uicompents.NewBtn_txt.text = key_name
  self.v_block_event_flag = nil
  self.v_btn_name = btn_name
  self.v_uiobjects.ScrollView:SetActiveEx(false)
  self.v_uiobjects.NewBtn:SetActiveEx(true)
end

function ui:ui_on_update()
  local key = CSHelper.GetAnyKeyDown()
  if 27 == key then
    self:ui_hide()
    return
  end
  if 0 ~= key then
    self.v_key_code = key
    self.v_key_name = BattleSettingMgr:keycode_to_string(key)
    local is_valid, old_btn_name = self:valid_check(self.v_key_code)
    if not is_valid then
      local tip = Util.format_str(string.format("此按钮已被[%s]使用，是否继续使用？", Setting_Cfg.BTNNAME_INFO[old_btn_name].desc))
      local sure_text = Util.format_str("确认")
      local cancel_text = Util.format_str("取消")
      
      local function sure_callback()
        self:confirm()
      end
      
      local function cancel_callback()
        local msg = MsgGame:mq_publish2(Const.MSG_CUSTOM_KEY_SETTING_END)
        msg.mm_x = self.v_btn_name
      end
      
      self.v_block_event_flag = true
      self:ui_hide()
      local ui_notice_tips = UIMgr:get_ui("uinotice_tips")
      ui_notice_tips:ui_show(sure_callback, cancel_callback, tip, sure_text, cancel_text)
      ui_notice_tips:set_ex_param({call_cancel_on_hide = true})
    else
      self.v_uicompents.NewBtn_txt.text = self.v_key_name
      self:confirm()
      self:ui_hide()
    end
  end
end

function ui:ui_on_hide()
  if self.v_block_event_flag then
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_CUSTOM_KEY_SETTING_END)
  msg.mm_x = self.v_btn_name
end

function ui:confirm()
  local msg = MsgGame:mq_publish2(Const.MSG_CUSTOM_KEY_SETTING)
  msg.mm_x = self.v_key_code
  msg.mm_y = self.v_btn_name
end

function ui:valid_check(new_key_code)
  local is_valid = true
  local old_btn_name
  for btn_name, t in pairs(Setting_Cfg.BTNNAME_INFO) do
    local btn_key = t.key
    local old_key_code = BattleSettingMgr:get_gpg_custom_button(btn_key)
    if old_key_code == new_key_code and btn_name ~= self.v_btn_name then
      is_valid = false
      old_btn_name = btn_name
      break
    end
  end
  return is_valid, old_btn_name
end

return ui
