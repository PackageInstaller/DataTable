local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local U = require("Common/Util")
local EA = require("Common/EquipAttr")
local IU = require("Common/ItemUtil")
local S = require("Common/Singleton")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local m_iapHandler = S:Get("IAPHandler")
local m_data, m_dropInfo
local m_bIsBuyOver = false
local m_rootRef, m_targetTime, m_eventUid, m_gots

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnButtonConfirm)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
  LU.Bind(REF.PreviewContent, {
    updateRow = UpdateWidget
  })
  WU.BindButtonEvent(REF.ButtonConfirm1, OnButtonConfirm)
  WU.BindButtonEvent(REF.ButtonCancel1, OnCancelClick)
  LU.Bind(REF.FirstContent, {
    updateRow = UpdateWidget
  })
  LU.Bind(REF.SecondContent, {
    updateRow = UpdateDelayReward
  })
end

function PopulateLineFrame(isSingleLine)
  REF.DialogBG.gameObject:SetActive(isSingleLine)
  REF.Content.gameObject:SetActive(isSingleLine)
  REF.MultiDialogBG.gameObject:SetActive(not isSingleLine)
  REF.MultiContent.gameObject:SetActive(not isSingleLine)
end

function UpdateWindow()
  if m_rootRef and m_data and m_targetTime then
    local remainTime = m_targetTime - CS.GameTime.serverUtc
    if m_rootRef.LabelTimeCountdown then
      local timeString = WU.RenderCountdownTimeNotUrgent(remainTime, "#3599e9")
      m_rootRef.LabelTimeCountdown.UIHtmlLabel.text = WU.GetString("Purchase_Time_Preheat", timeString)
      m_rootRef.LabelTimeCountdown.gameObject:SetActive(true)
    end
    if remainTime < 0 then
      this:BroadcastGameEvent("UpdateMallData")
    end
  else
    UpdateBottom()
  end
end

function InitWindow()
  REF.DialogBG.gameObject:SetActive(true)
  REF.Content.gameObject:SetActive(true)
  REF.MultiDialogBG.gameObject:SetActive(true)
  REF.MultiContent.gameObject:SetActive(true)
end

function UpdateLabelCount()
  local restNumber = m_data.maxBuyCount - m_data.buyCount
  local strCnt
  if m_data.maxCountClearInterval == PB.enum.MallBuyIntervalType.Day then
    strCnt = WU.GetString("Purchase_DayBuylab")
  elseif m_data.maxCountClearInterval == PB.enum.MallBuyIntervalType.Week then
    strCnt = WU.GetString("Purchase_WeekBuylab")
  elseif m_data.maxCountClearInterval == PB.enum.MallBuyIntervalType.Month then
    strCnt = WU.GetString("Purchase_MonthBuylab")
  end
  if REF.LabelLimitCount then
    if 0 < restNumber then
      REF.LimitCount.gameObject:SetActive(true)
      REF.LabelLimitCount.UILabel.text = tostring(restNumber)
      if strCnt then
        _ENV["$"](REF.LimitCount).Label.UIHtmlLabel.text = strCnt
      else
        _ENV["$"](REF.LimitCount).Label.UIHtmlLabel.text = WU.GetString("Purchase_Rest_Time")
      end
    else
      REF.LimitCount.gameObject:SetActive(false)
    end
  end
end

