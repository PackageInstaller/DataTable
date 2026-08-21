local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local S = require("Common/Singleton"):Register(_ENV, "IAPHandler")
local U = require("Common/Util")
local m_iap, m_remotePrice, m_localPrice, m_timeout, m_platform, m_channel, m_products, m_mapProducts
local m_activityInfo = {}
local m_payProducts, m_productIds
local m_bReset = false
local m_eventUid

function SetIAPInterface(iap)
  m_iap = iap
end

function SetEventId(id)
  m_eventUid = id
end

function Start()
  m_bReset = false
  this:RegisterGameEvent("IAPRemoteProduct", OnIAPRemoteProduct)
  this:RegisterGameEvent("IAPRemoteProductFailed", OnIAPRemoteProductFailed)
  this:RegisterGameEvent("IAPPurchase", OnIAPPurchase)
  this:RegisterGameEvent("IAPPurchaseFailed", OnIAPPurchaseFailed)
  this:RegisterGameEvent("GetPurchaseActivityInfo", OnGetActivityInfo)
  m_platform = CS.ResourceManager.Instance.ConstConfig.PurchasePlatform
  m_products = PB.all("PurchaseInfo"):where(function(_, p)
    return p.platform == m_platform
  end):toarray()
  m_payProducts = PB.all("PurchaseInfo"):where(function(_, p)
    return p.platform == m_platform and p.showInShop == true
  end):toarray()
  table.sort(m_payProducts, function(a, b)
    if a.price < b.price then
      return true
    else
      return false
    end
  end)
  m_productIds = m_products:select(function(p)
    return p.productId
  end)
  m_products = m_products:where(function(_, p)
    return p.ratio == 0
  end):toarray():sort(function(a, b)
    return a.count < b.count
  end):append(m_products:where(function(_, p)
    return p.ratio ~= 0
  end):toarray())
  m_mapProducts = {}
  for i, v in ipairs(m_products) do
    m_mapProducts[v.productId] = v
  end
  if m_iap ~= nil then
    m_iap:Init()
  end
end

function OnDestroy()
  if m_iap ~= nil then
    m_iap:Uninit()
  end
end

function OnGetActivityInfo(result)
  m_activityInfo = {}
  if result == nil then
    return
  end
  local luaData = JsonD(result)
  if luaData.mp_info and luaData.mp_info.utp_mpinfo_detail and luaData.mp_info.utp_mpinfo_detail.rank_info then
    for i, v in ipairs(luaData.mp_info.utp_mpinfo_detail.rank_info) do
      local info = m_activityInfo[tonumber(v.num)]
      if info == nil then
        info = {}
        info.rank_info = v
        m_activityInfo[tonumber(v.num)] = info
      else
        info.rank_info = v
      end
    end
    for i, v in ipairs(luaData.mp_info.utp_mpinfo_detail.range_info) do
      local info = m_activityInfo[tonumber(v.num)]
      if info == nil then
        info = {}
        info.range_info = v
        m_activityInfo[tonumber(v.num)] = v
      else
        info.range_info = v
      end
    end
  end
  this:BroadcastGameEvent("OnGetPurchaseActivityInfo")
end

function IsDoubleSendByFirst(v)
  return v.rank_info and v.rank_info.send_ext ~= ""
end

function GetSendNum(v)
  if v.range_info and v.range_info.coin and #v.range_info.coin > 0 and v.range_info.coin[1].send_num then
    return tonumber(v.range_info.coin[1].send_num)
  end
  return 0
end

function GetActivityByPrice(price)
  return m_activityInfo[price]
end

function GetProductsByID(proID)
  return m_mapProducts[proID]
end

function GetProducts()
  return m_payProducts
end

function UseRemoteProduct()
  return m_platform == PB.enum.PurchasePlatform.ios_cn or m_platform == PB.enum.PurchasePlatform.android_global or m_platform == PB.enum.PurchasePlatform.ios_midas
end

function LocalDelevery()
  return m_platform == PB.enum.PurchasePlatform.ios_cn or m_platform == PB.enum.PurchasePlatform.android_global or m_platform == PB.enum.PurchasePlatform.ios_midas or m_platform == PB.enum.PurchasePlatform.android_midas
end

