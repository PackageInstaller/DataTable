-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/agetipspopdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local AgeTipsPopDialog = class("AgeTipsPopDialog", Dialog)
AgeTipsPopDialog.AssetBundleName = "ui/layouts"
AgeTipsPopDialog.AssetName = "AgeTipsPop"
AgeTipsPopDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AgeTipsPopDialog
  ((AgeTipsPopDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

AgeTipsPopDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Back/Frame/Text")
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
end

AgeTipsPopDialog.OnDestroy = function(self)
  -- function num : 0_2
end

AgeTipsPopDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1499)).msgTextID)
  ;
  (self._text):SetText(str)
  local fontsize = (self._text):GetFontSize()
  local _, textheight = (self._text):GetPreferredSize()
  if self._height < textheight then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    ;
    (self._text):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._text):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
end

AgeTipsPopDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return AgeTipsPopDialog

