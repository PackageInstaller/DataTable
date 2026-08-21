local Base = require("ui.uibase")
local LoopListClass = require("ui.widget.infinite_loop_list")
local RelicItemClass = require("uimodule.character.relic.relic_operate_item")
local _tinsert = table.insert
local _tsort = table.sort
local _tremove = table.remove
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_main = {
    "BtnMain",
    BIND_TYPE.BUTTON
  },
  v_btn_ret1 = {
    "BtnRet1",
    BIND_TYPE.BUTTON
  },
  v_btn_screen_up_down = {
    "Btn_screenUpDown",
    BIND_TYPE.BUTTON
  },
  v_btn_screen = {
    "Btn_screen",
    BIND_TYPE.BUTTON
  },
  v_engrave_bag_show = {
    "EngraveBagShow",
    BIND_TYPE.OBJECT
  },
  v_engrave_char_show = {
    "EngraveCharShow",
    BIND_TYPE.OBJECT
  },
  v_engrave_info = {
    "EngraveInfo",
    BIND_TYPE.OBJECT
  },
  v_engrave_level_up = {
    "EngraveLevelUp",
    BIND_TYPE.OBJECT
  },
  v_engrave_tem = {
    "EngraveTem",
    BIND_TYPE.BUTTON
  },
  v_left_list_view = {
    "LeftListView",
    BIND_TYPE.OBJECT
  },
  v_owner_bag = {
    "OwnerBag",
    BIND_TYPE.IMAGE
  },
  v_owner = {
    "Owner",
    BIND_TYPE.IMAGE
  },
  v_part1 = {
    "Part1",
    BIND_TYPE.TOGGLE
  },
  v_part2 = {
    "Part2",
    BIND_TYPE.TOGGLE
  },
  v_part3 = {
    "Part3",
    BIND_TYPE.TOGGLE
  },
  v_part4 = {
    "Part4",
    BIND_TYPE.TOGGLE
  },
  v_screen_up_down = {
    "ScreenUpDown",
    BIND_TYPE.OBJECT
  },
  v_scroll_view = {
    "ScrollView",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_bag_show_ani = Util.get_child_gameobj("SafeArea/Animation/Ani_EngraveBagShow_IN", self.v_object)
  self.v_info_show_ani = Util.get_child_gameobj("SafeArea/Animation/Ani_EngraveCharShow_IN", self.v_object)
  self.v_info_show_ani_ex = Util.get_child_gameobj("SafeArea/Animation/Ani_EngraveCharShow_IN_ex", self.v_object)
  self.v_info_out_ani = Util.get_child_gameobj("SafeArea/Animation/Ani_EngraveCharShow_Out", self.v_object)
  self.v_upgrade_show_ani = Util.get_child_gameobj("SafeArea/Animation/Ani_EngraveLevelUp_IN", self.v_object)
  self:set_button("BtnRet1", function()
    self:on_click_return()
  end)
  self:set_button("Btn_screenUpDown", function()
    RelicMgr.v_is_drop = not RelicMgr.v_is_drop
    local rot_z = RelicMgr.v_is_drop and 0 or 180
    self.v_screen_up_down.transform:SetEuler(0, 0, rot_z)
    self:refresh_left_list()
  end)
  self:set_button("Btn_screen", function()
    local exclude_uuid
    if self.v_is_doing_upgrade then
      exclude_uuid = self.v_operate_relic_uuid
    end
    UIMgr:get_ui("relic_filter_tips"):ui_show(self.v_slot_idx, exclude_uuid)
  end)
  self.v_left_scroll_list = LoopListClass:new(self, self.v_uiobjects.ScrollView, RelicItemClass)
end

function ui:on_click_return()
  if self.v_is_doing_upgrade then
    local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_operate_relic_uuid)
    if relic_data then
      self.v_slot_idx = ShareRes.get_relic_cfg(relic_data.id).Slot
    end
    self:switch_page(false)
    return
  end
  RelicMgr:reset_filter()
  self:ui_hide()
end

function ui:on_go_to_main()
  RelicMgr:reset_filter()
end

function ui:ui_on_hide()
  self.v_consume_list = {}
  self.v_left_scroll_list:ui_on_hide()
  self:remove_cannot_touch_timer()
end

function ui:ui_on_destroy()
  self.v_consume_list = {}
  self.v_left_scroll_list:ui_on_destroy()
  self:remove_cannot_touch_timer()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_source_buddy, self.v_slot_idx, self.v_operate_relic_uuid, self.v_is_from_bag, self.v_is_doing_upgrade
