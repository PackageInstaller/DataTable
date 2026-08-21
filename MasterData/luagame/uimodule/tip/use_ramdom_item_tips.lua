local USE_ITEM_TIPS_ITEM = require("uimodule.tip.use_item_tips_item")
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local USE_RAMDOM_ITEM_TEMPLATE = "USE_RAMDOM_ITEM_TEMPLATE"
local Item_Helper = require("utils.item_helper")
local BagCfg = require("uimodule.uibag.uibag_configs")

local function func(award_cfg)
  return {
    ItemId = award_cfg.ItemId,
    Num = award_cfg.Num,
    Name = Item_Helper.get_item_cfg(award_cfg.ItemId).Name
  }
end

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnConfirm", function()
    self:use_item()
  end)
  self:set_button("Add_Btn", function()
    self:on_operation_item(true)
  end)
  self:set_button("Reduce_Btn", function()
    self:on_operation_item(false)
  end)
  self:set_button("Btncancel", function()
    self:ui_hide()
  end)
  self:set_button("BtnMin", function()
    self:refresh_count(1)
  end)
  self:set_button("BtnMax", function()
    local bag_count = BagMgr:get_item_num(self.v_select_item_id)
    local max_count = bag_count > self.v_max_use_count and self.v_max_use_count or bag_count
    self:refresh_count(max_count)
  end)
  self:set_button("FullBgClose", function()
    UIMgr:try_hide_ui("itemTip")
    self:ui_hide()
  end)
  self:set_slider_listener(self.v_uicompents.Slider_sld, function()
    local value = self.v_uicompents.Slider_sld.value
    self:refresh_count(value)
  end)
  self.v_item_list = {}
  self:register_exist_auto_template(USE_RAMDOM_ITEM_TEMPLATE, self.v_uiobjects.ItemTem, self.v_uiobjects.ItemContent)
end

function ui:ui_on_show(item_id, item_uuid, need_select_item_id, need_count)
  self.v_select_count = 0
  self.v_select_item_id = item_id
  self.v_select_uu_id = item_uuid
  self.v_need_select_item_id = need_select_item_id
  self.v_need_count = need_count
  local treasure_chest_unlocked_cfg = ShareRes.create("item.item_subtype", "treasure_chest_unlocked")
  local cfg = ShareRes.get_item_cfg(self.v_select_item_id)
  self.v_is_ramdom_item = cfg.Subtype == treasure_chest_unlocked_cfg.SubtypeId
  local bag_count = BagMgr:get_item_num(self.v_select_item_id)
  self:refresh_award_list(item_id)
  if not need_count or 0 == need_count then
    self.v_select_count = bag_count > self.v_max_use_count and self.v_max_use_count or bag_count
    self:refresh_count()
  end
  self:refresh_text()
end

function ui:ui_on_hide()
  for key, item in pairs(self.v_item_list) do
    item:ui_hide()
    self:remove_wrap_ui(item)
    self.v_item_list[key] = nil
  end
end

function ui:ui_on_destroy()
end

function ui:refresh_text()
  if self.v_is_ramdom_item then
    self.v_uicompents.Title_txt.text = Util.format_str("（消耗使用道具，随机获得以下奖励）")
  else
    self.v_uicompents.Title_txt.text = Util.format_str("（消耗使用道具，获得以下全部奖励）")
  end
end

function ui:refresh_count(value)
  local bag_count = BagMgr:get_item_num(self.v_select_item_id)
  local max_count = bag_count > self.v_max_use_count and self.v_max_use_count or bag_count
  self.v_uicompents.OwnNum_txt.text = bag_count
  if 1 == max_count then
    self.v_uicompents.Slider_sld.interactable = false
    self.v_uicompents.Slider_sld.minValue = 0
    self.v_uicompents.Slider_sld.maxValue = 1
  else
    self.v_uicompents.Slider_sld.interactable = true
    self.v_uicompents.Slider_sld.minValue = 1
    self.v_uicompents.Slider_sld.maxValue = max_count
  end
  self.v_uicompents.MaxNum_txt.text = max_count
  if value then
    self.v_select_count = value
    self.v_uicompents.Slider_sld:SetValueWithoutNotify(self.v_select_count)
  else
    self.v_uicompents.Slider_sld:SetValueWithoutNotify(self.v_select_count)
  end
  self.v_uicompents.UseNum_txt.text = math.ceil(self.v_select_count)
  if not self.v_is_ramdom_item then
    self:refresh_award_count()
  end
