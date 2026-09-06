local CItemSpecialAccess = BeanManager.GetTableByName("item.citemspecialaccess")
local ItemTipsGainSpecialTextCell = class("ItemTipsGainSpecialTextCell", Dialog)
ItemTipsGainSpecialTextCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainSpecialTextCell.AssetName = "ItemTipsNewGetSpecialCell"

function ItemTipsGainSpecialTextCell:Ctor(...)
  ItemTipsGainSpecialTextCell.super.Ctor(self, ...)
end

function ItemTipsGainSpecialTextCell:OnCreate()
  self._text = self:GetChild("Text")
  self._width, self._height = self._text:GetRectSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._rootWindow_size_x, self._rootWindow_size_offset_x, self._rootWindow_size_y, self._rootWindow_size_offset_y = self:GetRootWindow():GetSize()
end

function ItemTipsGainSpecialTextCell:OnDestroy()
end

function ItemTipsGainSpecialTextCell:RefreshCell(data)
  self._text:SetText(TextManager.GetText(CItemSpecialAccess:GetRecorder(data).text))
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local delta = textheight - self._height
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._rootWindow_size_x, self._rootWindow_size_offset_x, self._rootWindow_size_y, self._rootWindow_size_offset_y + delta)
  else
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
    self:GetRootWindow():SetSize(self._rootWindow_size_x, self._rootWindow_size_offset_x, self._rootWindow_size_y, self._rootWindow_size_offset_y)
  end
end

return ItemTipsGainSpecialTextCell
