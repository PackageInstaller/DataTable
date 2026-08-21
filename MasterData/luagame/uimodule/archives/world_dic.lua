local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ToggleTab = require("ui.widget.widget_toggle_tab")
local TAG_TOG_KEY = "TAG_TOG_KEY"
local DIC_ITEM_KEY = "DIC_ITEM_KEY"
local TagNormalColcor = {
  color = Util.get_unity_color_by_hex(tonumber("ffffff", 16)),
  a = 1.0
}
local TagDisableColor = Util.get_unity_color_by_hex(tonumber("786f60", 16))
local VerticalLayoutGroup = UnityEngine.UI.VerticalLayoutGroup

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self.v_TAG_TOG_KEY = TAG_TOG_KEY .. self:ui_get_name()
  self.v_DIC_ITEM_KEY = DIC_ITEM_KEY .. self:ui_get_name()
  self:register_exist_auto_template(self.v_TAG_TOG_KEY, self.v_uiobjects.TagItem1, self.v_uiobjects.TagList1)
  self:register_exist_auto_template(self.v_DIC_ITEM_KEY, self.v_uiobjects.TagItem2, self.v_uiobjects.TagList2)
  self.v_contenet_init_pos_y = 284
  self.v_tag_item_height = self.v_uicompents.Content_rect.rect.height
  self.v_tag_item_spacing = 20
  local bg_btn_close_obj = self.v_uicompents.BtnBgClose_btn
  if bg_btn_close_obj then
    self:set_button_listener(bg_btn_close_obj, function()
      self:ui_hide()
    end)
  end
  local bg_close_obj = self.v_uicompents.BtnClose_btn
  if bg_close_obj then
    self:set_button_listener(bg_close_obj, function()
      self:ui_hide()
    end)
  end
end

function ui:init_tag_tog()
  self.v_tog_list = ShareRes.create("archives.dictionary_title")
  UtilTable.list_delete_by_func(self.v_tog_list, function(info)
    local is_show = ShareRes.get_dictionary_content_cfg(info.Id)
    return not is_show
  end)
  for index, value in ipairs(self.v_tog_list) do
    local tempList = ShareRes.get_dictionary_content_cfg(value.Id)
    local lockFlag = true
    lockFlag = self:check_titleid_lockstate_formunlocklist(value.Id)
    for index, value in ipairs(tempList) do
      if not ArchiveMgr.v_world_dic_list[value.Id].lock_state then
        lockFlag = false
        break
      end
    end
    self.v_tog_list[index].LockFlag = lockFlag
  end
  if not self.v_tag_toggle then
    self.v_tag_toggle = {}
    self.v_title_to_toggle = {}
    for _, data in ipairs(self.v_tog_list) do
      local item = self:get_auto_cache(self.v_TAG_TOG_KEY)
      local desc = Util.get_text("TagName", item)
      local red_point = Util.get_child_gameobj("Redpoint", desc.gameObject)
      red_point:SetActive(ArchiveMgr:update_dic_title_red(data.Id))
      desc.text = data.Title
      local tog = Util.get_toggle(nil, item)
      table.insert(self.v_tag_toggle, tog)
      self.v_title_to_toggle[data.Id] = tog
    end
  end
  self.v_tag_toggle_tab = ToggleTab:new(self)
  self.v_tag_toggle_tab:init_by_toggles(self.v_tag_toggle, function(cur_select)
    self:click_tag(cur_select)
  end, 1, false)
  for index, value in ipairs(self.v_tag_toggle) do
    value.enabled = not self.v_tog_list[index].LockFlag
    local btn = Util.get_button("touchBtn", value.gameObject)
    btn.gameObject:SetActive(not value.enabled)
    local tagName_txt = Util.get_text("TagName", value.gameObject)
    if btn.gameObject.activeSelf then
      tagName_txt.color = TagDisableColor
      local firstInfo = ShareRes.get_dictionary_content_cfg(self.v_tog_list[index].Id)[1]
      self:set_button_listener(btn, function()
        ArchiveMgr:is_to_achieve_Condition(firstInfo.ConditionID, true)
      end)
    else
      tagName_txt.color = TagNormalColcor.color
    end
  end
  self:click_tag(1)
end

