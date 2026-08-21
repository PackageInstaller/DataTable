local Base = require("ui.uiobject")
local AttrItem = Util.create_child_mt(Base)

function AttrItem:ui_finish_load()
  self:set_button("BtnChangeRefine", function()
    self:on_click_BtnChangeRefine()
  end)
  self:set_button("BtnSelectRefine", function()
    self:on_click_BtnChangeRefine()
  end)
  self.v_bg_eff_obj = Util.get_child("Bg/Fx_Bg", self.v_uiobjects.After)
end

function AttrItem:on_click_BtnChangeRefine()
  local selected_attr_map = {}
  local puzzle_data = PuzzleMgr:get_puzzle_data(self.v_uuid)
  if puzzle_data and puzzle_data.attr_list then
    for _, id in ipairs(puzzle_data.attr_list) do
      selected_attr_map[id] = true
    end
  end
  selected_attr_map = self.v_parent_ui:get_selected_attrs(selected_attr_map)
  UIMgr:get_ui("puzzle_refine_attr_select_tips"):ui_show(self.v_idx, self.v_uuid, selected_attr_map, self.v_selected_attr_cfg_id)
end

function AttrItem:ui_on_show()
  self:bind_auto_mq(Const.MSG_CHANGE_PUZZLE_REFINE_SELECTED_ATTR, self.on_attr_selected_change, self)
  self.v_uiobjects.Ani_AttrLayout_RefreshR:SetActiveEx(false)
end

function AttrItem:ui_on_hide()
end

function AttrItem:ui_on_destroy()
end

function AttrItem:on_attr_selected_change(msg)
  local data = msg.mm_obj
  if self.v_uuid ~= data.uuid or self.v_idx ~= data.idx or self.v_selected_attr_cfg_id == data.selected_id then
    return
  end
  self:select_attr(data.selected_id)
end

function AttrItem:get_selected_id()
  return self.v_selected_attr_cfg_id
end

function AttrItem:get_id()
  return self.v_attr_cfg_id
end

function AttrItem:init_by_uuid(idx, uuid, play_refine_ani)
  local catch_attr_id = self.v_attr_cfg_id
  self.v_idx = idx
  self.v_uuid = uuid
  self.v_selected_attr_cfg_id = nil
  self.v_attr_cfg_id = nil
  local is_empty = nil == uuid
  self.v_uiobjects.NoAttr:SetActiveEx(is_empty)
  self.v_uiobjects.Attr:SetActiveEx(not is_empty)
  self.v_uiobjects.Arrow:SetActiveEx(not is_empty)
  self.v_uiobjects.After:SetActiveEx(not is_empty)
  self.v_uiobjects.Ani_RefineObj_RefreshL:SetActiveEx(false)
  self.v_uiobjects.Fx_ChongkeRefresh:SetActiveEx(false)
  if is_empty then
    return
  end
  local puzzle_data = PuzzleMgr:get_puzzle_data(uuid)
  local is_attr_empty = not puzzle_data or not puzzle_data.attr_list or not puzzle_data.attr_list[idx]
  self.v_uiobjects.NoAttr:SetActiveEx(is_attr_empty)
  self.v_uiobjects.Attr:SetActiveEx(not is_attr_empty)
  self.v_uiobjects.NoAfterAttr:SetActiveEx(is_attr_empty)
  self.v_bg_eff_obj:SetActiveEx(not is_attr_empty)
  self.v_uiobjects.AttrAfter:SetActiveEx(not is_attr_empty)
  self.v_uiobjects.BtnSelectRefine:SetActiveEx(not is_attr_empty)
  self.v_uiobjects.BtnChangeRefine:SetActiveEx(false)
  if is_attr_empty then
    return
  end
  local attr_cfg_id = puzzle_data.attr_list[idx]
  local is_attr_change = catch_attr_id ~= attr_cfg_id and play_refine_ani
  self.v_attr_cfg_id = attr_cfg_id
  local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
  local attr_val = attr_cfg.AttrValue
  local attr_show_cfg = ShareRes.get_buddy_puzzle_attr_show_cfg(attr_cfg.AttrId)
  self.v_uicompents.AttrName_txt.text = attr_show_cfg.Desc
  local is_ration = 1 == attr_show_cfg.AttrType
  self.v_uicompents.AttrNum_txt.text = Util.format_number(attr_val, is_ration)
  self.v_uicompents.AttrNameAfter_txt.text = ""
  self.v_uicompents.AttrNumAfter_txt.text = ""
  if is_attr_change then
    self.v_uiobjects.Ani_RefineObj_RefreshL:SetActiveEx(true)
    self.v_uiobjects.Fx_ChongkeRefresh:SetActiveEx(true)
  end
