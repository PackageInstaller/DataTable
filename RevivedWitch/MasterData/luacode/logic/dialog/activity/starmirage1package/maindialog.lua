-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1package/maindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CLittlebattlePass = (BeanManager.GetTableByName)("activity.clittlebattlepass")
local Starmirage1PackageMainDialog = class("starmirage1PackageMainDialog", Dialog)
Starmirage1PackageMainDialog.AssetBundleName = "ui/layouts.activitystar2"
Starmirage1PackageMainDialog.AssetName = "ActivityStar2OtherMain"
local ChildDialogs = {"activity.springfestival.itembuydialog", "activity.springfestival.roleopstiondialog"}
local BtnType = {Main = 1, Shop = 2}
Starmirage1PackageMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Starmirage1PackageMainDialog, BtnType, _ENV
  ((Starmirage1PackageMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._btnType = BtnType.Main
  self._shopId = (((DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]).Other).ShopId
end

Starmirage1PackageMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TabFrame
  self._cutBtn1_Text = self:GetChild("Cutbtn1/_Text")
  self._cutBtn2_Text = self:GetChild("Cutbtn2/_Text")
  ;
  (self._cutBtn1_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2133))
  ;
  (self._cutBtn2_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2134))
  self._cutBtn1 = self:GetChild("Cutbtn1")
  self._cutBtn1RedDot = self:GetChild("Cutbtn1/RedDot")
  self._cutBtn2 = self:GetChild("Cutbtn2")
  self._cutBtn2RedDot = self:GetChild("Cutbtn2/RedDot")
  ;
  (self._cutBtn1RedDot):SetActive(false)
  ;
  (self._cutBtn2RedDot):SetActive(false)
  self._backBtn = self:GetChild("BackBtn")
  self._talkText = self:GetChild("Talk1/Text")
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  ;
  (self._cutBtn1):Subscribe_PointerClickEvent(self.OnCutBtn1Clicked, self)
  ;
  (self._cutBtn2):Subscribe_PointerClickEvent(self.OnCutBtn2Clicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshActivityDailySupply, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshActivityRewards, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_RefreshShopInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

Starmirage1PackageMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

Starmirage1PackageMainDialog.Init = function(self)
  -- function num : 0_3
  self:OnCutBtn1Clicked()
  self:RefreshRedDot()
end

Starmirage1PackageMainDialog.RefreshRedDot = function(self, info)
  -- function num : 0_4 , upvalues : _ENV
  (self._cutBtn1RedDot):SetActive(((NekoData.BehaviorManager).BM_StarMirageCopy):ShowActivityRedDot())
  ;
  (self._cutBtn2RedDot):SetActive(((NekoData.BehaviorManager).BM_StarMirageCopy):HasFreeGood())
end

Starmirage1PackageMainDialog.OnCutBtn1Clicked = function(self)
  -- function num : 0_5 , upvalues : BtnType
  (self._cutBtn1):SetSelected(true)
  ;
  (self._cutBtn2):SetSelected(false)
  ;
  (self._frame):ToPage(BtnType.Main)
end

Starmirage1PackageMainDialog.OnCutBtn2Clicked = function(self)
  -- function num : 0_6 , upvalues : _ENV, BtnType
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  protocol.shopId = self._shopId
  protocol:Send()
  ;
  (self._cutBtn1):SetSelected(false)
  ;
  (self._cutBtn2):SetSelected(true)
  ;
  (self._frame):ToPage(BtnType.Shop)
end

Starmirage1PackageMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

Starmirage1PackageMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8 , upvalues : BtnType
  if index == BtnType.Main then
    return "activity.starmirage1package.mainpage"
  else
    if index == BtnType.Shop then
      return "activity.starmirage1package.shopmainpage"
    end
  end
end

Starmirage1PackageMainDialog.DidToPage = function(self, frame, index)
  -- function num : 0_9 , upvalues : BtnType
  if frame == self._frame then
    if index == BtnType.Main then
      (self._frame):GetCellAtIndex(BtnType.Main)
    else
      if index == BtnType.Shop then
        local page = (self._frame):GetCellAtIndex(BtnType.Shop)
        page:SetData(self._shopId)
      end
    end
    do
      self._btnType = index
    end
  end
end

Starmirage1PackageMainDialog.AddNewModal = function(self, dialog)
  -- function num : 0_10 , upvalues : _ENV, ChildDialogs
  if (table.contain)(ChildDialogs, dialog._dialogName) then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

Starmirage1PackageMainDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_11
  if (notification.userInfo)._dialogName == "mainline.bossrush.checkotherroleinfodialog" then
    (self._rootWindow):SetActive(true)
  end
end

return Starmirage1PackageMainDialog