end

function ui:ui_on_show(buddy_id, slot_idx, relic_uuid, is_from_bag, is_doing_upgrade)
  self.v_consume_list = {}
  self:set_source_buddy(buddy_id)
  self.v_is_doing_upgrade = true == is_doing_upgrade
  self.v_is_from_bag = true == is_from_bag
  self.v_bag_show_ani:SetActive(false)
  self.v_bag_show_ani:SetActive(self.v_is_from_bag and not self.v_is_doing_upgrade)
  slot_idx = slot_idx or self:get_not_empty_slot()
  self:init_left_slot_tab(slot_idx)
  relic_uuid = relic_uuid or self:get_left_list_first_relic_uuid(true)
  self:set_operate_relic(relic_uuid)
  self:switch_page(self.v_is_doing_upgrade)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.refresh_whole_view_keep_order, self)
  self:bind_auto_mq(Const.MSG_ON_RELIC_UPDATE, self.refresh_whole_view_keep_order, self)
  self:bind_auto_mq(Const.MSG_ON_RELIC_FILTER_UPDATE, self.refresh_whole_view, self)
  self:set_cannot_touch(false)
end

function ui:refresh_whole_view()
  self:refresh_left_list()
  self:refresh_center_right_view()
end

function ui:refresh_whole_view_keep_order()
  self:refresh_left_list(nil, true)
  self:refresh_center_right_view()
end

function ui:switch_page(is_doing_upgrade)
  self.v_is_doing_upgrade = is_doing_upgrade
  self:update_left_slot_tab()
  self:update_bag_view()
  self:switch_slot_tog(self.v_slot_idx)
  self:refresh_center_right_view()
  self.v_info_show_ani:SetActiveEx(false)
  self.v_info_out_ani:SetActiveEx(false)
  self.v_upgrade_show_ani:SetActiveEx(false)
  if self.v_is_doing_upgrade then
    self.v_info_out_ani:SetActive(true)
    self.v_upgrade_show_ani:SetActive(true)
  else
    self.v_info_show_ani:SetActive(true)
  end
end

function ui:update_bag_view()
  local show_info_from_bag = self.v_is_from_bag and not self.v_is_doing_upgrade
  self.v_left_list_view:SetActive(not show_info_from_bag)
  self.v_engrave_bag_show:SetActive(show_info_from_bag)
  self.v_engrave_char_show:SetActive(not show_info_from_bag)
  self.v_center_root = show_info_from_bag and self.v_engrave_bag_show or self.v_engrave_char_show
  self.v_center_slot_txt = Util.get_text("Part_", self.v_center_root)
  self.v_center_lv_txt = Util.get_text("LV_", self.v_center_root)
  self.v_center_bg_img = Util.get_image("QualityBg_", self.v_center_root)
  self.v_center_icon = Util.get_image("EngraveIcon_", self.v_center_root)
end

function ui:switch_slot_tog(slot_idx)
  self.v_tog_list[slot_idx].isOn = false
  self.v_tog_list[slot_idx].isOn = true
end

function ui:init_left_slot_tab(slot_idx)
  self.v_slot_idx = slot_idx
  self.v_tog_list = {}
  for i = 1, 4 do
    self.v_tog_list[i] = self["v_part" .. i]
    local is_unlock = RelicMgr:is_buddy_slot_unlock(self.v_source_buddy, i)
    local lock_obj = self:get_child_gameobj("Lock", self.v_uiobjects["Part" .. i])
    lock_obj:SetActiveEx(not is_unlock)
    self:set_toggle("Part" .. i, function(is_on)
      if is_on then
        self:on_click_slot(i)
        if is_unlock then
          self.v_tog_list[i].interactable = false
        end
      end
    end, false)
  end
  self:switch_slot_tog(self.v_slot_idx)
end

function ui:update_left_slot_tab()
  for i = 1, 4 do
    local is_unlock = true
    if not self.v_is_doing_upgrade and self.v_source_buddy then
      is_unlock = RelicMgr:is_buddy_slot_unlock(self.v_source_buddy, i)
    end
    local lock_obj = self:get_child_gameobj("Lock", self.v_uiobjects["Part" .. i])
    lock_obj:SetActiveEx(not is_unlock)
  end
end

