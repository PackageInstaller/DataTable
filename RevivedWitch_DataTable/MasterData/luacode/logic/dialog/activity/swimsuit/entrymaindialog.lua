-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/entrymaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local EntryMainDialog = class("EntryMainDialog", Dialog)
EntryMainDialog.AssetBundleName = "ui/layouts.activitysummer"
EntryMainDialog.AssetName = "ActivitySummerOtherMain"
EntryMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EntryMainDialog
  ((EntryMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

EntryMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  self._cutbtn1 = self:GetChild("Cutbtn1")
  self._cutbtn1Reddot = self:GetChild("Cutbtn1/RedDot")
  ;
  (self._cutbtn1):Subscribe_PointerClickEvent(self.OnCutBtn1Click, self)
  self._cutbtn2 = self:GetChild("Cutbtn2")
  self._cutbtn2Reddot = self:GetChild("Cutbtn2/RedDot")
  ;
  (self._cutbtn2):Subscribe_PointerClickEvent(self.OnCutBtn2Click, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShopInfo, Common.n_RefreshShopInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSummerShopRedPoint, Common.n_SummerShopRedPoint, nil)
  self:SetData()
  self:OnCutBtn1Click()
end

EntryMainDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
  end
end

EntryMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

EntryMainDialog.SetData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SummerActivityManagerID)
  ;
  (self._cutbtn1Reddot):SetActive(false)
  self:OnSummerShopRedPoint()
end

EntryMainDialog.OnCutBtn1Click = function(self)
  -- function num : 0_5
  (self._cutbtn1):SetSelected(true)
  ;
  (self._cutbtn2):SetSelected(false)
  ;
  ((self._frame):ToPage(1)):SetData()
end

EntryMainDialog.OnCutBtn2Click = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = DataCommon.SummerNewShopID
    protocol:Send()
  end
end

EntryMainDialog.RefreshShopInfo = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  local protocol = notification.userInfo
  if DataCommon.SummerNewShopID == protocol.shopId then
    (self._cutbtn1):SetSelected(false)
    ;
    (self._cutbtn2):SetSelected(true)
    ;
    ((self._frame):ToPage(2)):SetData(protocol)
  end
end

EntryMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  if index == 1 then
    return "activity.swimsuit.sheet1"
  else
    if index == 2 then
      return "activity.swimsuit.sheet2"
    end
  end
end

EntryMainDialog.OnSummerShopRedPoint = function(self)
  -- function num : 0_9
  local reddot = (self._bm):GetFreeRedDot()
  ;
  (self._cutbtn2Reddot):SetActive(reddot)
end

return EntryMainDialog

