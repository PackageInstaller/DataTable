local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local _insert = table.insert
local _sort = table.sort
local PLAY_SET_TITLE = require("uimodule.player.player_set_title")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local Char_Helper = require("uimodule.character.char_helper")
local CommonDefind = require("cs_share.common_define")
local FRIEND_STATE = CommonDefind.FRIEND_STATE
local CSColor = UnityEngine.Color
local FRIEND_CHAT_SYS_ID = 12
local GuiUtil = UnityEngine.GUIUtility
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local _sformat = string.format
local COLOR_NAME = Util.get_unity_color_by_hex(tonumber("292929", 16))
local COLOR_MARK = Util.get_unity_color_by_hex(tonumber("8D4B15", 16))
local COLOR_WHITE = Util.get_unity_color_by_hex(tonumber("FFFFFF", 16))
local MODEL = {
  v_player_content = {
    "PlayerContent",
    BIND_TYPE.OBJECT
  },
  v_player_template = {
    "PlayerTem",
    BIND_TYPE.OBJECT
  }
}
local PLAYER_OBJ_KEY = "PLAYER_OBJ_KEY"
local APPLY_PLAYER_OBJ_KEY = "APPLY_PLAYER_OBJ_KEY"
local RCMD_PLAYER_OBJ_KEY = APPLY_PLAYER_OBJ_KEY
local PAGE_TYPE = {
  FRIEND_LIST = 1,
  APPLY_LIST = 2,
  RECOMMEND = 2
}
local PAGE_IDX_TYPE = {
  [1] = "FRIEND_LIST",
  [2] = "RECOMMEND",
  [3] = "APPLY_LIST"
}
local SUB_PAGE_TYPE = {RECOMMEND = 2, APPLY_LISY = 3}
local SORT_KEY = {
  [PAGE_TYPE.FRIEND_LIST] = {
    {"sort_line", false},
    {"lv", true},
    {"uuid", false}
  },
  [PAGE_TYPE.APPLY_LIST] = {
    {"apply_time", false}
  }
}
local FRIEND_MAX_NUM = ShareRes.get_system_comm_value("FriendNumLimit")
local APPLY_MAX_NUM = ShareRes.get_system_comm_value("ApplyFriendNumLimit")
local COLOR_INDEX = {
  ONLINE = 1,
  CHOOSE = 2,
  OFFLINE = 3
}
local COLOR_TYPE = {
  TOG_TEXT_NORMAL = {
    color = Util.get_unity_color_by_hex("BCB4A5")
  },
  TOG_TEXT_SELECT = {
    color = Util.get_unity_color_by_hex("000000")
  },
  ONLINE = {
    color_txt = Util.get_unity_color_by_hex("ffffff"),
    color_img = Util.get_unity_color_by_hex("1e9d79")
  },
  OFFLINE = {
    color_txt = Util.get_unity_color_by_hex("c9c5bc"),
    color_img = Util.get_unity_color_by_hex("292929")
  }
}
local SYS_REDPOINT_ID = 6
local FRIEND_LIST_REDPOINT = 7
local FRIEND_ADD_REDPOINT = 8
local SHOW_TYPE = {NORMAL = 1, INVITE = 2}
local Act_ID = CommonDefind.ACTY_TYPE.ONLINE_BATTLE

local function sort_list(type, a, b)
  local sort_key = SORT_KEY[type]
  for index, sort_data in ipairs(sort_key) do
    local key = sort_data[1]
    local is_max = sort_data[2]
    if a[key] ~= b[key] then
      if is_max then
        return a[key] > b[key]
      else
        return a[key] < b[key]
      end
    end
  end
  return false
