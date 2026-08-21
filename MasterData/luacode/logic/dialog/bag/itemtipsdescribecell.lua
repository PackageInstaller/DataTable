-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemtipsdescribecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTipsDescribeCell = class("ItemTipsDescribeCell", Dialog)
ItemTipsDescribeCell.AssetBundleName = "ui/layouts.bag"
ItemTipsDescribeCell.AssetName = "ItemTipsNewDescribe"
ItemTipsDescribeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemTipsDescribeCell
  ((ItemTipsDescribeCell.super).Ctor)(self, ...)
end

ItemTipsDescribeCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Itemtips")
  ;
  (self._text):SetText("")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
end

ItemTipsDescribeCell.OnDestroy = function(self)
  -- function num : 0_2
end

ItemTipsDescribeCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._text):SetText(data.value)
  local fontsize = (self._text):GetFontSize()
  local _, textheight = (self._text):GetPreferredSize()
  if self._height < textheight then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    ;
    (self._text):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._text):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    ;
    (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
  else
    do
      ;
      (self._text):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
      ;
      (self._text):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
      ;
      (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
      ;
      (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
    end
  end
end

return ItemTipsDescribeCell

