local CStringRes = BeanManager.GetTableByName("message.cstringres")
local EquipFMTipsDialog = class("EquipFMTipsDialog", Dialog)
EquipFMTipsDialog.AssetBundleName = "ui/layouts.activityhud"
EquipFMTipsDialog.AssetName = "ActivityTips"
local TopToBottom = 4

function EquipFMTipsDialog:Ctor(...)
  EquipFMTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function EquipFMTipsDialog:OnCreate()
  self._titleTxt = self:GetChild("Back/Title")
  self._contentText = self:GetChild("Back/Frame/Text")
  self._confirmButton = self:GetChild("CloseBtn")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._titleTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1826).msgTextID))
  self._confirmButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._width, self._height = self._contentText:GetRectSize()
  local _ = 0
  _, self._oneline = self._contentText:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._contentText:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._contentText:GetPosition()
  self:Init()
end

function EquipFMTipsDialog:OnDestroy()
end

function EquipFMTipsDialog:Init()
  self._contentText:SetText(TextManager.GetText(CStringRes:GetRecorder(1441).msgTextID))
  local fontsize = self._contentText:GetFontSize()
  local _, textheight = self._contentText:GetPreferredSize()
  if textheight > self._height then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    self._contentText:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._contentText:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
end

function EquipFMTipsDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("equipforge.equipfmtipsdialog")
end

function EquipFMTipsDialog:OnCurPosChange(frame, proportion)
  local width, height = self._contentPanel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

return EquipFMTipsDialog
