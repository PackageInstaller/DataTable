-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolsdaytipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local AprilFoolsDayTipsDialog = class("AprilFoolsDayTipsDialog", Dialog)
AprilFoolsDayTipsDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsDayTipsDialog.AssetName = "ActivityAprilFoolsTips"
local TopToBottom = 4
AprilFoolsDayTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsDayTipsDialog
  ((AprilFoolsDayTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

AprilFoolsDayTipsDialog.OnCreate = function(self)
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

AprilFoolsDayTipsDialog.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1761)).msgTextID))
end

AprilFoolsDayTipsDialog.OnDestroy = function(self)
  -- function num : 0_3
end

AprilFoolsDayTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

AprilFoolsDayTipsDialog.SetData = function(self, textID, titleTextID)
  -- function num : 0_5 , upvalues : _ENV
  (self._text):SetText((TextManager.GetText)(textID))
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
  do
    if titleTextID then
      (self._title):SetText((TextManager.GetText)(titleTextID))
    end
  end
end

AprilFoolsDayTipsDialog.OnCurPosChange = function(self, frame, proportion)
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

return AprilFoolsDayTipsDialog