end

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
    UIMgr:try_destory_ui("player_hero")
    self.v_last_page = nil
  end)
  self:set_button("BtnChangeRemark", function()
    if not self.v_select_uuid then
      return
    end
    self.v_uiobjects.BtnCloseFrendContent:SetActive(false)
    UIMgr:get_ui("ui_remark_tip"):ui_show(self.v_select_uuid)
  end)
  self:set_button("BtnDeleteFriend", function()
    if not self.v_select_uuid then
      return
    end
    
    local function conform_callback()
      FriendMgr:delete_friend(self.v_select_uuid)
      self.v_uiobjects.BtnCloseFrendContent:SetActive(false)
      self.v_select_uuid = nil
    end
    
    local desc = Util.get_i18n("确认删除该好友")
    Util.show_conform_tip(desc, nil, nil, nil, conform_callback)
  end)
  self:set_button("BtnVisitingcard", function()
    if self.v_cur_player_data then
      UIMgr:get_ui("ui_player_new_info"):ui_show(self.v_cur_player_data)
    end
  end)
  self:set_button("BtnRefuseAll", function()
    if #self.v_player_obj_list <= 0 then
      return
    end
    
    local function conform_callback()
      self.v_apply_list = {}
      FriendMgr:refuse_all_friend_apply()
    end
    
    local desc = Util.get_i18n("是否拒绝全部好友申请？")
    Util.show_conform_tip(desc, nil, nil, nil, conform_callback)
  end)
  self:set_button("BtnApplyAllRecive", function()
    if #self.v_player_obj_list <= 0 then
      return
    end
    self.v_apply_list = {}
    FriendMgr:get_all_friend_apply()
  end)
  self:set_button("BtnFightInviteAll", function()
    self:_onclick_invite_all_btn()
  end)
  self:set_button("BtnFightInvite", function()
    self:_onclick_invite_btn()
  end)
  self:set_button("CopyBtn", function()
    CS.GoogleDeviceUtilities.CopyToClipboard(PlayerMgr:get_player_uid())
    Util.show_message_tip(2193)
  end)
  self.v_uiobjects.BtnBlackName:SetActive(false)
  self:set_button("BtnBlackName", function()
  end)
  self:set_button("BtnCloseFrendContent", function()
    self.v_uiobjects.BtnFriendContent:SetActive(false)
    self.v_uiobjects.BtnCloseFrendContent:SetActive(false)
    self.v_select_uuid = nil
  end)
  self:set_button("BtnReciveGiftAll", function()
    self:_onclick_receive_all_btn()
  end)
  self.v_sub_page = SUB_PAGE_TYPE.RECOMMEND
  self.v_select_eff_rcd = Util.get_child_gameobj("SelectEff", self.v_uiobjects.TogRecommend)
  self.v_select_eff_apply = Util.get_child_gameobj("SelectEff", self.v_uiobjects.TogAskFor)
  self:set_toggle("TogRecommend", function(isOn)
    if isOn then
      self.v_sub_page = SUB_PAGE_TYPE.RECOMMEND
      self.v_uiobjects.BtnSwitchRCD:SetActive(true)
      self:refresh_friends_recommend()
      self.v_select_eff_rcd:SetActive(true)
      self.v_select_eff_apply:SetActive(false)
      self.v_uicompents.AddFriendBg_rect:SetActive(false)
    end
  end, true)
  self:set_toggle("TogAskFor", function(isOn)
    if isOn then
      self.v_sub_page = SUB_PAGE_TYPE.APPLY_LISY
      self.v_uiobjects.BtnSwitchRCD:SetActive(false)
      self:refresh_apply_list()
      self.v_select_eff_rcd:SetActive(false)
      self.v_select_eff_apply:SetActive(true)
      self.v_uicompents.AddFriendBg_rect:SetActive(false)
    end
  end)
  self:set_button("BtnSwitchRCD", function()
    self.v_uicompents.BtnSwitchRCD_btn.enabled = false
    local btn_text = Util.get_text("Text", self.v_uiobjects.BtnSwitchRCD)
    local cd_time = 3
    self:start_btn_cd(self.v_uicompents.BtnSwitchRCD_btn, btn_text, cd_time)
    self.v_uicompents.ApPlayerCont_rect:SetAnchoredPositionA(0, 0)
    FriendMgr:request_get_recommendlist()
  end)
  self.v_set_title_obj = {}
  self:register_exist_auto_template(PLAYER_OBJ_KEY, self.v_player_template, self.v_player_content)
  self:register_exist_auto_template(APPLY_PLAYER_OBJ_KEY, self.v_uiobjects.ApPlayerTem, self.v_uiobjects.ApPlayerCont)
end

function ui:init_event()
  self:bind_auto_mq(Const.MSG_ON_CHANGE_FRIEND_NOTE, self.update_player_note, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_FRIEND_LIST, self.refresh_player_list, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_FRIEND_SHIP, self.refresh_player_list, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_APPLY_FRIEND_LIST, self.refresh_apply_list, self)
  self:bind_auto_mq(Const.MSG_FRIEND_SEARCH_CHAT_MSG_UPDATE, self._refresh_chat_bysearch, self)
  self:bind_auto_mq(Const.MSG_ON_INVITE_FRIEND_CD_FINISH, self._response_invite_cd_event, self)
  self:bind_auto_mq(Const.MSG_ON_GET_NEW_RCMD_LIST, self.refresh_friends_recommend, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_FRIEND_STATE, self.update_player_state, self)
end

function ui:click_accept()
  if not self.v_select_uuid then
    return
  end
  local friend_num = self.v_select_data.friend_num
  if friend_num >= FRIEND_MAX_NUM then
    Util.show_message_tip(1721)
    return
  end
  local cur_friend_num = FriendMgr:get_friend_num()
  if cur_friend_num >= FRIEND_MAX_NUM then
    Util.show_message_tip(1403)
    return
  end
  FriendMgr:accept_friend_apply(self.v_select_uuid, function()
    self:refresh_apply_list()
    self.v_cur_amountfriend = self.v_cur_amountfriend or 0
    self.v_cur_amountfriend = self.v_cur_amountfriend + 1
    self.v_uicompents.AmountHaveFriend_txt.text = self.v_cur_amountfriend
  end)
end

function ui:ui_on_show(data, ...)
  self.v_panels.search_player:set_enable(false)
  self:init_event()
  self.v_player_obj_list = {}
  self.v_apply_list = {}
  self:_init_page_list()
  self:refresh_red()
  if data and data.chat_friend then
    self.v_chat_friend = data.chat_friend
  end
  if data and data.show_type then
    self.v_show_type = data.show_type
  end
  self.v_uiobjects.BtnFriendContent:SetActive(false)
  self.v_uiobjects.BtnCloseFrendContent:SetActive(false)
  self.v_uicompents.PlayerLv_txt.text = PlayerMgr:get_role_lv()
  self.v_uicompents.IDNum_txt.text = PlayerMgr:get_player_uid()
  self.v_uicompents.PlayerName_txt.text = PlayerMgr:get_player_name()
  self:set_default_sub_page()
  self:refresh_list()
  self:_refresh_show_type()
