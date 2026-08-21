local Base = require("ui.uibase")
local CHAR_ITEM_CLASS = require("uimodule.friend.char_item")
local CharcterConfig = require("uimodule.character.character_config")
local CommonDef = require("cs_share.common_define")
local UNION_TITLE = CommonDef.GUILD_POSITION_TYPE
local LAST_SELECT_BUDDY_IDX_TYPE = CharcterConfig.LAST_SELECT_BUDDY_IDX_TYPE
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE

function ui:ui_finish_load()
  self:set_button("BtnPreview", function()
    self:click_preview()
  end)
  self:set_button("BtnReturn", function()
    if self:check_is_need_save() then
      local function sure_callback()
        self:click_save()
        
        CharacterMgr:set_card_show_data()
        CharacterMgr:set_show_all_buddy_temp()
        self:ui_hide()
      end
      
      local function cancel_callback()
        CharacterMgr:set_card_show_data()
        CharacterMgr:set_show_all_buddy_temp()
        self:ui_hide()
      end
      
      local stip = Util.format_str("存在未保存改动,是否保存后退出？")
      UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, cancel_callback, stip, Util.format_str("保存后退出"), Util.format_str("直接退出"))
    else
      self:ui_hide()
    end
  end)
  self:set_button("BtnSave", function()
    if self:check_is_need_save() then
      self:click_save()
    else
      Util.show_message_tip(2074)
    end
  end)
end

function ui:ui_on_show()
  self.v_char_item_list = {}
  self.v_is_show_all_char = CharacterMgr:get_show_all_buddy_temp()
  self:set_toggle("ShowAllTog", function()
    self.v_is_show_all_char = not self.v_is_show_all_char
    CharacterMgr:set_show_all_buddy_temp(self.v_is_show_all_char)
    self:update_view()
  end, self.v_is_show_all_char)
  self:update_view()
end

function ui:update_view()
  self.v_uiobjects.ShowCharContent:SetActive(not self.v_is_show_all_char)
  self.v_uiobjects.ShowAllChar:SetActive(self.v_is_show_all_char)
  if not self.v_is_show_all_char then
    self:update_show_char()
  end
end

function ui:is_aid(buddy_id)
  local aid_list = CharacterMgr:get_aid_hero()
  for _, id in ipairs(aid_list) do
    if id == buddy_id then
      return true
    end
  end
  return false
end

function ui:update_show_char()
  self:remove_wrap_list()
  local show_list = CharacterMgr:get_card_select_list_info()
  for pos, buddy_id in ipairs(show_list) do
    local item = self.v_uiobjects["CharTem" .. pos]
    local add = Util.get_child_gameobj("Add", item)
    local char_item = Util.get_child_gameobj("CharInfo" .. pos, item)
    local btn = Util.get_button(nil, item)
    char_item:SetActive(false)
    add:SetActive(0 == buddy_id)
    if 0 ~= buddy_id then
      local data = UtilTable.copy_table(CharacterMgr:get_buddy_by_id(buddy_id))
      data.is_aid = self:is_aid(buddy_id)
      data.fashion = FashionMgr:get_fashion_wearing_id(buddy_id)
      local char_item_obj = CHAR_ITEM_CLASS:ui_wrap_ex(self, char_item, true)
      char_item_obj:set_data(data, nil, Config.CHAR_QUALITY_TYPE.LONG)
      table.insert(self.v_char_item_list, char_item_obj)
    end
    if btn then
      self:set_button_listener(btn, function()
        self:on_click_aid_item(pos, buddy_id, show_list)
      end)
    end
  end
end

function ui:on_click_aid_item(pos, buddy_id, list)
  local select_data = {
    select_pos = pos,
    select_buddy_id = buddy_id,
    select_list = list
  }
  CharacterMgr:set_card_show_data(select_data)
  UIMgr:get_ui("character_enter"):ui_show(nil, nil, LAST_SELECT_BUDDY_IDX_TYPE.PLAYER_SHOW)
end

