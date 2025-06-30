-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmasunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ChristmasUnlockDialog = class("ChristmasUnlockDialog", Dialog)
ChristmasUnlockDialog.AssetBundleName = "ui/layouts.activityhud"
ChristmasUnlockDialog.AssetName = "ActivityStart"
ChristmasUnlockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChristmasUnlockDialog
  ((ChristmasUnlockDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ChristmasUnlockDialog.OnCreate = function(self)
  -- function num : 0_1
  self._goBtn = self:GetChild("BackImage/GoBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

ChristmasUnlockDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ChristmasUnlockDialog.OnGoBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(48)
  self:Destroy()
end

ChristmasUnlockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return ChristmasUnlockDialog