end

function ui:set_default_sub_page()
  local apply_list = FriendMgr:get_apply_list()
  if apply_list and next(apply_list) then
    self.v_sub_page = SUB_PAGE_TYPE.APPLY_LISY
  else
    self.v_sub_page = SUB_PAGE_TYPE.RECOMMEND
  end
end

function ui:refresh_list()
  if not self.v_last_page then
    self.v_last_page = PAGE_TYPE.FRIEND_LIST
  end
  
  local function callback()
    self:set_default_sub_page()
    self:_on_click_page(self.v_last_page, true)
  end
  
  FriendMgr:request_get_friend_list(callback)
  FriendMgr:request_get_apply_list()
end

function ui:ui_on_hide()
  if self.v_player_obj_list and next(self.v_player_obj_list) then
    for _, v in ipairs(self.v_player_obj_list) do
      RedPointMgr:unbind_redpoint_by_id(self, v.data.uuid, FRIEND_LIST_REDPOINT)
    end
  end
  if self.v_time_index then
    Timer:remove_timer(self.v_time_index)
    self.v_time_index = nil
  end
  self.v_in_chat_friend = nil
  self.v_select_uuid = nil
  self.v_delete = false
  self.v_select_index = nil
  self.v_show_type = nil
  self.v_chat_friend = nil
  FriendMgr:update_red()
end

function ui:ui_update(delta_time)
  self.v_panels.search_player:ui_update()
end

function ui:set_friend_list_red_point(flag)
  local red = self:get_child_gameobj("RedPoint", self.v_uicompents.Page_friendlist_tog.gameObject)
  local red2 = self:get_child_gameobj("ReciveGiftRed_", self.v_uiobjects.BtnReciveGiftAll.gameObject)
  red:SetActive(flag)
  red2:SetActive(flag)
end

function ui:_init_page_list()
  local pages = {}
  _insert(pages, self.v_uicompents.Page_friendlist_tog)
  _insert(pages, self.v_uicompents.Page_addfriend_tog)
  _insert(pages, self.v_uicompents.Page_Apply_tog)
  self.v_toggle_list = pages
  if not self.v_last_page then
    self.v_last_page = PAGE_TYPE.FRIEND_LIST
  end
  local red = self:get_child_gameobj("RedPoint", self.v_uicompents.Page_friendlist_tog.gameObject)
  RedPointMgr:bind_redpoint(self, red, FRIEND_LIST_REDPOINT, SYS_REDPOINT_ID)
  red = self:get_child_gameobj("RedPoint", self.v_uicompents.Page_addfriend_tog.gameObject)
  red:SetActive(false)
  red = self:get_child_gameobj("RedPoint", self.v_uicompents.Page_Apply_tog.gameObject)
  RedPointMgr:bind_redpoint(self, red, FRIEND_ADD_REDPOINT, SYS_REDPOINT_ID)
  self.v_page_toggle_tab = ToggleTab:new(self)
  self.v_page_toggle_tab:init_by_toggles(pages, function(idx)
    if "APPLY_LIST" == PAGE_IDX_TYPE[idx] then
      self.v_sub_page = SUB_PAGE_TYPE.APPLY_LISY
      self.v_uiobjects.BtnSwitchRCD:SetActive(false)
      self:refresh_apply_list()
      self.v_select_eff_rcd:SetActive(false)
      self.v_select_eff_apply:SetActive(true)
      self.v_uicompents.AddFriendBg_rect:SetActive(false)
      FriendMgr:set_apply_list_red_point(true)
    elseif "RECOMMEND" == PAGE_IDX_TYPE[idx] then
      self.v_sub_page = SUB_PAGE_TYPE.RECOMMEND
      self.v_uiobjects.BtnSwitchRCD:SetActive(true)
      self:refresh_friends_recommend()
      self.v_select_eff_rcd:SetActive(true)
      self.v_select_eff_apply:SetActive(false)
      self.v_uicompents.AddFriendBg_rect:SetActive(false)
    end
    self:_on_click_page(PAGE_TYPE[PAGE_IDX_TYPE[idx]])
  end, self.v_last_page)
  self:_on_click_page(self.v_last_page)
end

function ui:refresh_player_list()
  if self.v_last_page == PAGE_TYPE.FRIEND_LIST then
    self:_on_click_page(PAGE_TYPE.FRIEND_LIST, false)
  end
  self.v_uicompents.AmountHaveFriend_txt.text = FriendMgr:get_friend_num()
end

function ui:refresh_apply_list()
  if self.v_last_page == PAGE_TYPE.APPLY_LIST then
    self:_on_click_page(PAGE_TYPE.APPLY_LIST, false)
  end
  local red_point = Util.get_child_gameobj("RedPoint", self.v_uiobjects.Page_Apply)
  red_point:SetActive(false)
  local apply_list = FriendMgr:get_apply_list()
  if apply_list then
    local count = 0
    for _, data in pairs(apply_list) do
      count = count + 1
    end
    self.v_uicompents.AmountHaveApply_txt.text = count
    self.v_uicompents.AmountMaxApply_txt.text = APPLY_MAX_NUM
    if count > 0 then
      red_point:SetActive(FriendMgr:get_apply_list_red_point())
    end
  end
