-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/confirmbox/confirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ConfirmDialog = class("ConfirmDialog", Dialog)
ConfirmDialog.AssetBundleName = "ui/layouts.gacha"
ConfirmDialog.AssetName = "GachaConfirm"
ConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ConfirmDialog
  ((ConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._strList = {}
end

ConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text")
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

ConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ConfirmDialog.Refresh = function(self)
  -- function num : 0_3
  if #self._strList == 0 then
    self:Destroy()
  else
    ;
    (self._text):SetText(((self._strList)[1]).str)
  end
end

ConfirmDialog.AddConfirmDialog = function(self, str, confirmFunc)
  -- function num : 0_4 , upvalues : _ENV
  (table.insert)(self._strList, {str = str, confirmFunc = confirmFunc})
  if #self._strList == 1 then
    self:Refresh()
  end
end

ConfirmDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if ((self._strList)[1]).confirmFunc then
    (((self._strList)[1]).confirmFunc)()
  end
  ;
  (table.remove)(self._strList, 1)
  self:Refresh()
end

return ConfirmDialog

