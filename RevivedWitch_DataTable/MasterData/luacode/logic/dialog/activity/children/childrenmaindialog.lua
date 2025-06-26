-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/children/childrenmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CClownCfg = (BeanManager.GetTableByName)("activity.cclowncfg")
local ChildrenMainDialog = class("ChildrenMainDialog", Dialog)
ChildrenMainDialog.AssetBundleName = "ui/layouts.activitychildrensday"
ChildrenMainDialog.AssetName = "ActivityChildrensDayMain"
local BtnType = {Task = 1, Conversion = 2, Shop = 3}
ChildrenMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChildrenMainDialog, BtnType, _ENV
  ((ChildrenMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._btnType = BtnType.Task
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChildrenActivityManagerID)
  self._shopId = ((DataCommon.ChildrenActivity).Shop).ShopID
  self._taskFinsh = false
end

ChildrenMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._takBtn = self:GetChild("Cutbtn1")
  self._takBtnRedDot = self:GetChild("Cutbtn1/Dot")
  self._conversionBtn = self:GetChild("Cutbtn2")
  self._conversionBtnRedDot = self:GetChild("Cutbtn2/Dot")
  self._shopBtn = self:GetChild("Cutbtn3")
  self._shopBtnRedDot = self:GetChild("Cutbtn3/Dot")
  self._backBtn = self:GetChild("BackBtn")
  self._talkText = self:GetChild("Talk1/Text")
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  ;
  (self._takBtn):Subscribe_PointerClickEvent(self.OnTaskBtnClicked, self)
  ;
  (self._conversionBtn):Subscribe_PointerClickEvent(self.OnConversionBtnClicked, self)
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_SRefreshChildrenInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshShopInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnOthersActivitysTimeOver, Common.n_OthersActivitysTimeOver, nil)
  self:Init()
  self:RefreshRedDot()
end

ChildrenMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (DialogManager.DestroySingletonDialog)("activity.children.childrentipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

ChildrenMainDialog.Init = function(self)
  -- function num : 0_3
  self._taskFinsh = (self._bm):GetTaskFinish()
  if (self._bm):GetTaskFinish() then
    self:OnConversionBtnClicked()
  else
    self:OnTaskBtnClicked()
  end
end

ChildrenMainDialog.Refresh = function(self)
  -- function num : 0_4
  if not self._taskFinsh and (self._bm):GetTaskFinish() then
    self:OnBackBtnClicked()
  end
  self:RefreshRedDot()
end

ChildrenMainDialog.RefreshRedDot = function(self)
  -- function num : 0_5
  (self._takBtnRedDot):SetActive((self._bm):GetTaskRedDot())
  ;
  (self._conversionBtnRedDot):SetActive((self._bm):GetItemShopRedDot())
  ;
  (self._shopBtnRedDot):SetActive((self._bm):GetShopRedDot())
end

ChildrenMainDialog.RefreshShopRedPoint = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  if (notification.userInfo).shopId == self._shopId then
    local allFreeSoldOut = false
    for _,good in ipairs((notification.userInfo).refresh) do
      if good.discountPrice == 0 then
        allFreeSoldOut = true
        if good.goodRemain ~= 0 then
          allFreeSoldOut = false
          break
        end
      end
    end
  end
end

ChildrenMainDialog.OnTaskBtnClicked = function(self)
  -- function num : 0_7 , upvalues : BtnType, _ENV
  if not (self._bm):GetTaskFinish() then
    (self._takBtn):SetSelected(true)
    ;
    (self._conversionBtn):SetSelected(false)
    ;
    (self._shopBtn):SetSelected(false)
    ;
    (self._frame):ToPage(BtnType.Task)
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100452)
  end
end

ChildrenMainDialog.OnConversionBtnClicked = function(self)
  -- function num : 0_8 , upvalues : BtnType
  (self._takBtn):SetSelected(false)
  ;
  (self._conversionBtn):SetSelected(true)
  ;
  (self._shopBtn):SetSelected(false)
  ;
  (self._frame):ToPage(BtnType.Conversion)
end

ChildrenMainDialog.OnShopBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV, BtnType
  if not (self._bm):GetTaskFinish() then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
    protocol.shopId = self._shopId
    protocol:Send()
    ;
    (self._takBtn):SetSelected(false)
    ;
    (self._conversionBtn):SetSelected(false)
    ;
    (self._shopBtn):SetSelected(true)
    ;
    (self._frame):ToPage(BtnType.Shop)
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100452)
    end
  end
end

ChildrenMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

ChildrenMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_11 , upvalues : BtnType
  if index == BtnType.Task then
    return "activity.children.taskpage"
  else
    if index == BtnType.Conversion then
      return "activity.children.conversionpage"
    else
      if index == BtnType.Shop then
        return "activity.children.shopmainpage"
      end
    end
  end
end

ChildrenMainDialog.DidToPage = function(self, frame, index)
  -- function num : 0_12 , upvalues : BtnType
  if frame == self._frame then
    if index == BtnType.Task then
      ((self._frame):GetCellAtIndex(BtnType.Task)):Refresh()
    else
      if index == BtnType.Conversion then
        ((self._frame):GetCellAtIndex(BtnType.Conversion)):Refresh()
      else
        if index == BtnType.Shop then
          ((self._frame):GetCellAtIndex(BtnType.Shop)):RefreshGoodsData()
        end
      end
    end
    self._btnType = index
  end
end

ChildrenMainDialog.OnOthersActivitysTimeOver = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).ChildrenDay) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100033)
    self:OnBackBtnClicked()
  end
end

return ChildrenMainDialog

