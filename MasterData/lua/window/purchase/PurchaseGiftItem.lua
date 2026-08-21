local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_iapHandler = S:Get("IAPHandler")
local m_localedPrice, m_data, m_owner
local m_isSaleFinish = false
local m_buyCount = 0
local bTest, m_targetTime

function Awake()
  WU.BindButtonEvent(REF["$"], OnItemClick)
end

function Update()
  if m_data and m_targetTime and IsSaleFinish() == false and 0 < m_targetTime then
    local remainTime = m_targetTime - CS.GameTime.serverUtc
    if REF.TimeLimitBar then
      local timeString = WU.RenderCountdownTimeNotUrgent(remainTime, "#3599e9")
      local localization = ""
      if m_data.isPreheat then
        localization = "Purchase_Time_Preheat"
      else
        localization = "Purchase_Invalid_Goods_Before"
      end
      REF.TimeCountdownText.UIHtmlLabel.text = WU.GetString(localization, timeString)
      REF.TimeCountdownText.gameObject:SetActive(true)
    else
      REF.HtmlLabelTime.UIHtmlLabel.text = WU.RenderCountDownTime(remainTime, REF.HtmlLabelTime.UIHtmlLabel.fontSize)
      REF.HtmlLabelTime.gameObject:SetActive(true)
    end
    if remainTime < 0 then
      this:BroadcastGameEvent("UpdateMallData")
    end
  else
    if REF.TimeLimitBar then
      REF.TimeLimitBar.gameObject:SetActive(false)
    end
    if REF.HtmlLabelTime then
      REF.HtmlLabelTime.gameObject:SetActive(false)
    end
  end
end

function IsSaleFinish()
  local maxBuyCount = m_data.maxBuyCount
  if m_data.productId ~= "" then
    local product = m_iapHandler.GetProductsByID(m_data.productId)
    if product then
      maxBuyCount = product.maxBuyCount
    end
  end
  return maxBuyCount <= m_data.buyCount and 0 < maxBuyCount
end

function SetBuyCount(count)
  if m_data then
    m_data.buyCount = count
    m_isSaleFinish = IsSaleFinish()
    local maxBuyCount = m_data.maxBuyCount
    if m_data.buyCount and m_data.maxBuyCount then
      m_isSaleFinish = m_data.buyCount >= m_data.maxBuyCount and m_data.maxBuyCount > 0
    end
    local strCnt
    local leftCnt = m_data.maxBuyCount - m_data.buyCount
    if 0 < leftCnt then
      if m_data.giftType == PB.enum.GiftType.DailyRandomRefresh then
        strCnt = WU.GetString("Purchase_LeftBuyCount", leftCnt, m_data.maxBuyCount)
      elseif m_data.maxCountClearInterval == PB.enum.MallBuyIntervalType.Day then
        strCnt = WU.GetString("Purchase_DayBuyCnt", leftCnt, m_data.maxBuyCount)
      elseif m_data.maxCountClearInterval == PB.enum.MallBuyIntervalType.Week then
        strCnt = WU.GetString("Purchase_WeekBuyCnt", leftCnt, m_data.maxBuyCount)
      elseif m_data.maxCountClearInterval == PB.enum.MallBuyIntervalType.Month then
        strCnt = WU.GetString("Purchase_MonthBuyCnt", leftCnt, m_data.maxBuyCount)
      elseif m_data.maxCountClearInterval == PB.enum.MallBuyIntervalType.Forever then
        strCnt = WU.GetString("Purchase_LeftBuyCount", leftCnt, m_data.maxBuyCount)
      end
    end
    if REF.LimitCount then
      if strCnt then
        REF.LimitCount.gameObject:SetActive(true)
        REF.LabelLimitCount.UILabel.text = strCnt
      else
        REF.LimitCount.gameObject:SetActive(false)
      end
    end
    UpdateSaleIcon()
    UpdateSaleLabel()
  end
end

function Test()
  if bTest == nil then
    bTest = true
    this:DelayInvokeInSeconds(3, function()
      local activityInfoList = DB:GetData("ActivityList")
      if activityInfoList then
        for i, v in ipairs(activityInfoList) do
          if v.type == PB.enum.ActivityType.Mall and m_data.activityId == v.activityId then
            v.timestampEnd = 0
            m_data.endTime = 0
          end
        end
      end
    end)
  end
end

