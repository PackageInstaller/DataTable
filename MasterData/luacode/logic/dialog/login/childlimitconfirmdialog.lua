local CChildLimitTextTable = BeanManager.GetTableByName("age.cchildlimittext")
local ChildLimitConfirmDialog = class("ChildLimitConfirmDialog", Dialog)
ChildLimitConfirmDialog.AssetBundleName = "ui/layouts.childlimit"
ChildLimitConfirmDialog.AssetName = "ChildLimitConfirm"

function ChildLimitConfirmDialog:Ctor(...)
  ChildLimitConfirmDialog.super.Ctor(self, ...)
  self._groupName = "BrokenLine"
  self._confirmBtnClickFunc = nil
end

function ChildLimitConfirmDialog:OnCreate()
  self._tipText = self:GetChild("Text")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function ChildLimitConfirmDialog:OnDestroy()
end

function ChildLimitConfirmDialog:Init(time, id, yesfunc)
  if id == -1 then
    self._tipText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1588, {time}))
  elseif id == 4 then
    local txt = CChildLimitTextTable:GetRecorder(id).tipText
    self._tipText:SetText(txt)
  else
    local txt = string.gsub(CChildLimitTextTable:GetRecorder(id).tipText, "%$parameter1%$", time)
    self._tipText:SetText(txt)
  end
  self._confirmBtnClickFunc = yesfunc
end

function ChildLimitConfirmDialog:OnConfirmBtnClicked()
  if self._confirmBtnClickFunc then
    self._confirmBtnClickFunc()
    self._confirmBtnClickFunc = nil
  end
  self:Destroy()
end

return ChildLimitConfirmDialog
