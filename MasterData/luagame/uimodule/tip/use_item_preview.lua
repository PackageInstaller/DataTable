local USE_ITEM_TIPS_ITEM = require("uimodule.tip.use_item_tips_item")
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local USE_ITEM_PREVIEW_KEY = "USE_ITEM_PREVIEW_KEY"
local Item_Helper = require("utils.item_helper")

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
  self:register_exist_auto_template(USE_ITEM_PREVIEW_KEY, self.v_uiobjects.ItemObjComBox, self.v_uiobjects.AwardContentLong)
end

function ui:ui_on_show(data)
  self:refresh_award_list(data.item_id)
end

function ui:ui_on_hide()
end

function ui:refresh_tips(item_cfg)
  local type_cfg = ShareRes.create("item.item_subtype")
  if item_cfg.Subtype == type_cfg.treasure_chest_unlocked.SubtypeId then
    self.v_uicompents.Tips_txt.text = "可从列表中，随机获得其中一项"
  elseif item_cfg.Subtype == type_cfg.treasure_chest_select.SubtypeId then
    self.v_uicompents.Tips_txt.text = "可从列表中，自选其中一项获得"
  else
    self.v_uicompents.Tips_txt.text = "可获得列表中的全部道具"
  end
end

function ui:refresh_award_list(item_id)
  self:give_back_auto_cache(USE_ITEM_PREVIEW_KEY)
  local item_cfg = Item_Helper.get_item_cfg(item_id)
  self:refresh_tips(item_cfg)
  self.v_max_use_count = item_cfg.Arg[2]
  local cfg = ShareRes.get_item_cfg(item_id)
  local treasure_chest_unlocked_cfg = ShareRes.create("item.item_subtype", "treasure_chest_unlocked")
  local is_random = cfg.Subtype == treasure_chest_unlocked_cfg.SubtypeId
  if item_cfg.Arg[1] and item_cfg.Arg[1] > 0 then
    local award_list
    if is_random then
      award_list = self:get_ramdom_award_item_list(item_cfg.Arg[1])
    else
      award_list = self:get_award_item_list(item_cfg.Arg[1])
    end
    for index, award_data in ipairs(award_list) do
      local obj = self:get_auto_cache(USE_ITEM_PREVIEW_KEY)
      local item_id = award_data.ItemId
      self:set_button_listener(Util.get_button("ItemObjCom1_", obj), function()
        UIMgr:get_ui("item_tips_small"):ui_show(item_id, obj.transform)
      end)
      local ui_item = USE_ITEM_TIPS_ITEM:ui_wrap(self, obj)
      obj:SetActive(true)
      ui_item:set_data(award_data, false)
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
    if 0 == cur_count then
      return
    end
    self.v_select_count = cur_count - 1
  end
  self:refresh_count()
end

return ui
