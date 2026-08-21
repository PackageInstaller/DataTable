local Base = require("ui.uibase")
local ShopCfg = require("uimodule.shop.shop_config")
local ui = Util.create_child_mt(Base)
local MODEL = {
  [1] = {
    tog_name = "Recommend",
    ui_name = "recommond_shop",
    red_id = RedEnum.RECOMMOND_SHOP
  },
  [2] = {tog_name = "MonthCard", ui_name = ""},
  [3] = {
    tog_name = "GiftShop",
    ui_name = "gift_shop",
    red_id = RedEnum.GIFT_SHOP
  },
  [4] = {tog_name = "Skin", ui_name = "skin_shop"},
  [5] = {
    tog_name = "Exchange",
    ui_name = "shopexchange"
  },
  [6] = {
    tog_name = "Recharge",
    ui_name = "recharge_shop"
  },
  [7] = {
    tog_name = "TokenExchange",
    ui_name = "token_exchange"
  }
}
local SHOP_TYPE = ShopCfg.SHOP_TYPE
local COLOR_DIME = tonumber("FFFFFF", 16)
local COLOR_LIGHT = tonumber("000000", 16)

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    if self.return_cb then
      self.return_cb()
      self.return_cb = nil
    end
    self:ui_hide()
  end)
  local pageObj = self.v_uiobjects.Page
  self.v_toggle_group = self:get_toggle_group(nil, pageObj)
  self.v_toggle_group.allowSwitchOff = true
  self.v_tog_eff = {
    Recommend = self.v_uiobjects.Ani_VX_Recommend_ON,
    GiftShop = self.v_uiobjects.Ani_VX_GiftShop_ON,
    Skin = self.v_uiobjects.Ani_VX_Skin_ON,
    Exchange = self.v_uiobjects.Ani_VX_Exchange_ON,
    Recharge = self.v_uiobjects.Ani_VX_Recharge_ON,
    TokenExchange = self.v_uiobjects.Ani_VX_Recharge_ON
  }
  self.v_tog_list = {}
  for i, v in ipairs(MODEL) do
    local tb = {}
    tb.tog = self:set_toggle(v.tog_name, function(isOn)
      self.v_tog_eff[v.tog_name]:SetActive(isOn)
      self:_on_click_tog(i, isOn)
    end, false)
    local tog_obj = tb.tog.gameObject
    local is_lock = not SysOpenMgr:get_is_ui_open(v.ui_name)
    tb.lock = self:get_child_gameobj("Lock", tog_obj)
    tb.lock:SetActiveEx(is_lock)
    tb.icon = self:get_image("Icon", tog_obj)
    local color = tb.icon.color
    color.a = (is_lock and 5 or 25) / 255
    tb.icon.color = color
    tb.lab = self:get_text("Label", tog_obj)
    self.v_tog_list[i] = tb
    tb.check = self:get_child_gameobj("Checkmark", tog_obj)
    tb.check:SetActive(false)
    if v.red_id then
      local red = self:get_child_gameobj("Point", tog_obj)
      RedPointMgr:bind_redpoint(self, red, v.red_id)
    end
  end
  self.v_canvas_group = self:get_canvas_group(nil, pageObj)
end

function ui:ui_on_show(shop_name, shelves_type, ...)
  local first_param = (...)
  if first_param and type(first_param) == "table" and first_param.sub_page_idx then
    self:set_sub_page_idx(first_param.sub_page_idx)
  else
    self:set_sub_page_idx(nil)
    self.v_param = table.pack(...)
  end
  local MASK_TAG_KEY = "SHOP_MAIN_GET_PRODUCT"
  ScreenMaskMgr:open_one_tag(MASK_TAG_KEY)
  self.v_cur_tog_index = nil
  RechargeMgr:request_product_info(function()
    ScreenMaskMgr:close_one_tag(MASK_TAG_KEY)
    local defaultIdx = self:_get_default_shop()
    if shop_name then
      defaultIdx = SHOP_TYPE[shop_name]
    end
    self.v_shelves_type = shelves_type
    self.v_tog_list[defaultIdx].tog.isOn = false
    self.v_tog_list[defaultIdx].tog.isOn = true
    self.v_toggle_group.allowSwitchOff = false
    self.v_shelves_type = nil
    self.v_param = nil
    self.return_cb = nil
    self:_regist_client_event()
    for _, tog_eff in pairs(self.v_tog_eff) do
      tog_eff:SetActive(false)
    end
  end)
