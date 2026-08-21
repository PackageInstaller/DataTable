local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local IU = require("Common/ItemUtil")
local RU = require("Common/RedMarkUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local GU = require("Common/GuildUtil")
local m_allShops, m_displayedShops, m_goods, m_currentShopId, m_targetShopId
local m_shopRefreshInfo = {}
local m_nextFreeRefreshTime
local m_refreshFreeTimes = {}
local m_refreshFreeInterval = 0
local m_currentShopIndex, m_selectedTab, m_initWindow
local m_EQUIP_SHOP_ID = 11
local m_activityShopClosed, m_guildId
local m_refreshLocked = false
local m_resetPosition = true
local m_cellHeigght = REF.TabWrapContent.UIWrapContent.itemSize
local m_scrollViewInitY = (REF.TabScrollView.UIPanel.finalClipRegion.w - REF.Visual.UIWidget.height) / 2

function SetupWindow()
  WU.BindButtonEvent(REF.NodeRefreshFree, function()
    WU.TryToRefresh(nil, nil, function()
      OnRefresh(true)
    end)
  end)
  WU.BindButtonEvent(REF.NodeRefresh, function()
    local nextRefreshCost = m_displayedShops[m_currentShopIndex].nextRefreshCost
    WU.TryToRefresh(nextRefreshCost.type, nextRefreshCost.count, function()
      OnRefresh(false)
    end)
  end)
  for i = 0, #REF.NodeMoney - 1 do
    WU.BindButtonEvent(REF.NodeMoney[i]["$"], OnShowMoneyMessage)
  end
  WU.BindButtonEvent(REF.ButtonQQSuperVip, function()
    if m_currentShopId then
      local qqSuperVipExtra = _ENV["$"](REF.ButtonQQSuperVip)["@extra"]
      if qqSuperVipExtra then
        WU.ShowHintText(WU.GetString("WindowShop_QQSuperVip_ExtraRefreshTimeHint", WU.GetString("WindowShop_ShopId_" .. m_currentShopId), qqSuperVipExtra))
      end
    end
  end)
  WU.BindButtonEvent(REF.ButtonNext, OnButtonNext)
  REF.TabScrollView.UIPanel:AddOnClipMoveListener(OnScrollViewMove)
end

function Focus(on)
  WU.RecordWindowFocus(100132, on)
end

function InitWindow()
  WU.ToggleRendering(REF.ShopScrollViewList, false)
  WU.ToggleRendering(REF.RightBottom, false)
  m_initWindow = true
  m_currentShopId = nil
  m_resetPosition = true
  this:Bind("guildId", OnGuildIdChange)
  this:Bind("fci/Shop/", OnShopInfo)
  this:RegisterGameEvent("TryToBuyGoods", TryToBuyGoods)
  this:RegisterGameEvent("OnShopPurchaseSuccess", OnShopPurchaseSuccess)
  this:Bind("fci/baseinfo", function(baseInfo)
    OnShopInfo(m_allShops)
  end, false)
  local itemList = this:GetData("fci/item/")
  local autoSellList = _ENV["!"](itemList):where(function(k, v)
    local itemInfo = PB.get("ItemInfo", v.id)
    if itemInfo == nil then
      warning("ItemInfo.xlsx", "can't find id : " .. tostring(v.id))
      return false
    end
    return itemInfo.saleable and itemInfo.autoTrade and v.count > 0
  end):toarray()
  if 0 < #autoSellList then
    WU.AcquireWindowAsync("AutoSell", function(window)
      _ENV["$"](window)["$$SetItemList"](autoSellList)
    end)
  end
  OnScrollViewMove()
  REF.FriendShipStore.gameObject:SetActive(false)
end

function UpdateWindow(delta)
  if m_displayedShops == nil then
    return
  end
  local shopShouldSync = false
  for i = 1, #m_displayedShops do
    local shopInfo = m_displayedShops[i]
    if not shopInfo.baseInfo.activity then
      local nextRefreshTime = shopInfo.nextRefreshTime
      if nextRefreshTime and nextRefreshTime ~= 0 and nextRefreshTime <= CS.GameTime.serverUtc and m_shopRefreshInfo[shopInfo.baseInfo.shopId] then
        shopShouldSync = true
        this:SetData("fci/Shop/" .. shopInfo.baseInfo.shopId .. "/Goods/", nil)
        m_shopRefreshInfo[shopInfo.baseInfo.shopId].refreshCount = 0
      end
      if m_currentShopId == shopInfo.baseInfo.shopId then
        REF.LabelCountdown.UIHtmlLabel.text = WU.RenderCountDownTime(nextRefreshTime - CS.GameTime.serverUtc, REF.LabelCountdown.UIHtmlLabel.fontSize)
        local free = m_nextFreeRefreshTime ~= nil and 0 < m_nextFreeRefreshTime and 0 >= m_nextFreeRefreshTime - CS.GameTime.serverUtc
        WU.ToggleRendering(REF.NodeRefreshFree, free)
        WU.ToggleRendering(REF.NodeRefresh, not free)
        WU.ToggleRendering(REF.LabelLeftRefreshCnt, not free)
        local qqSuperVipExtra = _ENV["$"](REF.ButtonQQSuperVip)["@extra"] or 0
        WU.ToggleRendering(REF.ButtonQQSuperVip, not free and 0 < qqSuperVipExtra)
      end
    else
      local endTime = shopInfo.endTime
      if m_currentShopId == shopInfo.baseInfo.shopId then
        REF.LabelTLCountdown.UIHtmlLabel.text = WU.RenderCountDownTime(endTime - CS.GameTime.serverUtc, REF.LabelTLCountdown.UIHtmlLabel.fontSize)
      end
      if endTime <= CS.GameTime.serverUtc then
        m_activityShopClosed = true
        shopShouldSync = true
      end
    end
  end
  if shopShouldSync then
    m_displayedShops = nil
    DB:SyncRemote(DB:GameRequest("fci/Shop/"))
    return
  end
end

function UpdateSlot(refRow, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if itemIndex > #m_goods then
    return
  end
  if m_currentShopId == 15 then
    REF.FriendShipStore["$SetData"](wrapIndex, realIndex, m_goods[itemIndex], m_currentShopId)
  else
    refRow["$$SetData"](wrapIndex, realIndex, m_goods[itemIndex], m_currentShopId)
  end
end

function UpdateTabSlot(refRow, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if itemIndex > #m_displayedShops then
    return
  end
  local shopInfo = m_displayedShops[itemIndex]
  local shopId = shopInfo.baseInfo.shopId
  refRow["@id"] = shopId
  refRow["@currentShopIndex"] = itemIndex
  refRow["$$SetTab"](WU.GetString("WindowShop_ShopId_" .. shopId), "Lobby", "store/store_" .. shopId, shopInfo.newShop)
  refRow["$$SetActivity"](shopInfo.baseInfo.activity, shopInfo.baseInfo.tipsType)
  refRow["$$SetClickCallback"](OnTabClick)
  refRow["$$TabSelected"](shopId == m_currentShopId)
end

function SetSelected(shopId)
  m_targetShopId = shopId
  if not m_initWindow then
    SwitchShop()
  end
end

function SwitchShop()
  local result = false
  if m_targetShopId then
    local index, _ = table.find(m_displayedShops, function(_, shop)
      return shop.baseInfo.shopId == m_targetShopId
    end)
    if index then
      local slotIndex = index - 1
      if slotIndex >= #REF.TabWrapContent then
        local offsetY = REF.TabWrapContent.UIWrapContent.itemSize * slotIndex - REF.TabScrollView.UIPanel.height
        REF.TabScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, offsetY, 0))
      end
      for i = 0, #REF.TabWrapContent do
        local slotRef = REF.TabWrapContent[i]
        if slotRef["@id"] == m_targetShopId then
          slotRef["$$SetSelected"]()
          result = true
          break
        end
      end
    end
    m_targetShopId = nil
  end
  return result
end

function OnTabClick(go, RECflag)
  local ref = _ENV["$"](go)
  if not RECflag then
    WU.RecordButtonClick(ref["@id"])
  end
  if ref["@id"] == U.GuildShopId and not GU.CheckFunctionCD("Window_GuildShopCD") then
    if m_selectedTab then
      _ENV["$"](m_selectedTab)["$$SetSelected"]()
    end
    return
  end
  if m_currentShopId ~= ref["@id"] then
    REF.FriendShipStore.gameObject:SetActive(ref["@id"] == 15)
    if m_currentShopId then
      this:Unbind("fci/Shop/" .. m_currentShopId .. "/Goods/", OnNormalShopInfo)
    end
    m_currentShopId = ref["@id"]
    m_currentShopIndex = ref["@currentShopIndex"]
    WU.ToggleRendering(REF.ShopScrollViewList, false)
    WU.ToggleRendering(REF.RightBottom, false)
    m_selectedTab = go
    if m_currentShopId then
      this:BindRemote(DB:GameRequest("fci/Shop/" .. m_currentShopId .. "/Goods/"), OnNormalShopInfo)
      if m_currentShopId == m_EQUIP_SHOP_ID then
        WU.SetRuleCallback("Shop", function()
          WU.AcquireWindowAsync("RuleShop", function(ui)
            _ENV["$"](ui)["$$SetShopId"](m_currentShopId)
          end)
        end)
      else
        WU.SetRuleCallback("Shop", nil)
      end
    end
  end
end

function OnGuildIdChange(guildId)
  if m_guildId ~= guildId then
    m_guildId = guildId
    if m_allShops then
      OnShopInfo(m_allShops)
    end
  end
end

function OnShopInfo(shops)
  if shops then
    table.sort(shops, function(a, b)
      if a.baseInfo.priority < b.baseInfo.priority then
        return true
      elseif a.baseInfo.priority > b.baseInfo.priority then
        return false
      else
        return a.baseInfo.shopId < b.baseInfo.shopId
      end
    end)
    m_allShops = shops
    local playerLevel = this:GetData("fci/baseinfo").level
    shops = _ENV["!"](shops):where(function(k, v)
      return playerLevel >= v.baseInfo.playerLevel
    end):toarray()
    local closedShops = table.select(shops, function(value)
      if value.endTime ~= 0 and 0 >= value.endTime - CS.GameTime.serverUtc or not value.baseInfo.clientShow then
        return value
      end
    end):toarray()
    local closedId = {}
    for k, v in pairs(closedShops) do
      closedId[v.baseInfo.shopId] = true
    end
    closedId[U.GuildShopId] = not m_guildId or m_guildId == 0
    for i = #shops, 1, -1 do
      if closedId[shops[i].baseInfo.shopId] then
        table.remove(shops, i)
      end
    end
    m_displayedShops = shops
    LU.Bind(REF.TabWrapContent, {
      updateRow = UpdateTabSlot
    })
    LU.Set(REF.TabWrapContent, #shops)
    local _, find = table.find(shops, function(_, v)
      return v.baseInfo.shopId == m_currentShopId
    end)
    if find ~= nil then
      DB:SyncRemote(DB:GameRequest("fci/Shop/" .. m_currentShopId .. "/Goods/"))
    end
    if m_initWindow or find == nil or m_activityShopClosed then
      m_initWindow = false
      m_activityShopClosed = false
      if not SwitchShop() then
        REF.TabWrapContent[0]["$$SetSelected"]()
      end
      REF.root.Animator:Play("DelayOpen", -1, 0)
    end
  end
end

function OnNormalShopInfo(goods)
  if goods then
    m_goods = goods
    table.sort(goods, function(a, b)
      return a.position < b.position
    end)
    local shop = m_displayedShops[m_currentShopIndex]
    local baseInfo = shop.baseInfo
    REF.HelpMsg.UILabel.text = WU.GetStringEmpty("Window_ShopHelpMsg_" .. baseInfo.shopId)
    REF.NodeActivity.gameObject:SetActive(baseInfo.activity)
    REF.NodeNotActivity.gameObject:SetActive(not baseInfo.activity)
    REF.NodeCountdown.gameObject:SetActive(shop.nextRefreshTime ~= 0)
    if m_shopRefreshInfo[m_currentShopId] == nil then
      m_shopRefreshInfo[m_currentShopId] = {
        refreshCount = shop.refreshCount or 0
      }
    end
    WU.ToggleRendering(REF.NodeLeftRefreshCnt, 0 < baseInfo.refreshLimit - m_shopRefreshInfo[m_currentShopId].refreshCount)
    REF.LabelLeftRefreshCnt.UIHtmlLabel.text = WU.GetString("WindowShop_LeftRefreshCount", baseInfo.refreshLimit - m_shopRefreshInfo[m_currentShopId].refreshCount)
    _ENV["$"](REF.ButtonQQSuperVip)["@extra"] = baseInfo.vipSuperExtraCount
    if m_refreshFreeTimes[m_currentShopId] ~= nil then
      m_nextFreeRefreshTime = m_refreshFreeTimes[m_currentShopId]
    else
      m_nextFreeRefreshTime = shop.nextFreeRefreshTime
    end
    m_refreshFreeInterval = shop.baseInfo.refreshFree
    local canRefresh = m_shopRefreshInfo[m_currentShopId].refreshCount < baseInfo.refreshLimit and shop.nextRefreshCost ~= nil
    WU.ToggleRendering(REF.Refresh, canRefresh)
    if canRefresh then
      REF.LabelRefreshCost.ResourcePrinter:SetResource(shop.nextRefreshCost.type, shop.nextRefreshCost.id, shop.nextRefreshCost.count)
    end
    SetShopMoney(baseInfo)
    LU.Bind(REF.ShopWrapContentNormal, {
      updateRow = UpdateSlot
    })
    LU.Set(REF.ShopWrapContentNormal, #goods, m_resetPosition)
    m_resetPosition = true
    WU.ToggleRendering(REF.ShopScrollViewList, m_currentShopId ~= 15)
    WU.ToggleRendering(REF.RightBottom, true)
    WU.ToggleRendering(REF.NodeCommon, m_currentShopId ~= 15)
    REF.ShopWrapContentNormal.UIPlayTween:Play(true)
    REF.NodeEmpty.gameObject:SetActive(#goods == 0)
    if shop.newShop then
      this:GameRequest("fci/Shop/" .. m_currentShopId):Patch({new_shop = false}, function()
        shop.newShop = false
        _ENV["$"](m_selectedTab)["$$SetNew"](false)
        if shop.endTime ~= 0 then
          RU.SetRedMark("Shop", false)
        end
      end)
    end
  end
end

function OnRefresh(free)
  if m_refreshLocked then
    return
  end
  local shopInfo = m_displayedShops[m_currentShopIndex]
  local nextRefreshCost = shopInfo.nextRefreshCost
  local costCount = nextRefreshCost.count
  if free then
    costCount = 0
  end
  WU.TryToPay(nextRefreshCost.type, nextRefreshCost.id, costCount, function()
    m_refreshLocked = true
    this:GameRequest("fci/Shop/" .. m_currentShopId .. "/Goods/"):Post({refresh_free = free}, function(result)
      DBH.ResChange(result.resChange)
      if not free then
        m_shopRefreshInfo[m_currentShopId].refreshCount = result.refreshCount
        shopInfo.refreshCount = result.refreshCount
      else
        m_refreshFreeTimes[m_currentShopId] = result.refreshTimeFree + m_refreshFreeInterval
        shopInfo.nextFreeRefreshTime = m_refreshFreeTimes[m_currentShopId]
      end
      this:SetData("fci/Shop/" .. m_currentShopId .. "/Goods/", result.info)
      m_refreshLocked = false
    end, function()
      m_refreshLocked = false
    end)
  end)
end

function OnShowMoneyMessage(go)
  local cost = _ENV["$"](go)["@cost"]
  WU.ShowResourceDetail(cost.type, cost.id)
end

function OnShopPurchaseSuccess(result)
  DBH.ResChange(result.resChange)
  this:DelayInvokeInFrames(1, function()
    WU.ShowRewards(result.resChange)
    ShowAutoOpenProfitMessageBox(result)
  end)
  m_resetPosition = false
  this:GameRequest("fci/Shop/" .. m_currentShopId .. "/Goods/"):Get(function(response)
    this:SetData("fci/Shop/" .. m_currentShopId .. "/Goods/", response)
  end)
end

function OnShopPurchaseSuccess(result)
  DBH.ResChange(result.resChange)
  this:DelayInvokeInFrames(1, function()
    local haveProfit = ShowAutoOpenProfitMessageBox(result)
    if not haveProfit then
      WU.ShowRewards(result.resChange)
    end
  end)
  m_resetPosition = false
  this:GameRequest("fci/Shop/" .. m_currentShopId .. "/Goods/"):Get(function(response)
    this:SetData("fci/Shop/" .. m_currentShopId .. "/Goods/", response)
  end)
end

function ShowAutoOpenProfitMessageBox(result)
  if result ~= nil and result.info ~= nil and result.info.good ~= nil and result.info.good.id ~= nil then
    local itemInfo = PB.get("ItemInfo", result.info.good.id)
    local buffIds = {}
    if itemInfo and itemInfo.funcType and itemInfo.funcType == PB.enum.ItemFuncType.AutoProfit then
      for k, v in ipairs(result.resChange) do
        if v.baseRes ~= nil and v.baseRes.type == PB.enum.ResourceType.ResProfit then
          table.insert(buffIds, v.baseRes.id)
        end
      end
    end
    if #buffIds ~= 0 then
      WU.AcquireWindowAsync("AutoOpenProfitMessageBox", function(window)
        _ENV["$"](window)["$$SetBuffIds"](buffIds)
      end)
      return true
    end
  end
  return false
end

function SetShopMoney(baseInfo)
  local costs = baseInfo.displayCost
  for i = 1, #REF.NodeMoney do
    local ref = REF.NodeMoney[i - 1]
    ref["$gameObject"]:SetActive(i <= #costs)
    if i <= #costs then
      local cost = costs[i]
      ref.LabelMoney.ResourcePrinter:SetResource(cost.type, cost.id)
      ref["@cost"] = cost
    end
  end
end

function TryToBuyGoods(goodsInfo, index, buyCount, callback)
  local shopId = this:GetData("Shop/Id")
  if goodsInfo and shopId then
    local costs = goodsInfo.cost
    local lackResourceTypes = {}
    local resultList = _ENV["!"]({})
    
    local function _callback()
      if #costs == #resultList then
        if resultList:has(false) then
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
            if string.len(failedDesc) ~= 0 then
              WU.ShowHintText(failedDesc)
            end
          end
        else
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
        end
      end
    end
    
    for i = 1, #costs do
      local cost = costs[i]
      WU.TryToPay(cost.type, cost.id, cost.count * buyCount, function()
        table.insert(resultList, true)
        _callback()
      end, function()
        table.insert(lackResourceTypes, cost.type)
        table.insert(resultList, false)
        _callback()
      end)
    end
  end
end

function OnScrollViewMove()
  local showButton = false
  if m_displayedShops then
    local entryBottomHeight = (#m_displayedShops - 1) * m_cellHeigght + REF.Visual.UIWidget.height
    local scrollViewOffsetY = REF.TabScrollView.transform.localPosition.y - m_scrollViewInitY
    local entryOffsetYFromViewTop = entryBottomHeight - scrollViewOffsetY
    showButton = entryOffsetYFromViewTop > REF.TabScrollView.UIPanel.finalClipRegion.w
  end
  WU.SetActive(REF.ButtonNext, showButton)
end

function OnButtonNext()
  local entryBottomHeight = (NextTabIndex() - 1) * m_cellHeigght + REF.Visual.UIWidget.height
  local newOffsetY = entryBottomHeight - REF.TabScrollView.UIPanel.finalClipRegion.w + m_scrollViewInitY
  local offset = CS.UnityEngine.Vector3(0, newOffsetY - REF.TabScrollView.transform.localPosition.y, 0)
  REF.TabScrollView.UIScrollView:SpringRelative(offset, 20)
end

function NextTabIndex()
  local visibleContentHeight = REF.TabScrollView.transform.localPosition.y - m_scrollViewInitY + REF.TabScrollView.UIPanel.finalClipRegion.w
  local bottomDataIndex = math.floor((visibleContentHeight - REF.Visual.UIWidget.height) / m_cellHeigght) + 1
  local index = 0
  for i, shop in ipairs(m_displayedShops) do
    index = i
    if shop.newShop and bottomDataIndex < index then
      break
    end
  end
  return index
end
