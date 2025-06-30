-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/birthday/sheet2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Sheet2 = class("Sheet2", Dialog)
local BottomToTop = 3
local ColumnNum = 4
Sheet2.AssetBundleName = "ui/layouts.activitylogin"
Sheet2.AssetName = "ActivityLoginShop"
Sheet2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet2
  ((Sheet2.super).Ctor)(self, ...)
  self._currencyData = {}
  self._shopData = {}
end

Sheet2.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, GridFrame, ColumnNum, _ENV
  self._shopLimitText = self:GetChild("ActivityTime")
  self._tipsBtn = self:GetChild("Tips")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._currencyPanel = self:GetChild("CurrencyFrame")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._goodsPanel = self:GetChild("CellFrame")
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false, true)
  self._goodsFrame = (GridFrame.Create)(self._goodsPanel, self, true, ColumnNum, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
end

Sheet2.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  (self._shopLimitText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1658)).msgTextID))
end

Sheet2.OnDestroy = function(self)
  -- function num : 0_3
  if self._currencyFrame then
    (self._currencyFrame):Destroy()
  end
  if self._goodsFrame then
    (self._goodsFrame):Destroy()
  end
end

Sheet2.SetData = function(self, shopID)
  -- function num : 0_4 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  if DataCommon.BirtDayShopID == shopID then
    self._shopID = shopID
    self:RefreshCurrencyData()
    self:RefreshGoodsData()
  end
end

Sheet2.RefreshCurrencyData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for key,_ in pairs(self._currencyData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._currencyData)[key] = nil
  end
  ;
  (table.insert)(self._currencyData, DataCommon.BirthDayCandy)
  ;
  (self._currencyFrame):ReloadAllCell()
end

Sheet2.RefreshGoodsData = function(self, notChangePos)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  (self._shopData)[self._shopID] = ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(self._shopID)
  local lastPos = (self._goodsFrame):GetCurrentPosition()
  ;
  (self._goodsFrame):ReloadAllCell()
  if notChangePos and lastPos then
    (self._goodsFrame):MoveToAssignedPos(lastPos)
  end
end

Sheet2.OnBuyShopGood = function(self, notification)
  -- function num : 0_7
  if (notification.userInfo).shopId == self._shopID then
    self:RefreshGoodsData(true)
  end
end

Sheet2.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  if frame == self._currencyFrame then
    return #self._currencyData
  else
    if frame == self._goodsFrame then
      return #(self._shopData)[self._shopID]
    end
  end
end

Sheet2.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._currencyFrame then
    return "activity.birthday.shopcurrencycell"
  else
    if frame == self._goodsFrame then
      return "activity.birthday.shopgoodscell"
    end
  end
end

Sheet2.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._currencyFrame then
    return (self._currencyData)[index]
  else
    if frame == self._goodsFrame then
      return ((self._shopData)[self._shopID])[index]
    end
  end
end

Sheet2.OnTipsBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV, CStringRes
  local dialogName = "activity.birthday.tipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1657)).msgTextID, (CStringRes:GetRecorder(1656)).msgTextID)
  end
end

Sheet2.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_12
  local width, height = (self._goodsPanel):GetRectSize()
  local total = (self._goodsFrame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

return Sheet2

