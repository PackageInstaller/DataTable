local Base = require("manager.sdk.base_sdk_mgr")
local M = Util.create_child_mt(Base)
local CSHiveSDKManager = CS.Game.HiveSDKManager
local Account = require("gamelogic.account.account")
local CommonDef = require("cs_share.common_define")

function M:_init(...)
  Base._Init(self, ...)
  self.v_is_abroad_branch = true
  local use_sandbox = GAME_DEBUG or IS_STAGING or PUBLISH_GM
  if not UNITY_EDITOR then
    if use_sandbox then
      CS.hive.Configuration.setZone(CS.hive.ZoneType.SANDBOX)
    else
      CS.hive.Configuration.setZone(CS.hive.ZoneType.REAL)
    end
  end
end

function M:is_enable_del_player_timer_check()
  return true
end

function M:is_enable_player_id_txt_in_login()
  return true
end

function M:is_enable_notification_setting()
  return true
end

function M:is_enable_account_setting()
  return self:is_use_sdk() and self:had_sdk_login() and not Global.gamemode:gmode_is_login()
end

function M:is_enable_select_server()
  return GAME_DEBUG or UNITY_EDITOR
end

function M:is_enable_no_sdk_login_in_publish_gm()
  return true
end

function M:get_sub_channel_id()
  return "glohow"
end

local market_connect_tag = "market_connect"

function M:_market_connect(callback)
  ScreenMaskMgr:open_one_tag(market_connect_tag, math.huge, true, 1)
  CSHiveSDKManager.MarketConnect(function(result, marketIdList)
    if result:isSuccess() then
      self:_get_product_info(callback)
    else
      ScreenMaskMgr:close_one_tag(market_connect_tag)
      Log.Error("hive market connect failed! ", result.errorCode, result.errorMessage)
      if callback then
        callback()
      end
    end
  end)
end

function M:_get_product_info(callback)
  CSHiveSDKManager.GetProductInfo(function(result, productInfoList, balance)
    ScreenMaskMgr:close_one_tag(market_connect_tag)
    if result:isSuccess() then
      for i = 0, productInfoList.Count - 1 do
        local product_info = productInfoList[i]
        local product_id = product_info.marketPid
        self.v_products[product_id] = product_info
      end
      if callback then
        callback()
      end
      self:check_restore()
    else
      Log.Error("hive get product info failed! ", result.errorMessage)
      if callback then
        callback()
      end
    end
  end)
end

function M:_check_valid()
  return self:is_use_sdk()
end

function M:check_sensitive(content, callback, check_sensitive_ui_map_name)
  if not self:_check_valid() then
    return
  end
  Network:call("c2gs_on_check_sensitive_words", {text = content}, function(ok, resp)
    if callback then
      callback(0 == resp.errcode)
    end
    if 0 ~= resp.errcode then
      Util.show_message_tip(1722)
      Network:call("c2gs_prohibit_words_tsi_log", {
        text = content,
        trigger_id = CommonDef.EXAMINE_TEXT_REASON_ID_MAP[check_sensitive_ui_map_name]
      })
    end
  end)
end

local login_tag = "login"

function M:login()
  if not self:_check_valid() or self:is_logining() or self:had_sdk_login() then
    return
  end
  ScreenMaskMgr:open_one_tag(login_tag, math.huge, false)
  self:set_is_logining(true)
  CSHiveSDKManager.Login(function(result, hive_player_info)
    Log.Info("hive login: ", result:isSuccess(), result.message, result.errorMessage)
    if result:isSuccess() then
      self:on_sdk_login_success(hive_player_info)
    end
    self:set_is_logining(false)
    ScreenMaskMgr:close_one_tag(login_tag)
  end)
end

function M:on_sdk_login_success(sdk_response)
  Log.Info("on_sdk_login_success")
  Base.on_sdk_login_success(self, sdk_response)
  self.v_did = sdk_response.did
  self.v_player_token = sdk_response.playerToken
  self.v_sdk_user_id = sdk_response.playerId
  self.v_is_guest_account = CSHiveSDKManager.IsGuestAccount()
  CSHiveSDKManager.GetRemotePush(function(result, remote_push)
    if result:isSuccess() then
      BattleSettingMgr:set_notice_notification(remote_push.isAgreeNotice, true)
      BattleSettingMgr:set_night_notification(remote_push.isAgreeNight, true)
    end
  end)
  self:get_connected_idp_list()
end

function M:on_sdk_logout_success(sdk_response)
  Log.Info("on_sdk_logout_success")
  Base.on_sdk_logout_success(self, sdk_response)
  self.v_did = nil
  self.v_player_token = nil
  self.v_sdk_user_id = nil
