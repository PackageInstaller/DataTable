local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local MODEL = {}
local SHOP_ITEM = require("uimodule.weekly.weekly_shop_item")
local WEEKLY_SHOP_ITEM_KEY = "WEEKLY_SHOP_ITEM_KEY"
local WEEKLY_CFG = require("gamelogic.weekly.weekly_config")
local SHOW_CURRENCY = WEEKLY_CFG.SHOW_CURRENCY

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    UIMgr:go_to_main()
  end)
  self:register_exist_auto_template(WEEKLY_SHOP_ITEM_KEY, self.v_uiobjects.ShopTem, self.v_uiobjects.ShopContent)
  self.v_template_key = "current_item" .. self:ui_get_name()
  self:register_exist_auto_template(self.v_template_key, self.v_uiobjects.Asset_Item, self.v_uiobjects.AssetBar)
end

function ui:ui_update()
  self:update_time()
end

function ui:ui_on_show()
  self.v_wrap_list = {}
  self.v_currency_list = {}
  self.v_weekly_activity_cfg = ShareRes.get_weekly_pvp_activity_cfg()
  self.v_shop_id = self.v_weekly_activity_cfg.ShopId
  self.v_shop_cfg = ShareRes.get_shop_cfg_by_shop_id(self.v_shop_id)
  self.shop_info = ShareRes.create("shop.exchange_shop", 1005)
  self:update_shop_view()
  self:give_back_auto_cache(self.v_template_key)
  self:_refresh_currency_list()
  self:bind_auto_mq(Const.MSG_ON_ITEM_TIPS_CLOSE, self.response_view, self)
end

function ui:response_view()
  self:update_shop_view()
  self:_refresh_currency_list()
end

function ui:ui_on_hide()
  self:remove_wrap_list()
end

function ui:remove_wrap_list()
  for _, obj in pairs(self.v_wrap_list) do
    self:remove_wrap_ui(obj)
  end
  self.v_wrap_list = {}
end

function ui:_refresh_currency_list()
  for _, id in pairs(SHOW_CURRENCY) do
    if not self.v_currency_list[id] then
      local obj = self:get_auto_cache(self.v_template_key)
      self.v_currency_list[id] = obj
      local btn = Util.get_button("AddBtn", obj)
      self:set_button_listener(btn, function()
        UIMgr:get_ui("itemTip"):ui_show({item_id = id})
      end)
    end
    self:_set_currency(self.v_currency_list[id], id)
  end
end

function ui:_set_currency(obj, id)
  if nil == obj then
    Log.Error("获取货币item对象失败！！！")
    return
  end
  local cfg = ShareRes.get_item_cfg(id)
  if not cfg then
    return
  end
  obj:SetActiveEx(true)
  local moneyIcon = self:get_image("Label", obj)
  local path = UtilUI.get_item_icon(id)
  ResMgr:load_set_icon(moneyIcon, path)
  local moneyNum = self:get_text("Aomunt", obj)
  local item_num = BagMgr:get_item_num(id)
  moneyNum.text = item_num
end

function ui:update_shop_view()
  self:give_back_auto_cache(WEEKLY_SHOP_ITEM_KEY)
  local cfg = self.v_shop_cfg
  for _, data in ipairs(cfg) do
    local item = self:get_auto_cache(WEEKLY_SHOP_ITEM_KEY)
    local item_lua_obj = SHOP_ITEM:ui_wrap_ex(self, item, true)
    item_lua_obj:set_data(data)
    self.v_wrap_list[data.Id] = item_lua_obj
  end
  self:update_time()
end

function ui:update_time()
  local reset_value = self.shop_info.ResetValue
  local total_sec = WeeklyMgr:get_weekly_shop_reset_time(reset_value) - Date.server_time()
  self.v_uicompents.RemainTimeNum_txt.text = Date.get_time_formate_1(total_sec)
end

return ui
