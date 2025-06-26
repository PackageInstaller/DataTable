-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirageunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StarMirageUnlockDialog = class("StarMirageUnlockDialog", Dialog)
StarMirageUnlockDialog.AssetBundleName = "ui/layouts.activitystar"
StarMirageUnlockDialog.AssetName = "ActivityStarUnlock"
StarMirageUnlockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : StarMirageUnlockDialog
  ((StarMirageUnlockDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

StarMirageUnlockDialog.OnCreate = function(self)
  -- function num : 0_1
  self._goBtn = self:GetChild("BackImage/GetBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

StarMirageUnlockDialog.OnDestroy = function(self)
  -- function num : 0_2
end

StarMirageUnlockDialog.OnGoBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(1)
  self:Destroy()
end

StarMirageUnlockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).StarMirageUnlock)
  self:Destroy()
end

return StarMirageUnlockDialog