function ui:update_tag_show(cur_index)
  for index, tog in pairs(self.v_tag_toggle) do
    local tog_text_Eng = Util.get_text("TagEnName", tog.gameObject)
    local page_name = Util.get_text("TagName", tog.gameObject)
    tog_text_Eng.color = index == cur_index and ArchiveMgr.v_en_color or ArchiveMgr.v_en_un_color
    page_name.color = index == cur_index and ArchiveMgr.v_color or ArchiveMgr.v_un_color
  end
end

function ui:click_tag(cur_select)
  self.v_uiobjects.TagList2.transform:SetSiblingIndex(cur_select + 1)
  self.v_cur_tag_id = self.v_tog_list[cur_select].Id
  self.v_cur_tag_index = cur_select
  self:update_dic_list()
  if self.v_tog_list[cur_select].PageIcon then
    ResMgr:load_set_icon(self.v_uicompents.TypeIcon_img, self.v_tog_list[cur_select].PageIcon, nil, false, self)
  end
  local pos_y = (self.v_tag_item_spacing + self.v_tag_item_height) * (cur_select - 1)
  self.v_uicompents.TagList1_rect:SetAnchoredPositionA(self.v_uicompents.TagList1_rect.anchoredPosition.x, pos_y)
end

function ui:update_dic_list()
  self.v_cur_dic_list = nil
  self.v_item_toggle = nil
  self.v_cur_dic_list = ShareRes.get_dictionary_content_cfg(self.v_cur_tag_id)
  self:give_back_auto_cache(self.v_DIC_ITEM_KEY)
  local first_unlock = 0
  self.v_item_toggle = {}
  for index, data in ipairs(self.v_cur_dic_list) do
    local item = self:get_auto_cache(self.v_DIC_ITEM_KEY)
    local desc = Util.get_text("TagName", item)
    local desc_lock = Util.get_text("TagNameLock", item)
    local red_point = Util.get_child_gameobj("Redpoint", desc.gameObject)
    local tog = Util.get_toggle(nil, item)
    local lock = Util.get_image("Lock", item)
    local btn = Util.get_button("touchBtn", item)
    local lockFlag = not ArchiveMgr:is_to_achieve_Condition(data.ConditionID, false)
    lockFlag = self:check_decid_lockstate_formunlocklist(self.v_cur_tag_id, data.Id) and lockFlag
    red_point:SetActive(ArchiveMgr.v_world_dic_list[data.Id].red_state)
    if lockFlag then
      lock.gameObject:SetActive(true)
      desc.gameObject:SetActive(false)
      desc_lock.gameObject:SetActive(true)
      desc_lock.text = "???"
      self:set_button_listener(btn, function()
        ArchiveMgr:is_to_achieve_Condition(data.ConditionID, true)
      end)
    else
      desc.gameObject:SetActive(true)
      desc_lock.gameObject:SetActive(false)
      lock.gameObject:SetActive(false)
      desc.text = data.Name
    end
    btn.gameObject:SetActive(lockFlag)
    table.insert(self.v_item_toggle, tog)
    if 0 == first_unlock and not lockFlag then
      first_unlock = index
    end
    self.v_id_to_item_tog = self.v_id_to_item_tog or {}
    self.v_id_to_item_tog[data.Id] = {tog = tog, idx = index}
  end
  self.v_item_toggle_tab = ToggleTab:new(self)
  self.v_item_toggle_tab:init_by_toggles(self.v_item_toggle, function(cur_select)
    self:click_item(cur_select)
  end, first_unlock)
  if 0 ~= first_unlock then
    self:click_item(first_unlock)
    self:update_desccontent_pos(first_unlock)
  end
end

function ui:click_item(cur_select)
  local info = self.v_cur_dic_list[cur_select]
  if ArchiveMgr.v_world_dic_list[info.Id].red_state then
    ArchiveMgr:req_click_action(ArchiveMgr.CommonDefind.ARCH_TYPE.WORLD_DICTIONARY, info.Id, function()
      self:update_red(cur_select)
    end)
  end
  self:update_dic_item_info(cur_select)
end