end

function ui:ui_on_hide()
  self.v_shelves_type = nil
  self.v_param = nil
  self.v_canvas_group.alpha = 0
end

function ui:ui_on_destroy()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_NEW_SYS_OPEN, self._refresh_sys_state, self)
end

function ui:_on_click_tog(index, isOn)
  if index == self.v_cur_tog_index then
    return
  end
  if isOn then
    local last_idx_cache = self.v_cur_tog_index
    local last_idx = self.v_cur_tog_index or self:_get_default_shop()
    self.v_cur_tog_index = nil
    local cur_view_name = MODEL[index].ui_name
    if "" == cur_view_name then
      self.v_tog_list[last_idx].tog.isOn = true
      return
    end
    if SysOpenMgr:get_is_ui_open(cur_view_name, true) == false then
      self.v_tog_list[last_idx].tog.isOn = true
      self:_on_click_tog(last_idx, true)
      return
    end
    if MODEL[last_idx_cache] then
      local last_view_name = MODEL[last_idx_cache].ui_name
      if "" ~= last_view_name then
        UIMgr:get_ui(last_view_name):ui_hide()
      end
    end
    if index ~= ShopCfg.SHOP_TYPE.Skin then
      self:set_sub_page_idx(nil)
    end
    local param
    if self.v_param then
      param = table.unpack(self.v_param)
    end
    UIMgr:get_ui(cur_view_name):ui_show(self.v_shelves_type, param)
    self.v_cur_tog_index = index
    for i, v in ipairs(self.v_tog_list) do
      v.check:SetActiveEx(false)
    end
    self.v_tog_list[index].check:SetActiveEx(true)
  else
    self.v_tog_list[index].check:SetActiveEx(false)
  end
end

function ui:reopen(shop_name, shelves_type, ...)
  local defaultIdx = self:_get_default_shop()
  if shop_name then
    defaultIdx = SHOP_TYPE[shop_name]
  end
  self.v_shelves_type = shelves_type
  self.v_param = table.pack(...)
  if self.v_cur_tog_index ~= defaultIdx then
    self.v_tog_list[defaultIdx].tog.isOn = true
  else
    local cur_view_name = MODEL[self.v_cur_tog_index].ui_name
    local ui = UIMgr:get_ui(cur_view_name)
    if ui then
      ui:reopen(self.v_shelves_type, table.unpack(self.v_param))
    end
  end
  self.v_shelves_type = nil
  self.v_param = nil
end

function ui:_get_default_shop()
  for i, v in ipairs(MODEL) do
    if v.ui_name ~= "" and SysOpenMgr:get_is_ui_open(v.ui_name) then
      return i
    end
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  local temp_param
  if self.v_cur_tog_index == ShopCfg.SHOP_TYPE.Skin then
    temp_param = {
      sub_page_idx = self.v_sub_page_idx
    }
  end
  return ShopCfg.SHOP_TYPE_NAME[self.v_cur_tog_index], self.v_shelves_type, temp_param
end

function ui:set_sub_page_idx(idx)
  self.v_sub_page_idx = idx
end

function ui:get_sub_page_idx()
  return self.v_sub_page_idx
end

function ui:_refresh_sys_state()
  for k, tb in pairs(self.v_tog_list) do
    local open = SysOpenMgr:get_is_ui_open(MODEL[k].ui_name, true)
    tb.lock:SetActive(not open)
    local color = tb.icon.color
    color.a = (open and 25 or 5) / 255
    tb.icon.color = color
  end
end

return ui
