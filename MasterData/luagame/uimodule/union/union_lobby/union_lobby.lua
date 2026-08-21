local Base = require("ui.uibase")
local ChatConfig = require("uimodule.chat.chat_config")
local UnionHelper = require("uimodule.union.union_helper")
local UnionCfg = require("uimodule.union.union_config")
local ChatCfg = require("uimodule.chat.chat_config")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_pagelist = {
    "Pagelist",
    BIND_TYPE.OBJECT
  },
  v_apply_page = {
    "ApplyPage",
    BIND_TYPE.TOGGLE
  },
  v_member_page = {
    "MemberPage",
    BIND_TYPE.TOGGLE
  },
  v_invite_page = {
    "InvitePage",
    BIND_TYPE.TOGGLE
  },
  v_operate_panel = {
    "UnionOperate",
    BIND_TYPE.OBJECT
  },
  v_btn_change_icon = {
    "BtnChangeIcon",
    BIND_TYPE.BUTTON
  },
  v_btn_change_name = {
    "BtnChangeName",
    BIND_TYPE.BUTTON
  },
  v_btn_change_slogan = {
    "BtnChangeSlogan",
    BIND_TYPE.BUTTON
  },
  v_btn_chat = {
    "BtnChat",
    BIND_TYPE.BUTTON
  },
  v_chat_cont = {
    "ChatCont",
    BIND_TYPE.TEXT
  },
  v_union_info = {
    "UnionInfo",
    BIND_TYPE.OBJECT
  },
  v_icon = {
    "Icon",
    BIND_TYPE.IMAGE
  },
  v_member_num = {
    "MemberNum",
    BIND_TYPE.TEXT
  },
  v_union_leader = {
    "UnionLeader",
    BIND_TYPE.TEXT
  },
  v_union_name = {
    "UnionName",
    BIND_TYPE.TEXT
  },
  v_union_slogan = {
    "UnionSlogan",
    BIND_TYPE.TEXT
  }
}
local CHANGE_UNION_TYPE = UnionCfg.CHANGE_UNION_TYPE
local UNION_PAGES = UnionCfg.UNION_PAGES
local CHILDREN_UIS = {
  [UNION_PAGES.MEMBER] = {
    tog_name = "v_member_page",
    ui_name = "union_memeber"
  },
  [UNION_PAGES.INVITE] = {
    tog_name = "v_invite_page",
    ui_name = "union_invite"
  },
  [UNION_PAGES.APPLICATION] = {
    tog_name = "v_apply_page",
    ui_name = "union_application"
  }
}
local OPERATE_PANELS = {
  [CHANGE_UNION_TYPE.NAME] = "union_change_name",
  [CHANGE_UNION_TYPE.ICON] = "union_change_profile",
  [CHANGE_UNION_TYPE.SLOGAN] = "union_change_slogan"
}
local CHANGE_CB = {
  [CHANGE_UNION_TYPE.NAME] = function(ui, new_str)
    UnionMgr:request_change_union_info(CHANGE_UNION_TYPE.NAME, new_str, function(ok)
      local origin_str = ui.v_union_name.text
      local str = ok and new_str or origin_str
      ui.v_union_name.text = str
    end)
  end,
  [CHANGE_UNION_TYPE.ICON] = function(ui, new_icon)
    UnionMgr:request_change_union_info(CHANGE_UNION_TYPE.ICON, new_icon, function(ok)
      if ok then
        local icon = ui.v_icon
        ResMgr:load_set_icon(icon, UnionHelper.get_union_icon_path(new_icon))
      end
    end)
  end,
  [CHANGE_UNION_TYPE.SLOGAN] = function(ui, new_str)
    UnionMgr:request_change_union_info(CHANGE_UNION_TYPE.SLOGAN, new_str, function(ok)
      local origin_str = ui.v_union_slogan.text
      local str = ok and new_str or origin_str
      ui.v_union_slogan.text = str
    end)
  end
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnQuitUnion", function()
    self:_onclick_quit_btn()
  end)
  self:set_button("BtnChangeName", function()
    self:_show_operate_panel(CHANGE_UNION_TYPE.NAME)
  end)
  self:set_button("BtnChangeSlogan", function()
    self:_show_operate_panel(CHANGE_UNION_TYPE.SLOGAN)
  end)
  self:set_button("BtnChangeIcon", function()
    self:_show_operate_panel(CHANGE_UNION_TYPE.ICON)
  end)
  self:set_button("BtnChat", function()
    UIMgr:get_ui("union_chat"):ui_show(ChatCfg.CHANNEL_TYPE.GUILD)
  end)
  self.v_ui_canvas = self:get_canvas(nil, self.v_object)
  self.v_operate_canvas = self:get_canvas(nil, self.v_operate_panel)
  self.v_togs = {}
  for k, v in pairs(CHILDREN_UIS) do
    self.v_togs[k] = self[v.tog_name]
    self:set_toggle_listener(self[v.tog_name], function(isOn)
      self:_onclick_toggle(k, isOn)
    end)
  end
  local redPoint = self:get_child_gameobj("RedPoint", self.v_apply_page.gameObject)
  RedPointMgr:bind_redpoint(self, redPoint, RedEnum.JION_UNION_APPLY, RedEnum.UNION)
end

function ui:ui_on_show(tog_name, ...)
  local def_tog = self:_get_default_enter()
  if tog_name and tog_name >= UNION_PAGES.MEMBER then
    def_tog = tog_name
  end
  self.v_param = table.pack(...)
  self.v_show_chat = false
  self.v_cur_tog = ""
  self:_set_union_info()
  self:_reset_operate_panels()
  self.v_togs[def_tog].isOn = true
  self:_onclick_toggle(def_tog, true)
  self:refresh_chat_content()
  self:_regist_client_event()
