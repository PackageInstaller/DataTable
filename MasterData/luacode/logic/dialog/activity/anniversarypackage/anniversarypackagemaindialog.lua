local TabFrame = require("framework.ui.frame.tab.tabframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CLittlebattlePass = BeanManager.GetTableByName("activity.clittlebattlepass")
local AnniversaryPackageMainDialg = class("AnniversaryPackageMainDialg", Dialog)
AnniversaryPackageMainDialg.AssetBundleName = "ui/layouts.activity1yearanniversary"
AnniversaryPackageMainDialg.AssetName = "Activity1YearOtherMain"
local ChildDialogs = {
  "activity.springfestival.itembuydialog",
  "activity.springfestival.roleopstiondialog",
  "activity.anniversarypackage.skinlistdialog"
}
local BtnType = {
  Main = 1,
  Task = 2,
  Shop = 3
}

function AnniversaryPackageMainDialg:Ctor(...)
  AnniversaryPackageMainDialg.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._btnType = BtnType.Main
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BM_Anniversary)
  self._shopId = DataCommon.Anniversary.Other.ShopId
end

function AnniversaryPackageMainDialg:OnCreate()
  self._cutBtn1_Text = self:GetChild("Cutbtn1/_Text")
  self._cutBtn2_Text = self:GetChild("Cutbtn2/_Text")
  self._cutBtn3_Text = self:GetChild("Cutbtn3/_Text")
  self._cutBtn1_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2059))
  self._cutBtn2_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2057))
  self._cutBtn3_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2058))
  self._cutBtn1 = self:GetChild("Cutbtn1")
  self._cutBtn1RedDot = self:GetChild("Cutbtn1/RedDot")
  self._cutBtn2 = self:GetChild("Cutbtn2")
  self._cutBtn2RedDot = self:GetChild("Cutbtn2/RedDot")
  self._cutBtn3 = self:GetChild("Cutbtn3")
  self._cutBtn3RedDot = self:GetChild("Cutbtn3/RedDot")
  self._cutBtn1RedDot:SetActive(false)
  self._cutBtn2RedDot:SetActive(false)
  self._cutBtn3RedDot:SetActive(false)
  self._backBtn = self:GetChild("BackBtn")
  self._talkText = self:GetChild("Talk1/Text")
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._cutBtn1:Subscribe_PointerClickEvent(self.OnCutBtn1Clicked, self)
  self._cutBtn2:Subscribe_PointerClickEvent(self.OnCutBtn2Clicked, self)
  self._cutBtn3:Subscribe_PointerClickEvent(self.OnCutBtn3Clicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshAnniversaryDailySupply, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshAnniversaryDailyTaskList, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshAnniversaryCumulativeTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshShopInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

function AnniversaryPackageMainDialg:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
  end
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function AnniversaryPackageMainDialg:Init()
  NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.Anniversary)
  self:OnCutBtn1Clicked()
  self:RefreshRedDot()
end

function AnniversaryPackageMainDialg:RefreshRedDot(info)
  self._cutBtn1RedDot:SetActive(NekoData.BehaviorManager.BM_Anniversary:MainRedDot())
  self._cutBtn2RedDot:SetActive(NekoData.BehaviorManager.BM_Anniversary:HasTaskAward() or NekoData.BehaviorManager.BM_Anniversary:HasScoreAward())
  self._cutBtn3RedDot:SetActive(NekoData.BehaviorManager.BM_Anniversary:HasFreeGood())
end

function AnniversaryPackageMainDialg:OnCutBtn1Clicked()
  self._cutBtn1:SetSelected(true)
  self._cutBtn2:SetSelected(false)
  self._cutBtn3:SetSelected(false)
  self._frame:ToPage(BtnType.Main)
end

function AnniversaryPackageMainDialg:OnCutBtn2Clicked()
  if not NekoData.BehaviorManager.BM_Anniversary:IsPackageOpen() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100485)
    return
  end
  self._cutBtn1:SetSelected(false)
  self._cutBtn2:SetSelected(true)
  self._cutBtn3:SetSelected(false)
  self._frame:ToPage(BtnType.Task)
end

function AnniversaryPackageMainDialg:OnCutBtn3Clicked()
  if not NekoData.BehaviorManager.BM_Anniversary:IsPackageOpen() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100485)
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  protocol.shopId = self._shopId
  protocol:Send()
  self._cutBtn1:SetSelected(false)
  self._cutBtn2:SetSelected(false)
  self._cutBtn3:SetSelected(true)
  self._frame:ToPage(BtnType.Shop)
end

function AnniversaryPackageMainDialg:OnBackBtnClicked()
  self:Destroy()
end

function AnniversaryPackageMainDialg:CellAtIndex(frame, index)
  if index == BtnType.Main then
    return "activity.anniversarypackage.mainpage"
  elseif index == BtnType.Task then
    return "activity.anniversarypackage.taskpage"
  elseif index == BtnType.Shop then
    return "activity.anniversarypackage.shopmainpage"
  end
end

function AnniversaryPackageMainDialg:DidToPage(frame, index)
  if frame == self._frame then
    if index == BtnType.Main then
      self._frame:GetCellAtIndex(BtnType.Main)
    elseif index == BtnType.Task then
      self._frame:GetCellAtIndex(BtnType.Task):Refresh()
    elseif index == BtnType.Shop then
      local page = self._frame:GetCellAtIndex(BtnType.Shop)
      page:SetData(self._shopId)
    end
    self._btnType = index
  end
end

function AnniversaryPackageMainDialg:AddNewModal(dialog)
  if table.contain(ChildDialogs, dialog._dialogName) then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

function AnniversaryPackageMainDialg:OnDialogDestroy(notification)
  if notification.userInfo._dialogName == "mainline.bossrush.checkotherroleinfodialog" then
    self._rootWindow:SetActive(true)
  end
end

return AnniversaryPackageMainDialg
