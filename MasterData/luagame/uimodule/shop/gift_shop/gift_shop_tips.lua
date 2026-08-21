local Base = require("ui.uibase")
local ShopCfg = require("uimodule.shop.shop_config")
local ui = Util.create_child_mt(Base)
local TIPS_TYPE = ShopCfg.GIFT_TIPS_TYPE
local PANELS = {
  [TIPS_TYPE.DETAIL] = "gift_goods_detail",
  [TIPS_TYPE.SKIN_SHORT] = "skin_gift_short"
}

function ui:ui_finish_load()
  self:set_button("Close", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(tips_type, ...)
  tips_type = tips_type or TIPS_TYPE.DETAIL
  self:set_panel_enable(PANELS[tips_type], true, ...)
  self:_regist_client_event()
end

function ui:ui_on_hide()
  for _, v in pairs(PANELS) do
    self:set_panel_enable(v, false)
  end
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_JUMP_TO_RECHARGE, self.ui_hide, self)
end

return ui