function ResolveProductPrice()
  if UseRemoteProduct() then
    if m_iap ~= nil then
      local productId = m_productIds
      local json = JsonE(productId)
      m_iap:RequestRemoteProduct(json)
    end
  else
    m_localPrice = {}
    for k, p in pairs(m_products) do
      m_localPrice[p.productId] = WU.GetString("Purchase_LocalPrice", p.price)
    end
  end
end

function SetUserInfo(info)
  if m_iap ~= nil then
    m_iap:SetUserInfo(JsonE(info))
  end
end

function Refresh()
  ResolveProductPrice()
  if m_iap ~= nil then
    m_iap:Refresh()
  end
end

function Purchase(product, channel, count)
  MidasProxy(function()
    PurchaseImpl(product, channel, count)
  end)
end

function IsGoods(product)
  local isGoods = false
  for i, v in ipairs(product.purchaseRes) do
    if v.type ~= PB.enum.ResourceType.ResNone then
      isGoods = true
      break
    end
  end
  return isGoods
end

function GetActivityInfo()
  m_iap:GetActivityInfo(JsonE({platform = m_platform, channel = "midas"}))
end

function PurchaseImpl(product, channel, count)
  if m_iap ~= nil then
    m_channel = channel
    m_timeout = this:DelayInvokeInSeconds(30, function()
      OnIAPPurchaseFailed({reason = "Timeout"})
    end)
    local accountCache = this:GetData("accountCache")
    this:GameRequest("fci/purchasetouch/"):Post({
      isGuest = accountCache.entryType == "guest",
      productId = product.productId,
      platform = m_platform,
      channel = m_channel,
      count = count,
      eventId = m_eventUid
    }, function(response)
      if response ~= nil then
        local isGoods = IsGoods(product)
        local payItem = ""
        if isGoods then
          payItem = string.format("%s*%d*%s", product.productId, product.price * 10, 1)
        end
        m_iap:Purchase(JsonE(_ENV["!"]({
          productId = product.productId,
          presetCount = count,
          platform = m_platform,
          channel = PB.enum.PurchaseChannel.__keys[m_channel],
          isGoods = isGoods,
          payItem = payItem
        }):merge(response)))
      end
    end, FinishPurchase)
    WU.SetLockFlag(WU.LockInputFlag.Purchase, true)
  end
end

function Finish(response)
  if m_iap ~= nil and m_channel ~= nil then
    response.channel = PB.enum.PurchaseChannel.__keys[m_channel]
    m_iap:Finish(JsonE(response))
  end
end

function GetLocalizedPrice(productId)
  if UseRemoteProduct() then
    if m_remotePrice ~= nil then
      return m_remotePrice[productId]
    end
  elseif m_localPrice ~= nil then
    return m_localPrice[productId]
  end
end

function OnIAPRemoteProduct(json)
  m_remotePrice = JsonD(json)
end

function OnIAPRemoteProductFailed(json)
  this:DelayInvokeInSeconds(15, ResolveProductPrice)
end

function OnIAPPurchase(json)
  if LocalDelevery() then
    local jsonData = JsonD(json) or {}
    local data = table.linq(jsonData):merge({channel = m_channel, platform = m_platform})
    this:GameRequest("fci/purchasedelevery/"):Post(data, function(response)
      Finish(response)
      FinishPurchase()
    end, FinishPurchase)
  else
    FinishPurchase()
  end
end

function CheckWXAutoLogin()
  local accountCache = this:GetData("accountCache")
  local platform = U.ToEnum(CS.Msdk.ePlatform, accountCache.socialPlatform)
  if platform == CS.Msdk.ePlatform.ePlatform_Weixin then
    CS.PlatformManager.IsNeedWXAutoLogin = true
  end
end

