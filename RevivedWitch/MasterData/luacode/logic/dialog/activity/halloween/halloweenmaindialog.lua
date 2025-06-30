-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/halloween/halloweenmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local HalloweenMainDialog = class("HalloweenMainDialog", Dialog)
HalloweenMainDialog.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenMainDialog.AssetName = "ActivityHalloweenMain"
HalloweenMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HalloweenMainDialog
  ((HalloweenMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

HalloweenMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._sheetBtn1 = self:GetChild("Cutbtn1")
  self._sheetBtn2 = self:GetChild("Cutbtn2")
  self._sheetBtn3 = self:GetChild("Cutbtn3")
  self._backBtn = self:GetChild("BackBtn")
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  ;
  (self._sheetBtn1):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnSheetBtnClicked(1)
  end
, self)
  ;
  (self._sheetBtn2):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnSheetBtnClicked(2)
  end
, self)
  ;
  (self._sheetBtn3):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self
    self:OnSheetBtnClicked(3)
  end
, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_3 , upvalues : _ENV
    if GlobalGameFSM:GetCurrentState() ~= "Dungeon" then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100398)
    end
  end
, Common.n_OnHalloweenEnd, nil)
  self:OnSheetBtnClicked(1)
end

HalloweenMainDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
  end
end

HalloweenMainDialog.OnSheetBtnClicked = function(self, index)
  -- function num : 0_3 , upvalues : _ENV
  if index == 3 then
    if ((NekoData.BehaviorManager).BM_Shop):GetHalloweenShopOpenState() == 1 then
      local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
      protocol.shopId = ((DataCommon.HalloweenActivity).Shop).ShopID
      protocol:Send()
    else
      do
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100400)
        do return  end
        if index == 1 then
          (self._sheetBtn1):SetSelected(true)
          ;
          (self._sheetBtn2):SetSelected(false)
          ;
          (self._sheetBtn3):SetSelected(false)
          ;
          (self._frame):ToPage(index)
        else
          local sheet2Data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.HalloweenActivityID)):GetPumpkinPieReward()
          if sheet2Data and next(sheet2Data) ~= nil then
            (self._sheetBtn1):SetSelected(false)
            ;
            (self._sheetBtn2):SetSelected(true)
            ;
            (self._sheetBtn3):SetSelected(false)
            ;
            (self._frame):ToPage(index)
          else
            ;
            ((NekoData.BehaviorManager).BM_Message):SendMessageById(100399)
          end
        end
      end
    end
  end
end

HalloweenMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

HalloweenMainDialog.OpenShop = function(self)
  -- function num : 0_5
  (self._sheetBtn1):SetSelected(false)
  ;
  (self._sheetBtn2):SetSelected(false)
  ;
  (self._sheetBtn3):SetSelected(true)
  ;
  (self._frame):ToPage(3)
end

HalloweenMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if index == 1 then
    return "activity.halloween.halloweensheet1"
  else
    if index == 2 then
      return "activity.halloween.halloweensheet2"
    else
      if index == 3 then
        return "activity.halloween.shopmaindialog"
      end
    end
  end
end

return HalloweenMainDialog