function ui:on_click_slot(idx)
  if self.v_is_doing_upgrade then
    self:refresh_left_list(idx)
  elseif not self.v_is_from_bag then
    local is_unlock = RelicMgr:is_buddy_slot_unlock(self.v_source_buddy, idx)
    if is_unlock then
      self:refresh_left_list(idx)
      self:set_operate_relic(self:get_left_list_first_relic_uuid())
      return
    end
    local buddy_slot_cfg = ShareRes.get_relic_slot_cfg(self.v_source_buddy)
    local condition_id = buddy_slot_cfg[idx].Condition
    if condition_id then
      local condition = ShareRes.create("condition.condition", condition_id)
      Util.show_message_tip(condition.Desc)
    end
    self.v_tog_list[self.v_slot_idx].isOn = true
  end
end

function ui:get_not_empty_slot()
  local exclude_uuid, if_add_exp_item
  if self.v_is_doing_upgrade then
    exclude_uuid = self.v_operate_relic_uuid
    if_add_exp_item = true
  end
  for idx = 1, 4 do
    local temp_sort_list = RelicMgr:get_filter_sort_list(idx, exclude_uuid, nil, if_add_exp_item)
    if temp_sort_list and next(temp_sort_list) ~= nil then
      return idx
    end
  end
  return 1
end

function ui:get_left_list_first_relic_uuid(filt_wear)
  if filt_wear then
    for _, data in ipairs(self.v_left_list_data) do
      if not data.is_wear then
        return data.relic_uuid
      end
    end
  end
  if self.v_left_list_data[1] then
    return self.v_left_list_data[1].relic_uuid
  end
  return 0
end

function ui:refresh_left_list(slot_idx, keep_order)
  if slot_idx then
    self.v_slot_idx = slot_idx
  end
  local exclude_uuid, if_add_exp_item, first_uuid
  if self.v_is_doing_upgrade then
    exclude_uuid = self.v_operate_relic_uuid
    if_add_exp_item = true
  elseif keep_order then
    first_uuid = self.v_old_first_uuid
  else
    first_uuid = RelicMgr:get_relic_uuid_by_buddy_slot(self.v_source_buddy, self.v_slot_idx)
    self.v_old_first_uuid = first_uuid
  end
  self.v_left_list_data = RelicMgr:get_filter_sort_list(self.v_slot_idx, exclude_uuid, nil, if_add_exp_item, first_uuid)
  self.v_left_scroll_list:refresh_data(self.v_left_list_data)
  if keep_order then
    self.v_left_scroll_list:scroll_to_old_pos()
  end
  local is_list_empty = 0 == #self.v_left_list_data
  self.v_uiobjects.NoItem:SetActive(is_list_empty)
end

function ui:set_operate_relic(uuid)
  if self.v_is_doing_upgrade then
    return
  end
  self.v_operate_relic_uuid = uuid or 0
  self:update_bag_view()
  self:refresh_center_right_view()
  self:on_consume_selected_update()
end

function ui:refresh_center_right_view()
  if 0 == self.v_operate_relic_uuid then
    self.v_panels.sub_page_info:set_enable(false)
    self.v_panels.sub_page_upgrade:set_enable(false)
    self.v_center_root:SetActiveEx(false)
    self.v_uiobjects.Owner:SetActive(false)
    return
  end
  self.v_info_show_ani_ex:SetActive(false)
  self.v_info_show_ani_ex:SetActive(true)
  local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_operate_relic_uuid)
  local relic_cfg = ShareRes.get_relic_cfg(relic_data.id)
  self.v_center_slot_txt.text = Util.format_str("{1}号位", relic_cfg.Slot)
  self.v_center_lv_txt.text = Util.format_str("LV.{1}", relic_data.lv)
  local quality_path = ShareRes.get_item_quality_cfg(relic_cfg.Quality).RelicCircleBgBigIcon
  ResMgr:load_set_icon(self.v_center_bg_img, quality_path)
  local icon_path = UtilUI.get_item_icon(relic_data.id)
  ResMgr:load_set_icon(self.v_center_icon, icon_path)
  local owner_id = relic_data.buddy_id or 0
  local show_bag_owner = self.v_is_from_bag and not self.v_is_doing_upgrade and 0 ~= owner_id
  local show_source_buddy = 0 ~= self.v_source_buddy and not self.v_is_doing_upgrade
  self.v_uiobjects.Owner:SetActive(show_source_buddy)
  self:set_buddy_head_ui(self.v_uiobjects.OwnerBag, owner_id, show_bag_owner)
  self.v_panels.sub_page_info:set_enable(not self.v_is_doing_upgrade)
  self.v_panels.sub_page_upgrade:set_enable(self.v_is_doing_upgrade)
  if self.v_is_doing_upgrade then
    self.v_panels.sub_page_upgrade:refresh(self.v_operate_relic_uuid, self.v_source_buddy, self.v_is_from_bag)
  else
    self.v_panels.sub_page_info:refresh(self.v_operate_relic_uuid, self.v_source_buddy, self.v_is_from_bag)
  end
