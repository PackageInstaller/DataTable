local Base = require("ui.uibase")
local ShopCfg = require("uimodule.shop.shop_config")
local AssetBarView = require("ui.asset_bar.asset_bar")
local Shop_Helper = require("uimodule.shop.shop_helper")
local ui_config = Global.uiconfig.ui
local SyncListClass = require("ui.widget.sync_scroll_list")
local RecommondShopItem = require("uimodule.shop.recommond_shop.recommond_shop_select_item")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local GIFT_SHOP_TIPS = "gift_shop_tips"
local MODEL = {
  v_asset_bar = {
    "AssetBar",
    BIND_TYPE.OBJECT
  },
  v_order_obj = {
    "OrderObj",
    BIND_TYPE.OBJECT
  },
  v_rec_obj = {
    "RecommondObj",
    BIND_TYPE.OBJECT
  },
  v_rec_pos = {
    "RecommondPos",
    BIND_TYPE.OBJECT
  }
}
local SHOP_TYPE = ShopCfg.REMD_SHOP_SHELF
local TOGGLE_LIST = {
  [SHOP_TYPE.VERSION] = {
    tog_name = "Principal_tog"
  },
  [SHOP_TYPE.CARD] = {
    tog_name = "MonthCard_tog",
    panel = "card_shop",
    check_valid_func = function()
      local card_cfg = ShareRes.create("recharge.monthly_card", ShopCfg.DF_CARD_TYPE)
      return RechargeMgr:is_product_valid(card_cfg)
    end
  },
  [SHOP_TYPE.ORDER] = {
    tog_name = "Order_tog",
    panel = "order_view",
    check_valid_func = function()
      if 0 == PassPortMgr:get_passport_data().id then
        return false
      end
      local passport_cfg = ShareRes.create("battle_passport.battle_passport_key")
      if not passport_cfg or 0 == UtilTable.hash_lenth(passport_cfg) then
        return false
      end
      local is_valid = true
      for _, cfg in pairs(passport_cfg) do
        is_valid = is_valid and RechargeMgr:is_product_valid(cfg)
      end
      return is_valid
    end
  },
  [SHOP_TYPE.FIRSTCHARGE] = {
    tog_name = "FirstChargeTog_tog",
    panel = "first_recharge_view",
    red_id = RedEnum.FIRST_RECHARGE
  }
}
local TIPS_TYPE = ShopCfg.GIFT_TIPS_TYPE
local TIME_LIMIT_TYPE = {LIMIT_TIME = 1, NO_LIMIT_TIME = 2}
local enough_color = Util.CommonColor_White
local not_enough_color = Util.CommonColor_RedWarm
local REC_SELECT_KEY = "REC_SELECT_KEY"
local REC_POS_KEY = "REC_POS_KEY"
local _tinsert = table.insert
local ORDER_SELECT_KEY = "ORDER_SELECT"
local UI_RECOMMOND_TOG_TEM_KEY = "UI_RECOMMOND_TOG_TEM_KEY"
local LIVENESS_GIFT_TOG_TEM_KEY = "LIVENESS_GIFT_TOG_TEM_KEY"
local UI_RECOMMOND_TOG_POINT_TEM_KEY = "UI_RECOMMOND_TOG_POINT_TEM_KEY"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_tog_list = {}
  for i, v in pairs(TOGGLE_LIST) do
    local tog = self.v_uicompents[v.tog_name]
    self.v_tog_list[i] = tog
    self:set_toggle_listener(tog, function(isOn)
      if isOn then
        self:_on_click_tog(i, isOn)
      end
    end)
    if v.red_id then
      local red = self:get_child_gameobj("RedPoint", tog.gameObject)
      RedPointMgr:bind_redpoint(self, red, v.red_id)
    end
  end
  self.v_asset_bar = AssetBarView:new(self, self.v_asset_bar)
  self.v_page_canvas = self:get_canvas_group(nil, self.v_uiobjects.PageList)
  self:register_exist_auto_template(UI_RECOMMOND_TOG_TEM_KEY, self.v_uiobjects.RecommondTem, self.v_uiobjects.Tog_Content)
  self:register_exist_auto_template(UI_RECOMMOND_TOG_POINT_TEM_KEY, self.v_uiobjects.PointTem, self.v_uiobjects.PointTem.transform.parent.gameObject)
  self:register_exist_auto_template(REC_POS_KEY, self.v_rec_pos, self.v_uiobjects.RecContent)
  self:register_exist_auto_template(LIVENESS_GIFT_TOG_TEM_KEY, self.v_uiobjects.LivenessGiftTogTem, self.v_uiobjects.LivenessGiftTogLayout)
  self:set_button("BtnLast", function()
    self.v_cur_select_page_item = self.synv_list:get_cur_select_idx() - 1
    if self.v_cur_select_page_item <= 0 then
      self.v_cur_select_page_item = self.v_cur_select_page_max_item
    end
    self.synv_list:scroll_to_index_for_horizontal(self.v_cur_select_page_item)
  end)
  self:set_button("BtnNext", function()
    self.v_cur_select_page_item = self.synv_list:get_cur_select_idx() + 1
    if self.v_cur_select_page_item > self.v_cur_select_page_max_item then
      self.v_cur_select_page_item = 1
    end
    self.synv_list:scroll_to_index_for_horizontal(self.v_cur_select_page_item)
  end)
  local rect_ex = self.v_uiobjects.RecommondObj:GetComponent(typeof(CS.Game.ScrollRectEx))
  self.synv_list = SyncListClass:new(self, rect_ex, self.v_uiobjects.PageLayout, RecommondShopItem, REC_SELECT_KEY)
