local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")

function ui:ui_finish_load()
  self:set_button("BtnRankUp", function()
    local puzzle_data = PuzzleMgr:get_puzzle_data(self.v_operate_uuid)
    if not puzzle_data then
      return
    end
    local old_quality = puzzle_data.quality
    PuzzleMgr:upgrade_puzzle(self.v_operate_uuid, {
      self.v_cost_uuid
    }, function()
      if not self.v_cost_enough then
        return
      end
      self.v_parent_ui:show_up_lv_suc_eff()
      self:remove_effect_timer()
      self.v_effect_timer = Timer:add_timer("puzzle_up_lv_suc_eff_timer", 0.5, function()
        UIMgr:get_ui("puzzle_up_grade_tips"):ui_show(self.v_operate_uuid, old_quality)
        if self.v_auto_select_after_lv_up then
          self:change_operate_item(self.v_operate_uuid)
        else
          self:change_operate_item(nil)
        end
      end)
    end)
  end)
  self:set_button("Quality1", function()
    Util.show_puzzle_tip(self.v_operate_uuid, {
      offset = Config.PUZZLE_TIPS_OFFSET.MAP_ITEM,
      show_remove_btn = true,
      remove_cb = function()
        self:change_operate_item(nil)
      end
    })
  end)
  self:set_button("Quality2", function()
    Util.show_puzzle_tip(self.v_operate_uuid, {
      offset = Config.PUZZLE_TIPS_OFFSET.MAP_ITEM,
      puzzle_data = self:get_result_puzzle_data()
    })
  end)
  self:set_button("BtnUnload", function()
    self:change_operate_item(nil)
  end)
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
  self:change_operate_item(uuid)
end

function ui:ui_on_hide()
  self:clear_warp_item()
  self:remove_effect_timer()
  self.v_operate_uuid = nil
  self.v_cost_uuid = nil
  self.v_parent_ui:on_puzzle_list_update()
  self:set_enable(false)
end

function ui:reset_view()
  self.v_operate_uuid = nil
  self.v_uiobjects.PluginsInfo1:SetActive(false)
  self.v_uiobjects.Empty1:SetActive(true)
  self:reset_cost_view()
end

function ui:reset_cost_view()
  self.v_cost_uuid = nil
  self.v_uiobjects.PluginsInfo2:SetActive(false)
  self.v_uiobjects.Empty2:SetActive(true)
  self.v_uiobjects.EmptyCost:SetActive(true)
  self.v_uiobjects.ItemObjCom1:SetActive(false)
  self.v_uiobjects.Hero:SetActive(false)
  self.v_uiobjects.CurrCost:SetActive(false)
  self.v_cost_enough = false
  Util.apply_grey_ex(self.v_uiobjects.BtnRankUp, true)
  self:clear_warp_item()
end

function ui:change_selected_item(uuid)
  if not self.v_operate_uuid then
    self:change_operate_item(uuid)
  else
    self:change_cost_item(uuid)
  end
end

function ui:change_operate_item(uuid)
  self.v_operate_uuid = uuid
  self.v_cost_uuid = nil
  self.v_parent_ui:on_puzzle_list_update()
  if not uuid then
    self:reset_view()
    return
  end
  local puzzle_data = PuzzleMgr:get_puzzle_data(uuid)
  if not puzzle_data then
    self:reset_view()
    return
  end
  self:set_puzzle_item(1, puzzle_data.id, puzzle_data.quality)
  self.v_auto_select_after_lv_up = puzzle_data.quality + 1 < Config.PUZZLE_MAX_QUALITY
  self:reset_cost_view()
end

function ui:set_puzzle_item(idx, puzzle_id, quality)
  local item_id = puzzle_id
  local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(item_id)
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_quality_path(quality)
  ResMgr:load_set_icon(self.v_uicompents["Icon" .. idx .. "_img"], item_icon_path)
  ResMgr:load_set_icon(self.v_uicompents["Quality" .. idx .. "_img"], item_quality_path)
  self.v_uicompents["PluginsName" .. idx .. "_txt"].text = puzzle_cfg.Name
  if puzzle_cfg.EntryId then
    local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(puzzle_cfg.EntryId, quality)
    self.v_uicompents["EffectName" .. idx .. "_txt"].text = entry_cfg.Name
  else
    self.v_uicompents["EffectName" .. idx .. "_txt"].text = ""
  end
  self.v_uiobjects["PluginsInfo" .. idx]:SetActive(true)
  self.v_uiobjects["Empty" .. idx]:SetActive(false)
end

function ui:change_cost_item(uuid)
  self.v_cost_uuid = uuid
  if not uuid then
    self:reset_cost_view()
    return
  end
  if not self.v_operate_uuid then
    return
  end
  local puzzle_data = PuzzleMgr:get_puzzle_data(self.v_operate_uuid)
  self:set_puzzle_item(2, puzzle_data.id, puzzle_data.quality + 1)
  self.v_uiobjects.EmptyCost:SetActive(false)
  self.v_uiobjects.ItemObjCom1:SetActive(true)
  puzzle_data = PuzzleMgr:get_puzzle_data(uuid)
  local fake_item_data = {
    id = puzzle_data.id,
    count = 1,
    cb = function()
      Util.show_puzzle_tip(self.v_cost_uuid, {
        offset = Config.PUZZLE_TIPS_OFFSET.MIDDLE,
        show_up_lv_btn = false,
        show_remove_btn = true,
        show_select_btn = false,
        show_dark_mask = false,
        remove_cb = function()
          self:change_cost_item()
        end
      })
    end
  }
  self:clear_warp_item()
  self.v_wrap_item = ITEM_OBJ_COM:ui_wrap_ex(self, self.v_uiobjects.ItemObjCom1, true)
  self.v_wrap_item:set_data(fake_item_data)
  local graph_id = ShareRes.get_buddy_puzzle_cfg(puzzle_data.id).GraphID
  local cost_cfg = ShareRes.get_buddy_puzzle_upLv_cfg(puzzle_data.quality, graph_id)
  self.v_uiobjects.CurrCost:SetActive(nil ~= cost_cfg)
  if cost_cfg then
    local cost_id = cost_cfg.ConsumeItemId
    local cost_count = cost_cfg.ConsumeItemCount
    local own_num = BagMgr:get_item_num(cost_id)
    local cost_icon_path = ShareRes.get_item_icon_path(cost_id)
    ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, cost_icon_path)
    self.v_uicompents.CurrNum_txt.text = string.format("<color=#%s>%s</color>", cost_count > own_num and "e0212c" or "F5EDE2", cost_count)
    self.v_cost_enough = cost_count <= own_num
  else
    self.v_cost_enough = true
  end
  Util.apply_grey_ex(self.v_uiobjects.BtnRankUp, not self.v_cost_enough)
  local owner = puzzle_data.buddy_id or 0
  self.v_uiobjects.Hero:SetActive(0 ~= owner)
  if 0 ~= owner then
    local path = CharacterMgr:get_buddy_icon_path(owner)
    ResMgr:load_set_icon(self.v_uicompents.hero_head_icon_img, path)
  end
end

function ui:clear_warp_item()
  if self.v_wrap_item then
    self.v_wrap_item:ui_hide()
    self.v_wrap_item:ui_destroy()
    self.v_wrap_item = nil
  end
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

function ui:remove_effect_timer()
  if self.v_effect_timer then
    Timer:remove_timer(self.v_effect_timer)
    self.v_effect_timer = nil
  end
end

return ui
