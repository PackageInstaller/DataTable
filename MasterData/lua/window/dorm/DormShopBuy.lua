local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local m_goodInfo, m_buyRecordMap, m_manifesets

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnClickConfirm)
  WU.BindButtonEvent(REF.ButtonCancel, OnClickCancel)
  WU.BindButtonEvent(REF.ButtonCost1, function()
    OnClickBuy(1)
  end)
  WU.BindButtonEvent(REF.ButtonCost2, function()
    OnClickBuy(2)
  end)
end

function InitWindow()
  WU.SetActive(REF.GroupMono, false)
  WU.SetActive(REF.GroupBi, false)
end

function SetFurniture(goodInfo)
  m_manifesets = nil
  m_goodInfo = goodInfo
  local good = goodInfo[1].goods
  WU.SetActive(REF.WidgetIconItem, true)
  WU.SetActive(REF.TextureTheme, false)
  REF.DescribeSVNode.UIWidget.width = 740
  REF.LabelName.UIHtmlLabel.text = WU.GetString("FurnitureName_" .. good.id)
  REF.LabelDesc.UIHtmlLabel.text = WU.GetString("FurnitureDesc_" .. good.id)
  REF.WidgetIconItem["$ResetState"]()
  REF.WidgetIconItem["$SetData"](good.id, good.count)
  REF.LabelPossess.UIHtmlLabel.text = WU.GetString("Window_GuildOwnItemCount") .. this:GetData("fci/item/" .. good.id).count
  if #goodInfo == 1 then
    WU.SetActive(REF.GroupMono, true)
    local cost = goodInfo[1].cost[1]
    REF.LabelCostMono.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
  else
    WU.SetActive(REF.GroupBi, true)
    for i = 1, 2 do
      local cost = goodInfo[i].cost[1]
      REF["LabelCost" .. i].ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
    end
  end
end

function SetTheme(themeId, manifesets)
  m_manifesets = manifesets
  WU.SetActive(REF.WidgetIconItem, false)
  WU.SetActive(REF.TextureTheme, true)
  REF.DescribeSVNode.UIWidget.width = 560
  REF.TextureTheme.UITexture.mainTexturePath = "Texture/Dormitory/theme_suit_" .. themeId
  REF.LabelName.UIHtmlLabel.text = WU.GetString("FurnitureThemeName_" .. themeId)
  REF.LabelDesc.UIHtmlLabel.text = WU.GetString("FurnitureThemeDesc_" .. themeId)
  if #m_manifesets == 1 then
    WU.SetActive(REF.GroupMono, true)
    local cost = m_manifesets[1].cost
    REF.LabelCostMono.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
  elseif 1 < #m_manifesets then
    WU.SetActive(REF.GroupBi, true)
    for i = 1, 2 do
      local cost = m_manifesets[i].cost
      REF["LabelCost" .. i].ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
    end
  else
    this:DelayInvokeInFrames(1, function()
      WU.RecycleWindow(this)
    end)
  end
end

function OnClickConfirm()
  if m_manifesets then
    ReqestBuyFurn(m_manifesets[1].shopGoods)
  else
    local good = m_goodInfo[1].goods
    ReqestBuyFurn(m_goodInfo[1].shopGoodsId)
  end
end

function OnClickCancel()
  WU.RecycleWindow(this)
end

function OnClickBuy(index)
  if m_manifesets then
    ReqestBuyFurn(m_manifesets[index].shopGoods)
  else
    ReqestBuyFurn(m_goodInfo[index].shopGoodsId)
  end
end

function ReqestBuyFurn(shopGoodsId)
  local reqBody = {
    buyInfo = {}
  }
  if type(shopGoodsId) == "number" then
    reqBody.buyInfo = {
      {shopGoodsId = shopGoodsId, buyCount = 1}
    }
  else
    for _, v in ipairs(shopGoodsId) do
      table.insert(reqBody.buyInfo, {shopGoodsId = v, buyCount = 1})
    end
  end
  this:GameRequest("fci/dorm-shop-goods"):Post(reqBody, function(resp)
    DBH.ResChange(resp.resChange)
    this:SetData("fci/dorm-shop-goods", {
      buyRecord = resp.buyRecord
    })
    WU.ShowHintText(WU.GetString("DormShop_BuySucceed"))
    WU.RecycleWindow(this)
  end)
end
