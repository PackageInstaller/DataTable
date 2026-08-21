local Base = require("ui.uibase")
local Vec2 = require("base.vec2")
local AssetBarView = require("ui.asset_bar.asset_bar")
local LoopListClass = require("ui.widget.infinite_loop_list")
local GoodsItemClass = require("uimodule.shop.exchange_shop.exchange_shop_item")
local Shop_Helper = require("uimodule.shop.shop_helper")
local ShopCfg = require("uimodule.shop.shop_config")
local INTERVAL_TIME = 0.05
local ui = Util.create_child_mt(Base)
local FILTER_TYPE = {PUZZLE_SHOP = 1}
local CT_Timer = Global.ct_timer
local TEMPLATE_KEY = {
  TOGGLE_ITEM = "TOGGLE_ITEM",
  ASSET_ITEM = "ASSET_ITEM"
}
local IMAGE_PATH = ""
local SHOP_TYPE = Shop_Helper.SHOP_TYPE
local SHOP_RESET_TYPE = ShopCfg.SHOP_RESET_TYPE
local ONE_DAY_SECS = 86400
local COLOR_1 = tonumber("BCB4A5", 16)
local COLOR_2 = tonumber("FFDA9D", 16)
local CUR_PAGE = 2

function ui:ui_finish_load()
  local data = ShareRes.create("shop.exchange_shop")
  self.v_tog_list = {}
  self.v_shop_cfg = {}
  for k, v in pairs(data) do
    if 1 == v.ShowInShop then
      table.insert(self.v_shop_cfg, v)
    end
  end
  table.sort(self.v_shop_cfg, function(a, b)
    return a.SortId > b.SortId
  end)
  for i, v in ipairs(self.v_shop_cfg) do
    local tog = self:get_toggle(nil, self.v_uiobjects["ShopTem_" .. i])
    self.v_tog_list[v.Id] = tog
    self:_set_toggle_data(tog, v)
  end
  self.v_only_need_tog = self:get_toggle(nil, self.v_uiobjects.OnlyInNeed)
  self:set_toggle("OnlyInNeed", function(isOn)
    self:_onclick_need_tog(isOn)
  end, false)
  self.v_only_unlock_tog = self:get_toggle(nil, self.v_uiobjects.OnlyUnlock)
  self:set_toggle("OnlyUnlock", function(isOn)
    self:_onclick_unlock_tog(isOn)
  end, false)
  self:set_button("BtnExpend", function()
    self:_onclick_expend_btn()
  end)
  self:set_button("BtnScreen", function()
    self:_onclick_screen()
  end)
  self:set_button("BtnDirect", function()
    self:_onclick_direct()
  end)
  self.v_cutdown_time_lab = self:get_text(nil, self.v_uiobjects.RefreshTime)
  self.v_goods_view = LoopListClass:new(self, self.v_uiobjects.ItemList, GoodsItemClass, function(offset, total_distance)
    self:scroll_change_event(offset, total_distance)
  end)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self.v_cur_shop_idx = nil
  self.v_default_shop_id = nil
  self.v_cur_shop_data = nil
  self.v_cur_shop_type = nil
  self.v_color_1 = Util.get_unity_color_by_hex(COLOR_1)
  self.v_color_2 = Util.get_unity_color_by_hex(COLOR_2)
  self.v_page_canvas = self:get_canvas_group(nil, self.v_uiobjects.ShopList)
  self.v_list_rect_offset = self.v_uicompents.ItemList_rect.offsetMax
  self.v_list_rect_offset_with_filter = self.v_list_rect_offset - Vec2.New(0, 34)
end

function ui:ui_on_show(shelves_type, goods_id, ...)
  self:_refresh_toggle_list()
  if shelves_type then
    self.v_default_shop_id = shelves_type
  end
  if goods_id then
    self.v_cur_goods_id = goods_id
  end
  self:_onclick_tog(self.v_default_shop_id, true)
  self.v_tog_list[self.v_default_shop_id].isOn = true
  self:_regist_client_event()
  self.v_page_canvas.alpha = 1