function ui:update_dic_item_info(cur_select)
  local info = self.v_cur_dic_list[cur_select]
  if ArchiveMgr.v_world_dic_list[info.Id].lock_state and self:check_decid_lockstate_formunlocklist(self.v_cur_tag_id, info.Id) then
    return
  end
  self.v_uicompents.WordTitle_txt.text = info.Name
  self.v_uicompents.DescText_txt.text = info.Desc
  if self.v_is_new_prefab_ui then
    self.v_uicompents.ShowImage_img:SetActive(false)
  else
    self.v_uicompents.ShowImage_img:SetActive(info.illustrations)
  end
  self.v_uicompents.Content_rect:SetAnchoredPositionA(self.v_uicompents.Content_rect.anchoredPosition.x, self.v_contenet_init_pos_y)
  if info.illustrations then
    ResMgr:load_set_icon(self.v_uicompents.ShowImage_img, info.illustrations, nil, true, self)
  end
  self.v_uiobjects.ShowImageRoot:SetActive(info.CharacterIcon)
  if info.CharacterIcon then
    ResMgr:load_set_icon(self.v_uicompents.CharIcon_img, info.CharacterIcon, nil, false, self)
  end
end

function ui:update_red(cur_select)
  if not self.v_cur_dic_list then
    return
  end
  local info = self.v_cur_dic_list[cur_select]
  local item = self.v_item_toggle[cur_select].gameObject
  local red_point = Util.get_child_gameobj("Redpoint", Util.get_child_gameobj("TagName", item))
  red_point:SetActive(ArchiveMgr.v_world_dic_list[info.Id].red_state)
  local item_tag = self.v_tag_toggle[self.v_cur_tag_index].gameObject
  local red_point_tag = Util.get_child_gameobj("Redpoint", Util.get_child_gameobj("TagName", item_tag))
  red_point_tag:SetActive(ArchiveMgr:update_dic_title_red(self.v_cur_tag_id))
end

function ui:ui_on_show(disable_main_btn, title_id, dic_id, unlock_dic_list, is_new_prefab_ui)
  self.v_is_new_prefab_ui = is_new_prefab_ui
  self:set_unlock_list(unlock_dic_list)
  if disable_main_btn then
    self.v_uiobjects.BtnMain:SetActive(false)
  end
  self.v_uicompents.TagList1_rect:SetAnchoredPositionA(0, 0)
  self:init_tag_tog()
  self:update_dic_list(1)
  if title_id and dic_id then
    self:select_dic(title_id, dic_id)
    self:update_desccontent_pos(self.v_id_to_item_tog[dic_id].idx)
  end
  if self.v_is_new_prefab_ui then
    self.v_tag_item_spacing = 0
  end
end

function ui:ui_on_hide()
  self.v_tag_toggle = nil
  self.v_title_to_toggle = nil
  self.v_id_to_item_tog = nil
  self.v_item_toggle = nil
  self.v_cur_dic_list = nil
  self.v_tog_list = nil
end

function ui:select_dic(title_id, dic_id)
  self.v_title_to_toggle[title_id].isOn = true
  self.v_id_to_item_tog[dic_id].tog.isOn = true
end

function ui:set_unlock_list(unlock_list)
  self.v_stroy_unlock_dic_list = unlock_list or {}
end

function ui:get_unlock_list()
  return self.v_stroy_unlock_dic_list or {}
end

function ui:check_titleid_lockstate_formunlocklist(title_id)
  local unlock_list = self:get_unlock_list()
  for stroy_unlock_title, stroy_unlock_id_list in pairs(unlock_list) do
    if stroy_unlock_title == title_id then
      return false
    end
  end
  return true
end

function ui:check_decid_lockstate_formunlocklist(tag_id, dec_id)
  if not ArchiveMgr.v_world_dic_list[dec_id].lock_state then
    return false
  end
  local unlock_list = self:get_unlock_list()
  local unlock_id_list = unlock_list[tag_id]
  if not unlock_id_list then
    return true
  end
  for unlock_idx, stroy_unlock_id in pairs(unlock_id_list) do
    if stroy_unlock_id == dec_id then
      return false
    end
  end
  return true
end

function ui:update_desccontent_pos(idx)
  local cur_content_size = 7
  if idx > cur_content_size then
    local content_x = self.v_uicompents.TagList2_rect.anchoredPosition.x
    local content_spacing_cpt = Util.get_component(nil, self.v_uiobjects.TagList2, typeof(VerticalLayoutGroup))
    local height = self.v_uicompents.TagItem2_rect.sizeDelta.y
    local content_spacing = content_spacing_cpt.spacing
    local move_y = (height + content_spacing) * (idx - cur_content_size)
    self.v_uicompents.TagList2_rect:SetAnchoredPositionA(content_x, move_y)
  else
    self.v_uicompents.TagList2_rect:SetAnchoredPositionA(0, 0)
  end
end

return ui
