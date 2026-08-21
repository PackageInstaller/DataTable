local Base = require("ui.uiobject")
local CommonDef = require("cs_share.common_define")
local OnlineConfig = require("gamelogic.activity.online_config")
local ui = Util.create_child_mt(Base)
local Act_ID = CommonDef.ACTY_TYPE.ONLINE_BATTLE
local ROOM_CHANGE_TYPE = CommonDef.ROOM_CHANGE_TYPE
local ROOM_ABOUT_MAP = CommonDef.ROOM_ABOUT_MAP
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_apply_friend = {
    "BtnApplyFriend",
    BIND_TYPE.BUTTON
  },
  v_btn_captain = {
    "BtnCaptain",
    BIND_TYPE.BUTTON
  },
  v_btn_close_content = {
    "BtnCloseContent",
    BIND_TYPE.BUTTON
  },
  v_btn_content = {
    "BtnContent",
    BIND_TYPE.IMAGE
  },
  v_btn_kick_out = {
    "BtnKickOut",
    BIND_TYPE.BUTTON
  },
  v_btn_player_info = {
    "BtnPlayerInfo",
    BIND_TYPE.BUTTON
  },
  v_captain = {
    "Captain",
    BIND_TYPE.IMAGE
  },
  v_frame = {
    "Frame",
    BIND_TYPE.IMAGE
  },
  v_friend = {
    "Friend",
    BIND_TYPE.BUTTON
  },
  v_guild = {
    "Guild",
    BIND_TYPE.BUTTON
  },
  v_hero_click_btn = {
    "HeroClickBtn",
    BIND_TYPE.BUTTON
  },
  v_hero_info = {
    "HeroInfo",
    BIND_TYPE.OBJECT
  },
  v_hero_rew_img = {
    "HeroRewImg",
    BIND_TYPE.RAW_IMAGE
  },
  v_join_player_btn = {
    "JoinPlayerBtn",
    BIND_TYPE.BUTTON
  },
  v_join_player_way = {
    "JoinPlayerWay",
    BIND_TYPE.OBJECT
  },
  v_player_name = {
    "PlayerName",
    BIND_TYPE.TEXT
  },
  v_player_state = {
    "PlayerState",
    BIND_TYPE.IMAGE
  },
  v_player = {
    "Player",
    BIND_TYPE.OBJECT
  },
  v_state_text = {
    "StateText",
    BIND_TYPE.TEXT
  },
  v_time_num = {
    "TimeNum",
    BIND_TYPE.TEXT
  },
  v_time = {
    "Time",
    BIND_TYPE.TEXT
  },
  v_waitting = {
    "Waitting",
    BIND_TYPE.TEXT
  },
  v_zhanli = {
    "Zhanli",
    BIND_TYPE.TEXT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnApplyFriend", function()
    self:_onclick_add_friend_btn()
  end)
  self:set_button("BtnCaptain", function()
    self:_onclick_transfer_captain_btn()
  end)
  self:set_button("BtnCloseContent", function()
    self:_onclick_close_operate_btn()
  end)
  self:set_button("BtnKickOut", function()
    self:_onclick_kick_out_btn()
  end)
  self:set_button("BtnPlayerInfo", function()
    self:_onclick_player_info_btn()
  end)
  self:set_button("Friend", function()
    self:_onclick_invite_friend_btn()
  end)
  self:set_button("HeroClickBtn", function()
    self:_onclick_change_hero_btn()
  end)
  self:set_button("JoinPlayerBtn", function()
    self:_onclick_invit_btn()
  end)
  self:set_button("JoinPlayerWay", function()
    self:_onclick_close_invite_btn()
  end)
end

function ui:ui_on_show(pos, member_list, ...)
  self.v_pos_idx = pos
  local member_info = member_list[pos]
  self:_reset_member_view()
  if not member_info then
    return
  end
  self.v_member_list = member_list
  self.v_member_info = member_info
  self:_refresh_member_info()
  self:_refresh_role_info()
  self.v_parent_ui:set_model(self.v_pos_idx, self.v_member_info.buddy_info.id, self.v_member_info.buddy_info.fashion)
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_CHAR_SELECT, self._response_char_select, self)
  self:bind_auto_mq(Const.MSG_ON_CHOOSE_ROLE, self._refresh_choose_role_event, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self._response_ui_hide_event, self)
end

