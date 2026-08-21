local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local m_allAwards = {}
local m_cost, m_costCount, m_goods, m_resetPosition, m_shopInfo

function SetupWindow()
  if CS.GameGlobal.DoesDeviceHaveNotch() then
    REF.ScrollView.UIPanel.clipSoftness = CS.UnityEngine.Vector2(CS.UIRoot.LeftNotchWidth, 0)
  end
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.Black, function()
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
  m_resetPosition = true
  REF.ScrollView.gameObject:SetActive(false)
  m_shopInfo = this:GetData("fci/Shop/")
  local shopInfo
  if m_shopInfo then
    for i = 1, #m_shopInfo do
      if m_shopInfo[i].baseInfo.shopId == 20 then
        shopInfo = m_shopInfo[i]
        break
      end
    end
    if shopInfo then
      this:BindRemote(DB:GameRequest("fci/Shop/20/Goods/"), OnGoodsInfo)
      this:RegisterGameEvent("OnShopPurchaseSuccess", OnShopPurchaseSuccess)
      this:RegisterGameEvent("TryToBuyGoods", TryToBuyGoods)
      REF.LabelStock.ResourceChangeListener:AddListener(OnResourceChanged)
    else
      REF.NodeEmpty.gameObject:SetActive(true)
    end
  end
end

function OnGoodsItemShow(refRow, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if itemIndex > #m_goods then
    return
  end
  refRow["$$SetData"](wrapIndex, realIndex, m_goods[itemIndex], 20)
end

function OnGoodsInfo(goods)
  if goods then
    m_goods = goods
    m_cost = {
      type = goods[1].cost[1].type,
      id = goods[1].cost[1].id
    }
    m_costCount = this:GetData("fci/item/" .. m_cost.id).count
    table.sort(m_goods, function(a, b)
      return a.position < b.position
    end)
    LU.Bind(REF.WrapContent, {
      updateRow = OnGoodsItemShow
    })
    REF.ScrollView.gameObject:SetActive(true)
    LU.Set(REF.WrapContent, #m_goods, m_resetPosition)
    REF.LabelStock.ResourcePrinter:SetResource(m_cost.type, m_cost.id, m_costCount)
    REF.WrapContent.UIPlayTween:Play(true)
    REF.NodeEmpty.gameObject:SetActive(#goods == 0)
  end
end

function OnResourceChanged(type, id, count)
  m_cost.type = U.ToInt(type)
  m_cost.id = id
  m_costCount = count
end

function OnShopPurchaseSuccess(result)
  DBH.ResChange(result.resChange)
  this:DelayInvokeInFrames(1, function()
    WU.ShowRewards(result.resChange)
  end)
  m_resetPosition = false
  this:GameRequest("fci/Shop/20/Goods/"):Get(function(response)
    this:SetData("fci/Shop/20/Goods/", response)
  end)
end

function TryToBuyGoods(goodsInfo, index, buyCount, callback)
  local shopId = this:GetData("Shop/Id")
  if goodsInfo and shopId then
    local tryToPaySuccess = true
    local costs = goodsInfo.cost
    local lackResourceTypes = {}
    for i = 1, #costs do
      local cost = costs[i]
      WU.TryToPay(cost.type, cost.id, cost.count * buyCount, function()
      end, function()
        tryToPaySuccess = false
        table.insert(lackResourceTypes, cost.type)
      end)
    end
    if tryToPaySuccess then
      local trade = {
        info = goodsInfo,
        shopId = shopId,
        buyCount = buyCount,
        index = index
      }
      local wireFormatTable = ProtobufT("ApiShopTrade", trade)
      this:GameRequest("fci/ShopTrade"):Post(wireFormatTable, function(result)
        callback()
        this:BroadcastGameEvent("OnShopPurchaseSuccess", result)
      end)
    else
      do
        local lackGold = false
        local failedDesc = ""
        for i = 1, #lackResourceTypes do
          if lackResourceTypes[i] == PB.enum.ResourceType.ResPlayerGold then
            failedDesc = WU.GetString("WindowShopBuy_PurchaseFailedA") .. "\n"
            lackGold = true
          elseif lackResourceTypes[i] == PB.enum.ResourceType.ResPlayerMoney then
            failedDesc = WU.GetString("WindowShopBuy_PurchaseFailedB") .. "\n"
          else
            failedDesc = WU.GetString("WindowShopBuy_PurchaseFailedC") .. "\n"
          end
        end
        if lackGold == true then
          WU.ShowMessageYesNo(WU.GetString("Purchase_Tips8"), function(msg)
            if msg == "YES" then
              WU.Exchange(PB.enum.ResourceType.ResPlayerGold)
            end
          end)
        else
          callback()
          WU.ShowHintText(failedDesc)
        end
      end
    end
  end
end
