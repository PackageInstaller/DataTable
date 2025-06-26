-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversaryunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnniversaryUnlockDialog = class("AnniversaryUnlockDialog", Dialog)
AnniversaryUnlockDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
AnniversaryUnlockDialog.AssetName = "Activity1YearAnniversaryUnlock"
AnniversaryUnlockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AnniversaryUnlockDialog
  ((AnniversaryUnlockDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

AnniversaryUnlockDialog.OnCreate = function(self)
  -- function num : 0_1
  self._goBtn = self:GetChild("BackImage/GetBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

AnniversaryUnlockDialog.OnDestroy = function(self)
  -- function num : 0_2
end

AnniversaryUnlockDialog.OnGoBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(125)
  self:Destroy()
end

AnniversaryUnlockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).Anniversary)
  self:Destroy()
end

return AnniversaryUnlockDialog

