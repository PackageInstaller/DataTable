local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local AssetBarView = require("ui.asset_bar.asset_bar")
local Shop_Helper = require("uimodule.shop.shop_helper")
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_amount_panel = {
    "ItemAmoutPanel",
    BIND_TYPE.OBJECT
  },
  v_buy_num = {
    "ItemAmount",
    BIND_TYPE.TEXT
  },
  v_max_buy = {
    "ItemLimit",
    BIND_TYPE.TEXT
  },
  v_cost_panel = {
    "CostPanel",
    BIND_TYPE.OBJECT
  },
  v_money_cost = {
    "MoneyCostTem",
    BIND_TYPE.OBJECT
  },
  v_money_icon = {
    "MoneyCostIcon",
    BIND_TYPE.IMAGE
  },
  v_money_need = {
    "MoneyCostAmount",
    BIND_TYPE.TEXT
  },
  v_stock_cost = {
    "StockCostTem",
    BIND_TYPE.OBJECT
  },
  v_stock_need = {
    "StockCostAmount",
    BIND_TYPE.TEXT
  },
  v_sold_out = {
    "SlodOut",
    BIND_TYPE.OBJECT
  },
  v_operate_panel = {
    "OperatePanel",
    BIND_TYPE.OBJECT
  },
  v_slider = {
    "Slider",
    BIND_TYPE.SLIDER
  },
  v_add_btn = {
    "BtnAdd",
    BIND_TYPE.BUTTON
  },
  v_reduce_btn = {
    "BtnReduce",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnBuy", function()
    self:onclick_buy_btn()
  end)
  self:set_button("BtnAdd", function()
    self:onclick_add_btn()
  end)
  self:set_button("BtnReduce", function()
    self:onclick_reduce_btn()
  end)
  self:set_slider_listener(self.v_slider, function()
    self:onclick_slider()
  end)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:ui_on_show(shop_cfg, buy_count)
  self.v_shop_cfg = shop_cfg
  self.v_buy_count = buy_count
  self.v_buy_amount = 1
  self:refresh_view()
end

function ui:ui_on_hide()
  self.v_asset_bar:on_hide()
end

function ui:refresh_view()
  self.v_max_buy_batch = self:get_can_buy_max_batch()
  self.v_cost_panel:SetActiveEx(true)
  self.v_stock_cost:SetActiveEx(false)
  self.v_amount_panel:SetActiveEx(true)
  self.v_operate_panel:SetActiveEx(true)
  self.v_sold_out:SetActiveEx(false)
  ResMgr:load_set_icon(self.v_money_icon, UtilUI.get_item_icon(self.v_shop_cfg.CostItem))
  self.v_max_buy.text = self.v_max_buy_batch * self.v_shop_cfg.ItemNum
  self.v_slider.maxValue = self.v_max_buy_batch > 0 and self.v_max_buy_batch or 1
  self.v_slider.minValue = 1 == self.v_max_buy_batch and 0 or 1
  self.v_slider.value = 1
  self:refresh_changed_info()
  if self.v_max_buy_batch * self.v_shop_cfg.ItemNum < math.modf(self.v_buy_amount * self.v_shop_cfg.ItemNum) then
    self.v_buy_num.text = self.v_max_buy_batch * self.v_shop_cfg.ItemNum
  end
  local list = Shop_Helper.get_asset_list({
    self.v_shop_cfg.CostItem
  })
  self.v_asset_bar:reset_config(list)
  self.v_asset_bar:on_create()
end

function ui:get_can_buy_max_batch()
  local money_has = BagMgr:get_item_num(self.v_shop_cfg.CostItem)
  local money_max_buy = 0
  if money_has >= self.v_shop_cfg.CostNum then
    money_max_buy = math.floor(money_has / self.v_shop_cfg.CostNum)
  end
  local limit_max_buy = self.v_shop_cfg.BuyLimit - self.v_buy_count
  if 0 == money_max_buy then
    local cfg = ShareRes.get_item_cfg(self.v_shop_cfg.CostItem)
    self.v_notice_desc = cfg.Name
  end
  return math.min(money_max_buy, limit_max_buy)
end

function ui:refresh_changed_info()
  local need = math.modf(self.v_buy_amount * self.v_shop_cfg.CostNum)
  local color = need <= BagMgr:get_item_num(self.v_shop_cfg.CostItem) and "%s" or "<color=red>%s</color>"
  self.v_money_need.text = string.format(color, need)
  self.v_buy_num.text = math.modf(self.v_buy_amount * self.v_shop_cfg.ItemNum)
  self.v_add_btn.interactable = self.v_buy_amount < self.v_max_buy_batch
  self.v_reduce_btn.interactable = self.v_buy_amount > 1
  self.v_slider.interactable = self.v_max_buy_batch > 0
end

function ui:onclick_buy_btn()
  if 0 == self.v_max_buy_batch then
    Util.show_message_tip(2326, self.v_notice_desc)
    return
  end
  
  local function callback()
    UIMgr:try_hide_ui("chal_ring_plus_contri_shop_item_tips")
  end
  
  ChallengeRingPlusMgr:request_buy_contribution_shop_goods(self.v_shop_cfg.Id, self.v_buy_amount, callback)
end

function ui:onclick_add_btn()
  self.v_buy_amount = self.v_buy_amount + 1
  self:refresh_changed_info()
  self.v_slider.value = self.v_buy_amount
end

function ui:onclick_reduce_btn()
  self.v_buy_amount = self.v_buy_amount - 1
  self:refresh_changed_info()
  self.v_slider.value = self.v_buy_amount
end

function ui:onclick_slider()
  self.v_buy_amount = math.floor(self.v_slider.value)
  self:refresh_changed_info()
end

return ui