end

function M:get_sdk_account()
  return self.v_sdk_user_id
end

function M:logout(logout_sdk_withoutt_tip, on_sdk_logout_success)
  if not self:_check_valid() or not self:had_sdk_login() then
    Util.show_notify_popup_message(function()
      if PlayerMgr then
        PlayerMgr:logout_game_server()
      end
      if on_sdk_logout_success then
        on_sdk_logout_success()
      end
    end, "退出登录", "登出", "确定", "取消", nil, false)
    return
  end
  
  local function do_sdk_logout()
    CSHiveSDKManager.Logout(function(result, hive_player_info)
      self:on_sdk_logout_success(hive_player_info)
      if on_sdk_logout_success then
        on_sdk_logout_success()
      end
    end)
  end
  
  if logout_sdk_withoutt_tip then
    do_sdk_logout()
  elseif self:is_guest_account() then
    Util.show_notify_popup_message(function()
      do_sdk_logout()
    end, LanguageMgr:get_code_text("账号将被初始化，您确定要登出吗？"))
  else
    Util.show_notify_popup_message(function()
      do_sdk_logout()
    end, "退出登录", "登出", "确定", "取消", nil, false)
  end
end

function M:get_login_game_server_url(host)
  local device_type = Account:get_device_type()
  local mac_address = UnityEngine.SystemInfo.deviceUniqueIdentifier
  local host_content = host .. "platform=%s&device_type=%s&account_id=%s&mac_address=%s&version=%s&auth_token=A9Cz4sv0O8&did=%s&authorization=%s"
  if UNITY_ANDROID then
    host_content = host_content .. "&is_xigncode=true"
  end
  local url = string.format(host_content, self.v_platform, device_type, self.v_sdk_user_id, mac_address, Util.get_login_version(), self.v_did, self.v_player_token)
  return url
end

function M:get_server_list_json_url()
  if IS_STAGING then
    local url = "https://bbglobal-cdn.glohow.com/staging_list/server_list.json?time=" .. Date.server_time()
    return url
  else
    local url = "https://bbglobal-cdn.glohow.com/live_list/server_list.json?time=" .. Date.server_time()
    return url
  end
end

function M:get_notice_url(picture)
  local file = picture or "maintenance_notice.json"
  local url = "https://bbglobal-cdn.glohow.com/notice/%s/%s?time=" .. Date.server_time()
  if GAME_DEBUG or PUBLISH_GM then
    url = string.format(url, "debug", file)
  else
    url = string.format(url, "release", file)
  end
  return url
end

function M:check_restore()
  CSHiveSDKManager.Restore(function(restore_result, restore_recipt_list)
    if restore_result:isSuccess() and restore_result.errorCode == CS.hive.ResultAPI.ErrorCode.SUCCESS and restore_recipt_list and restore_recipt_list.Count > 0 then
      for i = 0, restore_recipt_list.Count - 1 do
        local receipt = restore_recipt_list[i]
        self:_finish_pay(receipt, nil)
      end
    else
    end
  end)
end

function M:_finish_pay(receipt, callback)
  local product_id = receipt.product.marketPid
  local comfirm_data = {
    hive_receipt = receipt.bypassInfo,
    amount = receipt.product.price,
    amount_type = receipt.product.currency
  }
  Network:call("c2gs_hive_recharge_call_back", comfirm_data, function(comfirm_ok, comfirm_err_code)
    CSHiveSDKManager.TransactionFinish(product_id, function(transactionResult)
      if callback then
        callback(comfirm_ok)
      end
      if not transactionResult:isSuccess() then
        Log.Error("hive TransactionFinish Failed! ", transactionResult.errorMessage)
      end
    end)
  end)
end

local buy_product_tag = "buy_product"

