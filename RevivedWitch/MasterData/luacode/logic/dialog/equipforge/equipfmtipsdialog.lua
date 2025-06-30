-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipfmtipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipFMTipsDialog = class("EquipFMTipsDialog", Dialog)
EquipFMTipsDialog.AssetBundleName = "ui/layouts.activityhud"
EquipFMTipsDialog.AssetName = "ActivityTips"
local TopToBottom = 4
EquipFMTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipFMTipsDialog
  ((EquipFMTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

EquipFMTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TopToBottom, _ENV, CStringRes
  self._titleTxt = self:GetChild("Back/Title")
  self._contentText = self:GetChild("Back/Frame/Text")
  self._confirmButton = self:GetChild("CloseBtn")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(TopToBottom)
  ;
  (self._titleTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1826)).msgTextID))
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._width = (self._contentText):GetRectSize()
  local _ = 0
  _ = (self._contentText):GetPreferredSize()
  self._text_size_x = (self._contentText):GetSize()
  self._text_pos_x = (self._contentText):GetPosition()
  self:Init()
end

EquipFMTipsDialog.OnDestroy = function(self)
  -- function num : 0_2
end

EquipFMTipsDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  (self._contentText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1441)).msgTextID))
  local fontsize = (self._contentText):GetFontSize()
  local _, textheight = (self._contentText):GetPreferredSize()
  if self._height < textheight then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    ;
    (self._contentText):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._contentText):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
end

EquipFMTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("equipforge.equipfmtipsdialog")
end

EquipFMTipsDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_5
  local width, height = (self._contentPanel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

return EquipFMTipsDialog

