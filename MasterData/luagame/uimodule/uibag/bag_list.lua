local Base = require("ui.uiobject")
local LoopListClass = require("uimodule.uibag.uibag_loop_list")
local BagItem = require("uimodule.uibag.bag_item")
local BagCfg = require("uimodule.uibag.uibag_configs")
local f_type_cfg = ShareRes.create("item.item_subtype", "favor_item")
local ui = Util.create_child_mt(Base)
local _insert, _remove = table.insert, table.remove
local SORT_TYPE = {
  WEAPON_BY_QUALITY = 1,
  WEAPON_BY_LEVEL = 2,
  WEAPON_BY_RECENT = 3,
  ITEM_DEFAULT = 4
}
local ITEM_TYPE = BagCfg.ITEM_TYPE
local WEAPEN_IDX = BagCfg.WEAPEN_IDX
local ITEM_IDX = BagCfg.ITEM_IDX
local QUALITYS = BagCfg.QUALITYS
local MAX_DURATION = BagCfg.MAX_ITEM_DURATION

local function _build_equip_gem_list(gemstone_slot)
  if not gemstone_slot then
    return nil
  end
  local list = {}
  for _, pos_data in pairs(gemstone_slot) do
    if pos_data.uuid and 0 ~= pos_data.uuid then
      list[#list + 1] = pos_data.uuid
    end
  end
  return list
end

local BUILD_FUNCTIONS = {
  [WEAPEN_IDX] = function(weapon)
    local ret_weapon = {}
    local wp_cfg = ShareRes.create("equip.equip", weapon.id)
    ret_weapon.uuid = weapon.uuid
    ret_weapon.id = weapon.id
    ret_weapon.lv = weapon.lv
    ret_weapon.exp = weapon.exp
    ret_weapon.create_time = weapon.create_time
    ret_weapon.create_time_sort = Date.server_time() - weapon.create_time
    ret_weapon.break_lv = weapon.break_lv
    ret_weapon.advance = weapon.advance
    ret_weapon.owner = weapon.owner
    ret_weapon.is_wear = 0 == weapon.owner and 0 or 1
    ret_weapon.lock = weapon.lock
    ret_weapon.priority = ShareRes.get_equip_priority(weapon.id)
    ret_weapon.icon = wp_cfg.Icon
    ret_weapon.quality = wp_cfg.Quality
    ret_weapon.gem_uuid_list = _build_equip_gem_list(weapon.gemstone_slot)
    ret_weapon.is_showing = 1
    return ret_weapon
  end,
  [ITEM_IDX] = function(item)
    local ret_item = {}
    local item_cfg = ShareRes.create("item.item", item.id)
    ret_item.id = item.id
    ret_item.create_time = item.create_time
    ret_item.uuid = item.uuid
    ret_item.count = item.count
    ret_item.end_time = item.end_time
    ret_item.can_sell = 0 ~= item_cfg.SellId
    ret_item.priority = item_cfg.Priority
    ret_item.quality = item_cfg.Quality
    ret_item.duration = 0 ~= item_cfg.Duration and item_cfg.Duration or MAX_DURATION
    ret_item.remain_time = ret_item.duration ~= MAX_DURATION and ret_item.create_time + ret_item.duration - Date.server_time() or MAX_DURATION
    ret_item.name = item_cfg.Name
    ret_item.desc = item_cfg.Desc
    ret_item.world_desc = item_cfg.WorldDesc
    ret_item.icon = item_cfg.Icon
    ret_item.item_type = item_cfg.Type == ITEM_TYPE.COMSUME and ITEM_TYPE.COMSUME or item_cfg.Type == ITEM_TYPE.MATS and ITEM_TYPE.MATS or ITEM_TYPE.OTHERS
    ret_item.show_red = Util.need_check_server_redpoint(item_cfg.Type, item_cfg.Subtype) == true and 0 == item.not_tip or false
    ret_item.is_showing = 1
    if item_cfg.Type == ITEM_TYPE.COMSUME and item_cfg.Subtype == f_type_cfg.SubtypeId then
      ret_item.item_type = ITEM_TYPE.OTHERS
    end
    return ret_item
  end
}

function ui:_build_list(list, idx)
  local build_list = {}
  for i = 1, #list do
    build_list[i] = BUILD_FUNCTIONS[idx](list[i])
  end
  return build_list
end

function ui:set_bag_type(idx)
  if not self.v_bag_lists[idx] then
    return
  end
  self.v_bag_type = idx
  self:sort_list(idx)
  self:update_bag(nil, idx)
end

function ui:update_bag(list, idx, only_set_data, stop_dynamic_effect, is_to_old_pos)
  if list then
    self.v_bag_lists[idx] = self:_build_list(list, idx)
  end
  if idx == self.v_bag_type then
    if only_set_data then
      return
    end
    local show_list = self.v_show_list or {}
    UtilTable.clear_list(show_list)
    local list = self.v_bag_lists[idx]
    for i = 1, #list do
      if 0 ~= list[i].is_showing then
        _insert(show_list, list[i])
      end
    end
    self.v_parent_ui:set_no_item_tip_show_state(#show_list <= 0)
    self.v_item_view:refresh_data(show_list, idx, stop_dynamic_effect)
    if nil ~= is_to_old_pos and true == is_to_old_pos then
      self.v_item_view:scroll_to_old_pos()
    end
    MsgGame:mq_publish2(Const.MSG_BAG_ITEM_SELECT_CHANGE)
  end
end

function ui:update_weapon_filt(quality_list, is_filt, max_select_num)
  if self.pre_quality_list == nil then
    self.pre_quality_list = {
      [QUALITYS.QUALITY_3] = false,
      [QUALITYS.QUALITY_4] = false
    }
  end
  local is_stop_effect, is_to_old_pos
  if quality_list or is_filt then
    local weapon_list = self.v_bag_lists[WEAPEN_IDX]
    local temp
    local num = 0
    for i = 1, #weapon_list do
      temp = weapon_list[i]
      if self.v_parent_ui:is_selecting_weapon() then
        temp.is_showing = (0 ~= temp.owner or 1 == temp.lock) and 0 or 1
      end
      if nil ~= quality_list and nil ~= quality_list[temp.quality] and quality_list[temp.quality] ~= self.pre_quality_list[temp.quality] then
        temp.selected = quality_list[temp.quality] == true
        num = num + 1
      end
      if max_select_num and max_select_num > 0 and max_select_num <= num then
        break
      end
    end
    if (nil == is_filt or false == is_filt) and nil ~= quality_list then
      self.pre_quality_list[QUALITYS.QUALITY_3] = quality_list[QUALITYS.QUALITY_3]
      self.pre_quality_list[QUALITYS.QUALITY_4] = quality_list[QUALITYS.QUALITY_4]
    end
  end
  if nil == quality_list and true == is_filt and not self.v_parent_ui:is_selecting_weapon() and not self.v_parent_ui.is_click_return then
    is_stop_effect = true
    is_to_old_pos = true
  end
  self:sort_list(WEAPEN_IDX)
  self:update_bag(nil, WEAPEN_IDX, nil, is_stop_effect, is_to_old_pos)
end

function ui:update_item_filt(item_type, is_filt)
  local param_is_empty = nil == item_type and true or nil
  if nil == self.v_cur_item_filt then
    self.v_cur_item_filt = ITEM_TYPE.ALL
  end
  local item_type = item_type or self.v_cur_item_filt
  local is_stop_effect, is_to_old_pos
  if item_type then
    self.v_cur_item_filt = item_type
    local list = self.v_bag_lists[ITEM_IDX]
    local temp
    for i = 1, #list do
      temp = list[i]
      if nil == is_filt or false == is_filt or not self.v_parent_ui:is_selecting_item() then
        temp.is_showing = (temp.item_type == item_type or item_type == ITEM_TYPE.ALL) and 1 or 0
      else
        temp.is_showing = (temp.item_type == item_type or item_type == ITEM_TYPE.ALL) and temp.can_sell and 1 or 0
      end
    end
  end
  if nil ~= param_is_empty and true == param_is_empty and true == is_filt and not self.v_parent_ui:is_selecting_item() and not self.v_parent_ui.is_click_return then
    is_stop_effect = true
    is_to_old_pos = true
  end
  self:sort_list(ITEM_IDX)
  self:update_bag(nil, ITEM_IDX, nil, is_stop_effect, is_to_old_pos)
end

function ui:get_selected_list(idx, quality_3, quality_4)
  local equip_datas = self.v_slct_equip_datas
  local uuid_list = self.v_slct_uuid_list
  local id_list = self.v_slct_id_list
  UtilTable.clear_list(equip_datas)
  UtilTable.clear_list(uuid_list)
  UtilTable.clear_list(id_list)
  local wp_list = self.v_bag_lists[idx]
  local temp
  local select_quality_3_count = 0
  local total_quality_3_count = 0
  local select_quality_4_count = 0
  local total_quality_4_count = 0
  for i = 1, #wp_list do
    temp = wp_list[i]
    if temp.selected and 1 == temp.is_showing then
      local equip_data = {
        id = temp.id,
        lv = temp.lv,
        exp = temp.exp,
        break_lv = temp.break_lv,
        quality = temp.quality,
        gem_uuid_list = temp.gem_uuid_list
      }
      _insert(equip_datas, equip_data)
      _insert(uuid_list, temp.uuid)
      _insert(id_list, temp.id)
      if nil ~= quality_3 and temp.quality == quality_3 then
        select_quality_3_count = select_quality_3_count + 1
      end
      if nil ~= quality_4 and temp.quality == quality_4 then
        select_quality_4_count = select_quality_4_count + 1
      end
    end
    if nil ~= quality_3 and temp.quality == quality_3 and 1 == temp.is_showing then
      total_quality_3_count = total_quality_3_count + 1
    end
    if nil ~= quality_4 and temp.quality == quality_4 and 1 == temp.is_showing then
      total_quality_4_count = total_quality_4_count + 1
    end
  end
  return uuid_list, id_list, select_quality_3_count, select_quality_4_count, total_quality_3_count, total_quality_4_count, equip_datas
end

function ui:check_is_select_rich_max(is_need_show_tips, idx)
  local select_num = #self:get_selected_list(idx)
  local decompose_max_num = ShareRes.get_comm_value("DecomposeMaxNum")
  if decompose_max_num and decompose_max_num > 0 and select_num >= decompose_max_num then
    if is_need_show_tips then
      Util.show_message_tip(2319, decompose_max_num)
    end
    return true
  end
  return false
end

local SHOW_TAG = "is_showing"
local TIME_TAG = "create_time_sort"
local WEAR_TAG = "is_wear"
local SORT_ORDER = {
  [SORT_TYPE.WEAPON_BY_QUALITY] = {
    SHOW_TAG,
    "quality",
    WEAR_TAG,
    "lv",
    "break_lv",
    "advance",
    "id",
    "priority"
  },
  [SORT_TYPE.WEAPON_BY_LEVEL] = {
    SHOW_TAG,
    "lv",
    "break_lv",
    WEAR_TAG,
    "quality",
    "advance",
    "id",
    "priority"
  },
  [SORT_TYPE.WEAPON_BY_RECENT] = {
    SHOW_TAG,
    TIME_TAG,
    "id",
    "priority"
  },
  [SORT_TYPE.ITEM_DEFAULT] = {
    SHOW_TAG,
    "remain_time",
    "item_type",
    "priority",
    "id",
    "uuid"
  }
}
local DEC_SORT = {
  [SORT_TYPE.WEAPON_BY_QUALITY] = "quality",
  [SORT_TYPE.WEAPON_BY_LEVEL] = "lv",
  [SORT_TYPE.WEAPON_BY_RECENT] = TIME_TAG
}

local function _camp_func(w1, w2, sort_type, dec_sort)
  local key
  local order = SORT_ORDER[sort_type]
  local need_dec_key = DEC_SORT[sort_type]
  for i = 1, #order do
    key = order[i]
    local v1, v2 = w1[key], w2[key]
    if v1 ~= v2 then
      if key == need_dec_key then
        if dec_sort then
          return v1 > v2
        else
          return v1 < v2
        end
      end
      return v1 > v2
    end
  end
  return w1.uuid > w2.uuid
end

function ui:sort_list(idx)
  local sort_type
  local dec_sort = true
  if idx == WEAPEN_IDX then
    sort_type = self.v_parent_ui.sort_type or SORT_TYPE.WEAPON_BY_QUALITY
    dec_sort = self.v_parent_ui:get_weapon_sort_state()
  elseif idx == ITEM_IDX then
    sort_type = SORT_TYPE.ITEM_DEFAULT
    dec_sort = false
  end
  table.sort(self.v_bag_lists[idx], function(w1, w2)
    local ret = _camp_func(w1, w2, sort_type, dec_sort)
    return ret
  end)
end

function ui:clear_select()
  local cur_list = self.v_bag_lists[self.v_bag_type]
  for i = 1, #cur_list do
    cur_list[i].selected = nil
  end
end

function ui:reset_show()
  local cur_list = self.v_bag_lists[self.v_bag_type]
  for i = 1, #cur_list do
    cur_list[i].is_showing = 1
  end
end

function ui:reset_cur_item_filt_index()
  self.v_cur_item_filt = ITEM_TYPE.ALL
end

function ui:set_pre_quality(quality_type, value)
  self.pre_quality_list[quality_type] = value
end

function ui:get_length_by_bag_type(type)
  local list = self.v_bag_lists[type]
  if not list then
    return 0
  end
  local count = 0
  for i = 1, #list do
    if 0 ~= list[i].is_showing then
      count = count + 1
    end
  end
  return count
end

function ui:ui_wrap(parent, gameobj)
  self = Base.ui_wrap(self, parent, gameobj)
  gameobj:SetActive(true)
  self.v_slct_equip_datas = {}
  self.v_slct_uuid_list = {}
  self.v_slct_id_list = {}
  return self
end

function ui:setup(bag_lists)
  self.v_bag_lists = {}
  for i = 1, 2 do
    self.v_bag_lists[i] = self:_build_list(bag_lists[i], i)
  end
  local sc_view_obj = self.v_parent_ui.v_uiobjects.ItemScrollView
  self.v_item_view = LoopListClass:new(self, sc_view_obj, BagItem)
end

function ui:ui_on_destroy()
  self.v_item_view:ui_on_destroy()
end

function ui:get_item_count(idx)
  if self.v_bag_lists[idx] then
    return #self.v_bag_lists[idx]
  end
  return 0
end

function ui:any_item_can_cell(idx)
  if idx ~= ITEM_IDX then
    return false
  end
  local item_list = self.v_bag_lists[ITEM_IDX]
  if not item_list then
    return false
  end
  for _, tem in ipairs(item_list) do
    if tem.can_sell then
      return true
    end
  end
  return false
end

return ui