function ui:check_is_need_save()
  if self.v_is_show_all_char ~= CharacterMgr:get_is_show_all_buddy() then
    return true
  end
  local cur_show_list = CharacterMgr:get_card_select_list_info()
  local real_save_list = CharacterMgr:get_card_real_select_list_info()
  for pos, buddy_id in ipairs(cur_show_list) do
    if real_save_list[pos] and buddy_id ~= real_save_list[pos] then
      return true
    end
    if not real_save_list[pos] and 0 ~= buddy_id then
      return true
    end
  end
  return false
end

function ui:click_save()
  local cur_show_list = CharacterMgr:get_card_select_list_info()
  local buddy_id_list = {}
  for index, buddy_id in ipairs(cur_show_list) do
    if 0 ~= buddy_id then
      table.insert(buddy_id_list, buddy_id)
    end
  end
  if self.v_is_show_all_char ~= CharacterMgr:get_is_show_all_buddy() then
    CharacterMgr:req_set_show_all_buddy()
  end
  CharacterMgr:req_set_appoint_show_buddy(buddy_id_list)
  CharacterMgr:set_card_show_data()
end

function ui:remove_wrap_list()
  for _, obj in pairs(self.v_char_item_list) do
    obj:ui_hide()
    obj:ui_destroy()
  end
  self.v_char_item_list = {}
end

function ui:cache_ui()
  return true
end

function ui:click_preview()
  local data = {}
  local cur_show_list = CharacterMgr:get_card_select_list_info()
  local cur_aid_list = CharacterMgr:get_aid_hero()
  local player_info = PlayerMgr:on_get_player_info_list()
  local player_info_list = player_info.info_list
  local birth_month = player_info_list.birth_month
  local birth_day = player_info_list.birth_day
  data.icon = PlayerMgr:get_player_head_id()
  data.is_self = true
  data.name = PlayerMgr:get_player_name()
  data.lv = PlayerMgr:get_role_lv()
  data.uuid = PlayerMgr:get_player_uid()
  if birth_month then
    data.birthday = {}
    data.birthday[1] = birth_month
    data.birthday[2] = birth_day
  end
  data.buddy_show_info = {}
  data.buddy_show_info.assist_buddys = {}
  data.buddy_show_info.appoint_buddys = {}
  data.buddy_show_info.all_buddy_num = #CharacterMgr:get_buddy_list_show()
  data.buddy_show_info.show_all_buddy = self.v_is_show_all_char
  data.title = PlayerMgr:whether_wear_title() and PlayerMgr:get_wear_title().id or 0
  data.active_titles = PlayerMgr:get_active_titles()
  data.achievement_num = PlayerMgr:get_achievements_complete_num()
  data.guild_position = UnionMgr:get_my_union_title()
  data.bussiness_card = PlayerMgr:get_wear_visiting_card()
  data.quotation = PlayerMgr:get_player_quotation()
  local my_union = UnionMgr:get_union_info()
  if my_union then
    data.guild_name = my_union.name
  end
  if self.v_is_show_all_char then
    local buddy_info_list = UtilTable.copy_table(CharacterMgr:get_all_buddys())
    for _, buddy_info in pairs(buddy_info_list) do
      buddy_info.fashion = FashionMgr:get_fashion_wearing_id(buddy_info.id)
    end
    data.buddy_show_info.appoint_buddys = buddy_info_list
  else
    for _, buddy_id in ipairs(cur_show_list) do
      if 0 ~= buddy_id then
        local buddy_info = UtilTable.copy_table(CharacterMgr:get_buddy_by_id(buddy_id))
        buddy_info.fashion = FashionMgr:get_fashion_wearing_id(buddy_id)
        table.insert(data.buddy_show_info.appoint_buddys, buddy_info)
      end
    end
  end
  for index, buddy_id in ipairs(cur_aid_list) do
    if 0 ~= buddy_id then
      local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
      table.insert(data.buddy_show_info.assist_buddys, buddy_info)
    end
  end
  UIMgr:get_ui("ui_player_info"):ui_show(data)
end

function ui:ui_on_hide()
  self:remove_wrap_list()
end

function ui:ui_on_destroy()
end

return ui