end

function ui:set_tog_text_color(page)
  if page == PAGE_TYPE.APPLY_LIST then
    self.v_uicompents.FriendLab_txt.color = COLOR_TYPE.TOG_TEXT_NORMAL.color
    self.v_uicompents.AddFriendLab_txt.color = COLOR_TYPE.TOG_TEXT_SELECT.color
  elseif page == PAGE_TYPE.FRIEND_LIST then
    self.v_uicompents.FriendLab_txt.color = COLOR_TYPE.TOG_TEXT_SELECT.color
    self.v_uicompents.AddFriendLab_txt.color = COLOR_TYPE.TOG_TEXT_NORMAL.color
  end
end

function ui:_on_click_page(page, is_refresh)
  if page == self.v_last_page and is_refresh then
    return
  end
  self.v_last_page = page
  self:set_tog_text_color(page)
  local is_friend_list = self.v_last_page == PAGE_TYPE.FRIEND_LIST
  self.v_uicompents.BtnApplyContent_rect:SetActive(not is_friend_list)
  self.v_uicompents.Amount_addFriend_rect:SetActive(not is_friend_list)
  self.v_uicompents.AddFriendBg_rect:SetActive(false)
  self.v_uicompents.ApplyBtnContent_rect:SetActive(false)
  self.v_uiobjects.EmptyTips:SetActive(false)
  self.v_uiobjects.BtnRefuseAll:SetActive(page == PAGE_TYPE.APPLY_LIST)
  self.v_uiobjects.BtnApplyAllRecive:SetActive(page == PAGE_TYPE.APPLY_LIST)
  self.v_uiobjects.BtnInviteContent:SetActive(page == PAGE_TYPE.FRIEND_LIST and self.v_show_type == SHOW_TYPE.INVITE)
  self.v_uiobjects.BtnFightInvite:SetActive(false)
  self.v_uiobjects.ApplyPlayer:SetActive(page == PAGE_TYPE.APPLY_LIST)
  self.v_uiobjects.FriendPnl:SetActive(page == PAGE_TYPE.FRIEND_LIST)
  local list_num = 0
  local tip = ""
  self.v_uicompents.FriendLab_txt.color = COLOR_WHITE
  self.v_uicompents.AddFriendLab_txt.color = COLOR_WHITE
  if page == PAGE_TYPE.FRIEND_LIST then
    self.v_apply_list = {}
    self:update_friend_list()
    list_num = #self.v_player_obj_list
    self.v_cur_amountfriend = list_num
    self.v_uicompents.AmountHaveFriend_txt.text = list_num
    self.v_uicompents.AmountMaxFriend_txt.text = FRIEND_MAX_NUM
    self.v_uiobjects.EmptyTips:SetActive(list_num <= 0)
    self.v_panels.search_player:set_enable(false)
    if is_refresh then
      self.v_uicompents.PlayerContent_rect:SetAnchoredPositionA(0, 0)
    end
    tip = Util.get_i18n("暂无好友")
    self.v_uiobjects.BtnSwitchRCD:SetActive(false)
  elseif page == PAGE_TYPE.APPLY_LIST and self.v_sub_page == SUB_PAGE_TYPE.APPLY_LISY then
    self.v_uicompents.AddFriendBg_rect:SetActive(false)
    self.v_select_eff_rcd:SetActive(false)
    self.v_select_eff_apply:SetActive(true)
    FriendMgr:request_get_apply_list()
    self:update_apply_list()
    self.v_in_chat_friend = nil
    list_num = #self.v_player_obj_list
    self.v_uicompents.AmountHaveApply_txt.text = list_num
    self.v_uicompents.AmountMaxApply_txt.text = APPLY_MAX_NUM
    local is_show_Refuse_btn = false
    for _, info in ipairs(self.v_player_obj_list) do
      local char_data = info.data
      if not char_data.friend_status or char_data.friend_status == FRIEND_STATE.APPLY then
        is_show_Refuse_btn = true
        break
      end
    end
    self.v_uiobjects.EmptyTips:SetActive(list_num <= 0)
    self.v_panels.search_player:set_enable(true)
    self.v_uicompents.BtnRefuseAll_btn:SetActive(is_show_Refuse_btn)
    self.v_uicompents.BtnApplyAllRecive_btn:SetActive(is_show_Refuse_btn)
    if is_refresh then
      self.v_uicompents.ApPlayerCont_rect:SetAnchoredPositionA(0, 0)
    end
    tip = Util.get_i18n("暂无好友申请")
    self.v_uiobjects.BtnSwitchRCD:SetActive(false)
  elseif page == PAGE_TYPE.APPLY_LIST and self.v_sub_page == SUB_PAGE_TYPE.RECOMMEND then
    self.v_uicompents.AddFriendBg_rect:SetActive(false)
    self.v_uicompents.ApPlayerCont_rect:SetAnchoredPositionA(0, 0)
    self.v_select_eff_rcd:SetActive(true)
    self.v_select_eff_apply:SetActive(false)
    self:refresh_friends_recommend()
    self.v_in_chat_friend = nil
    local is_show_Refuse_btn = false
    for _, info in ipairs(self.v_player_obj_list) do
      local char_data = info.data
      if not char_data.friend_status or char_data.friend_status == FRIEND_STATE.APPLY then
        is_show_Refuse_btn = true
        break
      end
    end
    list_num = #self.v_player_obj_list
    self.v_uiobjects.EmptyTips:SetActive(list_num <= 0)
    self.v_panels.search_player:set_enable(true)
    self.v_uicompents.BtnRefuseAll_btn:SetActive(false)
    self.v_uicompents.BtnApplyAllRecive_btn:SetActive(false)
    if is_refresh then
      self.v_uicompents.ApPlayerCont_rect:SetAnchoredPositionA(0, 0)
    end
    tip = Util.get_i18n("暂无推荐")
    self.v_uiobjects.BtnSwitchRCD:SetActive(true)
  end
