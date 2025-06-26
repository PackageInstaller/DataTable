-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/childlimitconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CChildLimitTextTable = (BeanManager.GetTableByName)("age.cchildlimittext")
local ChildLimitConfirmDialog = class("ChildLimitConfirmDialog", Dialog)
ChildLimitConfirmDialog.AssetBundleName = "ui/layouts.childlimit"
ChildLimitConfirmDialog.AssetName = "ChildLimitConfirm"
ChildLimitConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChildLimitConfirmDialog
  ((ChildLimitConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "BrokenLine"
  self._confirmBtnClickFunc = nil
end

ChildLimitConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._tipText = self:GetChild("Text")
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

ChildLimitConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ChildLimitConfirmDialog.Init = function(self, time, id, yesfunc)
  -- function num : 0_3 , upvalues : _ENV, CChildLimitTextTable
  if id == -1 then
    (self._tipText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1588, {time}))
  else
    if id == 4 then
      local txt = (CChildLimitTextTable:GetRecorder(id)).tipText
      ;
      (self._tipText):SetText(txt)
    else
      do
        do
          local txt = (string.gsub)((CChildLimitTextTable:GetRecorder(id)).tipText, "%$parameter1%$", time)
          ;
          (self._tipText):SetText(txt)
          self._confirmBtnClickFunc = yesfunc
        end
      end
    end
  end
end

ChildLimitConfirmDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_4
  if self._confirmBtnClickFunc then
    (self._confirmBtnClickFunc)()
    self._confirmBtnClickFunc = nil
  end
  self:Destroy()
end

return ChildLimitConfirmDialog