end

function ui:ui_on_show(shelves_type)
  self.v_cur_select_page_cfg_fillter = {}
  self.v_rec_page_point = {}
  self.v_rec_page_tog = {}
  self.v_cur_select_page_item = 1
  self.v_time_to_update = 1
  self.v_cur_time = 0
  self.v_liveness_gift_togs = nil
  self:give_back_auto_cache(UI_RECOMMOND_TOG_TEM_KEY)
  local rec_page_cfg = ShareRes.get_rec_shop_page_cfg()
  local default_cfg, default_tog
  for tog_idx, rec_page in pairs(rec_page_cfg) do
    local rec_page_obj = self:get_auto_cache(UI_RECOMMOND_TOG_TEM_KEY)
    local rec_page_text = Util.get_text("TagName", rec_page_obj)
    local rec_page_select_text = Util.get_text("Select/selectTxt", rec_page_obj)
    local rec_limit_icon = Util.get_child_gameobj("TimeLimitTips", rec_page_obj)
    rec_limit_icon:SetActive(nil ~= rec_page.IconShow)
    local rec_page_tog = Util.get_toggle(nil, rec_page_obj)
    rec_page_text.text = rec_page.RecommendName
    rec_page_select_text.text = rec_page.RecommendName
    self.v_rec_page_tog[rec_page.Id] = rec_page_obj.gameObject
    self:set_toggle_listener(rec_page_tog, function(isOn)
      if isOn then
        self.v_cur_idx = nil
        self:_on_click_tog(SHOP_TYPE.RECOMMOND, isOn, rec_page.Id)
      end
    end)
    rec_page_obj.transform:SetSiblingIndex(tog_idx - 1)
    default_cfg = default_cfg or rec_page.Id
    default_tog = default_tog or rec_page_tog
  end
  local default_select
  if shelves_type and self.v_tog_list[shelves_type] then
    default_select = shelves_type
  elseif 2 == UIMgr:get_cache_ui_custom_data(ORDER_SELECT_KEY) then
    default_select = SHOP_TYPE.ORDER
  end
  self:_refresh_liveness_gift_tog(true)
  self:check_first_charge_tog_show()
  if self:_check_toggle_valid(default_select) then
    self.v_tog_list[default_select].isOn = true
    self:_on_click_tog(default_select, true)
  else
    default_tog.isOn = true
    self:_on_click_tog(SHOP_TYPE.RECOMMOND, true, default_cfg)
  end
  if UIMgr:try_get_visible_ui("ui_monthtask_award_choice") then
    UIMgr:set_cache_ui_custom_data(ORDER_SELECT_KEY, 2)
  else
    UIMgr:set_cache_ui_custom_data(ORDER_SELECT_KEY, nil)
  end
  self.v_page_canvas.alpha = 1
  self:_refresh_asset()
  self:_regist_client_event()
  self:response_buy_result_msg()
