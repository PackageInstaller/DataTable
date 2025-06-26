-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/activitysummerunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivitySummerUnlockDialog = class("ActivitySummerUnlockDialog", Dialog)
ActivitySummerUnlockDialog.AssetBundleName = "ui/layouts.activitysummer"
ActivitySummerUnlockDialog.AssetName = "ActivitySummerUnlock"
ActivitySummerUnlockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActivitySummerUnlockDialog
  ((ActivitySummerUnlockDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ActivitySummerUnlockDialog.OnCreate = function(self)
  -- function num : 0_1
  self._goBtn = self:GetChild("BackImage/GetBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

ActivitySummerUnlockDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ActivitySummerUnlockDialog.OnGoBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(21)
  self:Destroy()
end

ActivitySummerUnlockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return ActivitySummerUnlockDialog

