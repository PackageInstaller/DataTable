-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/activitycommon/shopmainpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ShopMainPage = class("ShopMainPage", Dialog)
ShopMainPage.AssetBundleName = "ui/layouts.activitycommon"
ShopMainPage.AssetName = "ActivityCommon2Shop"
ShopMainPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopMainPage
  ((ShopMainPage.super).Ctor)(self, ...)
  self._goodData = {}
end

ShopMainPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._title = self:GetChild("Back/Title")
  self._panel = self:GetChild("Back/Frame")
  self._tipTxt = self:GetChild("Back/Text")
  self._endTimeTxt = self:GetChild("Back/EndTimeBack/EndTime")
  self._tipBtn = self:GetChild("Back/Tips")
  self._goodsFrame = (GridFrame.Create)(self._panel, self, true, 3, false)
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

ShopMainPage.OnTipBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local tipId = ((self._style).cfg).activeTip
  ;
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(tipId)
end

ShopMainPage.Refresh = function(self, delegate, style)
  -- function num : 0_4 , upvalues : CImagePathTable, _ENV
  self._style = style
  self._delegate = delegate
  self._shopId = (delegate._bm):GetActivityShopID((self._delegate)._actId)
  self:RefreshGoodsData()
  local imageRecord = CImagePathTable:GetRecorder(((self._style).cfg).activeTitle)
  if imageRecord then
    (self._title):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  ;
  (self._tipTxt):SetText((TextManager.GetText)(((self._style).cfg).activeText))
  ;
  (self._endTimeTxt):SetText((TextManager.GetText)(((self._style).cfg).activeTime))
end

ShopMainPage.RefreshGoodsData = function(self, notChangePos)
  -- function num : 0_5 , upvalues : _ENV
  self._shopData = {}
  local shopData = ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(self._shopId)
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
  -- function num : 0_6
  if (notification.userInfo).shopId == self._shopId then
    self:RefreshGoodsData(true)
  end
end

ShopMainPage.NumberOfCell = function(self, frame, index)
  -- function num : 0_7
  if frame == self._goodsFrame then
    return #self._shopData
  end
end

ShopMainPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._goodsFrame then
    return "activity.activitycommon.shopgoodscell"
  end
end

ShopMainPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._goodsFrame then
    return (self._shopData)[index]
  end
end

return ShopMainPage