end

function ui:refresh_award_list(item_id)
  self:give_back_auto_cache(USE_RAMDOM_ITEM_TEMPLATE)
  local item_cfg = Item_Helper.get_item_cfg(item_id)
  self.v_max_use_count = item_cfg.Arg[2]
  if item_cfg.Arg[1] and item_cfg.Arg[1] > 0 then
    local award_list
    if self.v_is_ramdom_item then
      award_list = self:get_ramdom_award_item_list(item_cfg.Arg[1])
    else
      award_list = self:get_award_item_list(item_cfg.Arg[1])
    end
    local need_select_count
    for index, award_data in ipairs(award_list) do
      local obj = self:get_auto_cache(USE_RAMDOM_ITEM_TEMPLATE)
      self:set_button_listener(Util.get_button("ItemObjCom1_", obj), function()
        UIMgr:get_ui("item_tips_small"):ui_show(award_data.ItemId, obj.transform)
      end)
      self.v_item_list[index] = USE_ITEM_TIPS_ITEM:ui_wrap(self, obj, true)
      self.v_item_list[index]:set_data(award_data, false)
      if award_data.ItemId == self.v_need_select_item_id and self.v_need_count and self.v_need_count > 0 then
        need_select_count = math.ceil(self.v_need_count / award_data.Limit)
        local hava_count = BagMgr:get_item_num(self.v_select_item_id)
        if need_select_count > hava_count then
          need_select_count = hava_count
        end
      end
    end
    if need_select_count then
      self:refresh_count(need_select_count)
    end
  end
end

function ui:get_award_item_list(arg)
  local a_item_cfg, b_item_cfg
  local award_list = {}
  ShareRes.get_item_obj_use_award_list(arg, award_list, func)
  table.sort(award_list, function(a, b)
    a_item_cfg, b_item_cfg = Item_Helper.get_item_cfg(a.ItemId), Item_Helper.get_item_cfg(b.ItemId)
    if a_item_cfg.Quality ~= b_item_cfg.Quality then
      return a_item_cfg.Quality > b_item_cfg.Quality
    elseif a.ItemId ~= b.ItemId then
      return a.ItemId < b.ItemId
    else
      return false
    end
  end)
  return award_list
end

function ui:get_ramdom_award_item_list(arg)
  local a_item_cfg, b_item_cfg
  local result = ShareRes.get_all_possible_award(arg)
  local award_list = {}
  for key, value in pairs(result) do
    local temp = {
      ItemId = key,
      Num = value,
      Name = Item_Helper.get_item_cfg(key).Name
    }
    table.insert(award_list, temp)
  end
  table.sort(award_list, function(a, b)
    a_item_cfg, b_item_cfg = Item_Helper.get_item_cfg(a.ItemId), Item_Helper.get_item_cfg(b.ItemId)
    if a_item_cfg.Quality ~= b_item_cfg.Quality then
      return a_item_cfg.Quality > b_item_cfg.Quality
    elseif a.ItemId ~= b.ItemId then
      return a.ItemId < b.ItemId
    else
      return false
    end
  end)
  return award_list
end

function ui:on_operation_item(is_select)
  local cur_count = self.v_select_count or 0
  if is_select then
    local item_cfg = Item_Helper.get_item_cfg(self.v_select_item_id)
    if cur_count + 1 > item_cfg.Arg[2] or cur_count + 1 > BagMgr:get_item_num(self.v_select_item_id) then
      Util.show_message_tip(2223)
      return
    end
    self.v_select_count = cur_count + 1
  else
    if cur_count - 1 <= 0 then
      return
    end
    self.v_select_count = cur_count - 1
  end
  self:refresh_count()
end

function ui:use_item()
  if self.v_select_count <= 0 then
    Util.show_message_tip(2224)
    return
  end
  
  local function callback()
    UIMgr:try_hide_ui("itemTip")
    self:ui_hide()
  end
  
  local consume_list = {
    bag_type = BagCfg.ITEM_TYPE.COMSUME,
    item_list = {}
  }
  local temp = {
    uuid = self.v_select_uu_id,
    count = self.v_select_count
  }
  table.insert(consume_list.item_list, temp)
  BagMgr:request_use_item(consume_list, callback)
end

function ui:refresh_award_count()
  for key, item in pairs(self.v_item_list) do
    item:set_multi(self.v_select_count)
  end
end

return ui
