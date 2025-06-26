-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolstowershopmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CClownSpecialCfg = (BeanManager.GetTableByName)("activity.cclownspecialcfg")
local AprilFoolsTowerShopMainDialog = class("AprilFoolsTowerShopMainDialog", Dialog)
AprilFoolsTowerShopMainDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerShopMainDialog.AssetName = "ActivityAprilFoolsStore"
AprilFoolsTowerShopMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsTowerShopMainDialog, _ENV
  ((AprilFoolsTowerShopMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AprilFoolsDayActivityManagerID)
end

AprilFoolsTowerShopMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, TableFrame, _ENV
  self._activeTime = self:GetChild("UI/ShopArea/Refresh/Txt")
  self._backBtn = self:GetChild("BackBtn")
  self._panel = self:GetChild("UI/ShopArea/CellFrame")
  self._redBtn = self:GetChild("Cutbtn1")
  self._redBtnTagTxt = self:GetChild("Cutbtn1/_Text")
  self._blueBtn = self:GetChild("Cutbtn2")
  self._blueBtnTagTxt = self:GetChild("Cutbtn2/_Text")
  self._title = self:GetChild("Title")
  self._topGroup = self:GetChild("TopGroup")
  self._goodsFrame = (GridFrame.Create)(self._panel, self, true, 4)
  self._moneyFrame = (TableFrame.Create)(self._topGroup, self, false, false, true)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._redBtn):Subscribe_PointerClickEvent(self.OnRedBtnClicked, self)
  ;
  (self._blueBtn):Subscribe_PointerClickEvent(self.OnBlueBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_RefreshShopInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_RefreshShopInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMoney, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_AprilFoolsOpenTowerShopDialog, self, true)
  self._panelRectX = (self._panel):GetRectSize()
  self:Init()
end

AprilFoolsTowerShopMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_AprilFoolsOpenTowerShopDialog, self, false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._shopTask then
    (GameTimer.RemoveTask)(self._shopTask)
    self._shopTask = nil
  end
  if self._goodsFrame then
    (self._goodsFrame):Destroy()
  end
  if self._moneyFrame then
    (self._moneyFrame):Destroy()
    self._moneyFrame = nil
  end
end

AprilFoolsTowerShopMainDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1776)).msgTextID))
  ;
  (self._activeTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1787)).msgTextID))
  ;
  (self._redBtnTagTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1790)).msgTextID))
  ;
  (self._blueBtnTagTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1791)).msgTextID))
  if (self._bm):IfGardenPartyRedShopUnlock() then
    self:OnRedBtnClicked()
  else
    if (self._bm):IfGardenPartyBlueShopUnlock() then
      self:OnBlueBtnClicked()
    else
      LogError("AprilFoolsTowerShopMainDialog", "blueshop and redshop neither is open, why shop can be opened?")
    end
  end
  ;
  (self._blueBtn):SetActive((self._bm):IfGardenPartyBlueShopUnlock())
  ;
  (self._redBtn):SetActive((self._bm):IfGardenPartyRedShopUnlock())
  self:OnRefreshMoney()
end

AprilFoolsTowerShopMainDialog.RefreshGoodsData = function(self, notChangePos)
  -- function num : 0_4 , upvalues : _ENV
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
    -- function num : 0_4_0 , upvalues : self, _ENV
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
  if self._panelRectY < (self._goodsFrame):GetTotalLength() then
    (self._goodsFrame):SetSlide(true, true)
  else
    ;
    (self._goodsFrame):SetSlide(false, false)
  end
  if notChangePos and lastPos then
    (self._goodsFrame):MoveToAssignedPos(lastPos)
  end
end

AprilFoolsTowerShopMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

AprilFoolsTowerShopMainDialog.OnRedBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self._shopId = ((DataCommon.AprilFoolsDayActivity).Shop).RedClownShopID
  self:RefreshGoodsData()
  ;
  (self._redBtn):SetSelected(true)
  ;
  (self._blueBtn):SetSelected(false)
end

AprilFoolsTowerShopMainDialog.OnBlueBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self._shopId = ((DataCommon.AprilFoolsDayActivity).Shop).BlueClownShopID
  self:RefreshGoodsData()
  ;
  (self._redBtn):SetSelected(false)
  ;
  (self._blueBtn):SetSelected(true)
end

AprilFoolsTowerShopMainDialog.OnBuyShopGood = function(self, notification)
  -- function num : 0_8
  if (notification.userInfo).shopId == self._shopId then
    self:RefreshGoodsData(true)
  end
end

AprilFoolsTowerShopMainDialog.OnRefreshMoney = function(self)
  -- function num : 0_9 , upvalues : _ENV, CClownSpecialCfg
  self._moneyList = {}
  ;
  (table.insert)(self._moneyList, tonumber((CClownSpecialCfg:GetRecorder(4)).Value))
  ;
  (table.insert)(self._moneyList, tonumber((CClownSpecialCfg:GetRecorder(5)).Value))
  ;
  (self._moneyFrame):ReloadAllCell()
end

AprilFoolsTowerShopMainDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_10
  if frame == self._goodsFrame then
    return #self._shopData
  else
    if frame == self._moneyFrame then
      return #self._moneyList
    end
  end
end

AprilFoolsTowerShopMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._goodsFrame then
    return "activity.aprilfoolsday.aprilfoolstowershopgoodscell"
  else
    if frame == self._moneyFrame then
      return "activity.aprilfoolsday.aprilfoolsmoneynumcell"
    end
  end
end

AprilFoolsTowerShopMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  if frame == self._goodsFrame then
    return (self._shopData)[index]
  else
    if frame == self._moneyFrame then
      return (self._moneyList)[index]
    end
  end
end

return AprilFoolsTowerShopMainDialog

