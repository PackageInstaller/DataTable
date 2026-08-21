local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local SDU = require("Common/SoundUtil")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local m_data = {}
local m_activityId, m_shopGoods, m_showOne, m_resetPosition

function Awake()
  WU.TraverseChildren(REF.MyMoney, function(go)
    WU.BindButtonEvent(go, OnShowMoneyMessage)
  end)
  WU.TraverseChildren(REF.WrapContentOne, function(go)
    WU.TraverseChildren(_ENV["$"](go).root, function(button)
      WU.BindButtonEvent(_ENV["$"](button).ButtonExchange, OnSlotClickCallback)
    end)
  end)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
  LU.Bind(REF.WrapContentOne, {
    dataSource = function(dataIndex)
      return m_shopGoods and m_shopGoods.buyRecords and m_shopGoods.buyRecords[dataIndex]
    end,
    updateSlot = UpdateSlot,
    delta = 0.01
  })
end

function OnEnable()
  local wlfName = this:GetData("WelfareTab")
  m_activityId = PB.get("WelfareConfig", wlfName).relatedActivityIds[1]
  m_resetPosition = true
  WU.SetActive(REF.ShopListMore, false)
  WU.SetActive(REF.ShopListOne, false)
  WU.ToggleRendering(REF.ShopListMore, false)
  WU.ToggleRendering(REF.ShopListOne, false)
  SetView()
  this:BindRemote(this:GameRequest("fci/exchange-shop-goods/" .. m_activityId .. "/"), OnShopGoods)
end

function SetView()
  local activity = m_activityManager.GetActivitySync(PB.enum.ActivityType.ExchangeShop, m_activityId)
  if activity then
    local startTime = CS.GameTime.UtcToLocal(activity.timestampStart)
    local endTime = CS.GameTime.UtcToLocal(activity.timestampEnd)
    local closeTime = CS.GameTime.UtcToLocal(activity.timestampClose)
    local startStr = WU.GetString("Window_Month_Day_Hour", startTime.Month, startTime.Day, fif(startTime.Minute == 59, startTime.Hour + 1, startTime.Hour))
    local endStr = WU.GetString("Window_Month_Day_Hour", endTime.Month, endTime.Day, fif(endTime.Minute == 59, endTime.Hour + 1, endTime.Hour))
    local closeDay = closeTime.Day
    REF.LabelTime.UILabel.text = WU.GetString("PropExchange_ActivityTime", startStr, endStr, closeDay)
  end
  local costs = PB.get("ExchangeShopCosts", m_activityId).cost
  for i = 0, #REF.MyMoney - 1 do
    local ref = REF.MyMoney[i]
    local cost = costs[i + 1]
    WU.SetActive(ref.root, cost)
    if cost then
      ref.LabelMoney.ResourcePrinter:SetResource(cost.type, cost.id)
      ref["@cost"] = cost
    end
  end
  REF.MyMoney.UIGrid.cellWidth = REF.MyMoney.UIWidget.width / #costs
  REF.MyMoney.UIGrid:Reposition()
end

function OnDisable()
  this:Unbind("fci/exchange-shop-goods/" .. m_activityId .. "/", OnShopGoods)
  this:SetData("fci/exchange-shop-goods/" .. m_activityId .. "/", nil)
end

function OnShopGoods(shopGoods)
  if shopGoods then
    for i = 1, #shopGoods.buyRecords do
      local record = shopGoods.buyRecords[i]
      local goodConfig = PB.get("ExchangeShopGoods", record.goodId)
      record.runOut = record.buyCount >= goodConfig.buyLimit
    end
    table.sort(shopGoods.buyRecords, function(a, b)
      if a.runOut == b.runOut then
        return a.goodId < b.goodId
      else
        return b.runOut
      end
    end)
    m_shopGoods = shopGoods
    local exchangeInfo = PB.get("ExchangeShopGoods", shopGoods.buyRecords[1].goodId)
    local goodCount = #exchangeInfo.good
    m_showOne = goodCount == 1
    WU.SetActive(REF.ShopListMore, not m_showOne)
    WU.SetActive(REF.ShopListOne, m_showOne)
    local wrapContent = fif(m_showOne, REF.WrapContentOne, REF.WrapContent)
    local count = #m_shopGoods.buyRecords
    if m_showOne then
      count = math.ceil(count / #wrapContent[0].root)
    end
    LU.Set(wrapContent, count, m_resetPosition)
    m_resetPosition = false
    local shopList = fif(m_showOne, REF.ShopListOne, REF.ShopListMore)
    WU.ToggleRendering(shopList, true)
  end
end

function UpdateRow(slotRef, wrapIndex, realIndex)
  local index = realIndex + 1
  if m_shopGoods == nil or index > #m_shopGoods.buyRecords then
    return
  end
  local buyRecord = m_shopGoods.buyRecords[index]
  local exchangeInfo = PB.get("ExchangeShopGoods", buyRecord.goodId)
  slotRef["@exchangeInfo"] = exchangeInfo
  slotRef["$$SetView"](exchangeInfo, buyRecord.buyCount)
  slotRef["$$SetClickCallback"](OnSlotClickCallback)
end

function UpdateSlot(slotRef, record)
  WU.SetActive(slotRef.root, record)
  local btnRef = _ENV["$"](slotRef.ButtonExchange)
  if record then
    btnRef["@record"] = record
    local exchangeInfo = PB.get("ExchangeShopGoods", record.goodId)
    btnRef["@exchangeInfo"] = exchangeInfo
    local good = exchangeInfo.good[1]
    slotRef.WidgetIconSlot["$ResetState"]()
    slotRef.WidgetIconSlot["$SetData"](good.type, good.id, good.count)
    local cost = exchangeInfo.cost[1]
    slotRef.LabelMoney.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
    slotRef.LabelTimes.UILabel.text = WU.GetString("Window_ExchangeRatio", exchangeInfo.buyLimit - record.buyCount, exchangeInfo.buyLimit)
    if record.runOut then
      slotRef.Container.UIWidget.alpha = 0.6
      slotRef.WidgetIconSlot["$SetTips"]("soldOut")
    else
      slotRef.Container.UIWidget.alpha = 1
    end
  end
end

function OnSlotClickCallback(go)
  local ref = _ENV["$"](go)
  WU.AcquireWindowAsync("PropExchangeConfirm", function(window)
    local data = this:GetData("fci/exchange-shop-goods/" .. m_activityId .. "/")
    local _, record = table.find(data.buyRecords, function(k, v)
      return v.goodId == ref["@exchangeInfo"].goodId
    end)
    _ENV["$"](window)["$$SetView"](ref["@exchangeInfo"], record.buyCount)
    _ENV["$"](window)["$$SetCallback"](function(msg, num)
      if msg == "YES" then
        DB:GameRequest("fci/exchange-shop-goods/buy"):Post({
          goodId = ref["@exchangeInfo"].goodId,
          buyCount = num
        }, function(res)
          DBH.ResChange(res.resChange)
          if record then
            record.buyCount = record.buyCount + num
          end
          this:SetData("fci/exchange-shop-goods/" .. m_activityId .. "/", data)
          this:DelayInvokeInFrames(1, function()
            WU.ShowRewards(res.resChange)
          end)
        end)
      end
    end)
  end)
end

function OnShowMoneyMessage(go)
  local cost = _ENV["$"](go)["@cost"]
  if cost ~= nil then
    WU.ShowResourceDetail(cost.type, cost.id)
  end
end
