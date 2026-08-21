local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local U = require("Common/Util")
local EA = require("Common/EquipAttr")
local m_goods, m_shopId
local m_buyCount = 1
local m_maxAmount = 0
local m_limit = 0
local m_min = 1

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnButtonConfirm)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
  REF.WidgetNumberEdit["$SetNumberUpdateCallback"](OnAmountChange)
  REF.WidgetNumberEdit["$SetShowMax"](true)
end

function InitWindow()
  m_shopId = this:GetData("Shop/Id")
  m_goods = this:GetData("Shop/Goods")
  WU.TraverseChildren(REF.SpriteCostBG, function(go)
    go:SetActive(false)
  end)
  WU.TraverseChildren(REF.SpriteCostBG2, function(go)
    go:SetActive(false)
  end)
  SetData()
end

function SetData()
  if m_goods then
    local iconDetail = m_goods.good
    REF.WidgetIconSlot["$SetData"](iconDetail.type, iconDetail.id, iconDetail.count)
    REF.WidgetIconSlot["$SetClickCallback"](function()
    end)
    local costs = m_goods.cost
    if costs[1].type == PB.enum.ResourceType.ResPlayerMoney then
      REF.WidgetIconCost["$SetData"](costs[1].count, costs[1].type)
      REF.WidgetIconCost.gameObject:SetActive(true)
    else
      REF.WidgetIconCost.gameObject:SetActive(false)
      for i = 1, #costs do
        REF["LabelCost" .. i].gameObject:SetActive(true)
        REF["LabelCost" .. i].ResourcePrinter:SetResource(costs[i].type, costs[i].id, costs[i].count)
      end
    end
    REF.SpriteCostBG.UIGrid:Reposition()
    REF.LabelDetail.gameObject:SetActive(false)
    REF.WidgetEquipAttrTable.gameObject:SetActive(false)
    REF.LabelDescribe.gameObject:SetActive(false)
    WU.SetActive(REF.WidgetSkinDetail, false)
    WU.SetActive(REF.DescribeSVNode, true)
    WU.SetActive(REF.DescribeArmNode, false)
    WU.SetActive(REF.LabelPossess, true)
    WU.SetActive(REF.NodeCountChanger, true)
    if iconDetail.type == PB.enum.ResourceType.ResItem then
      local title = WU.GetString("ItemName_" .. iconDetail.id) .. " x" .. iconDetail.count
      REF.LabelDescribe.UIHtmlLabel.text = WU.GetString("WindowShopBuy_ItemDesc", title, WU.GetItemDesc(iconDetail.id))
      REF.LabelDescribe.gameObject:SetActive(true)
    elseif iconDetail.type == PB.enum.ResourceType.ResEquip then
      local fakeEquip = {
        id = iconDetail.id,
        randAttrIndex = 0,
        randAttrValueIndex = 0,
        level = 1
      }
      REF.LabelDetail.gameObject:SetActive(true)
      REF.WidgetEquipAttrTable.gameObject:SetActive(true)
      local equipAttr = EA.GetEquipAttr(fakeEquip)
      REF.LabelDetail.UIHtmlLabel.text = EA.GetEquipDetails(iconDetail.id)
      REF.WidgetEquipAttrTable["$SetEquipAttr"](equipAttr)
    elseif iconDetail.type == PB.enum.ResourceType.ResActorSkin then
      WU.SetActive(REF.WidgetSkinDetail, true)
      REF.WidgetSkinDetail["$SetDataBySkinId"](iconDetail.id)
      WU.SetActive(REF.LabelPossess, true)
    elseif iconDetail.type == PB.enum.ResourceType.ResPlayerHeadFrame then
      REF.LabelDescribe.UIHtmlLabel.text = "<font size=46>" .. WU.GetString("PlayerHeadFrameName_" .. iconDetail.id) .. "</font><br><br>" .. WU.GetString("PlayerHeadFrameDesc_" .. iconDetail.id)
      WU.SetActive(REF.LabelPossess, false)
      REF.LabelDescribe.gameObject:SetActive(true)
    elseif iconDetail.type == PB.enum.ResourceType.ResUniqueWeapon then
      local armInfo = PB.get("UniqueWeaponInfo", iconDetail.id)
      if armInfo == nil then
        error("UniqueWeaponInfo.xlsx has no this id " .. iconDetail.id)
        return
      end
      WU.SetActive(REF.DescribeArmNode, true)
      WU.SetLabel(REF.LabelPicturer, WU.GetString("UniqueWeapon_ArtistPrefix") .. armInfo.Artist)
      REF.WidgetIconSlot["$SetData"](iconDetail.type, iconDetail.id, nil, "S")
      REF.WidgetIconSlot["$ShowCustom"]({
        hideLevel = true,
        showEquip = false,
        showStar = false,
        phase = 1
      })
      REF.WidgetIconSlot["$SetClickCallback"](nil)
      REF.LabelCharactorTypeArm.UILabel.text = WU.GetString("UniqueWeapon_GachaExchangeKind_" .. armInfo.position)
      REF.TextureArmName.UITexture.mainTexturePath = "Texture/ImpressionRole_name/impression_role_name_" .. iconDetail.id .. "_0"
      REF.TextureArmName.UITexture:MakePixelPerfect()
      REF.TextureArmName.UITexture.color = CS.NGUIMath.HexToColor(995593215)
      REF.LabelArmDescription.UIHtmlLabel.text = WU.GetString("UniqueWeapon_Story_" .. iconDetail.id .. "_short")
      WU.SetActive(REF.DescribeSVNode, false)
      WU.SetActive(REF.LabelPossess, false)
      WU.SetActive(REF.NodeCountChanger, false)
    else
      local title = WU.GetString("WindowShopBuy_ResName" .. iconDetail.type) .. " x" .. iconDetail.count
      REF.LabelDescribe.UIHtmlLabel.text = WU.GetString("WindowShopBuy_ItemDesc", title, WU.GetString("ResourceTypeDesc_" .. iconDetail.type))
      REF.LabelDescribe.gameObject:SetActive(true)
    end
    REF.ScrollView.UIScrollView:ResetPosition()
    REF.LabelPossess.UIHtmlLabel.text = WU.GetString("WindowShopBuy_Possess", GetStock(iconDetail))
    REF.ButtonConfirm.UIButton.isEnabled = m_goods.buyLimit == 0 or 0 < m_goods.buyLimit - m_goods.buyCountRecord
    if 0 >= m_goods.buyLimit then
      m_limit = 0
      WU.ToggleRendering(REF.ButtonCancel, false)
      WU.ToggleRendering(REF.WidgetNumberEdit, true)
      WU.ToggleRendering(REF.LabelLimitOnce, false)
      WU.ToggleRendering(REF.SpriteCostBG2, true)
      WU.ToggleRendering(REF.SpriteCostBG, false)
    elseif m_goods.buyLimit >= 2 then
      if 1 < m_goods.buyLimit - m_goods.buyCountRecord then
        m_limit = m_goods.buyLimit - m_goods.buyCountRecord
        WU.ToggleRendering(REF.LabelLimitOnce, false)
        WU.ToggleRendering(REF.WidgetNumberEdit, true)
        WU.ToggleRendering(REF.SpriteCostBG2, true)
        WU.ToggleRendering(REF.SpriteCostBG, false)
        WU.ToggleRendering(REF.ButtonCancel, false)
      else
        WU.ToggleRendering(REF.LabelLimitOnce, true)
        WU.ToggleRendering(REF.WidgetNumberEdit, false)
        WU.ToggleRendering(REF.SpriteCostBG2, false)
        WU.ToggleRendering(REF.SpriteCostBG, true)
        WU.ToggleRendering(REF.ButtonCancel, false)
      end
    else
      WU.ToggleRendering(REF.LabelLimitOnce, false)
      WU.ToggleRendering(REF.WidgetNumberEdit, false)
      WU.ToggleRendering(REF.SpriteCostBG2, false)
      WU.ToggleRendering(REF.SpriteCostBG, true)
      WU.ToggleRendering(REF.ButtonCancel, true)
    end
    m_maxAmount = GetMaxAmount()
    REF.WidgetNumberEdit["$SetNumber"](1, true)
    if m_maxAmount == 0 then
      REF.WidgetNumberEdit["$SetRange"](1, 1)
    else
      REF.WidgetNumberEdit["$SetRange"](1, m_maxAmount)
    end
  else
    info("Shop", "goods is missing, please check shop slot for more detail!")
  end