function OnIAPPurchaseFailed(json)
  local jsonData = JsonD(json) or {}
  local reason = jsonData.reason
  if reason == "NeedLogin" then
    if not m_bReset then
      m_bReset = true
      WU.ShowMessageOK(WU.GetString("Error_ExpiredRelationData"), function()
        CheckWXAutoLogin()
        this:SetData("accountCache", {})
        CS.GameGlobal.Instance:ResetGame()
      end)
    end
  elseif reason ~= nil then
    WU.ShowHintText(WU.GetString("Purchase_PurchaseFailed"))
  else
    if type(json) == "string" and json == "NeedLogin" then
      WU.ShowMessageOK(WU.GetString("Purchase_PurchaseFailed_TokenTimeOut"), function()
        CheckWXAutoLogin()
        this:SetData("accountCache", {})
        CS.GameGlobal.Instance:ResetGame()
      end)
      WU.SetLockFlag(WU.LockInputFlag.Purchase, false)
      if m_timeout ~= nil then
        this:StopCoroutine(m_timeout)
        m_timeout = nil
      end
      return
    end
    WU.ShowHintText(WU.GetString("Purchase_PurchaseFailed"))
  end
  FinishPurchase()
end

function FinishPurchase()
  WU.SetLockFlag(WU.LockInputFlag.Purchase, false)
  if m_timeout ~= nil then
    this:StopCoroutine(m_timeout)
    m_timeout = nil
  end
  GetActivityInfo()
  this:BroadcastGameEvent("FinishPurchase")
end

local Msdk = CS.Msdk
local m_midasInfoCache

function MidasProxy(callback)
  WU.SetLockFlag(WU.LockInputFlag.Purchase, true)
  UpdateMidasUserInfo(nil, function(changed)
    WU.SetLockFlag(WU.LockInputFlag.Purchase, false)
    if changed == nil then
      WU.ShowMessageOK(WU.GetString("Purchase_PurchaseFailed_TokenTimeOut"), function()
        CS.GameGlobal.Instance:ResetGame()
      end)
    elseif changed then
      SyncMidas(callback)
    elseif callback ~= nil then
      callback()
    end
  end)
end

function UpdateMidasUserInfoImpl(loginRet, callback)
  local midasInfo = _ENV["!"]({
    openId = loginRet.open_id,
    pf = loginRet.pf,
    pfKey = loginRet.pf_key,
    platform = CS.ResourceManager.Instance.ConstConfig.PurchasePlatform,
    accessToken = loginRet:GetAccessToken()
  })
  local platformEnum = U.ToEnum(Msdk.ePlatform, loginRet.platform)
  if platformEnum == Msdk.ePlatform.ePlatform_QQ then
    midasInfo.openKey = loginRet:GetTokenByType(Msdk.eTokenType.eToken_QQ_Pay)
    midasInfo.sessionId = "openid"
    midasInfo.sessionType = "kp_actoken"
  end
  if platformEnum == Msdk.ePlatform.ePlatform_Weixin then
    midasInfo.openKey = loginRet:GetTokenByType(Msdk.eTokenType.eToken_WX_Access)
    midasInfo.sessionId = "hy_gameid"
    midasInfo.sessionType = "wc_actoken"
  end
  if platformEnum == Msdk.ePlatform.ePlatform_Guest then
    midasInfo.openKey = "openkey"
    midasInfo.sessionId = "hy_gameid"
    midasInfo.sessionType = "st_dummy"
  end
  local changed = midasInfo:compare(m_midasInfoCache)
  m_midasInfoCache = midasInfo
  return changed
end

function UpdateMidasUserInfo(loginRet, callback)
  if loginRet == nil then
    loginRet = Msdk.WGPlatform.Instance:WGGetLoginRecord()
  end
  if loginRet.flag == Msdk.eFlag.eFlag_Succ then
    local changed = UpdateMidasUserInfoImpl(loginRet)
    if callback ~= nil then
      callback(changed)
    end
  elseif loginRet.flag == Msdk.eFlag.eFlag_Checking_Token then
    this:DelayInvokeInSeconds(3, function()
      UpdateMidasUserInfo(nil, callback)
    end)
  elseif callback ~= nil then
    callback(nil)
  end
end

function SyncMidas(callback)
  CS.Restifizer.RestifizerManager.Instance:ConfigBearerAuth(m_midasInfoCache.accessToken)
  SetUserInfo(m_midasInfoCache)
  local luaTable = {midasInfo = m_midasInfoCache}
  local wireForMatTable = ProtobufT("ApiPlayerSyncMidasInfo", luaTable)
  this:GameRequest("/fci/syncmidas"):Patch(wireForMatTable, callback)
end
