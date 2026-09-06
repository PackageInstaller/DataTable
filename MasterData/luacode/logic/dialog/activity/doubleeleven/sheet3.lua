local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Sheet3 = class("Sheet3", Dialog)
Sheet3.AssetBundleName = "ui/layouts.activityeleven"
Sheet3.AssetName = "ActivityElevenShop"

function Sheet3:Ctor(...)
  Sheet3.super.Ctor(self, ...)
  self._goodData = {}
end

function Sheet3:OnCreate()
  self._panel = self:GetChild("Back/Frame")
  self:GetChild("Back/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2067))
  self:GetChild("Back/EndTimeBack/EndTime"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2193))
  self._tipBtn = self:GetChild("Back/Tips")
  self._goodsFrame = GridFrame.Create(self._panel, self, true, 3, false)
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_RefreshShopInfo, nil)
  self:GetChild("Back/UITips3"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2192))
end

function Sheet3:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  if self._shopTask then
    GameTimer.RemoveTask(self._shopTask)
    self._shopTask = nil
  end
  if self._goodsFrame then
    self._goodsFrame:Destroy()
  end
  if self._timerId ~= 0 then
    GameTimer.RemoveTask(self._timerId)
    self._timerId = 0
  end
end

function Sheet3:OnTipBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(17)
end

function Sheet3:SetData()
  self._shopID = DataCommon.DoubleElevenShopID
  self:RefreshGoodsData()
end

function Sheet3:RefreshGoodsData(notChangePos)
  self._shopData = {}
  local shopData = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(self._shopID)
  shopData = shopData or {}
  for _, good in ipairs(shopData) do
    local isrmt = 0
    if NekoData.BehaviorManager.BM_Currency:IsRealityCurrency(good.moneyType) then
      isrmt = 1
    end
    table.insert(self._shopData, {isrmt = isrmt, iteminfo = good})
  end
  table.sort(self._shopData, function(a, b)
    return a.iteminfo.discountPrice < b.iteminfo.discountPrice
  end)
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
      protocol.shopId = self._shopID
      protocol:Send()
    end, nil, true)
  end
  local lastPos = self._goodsFrame:GetCurrentPosition()
  self._goodsFrame:ReloadAllCell()
  if notChangePos and lastPos then
    self._goodsFrame:MoveToAssignedPos(lastPos)
  end
end

function Sheet3:OnBuyShopGood(notification)
  if notification.userInfo.shopId == self._shopID then
    self:RefreshGoodsData(true)
  end
end

function Sheet3:NumberOfCell(frame, index)
  if frame == self._goodsFrame then
    return #self._shopData
  end
end

function Sheet3:CellAtIndex(frame, index)
  if frame == self._goodsFrame then
    return "activity.doubleeleven.shopgoodscell"
  end
end

function Sheet3:DataAtIndex(frame, index)
  if frame == self._goodsFrame then
    return {
      data = self._shopData[index].iteminfo,
      index = index
    }
  end
end

return Sheet3
