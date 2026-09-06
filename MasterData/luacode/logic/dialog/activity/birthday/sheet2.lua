local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Sheet2 = class("Sheet2", Dialog)
local BottomToTop = 3
local ColumnNum = 4
Sheet2.AssetBundleName = "ui/layouts.activitylogin"
Sheet2.AssetName = "ActivityLoginShop"

function Sheet2:Ctor(...)
  Sheet2.super.Ctor(self, ...)
  self._currencyData = {}
  self._shopData = {}
end

function Sheet2:OnCreate()
  self._shopLimitText = self:GetChild("ActivityTime")
  self._tipsBtn = self:GetChild("Tips")
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._currencyPanel = self:GetChild("CurrencyFrame")
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._goodsPanel = self:GetChild("CellFrame")
  self._currencyFrame = TableFrame.Create(self._currencyPanel, self, false, false, true)
  self._goodsFrame = GridFrame.Create(self._goodsPanel, self, true, ColumnNum, true)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
end

function Sheet2:SetStaticRes()
  self._shopLimitText:SetText(TextManager.GetText(CStringRes:GetRecorder(1658).msgTextID))
end

function Sheet2:OnDestroy()
  if self._currencyFrame then
    self._currencyFrame:Destroy()
  end
  if self._goodsFrame then
    self._goodsFrame:Destroy()
  end
end

function Sheet2:SetData(shopID)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  if DataCommon.BirtDayShopID == shopID then
    self._shopID = shopID
    self:RefreshCurrencyData()
    self:RefreshGoodsData()
  end
end

function Sheet2:RefreshCurrencyData()
  for key, _ in pairs(self._currencyData) do
    self._currencyData[key] = nil
  end
  table.insert(self._currencyData, DataCommon.BirthDayCandy)
  self._currencyFrame:ReloadAllCell()
end

function Sheet2:RefreshGoodsData(notChangePos)
  self._shopData[self._shopID] = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(self._shopID)
  local lastPos = self._goodsFrame:GetCurrentPosition()
  self._goodsFrame:ReloadAllCell()
  if notChangePos and lastPos then
    self._goodsFrame:MoveToAssignedPos(lastPos)
  end
end

function Sheet2:OnBuyShopGood(notification)
  if notification.userInfo.shopId == self._shopID then
    self:RefreshGoodsData(true)
  end
end

function Sheet2:NumberOfCell(frame, index)
  if frame == self._currencyFrame then
    return #self._currencyData
  elseif frame == self._goodsFrame then
    return #self._shopData[self._shopID]
  end
end

function Sheet2:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "activity.birthday.shopcurrencycell"
  elseif frame == self._goodsFrame then
    return "activity.birthday.shopgoodscell"
  end
end

function Sheet2:DataAtIndex(frame, index)
  if frame == self._currencyFrame then
    return self._currencyData[index]
  elseif frame == self._goodsFrame then
    return self._shopData[self._shopID][index]
  end
end

function Sheet2:OnTipsBtnClicked()
  local dialogName = "activity.birthday.tipsdialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData(CStringRes:GetRecorder(1657).msgTextID, CStringRes:GetRecorder(1656).msgTextID)
  end
end

function Sheet2:OnCurPosChange(frame, proportion)
  local width, height = self._goodsPanel:GetRectSize()
  local total = self._goodsFrame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

return Sheet2
