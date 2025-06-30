-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/relationexplaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local RelationExplainDialog = class("RelationExplainDialog", Dialog)
RelationExplainDialog.AssetBundleName = "ui/layouts.tujian"
RelationExplainDialog.AssetName = "TuJianCharInfoRelationExplain"
RelationExplainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RelationExplainDialog
  ((RelationExplainDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

RelationExplainDialog.OnCreate = function(self)
  -- function num : 0_1
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnBackPressed, self)
  self._text = self:GetChild("Text")
end

RelationExplainDialog.OnDestroy = function(self)
  -- function num : 0_2
end

RelationExplainDialog.OnBackPressed = function(self)
  -- function num : 0_3
  self:Destroy()
  return true, true
end

return RelationExplainDialog

