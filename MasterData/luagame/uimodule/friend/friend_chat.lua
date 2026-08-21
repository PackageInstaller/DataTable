local Base = require("ui.uiobject")
local ChatItemClass = require("uimodule.chat.chat_item")
local LoopListClass = require("uimodule.chat.widget.dynamic_loop_list")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local FACE_ICON_PATH = "UIChat/Face/%s"
local GUIUtility = UnityEngine.GUIUtility
local CT_Timer = Global.ct_timer
local FRIEND_LIST_REDPOINT = 7
local MODEL = {
  v_friend_name = {
    "Chat_player_name",
    BIND_TYPE.TEXT
  },
  v_online_state = {
    "Chat_player_online",
    BIND_TYPE.TEXT
  },
  v_face_panel = {
    "FaceWin",
    BIND_TYPE.OBJECT
  },
  v_new_msg_notcie = {
    "NewMegNotice",
    BIND_TYPE.TEXT
  },
  v_new_msg_btn = {
    "NewMegBtn",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnFace", function()
    self:_onclick_face_btn()
  end)
  self:set_button("BtnSend", function()
    self:_onclick_send_btn()
  end)
  self:set_button("BtnChatOut", function()
    self:_onclick_out_btn()
  end)
  self:set_button("CloseWinBtn", function()
    self:_onclick_face_btn()
  end)
  self:set_button("BtnClear", function()
    self.v_msg_input.text = ""
    self.v_send_msg = ""
    self.v_uiobjects.BtnClear:SetActive(false)
  end)
  Global.listener_mgr:add_listener(self.v_object, self.v_new_msg_btn.onClick, function()
    self.v_chat_list:scroll_to_bottom()
    self.v_new_msg_btn.gameObject:SetActive(false)
    self.v_unread_msg_num = 0
  end)
  self.template_key = {
    face_page_tog = string.format("%s_%s", "face_page_tog", self:get_object().name),
    face_item = string.format("%s_%s", "face_item", self:get_object().name)
  }
  self:_init_face_panel()
  self.v_msg_input = self:get_inputfield(nil, self.v_uiobjects.Input)
  self:set_inputfield_listener(self.v_msg_input, function()
    self.v_uiobjects.BtnClear:SetActive(true)
  end)
  self.v_send_msg = ""
  self.v_input_max_len = ShareRes.get_game_const("ChatMsgLenLimit") or 200
  self.v_msg_input.placeholder.text = Util.format_str("（不超过{1}个字）", self.v_input_max_len)
  
  local function top_cb()
    self:_on_slider_to_top()
  end
  
  local function buttom_cb()
    self.v_unread_msg_num = 0
    self.v_new_msg_btn.gameObject:SetActive(false)
  end
  
  self.v_chat_list = LoopListClass:new(self, self.v_uiobjects.ChatScrollView, ChatItemClass, top_cb, buttom_cb)
end

function ui:_init_face_panel()
  self.v_face_page_cfg = ShareRes.create("chat.chat_face_page")
  self.v_face_page_type_cfg = ShareRes.create("chat.chat_face_page_type")
  self:register_exist_auto_template(self.template_key.face_page_tog, self.v_uiobjects.FAcePageTem, self.v_uiobjects.FacePageList)
  self:register_exist_auto_template(self.template_key.face_item, self.v_uiobjects.FaceTem, self.v_uiobjects.FaceContent)
end

function ui:_init_face_page_toggle_list()
  self.v_face_tog_list = {}
  self:give_back_auto_cache(self.template_key.face_page_tog, false)
  local list = {}
  for _, v in pairs(self.v_face_page_cfg) do
    if Condition:check_condition(v.condition) == true then
      table.insert(list, v)
    end
  end
  table.sort(list, function(a, b)
    return a.sort_id < b.sort_id
  end)
  for idx, v in ipairs(list) do
    local obj = self:get_auto_cache(self.template_key.face_page_tog)
    local tog = self:get_toggle(nil, obj)
    self.v_face_tog_list[idx] = tog
    self:_set_face_page_toggle(tog, idx, v)
  end
end

function ui:_set_face_page_toggle(togObj, index, data)
  local lab = self:get_text("Label", togObj.gameObject)
  lab.text = data.page_name
  togObj.onValueChanged:RemoveAllListeners()
  togObj.onValueChanged:AddListener(function(isOn)
    if isOn then
      lab.text = string.format("<color=black>%s</color>", data.page_name)
    else
      lab.text = string.format("<color=white>%s</color>", data.page_name)
    end
    self:_onclick_face_page_tog(isOn, index)
  end)
end

function ui:ui_on_show(...)
end

function ui:set_data(data)
  if not data then
    self:set_enable(false)
    return
  end
  if self.v_chat_char and self.v_chat_char.uuid == data.char.uuid then
    return
  end
  self.v_msg_list = nil
  self.v_chat_char = data.char
  self:_set_friend_states()
  self.v_show_face_panel = false
  self:_refresh_face_toggle_panel()
  self:_refresh_chat_panel(true)
  self:_regist_client_event()
  self.v_last_record_idx = ChatMgr:get_record_idx(self.v_chat_char.uuid)
  self.v_unread_msg_num = 0
  self.v_new_msg_btn.gameObject:SetActive(false)
  self.v_uiobjects.BtnClear:SetActive(false)
end

function ui:ui_on_hide()
  if self.v_chat_char then
    self.v_parent_ui:close_chat(self.v_chat_char.uuid)
  end
  self.v_chat_char = nil
  self.v_send_msg = ""
  self.v_show_face_panel = false
  self.v_msg_list = nil
  if self.pull_cd_timer then
    CT_Timer:remove_timer(self.pull_cd_timer)
    self.pull_cd_timer = nil
  end
  self.v_in_pull_cd = nil
end

function ui:ui_on_update(delta_time)
  if self.v_auto_scroll and self.v_auto_scroll < 1 then
    self.v_auto_scroll = self.v_auto_scroll + 1
    self:_scroll_to_target()
    self.v_last_record_idx = ChatMgr:get_record_idx(self.v_chat_char.uuid)
  end
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_FRIEND_CHAT_MSG_UPDATE, self.response_msg_update_event, self)
  self:bind_auto_mq(Const.MSG_PULL_FRIEND_CHAT_MSG_SUCCESS, self.response_pull_success_event, self)
