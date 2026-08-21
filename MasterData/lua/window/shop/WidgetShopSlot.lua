local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local m_target, m_shopId

function Start()
  WU.BindButtonEvent(REF["$"], OnSlotClick)
end

function SetData(wrapIndex, realIndex, target, shopId)
  if target ~= nil then
    m_target = target
    m_shopId = shopId
    local costs = m_target.cost
    local iconDetail = m_target.good
    REF.LabelCost3.ResourcePrinter:SetResource(costs[1].type, costs[1].id, costs[1].count)
    if iconDetail.type == PB.enum.ResourceType.ResActor then
      local actorQuality, actorStar = AU.CheckActorStarRandom(iconDetail.id, iconDetail.param)
      iconDetail.quality = actorQuality
      REF.WidgetIconSlot["$SetActorCustom"]({
        id = iconDetail.id,
        quality = actorQuality
      })
    elseif iconDetail.type == PB.enum.ResourceType.ResUniqueWeapon then
      REF.WidgetIconSlot["$SetData"](iconDetail.type, iconDetail.id, nil, "S")
      REF.WidgetIconSlot["$ShowCustom"]({
        hideLevel = true,
        showEquip = false,
        showStar = false,
        phase = 1
      })
    else
      REF.WidgetIconSlot["$SetData"](iconDetail.type, iconDetail.id, iconDetail.count)
    end
    local soldOut = m_target.sold or m_target.buyLimit ~= 0 and m_target.buyCountRecord >= m_target.buyLimit
    REF["$BoxCollider2D"].enabled = not soldOut
    if soldOut then
      REF.WidgetIconSlot["$SetClickCallback"](nil)
      REF.Container.UIWidget.alpha = 0.6
      REF.WidgetIconSlot["$SetTips"]("soldOut")
    else
      REF.WidgetIconSlot["$SetClickCallback"](OnSlotClick)
      REF.Container.UIWidget.alpha = 1
      REF.WidgetIconSlot["$SetTips"](nil)
      if IsLimitedByGuildLevel(m_target) then
        REF.LabelCost3.ResourcePrinter:SetResource(0, 0, 0)
        REF.LabelCost3.UIHtmlLabel.text = WU.GetString("Window_GuildGoodsUnlockAtLevel", m_target.guildLevelLimit)
      end
    end
    if m_target.buyLimit <= 0 then
      WU.ToggleRendering(REF.LeftBuyCount, true)
      REF.LeftBuyCount.UIHtmlLabel.text = WU.GetString("WindowShop_NoBuyLimit")
    elseif m_target.buyLimit >= 2 then
      WU.ToggleRendering(REF.LeftBuyCount, true)
      REF.LeftBuyCount.UIHtmlLabel.text = WU.GetString("WindowShopBuy_LeftBuyCount", m_target.buyLimit - m_target.buyCountRecord, m_target.buyLimit)
    else
      WU.ToggleRendering(REF.LeftBuyCount, false)
    end
    if m_target.dailyRefresh then
      WU.ToggleRendering(REF.LeftBuyCountToday, true)
      if m_target.buyCountRecord >= m_target.buyLimit then
        REF.LeftBuyCountToday.UIHtmlLabel.text = WU.GetString("WindowShop_RefreshTomorrow")
      else
        REF.LeftBuyCountToday.UIHtmlLabel.text = WU.GetString("WindowShop_TodayBuyTimes", m_target.buyLimit - m_target.buyCountRecord, m_target.buyLimit)
      end
    else
      WU.ToggleRendering(REF.LeftBuyCountToday, false)
    end
  else
    info("Shop", "can't locate realIndex " .. realIndex .. [[
 in m_goods arrayList
Please checkout goods's position at ]] .. realIndex)
  end
end

function OnSlotClick()
  if m_target and m_shopId then
    if IsLimitedByGuildLevel(m_target) then
      WU.ShowHintText(WU.GetString("Window_GuildGoodsUnlockAtLevelDetail", m_target.guildLevelLimit))
      return
    end
    if m_target.dailyRefresh and m_target.buyCountRecord >= m_target.buyLimit then
      WU.ShowHintText(WU.GetString("Window_RemainTimesRunOut"))
      return
    end
    this:SetData("Shop/Id", m_shopId)
    if m_target.good.type == PB.enum.ResourceType.ResActor then
      m_target.cost.type = m_target.cost[1].type
      m_target.cost.id = m_target.cost[1].id
      m_target.cost.count = m_target.cost[1].count
      this:SetData("GachaScoreShop/EnterType", 2)
      this:SetData("GachaScoreShop/Goods", m_target)
      WU.AcquireWindowAsync("GachaScoreExchange")
    else
      local isManualBox = false
      local itemInfo
      if m_target.good.type == PB.enum.ResourceType.ResItem then
        itemInfo = PB.get("ItemInfo", m_target.good.id)
        isManualBox = itemInfo.funcType == PB.enum.ItemFuncType.ManualBox or itemInfo.funcType == PB.enum.ItemFuncType.FinanceBox
      end
      if isManualBox then
        if itemInfo.param[1] == PB.enum.ManualBoxType.Actor then
          WU.AcquireWindowAsync("ManualBoxActor", function(ui)
            _ENV["$"](ui)["$$SetGoodsInfo"](m_target)
          end)
        elseif itemInfo.param[1] == PB.enum.ManualBoxType.Equip then
          WU.AcquireWindowAsync("ManualBoxEquip", function(ui)
            _ENV["$"](ui)["$$SetGoodsInfo"](m_target)
          end)
        elseif itemInfo.param[1] == PB.enum.ManualBoxType.Mix then
          WU.AcquireWindowAsync("ManualBoxMix", function(ui)
            _ENV["$"](ui)["$$SetGoodsInfo"](m_target)
          end)
        elseif itemInfo.param[1] == PB.enum.ManualBoxType.ActorSkin then
          WU.AcquireWindowAsync("ManualBoxSkin", function(ui)
            _ENV["$"](ui)["$$SetGoodsInfo"](m_target)
          end)
        else
          warning("Unknow ManualBoxType: " .. itemInfo.param[1])
        end
      else
        this:SetData("Shop/Goods", m_target)
        WU.AcquireWindowAsync("ShopBuy")
      end
    end
  end
end

function IsLimitedByGuildLevel(goods)
  local result = false
  if goods.guildLevelLimit > 0 then
    local guild = this:GetData("fci/guild/")
    if guild then
      result = goods.guildLevelLimit > guild.level
    else
      error("Shop", "no guild available, guild shop shold be closed")
    end
  end
  return result
end