end

function ui:ui_on_hide()
  self.v_page_canvas.alpha = 0
  self.v_only_need = false
  self.v_only_can_buy = false
  self.v_cur_shop_idx = nil
  self.v_default_shop_id = nil
  self.v_cur_shop_data = nil
  self.v_cur_shop_type = nil
  self.v_goods_view:ui_on_hide()
  self.v_only_need_tog.isOn = false
  self.v_only_unlock_tog.isOn = false
  self.v_asset_bar:on_hide()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
  self.v_goods_view:ui_on_destroy()
end

function ui:reopen(shelves_type, goods_id, ...)
  if goods_id then
    self.v_cur_goods_id = goods_id
  end
  if shelves_type and self.v_default_shop_id == shelves_type then
    return
  end
  self.v_cur_shop_idx = nil
  self:_onclick_tog(self.v_default_shop_id, true)
  self.v_tog_list[self.v_default_shop_id].isOn = true
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_EXCHANGE_GOODS_UPDATE, self.response_shop_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_SERVER_STOCK_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_COIN_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_DIAMOND_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_PLAYER_SP_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_DP_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_PUZZLE_FILTER_UPDATE, self._refresh_goods_list, self)
end

function ui:response_shop_update_event(msg)
  if self.v_cur_shop_data and self.v_cur_shop_data.FilterType == FILTER_TYPE.PUZZLE_SHOP and self.v_goods_view then
    self.v_goods_view:reload_data()
    return
  end
  local last = self.v_cur_shop_idx
  self.v_cur_shop_idx = 0
  self:_refresh_toggle_list()
  self.v_tog_list[last].isOn = true
  self:_onclick_tog(last, true, true)
end

function ui:response_bag_update_event(msg)
  if self.v_goods_view then
    self.v_goods_view:reload_data()
  end
end

function ui:_refresh_toggle_list()
  for k, v in ipairs(self.v_shop_cfg) do
    if self:_get_shop_is_unlock(v) then
      self.v_tog_list[v.Id].gameObject:SetActiveEx(true)
      if not self.v_default_shop_id then
        self.v_default_shop_id = v.Id
      end
    else
      self.v_tog_list[v.Id].gameObject:SetActiveEx(false)
    end
  end
end

function ui:_set_toggle_data(tog, data)
  local obj = tog.gameObject
  self:get_text("TagName", obj).text = data.Name
  self:get_text("Select/selectTxt", obj).text = data.Name
  local new_mark = self:get_text("New", obj)
  new_mark.gameObject:SetActiveEx(ShopMgr:get_shop_new_mark(data.Id))
  local tog = self:get_toggle(nil, obj)
  Global.listener_mgr:add_listener(tog, tog.onValueChanged, function(isOn)
    self:_onclick_tog(data.Id, isOn)
  end)
  return tog
end

function ui:_get_shop_is_unlock(data)
  if 0 == data.ShowInShop then
    return false
  end
  if data.Page ~= CUR_PAGE then
    return false
  end
  local time = Date.server_time()
  local start_time = data.StartTime and Date.get_time_stamp_by_scheme_id(data.StartTime)
  if start_time and time < start_time then
    return false
  end
  local end_time = data.EndTime and Date.get_time_stamp_by_scheme_id(data.EndTime)
  if end_time and time > end_time then
    return false
  end
  if data.Condition and 0 ~= data.Condition and not ShopMgr:get_shop_cond_state(data.Id) then
    return false
  end
  return true
end