function UpdateSaleIcon()
  local spSale = REF.SpriteSale
  local containerAlpha = REF.ContainerAlpha
  if m_isSaleFinish == true then
    if spSale then
      spSale.gameObject:SetActive(true)
    end
    if containerAlpha then
      containerAlpha.UIWidget.alpha = 0.5
    end
  else
    if spSale then
      spSale.gameObject:SetActive(false)
    end
    if containerAlpha then
      containerAlpha.UIWidget.alpha = 1
    end
  end
end

function UpdateSaleLabel()
  local isEnough = true
  if m_data.resourceType == PB.enum.ResourceType.ResPlayerMoney or m_data.resourceType == PB.enum.ResourceType.ResPlayerPayMoney then
    isEnough = WU.IsEnoughMoney(m_data.price, m_data.resourceType)
  elseif m_data.resourceType ~= 0 then
    local stockCount = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[m_data.resourceType] .. "_0")
    isEnough = stockCount >= m_data.price
  end
  if isEnough == false then
    REF.Price.UIHtmlLabel.color = CS.NGUIMath.HexToColor(4250162431)
  else
    REF.Price.UIHtmlLabel.color = CS.NGUIMath.HexToColor(995593215)
  end
end

function SetData(data, owner)
  if data == nil then
    WU.SetActive(REF["$"], false)
    return
  end
  if data ~= nil then
    m_data = data
    if m_data.picBg then
      REF.Icon.UITexture.mainTexturePath = "Texture/Purchase/" .. m_data.picBg
    end
    local strTitle = string.format("MALL_GIFT_NAME%d", m_data.id)
    strTitle = WU.GetString(strTitle)
    REF.Title.UIHtmlLabel.text = strTitle
    local strDesc = string.format("MALL_GIFT_DESC%d", m_data.id)
    strDesc = WU.GetString(strDesc)
    REF.PromotionText.UIHtmlLabel.text = strDesc
    SetBuyCount(data.buyCount)
    UpdateSaleIcon()
    REF.IconCost.gameObject:SetActive(data.productId == "")
    REF.Price.gameObject:SetActive(data.productId == "")
    REF.RMBPrice.gameObject:SetActive(data.productId ~= "")
    if data.productId ~= "" then
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
      UpdateSaleLabel()
    end
    if data.isNewGift ~= true then
      if REF.IconGrid then
        for i = 1, 3 do
          local reward = m_data.reward[i]
          local icon = REF.IconGrid[i - 1]
          if reward and icon then
            icon.root.gameObject:SetActive(true)
            icon["$$SetData"](reward.type, reward.id, reward.count)
          else
            icon.root.gameObject:SetActive(false)
          end
        end
      end
      ConfigActivity()
    end
    UpdateTag()
  end
  m_owner = owner
end

function ConfigActivity()
  if m_data == nil then
    return
  end
  if m_data.giftType == PB.enum.GiftType.DailyRandomRefresh then
    m_targetTime = m_data.endTime
    return
  end
  local activityInfoList = DB:GetData("ActivityList")
  if activityInfoList then
    for i, v in ipairs(activityInfoList) do
      if v.type == PB.enum.ActivityType.Mall and m_data.activityId == v.activityId then
        local now = CS.GameTime.serverUtc
        if m_data.preheartTime then
          m_data.isPreheat = true
          m_targetTime = m_data.preheartTime
        elseif v.timestampPreheat and now > v.timestampPreheat and now < v.timestampStart then
          m_data.isPreheat = true
          m_targetTime = m_data.startTime
        else
          m_data.isPreheat = false
          if m_data.refreshTime then
            m_targetTime = m_data.refreshTime
          else
            m_targetTime = m_data.endTime
          end
        end
        return
      end
    end
  end
end

function UpdateTag()
  if m_data then
    local tagSprite
    if m_data.isPreheat then
      tagSprite = "Presale_bg"
    elseif m_data.isNewGift then
      tagSprite = "new_item_tag2"
    elseif m_data.isNew then
      tagSprite = "new_item_tag3"
    end
    REF.TagBg.UISprite.spriteName = tagSprite
    if tagSprite then
      REF.TagBg.UISprite:SnapWithoutScale()
    end
  end
end

function OnItemClick()
  if m_localedPrice == nil then
    WU.ShowHintText(WU.GetString("Purchase_NotAvaiable"))
  else
    WU.AcquireWindowAsync("PurchaseBuy", function(window)
      _ENV["$"](window)["$$SetData"](m_data)
    end)
  end
end
