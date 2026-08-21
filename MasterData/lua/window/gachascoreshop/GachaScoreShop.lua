local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local m_shop, m_weaponShop

function SetupWindow()
  WU.BindButtonEvent(REF.WidgetTabSlotActor, SetActorShop)
  WU.BindButtonEvent(REF.WidgetTabSlotArm, SetArmShop)
end

function InitWindow()
  m_weaponShop = {}
  REF.LabelRefreshCountdown.gameObject:SetActive(false)
  REF.LabelCountdown.gameObject:SetActive(false)
  REF.ShopScrollViewList.gameObject:SetActive(false)
  REF.ShopWeaponScrollViewList.gameObject:SetActive(false)
  REF.LabelStock.gameObject:SetActive(false)
  REF.LabelStockArm1.gameObject:SetActive(false)
  REF.LabelStockArm2.gameObject:SetActive(false)
  REF.WidgetTabSlotArm.gameObject:SetActive(false)
  local limitLevel = PB.all("Misc")[1].weaponMisc.weaponShowLevel
  local isUnlocked = this:GetData("Arm/ArmUnlock")
  if isUnlocked == true then
    REF.WidgetTabSlotArm.gameObject:SetActive(true)
  end
  this:RegisterGameEvent("OnScoreShopPurchaseSuccess", OnScoreShopPurchaseSuccess)
  this:BindRemote(DB:GameRequest("fci/gacha-shop/"), OnScoreShopInfo)
  this:GameRequest("fci/gacha-shop-weapon/"):Get(OnScoreWeaponShopInfo)
  local resType = PB.enum.ResourceType.ResGachaPoint
  local resId = 0
  local stockAmount = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[resType] .. "_" .. resId)
  REF.LabelStock.ResourcePrinter:SetResource(resType, resId, stockAmount)
  REF.LabelStockArm1.ResourcePrinter:SetResource(11, 55002)
  REF.LabelStockArm2.ResourcePrinter:SetResource(11, 55003)
  REF.root.Animator:Play("DelayOpen", -1, 0)
end

function UninitWindow()
end

function UpdateWindow(delta)
  UpdateRefreshTime()
end

function UpdateRowShop(refRow, wrapIndex, realIndex)
  if m_shop and m_shop.goods ~= nil and realIndex < #m_shop.goods then
    refRow["$$SetData"](m_shop.goods[realIndex + 1])
  end
end

function UpdateRowWeaponShop(refRow, wrapIndex, realIndex)
  if m_weaponShop and m_weaponShop.goodsInfo ~= nil and realIndex < #m_weaponShop.goodsInfo then
    refRow["$$SetData"](m_weaponShop.goodsInfo[realIndex + 1])
  end
end

function UpdateRefreshTime()
  if m_shop and m_shop.nextRefreshTime then
    if m_shop.nextRefreshTime <= CS.GameTime.serverUtc then
      m_shop = nil
      this:GameRequest("fci/gacha-shop/"):Get(function(result)
        this:SetData("fci/gacha-shop/", result)
      end, function(error)
        this:BroadcastGameEvent("GachaScoreShopClose")
        WU.RecycleWindow(this)
        return true
      end)
      return
    end
    REF.LabelCountdown.UIHtmlLabel.text = WU.RenderCountDownTime(m_shop.nextRefreshTime - CS.GameTime.serverUtc, REF.LabelCountdown.UIHtmlLabel.fontSize)
  end
end

function OnScoreShopInfo(shop)
  if shop then
    m_shop = shop
    SetSlideArrow()
    if m_shop.goods then
      REF.WidgetTabSlotActor.UIToggle.value = true
      SetActorShop()
    end
  end
end

function OnScoreWeaponShopInfo(shop)
  if shop then
    m_weaponShop = {}
    m_weaponShop.goodsInfo = {}
    for k, v in pairs(shop.goodsInfo) do
      table.insert(m_weaponShop.goodsInfo, v)
    end
  end
end

function OnScoreShopPurchaseSuccess(result)
  DBH.ResChange(result.resChange)
  WU.ShowRewards(result.resChange)
end

function SetSlideArrow()
  local maxCountPerPage = math.ceil(REF.ShopScrollView.UIPanel:GetViewSize().x / REF.ShopWrapContent.UIWrapContent.itemSize)
  REF.Slide_Arrow.gameObject:SetActive(false)
  if m_shop and maxCountPerPage < #m_shop.goods then
    REF.Slide_Arrow.gameObject:SetActive(true)
  end
end

function SetActorShop()
  SetActorShopState(true)
  LU.Bind(REF.ShopWrapContent, {
    updateRow = UpdateRowShop
  })
  LU.Set(REF.ShopWrapContent, #m_shop.goods)
  REF.ShopWrapContent.UIPlayTween:Play(true)
end

function SetArmShop()
  SetActorShopState(false)
  LU.Bind(REF.ShopWeaponWrapContent, {
    updateRow = UpdateRowWeaponShop
  })
  LU.Set(REF.ShopWeaponWrapContent, #m_weaponShop.goodsInfo)
  REF.ShopWeaponWrapContent.UIPlayTween:Play(true)
end

function SetActorShopState(flag)
  REF.ShopScrollViewList.gameObject:SetActive(flag)
  REF.ShopWeaponScrollViewList.gameObject:SetActive(not flag)
  REF.LabelRefreshCountdown.gameObject:SetActive(flag)
  REF.LabelCountdown.gameObject:SetActive(flag)
  REF.LabelStock.gameObject:SetActive(flag)
  REF.LabelStockArm1.gameObject:SetActive(not flag)
  REF.LabelStockArm2.gameObject:SetActive(not flag)
end
