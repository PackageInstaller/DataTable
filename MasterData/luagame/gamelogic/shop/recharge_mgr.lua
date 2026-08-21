local Base = require("gamelogic.base_system")
local ShopCfg = require("uimodule.shop.shop_config")
local Shop_Helper = require("uimodule.shop.shop_helper")
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
  self.v_recharge_info = {}
  self.v_gift_info = {}
  self.v_card_info = {}
  self.v_first_recharge_award_data = {}
  self.v_retry_count = 0
end

function M:on_reconnect()
  self.v_recharge_info = {}
end

function M:on_recharge_money_list(data)
  self.v_recharge_info = {}
  for _, v in ipairs(data.recharge_money_list) do
    self.v_recharge_info[v.id] = v
  end
end

function M:on_recharge_money_data(data)
  local info = data.recharge_money_data
  self.v_recharge_info[info.id] = info
  MsgGame:mq_publish2(Const.MSG_ON_RECHARGE_UPDATE)
end

function M:on_gift_shop_list(data)
  self.v_gift_info = {}
  for _, v in pairs(data.gift_shop_list) do
    self.v_gift_info[v.gift_id] = v.buy_cnt
  end
  self:_check_gift_redpoint()
  MsgGame:mq_publish2(Const.MSG_ON_GIFT_INFO_UPDATE)
end

function M:on_gift_shop_data(data)
  local gift = data.gift_shop_data
  self.v_gift_info[gift.gift_id] = gift.buy_cnt
  self:_check_gift_redpoint()
  MsgGame:mq_publish2(Const.MSG_ON_GIFT_INFO_UPDATE)
end

function M:on_monthly_cards_info(data)
  self.v_card_info = {}
  for k, v in pairs(data.cards_data) do
    self.v_card_info[v.type] = v
  end
end

function M:on_monthly_card_info_update(data)
  local card = data.card_data
  local is_pass_day
  if self.v_card_info[card.type] then
    local pre_duration = self.v_card_info[card.type].duration
    is_pass_day = 1 == pre_duration - card.duration
  end
  self.v_card_info[card.type] = card
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CARD_INFO_UPDATE)
  msg.mm_obj = is_pass_day
end

function M:on_monthly_card_expired(data)
  self.v_card_info[data.card_type] = nil
  MsgGame:mq_publish2(Const.MSG_ON_CARD_INFO_UPDATE)
end

function M:on_offline_recharge_award(data)
  UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Recharge_Reward, "award_show_panel", data.award_list)
end

function M:on_first_recharge_award_data(data)
  self.v_first_recharge_award_data = data
  MsgGame:mq_publish2(Const.MSG_ON_FIRST_RECHARGE_AWARD_UPDATE)
  self:check_first_recharge_red()
end

function M:on_recharge_module_data(data)
  self.v_recharge_module_data = data
end

function M:get_recharge_module_data()
  return self.v_recharge_module_data
end

function M:is_fobidden_buy_product(sdkkey)
  if self.v_recharge_module_data and self.v_recharge_module_data.ban_recharge_project then
    for _, v in ipairs(self.v_recharge_module_data.ban_recharge_project) do
      if v == sdkkey then
        return true
      end
    end
  end
  return false
end

function M:request_buy_product(config, cb)
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    Util.show_notify_popup_message(nil, "模拟器暂不支持充值，请前往移动端充值", nil, "确定", nil, nil, true)
    if cb then
      cb(false)
    end
  else
    local sdkkey = SDKManager:get_sdkkey(config)
    if self:is_fobidden_buy_product(sdkkey) then
      Log.Error("product is forbidden to buy!", sdkkey)
      Util.show_notify_popup_message(nil, "暂时无法购买此商品！")
      if cb then
        cb(false)
      end
    else
      SDKManager:buy_product(config, cb)
    end
  end
end

function M:simulate_request_buy_product(product_id, cb)
  local send_data = {product_id = product_id}
  Network:call("c2gs_simulate_recharge", send_data, function(ok, resp)
    if cb then
      cb()
    end
  end)
end

function M:request_buy_gift(gift_id, cb)
  local gift_cfg = ShareRes.get_gift_shop_cfg(gift_id)
  local _, _, privilege_id = NewbieTowerMgr:check_is_privilege_gift(gift_cfg.Paging, gift_id)
  Network:call("c2gs_gift_shop_buy", {gift_id = gift_id, privilege_id = privilege_id}, function(ok, resp)
    MsgGame:mq_publish2(Const.MSG_ON_FASHION_BUY_SUC)
    if cb then
      cb(ok)
    end
  end)
end

function M:is_recharge_product(config)
  return config and config.sdkkey and UtilTable.hash_lenth(config.sdkkey) > 0
end

function M:get_sdkkey(config)
  return SDKManager:get_sdkkey(config)
end

function M:get_is_first_recharge(id)
  if not self.v_recharge_info[id] then
    Log.Error("get recharge info error, id not find!", id)
    return false
  end
  return self.v_recharge_info[id].bFirst
end

function M:get_recharge_money()
  return math.ceil(self.v_recharge_module_data.recharge_money)
end

function M:get_goods_price(config)
  return SDKManager:get_product_price(config)
end

function M:get_product_show_price_str(config)
  return SDKManager:get_product_show_price_str(config)