end

function ui:update_friend_list()
  local friend_list = FriendMgr:get_friend_list()
  self:arrange_list(friend_list, PAGE_TYPE.FRIEND_LIST)
  self:update_receive_times()
end

function ui:check_insert_apply_list(uuid)
  for index = #self.v_apply_list, 1, -1 do
    local data = self.v_apply_list[index]
    if data.uuid == uuid then
      return false
    end
  end
  return true
end

function ui:update_apply_list()
  self.v_apply_list = {}
  local apply_list = FriendMgr:get_apply_list()
  for key, data in pairs(apply_list) do
    if self:check_insert_apply_list(data.uuid) then
      data.sort_line = 0
      if not data.offline_time or 0 ~= data.offline_time then
        data.sort_line = 1
      end
      _insert(self.v_apply_list, data)
    end
  end
  local cur_num = #self.v_apply_list
  if cur_num > APPLY_MAX_NUM then
    for index = cur_num, 1, -1 do
      if #self.v_apply_list <= APPLY_MAX_NUM then
        break
      end
      table.remove(self.v_apply_list, index)
    end
  end
  table.sort(self.v_apply_list, function(a, b)
    if a.apply_time == b.apply_time then
      return a.uuid < b.uuid
    end
    return a.apply_time > b.apply_time
  end)
  self:creat_apply_player_obj(self.v_apply_list)
end

function ui:refresh_friends_recommend_state()
  self.v_uicompents.BtnSwitchRCD_btn.enabled = true
end

function ui:start_btn_cd(btn, btn_text, cd_time)
  self.v_cd_btn_state = true
  FriendMgr:set_btn_cd_time(cd_time)
  self.v_cd_btn = btn
  self.v_cd_btn_text = btn_text
end

function ui:refresh_friends_recommend()
  self.v_friends_recommendlist = FriendMgr:get_friends_recommendlist()
  self:create_recommend_player_obj(self.v_friends_recommendlist)
end

function ui:arrange_list(list, sort_type)
  local new_list = {}
  for key, data in pairs(list) do
    data.sort_line = 0
    if not data.offline_time or 0 ~= data.offline_time then
      data.sort_line = 1
    end
    data.can_receive_friendship = FriendMgr:can_receive_friendship(data.uuid)
    data.can_send_friendship = FriendMgr:can_send_friendship(data.uuid)
    _insert(new_list, data)
  end
  _sort(new_list, function(a, b)
    return sort_list(sort_type, a, b)
  end)
  self:creat_player_obj(new_list)
end

function ui:creat_player_obj(list)
  if self.v_player_obj_list and next(self.v_player_obj_list) then
    for _, v in ipairs(self.v_player_obj_list) do
      RedPointMgr:unbind_redpoint_by_id(self, v.data.uuid, FRIEND_LIST_REDPOINT)
    end
  end
  local select_index = 1
  self.v_player_obj_list = {}
  self.v_player_uuid_list = {}
  self:set_friend_list_red_point(false)
  self:give_back_auto_cache(PLAYER_OBJ_KEY)
  for index, data in ipairs(list) do
    local obj = self:get_auto_cache(PLAYER_OBJ_KEY)
    _insert(self.v_player_obj_list, {obj = obj, data = data})
    self:update_player_info(obj, data, index)
    if self.v_select_uuid == data.uuid then
      select_index = index
      self.v_chat_friend = data.uuid
    end
    self.v_player_uuid_list[index] = data.uuid
  end
  local list_num = #self.v_player_obj_list
  if list_num <= 0 then
    return
  end
  if self.v_delete then
    if self.v_select_index then
      if self.v_select_index - list_num >= 0 then
        select_index = list_num
      else
        select_index = self.v_select_index
      end
    end
    self.v_delete = false
  end
end

function ui:creat_apply_player_obj(list)
  self.v_player_obj_list = {}
  self:give_back_auto_cache(APPLY_PLAYER_OBJ_KEY)
  for index, data in ipairs(list) do
    local obj = self:get_auto_cache(APPLY_PLAYER_OBJ_KEY)
    local add_obj = Util.get_child_gameobj("BtnAdd", obj)
    local add_had_obj = Util.get_child_gameobj("BtnHadAdd", obj)
    add_obj:SetActive(false)
    add_had_obj:SetActive(false)
    _insert(self.v_player_obj_list, {obj = obj, data = data})
    self:update_player_info(obj, data, index, nil, true)
  end
end