function ui:_response_char_select(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  self.v_choose_buddy_id = msg.mm_obj.id
end

function ui:_refresh_choose_role_event()
  ActivityMgr:invoke(Act_ID, "request_change_roomstate", ROOM_CHANGE_TYPE.ROLE_ID, self.v_choose_buddy_id)
end

function ui:_response_ui_hide_event(msg)
  if msg.mm_obj ~= "character_enter" then
    return
  end
  if not self.v_open_character then
    return
  end
  self.v_open_character = nil
  ActivityMgr:invoke(Act_ID, "request_change_roomstate", ROOM_CHANGE_TYPE.PLAYER_STATE, ROOM_ABOUT_MAP.STATE_MAP.NOT_READY)
end

function ui:ui_on_hide()
  self.v_pos_idx = nil
  self.v_member_list = nil
  self.v_member_info = nil
  self.v_open_character = nil
end

function ui:_reset_member_view()
  self.v_time:SetActive(false)
  self.v_player:SetActive(false)
  self.v_hero_info:SetActive(false)
  self.v_player_state:SetActive(false)
  self.v_waitting:SetActive(true)
  self.v_btn_content:SetActive(false)
  self.v_hero_click_btn:SetActive(false)
  self.v_join_player_btn:SetActive(true)
  self.v_join_player_way:SetActive(false)
  self.v_frame:SetActive(true)
end

function ui:_refresh_member_info()
  self.v_player:SetActive(true)
  self.v_waitting:SetActive(false)
  self.v_frame:SetActive(false)
  self.v_is_leader = self.v_member_info.pos == OnlineConfig.MEMBER_TITLE.LEADER
  self.v_captain:SetActive(self.v_is_leader)
  self.v_player_name.text = self.v_member_info.player_name
  for _, v in ipairs(self.v_member_list) do
    if v.uuid ~= self.v_member_info.uuid and v.buddy_info.id == self.v_member_info.buddy_info.id then
      self.v_player_state:SetActive(true)
      return
    end
  end
end

function ui:_refresh_role_info()
  self.v_hero_info:SetActive(true)
  self.v_hero_click_btn:SetActive(true)
  self.v_join_player_btn:SetActive(false)
  self.v_zhanli.text = self.v_member_info.buddy_info.power
end

function ui:_onclick_change_hero_btn()
  if Global.player_uuid == self.v_member_info.uuid then
    local pos_data = {}
    for _, v in ipairs(self.v_member_list) do
      table.insert(pos_data, {
        buddy_id = v.buddy_info.id
      })
    end
    local team_data = {
      select_pos = self.v_pos_idx,
      select_buddy_id = self.v_member_info.buddy_info.id,
      pos_data = pos_data
    }
    if not self.v_is_leader then
      ActivityMgr:invoke(Act_ID, "request_change_roomstate", ROOM_CHANGE_TYPE.PLAYER_STATE, ROOM_ABOUT_MAP.STATE_MAP.CHOICE_ROLE)
      self.v_open_character = true
    end
    
    local function cb()
      self.v_parent_ui:set_model_disable()
    end
    
    UIMgr:get_ui("character_enter"):ui_show(team_data, cb, Config.TEAM_TYPE.ONLINE_BATTLE)
  else
    self:_refresh_operate_btns()
  end
end

function ui:_onclick_invit_btn()
  self.v_join_player_way:SetActive(true)
  self.v_join_player_btn:SetActive(false)
end

function ui:_onclick_close_invite_btn()
  self.v_join_player_way:SetActive(false)
  self.v_join_player_btn:SetActive(true)
end

function ui:_onclick_invite_friend_btn()
  UIMgr:get_ui("uifriend"):ui_show({show_type = 2})
end

function ui:_refresh_operate_btns()
  local is_leader = ActivityMgr:invoke(Act_ID, "get_is_leader")
  self.v_btn_content:SetActive(true)
  self.v_btn_captain:SetActive(is_leader)
  self.v_btn_kick_out:SetActive(is_leader)
  local can = FriendMgr:check_applied_by_uuid(self.v_member_info.uuid)
  if can then
    Util.enable_btn(self.v_btn_apply_friend)
  else
    Util.disable_btn(self.v_btn_apply_friend, true)
  end
end

function ui:_onclick_add_friend_btn()
  local function apply_callback()
    Util.show_message_tip(2194)
  end
  
  FriendMgr:apply_add_friend(self.v_member_info.uuid, apply_callback)
end

function ui:_onclick_transfer_captain_btn()
  ActivityMgr:invoke(Act_ID, "request_room_transfer_capatin", self.v_member_info.uuid)
end

function ui:_onclick_kick_out_btn()
  ActivityMgr:invoke(Act_ID, "request_kickout_player", self.v_member_info.uuid)
end

function ui:_onclick_player_info_btn()
  UIMgr:get_ui("ui_player_info"):ui_show(self.v_member_info.buddy_info)
end

function ui:_onclick_close_operate_btn()
  self.v_btn_content:SetActive(false)
end

return ui
