-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/tipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local UIManager = ((CS.PixelNeko).UI).UIManager
local TopToBottom = 4
local TipsDialog = class("TipsDialog", Dialog)
TipsDialog.AssetBundleName = "ui/layouts.activitynewyear"
TipsDialog.AssetName = "ActivityNewYearTips"
TipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TipsDialog
  ((TipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

TipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TopToBottom
  self._title = self:GetChild("Back/Title")
  self._closeBtn = self:GetChild("CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._text = self:GetChild("Back/Frame/Text")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(TopToBottom)
  self:SetStaticRes()
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(R4_PC41, R5_PC40)
end

TipsDialog.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1636)).msgTextID))
end

TipsDialog.OnDestroy = function(self)
  -- function num : 0_3
end

TipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

TipsDialog.SetData = function(self, textID, parameter)
  -- function num : 0_5 , upvalues : _ENV
  (self._text):SetText((TextManager.GetText)(textID, parameter))
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

TipsDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_6
  local width, height = (self._panel):GetRectSize()
  local total = (self._text):GetTotalLength()
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

return TipsDialog