function ui:create_recommend_player_obj(list)
  self.v_player_obj_list = {}
  self:give_back_auto_cache(RCMD_PLAYER_OBJ_KEY)
  for index, data in ipairs(list) do
    local obj = self:get_auto_cache(RCMD_PLAYER_OBJ_KEY)
    local add_obj = Util.get_child_gameobj("BtnAdd", obj)
    local add_had_obj = Util.get_child_gameobj("BtnHadAdd", obj)
    local add_btn = Util.get_button(nil, add_obj)
    add_obj:SetActive(true)
    add_had_obj:SetActive(true)
    self:set_button_listener(add_btn, function()
      self:on_apply_add_friend(data)
    end)
    _insert(self.v_player_obj_list, {obj = obj, data = data})
    self:update_player_info(obj, data, index, true)
    self:update_player_state()
  end
  self.v_uiobjects.EmptyTips:SetActive(next(self.v_player_obj_list) == nil)
end

function ui:update_player_info(obj, player_data, index, is_rcd, is_apply)
  local lv_txt = Util.get_text("LvAmountBg/PlayerLv", obj)
  local name_txt = Util.get_text("PlayerName", obj)
  local state_bg = Util.get_child_gameobj("PlayerStateBg", obj)
  local state_bg_img = Util.get_image("PlayerStateBg", obj)
  local online_txt = Util.get_text("PlayerState", state_bg)
  local head_icon = Util.get_image("PlayerProfile", obj)
  local player_quotation = Util.get_text("PlayerQuotation", obj)
  lv_txt.text = player_data.lv
  name_txt.text = player_data.name
  name_txt.color = COLOR_NAME
  if player_data.note and player_data.note ~= "" then
    name_txt.text = player_data.note
    name_txt.color = COLOR_MARK
  end
  local line_txt = "离线"
  if 0 == player_data.offline_time then
    line_txt = "在线"
    state_bg_img.color = COLOR_TYPE.ONLINE.color_img
    Util.change_component_alpha(state_bg_img, 255)
  else
    local now_time = Date.server_time()
    local online_time = now_time - player_data.offline_time
    local time_tip = Date.get_time_desc2(online_time)
    line_txt = Util.format_str("{1}前在线", time_tip)
    state_bg_img.color = COLOR_TYPE.OFFLINE.color_img
    Util.change_component_alpha(state_bg_img, 153)
  end
  online_txt.text = Util.format_str(line_txt)
  Util.load_char_head_icon(head_icon, player_data.icon)
  player_quotation.text = "" ~= player_data.quotation and player_data.quotation or Util.get_i18n("请多多指教")
  local show_pos = Util.get_child("showPos", obj)
  local head_btn = Util.get_button("BtnFunction_", obj)
  if head_btn and show_pos then
    self:set_button_listener(head_btn, function()
      self.v_cur_player_data = player_data
      self:click_player_func_btn(show_pos.transform, player_data.uuid, is_rcd, is_apply)
    end)
  end
  local red_point_obj = Util.get_child("RedPoint_", obj)
  red_point_obj:SetActive(false)
  local apply_btn_obj = Util.get_child("BtnApplyContent_", obj)
  if apply_btn_obj and not is_rcd then
    local refuse_btn = Util.get_button("BtnRefuse_", apply_btn_obj)
    local accept_btn = Util.get_button("BtnAccept_", apply_btn_obj)
    self:set_button_listener(refuse_btn, function()
      self.v_select_uuid = player_data.uuid
      FriendMgr:remove_data_by_uuid(self.v_apply_list, self.v_select_uuid)
      FriendMgr:refuse_friend_apply(self.v_select_uuid)
    end)
    self:set_button_listener(accept_btn, function()
      self.v_select_uuid = player_data.uuid
      self.v_select_data = player_data
      self:click_accept()
    end)
  end
  if apply_btn_obj then
    apply_btn_obj:SetActive(not is_rcd)
  end
  local assistant_obj = Util.get_child("Assistant", obj)
  local aid_list = player_data.buddy_show_info.assist_buddys
  for i = 1, 3 do
    local char = Util.get_child("Char" .. i, assistant_obj)
    local is_show = 0 ~= aid_list[i].id
    char:SetActive(is_show)
    if is_show then
      self:set_assistant_roles(char, aid_list[i])
    end
  end
  local btn_receive_obj = Util.get_child("GiftButton/BtnReciveGift_", obj)
  if not btn_receive_obj then
    return
  end
  local btn_send_obj = Util.get_child("GiftButton/BtnGiveGift_", obj)
  local btn_gray_obj = Util.get_child("GiftButton/BtnHaveGiven_", obj)
  btn_receive_obj:SetActiveEx(player_data.can_receive_friendship)
  btn_send_obj:SetActiveEx(player_data.can_send_friendship and not player_data.can_receive_friendship)
  btn_gray_obj:SetActiveEx(not player_data.can_send_friendship and not player_data.can_receive_friendship)
  red_point_obj:SetActive(player_data.can_receive_friendship)
  if player_data.can_receive_friendship then
    self:set_friend_list_red_point(true)
  end
  local btn_receive = Util.get_button(nil, btn_receive_obj)
  local btn_send = Util.get_button(nil, btn_send_obj)
  self:set_button_listener(btn_receive, function()
    FriendMgr:receive_friendship(player_data.uuid)
  end)
  self:set_button_listener(btn_send, function()
    FriendMgr:send_friendship(player_data.uuid)
    Util.show_message_tip(2082)
  end)
end