function M:buy_product(config, cb)
  local price = config.ShowPrice
  local product_id = self:get_sdkkey(config)
  ScreenMaskMgr:open_one_tag(buy_product_tag, math.huge, false)
  
  local function callback(result)
    ScreenMaskMgr:close_one_tag(buy_product_tag)
    if cb then
      cb(result)
    end
  end
  
  if not self:_check_valid() then
    callback(false)
    return
  end
  if not self:is_product_valid(config) then
    callback(false)
    return
  end
  local send_data = {product_id = product_id}
  Network:call("c2gs_new_recharge_order", send_data, function(ok, resp)
    if ok then
      local order_id = resp.order_id
      
      local function pay_failed_cb(result)
        Network:call("c2gs_recharge_failed", {order_id = order_id})
        Log.Error("hive pay failed! ", result.errorCode, result.errorMessage)
        callback(false)
      end
      
      local function pay_cancel_cb(result)
        Network:call("c2gs_cancel_recharge", {order_id = order_id})
        Log.Info("hive pay canceld! ", result.errorCode, result.errorMessage)
        callback(false)
      end
      
      local iapPayload = order_id .. "|" .. product_id
      CSHiveSDKManager.Purchase(product_id, iapPayload, function(result, receipt)
        if result:isSuccess() then
          self:_finish_pay(receipt, callback)
        elseif result.errorCode == CS.hive.ResultAPI.ErrorCode.NEED_RESTORE then
          self:check_restore()
        elseif result.errorCode == CS.hive.ResultAPI.ErrorCode.CANCELED then
          pay_cancel_cb(result)
        else
          pay_failed_cb(result)
        end
      end)
    else
      callback(false)
    end
  end)
end

function M:enter_game()
  if not self:_check_valid() then
    return
  end
  CSHiveSDKManager.SetXCUserInfo(Global.player_uuid)
end

function M:add_login_request_params(body)
  if not self:_check_valid() then
    return
  end
  Base.add_login_request_params(self, body)
  if UNITY_ANDROID then
    local cookie = CSHiveSDKManager.GetCookie2(self.v_server_xign_seed)
    body.xign_cookie = cookie
  end
end

function M:on_game_server_auth_success(auth_info)
  if not self:_check_valid() then
    return
  end
  self.v_server_xign_seed = auth_info.xign_code
end

function M:track_adjust_event(event_name)
  if UNITY_EDITOR then
    return
  end
  CSHiveSDKManager.SendEvent(event_name)
end

function M:get_product_show_price_str(config)
  if not self:is_product_valid(config) then
    return "no product"
  end
  local product_id = self:get_sdkkey(config)
  return self.v_products[product_id].displayPrice
end

function M:get_product_price(config)
  if not self:is_product_valid(config) then
    return "Invalid"
  end
  local product_id = self:get_sdkkey(config)
  return self.v_products[product_id].price
end

function M:request_product_info(callback)
  Log.Info("gh request_product_info: ", self:is_use_sdk(), self.v_is_use_sdk)
  if not self:is_use_sdk() then
    Base.request_product_info(self, callback)
  else
    self:_market_connect(callback)
  end
end

function M:get_currency_symbol(config)
  if not self:is_product_valid(config) then
    return ""
  end
  local product_id = self:get_sdkkey(config)
  return self.v_products[product_id].currency
end

function M:is_show_privacy_policy_btn_in_more_entry()
  return false
end

function M:is_show_user_center_btn_in_more_entry()
  return false
end

function M:is_show_help_center_btn_in_more_entry()
  return false
end

function M:is_show_community_btn_in_more_entry()
  return false
end

function M:is_show_delete_account_in_more_entry()
  return false
end

function M:open_privacy_policy()
  if not self:_check_valid() then
    return
  end
  CSHiveSDKManager.ShowTerms(nil)
end

function M:open_community()
  if not self:_check_valid() then
    return
  end
  Base.open_web_view(self, "https://discord.com/invite/pHgnz5C5Uc")
end

function M:open_help_center()
  if not self:_check_valid() then
    return
  end
  CSHiveSDKManager.ShowInquiry(nil)
end

function M:open_exchange_code()
  if not self:_check_valid() then
    return
  end
  local sanbox_url = "https://sandbox-coupon.withhive.com/2444"
  local release_url = "https://coupon.withhive.com/2444"
  Base.open_web_view(self, GAME_RELEASE and not PUBLISH_GM and release_url or sanbox_url)
end

function M:open_user_center()
  if not self:_check_valid() then
    return
  end
  CSHiveSDKManager.ShowProfile(nil)
end

function M:set_remote_push(is_agree_notice, is_agree_night)
  if not self:_check_valid() then
    return
  end
  CSHiveSDKManager.SetRemotePush(is_agree_notice, is_agree_night, nil)
end

function M:request_notification_permission()
  if not self:_check_valid() then
    return
  end
  CSHiveSDKManager.RequestPushPermission()
end

function M:get_sdkkey(config)
  if UNITY_ANDROID then
    return config and config.sdkkey and config.sdkkey[2]
  elseif UNITY_IOS then
    return config and config.sdkkey and config.sdkkey[3]
  end
  return nil
end

