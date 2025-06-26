-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/messagetip/instructionstipdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TopToBottom = 4
local InstructionsTipDialog = class("InstructionsTipDialog", Dialog)
InstructionsTipDialog.AssetBundleName = "ui/layouts.activityhud"
InstructionsTipDialog.AssetName = "ActivityTips"
InstructionsTipDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InstructionsTipDialog
  ((InstructionsTipDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

InstructionsTipDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TopToBottom
  self._title = self:GetChild("Back/Title")
  self._closeBtn = self:GetChild("CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._text = self:GetChild("Back/Frame/Text")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(TopToBottom)
  self._width = (self._text):GetRectSize()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, R4_PC32)
end

InstructionsTipDialog.OnDestroy = function(self)
  -- function num : 0_2
end

InstructionsTipDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

InstructionsTipDialog.SetData = function(self, record)
  -- function num : 0_4 , upvalues : _ENV
  (self._title):SetText((TextManager.GetText)(record.tipsId))
  ;
  (self._text):SetText((TextManager.GetText)(record.tipsTxtId))
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

return InstructionsTipDialog

