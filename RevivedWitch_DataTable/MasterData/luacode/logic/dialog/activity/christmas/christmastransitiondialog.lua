-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmastransitiondialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local UIManager = ((CS.PixelNeko).UI).UIManager
local ChristmasTransitionDialog = class("ChristmasTransitionDialog", Dialog)
ChristmasTransitionDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasTransitionDialog.AssetName = "ActivityChristmasTransition"
ChristmasTransitionDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChristmasTransitionDialog
  ((ChristmasTransitionDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ChristmasTransitionDialog.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_AnimationEvent("ActivityChristmasRurn", self.OnAnimationEvent, self)
end

ChristmasTransitionDialog.OnAnimationEvent = function(self, floatValue, intValue, stringValue, obj, clipName)
  -- function num : 0_2 , upvalues : _ENV
  if stringValue == "turn" then
    local dialog = nil
    if self._state == 1 then
      dialog = (DialogManager.GetDialog)("activity.christmas.christmasmain2dialog")
      if dialog then
        dialog:Destroy()
      end
      ;
      ((DialogManager.CreateSingletonDialog)("activity.christmas.christmasmaindialog")):Init()
    else
      if self._state == 2 then
        dialog = (DialogManager.GetDialog)("activity.christmas.christmasmaindialog")
        if dialog then
          dialog:Destroy()
        end
        ;
        (DialogManager.CreateSingletonDialog)("activity.christmas.christmasmain2dialog")
      end
    end
  else
    do
      if stringValue == "End" then
        self:Destroy()
      end
    end
  end
end

ChristmasTransitionDialog.SetState = function(self, state)
  -- function num : 0_3
  self._state = state
end

ChristmasTransitionDialog.OnDestroy = function(self)
  -- function num : 0_4
end

return ChristmasTransitionDialog

