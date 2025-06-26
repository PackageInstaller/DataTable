-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/messagetip/msgtipconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MsgTipConfirmDialog = class("MsgTipConfirmDialog", Dialog)
MsgTipConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
MsgTipConfirmDialog.AssetName = "SingleConfirmLarge"
MsgTipConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MsgTipConfirmDialog
  ((MsgTipConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "Message"
  self._strList = {}
end

MsgTipConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text")
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

MsgTipConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2
end

MsgTipConfirmDialog.Refresh = function(self)
  -- function num : 0_3
  if #self._strList == 0 then
    self:Destroy()
  else
    ;
    (self._text):SetText((self._strList)[1])
  end
end

MsgTipConfirmDialog.AddConfirmTip = function(self, str)
  -- function num : 0_4 , upvalues : _ENV
  (table.insert)(self._strList, str)
  if #self._strList == 1 then
    self:Refresh()
  end
end

MsgTipConfirmDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (table.remove)(self._strList, 1)
  self:Refresh()
end

return MsgTipConfirmDialog

