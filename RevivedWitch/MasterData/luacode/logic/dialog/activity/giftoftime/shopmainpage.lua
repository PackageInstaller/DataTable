-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/shopmainpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ShopMainPage = class("ShopMainPage", Dialog)
ShopMainPage.AssetBundleName = "ui/layouts.battlepassnew"
ShopMainPage.AssetName = "BattlePassNewShop"
ShopMainPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopMainPage, _ENV
  ((ShopMainPage.super).Ctor)(self, ...)
  self._goodData = {}
  self._shopId = ((DataCommon.GiftofTime).Shop).ShopID
end

ShopMainPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._panel = self:GetChild("Frame")
  self._leftTime = self:GetChild("Time")
  self._tipBtn = self:GetChild("Tip")
  self._goodsFrame = (GridFrame.Create)(self._panel, self, true, 4, false)
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_RefreshShopInfo, nil)
end

ShopMainPage.OnDestroy = function(self)
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

local format_str = function(id, value)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  local s = (TextManager.GetText)((CStringRes:GetRecorder(id)).msgTextID)
  return (string.gsub)(s, "%$parameter1%$", value)
end

local GetRemainTimeStr = function(endTime)
  -- function num : 0_4 , upvalues : _ENV, CStringRes
  local str = nil
  if endTime and endTime > 0 then
    local time = endTime
    local day = time // 86400
    local hour = (math.ceil)(time / 3600)
    if day > 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1935)).msgTextID, (string.format)("%d", day), (string.format)("%d", hour - day * 24))
    else
      str = (TextManager.GetText)((CStringRes:GetRecorder(1936)).msgTextID, hour)
    end
  else
    do
      str = (TextManager.GetText)((CStringRes:GetRecorder(1936)).msgTextID, 0)
      return str
    end
  end
end

ShopMainPage.UpdateLeftTime = function(self)
  -- function num : 0_5 , upvalues : _ENV, GetRemainTimeStr
  self._leftTimeData = self._leftTimeData - 1
  if self._leftTimeData < 0 then
    (GameTimer.RemoveTask)(self._timerId)
    self._timerId = 0
    return 
  end
  local str = GetRemainTimeStr(self._leftTimeData)
  ;
  (self._leftTime):SetText(str)
end

ShopMainPage.OnTipBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(3)
end

ShopMainPage.RefreshGoodsData = function(self, notChangePos)
  -- function num : 0_7 , upvalues : _ENV
  self._leftTimeData = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetWeeklyLeftTime()
  self:UpdateLeftTime()
  if self._timerId ~= 0 then
    (GameTimer.RemoveTask)(self._timerId)
    self._timerId = 0
  end
  self._timerId = (GameTimer.AddTask)(1, 1, self.UpdateLeftTime, self)
  self._shopData = {}
  local shopData = ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(((DataCommon.GiftofTime).Shop).ShopID)
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
    -- function num : 0_7_0 , upvalues : self, _ENV
    self._shopTask = nil
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
    protocol.shopId = self._shopId
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

ShopMainPage.OnBuyShopGood = function(self, notification)
  -- function num : 0_8
  if (notification.userInfo).shopId == self._shopId then
    self:RefreshGoodsData(true)
  end
end

ShopMainPage.NumberOfCell = function(self, frame, index)
  -- function num : 0_9
  if frame == self._goodsFrame then
    return #self._shopData
  end
end

ShopMainPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._goodsFrame then
    return "activity.giftoftime.shopgoodscell"
  end
end

ShopMainPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._goodsFrame then
    return (self._shopData)[index]
  end
end

return ShopMainPage

