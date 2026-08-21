-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/doubleeleven/sheet3.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Sheet3 = class("Sheet3", Dialog)
Sheet3.AssetBundleName = "ui/layouts.activityeleven"
Sheet3.AssetName = "ActivityElevenShop"
Sheet3.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet3
  ((Sheet3.super).Ctor)(self, ...)
  self._goodData = {}
end

Sheet3.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, GridFrame
  self._panel = self:GetChild("Back/Frame")
  ;
  (self:GetChild("Back/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2067))
  ;
  (self:GetChild("Back/EndTimeBack/EndTime")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2193))
  self._tipBtn = self:GetChild("Back/Tips")
  self._goodsFrame = (GridFrame.Create)(self._panel, self, true, 3, false)
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_RefreshShopInfo, nil)
  ;
  (self:GetChild("Back/UITips3")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2192))
end

Sheet3.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  if self._shopTask then
    (GameTimer.RemoveTask)(self._shopTask)
    self._shopTask = nil
  end
  if self._goodsFrame then
    (self._goodsFrame):Destroy()
  end
  if self._timerId ~= 0 then
    (GameTimer.RemoveTask)(self._timerId)
    self._timerId = 0
  end
end

Sheet3.OnTipBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(17)
end

Sheet3.SetData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._shopID = DataCommon.DoubleElevenShopID
  self:RefreshGoodsData()
end

Sheet3.RefreshGoodsData = function(self, notChangePos)
  -- function num : 0_5 , upvalues : _ENV
  self._shopData = {}
  local shopData = ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(self._shopID)
  if not shopData then
    shopData = {}
  end
  for _,good in ipairs(shopData) do
    local isrmt = 0
    if ((NekoData.BehaviorManager).BM_Currency):IsRealityCurrency(good.moneyType) then
      isrmt = 1
    end
    ;
    (table.insert)(self._shopData, {isrmt = isrmt, iteminfo = good})
  end
  ;
  (table.sort)(self._shopData, function(a, b)
    -- function num : 0_5_0
    do return (a.iteminfo).discountPrice < (b.iteminfo).discountPrice end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local refreshShopTime = nil
  for i,v in ipairs(self._shopData) do
    if (v.iteminfo).beginTime and (v.iteminfo).endTime and (v.iteminfo).beginTime ~= 0 and (v.iteminfo).endTime ~= 0 and (not refreshShopTime or (v.iteminfo).endTime < refreshShopTime) then
      refreshShopTime = (v.iteminfo).endTime
    end
  end
  if self._shopTask then
    (GameTimer.RemoveTask)(self._shopTask)
    self._shopTask = nil
  end
  if refreshShopTime then
    self._shopTask = (GameTimer.AddTask)(refreshShopTime // 1000, -1, function()
    -- function num : 0_5_1 , upvalues : self, _ENV
    self._shopTask = nil
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
    protocol.shopId = self._shopID
    protocol:Send()
  end
, nil, true)
  end
  local lastPos = (self._goodsFrame):GetCurrentPosition()
  ;
  (self._goodsFrame):ReloadAllCell()
  if notChangePos and lastPos then
    (self._goodsFrame):MoveToAssignedPos(lastPos)
  end
end

Sheet3.OnBuyShopGood = function(self, notification)
  -- function num : 0_6
  if (notification.userInfo).shopId == self._shopID then
    self:RefreshGoodsData(true)
  end
end

Sheet3.NumberOfCell = function(self, frame, index)
  -- function num : 0_7
  if frame == self._goodsFrame then
    return #self._shopData
  end
end

Sheet3.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._goodsFrame then
    return "activity.doubleeleven.shopgoodscell"
  end
end

Sheet3.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._goodsFrame then
    return {data = ((self._shopData)[index]).iteminfo, index = index}
  end
end

return Sheet3

