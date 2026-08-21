local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_iapHandler = S:Get("IAPHandler")
local DBH = require("Manager/DataBindingHandler")
local m_result, m_canBuy, m_data, m_mallResId, m_localedPrice, m_eventUid

function Awake()
  WU.BindButtonEvent(REF.ButtonPrice, function()
    if m_canBuy then
      if m_localedPrice == nil then
        WU.ShowHintText(WU.GetString("Purchase_NotAvaiable"))
      else
        WU.AcquireWindowAsync("PurchaseBuy", function(window)
          _ENV["$"](window)["$$SetData"](m_data, m_eventUid)
        end)
      end
    end
  end)
  this:RegisterGameEvent("UpdateSale", function(id, buyCount)
    if m_data and id == m_data.id then
      UpdateStatus()
    end
  end)
  this:RegisterGameEvent("PushTypePurchaseBuyRecord", function(params)
    local purchaseId = params[1]
    if purchaseId and m_data and purchaseId == m_data.productId then
      UpdateStatus()
    end
  end)
end

function OnEnable()
  this:Bind("surpriseEventInfo", OnSurpriseEvent)
  UpdateStatus()
end

function OnSurpriseEvent(result)
  if result and result.surpriseEvent then
    m_result = result
  else
    return
  end
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
end

function SetRewardSlot(ref, resourceType, resourceId, resourceCount)
  _ENV["$"](ref).IconHasClaimed.gameObject:SetActive(false)
  _ENV["$"](ref).GLOW.gameObject:SetActive(false)
  _ENV["$"](ref).SpriteProgress.gameObject:SetActive(false)
  _ENV["$"](ref)["$$SetData"](resourceType, resourceId, resourceCount)
end

function Update()
  if m_result then
    local info = m_result.surpriseEvent
    local expireTime = info.expireTime
    local lastTriggerTime = info.lastTriggerTime
    local timeNow = CS.GameTime.serverUtc
    local endTime = lastTriggerTime + expireTime
    local lastTimeSpanSeconds = endTime - timeNow
    if timeNow < endTime then
      REF.HtmlLabelLeftDay.UIHtmlLabel.text = WU.RenderCountDownTime(lastTimeSpanSeconds, 38, true)
    end
    REF.HtmlLabelLeftDay.gameObject:SetActive(timeNow < endTime)
  end
end

function OnDisable()
  this:Unbind("surpriseEventInfo", OnSurpriseEvent)
  RemoveAllClone(REF.RewardsGrid)
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

function SetPriceLabel(canbuy)
  if canbuy then
    if m_data then
      REF.ButtonPrice.UISprite.spriteName = "surprise_gift_button_on"
      REF.LabelHasBuy.gameObject:SetActive(false)
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
      m_data.buyCount = 0
    end
  else
    REF.ButtonPrice.UISprite.spriteName = "surprise_gift_button_off"
    REF.LabelHasBuy.gameObject:SetActive(true)
    REF.IconCost.gameObject:SetActive(false)
    REF.Price.gameObject:SetActive(false)
    REF.RMBPrice.gameObject:SetActive(false)
  end
end

function UpdateStatus()
  this:GameRequest("fci/mall-info/"):Get(function(response)
    DB:SetData("fci/mall-info/", response)
    m_canBuy = true
    for k, v in pairs(response.mallRecord.summary) do
      local key = tonumber(k)
      local buyCount = tonumber(v.buyCount)
      if m_data and key == m_data.id then
        m_canBuy = buyCount < m_data.maxBuyCount
        break
      end
    end
    for k, v in pairs(response.purchaseRecord.buyRecord) do
      if m_data and k == m_data.productId then
        m_canBuy = v.buyCount < m_data.maxBuyCount
        break
      end
    end
    SetPriceLabel(m_canBuy)
    DB:SetData("hasGetGiftSaku", m_canBuy)
  end)
end