end

function OnButtonConfirm()
  if m_goods and m_shopId then
    if m_goods.good.type == PB.enum.ResourceType.ResEquip and EU.CheckEquipOverflow() then
      return
    end
    if m_buyCount < 1 then
      WU.ShowHintText(WU.GetString("WindowShopBuy_CannotBuy0"))
      return
    end
    local tryToPaySuccess = true
    local costs = m_goods.cost
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
            if string.len(failedDesc) ~= 0 then
              WU.ShowHintText(failedDesc)
            end
            WU.RecycleWindow("ShopBuy")
          end
        else
          local trade = {
            info = m_goods,
            shopId = m_shopId,
            buyCount = m_buyCount
          }
          local wireFormatTable = ProtobufT("ApiShopTrade", trade)
          this:GameRequest("fci/ShopTrade"):Post(wireFormatTable, function(result)
            this:BroadcastGameEvent("OnShopPurchaseSuccess", result)
            WU.RecycleWindow("ShopBuy")
          end)
        end
      end
    end
    
    for i = 1, #costs do
      local cost = costs[i]
      WU.TryToPay(cost.type, cost.id, cost.count * m_buyCount, function()
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

function OnCancelClick()
  WU.RecycleWindow("ShopBuy")
end

function GetStock(item)
  local stock = 0
  if item.type == PB.enum.ResourceType.ResItem then
    stock = this:GetData("fci/item/" .. item.id).count
  elseif item.type == PB.enum.ResourceType.ResEquip then
    stock = _ENV["!"](this:GetData("fci/equip/")):where(function(_, equip)
      return equip.id == item.id
    end):count()
  elseif item.type == PB.enum.ResourceType.ResActorSkin then
    stock = fif(this:GetData("fci/unlockedSkins")[item.id], 1, 0)
  else
    stock = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[item.type] .. "_" .. item.id)
  end
  return stock
