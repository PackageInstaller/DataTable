local Base = require("ui.uibase")
local Shop_Helper = require("uimodule.shop.shop_helper")
local BagCfg = require("uimodule.uibag.uibag_configs")
local ui = Util.create_child_mt(Base)
local ITEM_TYPE = BagCfg.ITEM_TYPE
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_item_quality = {
    "Pz",
    BIND_TYPE.IMAGE
  },
  v_item_icon = {
    "Item_icon",
    BIND_TYPE.IMAGE
  },
  v_item_num = {
    "Item_amount",
    BIND_TYPE.TEXT
  },
  v_item_name = {
    "Item_name",
    BIND_TYPE.TEXT
  },
  v_item_desc = {
    "Item_detilTitle",
    BIND_TYPE.TEXT
  },
  v_item_w_desc = {
    "Item_detil",
    BIND_TYPE.TEXT
  },
  v_stock_icon = {
    "StockIcon",
    BIND_TYPE.OBJECT
  },
  v_stock = {
    "Stock",
    BIND_TYPE.OBJECT
  },
  v_detail_obj = {
    "Detil_text",
    BIND_TYPE.OBJECT
  },
  v_stock_num = {
    "StockAmount",
    BIND_TYPE.TEXT
  },
  v_break_star = {
    "StarNeed",
    BIND_TYPE.BUTTON
  },
  v_need_star_bg = {
    "StarNeedAmount",
    BIND_TYPE.OBJECT
  },
  v_star_num = {
    "StarAmount",
    BIND_TYPE.TEXT
  },
  v_mat_num = {
    "MatAmount",
    BIND_TYPE.TEXT
  },
  v_start_overflow_desc = {
    "Overflow",
    BIND_TYPE.OBJECT
  },
  v_no_hero_desc = {
    "HeroLock",
    BIND_TYPE.OBJECT
  },
  v_getway = {
    "GetWayList",
    BIND_TYPE.OBJECT
  },
  v_getway_item = {
    "GetWayTem",
    BIND_TYPE.OBJECT
  },
  v_source_btn = {
    "SourceBtn",
    BIND_TYPE.BUTTON
  },
  v_detail_btn = {
    "DetailBtn",
    BIND_TYPE.BUTTON
  }
}
local TIPS_TYPE = Config.ITEM_TIPS_TYPE
local SHOW_TYPE = Config.ITEM_SHOW_TYPE
local TEMPLATE_KEY = {
  SOURCE_ITEM = "SOURCE_ITEM"
}
local SHOP_TYPE = Shop_Helper.SHOP_TYPE

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("Return", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("ExpendStockBtn", function()
    self:_onclick_expend_stock_btn()
  end)
  self:set_button("SourceBtn", function()
    self:_onclick_source_btn()
  end)
  self:set_button("DetailBtn", function()
    self:_onclick_detail_btn()
  end)
  self:register_exist_auto_template(TEMPLATE_KEY.SOURCE_ITEM, self.v_uiobjects.GetWayTem, self.v_uiobjects.GetWayList)
  self.v_show_type = SHOW_TYPE.DETAIL
  self.v_tips_type = TIPS_TYPE.COMMON
  self.v_item_id = 0
  self.v_item_cfg = nil
  self.v_buy_panel = self.v_panels.shop_buy_view:get_object()
end

function ui:ui_on_show(data, ...)
  if not data.item_id then
    return
  end
  if data.tips_type then
    self.v_tips_type = data.tips_type
  end
  self.v_item_id = data.item_id
  if data.show_type then
    self.v_show_type = data.show_type
  end
  if data.param then
    self.v_param = data.param
  end
  self.v_item_cfg = UtilUI.get_item_cfg(self.v_item_id)
  self:_refresh_tips_view()
end

function ui:ui_on_hide()
  MsgGame:mq_publish2(Const.MSG_ON_ITEM_TIPS_CLOSE)
  self.v_show_type = SHOW_TYPE.DETAIL
  self.v_tips_type = TIPS_TYPE.COMMON
  self.v_item_id = 0
  self.v_item_cfg = nil
  self.v_break_mat_enough = nil
  self.v_item_obj = nil
  self.v_panels.shop_buy_view:set_enable(false)
end

function ui:_refresh_tips_view()
  self.v_item_name.text = UtilUI.get_item_name(self.v_item_id)
  local quality_cfg = ShareRes.get_item_quality_cfg(self.v_item_cfg.Quality)
  if quality_cfg then
    ResMgr:load_set_icon(self.v_uicompents.Bg_img, quality_cfg.QualityBgIcon)
  end
  local show_num = 0
  if self.v_tips_type == TIPS_TYPE.SHOP and self.v_show_type == SHOW_TYPE.DETAIL and self.v_param.goods_cfg then
    show_num = self.v_param.goods_cfg.ItemCnt
    self.v_uicompents.PzAmount_txt.text = show_num
  end
  self.v_uiobjects.PzAmountLayout:SetActive(0 ~= show_num)
  if not self.v_item_obj then
    self.v_item_obj = self:create_item_obj(nil, self.v_item_quality.gameObject, nil, {
      item_id = self.v_item_id
    })
  else
    self.v_item_obj:ui_show({
      item_id = self.v_item_id
    })
  end
  self.v_item_num.text = BagMgr:get_item_num(self.v_item_id)
  local is_break_mat = false
  if self.v_item_cfg then
    is_break_mat = self.v_item_cfg.Type == ITEM_TYPE.MATS and 1 == self.v_item_cfg.Subtype
  end
  self.v_break_star.gameObject:SetActiveEx(is_break_mat)
  Global.listener_mgr:add_listener(self.v_object, self.v_break_star.onClick, function()
    self:_onclick_break_star_btn()
  end)
  if is_break_mat then
    self:_set_break_info()
  end
  self:_set_mini_icon()
  self:_set_stock_info()
  self:_set_discount()
  self:_refresh_right_view()
end

function ui:_set_mini_icon()
  local item_id = self.v_item_cfg.Id
  local type_config = ShareRes.get_award_type_cfg(item_id)
  self.v_uiobjects.PluginsSize:SetActive(false)
  if type_config.AwardType == Config.AWARD_TYPE.PUZZLE then
    local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(item_id)
    local graph_show_cfg = ShareRes.get_buddy_puzzle_graph_show_cfg(puzzle_cfg.GraphID)
    ResMgr:load_set_icon(self.v_uicompents.PluginsSizeIcon_img, graph_show_cfg.SmallIcon, nil, true)
    self.v_uiobjects.PluginsSize:SetActive(true)
  end
end

function ui:_get_item_bag_type(item_id)
  local award_type = ShareRes.create("item.award_type")
  for k, v in pairs(award_type) do
    if item_id >= v.IdBegin and item_id <= v.IdEnd then
      return v.AwardType
    end
  end
end

function ui:_set_stock_info()
  self.v_stock:SetActiveEx(false)
  self.v_detail_obj:SetActive(false)
  if self.v_tips_type ~= TIPS_TYPE.SHOP then
    return
  end
  if self.v_param ~= nil and nil ~= self.v_param.goods_cfg then
    local goods_cfg = self.v_param.goods_cfg
    self.v_stock:SetActiveEx(goods_cfg.StockItem > 0)
    if goods_cfg.StockItem > 0 then
      local stock_has = BagMgr:get_item_num(goods_cfg.StockItem)
      self.v_stock_num.text = Shop_Helper.get_num_formate(stock_has)
    end
  end
end

function ui:_set_break_info()
  local role_id = self.v_item_cfg.Arg[1]
  local buddy_info = CharacterMgr:get_buddy_by_id(role_id)
  self.v_no_hero_desc:SetActiveEx(nil == buddy_info)
  self.v_need_star_bg:SetActiveEx(nil ~= buddy_info)
  self.v_start_overflow_desc:SetActiveEx(nil ~= buddy_info)
  self.v_break_star.interactable = nil ~= buddy_info
  if nil ~= buddy_info then
    local has = BagMgr:get_item_num(self.v_item_id)
    local is_enough, anmout, lv = Shop_Helper.check_break_mat_enough(self.v_item_id, role_id)
    self.v_need_star_bg:SetActiveEx(false == is_enough)
    self.v_start_overflow_desc:SetActiveEx(true == is_enough)
    if false == is_enough then
      self.v_star_num.text = Util.format_str("升{1}", lv)
      self.v_mat_num.text = Util.format_str("仍需<color=red>{1}</color>个", anmout)
    end
    self.v_break_mat_enough = is_enough
  end
end

function ui:_set_discount()
  if not self.v_param or not self.v_param.goods_cfg then
    return
  end
  local goods_cfg = self.v_param.goods_cfg
  local has_discount = goods_cfg.Discount > 0
  self.v_uiobjects.DiscountBg:SetActiveEx(has_discount)
  self.v_uicompents.Discount_txt.text = 100
  if false == has_discount then
    return
  end
  if self.v_shop_type == SHOP_TYPE.BREAK_SHOP then
    if goods_cfg.StockItem > 0 then
      local num = ShopMgr:get_stock_amount(goods_cfg.StockItem)
      self.v_price_discount = Shop_Helper.get_break_item_discount(num, goods_cfg.DiscountVal)
    end
    if 100 == self.v_price_discount then
      self.v_discount_bg:SetActiveEx(false)
    else
      local discount_str = Shop_Helper.format_discount(self.v_price_discount)
      self.v_uicompents.Discount_txt.text = discount_str
    end
  else
    self.v_price_discount = tonumber(goods_cfg.DiscountVal)
    local discount_str = Shop_Helper.format_discount(goods_cfg.DiscountVal)
    self.v_uicompents.Discount_txt.text = discount_str
  end
end

function ui:_refresh_right_view()
  self.v_item_desc.text = ""
  self.v_item_w_desc.text = ""
  if not self.v_item_cfg then
    return
  end
  local has_source
  if self.v_item_cfg.Jump then
    local k, v = next(self.v_item_cfg.Jump)
    has_source = 0 ~= v
  end
  self.v_source_btn:SetActive(false)
  self.v_detail_btn:SetActive(false)
  self.v_item_desc:SetActive(self.v_show_type == SHOW_TYPE.DETAIL)
  self.v_item_w_desc:SetActive(self.v_show_type == SHOW_TYPE.DETAIL)
  self.v_getway:SetActive(self.v_show_type == SHOW_TYPE.SOURCE)
  if self.v_show_type == SHOW_TYPE.DETAIL then
    self.v_item_desc.text = self.v_item_cfg.Desc
    local item_id = self.v_item_cfg.Id
    local type_config = ShareRes.get_award_type_cfg(item_id)
    if type_config.AwardType == Config.AWARD_TYPE.PUZZLE then
      local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(item_id)
      if puzzle_cfg.EntryId then
        local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(puzzle_cfg.EntryId, 3)
        self.v_item_w_desc.text = entry_cfg.Desc
      end
    else
      self.v_item_w_desc.text = self.v_item_cfg.WorldDesc
    end
  else
    self:_refresh_source_view()
  end
  self.v_buy_panel:SetActive(false)
  if self.v_tips_type == TIPS_TYPE.SHOP and self.v_show_type == SHOW_TYPE.DETAIL then
    local goods_cfg = self.v_param.goods_cfg
    self.v_panels.shop_buy_view:set_enable(true, {
      goods_cfg = goods_cfg,
      enough = self.v_break_mat_enough
    })
    self.v_buy_panel:SetActive(true)
  end
end

function ui:_refresh_source_view()
  self:give_back_auto_cache(TEMPLATE_KEY.SOURCE_ITEM, false)
  local jump = self.v_item_cfg.Jump
  for k, v in pairs(jump) do
    if 0 ~= v then
      local cfg = ShareRes.create("sysopen.sys_jump", v)
      local obj = self:get_auto_cache(TEMPLATE_KEY.SOURCE_ITEM)
      local title = self:get_text("GetWay_name", obj)
      title.text = cfg.title
      local desc = self:get_text("GetWay_detil", obj)
      desc.text = cfg.source_desc
      local btn = self:get_button(nil, obj)
      Global.listener_mgr:add_listener(self.v_object, btn.onClick, function()
        self:ui_hide()
        SysOpenMgr:jump_to_sys(v, true)
      end)
    end
  end
end

function ui:_onclick_expend_stock_btn()
  UIMgr:get_ui("expand_stock_tips"):ui_show(self.v_param.goods_cfg.ShopId)
end

function ui:_onclick_break_star_btn()
  UIMgr:get_ui("break_mat_tips"):ui_show(self.v_item_id)
  self:ui_hide()
end

function ui:_onclick_source_btn()
  self.v_show_type = SHOW_TYPE.SOURCE
  self:_refresh_tips_view()
end

function ui:_onclick_detail_btn()
  self.v_show_type = SHOW_TYPE.DETAIL
  self:_refresh_tips_view()
end

return ui
