local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local m_iapHandler = S:Get("IAPHandler")
local m_mallResId, m_lastTriggerTime, m_expireTime, m_result, m_data, m_localedPrice, m_canBuy, m_eventUid

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, CloseWindow)
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirmClick)
  this:RegisterGameEvent("PushTypePurchaseBuyRecord", function(params)
    local purchaseId = params[1]
    if purchaseId and purchaseId == m_data.productId then
      UpdateStatus()
    end
  end)
end

function InitWindow()
  REF.EffectOpen.gameObject:SetActive(true)
  REF.Content.gameObject:SetActive(true)
  REF.Black.gameObject:SetActive(true)
end

function SetData(result)
  if result == nil then
    return
  end
  m_result = result
  m_mallResId = result.surpriseEvent.mallResId
  m_eventUid = result.surpriseEvent.eventUid
  local mallInfo = PB.get("Mall", m_mallResId)
  if mallInfo == nil then
    error("Mall.xlsx has no mallid " .. m_mallResId)
    return
  end
  m_data = mallInfo
  local reward = mallInfo.reward or {}
  local refRoot = REF.RewardsGrid[0].root.gameObject
  for i = 1, #reward - 1 do
    local go = CS.NGUITools.AddChild(REF.RewardsGrid.gameObject, refRoot)
  end
  for i = 1, #reward do
    local ref = REF.RewardsGrid[i - 1].root
    ref.transform.localScale = CS.UnityEngine.Vector3(0.7, 0.7, 1)
    SetRewardSlot(ref, reward[i].type, reward[i].id, reward[i].count)
  end
  REF.RewardsGrid.UIGrid:Reposition()
  local TextInfo = PB.get("ActivityGiftSaku", m_mallResId)
  if TextInfo == nil then
    error("ActivityGiftSaku.xlsx has no mallid " .. m_mallResId)
    return
  end
  REF.TextWindow.gameObject:SetActive(TextInfo.text ~= "")
  REF.LabelTextWindow.UILabel.text = WU.GetString(TextInfo.text)
  UpdateStatus()
end

function SetRewardSlot(ref, resourceType, resourceId, resourceCount)
  _ENV["$"](ref).IconHasClaimed.gameObject:SetActive(false)
  _ENV["$"](ref).GLOW.gameObject:SetActive(false)
  _ENV["$"](ref).SpriteProgress.gameObject:SetActive(false)
  _ENV["$"](ref)["$$SetData"](resourceType, resourceId, resourceCount)
end

function UpdateWindow()
  if m_result then
    m_lastTriggerTime = CS.GameTime.UtcToLocal(m_result.surpriseEvent.lastTriggerTime)
    m_expireTime = m_result.surpriseEvent.expireTime
    local timeNow = CS.GameTime.serverNow
    local endTime = m_lastTriggerTime:AddSeconds(m_expireTime)
    if timeNow < endTime then
      local lastTimeSpan = endTime - timeNow
      local lastDay = lastTimeSpan.Days
      local lastHour = lastTimeSpan.Hours
      local lastMin = lastTimeSpan.Minutes
      local lastSecond = lastTimeSpan.Seconds
      REF.LabelTime.UIHtmlLabel.text = WU.GetString("Window_Day_Hour_Min_Second_end", lastDay, lastHour, lastMin, lastSecond)
      REF.LabelTime.gameObject:SetActive(true)
    else
      REF.LabelTime.gameObject:SetActive(false)
    end
  else
    REF.LabelTime.gameObject:SetActive(false)
  end
end

function OnConfirmClick()
  WU.ShowMessageYesNo(WU.GetString("MALL_TIPS2"), OnConfirmBuy)
end

function CloseWindow()
  RemoveAllClone(REF.RewardsGrid)
  REF.EffectOpen.gameObject:SetActive(false)
  REF.EffectClose.EffectGenerator:Play(function()
    playFlyEffect()
  end)
end

function RemoveAllClone(node)
  if node ~= nil then
    local childCnt = #node
    if 0 < childCnt then
      for i = childCnt - 1, 1, -1 do
        local obj = node[i]["$gameObject"]
        obj.transform.parent = nil
        CS.UnityEngine.GameObject.Destroy(obj)
      end
    end
  end
end