end

function OnAmountChange(num)
  REF.WidgetIconCost.gameObject:SetActive(false)
  if m_goods == nil then
    return
  end
  m_buyCount = num
  local costs = m_goods.cost
  if costs[1].type == PB.enum.ResourceType.ResPlayerMoney then
    WU.ToggleRendering(REF.SpriteCostBG2, true)
  end
  for i = 1, #costs do
    WU.SetActive(REF["LabelCost2" .. i], true)
    local stock = GetStock(costs[i])
    local costString
    if stock >= m_buyCount * costs[i].count then
      costString = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[costs[i].type] .. "_" .. costs[i].id .. "'/>" .. "<font color=#3B578BFF>" .. m_buyCount * costs[i].count .. "</font>"
    else
      costString = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[costs[i].type] .. "_" .. costs[i].id .. "'/>" .. "<font color=#fd5454ff>" .. m_buyCount * costs[i].count .. "</font>"
    end
    REF["LabelCost2" .. i].UIHtmlLabel.text = costString
  end
  REF.SpriteCostBG2.UIGrid:Reposition()
end

function GetMaxAmount()
  if m_goods == nil then
    return
  end
  local costs = m_goods.cost
  local stock = 0
  local maxAmount = fif(m_limit == 0, -1, m_limit)
  for i = 1, #costs do
    local cost = costs[i]
    if cost.type == PB.enum.ResourceType.ResItem then
      local item = this:GetData("fci/item/" .. cost.id)
      if item then
        stock = item.count
      end
    else
      stock = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[cost.type] .. "_" .. tostring(cost.id or 0))
    end
    local tmp = stock // cost.count
    maxAmount = fif(maxAmount > tmp or maxAmount == -1, tmp, maxAmount)
  end
  return maxAmount
end