function SetData(data, eventId)
  local cornerTitle = WU.GetString("Purchase_SubTitle")
  local itemInfo = PB.get("ItemInfo", data.reward[1].id)
  if itemInfo ~= nil and itemInfo.funcType == PB.enum.ItemFuncType.DrawBox then
    cornerTitle = WU.GetString("Purchase_DrawBox")
    if data.randomItems == nil then
      data.randomItems = {}
      local itemIds = PB.all("DrawBox")
      for j = 1, #itemIds do
        if itemIds[j].itemId == data.reward[1].id then
          local reward = {}
          reward.type = itemIds[j].drawBoxRes.type
          reward.id = itemIds[j].drawBoxRes.id
          reward.count = itemIds[j].drawBoxRes.count
          reward.prarm = itemIds[j].drawBoxRes.param
          table.insert(data.randomItems, reward)
        end
      end
    end
    this:GameRequest("fci/item-drawbox/" .. data.reward[1].id .. "/"):Get(function(result)
      m_gots = result.gotIndex
      LU.Set(REF.PreviewContent, #data.randomItems)
    end)
  else
    m_gots = nil
  end
  REF.CornerBg.UISprite.width = #cornerTitle * 16
  REF.CornerTitle.UILabel.text = cornerTitle
  m_data = data
  m_eventUid = eventId
  if m_data.buyCount and m_data.buyCount >= m_data.maxBuyCount and m_data.maxBuyCount > 0 then
    m_bIsBuyOver = true
  else
    m_bIsBuyOver = false
  end
  if m_data.productId ~= "" then
    local product = m_iapHandler.GetProductsByID(m_data.productId)
    if product then
      m_dropInfo = product.purchaseRes
    else
      m_dropInfo = {}
    end
  elseif itemInfo ~= nil and itemInfo.funcType == PB.enum.ItemFuncType.DrawBox then
    m_dropInfo = m_data.randomItems
  else
    m_dropInfo = m_data.reward
  end
  m_dropInfo = _ENV["!"](m_dropInfo):duplicate()
  local i, delayInfo = m_dropInfo:find(function(k, v)
    return v.type == PB.enum.ResourceType.ResDelayReward
  end)
  if delayInfo ~= nil then
    table.remove(m_dropInfo, i)
  end
  local delayReward = PB.get("DelayReward", m_data.activityId)
  if delayReward == nil and delayInfo ~= nil then
    PB.get("DelayReward", delayInfo.id)
  end
  if m_data.isDelay and delayReward then
    LU.Set(REF.FirstContent, #m_dropInfo, true)
    LU.Set(REF.SecondContent, #delayReward.delayReward, true)
    REF.CornerSubTitle.UILabel.text = WU.GetString("Purchase_SubTitle_Delay", m_data.sustainedDays)
  else
    LU.Set(REF.PreviewContent, #m_dropInfo, true)
  end
  PopulateLineFrame(not m_data.isDelay)
  local allMoney = this:GetData("fci/resource/ResPlayerMoney_0") or 0
  local payMoney = this:GetData("fci/resource/ResPlayerPayMoney_0") or 0
  local rootRef = _ENV["$"](REF.Content)
  if m_data.isDelay then
    rootRef = _ENV["$"](REF.MultiContent)
  end
  m_rootRef = rootRef
  if m_data.preheartTime then
    m_targetTime = m_data.preheartTime
  else
    m_targetTime = m_data.startTime
  end
  local strTitle = string.format("MALL_GIFT_NAME%d", m_data.id)
  strTitle = WU.GetString(strTitle)
  rootRef.LabelDescribeTitle.UIHtmlLabel.text = strTitle
  rootRef.CoinCost.gameObject:SetActive(false)
  rootRef.GridCost.gameObject:SetActive(true)
  rootRef.LabelPrice.gameObject:SetActive(false)
  UpdateLabelCount()
  if data.productId ~= "" then
    rootRef.GridCost.gameObject:SetActive(false)
    rootRef.LabelPrice.gameObject:SetActive(true)
    rootRef.LabelPrice.UIHtmlLabel.text = m_iapHandler.GetLocalizedPrice(m_data.productId)
  elseif m_data.resourceType == PB.enum.ResourceType.ResPlayerPayMoney then
    rootRef.NoBindCost.gameObject:SetActive(true)
    rootRef.BindCost.gameObject:SetActive(false)
    if payMoney < m_data.price then
      rootRef.LabelCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(4250162431)
    else
      rootRef.LabelCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(995593215)
    end
    rootRef.LabelCost.UIHtmlLabel.text = tostring(m_data.price)
  elseif m_bIsBuyOver == true then
    if m_data.resourceType == PB.enum.ResourceType.ResPlayerMoney then
      rootRef.NoBindCost.gameObject:SetActive(false)
      rootRef.BindCost.gameObject:SetActive(true)
      rootRef.LabelBindCost.UIHtmlLabel.text = tostring(m_data.price)
    else
      rootRef.NoBindCost.gameObject:SetActive(false)
      rootRef.BindCost.gameObject:SetActive(false)
      rootRef.CoinCost.gameObject:SetActive(true)
      rootRef.LabelCoinCost.UIHtmlLabel.text = tostring(m_data.price)
    end
  else
    local isEnough, bindCost, noBindCost
    if m_data.resourceType == PB.enum.ResourceType.ResPlayerMoney then
      isEnough, bindCost, noBindCost = WU.IsEnoughMoney(m_data.price, m_data.resourceType)
      if isEnough == true and 0 < noBindCost then
        rootRef.NoBindCost.gameObject:SetActive(true)
        rootRef.BindCost.gameObject:SetActive(true)
      else
        rootRef.NoBindCost.gameObject:SetActive(false)
        rootRef.BindCost.gameObject:SetActive(true)
      end
      rootRef.LabelCost.UIHtmlLabel.text = tostring(noBindCost)
      rootRef.LabelBindCost.UIHtmlLabel.text = tostring(bindCost)
      if isEnough == false then
        rootRef.LabelBindCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(4278190335)
        rootRef.LabelCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(4278190335)
      else
        rootRef.LabelBindCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(995593215)
        rootRef.LabelCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(995593215)
      end
    else
      do
        local function updateCost()
          local stockCount = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[m_data.resourceType] .. "_0")
          
          isEnough = stockCount >= m_data.price
          rootRef.NoBindCost.gameObject:SetActive(false)
          rootRef.BindCost.gameObject:SetActive(false)
          rootRef.CoinCost.gameObject:SetActive(true)
          rootRef.LabelCoinCost.UIHtmlLabel.text = tostring(m_data.price)
          if isEnough == false then
            rootRef.LabelCoinCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(4278190335)
          else
            rootRef.LabelCoinCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(995593215)
          end
        end
        
        this:Bind("fci/resource/" .. PB.enum.ResourceType.__keys[m_data.resourceType] .. "_0", function()
          updateCost()
        end)
      end
    end
  end
  rootRef.GridCost.UIGrid:Reposition()
  if m_bIsBuyOver == true then
    REF.ButtonCancel.gameObject:SetActive(false)
    REF.ButtonConfirm.gameObject:SetActive(false)
  else
    REF.ButtonCancel.gameObject:SetActive(true)
    REF.ButtonConfirm.gameObject:SetActive(true)
  end
  UpdateBottom()
end

function NeedClose()
  if m_data.maxBuyCount - m_data.buyCount <= 0 then
    return true
  end
  return false
end

function OnButtonConfirm()
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
          this:BroadcastGameEvent("UpdateSale", m_data.id, result.buyCount)
          local itemInfo = PB.get("ItemInfo", m_data.reward[1].id)
          if itemInfo ~= nil and itemInfo.funcType == PB.enum.ItemFuncType.DrawBox then
            for i = 1, #result.resChange do
              if result.resChange[i].baseRes.id ~= 0 then
                this:GameRequest("fci/itemuse/"):Post({
                  id = result.resChange[i].baseRes.id,
                  count = 1
                }, function(result)
                  DBH.ResChange(result.resChange)
                  WU.ShowRewards(result.resChange, function()
                    WU.RecycleWindow(this)
                  end)
                end)
              end
            end
          else
            WU.ShowRewards(result.resChange)
          end
          if NeedClose() then
            if itemInfo ~= nil and itemInfo.funcType ~= PB.enum.ItemFuncType.DrawBox then
              WU.RecycleWindow(this)
            end
          else
            UpdateLabelCount()
          end
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
          this:BroadcastGameEvent("UpdateSale", m_data.id, result.buyCount)
          WU.ShowRewards(result.resChange)
          if NeedClose() then
            WU.RecycleWindow(this)
          else
            UpdateLabelCount()
          end
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

function OnCancelClick()
  WU.RecycleWindow(this)
end

function PopulateSlotWithData(refRow, rewardInfo, realIndex)
  refRow["$$SetData"](rewardInfo.type, rewardInfo.id, fif(rewardInfo.count == 0, "?", rewardInfo.count))
  if rewardInfo.type == PB.enum.ResourceType.ResActor then
    local actorQuality, actorStar = AU.CheckActorStarRandom(rewardInfo.id, rewardInfo.param)
    rewardInfo.quality = actorQuality
    refRow["$$SetActorCustom"]({
      id = rewardInfo.id,
      quality = actorQuality
    })
  end
  if m_gots ~= nil then
    for i = 1, #m_gots do
      if m_gots[i] == realIndex then
        refRow["$$SetTips"]("received")
        break
      end
    end
  end
end

function UpdateWidget(refRow, wrapIndex, realIndex)
  if m_data then
    local rewardInfo = m_dropInfo[realIndex + 1]
    if rewardInfo then
      PopulateSlotWithData(refRow, rewardInfo, realIndex)
      return
    end
  end
  refRow["$$ClearSlot"]()
end

function UpdateDelayReward(refRow, wrapIndex, realIndex)
  if m_data then
    local delayReward = PB.get("DelayReward", m_data.activityId)
    if delayReward then
      local rewardInfo = delayReward.delayReward[realIndex + 1]
      if rewardInfo then
        PopulateSlotWithData(refRow, rewardInfo, realIndex)
        refRow["$$SetData"](rewardInfo.type, rewardInfo.id, fif(rewardInfo.count == 0, "?", rewardInfo.count))
        return
      end
    end
  end
  refRow["$$ClearSlot"]()
end

function UpdateBottom()
  if m_data and m_rootRef then
    local showBottomNormal = false
    local showBottomSellout = false
    local showBottomPreheat = false
    if m_data.isPreheat then
      showBottomPreheat = true
    elseif m_data.buyCount >= m_data.maxBuyCount and m_data.maxBuyCount > 0 then
      showBottomSellout = true
      m_targetTime = nil
    else
      showBottomNormal = true
      m_targetTime = nil
    end
    m_rootRef.BottomNormal.gameObject:SetActive(showBottomNormal)
    m_rootRef.BottomSellOut.gameObject:SetActive(showBottomSellout)
    m_rootRef.BottomPreheat.gameObject:SetActive(showBottomPreheat)
    local restNumber = m_data.maxBuyCount - m_data.buyCount
    if m_rootRef.LimitCount then
      if m_data.isPreheat or restNumber <= 1 or showBottomSellout then
        m_rootRef.LimitCount.gameObject:SetActive(false)
      else
        m_rootRef.LimitCount.gameObject:SetActive(true)
      end
    end
  end
end