function OnConfirmBuy()
  local baseInfo = DB:GetData("fci/baseinfo/")
  if baseInfo == nil then
    return
  end
  if baseInfo.level < m_data.limitLv then
    WU.ShowHintText(WU.GetString("Purchase_Error1"))
    return
  end
  if m_data.isPreheat then
    WU.ShowHintText(WU.GetString("Purchase_WillStart"))
    return
  end
  if m_data.productId == "" then
    local tryToPaySuccess = true
    local bindCost, noBindCost
    if m_data.resourceType == PB.enum.ResourceType.ResPlayerMoney or m_data.resourceType == PB.enum.ResourceType.ResPlayerPayMoney then
      tryToPaySuccess, bindCost, noBindCost = WU.IsEnoughMoney(m_data.price, m_data.resourceType)
      if tryToPaySuccess == false then
        local failedDesc = WU.GetString("WindowShopBuy_PurchaseFailedB") .. "\n"
        WU.ShowMessageYesNo(WU.GetString("MALL_TIPS1"), function(message)
          if message == "YES" then
            this:BroadcastGameEvent("POSITION_BUYMONEY")
            WU.RecycleWindow(this)
          end
        end)
      else
        local trade = {
          id = m_data.id,
          eventId = m_eventUid
        }
        this:GameRequest("fci/mall-trade"):Post(trade, function(result)
          DBH.ResChange(result.resChange)
          m_data.buyCount = result.buyCount
          UpdateStatus()
          WU.ShowRewards(result.resChange)
          WU.RecycleWindow(this)
        end)
      end
    else
      local function onFail()
        WU.ShowMessageYesNo(WU.GetString("Purchase_Tips8"), function(msg)
          if msg == "YES" then
            WU.Exchange(PB.enum.ResourceType.ResPlayerGold)
          end
        end)
      end
      
      local function onSuccess()
        local trade = {
          id = m_data.id,
          eventId = m_eventUid
        }
        this:GameRequest("fci/mall-trade"):Post(trade, function(result)
          DBH.ResChange(result.resChange)
          m_data.buyCount = result.buyCount
          UpdateStatus()
          WU.ShowRewards(result.resChange)
          WU.RecycleWindow(this)
        end)
      end
      
      WU.TryToPay(m_data.resourceType, 0, m_data.price, onSuccess, onFail)
    end
  else
    local purchaseInfo = m_iapHandler.GetProductsByID(m_data.productId)
    if purchaseInfo.ratio == 0 then
      WU.RecycleWindow(this)
      m_iapHandler.SetEventId(m_eventUid)
      m_iapHandler.Purchase(purchaseInfo, purchaseInfo.channels[1], purchaseInfo.count)
    else
      WU.ShowHintText(WU.GetString("Purchase_AnyInvalidHint"))
    end
  end
end

function SetPriceLabel(canbuy)
  if canbuy then
    REF.IconCost.gameObject:SetActive(m_data.productId == "")
    REF.Price.gameObject:SetActive(m_data.productId == "")
    REF.RMBPrice.gameObject:SetActive(m_data.productId ~= "")
    if m_data.productId ~= "" then
      m_localedPrice = m_iapHandler.GetLocalizedPrice(m_data.productId)
      if m_localedPrice ~= nil then
        REF.RMBPrice.UIHtmlLabel.text = m_localedPrice
      else
        REF.RMBPrice.UIHtmlLabel.text = WU.GetString("Purchase_NotAvaiable")
      end
    else
      m_localedPrice = string.format("%d", m_data.price)
      REF.Price.UIHtmlLabel.text = m_localedPrice
      REF.IconCost.UISprite.spriteName = PB.enum.ResourceType.__keys[m_data.resourceType] .. "_0"
    end
    REF.ButtonConfirm.gameObject:SetActive(true)
  else
    REF.IconCost.gameObject:SetActive(false)
    REF.Price.gameObject:SetActive(false)
    REF.RMBPrice.gameObject:SetActive(false)
    REF.ButtonConfirm.gameObject:SetActive(false)
  end
end

function UpdateStatus()
  this:GameRequest("fci/mall-info/"):Get(function(response)
    DB:SetData("fci/mall-info/", response)
    m_canBuy = true
    for k, v in pairs(response.mallRecord.summary) do
      local key = tonumber(k)
      local buyCount = tonumber(v.buyCount)
      if key == m_data.id then
        m_canBuy = buyCount < m_data.maxBuyCount
        break
      end
    end
    for k, v in pairs(response.purchaseRecord.buyRecord) do
      if k == m_data.productId then
        m_canBuy = v.buyCount < m_data.maxBuyCount
        break
      end
    end
    SetPriceLabel(m_canBuy)
    DB:SetData("hasGetGiftSaku", m_canBuy)
  end)
end

function playFlyEffect()
  REF.Content.gameObject:SetActive(false)
  REF.Black.gameObject:SetActive(false)
  local effect = REF.StarEffect
  effect.transform.localPosition = CS.UnityEngine.Vector3.zero
  local tween = effect.TweenPosition
  local resource = WU.FindWindow("Resource")
  tween.from = effect.transform.localPosition
  tween.to = _ENV["$"](resource).RIGHT.transform.localPosition + _ENV["$"](resource).ButtonMoney.transform.localPosition
  tween:ResetToBeginning()
  tween:PlayForward()
  effect.EffectGenerator:Play(function()
    WU.RecycleWindow("SurpriseEventUp")
  end)
end
