local TabFrame = require("framework.ui.frame.tab.tabframe")
local HalloweenMainDialog = class("HalloweenMainDialog", Dialog)
HalloweenMainDialog.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenMainDialog.AssetName = "ActivityHalloweenMain"

function HalloweenMainDialog:Ctor(...)
  HalloweenMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function HalloweenMainDialog:OnCreate()
  self._sheetBtn1 = self:GetChild("Cutbtn1")
  self._sheetBtn2 = self:GetChild("Cutbtn2")
  self._sheetBtn3 = self:GetChild("Cutbtn3")
  self._backBtn = self:GetChild("BackBtn")
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._sheetBtn1:Subscribe_PointerClickEvent(function()
    self:OnSheetBtnClicked(1)
  end, self)
  self._sheetBtn2:Subscribe_PointerClickEvent(function()
    self:OnSheetBtnClicked(2)
  end, self)
  self._sheetBtn3:Subscribe_PointerClickEvent(function()
    self:OnSheetBtnClicked(3)
  end, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, function()
    if GlobalGameFSM:GetCurrentState() ~= "Dungeon" then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100398)
    end
  end, Common.n_OnHalloweenEnd, nil)
  self:OnSheetBtnClicked(1)
end

function HalloweenMainDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function HalloweenMainDialog:OnSheetBtnClicked(index)
  if index == 3 then
    if NekoData.BehaviorManager.BM_Shop:GetHalloweenShopOpenState() == 1 then
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
      protocol.shopId = DataCommon.HalloweenActivity.Shop.ShopID
      protocol:Send()
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100400)
    end
    return
  end
  if index == 1 then
    self._sheetBtn1:SetSelected(true)
    self._sheetBtn2:SetSelected(false)
    self._sheetBtn3:SetSelected(false)
    self._frame:ToPage(index)
  else
    local sheet2Data = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.HalloweenActivityID):GetPumpkinPieReward()
    if sheet2Data and next(sheet2Data) ~= nil then
      self._sheetBtn1:SetSelected(false)
      self._sheetBtn2:SetSelected(true)
      self._sheetBtn3:SetSelected(false)
      self._frame:ToPage(index)
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100399)
    end
  end
end

function HalloweenMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function HalloweenMainDialog:OpenShop()
  self._sheetBtn1:SetSelected(false)
  self._sheetBtn2:SetSelected(false)
  self._sheetBtn3:SetSelected(true)
  self._frame:ToPage(3)
end

function HalloweenMainDialog:CellAtIndex(frame, index)
  if index == 1 then
    return "activity.halloween.halloweensheet1"
  elseif index == 2 then
    return "activity.halloween.halloweensheet2"
  elseif index == 3 then
    return "activity.halloween.shopmaindialog"
  end
end

return HalloweenMainDialog
