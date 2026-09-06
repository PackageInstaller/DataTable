local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ShopMainPage = class("ShopMainPage", Dialog)
ShopMainPage.AssetBundleName = "ui/layouts.activitychildrensday"
ShopMainPage.AssetName = "ActivityChildrensDayShop"

function ShopMainPage:Ctor(...)
  ShopMainPage.super.Ctor(self, ...)
  self._goodData = {}
end

function ShopMainPage:OnCreate()
  self._panel = self:GetChild("FrameShop")
  self._timeText = self:GetChild("EndTime")
  self._timeText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1796))
  self._txt = self:GetChild("Txt")
  self._mainName = self:GetChild("MainName")
  self._tipBtn = self:GetChild("Tips")
  self._goodsFrame = GridFrame.Create(self._panel, self, true, 3, false)
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_RefreshShopInfo, nil)
  self:Init()
end

function ShopMainPage:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("activity.children.childrentipsdialog")
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  if self._shopTask then
    GameTimer.RemoveTask(self._shopTask)
    self._shopTask = nil
  end
  if self._goodsFrame then
    self._goodsFrame:Destroy()
  end
end

function ShopMainPage:Init()
  self._txt:SetText(TextManager.GetText(CStringRes:GetRecorder(1801).msgTextID))
  self._shopId = DataCommon.ChildrenActivity.Shop.ShopID
  self:RefreshGoodsData()
end

function ShopMainPage:OnTipBtnClicked()
  DialogManager.CreateSingletonDialog("activity.children.childrentipsdialog"):SetData(CStringRes:GetRecorder(1794).msgTextID)
end

function ShopMainPage:RefreshGoodsData(notChangePos)
  self._shopData = {}
  local shopData = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(DataCommon.ChildrenActivity.Shop.ShopID)
  shopData = shopData or {}
  for _, good in ipairs(shopData) do
    local isrmt = 0
    if NekoData.BehaviorManager.BM_Currency:IsRealityCurrency(good.moneyType) then
      isrmt = 1
    end
    table.insert(self._shopData, {isrmt = isrmt, iteminfo = good})
  end
  local refreshShopTime
  for i, v in ipairs(self._shopData) do
    if v.iteminfo.beginTime and v.iteminfo.endTime and v.iteminfo.beginTime ~= 0 and v.iteminfo.endTime ~= 0 and (not refreshShopTime or refreshShopTime > v.iteminfo.endTime) then
      refreshShopTime = v.iteminfo.endTime
    end
  end
  if self._shopTask then
    GameTimer.RemoveTask(self._shopTask)
    self._shopTask = nil
  end
  if refreshShopTime then
    self._shopTask = GameTimer.AddTask(refreshShopTime // 1000, -1, function()
      self._shopTask = nil
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
      protocol.shopId = self._shopId
      protocol:Send()
    end, nil, true)
  end
  local lastPos = self._goodsFrame:GetCurrentPosition()
  self._goodsFrame:ReloadAllCell()
  if notChangePos and lastPos then
    self._goodsFrame:MoveToAssignedPos(lastPos)
  end
end

function ShopMainPage:OnBuyShopGood(notification)
  if notification.userInfo.shopId == self._shopId then
    self:RefreshGoodsData(true)
  end
end

function ShopMainPage:NumberOfCell(frame, index)
  if frame == self._goodsFrame then
    return #self._shopData
  end
end

function ShopMainPage:CellAtIndex(frame, index)
  if frame == self._goodsFrame then
    return "activity.children.shopgoodscell"
  end
end

function ShopMainPage:DataAtIndex(frame, index)
  if frame == self._goodsFrame then
    return self._shopData[index]
  end
end

return ShopMainPage
