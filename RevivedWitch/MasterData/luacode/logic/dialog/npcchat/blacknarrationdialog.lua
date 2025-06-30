-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/npcchat/blacknarrationdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BlackNarrationDialog = class("BlackNarrationDialog", Dialog)
BlackNarrationDialog.AssetBundleName = "ui/layouts.dramadialog"
BlackNarrationDialog.AssetName = "DramaNarratorDialogue"
BlackNarrationDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BlackNarrationDialog
  ((BlackNarrationDialog.super).Ctor)(self, ...)
end

BlackNarrationDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("UI/Back/Text")
  self._midText = self:GetChild("UI/BackTop/Text2")
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimatorStateExit, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnRootWindowClick, self)
end

BlackNarrationDialog.OnDestroy = function(self)
  -- function num : 0_2
end

BlackNarrationDialog.SetText = function(self, text, position)
  -- function num : 0_3
  (self._text):SetText(text)
  ;
  (self._midText):SetText(text)
  ;
  (self._text):SetActive(position ~= 1)
  ;
  (self._midText):SetActive(position == 1)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BlackNarrationDialog.OnRootWindowClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("npcchat.newnpcchatdialog")
  if dialog then
    dialog:OnNextBtnClicked(nil, nil, true)
  end
end

BlackNarrationDialog.Skip = function(self)
  -- function num : 0_5
  if self._closing then
    return 
  end
  ;
  (self:GetRootWindow()):SetAnimatorBool("onClose", true)
  self._closing = true
end

BlackNarrationDialog.OnAnimatorStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_6
  if stateName == "NarratorClose" then
    self:Destroy()
  end
end

return BlackNarrationDialog

