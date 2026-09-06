local CStringRes = BeanManager.GetTableByName("message.cstringres")
local AgeTipsPopDialog = class("AgeTipsPopDialog", Dialog)
AgeTipsPopDialog.AssetBundleName = "ui/layouts"
AgeTipsPopDialog.AssetName = "AgeTipsPop"

function AgeTipsPopDialog:Ctor(...)
  AgeTipsPopDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function AgeTipsPopDialog:OnCreate()
  self._text = self:GetChild("Back/Frame/Text")
  self._closeBtn = self:GetChild("CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
end

function AgeTipsPopDialog:OnDestroy()
end

function AgeTipsPopDialog:Init()
  local str = TextManager.GetText(CStringRes:GetRecorder(1499).msgTextID)
  self._text:SetText(str)
  local fontsize = self._text:GetFontSize()
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
end

function AgeTipsPopDialog:OnBackBtnClicked()
  self:Destroy()
end

return AgeTipsPopDialog
