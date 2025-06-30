-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemtipsgainspecialtextcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CItemSpecialAccess = (BeanManager.GetTableByName)("item.citemspecialaccess")
local ItemTipsGainSpecialTextCell = class("ItemTipsGainSpecialTextCell", Dialog)
ItemTipsGainSpecialTextCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainSpecialTextCell.AssetName = "ItemTipsNewGetSpecialCell"
ItemTipsGainSpecialTextCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemTipsGainSpecialTextCell
  ((ItemTipsGainSpecialTextCell.super).Ctor)(self, ...)
end

ItemTipsGainSpecialTextCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text")
  self._width = (self._text):GetRectSize()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  self._rootWindow_size_x = (self:GetRootWindow()):GetSize()
end

ItemTipsGainSpecialTextCell.OnDestroy = function(self)
  -- function num : 0_2
end

ItemTipsGainSpecialTextCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CItemSpecialAccess
  (self._text):SetText((TextManager.GetText)((CItemSpecialAccess:GetRecorder(data)).text))
  local _, textheight = (self._text):GetPreferredSize()
  if self._height < textheight then
    local delta = textheight - self._height
    ;
    (self._text):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._text):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._rootWindow_size_x, self._rootWindow_size_offset_x, self._rootWindow_size_y, self._rootWindow_size_offset_y + delta)
  else
    do
      ;
      (self._text):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
      ;
      (self._text):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
      ;
      (self:GetRootWindow()):SetSize(self._rootWindow_size_x, self._rootWindow_size_offset_x, self._rootWindow_size_y, self._rootWindow_size_offset_y)
    end
  end
end

return ItemTipsGainSpecialTextCell