function ui:ui_update(delta_time)
  if not self.v_last_page then
    return
  end
  if self.v_last_page == PAGE_TYPE.APPLY_LIST and self.v_sub_page == SUB_PAGE_TYPE.APPLY_LISY then
    FriendMgr:request_get_apply_list()
  elseif self.v_last_page == PAGE_TYPE.FRIEND_LIST then
    FriendMgr:request_get_friend_list()
  end
  if self.v_last_page == PAGE_TYPE.APPLY_LIST and self.v_sub_page == SUB_PAGE_TYPE.RECOMMEND and self.v_cd_btn_state then
    if FriendMgr:get_btn_cd_time() > 0.1 then
      local cur_cd_time = FriendMgr:get_btn_cd_time()
      self.v_cd_btn_text.text = Util.format_str("刷新冷却：{1}", _sformat("%.1f", FriendMgr:get_btn_cd_time()))
      FriendMgr:set_btn_cd_time(cur_cd_time - delta_time)
    else
      self.v_cd_btn_text.text = Util.format_str("换一批")
      self:refresh_friends_recommend_state()
      self.v_cd_btn_state = false
    end
  end
end

function ui:set_player_aid_char_info(item, data, uuid)
  local char_icon = Util.get_image("CharIcon", item)
  local char_lv = Util.get_text("CharLevel", item)
  local potential = Util.get_image("Potential", item)
  local star = Util.get_child_gameobj("Star", item)
  char_lv.text = data.lv
  local icon_path = UtilUI.get_hero_images(data.id, 1)
  ResMgr:load_set_icon(char_icon, icon_path)
  for i = 1, 3 do
    local star_obj = Util.get_child_gameobj("Star" .. i, star)
    local star_light = Util.get_child_gameobj("Light" .. i, star_obj)
    star_obj:SetActive(true)
    star_light:SetActive(i < data.break_lv)
  end
  local potential_icon = Char_Helper.get_char_potential_icon_by_advance(data.advance)
  ResMgr:load_set_icon(potential, potential_icon, nil, true)
  local btn = Util.get_button(nil, item)
  if btn then
    self:set_button_listener(btn, function()
      local function cb(data)
        Player_Hero_Helper.set_hero_data(data)
        
        UIMgr:get_ui("player_hero"):ui_show()
      end
      
      FriendMgr:c2gs_get_role_buddy_info(uuid, data.id, cb)
    end)
  end
end

function ui:set_assistant_roles(item, data)
  local buddy_id = data.id
  local icon_path = UtilUI.get_hero_images(buddy_id, 1, data.fashion)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local qual_val = buddy_cfg.Quality
  local quality_icon = ShareRes.get_buddy_qualityIcon_small_square(qual_val)
  local HeadIcon = Util.get_image("CharIcon", item)
  local QualityIcon = Util.get_image("QualityIcon", item)
  local fight_val_obj = Util.get_text("Zhanli/Zhanli", item)
  ResMgr:load_set_icon(HeadIcon, icon_path)
  ResMgr:load_set_icon(QualityIcon, quality_icon)
  fight_val_obj.text = data.power or ""
end

function ui:on_apply_add_friend(player_data)
  local function apply_callback(uuid, type)
    Util.show_message_tip(2194)
  end
  
  local player_friend_num = player_data.friend_num
  local self_friend_num = FriendMgr:get_friend_num()
  if player_friend_num >= FRIEND_MAX_NUM then
    Util.show_message_tip(2334)
    return
  end
  if self_friend_num >= FRIEND_MAX_NUM then
    Util.show_message_tip(2335)
    return
  end
  FriendMgr:apply_add_friend(player_data.uuid, apply_callback, nil, player_data)
end

function ui:update_player_state()
  if not self.v_player_obj_list or not next(self.v_player_obj_list) then
    return
  end
  for key, player_data in pairs(self.v_player_obj_list) do
    local data = player_data.data
    local player_uuid = data.uuid
    local obj = player_data.obj
    if obj then
      local apply = Util.get_button("BtnAdd", obj)
      local friend = Util.get_rect_transform("BtnHadAdd", obj)
      local player_state = data.friend_status
      if FriendMgr:check_applied_by_uuid(player_uuid) then
        apply.gameObject:SetActive(false)
        friend.gameObject:SetActive(true)
      else
        apply.gameObject:SetActive(player_state == FRIEND_STATE.APPLY)
        friend.gameObject:SetActive(player_state == FRIEND_STATE.APPLIED)
      end
    end
  end
end

function ui:click_player_func_btn(pos_transform, uuid, is_rcd, is_apply)
  self.v_uiobjects.BtnFriendContent:SetActive(true)
  self.v_uiobjects.BtnCloseFrendContent:SetActive(true)
  self.v_uiobjects.BtnFriendContent.transform:SetParent(pos_transform)
  self.v_uiobjects.BtnFriendContent.transform:SetLocalPositionA(0, 0, 0)
  self.v_uiobjects.BtnFriendContent.transform:SetParent(self.v_uiobjects.BtnCloseFrendContent.transform)
  self.v_select_uuid = uuid
  if is_rcd or is_apply then
    self.v_uiobjects.BtnChangeRemark:SetActive(false)
    self.v_uiobjects.BtnDeleteFriend:SetActive(false)
  else
    self.v_uiobjects.BtnChangeRemark:SetActive(true)
    self.v_uiobjects.BtnDeleteFriend:SetActive(true)
  end
end

