local TableFrame = require("framework.ui.frame.table.tableframe")
local CJigsawText = BeanManager.GetTableByName("activity.cjigsawtext")
local PuzzleTipDialog = class("PuzzleTipDialog", Dialog)
PuzzleTipDialog.AssetBundleName = "ui/layouts.activitypuzzle"
PuzzleTipDialog.AssetName = "ActivityPuzzleTips"

function PuzzleTipDialog:Ctor(...)
  PuzzleTipDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function PuzzleTipDialog:OnCreate()
  self._CloseBtn = self:GetChild("Back/CloseBtn")
  self._text = self:GetChild("Back/Frame/Text")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._CloseBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function PuzzleTipDialog:Init(id)
  local recorder = CJigsawText:GetRecorder(id)
  if recorder then
    local str = TextManager.GetText(recorder.TextID)
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
end

function PuzzleTipDialog:OnDestroy()
end

function PuzzleTipDialog:OnBackBtnClicked()
  self:Destroy()
end

return PuzzleTipDialog
