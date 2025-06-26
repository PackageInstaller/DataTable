-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/messagetip/msgtipcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MsgTipCell = class("MsgTipCell", Dialog)
MsgTipCell.AssetBundleName = "ui/layouts.toast"
MsgTipCell.AssetName = "Toast"
MsgTipCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MsgTipCell
  ((MsgTipCell.super).Ctor)(self, ...)
end

MsgTipCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text")
  self._back = self:GetChild("Back")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._size_x = (self:GetRootWindow()):GetSize()
  self._pos_x = (self:GetRootWindow()):GetPosition()
end

MsgTipCell.OnDestroy = function(self)
  -- function num : 0_2
end

MsgTipCell.Refresh = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  (self._text):SetText(msg)
  local fontsize = (self._text):GetFontSize()
  local _, textheight = (self._text):GetPreferredSize()
  if self._height < textheight then
    local line = (math.ceil)((textheight - self._height) / self._oneline)
    local delta = line * fontsize
    ;
    (self._back):SetSize(self._size_x, self._size_offset_x, self._size_y, self._size_offset_y + delta)
    ;
    (self._back):SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._size_x, self._size_offset_x, self._size_y, self._size_offset_y + delta)
    ;
    (self:GetRootWindow()):SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta)
  end
end

return MsgTipCell