end

function M:get_currency_symbol(config)
  return SDKManager:get_currency_symbol(config)
end

function M:request_product_info(callback)
  SDKManager:request_product_info(callback)
end

function M:is_product_valid(config)
  return SDKManager:is_product_valid(config)
end

function M:get_has_buy_card(card_type)
  return self.v_card_info[card_type]
end

function M:get_month_card_remain_days(card_type)
  if not self.v_card_info[card_type] then
    return 0
  end
  return self.v_card_info[card_type].duration
end

function M:get_has_recive_reward_today(card_type)
  if not self.v_card_info[card_type] then
    return false
  end
  return self.v_card_info[card_type].is_got
end

function M:recive_month_card_daily_award(card_type, callback)
  if not self.v_card_info[card_type] or self.v_card_info[card_type].is_got then
    return false
  end
  Network:call("c2gs_sign_monthly_card", {type = card_type}, function(ok, resp)
    if true == ok and 0 == resp.errcode and callback then
      callback(resp.fixed_award, resp.drop_award)
    end
  end)
end

function M:get_gift_buy_count(gift_id)
  if not self.v_gift_info[gift_id] then
    Log.Error("get gift info error, id not find!", gift_id)
    return 0
  end
  return self.v_gift_info[gift_id]
end

function M:_check_gift_redpoint()
  for _, v in pairs(ShopCfg.GIFT_SHOP_SHELF) do
    if v.Id < ShopCfg.SKIN_GIFT_SHOP_SHELF then
      local show = false
      local gift_shop_type_cfg = ShareRes.create("recharge.gift_shop_type", v.Id)
      if gift_shop_type_cfg then
        for _, gift in ipairs(gift_shop_type_cfg) do
          local is_open = Shop_Helper.check_gift_open(gift)
          if is_open and not Shop_Helper.check_sold_out(gift) and not gift.CostItem and not gift.ShowPrice then
            show = true
            break
          end
        end
      end
      RedPointMgr:enable_redpoint(ShopCfg.GIFT_SHOP_SHELF[v.Id].RedId, show)
    end
  end
end

function M:is_first_recharge_done()
  if self.v_first_recharge_award_data and self.v_first_recharge_award_data.award_state then
    return true
  end
  return false
end

function M:is_first_recharge_award_all_get()
  if self.v_first_recharge_award_data then
    local award_cfg = ShareRes.create("recharge.firse_recharge_award")
    local get_award_day = self.v_first_recharge_award_data.get_award_day
    if get_award_day then
      return #get_award_day >= #award_cfg
    end
  end
  return true
end

function M:get_first_recharge_login_day()
  if self.v_first_recharge_award_data then
    return self.v_first_recharge_award_data.player_login_day
  end
  return 0
end

function M:can_get_first_recharge_award(day)
  local can_get_days = self:get_first_recharge_award_can_get_days()
  if not can_get_days then
    return false
  end
  if not day then
    return true
  end
  for _, _day in ipairs(can_get_days) do
    if day == _day then
      return true
    end
  end
  return false
end

function M:can_get_free_first_recharge_award()
  local has_free_award = ShareRes.get_first_recharge_free_award() ~= nil
  if not has_free_award then
    return false
  end
  if self.v_first_recharge_award_data then
    return self.v_first_recharge_award_data.day_award_state == true
  end
  return false
end

do
  local first_recharge_sys_id = 61
  
  function M:is_first_recharge_open()
    local is_open = SysOpenMgr:get_sys_is_open(first_recharge_sys_id)
    if not is_open then
      return false
    end
    return not RechargeMgr:is_first_recharge_award_all_get()
  end
  
  function M:check_first_recharge_red()
    local show_red = true
    local can_get_award = self:can_get_first_recharge_award()
    if not can_get_award then
      local is_first_recharge_open = self:is_first_recharge_open()
      if not is_first_recharge_open then
        show_red = false
      else
        show_red = self:can_get_free_first_recharge_award()
      end
    end
    RedPointMgr:enable_redpoint(RedEnum.FIRST_RECHARGE, show_red)
  end
  
  function M:get_first_recharge_award_can_get_days()
    if not self.v_first_recharge_award_data or not self.v_first_recharge_award_data.award_state then
      return
    end
    local cfg = ShareRes.create("recharge.firse_recharge_award")
    local max_day = #cfg
    max_day = max_day < self.v_first_recharge_award_data.player_login_day and max_day or self.v_first_recharge_award_data.player_login_day
    if max_day < 1 then
      return
    end
    local day_list = {}
    local get_award_day = self.v_first_recharge_award_data.get_award_day
    for day = 1, max_day do
      if not get_award_day or not get_award_day[day] then
        day_list[#day_list + 1] = day
      end
    end
    if 0 == #day_list then
      return
    end
    return day_list
  end
  
  function M:req_get_first_recharge_award(callback)
    local can_get_days = self:get_first_recharge_award_can_get_days()
    if not can_get_days then
      return
    end
    Network:call("c2gs_get_first_recharge_award", {day_list = can_get_days}, function()
      if callback then
        callback()
      end
    end)
  end
  
  function M:req_get_free_first_recharge_award()
    Network:call("c2gs_get_first_recharge_day_award")
  end
end
return M