function ui:_onclick_tog(index, isOn, ignore_tog)
  if self.v_cur_shop_idx == index then
    return
  end
  if isOn then
    self.v_cur_shop_idx = index
    if not ignore_tog then
      self.v_only_need_tog.isOn = false
      self.v_only_unlock_tog.isOn = false
    end
    local data = ShareRes.create("shop.exchange_shop")
    self.v_cur_shop_data = data[self.v_cur_shop_idx]
    self.v_cur_shop_type = self.v_cur_shop_data.Type
    self:_refresh_filter_obj()
    self:_refresh_Asset()
    self:_refresh_goods_list()
    self:_refresh_top_tog()
  end
end

function ui:_refresh_filter_obj()
  local fliter_type = self.v_cur_shop_data.FilterType
  self.v_uiobjects.FilterObj:SetActiveEx(nil ~= fliter_type)
  local offset = nil ~= fliter_type and self.v_list_rect_offset_with_filter or self.v_list_rect_offset
  self.v_uicompents.ItemList_rect.offsetMax = offset
  if fliter_type == FILTER_TYPE.PUZZLE_SHOP then
    PuzzleMgr:reset_filter_record_shop()
    self.v_uiobjects.Direct_up:SetActive(false)
    self.v_uiobjects.Direct_down:SetActive(true)
  end
end

function ui:check_filter_pass(shop_item_data)
  local fliter_type = self.v_cur_shop_data.FilterType
  if fliter_type == FILTER_TYPE.PUZZLE_SHOP then
    return PuzzleMgr:check_filter_pass_shop(shop_item_data.Item)
  end
  return true
end

function ui:_refresh_Asset()
  local key, value = next(self.v_cur_shop_data.ItemId)
  if 0 ~= value then
    local list = Shop_Helper.get_asset_list(self.v_cur_shop_data.ItemId)
    self.v_asset_bar:reset_config(list)
  else
    self.v_asset_bar:reset_config()
  end
  self.v_asset_bar:on_create()
end

function ui:_refresh_top_tog()
  self.v_uiobjects.OnlyInNeed.gameObject:SetActiveEx(self.v_cur_shop_type == SHOP_TYPE.BREAK_SHOP)
  self.v_uiobjects.OnlyUnlock.gameObject:SetActiveEx(self.v_cur_shop_type == SHOP_TYPE.BREAK_SHOP)
  self.v_uiobjects.BtnExpend.gameObject:SetActiveEx(self.v_cur_shop_data.WindId > 0)
end

function ui:_get_can_buy_goods_list()
  local data = ShareRes.create("shop.exchange_goods_type")
  local list = data[self.v_cur_shop_idx]
  if nil == list then
    return
  end
  local goods_list = {}
  for k, v in pairs(list) do
    if self:_get_goods_can_sale(v) then
      local show = true
      if self.v_only_need == true and self:_get_is_needed_goods(v) == false then
        show = false
      end
      if true == self.v_only_can_buy and false == self:_get_is_can_buy_goods(v) then
        show = false
      end
      if show then
        table.insert(goods_list, v)
      end
    end
  end
  return goods_list
end

function ui:_refresh_goods_list()
  local data = ShareRes.create("shop.exchange_goods_type")
  local list = data[self.v_cur_shop_idx]
  if nil == list then
    return
  end
  self.v_goods_list = {}
  for k, v in pairs(list) do
    if self:_get_goods_can_sale(v) then
      local show = true
      if self.v_only_need == true and self:_get_is_needed_goods(v) == false then
        show = false
      end
      if true == self.v_only_can_buy and false == self:_get_is_can_buy_goods(v) then
        show = false
      end
      if not self:check_filter_pass(v) then
        show = false
      end
      if show then
        table.insert(self.v_goods_list, v)
      end
    end
  end
  self.v_uiobjects.Unmatch.gameObject:SetActiveEx(self.v_cur_shop_type == SHOP_TYPE.BREAK_SHOP and nil == next(self.v_goods_list))
  if nil ~= next(self.v_goods_list) then
    table.sort(self.v_goods_list, function(a, b)
      return self:_sort_goods(a, b)
    end)
  end
  self.v_need_ani = true
  self.v_goods_view:refresh_data(self.v_goods_list)
  self.v_need_ani = false
  self.v_uiobjects.NoShopItem:SetActiveEx(0 == #self.v_goods_list)
  self.v_goods_view:stop_scroll()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  if self.v_visible then
    self.v_sequence = Util.create_sequence()
    local all_itmes = self.v_goods_view:get_all_uis()
    for _, ui_item in pairs(all_itmes) do
      if ui_item:is_visible_item() then
        ui_item:eff_init()
        self.v_sequence:AppendCallback(function()
          ui_item:play_in_eff()
        end)
        self.v_sequence:AppendInterval(INTERVAL_TIME)
      end
    end
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.shop_item_refresh_UI_SOUND)
  end
