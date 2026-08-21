-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadruledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local UndecidedRoadRuleDialog = class("UndecidedRoadRuleDialog", Dialog)
UndecidedRoadRuleDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRuleDialog.AssetName = "ActivityRoadRule"
UndecidedRoadRuleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadRuleDialog
  ((UndecidedRoadRuleDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

UndecidedRoadRuleDialog.OnCreate = function(self)
  -- function num : 0_1
  self._CloseBtn = self:GetChild("Back/CloseBtn")
  self._text = self:GetChild("Back/Frame/Text")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  ;
  (self._CloseBtn):Subscribe_PointerClickEvent(R4_PC23, R5_PC22)
end

UndecidedRoadRuleDialog.Init = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local str = (TextManager.GetText)(1900971)
  ;
  (self._text):SetText(str)
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

UndecidedRoadRuleDialog.OnDestroy = function(self)
  -- function num : 0_3
end

UndecidedRoadRuleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return UndecidedRoadRuleDialog