end

function AttrItem:select_attr(attr_cfg_id)
  self.v_selected_attr_cfg_id = attr_cfg_id
  if attr_cfg_id then
    local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
    local attr_val = attr_cfg.AttrValue
    local attr_show_cfg = ShareRes.get_buddy_puzzle_attr_show_cfg(attr_cfg.AttrId)
    self.v_uicompents.AttrNameAfter_txt.text = attr_show_cfg.Desc
    local is_ration = 1 == attr_show_cfg.AttrType
    self.v_uicompents.AttrNumAfter_txt.text = Util.format_number(attr_val, is_ration)
  end
  self.v_uiobjects.BtnSelectRefine:SetActiveEx(nil == attr_cfg_id)
  self.v_uiobjects.BtnChangeRefine:SetActiveEx(nil ~= attr_cfg_id)
  self.v_uiobjects.Ani_AttrLayout_RefreshR:SetActiveEx(false)
  self.v_uiobjects.Ani_AttrLayout_RefreshR:SetActiveEx(nil ~= attr_cfg_id)
  self.v_parent_ui:refresh_cost()
end

local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnUnload", function()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_CHOOSE_PUZZLE_ITEM)
    msg.mm_x = nil
  end)
  self:set_button("BtnRefine", function()
    self:on_click_refine()
  end)
  self.v_attr_obj = {
    [1] = self.v_uiobjects.AttrTem1,
    [2] = self.v_uiobjects.AttrTem2,
    [3] = self.v_uiobjects.AttrTem3
  }
end

function ui:on_click_refine()
  if not self.v_operate_uuid then
    Util.show_message_tip(2350)
    return
  end
  if self.v_puzzle_select_but_not_refine then
    return
  end
  if not self.v_cost_enough then
    Util.show_message_tip(2115)
    return
  end
  local attr_list = self:get_selected_attr_list()
  if not attr_list or not next(attr_list) then
    Util.show_message_tip(2350)
    return
  end
  
  local function confirm_cb()
    PuzzleMgr:refine_puzzle(self.v_operate_uuid, attr_list, function()
      Util.show_message_tip(2351)
      self:change_operate_item(self.v_operate_uuid, true)
    end)
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_puzzle_refine_btn_UI_SOUND)
  end
  
  Util.show_notify_popup_message(confirm_cb, "是否进行重刻？")
end