end

function ui:_get_goods_can_sale(goods_cfg)
  local time = Date.server_time()
  local start_time = goods_cfg.StartTime and Date.get_time_stamp_by_scheme_id(goods_cfg.StartTime)
  if start_time and time < start_time then
    return false
  end
  local end_time = goods_cfg.EndTime and Date.get_time_stamp_by_scheme_id(goods_cfg.EndTime)
  if end_time and time > end_time then
    return false
  end
  if goods_cfg.BuddyId and 0 ~= goods_cfg.BuddyId and not CharacterMgr:check_buddy_release(goods_cfg.BuddyId) then
    return false
  end
  return true
end

function ui:_sort_goods(goods_a, goods_b)
  if self.v_cur_shop_type == SHOP_TYPE.COOMMON_SHOP then
    local sold_out_a = self:_get_is_sold_out(goods_a)
    local sold_out_b = self:_get_is_sold_out(goods_b)
    if sold_out_a ~= sold_out_b then
      return sold_out_b
    end
    local unlock_a = self:_get_is_unlock_goods(goods_a)
    local unlock_b = self:_get_is_unlock_goods(goods_b)
    if unlock_a ~= unlock_b then
      return unlock_a
    end
    if goods_a.SortId ~= goods_b.SortId then
      if self.v_cur_shop_data.FilterType == FILTER_TYPE.PUZZLE_SHOP and PuzzleMgr.direct_up_shop then
        return goods_a.SortId < goods_b.SortId
      end
      return goods_a.SortId > goods_b.SortId
    end
    return goods_a.Id < goods_b.Id
  else
    local sold_out_a = self:_get_is_sold_out(goods_a) and 0 or 1
    local sold_out_b = self:_get_is_sold_out(goods_b) and 0 or 1
    if sold_out_a == sold_out_b then
      local unlock_a = self:_get_is_unlock_goods(goods_a) and 1 or 0
      local unlock_b = self:_get_is_unlock_goods(goods_b) and 1 or 0
      if unlock_a == unlock_b then
        local item_a = ShareRes.create("item.item", goods_a.Item)
        local item_b = ShareRes.create("item.item", goods_b.Item)
        local quality_a = item_a and item_a.Quality or 0
        local quality_b = item_b and item_b.Quality or 0
        if quality_a == quality_b then
          if goods_a.SortId == goods_b.SortId then
            return goods_a.Id < goods_b.Id
          else
            return goods_a.SortId > goods_b.SortId
          end
        else
          return quality_a > quality_b
        end
      else
        return unlock_a > unlock_b
      end
    else
      return sold_out_a > sold_out_b
    end
  end
end

function ui:_get_is_needed_goods(goods_cfg)
  if self.v_cur_shop_type == SHOP_TYPE.COOMMON_SHOP then
    return true
  end
  local enough = Shop_Helper.check_break_mat_enough(goods_cfg.Item, goods_cfg.BuddyId)
  return false == enough
end

function ui:_get_is_can_buy_goods(goods_cfg)
  return self:_get_is_unlock_goods(goods_cfg) == true and self:_get_is_sold_out(goods_cfg) == false and false == self:_get_is_less_stock(goods_cfg)
end