end

function ui:set_buddy_head_ui(ui_root, buddy_id, is_show)
  ui_root:SetActive(is_show)
  if not is_show then
    return
  end
  local owner_head_img = Util.get_image("CharIcon", ui_root)
  local owner_ele_img = Util.get_image("Ele/EleIcon", ui_root)
  local buddy_config = ShareRes.create("buddy.buddy", buddy_id)
  local icon_name = buddy_config.Icon[2]
  local path = string.format("Icon/Profile/%s", icon_name)
  ResMgr:load_set_icon(owner_head_img, path)
  local element_id = buddy_config.Element
  local element_cfg = ShareRes.create("buddy.buddy_element", element_id)
  ResMgr:load_set_icon(owner_ele_img, element_cfg.ElementIconPath)
end

function ui:set_source_buddy(buddy_id)
  self.v_source_buddy = buddy_id or 0
  self:set_buddy_head_ui(self.v_uiobjects.Owner, self.v_source_buddy, 0 ~= self.v_source_buddy)
end

function ui:on_click_relic(uuid)
  if self.v_is_doing_upgrade then
    self:on_click_relic_consume(uuid)
  elseif self.v_operate_relic_uuid ~= uuid then
    self:set_operate_relic(uuid)
  end
end

function ui:on_click_exp_item(exp_item_id, is_delete)
  if self.v_is_doing_upgrade then
    self:on_click_exp_item_consume(exp_item_id, is_delete)
  end
  self:refresh_center_right_view()
end

function ui:on_click_relic_consume(uuid)
  local match_idx
  for idx, consume_data in ipairs(self.v_consume_list) do
    if consume_data.relic_uuid == uuid then
      match_idx = idx
      break
    end
  end
  local show_tips_uuid = uuid
  if match_idx then
    _tremove(self.v_consume_list, match_idx)
    show_tips_uuid = nil
  elseif #self.v_consume_list >= 4 then
    Util.show_message_tip(2264)
  elseif self:calculate_add_exp_overflow() then
    Util.show_message_tip(2265)
  else
    local temp_relic_data = RelicMgr:get_relic_data_by_uuid(uuid)
    if not temp_relic_data then
      self:refresh_left_list()
      return
    end
    local owner_id = temp_relic_data.buddy_id or 0
    local need_unlock = 1 == temp_relic_data.lock
    local need_unwear = 0 ~= owner_id
    if need_unlock or need_unwear then
      local function confirm_cb()
        if need_unlock then
          RelicMgr:req_unlock_relic(uuid, function()
            if not need_unwear then
              self:on_click_relic_consume(uuid)
            end
          end)
        end
        if need_unwear then
          RelicMgr:req_take_off_relic(uuid, function()
            self:on_click_relic_consume(uuid)
          end)
        end
      end
      
      show_tips_uuid = nil
      Util.show_notify_popup_message(confirm_cb, "物品已锁定/已装备，是否解锁/卸下并选中作为消耗？")
    else
      _tinsert(self.v_consume_list, {relic_uuid = uuid})
    end
  end
  Util.show_relic_tip(show_tips_uuid)
  self:on_consume_selected_update()
end

function ui:on_click_exp_item_consume(exp_item_id, is_delete)
  local diff = is_delete and -1 or 1
  local match_idx, temp_result
  for idx, consume_data in ipairs(self.v_consume_list) do
    if consume_data.exp_item_id == exp_item_id then
      temp_result = consume_data.num + diff
      match_idx = idx
      break
    end
  end
  if match_idx then
    if temp_result <= 0 then
      _tremove(self.v_consume_list, match_idx)
    else
      if not is_delete and self:calculate_add_exp_overflow() then
        Util.show_message_tip(2265)
        return
      end
      self.v_consume_list[match_idx].num = temp_result
    end
  elseif not is_delete then
    if #self.v_consume_list >= 4 then
      Util.show_message_tip(2264)
    elseif self:calculate_add_exp_overflow() then
      Util.show_message_tip(2265)
    else
      _tinsert(self.v_consume_list, {exp_item_id = exp_item_id, num = 1})
    end
  end
  self:on_consume_selected_update()