end

function ui:_check_toggle_valid(selected_shop_type)
  local seleted_is_open = false
  for k, v in pairs(TOGGLE_LIST) do
    if v.check_valid_func then
      local tog = self.v_uicompents[v.tog_name]
      local is_open = v.check_valid_func()
      tog:SetActive(is_open)
      if k == selected_shop_type then
        seleted_is_open = is_open
      end
    end
  end
  return seleted_is_open
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_GIFT_INFO_UPDATE, self.response_buy_result_msg, self)
  self:bind_auto_mq(Const.MSG_NEW_SYS_OPEN, self.refresh_sys_state, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.response_ui_show, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.response_ui_hide, self)
  self:bind_auto_mq(Const.MSG_UPDATE_PASSPORT_DATA, self.response_passport_update, self)
  self:bind_auto_mq(Const.MSG_ON_LIVENESS_GIFT_UPDATE, self.check_liveness_gift_tog_active, self)
end

function ui:response_buy_result_msg()
  self:check_close_page()
  self:refresh_rec()
end

function ui:refresh_sys_state()
  self:check_first_charge_tog_show()
end

function ui:check_first_charge_tog_show()
  local is_first_recharge_open = RechargeMgr:is_first_recharge_open()
  self.v_uiobjects.FirstChargeTog:SetActive(is_first_recharge_open)
  return is_first_recharge_open
end

function ui:ui_on_hide()
  self.synv_list:clear()
  self.v_page_canvas.alpha = 0
  self.v_cur_idx = nil
  self.v_cur_point_length = nil
  self.v_asset_bar:on_hide()
end

function ui:ui_on_destroy()
  if self.v_asset_bar then
    self.v_asset_bar:on_destory()
  end
end

function ui:_refresh_asset()
  local list = Shop_Helper.get_asset_list({
    Config.GILTGOLD_ITEMID
  })
  self.v_asset_bar:reset_config(list)
  self.v_asset_bar:on_create()
end

function ui:_on_click_tog(index, isOn, page_id_param)
  if self.v_cur_idx == index or not isOn then
    return
  end
  self.v_cur_idx = index
  for k, v in pairs(TOGGLE_LIST) do
    if v.panel then
      self:set_panel_enable(v.panel, isOn and k == index)
    end
  end
  if isOn then
    self.v_rec_obj:SetActive(index == SHOP_TYPE.RECOMMOND)
    self.v_cur_select_page_cfg = nil
    self.v_cur_select_page_id = nil
    if index == SHOP_TYPE.RECOMMOND then
      self.v_cur_select_page_cfg = ShareRes.get_rec_shop_page_item_cfg(page_id_param)
      self.v_cur_select_page_id = page_id_param
      if self.v_select_rec_page ~= page_id_param then
        self:refresh_rec()
      end
      self.v_select_rec_page = page_id_param
    else
      self.v_select_rec_page = nil
    end
  end
  self:set_liveness_gift_ui_enable(isOn and index == SHOP_TYPE.LIVENESSGIFT, page_id_param)
  if not isOn and index == SHOP_TYPE.FIRSTCHARGE then
    self:check_first_charge_tog_show()
  end
end

function ui:get_gift_cfg(rec_index)
  if not rec_index then
    return
  end
  local target_gift_cfg = ShareRes.get_gift_shop_cfg(rec_index)
  return target_gift_cfg
end