end

function ui:ui_on_hide()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_UNION_CHAT_MSG_UPDATE, self.refresh_chat_content, self)
  self:bind_auto_mq(Const.MSG_ON_UNION_INFO_UPDATE, self._set_union_info, self)
  self:bind_auto_mq(Const.MSG_ON_HAS_UNION_STATE_UPDATE, self._response_in_union_state_update, self)
  self:bind_auto_mq(Const.MSG_ON_UNION_TITLE_UPDATE, self._response_union_title_update, self)
end

function ui:_set_union_info()
  self.v_union_info = UnionMgr:get_union_info()
  if not self.v_union_info then
    return
  end
  ResMgr:load_set_icon(self.v_icon, UnionHelper.get_union_icon_path(self.v_union_info.icon))
  self.v_union_name.text = self.v_union_info.name
  self.v_union_leader.text = UnionMgr:get_leader_info().name
  self.v_member_num.text = string.format("%s/%s", self.v_union_info.member_num, self.v_union_info.member_num_limit)
  self.v_union_slogan.text = self.v_union_info.idea
  self:_set_authority()
end

function ui:_set_authority()
  local title = UnionMgr:get_my_union_title()
  self.v_invite_page:SetActive(title & UnionCfg.GUILD_AUTH_LIST.INVITE_ROLE > 0)
  self.v_apply_page:SetActive(title & UnionCfg.GUILD_AUTH_LIST.ACCEPT_JOIN > 0)
  self.v_btn_change_icon:SetActive(title & UnionCfg.GUILD_AUTH_LIST.CHANGE_ICON > 0)
  self.v_btn_change_name:SetActive(title & UnionCfg.GUILD_AUTH_LIST.RENAME > 0)
  self.v_btn_change_slogan:SetActive(title & UnionCfg.GUILD_AUTH_LIST.CHANGE_IDEA > 0)
end

function ui:_reset_operate_panels()
  for _, v in pairs(OPERATE_PANELS) do
    self.v_panels[v]:set_enable(false)
  end
  self.v_operate_canvas.sortingOrder = 0
end

function ui:_get_default_enter()
  return UNION_PAGES.MEMBER
end

function ui:_onclick_toggle(tog_name, isOn)
  if not isOn or self.v_cur_tog == tog_name then
    return
  end
  self.v_cur_tog = tog_name
  if self.v_cur_child then
    self.v_cur_child:ui_hide()
  end
  self.v_cur_child = UIMgr:get_ui(CHILDREN_UIS[tog_name].ui_name)
  self.v_cur_child:ui_show(table.unpack(self.v_param))
end

function ui:_onclick_quit_btn()
  local is_leader = UnionMgr:get_is_union_leader()
  if is_leader then
    self:_leader_quit_union()
  else
    self:_member_quit_union()
  end
end

function ui:_leader_quit_union()
  local list = UnionMgr:get_member_list()
  if #list >= 2 then
    Util.show_message_tip(2305)
    return
  end
  local desc = Util.format_str("是否确认解散公会？")
  
  local function conform_callback()
    UnionMgr:request_quit_union(function()
      UIMgr:try_hide_ui("union_main")
    end)
  end
  
  Util.show_conform_tip(desc, nil, nil, nil, conform_callback)
end

function ui:_member_quit_union()
  local desc = Util.format_str("是否确认退出公会？")
  
  local function conform_callback()
    UnionMgr:request_quit_union(function()
      UIMgr:try_hide_ui("union_main")
    end)
  end
  
  Util.show_conform_tip(desc, nil, nil, nil, conform_callback)
end

function ui:_show_operate_panel(panel_type)
  self:_reset_operate_panels()
  self.v_operate_canvas.sortingOrder = self.v_ui_canvas.sortingOrder + 2
  local panel_ui = OPERATE_PANELS[panel_type]
  local callback = CHANGE_CB[panel_type]
  self.v_panels[panel_ui]:set_enable(true, callback, self)
end

function ui:refresh_chat_content()
  local msg = ChatMgr:get_latest_msg()
  if nil == msg then
    self.v_chat_cont.text = Util.format_str("当前暂无聊天信息")
    return
  end
  local prefix = string.format("【%s】", ChatConfig.CHANNLE_LIST[msg.channel][1])
  if msg.channel == ChatConfig.CHANNEL_TYPE.SYSTEM then
    local content = msg.chatInfo.notify_msg.msg
    self.v_chat_cont.text = string.format("%s %s", prefix, content)
  else
    local speaker_name = msg.chatInfo.speaker and msg.chatInfo.speaker.name .. "：" or ""
    local content = msg.chatInfo.msg.msg
    local face_character = self:_get_is_face(content)
    if face_character then
      local cfg = ChatConfig.chat_face[face_character]
      content = string.format("[%s]", cfg.name)
    end
    self.v_chat_cont.text = string.format("%s %s%s", prefix, speaker_name, content)
  end
end

function ui:_get_is_face(msg)
  for v in string.gmatch(msg, "%[%d+%]") do
    return v
  end
end

function ui:_response_in_union_state_update(msg)
  local in_union = msg.mm_x
  if in_union then
    return
  end
  self:ui_hide()
  self.v_parent_panel:ui_on_show()
end

function ui:_response_union_title_update(msg)
  self:_set_authority()
end

return ui