end

function ui:clear_all_consume()
  self.v_consume_list = {}
  self:on_consume_selected_update()
end

function ui:set_consume_list(consume_list)
  self.v_consume_list = consume_list
  self:on_consume_selected_update()
end

function ui:get_is_relic_selected(uuid)
  if self.v_is_doing_upgrade then
    for _, consume_data in ipairs(self.v_consume_list) do
      if consume_data.relic_uuid == uuid then
        return true
      end
    end
  else
    return self.v_operate_relic_uuid == uuid
  end
end

function ui:get_is_exp_item_selected(exp_item_id)
  for _, consume_data in ipairs(self.v_consume_list) do
    if consume_data.exp_item_id == exp_item_id then
      return true
    end
  end
end

function ui:get_exp_item_selected_num(exp_item_id)
  for _, consume_data in ipairs(self.v_consume_list) do
    if consume_data.exp_item_id == exp_item_id then
      return consume_data.num
    end
  end
  return 0
end

function ui:on_consume_selected_update()
  local all_itmes = self.v_left_scroll_list:get_all_uis()
  for _, ui_item in pairs(all_itmes) do
    if ui_item:is_visible_item() then
      ui_item:update_selected()
    end
  end
  if self.v_panels.sub_page_upgrade:visible() then
    self.v_panels.sub_page_upgrade:refresh_view()
  end
end

function ui:get_selected_consume_list()
  return self.v_consume_list
end

function ui:calculate_add_exp_overflow()
  local operate_relic_data = RelicMgr:get_relic_data_by_uuid(self.v_operate_relic_uuid)
  local max_lv = ShareRes.get_relic_max_lv(operate_relic_data.id)
  if max_lv <= operate_relic_data.lv then
    return true
  end
  if not self.v_consume_list or not next(self.v_consume_list) then
    return false
  end
  local add_exp = 0
  for _, consume in ipairs(self.v_consume_list) do
    if consume.relic_uuid then
      local relic_data = RelicMgr:get_relic_data_by_uuid(consume.relic_uuid)
      local relic_cfg = ShareRes.get_relic_cfg(relic_data.id)
      local cost_exp = relic_data.exp
      local exp_rev_cfg = ShareRes.create("relic.relic_replace_exp", relic_cfg.Quality)
      if relic_data.lv > 1 then
        local lv_cfg = ShareRes.create("relic.relic_level", relic_cfg.Quality)
        for lv = 1, relic_data.lv do
          cost_exp = cost_exp + lv_cfg[lv].Exp
        end
      end
      add_exp = add_exp + (exp_rev_cfg.BaseExp + cost_exp * exp_rev_cfg.ExpPercent % 10000)
    else
      local exp_item_cfg = ShareRes.create("relic.relic_item", consume.exp_item_id)
      add_exp = add_exp + exp_item_cfg.Exp * consume.num
    end
  end
  local operate_relic_cfg = ShareRes.get_relic_cfg(operate_relic_data.id)
  local operate_relic_lv_cfg = ShareRes.create("relic.relic_level", operate_relic_cfg.Quality)
  local exp_count = operate_relic_data.exp + add_exp
  for lv = operate_relic_data.lv, max_lv do
    exp_count = exp_count - operate_relic_lv_cfg[lv].Exp
    if exp_count < 0 then
      break
    end
  end
  return exp_count >= 0
end

function ui:try_hide_tips()
  UIMgr:try_hide_ui("relic_item_tips")
end

function ui:set_cannot_touch(cannot_touch)
  self.v_uiobjects.CannotTouchBg:SetActive(cannot_touch)
end

function ui:start_cannot_touch_timer()
  self:remove_cannot_touch_timer()
  self.v_cannot_touch_timer = Timer:add_timer("relic_cannot_touch_timer", 0.6, function()
    self.v_uiobjects.CannotTouchBg:SetActive(false)
  end)
end

function ui:remove_cannot_touch_timer()
  if self.v_cannot_touch_timer then
    Timer:remove_timer(self.v_cannot_touch_timer)
    self.v_cannot_touch_timer = nil
  end
end

return ui
