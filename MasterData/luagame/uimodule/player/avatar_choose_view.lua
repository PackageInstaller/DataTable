local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local StaicSv = require("ui.widget.static_scroll_view")
local LoopListClass = require("ui.widget.infinite_loop_list")
local SvItem = require("uimodule.player.local_widgets.avatar_item")
local SvCardItem = require("uimodule.player.local_widgets.card_item")
local Player_Cfg = require("uimodule.player.player_cfg")
local _tsort = table.sort
local _tinsert = table.insert
local player_icon_path_prefix = "Icon/Profile/%s"
local player_card_path_prefix = "CardBG/%s"
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_profile_toggle = {
    "PageProfile",
    BIND_TYPE.TOGGLE
  },
  v_cardobj_toggle = {
    "PageCard",
    BIND_TYPE.TOGGLE
  },
  v_profile_obj = {
    "ProfileObj",
    BIND_TYPE.OBJECT
  },
  v_card_obj = {
    "CardObj",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BgReturn", function()
    self:ui_hide()
  end)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:set_button("InsertIn", function()
    self:_on_click_insert_in()
  end)
  self:set_button("CardInsertIn", function()
    self:_on_click_card_insert_in()
  end)
  self:set_toggle("PageProfile", function()
    self.v_profile_obj:SetActive(true)
    self.v_card_obj:SetActive(false)
  end)
  self:set_toggle("PageCard", function()
    self.v_profile_obj:SetActive(false)
    self.v_card_obj:SetActive(true)
    if self.v_card_child_list and self.v_card_data then
      self.v_card_child_list:scroll_to_item(self.v_card_data.cur_select)
    end
  end)
  self:init_reward_item()
end

function ui:ui_on_show(select_page, player_name)
  self.v_avatar_data = {}
  self.v_select_avatar_id = nil
  self.v_cur_avatar = nil
  self.v_player_name = player_name
  self:register_listener()
  self:refresh_view()
  self:refresh_card_item()
  if 1 == select_page then
    self.v_profile_toggle.isOn = false
    self.v_profile_toggle.isOn = true
  elseif 2 == select_page then
    self.v_cardobj_toggle.isOn = false
    self.v_cardobj_toggle.isOn = true
  end
end

function ui:ui_on_hide()
  self.v_avatar_data = nil
  self.v_select_avatar_id = nil
  self.v_child_list:clear()
  if self.v_card_child_list then
    self.v_card_child_list:ui_on_hide()
  end
end

function ui:ui_on_destroy()
  self.v_child_list = nil
  if self.v_card_child_list then
    self.v_card_child_list:ui_on_destroy()
  end
  self.v_card_child_list = nil
end

function ui:init_reward_item()
  self.v_child_list = StaicSv:new(self, self.v_uiobjects.Avatar_Content, SvItem, "PLAYER_AVATAR_CHOOSE_ITEM")
  self.v_card_child_list = LoopListClass:new(self, self.v_uiobjects.Card_Scroll, SvCardItem)
end

function ui:refresh_view()
  self.v_avatar_data = PlayerMgr:on_get_avatar_list()
  local avatar_data = self.v_avatar_data
  local msg = {}
  if next(avatar_data) ~= nil then
    for index, data in pairs(avatar_data) do
      if data.is_use then
        self.v_cur_avatar = data
        msg.mm_obj = avatar_data[index]
        break
      end
    end
  end
  if not msg.mm_obj then
    msg.mm_obj = avatar_data[1]
  end
  self:refresh_reward_item()
  self:on_item_selected(msg)
end

function ui:initselect_card_item()
  local select_index = 1
  for index = 1, #self.v_card_data do
    local data = self.v_card_data[index]
    if data.is_use then
      select_index = index
      break
    end
  end
  self.v_card_data.cur_select = select_index
  self.v_card_child_list:scroll_to_item(select_index)
  self.v_card_child_list:select_item(select_index)
end

function ui:refresh_card_item()
  local unlock_card_id_list = PlayerMgr:get_all_visiting_card()
  local all_card_cfg = ShareRes.get_visiting_card_cfg()
  self.v_card_data = {}
  for card_id, cfg in pairs(all_card_cfg) do
    local buddy_id = cfg.BuddyID
    if not buddy_id or ShareRes.get_buddy_is_show(buddy_id) and CharacterMgr:check_buddy_release(buddy_id) then
      local temp_data = {}
      temp_data.cfg = cfg
      temp_data.is_unlock = nil ~= unlock_card_id_list[card_id]
      temp_data.is_use = true == unlock_card_id_list[card_id]
      if 1 ~= temp_data.cfg.isHide then
        _tinsert(self.v_card_data, temp_data)
      end
    end
  end
  
  local function sort_func(a, b)
    if a.is_unlock == b.is_unlock and a.cfg.Priority == b.cfg.Priority then
      return a.cfg.Id < b.cfg.Id
    elseif a.is_unlock == b.is_unlock then
      return a.cfg.Priority > b.cfg.Priority
    else
      return a.is_unlock
    end
  end
  
  _tsort(self.v_card_data, sort_func)
  self.v_card_child_list:refresh_data(self.v_card_data)
  self:initselect_card_item()