function ui:update_player_note(msg)
  if not msg then
    return
  end
  if self.v_last_page ~= PAGE_TYPE.FRIEND_LIST then
    return
  end
  local note = msg.mm_y
  local uuid = msg.mm_x
  local obj, name
  for index, player_info in ipairs(self.v_player_obj_list) do
    obj = player_info.obj
    local data = player_info.data
    if data.uuid == uuid then
      data.note = note
      name = data.name
      break
    end
  end
  local note_txt = Util.get_text("PlayerName", obj)
  note_txt.text = name
  note_txt.color = COLOR_NAME
  if note and "" ~= note then
    note_txt.text = note
    note_txt.color = COLOR_MARK
  end
end

function ui:refresh_red()
  local is_show_red = FriendMgr:is_show_friend_red()
  if self.v_last_page == PAGE_TYPE.APPLY_LIST then
    self.v_uicompents.BtnRefuseAll_btn:SetActive(is_show_red)
  end
  local red_point = Util.get_child_gameobj("RedPoint", self.v_uiobjects.Page_Apply)
  red_point:SetActive(false)
  local apply_list = FriendMgr:get_apply_list()
  if apply_list then
    local count = 0
    for _, data in pairs(apply_list) do
      count = count + 1
    end
    if count > 0 then
      red_point:SetActive(FriendMgr:get_apply_list_red_point())
    end
  end
end

function ui:close_chat(friend_uuid)
  for idx, v in ipairs(self.v_player_obj_list) do
    if v.data.uuid == friend_uuid then
      self:show_player_detail(v.data, idx)
      break
    end
  end
  self.v_in_chat_friend = nil
  if self.v_uicompents.Page_addfriend_tog.isOn then
    self.v_panels.search_player:set_enable(true)
  end
end

function ui:_refresh_chat(player_data)
end

function ui:_refresh_chat_bysearch(msg)
end

function ui:cancel_select()
  local select_index = self.v_select_index
  local select_data = self.v_player_obj_list[select_index]
  if not select_data then
    return
  end
  self:update_player_info(select_data.obj, select_data.data, select_index)
end

function ui:refresh_buddy_state(uuid, state)
  self.v_panels.search_player:update_player_state(uuid, state)
end

function ui:_refresh_show_type()
  self.v_uiobjects.BtnInviteContent:SetActive(false)
  if not self.v_show_type then
    return
  end
  self.v_uiobjects.BtnInviteContent:SetActive(true)
  local has_invite_all = ActivityMgr:invoke(Act_ID, "get_invite_all_friend")
  if has_invite_all then
    Util.disable_btn(self.v_uicompents.BtnFightInviteAll_btn, true)
    Util.disable_btn(self.v_uicompents.BtnFightInvite_btn, true)
  else
    Util.enable_btn(self.v_uicompents.BtnFightInviteAll_btn)
    Util.enable_btn(self.v_uicompents.BtnFightInvite_btn)
  end
end

function ui:_refresh_invite_btn_state()
  if not self.v_show_type then
    return
  end
  local min_lv = ActivityMgr:invoke(Act_ID, "get_act_cfg").LimitGrade
  if min_lv > self.v_select_data.lv then
    self.v_uiobjects.BtnFightInvite:SetActive(false)
    return
  end
  if self.v_select_data.offline_time > 0 then
    self.v_uiobjects.BtnFightInvite:SetActive(false)
    return
  end
  self.v_uiobjects.BtnFightInvite:SetActive(true)
  local has_invite = ActivityMgr:invoke(Act_ID, "get_invite_friend", self.v_select_uuid)
  if has_invite then
    Util.disable_btn(self.v_uicompents.BtnFightInvite_btn, true)
  else
    Util.enable_btn(self.v_uicompents.BtnFightInvite_btn)
  end
end

function ui:_response_invite_cd_event(msg)
  if -1 == msg.mm_obj then
    self:_refresh_show_type()
  elseif msg.mm_obj == self.v_select_uuid then
    self:_refresh_invite_btn_state()
  end
end

function ui:_onclick_invite_all_btn()
  ActivityMgr:invoke(Act_ID, "invite_all_friend", function()
    Util.disable_btn(self.v_uicompents.BtnFightInviteAll_btn, true)
    Util.disable_btn(self.v_uicompents.BtnFightInvite_btn, true)
    self:ui_hide()
  end)
end

function ui:_onclick_invite_btn()
  ActivityMgr:invoke(Act_ID, "invite_friend", self.v_select_uuid, function()
    self:ui_hide()
  end)
end

function ui:_onclick_receive_all_btn()
  FriendMgr:receive_all_friendship(self.v_player_uuid_list)
end

function ui:update_receive_times()
  local max_times = ShareRes.get_system_comm_value("GetPresentRewardLimit")
  local today_times = FriendMgr:get_had_send_times()
  local can_receive = FriendMgr:is_anybody_can_receive()
  self.v_uicompents.GiftNow_txt.text = today_times
  self.v_uicompents.GiftMax_txt.text = max_times
  local can_send = FriendMgr:is_anybody_can_send()
  local active = max_times > today_times and can_receive or can_send
  self.v_uicompents.BtnReciveGiftAll_btn.interactable = active
  Util.apply_grey_ex(self.v_uiobjects.BtnReciveGiftAll, not active)
end

function ui:cache_ui()
  return true
end

return ui