end

function ui:response_msg_update_event(msg)
  if not (msg and self.v_chat_char) or msg.mm_obj ~= self.v_chat_char.uuid then
    return
  end
  local need_to_buttom = true
  if ChatMgr:get_latest_friend_chat_side() == self.v_chat_char.uuid then
    local list = ChatMgr:get_friend_chat_list(self.v_chat_char)
    local endIdx = self.v_chat_list:get_visual_end_idx()
    need_to_buttom = math.abs(endIdx - #list) <= 1
    self.v_new_msg_btn.gameObject:SetActive(not need_to_buttom)
    if not need_to_buttom then
      self.v_unread_msg_num = self.v_unread_msg_num + 1
      self.v_new_msg_notcie.text = Util.format_str("{1}条新消息", self.v_unread_msg_num)
    end
  end
  self:_refresh_chat_panel(need_to_buttom)
end

function ui:response_pull_success_event(msg)
  if not (msg and self.v_chat_char) or msg.mm_obj ~= self.v_chat_char.uuid then
    return
  end
  self.v_msg_list = nil
  self.v_auto_scroll = 0
  self:_refresh_chat_panel()
  self:_scroll_to_target()
end

function ui:_scroll_to_target()
  local chat_data = self.v_msg_list[1]
  if not chat_data then
    return
  end
  local targetIdx = self.v_last_record_idx - chat_data.idx
  if targetIdx <= 0 then
    return
  end
  self.v_chat_list:scroll_to_item(targetIdx)
end

function ui:_set_friend_states()
  self.v_friend_name.text = self.v_chat_char.name
  local str = 0 == self.v_chat_char.offline_time and string.format("<color=green>%s</color>", Util.format_str("在线")) or string.format("<color=#8A8A8A>%s</color>", Util.format_str("离线"))
  self.v_online_state.text = str
end

function ui:_refresh_chat_panel(need_to_buttom)
  if self.v_msg_list then
    self.v_msg_list = ChatMgr:get_friend_chat_list(self.v_chat_char)
    self.v_chat_list:add_data(self.v_msg_list)
  else
    self.v_msg_list = ChatMgr:get_friend_chat_list(self.v_chat_char)
    self.v_chat_list:refresh_data(self.v_msg_list)
  end
  if need_to_buttom then
    self.v_unread_msg_num = 0
    self.v_new_msg_btn.gameObject:SetActive(false)
  end
  RedPointMgr:enable_dynamic_redpoint(self.v_chat_char.uuid, FRIEND_LIST_REDPOINT, false)
end

function ui:_refresh_face_toggle_panel()
  self.v_face_panel:SetActive(self.v_show_face_panel)
  if self.v_show_face_panel == false then
    self.v_cur_page_idx = 0
    return
  end
  self:_refresh_face_toggle_list()
end

function ui:_refresh_face_toggle_list()
  self:_init_face_page_toggle_list()
  if 0 == #self.v_face_tog_list then
    self:_onclick_face_btn()
    Util.show_message_tip(2192)
    return
  end
  self.v_face_tog_list[1].isOn = true
  self:_onclick_face_page_tog(true, 1)
end

function ui:_refresh_face_panel()
  self:give_back_auto_cache(self.template_key.face_item, false)
  self.v_face_list = self.v_face_page_type_cfg[self.v_cur_page_idx]
  for i, v in ipairs(self.v_face_list) do
    local obj = self:get_auto_cache(self.template_key.face_item)
    self:_set_face_item(obj, v)
  end
end

function ui:_set_face_item(obj, data)
  obj:SetActive(true)
  local icon = self:get_image("Image", obj)
  ResMgr:load_set_icon(icon, string.format(FACE_ICON_PATH, data.icon))
  local btn = self:get_button(nil, obj)
  btn.onClick:RemoveAllListeners()
  btn.onClick:AddListener(function()
    if self.v_in_send_cd == true then
      return
    end
    ChatMgr:request_send_friend_chat_msg(self.v_chat_char, data.face_character)
    self:_onclick_face_btn()
  end)
end

function ui:_onclick_face_btn()
  self.v_show_face_panel = not self.v_show_face_panel
  self.v_msg_input.interactable = not self.v_show_face_panel
  self:_refresh_face_toggle_panel()
end

function ui:_onclick_send_btn()
  self.v_send_msg = self.v_msg_input.text
  if string.len(self.v_send_msg) >= self.v_input_max_len then
    Util.show_message_tip(2166)
    return
  end
  local space_len = 0
  for v in string.gmatch(self.v_send_msg, "%s") do
    space_len = space_len + 1
  end
  if space_len == string.len(self.v_send_msg) then
    Util.show_message_tip(2167)
    return
  end
  ChatMgr:request_send_friend_chat_msg(self.v_chat_char, self.v_send_msg)
  self.v_msg_input.text = ""
  self.v_uiobjects.BtnClear:SetActive(false)
end

function ui:_onclick_out_btn()
  self:set_enable(false)
end

function ui:_onclick_face_page_tog(isOn, index)
  if self.v_cur_page_idx == index then
    return
  end
  if isOn then
    self.v_cur_page_idx = index
    self:_refresh_face_panel()
  end
end

function ui:_on_slider_to_top()
  if not self.v_chat_char then
    return
  end
  if self.v_in_pull_cd then
    return
  end
  ChatMgr:pull_friend_chat_record(self.v_chat_char)
  self:_start_send_cd()
end

function ui:_start_send_cd()
  if self.pull_cd_timer == nil then
    self.v_in_pull_cd = true
    self.pull_cd_timer = CT_Timer:add_timer("pull_cut_down", 5, function(sec)
      if sec <= 0 then
        if self.pull_cd_timer then
          CT_Timer:remove_timer(self.pull_cd_timer)
          self.pull_cd_timer = nil
        end
        self.v_in_pull_cd = nil
      end
    end)
  end
end

return ui