end

function ui:refresh_reward_item()
  local avatar_data = self.v_avatar_data
  
  local function sort_func(a, b)
    if a.un_get == b.un_get and a.avatar_cfg.Priority == b.avatar_cfg.Priority then
      return a.avatar_cfg.Id < b.avatar_cfg.Id
    elseif a.un_get == b.un_get then
      return a.avatar_cfg.Priority > b.avatar_cfg.Priority
    else
      return b.un_get
    end
  end
  
  _tsort(avatar_data, sort_func)
  self.v_child_list:update_list(avatar_data)
  self:_location_current_item(avatar_data, 4, self.v_uiobjects.Card_Scroll)
end

function ui:refresh_head_info(data)
  local icon_path = string.format(player_icon_path_prefix, data.avatar_cfg.Icon)
  ResMgr:load_set_icon(self.v_uicompents.NowProfile_img, icon_path)
  self.v_uicompents.ProfileName_txt.text = data.avatar_cfg.Name
  self.v_uicompents.Desc_txt.text = data.avatar_cfg.Desc
end

function ui:refresh_card_info(data)
  self.v_uicompents.CardDesc_txt.text = data.cfg.Desc
  self.v_uicompents.PlayerTemName_txt.text = self.v_player_name
  local rank_icon_path = string.format(player_card_path_prefix, data.cfg.RankingListIcon)
  ResMgr:load_set_icon(self.v_uicompents.PlayerTemBg_img, rank_icon_path, nil, true)
  if self.v_cur_avatar then
    self.v_uiobjects.PlayerTemProfile:SetActive(true)
    self.v_uiobjects.PlayerTemNoChar:SetActive(false)
    local icon_path = string.format(player_icon_path_prefix, self.v_cur_avatar.avatar_cfg.Icon)
    ResMgr:load_set_icon(self.v_uicompents.PlayerTemProfile_img, icon_path)
  else
    self.v_uiobjects.PlayerTemProfile:SetActive(false)
    self.v_uiobjects.PlayerTemNoChar:SetActive(true)
  end
  if data.is_unlock then
    self.v_uiobjects.CardInsertIn:SetActive(true)
    self.v_uiobjects.CardNotGet:SetActive(false)
  else
    self.v_uiobjects.CardInsertIn:SetActive(false)
    self.v_uiobjects.CardNotGet:SetActive(true)
  end
end

function ui:_on_click_insert_in()
  if self.v_select_avatar_id ~= nil then
    local avatar_cfg = self.v_avatar_data[self.v_select_avatar_id].avatar_cfg
    local avatar_id = avatar_cfg.Id
    PlayerMgr:upgrade_face_id(avatar_id, function()
      local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_AVATAR_SUCCESS)
      msg.mm_obj = avatar_cfg
      self:refresh_view()
      self:refresh_card_info(self.v_select_card)
    end)
  end
end

function ui:_on_click_card_insert_in()
  if self.v_select_card_id then
    if self.v_select_card_id == PlayerMgr:get_wear_visiting_card() then
      return
    end
    PlayerMgr:ware_visiting_card(self.v_select_card_id)
  end
end

function ui:_location_current_item(data_list, row_num, scroll_object)
  for index, data in pairs(data_list) do
    if data.is_use then
      local scrollrect = Util.get_scrollrect(nil, scroll_object)
      local row_count = math.ceil(#data_list / row_num)
      local current_row_count = math.ceil(index / row_num)
      if current_row_count <= 2 then
        scrollrect.verticalNormalizedPosition = 1
        break
      end
      if current_row_count >= row_count - 1 then
        scrollrect.verticalNormalizedPosition = 0
        break
      end
      scrollrect.verticalNormalizedPosition = 1 - current_row_count / row_count
      break
    end
  end
end

function ui:register_listener()
  self:bind_auto_mq(Const.MSG_ON_SELECTED_PLAYER_AVATAR_ITEM, self.on_item_selected, self)
  self:bind_auto_mq(Const.MSG_ON_VISITING_CARD_SELECT, self.on_card_selected, self)
  self:bind_auto_mq(Const.MSG_ON_VISITING_CARD_WARE, self.refresh_card_item, self)
end

function ui:on_item_selected(msg)
  local data = msg.mm_obj
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local select_idx = data.idx
  local select_item = self.v_child_list:get_item_by_idx(select_idx)
  self.v_child_list:on_select_change(select_item)
  self:refresh_head_info(data)
  self.v_select_avatar_id = data.idx
  if data.un_get then
    uobj.InsertIn:SetActive(false)
    uobj.NotGet:SetActive(true)
  else
    uobj.InsertIn:SetActive(true)
    uobj.NotGet:SetActive(false)
  end
end

function ui:on_card_selected(msg)
  if msg then
    local select_idx = msg.mm_x
    local data = self.v_card_data[select_idx]
    self.v_select_card_id = data.cfg.Id
    self.v_select_card = data
    self:refresh_card_info(data)
    self.v_card_data.cur_select = select_idx
  end
end

return ui
