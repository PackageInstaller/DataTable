local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local m_iapHandler = S:Get("IAPHandler")
local m_localedPrice, m_data, m_owner

function Awake()
  WU.BindButtonEvent(REF["$"], OnItemClick)
end

function IsSaleFinish()
  local maxBuyCount = m_data.data.maxBuyCount
  if m_data.data.productId ~= "" then
    local product = m_iapHandler.GetProductsByID(m_data.data.productId)
    if product then
      maxBuyCount = product.maxBuyCount
    end
  end
  if m_data.buyCount == nil then
    m_data.buyCount = 0
  end
  return maxBuyCount <= m_data.buyCount and 0 < maxBuyCount
end

function SetData(data, owner)
  if data ~= nil then
    m_data = data
    local dropInfo = m_data.rewardBuy
    if dropInfo then
      for i = 1, 3 do
        local rewardInfo = dropInfo[i]
        local labelTips = REF.ContainerOnce[i - 1]
        if rewardInfo then
          labelTips.root.gameObject:SetActive(true)
          local strTitle = WU.GetItemName(rewardInfo.id, rewardInfo.type)
          labelTips.root.UIHtmlLabel.text = strTitle
          local labelNum = REF[string.format("HtmlLabelOnceNum%d", i)]
          labelNum.UIHtmlLabel.text = "X" .. rewardInfo.count
        else
          local labelNum = REF[string.format("HtmlLabelOnceNum%d", i)]
          labelNum.gameObject:SetActive(false)
          labelTips.root.gameObject:SetActive(false)
        end
      end
    end
    dropInfo = m_data.rewardDaily
    for i = 1, 3 do
      local rewardInfo = dropInfo[i]
      local labelTips = REF.ContainerDaily[i - 1]
      local labelNum = REF[string.format("HtmlLabelDailyNum%d", i)]
      if rewardInfo then
        labelTips.root.gameObject:SetActive(true)
        local strTitle = WU.GetItemName(rewardInfo.id, rewardInfo.type)
        labelTips.root.UIHtmlLabel.text = strTitle
        labelNum.gameObject:SetActive(true)
        labelNum.UIHtmlLabel.text = "X" .. rewardInfo.count
      else
        labelTips.root.gameObject:SetActive(false)
        labelNum.gameObject:SetActive(false)
      end
    end
    if m_data.data and m_data.data.productId ~= "" then
      m_localedPrice = m_iapHandler.GetLocalizedPrice(m_data.data.productId)
    elseif m_data.data then
      m_localedPrice = m_data.data.price
    end
    REF.Price.UIHtmlLabel.text = m_localedPrice
  end
  local leftDay = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResMonthCardDays] .. "_0")
  UpdateLeftDay(leftDay)
  m_owner = owner
  if WU.IsPreCommit() then
    REF.SpriteSlotBG_1.UITexture.mainTexturePath = "Texture/Purchase/purchase_monthcard_apple"
    REF.SpriteTips2.gameObject:SetActive(false)
    REF.HtmlLabelDailyNum1.gameObject:SetActive(false)
    REF.HtmlLabelDailyNum2.gameObject:SetActive(false)
    REF.HtmlLabelDailyNum3.gameObject:SetActive(false)
    REF.ContainerDaily.gameObject:SetActive(false)
  end
end

function UpdateLeftDay(leftDay)
  if leftDay == nil then
    leftDay = 0
  end
  if leftDay <= 0 then
    REF.HtmlLabelLeftDay.gameObject:SetActive(false)
  else
    REF.HtmlLabelLeftDay.gameObject:SetActive(true)
    REF.HtmlLabelLeftDay.UIHtmlLabel.text = WU.GetString("Purchase_LeftDay", leftDay)
  end
end

function OnItemClick()
  if IsSaleFinish() == true then
    WU.ShowHintText(WU.GetString("Purchase_Error2"))
    return
  end
  if m_localedPrice == nil then
    WU.ShowHintText(WU.GetString("Purchase_NotAvaiable"))
  elseif m_data.data.productId ~= "" then
    WU.AcquireWindowAsync("PurchaseOrder", function(window)
      local data = m_iapHandler.GetProductsByID(m_data.data.productId)
      data.isMonthCard = true
      _ENV["$"](window)["$$SetData"](data)
    end)
  else
    local trade = {
      id = m_data.data.id
    }
    this:GameRequest("fci/mall-trade"):Post(trade, function(result)
      DBH.ResChange(result.resChange)
      WU.ShowRewards(result.resChange)
      for i, v in ipairs(result.resChange) do
        if v.baseRes.type == PB.enum.ResourceType.ResMonthCardDays then
          UpdateLeftDay(v.baseRes.count)
          this:BroadcastGameEvent("ResetNotification")
          break
        end
      end
      WU.RecycleWindow("PurchaseBuy")
    end)
  end
end
