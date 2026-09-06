local TableFrame = require("framework.ui.frame.table.tableframe")
local RelationExplainDialog = class("RelationExplainDialog", Dialog)
RelationExplainDialog.AssetBundleName = "ui/layouts.tujian"
RelationExplainDialog.AssetName = "TuJianCharInfoRelationExplain"

function RelationExplainDialog:Ctor(...)
  RelationExplainDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function RelationExplainDialog:OnCreate()
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnBackPressed, self)
  self._text = self:GetChild("Text")
end

function RelationExplainDialog:OnDestroy()
end

function RelationExplainDialog:OnBackPressed()
  self:Destroy()
  return true, true
end

return RelationExplainDialog
