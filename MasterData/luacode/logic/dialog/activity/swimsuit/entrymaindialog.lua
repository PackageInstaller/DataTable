local TabFrame = require("framework.ui.frame.tab.tabframe")
local EntryMainDialog = class("EntryMainDialog", Dialog)
EntryMainDialog.AssetBundleName = "ui/layouts.activitysummer"
EntryMainDialog.AssetName = "ActivitySummerOtherMain"

function EntryMainDialog:Ctor(...)
  EntryMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function EntryMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._cutbtn1 = self:GetChild("Cutbtn1")
  self._cutbtn1Reddot = self:GetChild("Cutbtn1/RedDot")
  self._cutbtn1:Subscribe_PointerClickEvent(self.OnCutBtn1Click, self)
  self._cutbtn2 = self:GetChild("Cutbtn2")
  self._cutbtn2Reddot = self:GetChild("Cutbtn2/RedDot")
  self._cutbtn2:Subscribe_PointerClickEvent(self.OnCutBtn2Click, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshShopInfo, Common.n_RefreshShopInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSummerShopRedPoint, Common.n_SummerShopRedPoint, nil)
  self:SetData()
  self:OnCutBtn1Click()
end

function EntryMainDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function EntryMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function EntryMainDialog:SetData()
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityManagerID)
  self._cutbtn1Reddot:SetActive(false)
  self:OnSummerShopRedPoint()
end

function EntryMainDialog:OnCutBtn1Click()
  self._cutbtn1:SetSelected(true)
  self._cutbtn2:SetSelected(false)
  self._frame:ToPage(1):SetData()
end

function EntryMainDialog:OnCutBtn2Click()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = DataCommon.SummerNewShopID
    protocol:Send()
  end
end

function EntryMainDialog:RefreshShopInfo(notification)
  local protocol = notification.userInfo
  if DataCommon.SummerNewShopID == protocol.shopId then
    self._cutbtn1:SetSelected(false)
    self._cutbtn2:SetSelected(true)
    self._frame:ToPage(2):SetData(protocol)
  end
end

function EntryMainDialog:CellAtIndex(frame, index)
  if index == 1 then
    return "activity.swimsuit.sheet1"
  elseif index == 2 then
    return "activity.swimsuit.sheet2"
  end
end

function EntryMainDialog:OnSummerShopRedPoint()
  local reddot = self._bm:GetFreeRedDot()
  self._cutbtn2Reddot:SetActive(reddot)
end

return EntryMainDialog
