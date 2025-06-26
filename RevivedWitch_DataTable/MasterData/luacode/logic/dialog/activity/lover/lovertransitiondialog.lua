-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/lover/lovertransitiondialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local UIManager = ((CS.PixelNeko).UI).UIManager
local LoverTransitionDialog = class("LoverTransitionDialog", Dialog)
LoverTransitionDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverTransitionDialog.AssetName = "ActivityValentinesTransition"
LoverTransitionDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoverTransitionDialog
  ((LoverTransitionDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

LoverTransitionDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetRootWindow()):Subscribe_AnimationEvent("ActivityChristmasRurn", self.OnAnimationEvent, self)
  self._dialog = (DialogManager.CreateSingletonDialog)("activity.lover.lovermaindialog")
  ;
  ((self._dialog):GetRootWindow()):SetActive(false)
end

LoverTransitionDialog.OnAnimationEvent = function(self, floatValue, intValue, stringValue, obj, clipName)
  -- function num : 0_2 , upvalues : _ENV
  if stringValue == "turn" then
    (DialogManager.DestroySingletonDialog)("activity.loverunlockdialog")
    ;
    ((self._dialog):GetRootWindow()):SetActive(true)
  else
    if stringValue == "End" then
      self:Destroy()
    end
  end
end

LoverTransitionDialog.OnDestroy = function(self)
  -- function num : 0_3
end

return LoverTransitionDialog

