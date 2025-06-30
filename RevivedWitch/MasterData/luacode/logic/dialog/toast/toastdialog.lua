-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/toast/toastdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ToastDialog = class("ToastDialog", Dialog)
ToastDialog.AssetBundleName = "ui/layouts.toast"
ToastDialog.AssetName = "Toast"
ToastDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ToastDialog
  ((ToastDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ToastDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text")
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

ToastDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ToastDialog.Show = function(self, text)
  -- function num : 0_3 , upvalues : _ENV
  text = (string.trim)(text)
  ;
  (self._text):SetText(text)
  local width, _ = (self:GetRootWindow()):GetDeltaSize()
  local w, h = (self._text):GetPreferredSize()
  if width < w then
    w = width
    ;
    (self:GetRootWindow()):SetDeltaSize(w + 20, h + 10)
  else
    ;
    (self:GetRootWindow()):SetDeltaSize(w + 20, h + 10)
    local w, h = (self._text):GetPreferredSize()
    ;
    (self:GetRootWindow()):SetDeltaSize(w + 20, h + 10)
  end
end

ToastDialog.OnAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_4 , upvalues : _ENV
  if stateName == "ToastShow" then
    (DialogManager.DestroySingletonDialog)("toast.toastdialog")
  end
end

return ToastDialog