function ui:refresh_rec()
  local reset_select = self:fillter_gift_cfg()
  if reset_select then
    self.v_cur_select_page_item = 1
  end
  local cfg = self.v_cur_select_page_cfg_fillter
  if nil == cfg then
    self.v_rec_obj:SetActive(false)
    return
  end
  self.v_cur_select_page_max_item = #cfg
  if 0 == self.v_cur_select_page_max_item then
    self.v_rec_obj:SetActive(false)
    cfg = nil
    return
  end
  self.v_rec_obj:SetActive(true)
  self.v_uiobjects.BtnLast:SetActive(self.v_cur_select_page_max_item > 1)
  self.v_uiobjects.BtnNext:SetActive(self.v_cur_select_page_max_item > 1)
  self.v_point_temp = {}
  self:give_back_auto_cache(REC_POS_KEY)
  for i = 1, #self.v_cur_select_page_cfg_fillter do
    local obj = self:get_auto_cache(REC_POS_KEY)
    self:close_all_chirld(obj)
    local pont_data = {parent_ui = self}
    _tinsert(self.v_point_temp, pont_data)
    local cur_select_cfg = self.v_cur_select_page_cfg_fillter[i]
    local cur_select_obj = Util.get_child_gameobj(cur_select_cfg.NodeName, obj)
    cur_select_obj:SetActive(true)
    local img1 = Util.get_image("Image1_", cur_select_obj)
    local img2 = Util.get_image("Image2_", cur_select_obj)
    local txt1 = Util.get_text("Text1_", cur_select_obj)
    local txt2 = Util.get_text("Text2_", cur_select_obj)
    self:set_jump_group(cur_select_obj, cur_select_cfg)
    self:set_rec_time(cur_select_obj, cur_select_cfg)
    if nil ~= cur_select_cfg.Image[1] then
      ResMgr:load_set_icon(img1, cur_select_cfg.Image[1], nil, true)
    end
    local txt_obj = Util.get_child_gameobj("TimeTips_", cur_select_obj)
    local txt_time = Util.get_text("TimeTips_/TimeNum_", cur_select_obj)
    txt_obj:SetActive(cur_select_cfg.TimeLimitType ~= TIME_LIMIT_TYPE.NO_LIMIT_TIME)
    if cur_select_cfg.TimeLimitType ~= TIME_LIMIT_TYPE.NO_LIMIT_TIME then
      local end_time = Date.get_time_stamp_by_scheme_id(cur_select_cfg.RecEndTime)
      txt_time.text = Date.get_time_formate_2(end_time - Date.server_time())
    end
    local giftBoxs = Util.get_child_gameobj("GiftBoxs", cur_select_obj)
    self:close_all_chirld(giftBoxs)
    local RecIndex_cfg = {}
    for _, rec_index in pairs(cur_select_cfg.RecIndex) do
      local gift_cfg = self:get_gift_cfg(rec_index)
      if gift_cfg then
        local is_product_valid = not RechargeMgr:is_recharge_product(gift_cfg) or RechargeMgr:is_product_valid(gift_cfg)
        if is_product_valid then
          _tinsert(RecIndex_cfg, rec_index)
        end
      end
    end
    local gift_mode_obj = Util.get_child_gameobj("BoxMode" .. #RecIndex_cfg, giftBoxs)
    gift_mode_obj:SetActive(true)
    if gift_mode_obj then
      for idx, val in pairs(RecIndex_cfg) do
        local gift_box = Util.get_child_gameobj("GiftBox" .. idx, gift_mode_obj)
        self:refresh_rec_gift_box(val, gift_box, idx)
      end
    end
    if cur_select_cfg.RecJumpID then
      self:close_all_chirld(giftBoxs)
    end
  end
  self.v_uiobjects.PageLayout:SetActive(#self.v_point_temp > 1)
  self.synv_list:update_list(self.v_point_temp)
  self.synv_list:on_select_change(self.synv_list.v_items[1])
  self.synv_list:scroll_to_index_for_horizontal(1, 0.01)
  self.synv_list:control_scroll(self.v_cur_select_page_max_item > 1)
  self:auto_next_page()
end

function ui:refresh_rec_gift_box(gift_id, gift_box, idx)
  if gift_box then
    gift_box:SetActive(true)
    local btn = self:get_button("BuyBtn", gift_box)
    local gift_icon = Util.get_image("Box", gift_box)
    local gift_name = Util.get_text("TextBg/GiftName", gift_box)
    local discount_num = Util.get_text("DiscountBg/DiscountNum/Discount", gift_box)
    local discount_num_obj = Util.get_child_gameobj("DiscountBg", gift_box)
    local price_text = Util.get_text("BuyBtn/GiftValue", gift_box)
    local dia_obj = Util.get_child_gameobj("BuyBtn/DiamondGroup", gift_box)
    local dia_text = Util.get_text("BuyBtn/DiamondGroup/Bg/Price_normal", gift_box)
    local eff_obj = Util.get_child_gameobj("BuyBtn/Fx_BtnBuy", gift_box)
    local limit_text = Util.get_text("LimitLayout/Limit", gift_box)
    local limit_num_text = Util.get_text("LimitLayout/LimitNum", gift_box)
    local limit_num_limitLayout = Util.get_child_gameobj("LimitLayout", gift_box)
    local sold_out_obj = Util.get_child_gameobj("BuyBtn/SelloutBg", gift_box)
    if btn then
      self:set_button_listener(btn, function()
        self:click_gift_btn(gift_id)
      end)
    end
    local gift_cfg = self:get_gift_cfg(gift_id)
    if gift_cfg then
      if gift_cfg.Icon then
        ResMgr:load_set_icon(gift_icon, gift_cfg.Icon)
      end
      gift_name.text = gift_cfg.Name
      discount_num.gameObject:SetActive(gift_cfg.Discount ~= nil)
      discount_num_obj:SetActive(gift_cfg.Discount ~= nil)
      discount_num.text = gift_cfg.Discount
      if gift_cfg.ShowPrice then
        local price = Shop_Helper.get_goods_price(gift_cfg)
        price_text.text = string.format("<size=20>%s</size> %s", Shop_Helper.get_money_symbol(gift_cfg), price)
        price_text.color = enough_color
        price_text.gameObject:SetActive(true)
        if nil ~= dia_obj then
          dia_obj:SetActive(false)
        end
      elseif gift_cfg.CostItem then
        price_text.gameObject:SetActive(false)
        if nil ~= dia_obj then
          dia_obj:SetActive(true)
          local is_enough = BagMgr:get_cost_enough(gift_cfg.CostItem, gift_cfg.CostItemNum)
          dia_text.text = gift_cfg.CostItemNum
          dia_text.color = is_enough and enough_color or not_enough_color
        end
      else
        price_text.text = Util.format_str("免费")
        price_text.color = enough_color
      end
      local is_limit = nil ~= gift_cfg.BuyLimit
      limit_text.gameObject:SetActive(is_limit)
      limit_num_limitLayout.gameObject:SetActive(is_limit)
      limit_num_text.gameObject:SetActive(true)
      if eff_obj then
        eff_obj.gameObject:SetActive(true)
      end
      if sold_out_obj then
        sold_out_obj.gameObject:SetActive(false)
      end
      if is_limit then
        limit_text.text = "限购:"
        limit_num_text.text = RechargeMgr:get_gift_buy_count(gift_cfg.Id) .. "/" .. gift_cfg.BuyLimit
      end
      if Shop_Helper.check_sold_out(gift_cfg) then
        limit_text.text = "已售罄"
        limit_num_text.gameObject:SetActive(false)
        if eff_obj then
          eff_obj.gameObject:SetActive(false)
        end
        if sold_out_obj then
          sold_out_obj.gameObject:SetActive(true)
        end
      end
    else
      gift_box:SetActive(false)
    end
  end
end

function ui:fillter_gift_cfg()
  local ret = true
  local ori_select_id
  if not self.v_cur_select_page_cfg_fillter[self.v_cur_select_page_item] then
    ret = true
  else
    ori_select_id = self.v_cur_select_page_cfg_fillter[self.v_cur_select_page_item].Id
  end
  UtilTable.clear_map(self.v_cur_select_page_cfg_fillter)
  if not self.v_cur_select_page_cfg then
    return ret
  end
  for i, data in ipairs(self.v_cur_select_page_cfg) do
    local fillter = false
    local check_time = false
    if data.TimeLimitType == TIME_LIMIT_TYPE.NO_LIMIT_TIME then
      check_time = true
    else
      local cur_time = Date.server_time()
      local start_time = Date.get_time_stamp_by_scheme_id(data.RecStartTime)
      local end_time = Date.get_time_stamp_by_scheme_id(data.RecEndTime)
      check_time = cur_time > start_time and cur_time < end_time
    end
    for _, rec in pairs(data.RecIndex) do
      local cfg2 = self:get_gift_cfg(rec)
      if cfg2 then
        local is_product_valid = not RechargeMgr:is_recharge_product(cfg2) or RechargeMgr:is_product_valid(cfg2)
        local check_base = Shop_Helper.check_gift_open(cfg2) and is_product_valid
        if data.RecPageActivity ~= nil then
          if check_base and not Shop_Helper.check_sold_out(cfg2) then
            fillter = check_time
          end
        elseif check_base then
          fillter = check_time
        end
      end
    end
    if fillter then
      if ori_select_id == data.Id then
        ret = false
      end
      _tinsert(self.v_cur_select_page_cfg_fillter, data)
    end
  end
  return ret
end

function ui:check_close_page()
  for page_id, obj in pairs(self.v_rec_page_tog) do
    local cfg = ShareRes.get_rec_shop_page_item_cfg(page_id) or {}
    local is_open = false
    for i, data in ipairs(cfg) do
      local check_time = false
      if data.TimeLimitType == TIME_LIMIT_TYPE.NO_LIMIT_TIME then
        check_time = true
      else
        local cur_time = Date.server_time()
        local start_time = Date.get_time_stamp_by_scheme_id(data.RecStartTime)
        local end_time = Date.get_time_stamp_by_scheme_id(data.RecEndTime)
        check_time = cur_time > start_time and cur_time < end_time
      end
      for _, rec in pairs(data.RecIndex) do
        local cfg2 = self:get_gift_cfg(rec)
        if cfg2 then
          local is_product_valid = not RechargeMgr:is_recharge_product(cfg2) or RechargeMgr:is_product_valid(cfg2)
          local check_base = Shop_Helper.check_gift_open(cfg2) and is_product_valid
          if data.RecPageActivity ~= nil then
            if check_base and not Shop_Helper.check_sold_out(cfg2) then
              is_open = check_time
            end
          elseif check_base then
            is_open = check_time
          end
        end
      end
      if is_open then
        break
      end
    end
    obj:SetActive(is_open)
    if not is_open and page_id == self.v_cur_select_page_id then
      self:set_to_default_tog()
    end
  end
end

function ui:set_to_default_tog()
  local first_charge_show = self:check_first_charge_tog_show()
  local default_select = first_charge_show and SHOP_TYPE.FIRSTCHARGE or SHOP_TYPE.CARD
  if self.v_tog_list and self.v_tog_list[default_select] then
    self.v_tog_list[default_select].isOn = true
    self:_on_click_tog(default_select, true)
  end
end

function ui:auto_next_page()
  if self.v_cur_select_page_max_item <= 1 or not self.v_cur_select_page_cfg_fillter then
    return
  end
  local select_cfg = self.v_cur_select_page_cfg_fillter[self.v_cur_select_page_item]
  if not select_cfg then
    return
  end
  local change_time = select_cfg.ChangeTime or 5
  self:clear_auto_timer()
  self.v_ui_auto_timer = Timer:add_timer("ui_auto_timer", change_time, function()
    if self.synv_list:scroll_is_rolling() then
      return
    end
    if self.v_stop_auto_roll then
      return
    end
    self.v_cur_select_page_item = self.synv_list:get_cur_select_idx() + 1
    if self.v_cur_select_page_item > self.v_cur_select_page_max_item then
      self.v_cur_select_page_item = 1
    end
    self.synv_list:scroll_to_index_for_horizontal(self.v_cur_select_page_item)
  end)
end

function ui:clear_auto_timer()
  if self.v_ui_auto_timer then
    Timer:remove_timer(self.v_ui_auto_timer)
    self.v_ui_auto_timer = nil
  end
end

function ui:update_cur_select(idx)
  self.v_cur_select_page_item = self.synv_list:get_cur_select_idx()
  local cur_select_cfg = self.v_cur_select_page_cfg_fillter[self.v_cur_select_page_item]
  self.v_uiobjects.Button:SetActive(true)
  if cur_select_cfg then
    self.v_uiobjects.Button:SetActive(cur_select_cfg.RecJumpID ~= nil)
  end
end

function ui:click_gift_btn(gift_id)
  if self.v_cur_select_page_cfg_fillter and self.v_cur_select_page_cfg_fillter[self.v_cur_select_page_item] then
    local select_cfg = self.v_cur_select_page_cfg_fillter[self.v_cur_select_page_item]
    local check_time = false
    if select_cfg.TimeLimitType == TIME_LIMIT_TYPE.NO_LIMIT_TIME then
      check_time = true
    else
      local cur_time = Date.server_time()
      local start_time = Date.get_time_stamp_by_scheme_id(select_cfg.RecStartTime)
      local end_time = Date.get_time_stamp_by_scheme_id(select_cfg.RecEndTime)
      check_time = cur_time > start_time and cur_time < end_time
    end
    if check_time then
      local gift_cfg = self:get_gift_cfg(gift_id)
      if gift_cfg.Paging == ShopCfg.SKIN_GIFT_SHOP_SHELF or gift_cfg.Paging == ShopCfg.WEAPON_SKIN_GIFT_SHOP_SHELF then
        return
      end
      local is_product_valid = not RechargeMgr:is_recharge_product(gift_cfg) or RechargeMgr:is_product_valid(gift_cfg)
      if Shop_Helper.check_sold_out(gift_cfg) or not is_product_valid then
        return
      end
      if Shop_Helper.check_gift_open(gift_cfg) and not Shop_Helper.check_sold_out(gift_cfg) then
        UIMgr:get_ui("gift_shop_tips"):ui_show(TIPS_TYPE.DETAIL, gift_cfg)
      else
        Util.show_message_tip(2275)
      end
    else
      Util.show_message_tip(2276)
    end
  else
    Util.show_message_tip(2275)
  end
end

function ui:close_all_chirld(obj)
  if Util.is_nil(obj) then
    return
  end
  local chirld_len = obj.gameObject.transform.childCount
  for i = 0, chirld_len - 1 do
    local item_obj = obj.gameObject.transform:GetChild(i)
    item_obj:SetActive(false)
  end
end

function ui:response_ui_show(msg)
  if msg.mm_obj == GIFT_SHOP_TIPS then
    self.v_stop_auto_roll = true
  end
end

function ui:response_ui_hide(msg)
  if msg.mm_obj == GIFT_SHOP_TIPS and self.v_stop_auto_roll then
    self.v_stop_auto_roll = nil
    self:auto_next_page()
  end
end

function ui:response_passport_update()
  self:ui_on_show()
end

function ui:set_jump_group(cur_select_obj_param, cur_select_cfg_param)
  local jump_group = Util.get_child_gameobj("JumpBtnGroup", cur_select_obj_param)
  if nil == jump_group then
    return
  end
  if nil == cur_select_cfg_param.RecJumpGroupID then
    jump_group:SetActive(false)
    return
  else
    jump_group:SetActive(true)
    self:close_all_chirld(jump_group)
    local gift_cfg
    if nil ~= cur_select_cfg_param.RecIndex and nil ~= cur_select_cfg_param.RecIndex[1] then
      gift_cfg = self:get_gift_cfg(cur_select_cfg_param.RecIndex[1])
    end
    for idx, jump_id in ipairs(cur_select_cfg_param.RecJumpGroupID) do
      local btn = Util.get_button("JumpBtn" .. idx, jump_group)
      btn.gameObject:SetActive(true)
      if nil ~= btn then
        self:set_button_listener(btn, function()
          if nil ~= gift_cfg and (gift_cfg.Paging == ShopCfg.SKIN_GIFT_SHOP_SHELF or gift_cfg.Paging == ShopCfg.WEAPON_SKIN_GIFT_SHOP_SHELF) then
            SysOpenMgr:jump_to_sys(12110, true)
          end
          SysOpenMgr:jump_to_sys(jump_id, true)
        end)
      end
    end
  end
end

function ui:set_rec_time(cur_select_obj_param, cur_select_cfg_param)
  local time_group = Util.get_child_gameobj("TimeGroup", cur_select_obj_param)
  if nil == time_group then
    return
  end
  time_group:SetActive(true)
  local time1 = Util.get_text("Time1", time_group)
  local time2 = Util.get_text("Time2", time_group)
  if cur_select_cfg_param.RecStartTime then
    time1.text = Date.get_time_formate_3_1(Date.get_time_stamp_by_scheme_id(cur_select_cfg_param.RecStartTime))
    time2.text = Date.get_time_formate_3_1(Date.get_time_stamp_by_scheme_id(cur_select_cfg_param.RecEndTime))
  else
    time_group:SetActive(false)
  end
end

function ui:_refresh_liveness_gift_tog(is_init)
  if is_init then
    self:give_back_auto_cache(LIVENESS_GIFT_TOG_TEM_KEY)
  end
  if not self.v_liveness_gift_togs then
    self.v_liveness_gift_togs = {}
  end
  local id_list = LivenessGiftMgr:get_id_list()
  self.v_uiobjects.LivenessGiftTogLayout:SetActiveEx(nil ~= id_list)
  if not id_list then
    return
  end
  for _, data in ipairs(id_list) do
    local id = data.id
    if self.v_liveness_gift_togs[id] then
      return
    end
    local cfg = ShareRes.get_liveness_gift_cfg(id)
    local obj = self:get_auto_cache(LIVENESS_GIFT_TOG_TEM_KEY)
    local tog = Util.get_toggle(nil, obj)
    local red_obj = Util.get_child_gameobj("RedPoint", obj)
    red_obj:SetActiveEx(LivenessGiftMgr:get_gift_red(id))
    Util.get_child_gameobj("TimeLimitTips", obj):SetActive(true)
    Util.get_text("TagName", obj).text = cfg.TagName
    Util.get_text("Select/selectTxt", obj).text = cfg.TagName
    self.v_liveness_gift_togs[id] = {
      obj = obj,
      tog = tog,
      red_obj = red_obj
    }
    self:set_toggle_listener(tog, function(isOn)
      if isOn then
        self.v_cur_idx = nil
        self:_on_click_tog(SHOP_TYPE.LIVENESSGIFT, isOn, id)
      end
    end)
  end
end

function ui:check_liveness_gift_tog_active()
  if not self.v_liveness_gift_togs then
    return
  end
  for id, tog in pairs(self.v_liveness_gift_togs) do
    local is_active = LivenessGiftMgr:get_liveness_gift_data(id)
    if not is_active then
      tog.obj:SetActiveEx(false)
      if tog.tog.isOn then
        self:set_to_default_tog()
      end
      self.v_liveness_gift_togs[id] = nil
    else
      tog.red_obj:SetActiveEx(LivenessGiftMgr:get_gift_red(id))
    end
  end
end

local ui_name_prefix = "liveness_gift_view"
local prefab_path = "prefab/Shop/%s.prefab"
local ui_class_name = "shop.recommond_shop.liveness_gift_view"

function ui:check_and_add_uicfg(ui_name, prefab_name)
  if nil == ui_config[ui_name] then
    local path = string.format(prefab_path, prefab_name)
    ui_config[ui_name] = {
      resource = path,
      class = ui_class_name,
      sort_order = Config.UI_SORT_ORDER.System,
      group = Config.UI_GROUPS.GROUP_NORMAL,
      normal_update = true,
      sync_load = true,
      parent_ui = "recommond_shop",
      view_level = Config.UI_VIEW_LEVEL.MAIN_VIEW
    }
  end
end

function ui:set_liveness_gift_ui_enable(is_on, id)
  for _, sub_panel in pairs(self.v_sub_panels) do
    sub_panel:set_enable(false)
  end
  if not is_on then
    return
  end
  if not id then
    return
  end
  local prefab_name = ShareRes.get_liveness_gift_cfg(id).PrefabName
  local ui_name = ui_name_prefix .. id
  self:check_and_add_uicfg(ui_name, prefab_name)
  if self.v_sub_panels[ui_name] then
    self.v_sub_panels[ui_name]:set_enable(true, id)
  else
    UIMgr:get_ui(ui_name):ui_show(id)
  end
end

return ui