function ui:_get_is_unlock_goods(goods_cfg)
  if self.v_cur_shop_type == SHOP_TYPE.COOMMON_SHOP then
    return true
  end
  local buddy_info = CharacterMgr:get_buddy_by_id(goods_cfg.BuddyId)
  return nil ~= buddy_info
end

function ui:_get_is_sold_out(goods_cfg)
  if 0 == goods_cfg.Quota then
    return false
  end
  local has_buy = ShopMgr:get_buy_amount(goods_cfg.Id)
  return has_buy >= goods_cfg.Quota
end

function ui:_get_is_less_stock(goods_cfg)
  if 0 == goods_cfg.StockItem then
    return false
  end
  return 0 == BagMgr:get_item_num(goods_cfg.StockItem)
end

function ui:_onclick_need_tog(isOn)
  self.v_only_need = isOn
  self:_refresh_goods_list()
end

function ui:_onclick_unlock_tog(isOn)
  self.v_only_can_buy = isOn
  self:_refresh_goods_list()
end

function ui:_onclick_expend_btn()
  UIMgr:get_ui("expand_stock_tips"):ui_show(self.v_cur_shop_idx)
end

function ui:_onclick_screen()
  UIMgr:get_ui("puzzle_filter_tips_shop"):ui_show(self:_get_can_buy_goods_list())
end

function ui:_onclick_direct()
  local direct_up = PuzzleMgr.direct_up_shop == true
  PuzzleMgr.direct_up_shop = not direct_up
  self.v_uiobjects.Direct_up:SetActive(PuzzleMgr.direct_up_shop)
  self.v_uiobjects.Direct_down:SetActive(not PuzzleMgr.direct_up_shop)
  self:_refresh_goods_list()
end

function ui:_get_reset_time(shop_data)
  if 0 == shop_data.ResetType then
    return 0
  end
  if shop_data.ResetType == SHOP_RESET_TYPE.DAILY then
    return self:_get_daily_reset_time()
  elseif shop_data.ResetType == SHOP_RESET_TYPE.WEEKLY then
    return self:_get_weekly_reset_time(shop_data.ResetValue)
  elseif shop_data.ResetType == SHOP_RESET_TYPE.MONTHLY then
    return self:_get_monthly_reset_time()
  else
    return 0
  end
end

function ui:_get_daily_reset_time()
  local date = os.date("!*t", Date.server_time())
  local next_reset_date
  local daily_reset_hour = Global.daily_reset_hour
  if daily_reset_hour > date.hour then
    return Date.to_timestamp({
      year = date.year,
      month = date.month,
      day = date.day,
      hour = daily_reset_hour,
      min = 0,
      sec = 0
    })
  else
    next_reset_date = os.date("!*t", Date.server_time() + ONE_DAY_SECS)
    return Date.to_timestamp({
      year = next_reset_date.year,
      month = next_reset_date.month,
      day = next_reset_date.day,
      hour = daily_reset_hour,
      min = 0,
      sec = 0
    })
  end
end

function ui:_get_weekly_reset_time(day)
  if 0 == day then
    day = 2
  end
  local next_day_time = self:_get_daily_reset_time()
  local date = os.date("!*t", next_day_time)
  if date.wday - 1 == day then
    return next_day_time
  end
  local days = day < date.wday and day + 7 - date.wday or day - date.wday
  return next_day_time + (days + 1) * ONE_DAY_SECS
end

function ui:_get_monthly_reset_time()
  local date = os.date("!*t", Date.server_time())
  local new_year = 12 == date.month and date.year + 1 or date.year
  local new_month = 12 == date.month and 1 or date.month + 1
  return Date.to_timestamp({
    year = new_year,
    month = new_month,
    day = 1,
    hour = 5,
    min = 0,
    sec = 2
  })
end

function ui:scroll_change_event(offset, total_distance)
end

function ui:get_need_ani()
  return self.v_need_ani
end

return ui