function ui:get_result_puzzle_data()
  if not self.v_operate_uuid or not self.v_cost_uuid then
    return nil
  end
  local puzzle_data = PuzzleMgr:get_puzzle_data(self.v_operate_uuid)
  local cost_puzzle_data = PuzzleMgr:get_puzzle_data(self.v_cost_uuid)
  local attr_list = {}
  for _, attr_cfg_id in ipairs(puzzle_data.attr_list) do
    attr_list[#attr_list + 1] = attr_cfg_id
  end
  for _, attr_cfg_id in ipairs(cost_puzzle_data.attr_list) do
    attr_list[#attr_list + 1] = attr_cfg_id
  end
  local fake_data = {
    id = puzzle_data.id,
    quality = puzzle_data.quality + 1,
    attr_list = attr_list
  }
  return fake_data
end

function ui:ui_on_show(uuid)
  self.v_operate_uuid = nil
  self:warp_attr_items(uuid)
  self:change_operate_item(uuid)
  self.v_parent_ui:on_puzzle_list_update()
end

function ui:ui_on_hide()
  self:clear_wrap_items()
  self.v_operate_uuid = nil
  self.v_parent_ui:on_puzzle_list_update()
  self:set_enable(false)
end

function ui:reset_view()
  self.v_operate_uuid = nil
  self.v_uiobjects.PluginsInfo:SetActive(false)
  self.v_uiobjects.Empty:SetActive(true)
  self:reset_cost_view()
  self:refresh_attr_items_by_uuid(nil)
end

function ui:clear_wrap_items()
  if self.v_attr_items then
    for idx = #self.v_attr_items, 1, -1 do
      local item = self.v_attr_items[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_attr_items[idx] = nil
    end
    self.v_attr_items = nil
  end
end

function ui:refresh_attr_items_by_uuid(uuid, play_refine_ani)
  if not self.v_attr_items then
    self:warp_attr_items(uuid)
    return
  end
  for idx, item in ipairs(self.v_attr_items) do
    item:init_by_uuid(idx, uuid, play_refine_ani)
  end
  self.v_puzzle_select_but_not_refine = true
end

function ui:warp_attr_items(uuid)
  self.v_attr_items = {}
  for idx, obj in ipairs(self.v_attr_obj) do
    local item = AttrItem:ui_wrap_ex(self, obj, true)
    item:init_by_uuid(idx, uuid)
    table.insert(self.v_attr_items, item)
  end
end

function ui:get_selected_attrs(selected_attr_map)
  if not self.v_attr_items then
    return selected_attr_map
  end
  for _, item in ipairs(self.v_attr_items) do
    local selected_id = item:get_selected_id()
    if selected_id then
      selected_attr_map[selected_id] = true
    end
  end
  return selected_attr_map
end

function ui:get_selected_attr_list()
  if not self.v_attr_items then
    return nil
  end
  local list = {}
  for _, item in ipairs(self.v_attr_items) do
    local id = item:get_id()
    local selected_id = item:get_selected_id()
    if id and selected_id then
      list[#list + 1] = {attr_id = id, target_attr_id = selected_id}
    end
  end
  return list
end

function ui:get_refine_num()
  if not self.v_attr_items then
    return 0
  end
  local num = 0
  for _, item in ipairs(self.v_attr_items) do
    local selected_id = item:get_selected_id()
    if selected_id then
      num = num + 1
    end
  end
  return num
end

function ui:reset_cost_view()
  self.v_uiobjects.Curr:SetActive(false)
  self.v_cost_enough = false
  Util.apply_grey_ex(self.v_uiobjects.BtnRefine, true)
end

function ui:change_selected_item(uuid)
  self:change_operate_item(uuid)
end

function ui:change_operate_item(uuid, play_refine_ani)
  self.v_operate_uuid = uuid
  local puzzle_data = PuzzleMgr:get_puzzle_data(uuid)
  if not puzzle_data then
    self:reset_view()
    return
  end
  self.v_puzzle_id = puzzle_data.id
  self:set_puzzle_item(puzzle_data.id, puzzle_data.quality)
  self:refresh_attr_items_by_uuid(uuid, play_refine_ani)
  self:reset_cost_view()
end

function ui:set_puzzle_item(puzzle_id, quality)
  local item_id = puzzle_id
  local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(item_id)
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_quality_path(quality)
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, item_icon_path)
  ResMgr:load_set_icon(self.v_uicompents.Quality_img, item_quality_path)
  self.v_uicompents.PluginsName_txt.text = puzzle_cfg.Name
  if puzzle_cfg.EntryId then
    local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(puzzle_cfg.EntryId, quality)
    self.v_uicompents.EffectName_txt.text = entry_cfg.Name
  else
    self.v_uicompents.EffectName_txt.text = ""
  end
  self.v_uiobjects.PluginsInfo:SetActive(true)
  self.v_uiobjects.Empty:SetActive(false)
end

function ui:refresh_cost()
  self.v_puzzle_select_but_not_refine = false
  if not self.v_operate_uuid then
    self:reset_cost_view()
    return
  end
  local refine_num = self:get_refine_num()
  if 0 == refine_num then
    self.v_puzzle_select_but_not_refine = true
    self:reset_cost_view()
    return
  end
  local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(self.v_puzzle_id)
  local cost_id = puzzle_cfg.RefineItemId
  local cost_count = puzzle_cfg.RefineItemCount * refine_num
  local own_num = BagMgr:get_item_num(cost_id)
  local cost_icon_path = ShareRes.get_item_icon_path(cost_id)
  ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, cost_icon_path)
  self.v_uicompents.CurrNum_txt.text = string.format("<color=#%s>%s</color>", cost_count > own_num and "e0212c" or "F5EDE2", cost_count)
  self.v_cost_enough = cost_count <= own_num
  self.v_uiobjects.Curr:SetActiveEx(true)
  Util.apply_grey_ex(self.v_uiobjects.BtnRefine, not self.v_cost_enough)
end

function ui:get_operate_puzzle_id()
  if self.v_operate_uuid then
    local puzzle_data = PuzzleMgr:get_puzzle_data(self.v_operate_uuid)
    if puzzle_data then
      return puzzle_data.id
    end
  end
end

function ui:get_operate_puzzle_attr_map()
  if self.v_operate_uuid then
    local puzzle_data = PuzzleMgr:get_puzzle_data(self.v_operate_uuid)
    if puzzle_data and puzzle_data.attr_list then
      local attr_map = {}
      for _, attr_cfg_id in ipairs(puzzle_data.attr_list) do
        local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
        attr_map[attr_cfg.AttrId] = true
      end
      return attr_map
    end
  end
end

function ui:get_operate_puzzle_entry_id()
  if self.v_operate_uuid then
    local puzzle_data = PuzzleMgr:get_puzzle_data(self.v_operate_uuid)
    if puzzle_data then
      return ShareRes.get_buddy_puzzle_cfg(puzzle_data.id).EntryId
    end
  end
end

return ui