function M:exit_game()
  if not self:_check_valid() or UNITY_IOS then
    self:show_exit_game_popup()
  else
    CSHiveSDKManager.ExitGame()
  end
end

function M:show_review(close_callback)
  if not self:_check_valid() then
    if nil ~= close_callback then
      close_callback()
    end
    return
  end
  CSHiveSDKManager.ShowNativeReview(close_callback)
end

function M:display_banner(close_callback)
  if not self:_check_valid() then
    if nil ~= close_callback then
      close_callback()
    end
    return
  end
  CSHiveSDKManager.ShowBanner(close_callback)
end

function M:show_news(close_callback)
  if nil ~= close_callback then
    close_callback()
  end
end

function M:show_delete_account_popup()
  if not self:_check_valid() then
    return
  end
  local title = "删除账户"
  local android_content = "删除账户时，绑定的数据将被删除。 删除部分游戏数据最多需要90天时间。 * 付费相关咨询请联系应用商店或[Glohow]客服中心。"
  local ios_content = "删除账户时，绑定的数据将被删除。 删除部分游戏数据最多需要90天时间。 * 付费相关咨询请联系应用商店或[Glohow]客服中心。"
  local content = UNITY_ANDROID and android_content or ios_content
  local deleted_content = "已删除账号。"
  local delete_failed_content = "账号删除失败。请稍后再试。"
  local comfirm_content = "确定"
  local cancel_content = "取消"
  Util.show_notify_popup_message(function()
    Network:call("c2gs_del_player_timer", nil, function(ok, resp)
      if ok then
        SDKManager:logout(true)
      end
    end)
  end, content, title, comfirm_content, cancel_content)
end

function M:do_delete_account(callback)
  if not self:_check_valid() then
    if callback then
      callback(false)
    end
    return
  end
  CSHiveSDKManager.DeleteAccount(function(result, player_info)
    if callback then
      callback(result:isSuccess())
    end
  end)
end

function M:get_connected_idp_list()
  if not self:_check_valid() then
    return
  end
  CSHiveSDKManager.GetConnectedIDPList(function(result, idp_list)
    if not result:isSuccess() or nil == idp_list then
      Log.Error("hive get connected idp list failed! ", result.errorMessage)
    end
    local ret_idp_tb = {}
    for i = 0, idp_list.Count - 1 do
      table.insert(ret_idp_tb, idp_list[i])
    end
    self.v_connected_idp_list = ret_idp_tb
  end)
end

function M:get_connected_idp_count()
  if not self.v_connected_idp_list then
    return 0
  end
  return UtilTable.hash_lenth(self.v_connected_idp_list)
end

function M:is_idp_connected(idp_type)
  if not self:_check_valid() then
    return false
  end
  if not self.v_connected_idp_list then
    Log.Error("hive get connected idp list failed! ")
    return false
  end
  for _, connected_idp_type in pairs(self.v_connected_idp_list) do
    if connected_idp_type == idp_type then
      return true
    end
  end
  return false
end

local connect_idp_tag = "connect_idp"

function M:connect_idp(idp_type, callback)
  if not self:_check_valid() then
    if callback then
      callback(false)
    end
    return
  end
  local is_connected = self:is_idp_connected(idp_type)
  if is_connected then
    local connected_idp_count = self:get_connected_idp_count()
    if 1 == connected_idp_count then
      Util.show_notify_popup_message(nil, "需要绑定至少1个账号。", nil, nil, nil, nil, true)
      return
    end
    ScreenMaskMgr:open_one_tag(connect_idp_tag, math.huge, false)
    CSHiveSDKManager.DisconnectIDP(idp_type, function(result, player_info)
      self.v_is_guest_account = CSHiveSDKManager.IsGuestAccount()
      self:get_connected_idp_list()
      if callback then
        callback(not result:isSuccess())
      end
      if result:needExit() then
        CSHelper.QuitApplication()
      end
      ScreenMaskMgr:close_one_tag(connect_idp_tag)
    end)
  else
    ScreenMaskMgr:open_one_tag(connect_idp_tag, math.huge, false)
    CSHiveSDKManager.ConnectIDP(idp_type, function(result, player_info)
      self.v_is_guest_account = CSHiveSDKManager.IsGuestAccount()
      self:get_connected_idp_list()
      if callback then
        callback(result:isSuccess())
      end
      if result:needExit() then
        CSHelper.QuitApplication()
      elseif result.errorCode == CS.hive.ResultAPI.ErrorCode.PLAYER_CHANGE then
        self:logout(true)
      end
      ScreenMaskMgr:close_one_tag(connect_idp_tag)
    end)
  end
end

return M
