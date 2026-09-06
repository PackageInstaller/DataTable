local DungeonTestSecondConfirmDialog = class("DungeonTestSecondConfirmDialog", Dialog)
DungeonTestSecondConfirmDialog.AssetBundleName = "ui/layouts.gm"
DungeonTestSecondConfirmDialog.AssetName = "DungeonTestSecondConfirm"

function DungeonTestSecondConfirmDialog:Ctor(...)
  DungeonTestSecondConfirmDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function DungeonTestSecondConfirmDialog:OnCreate()
  self._input = self:GetChild("InputField")
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

function DungeonTestSecondConfirmDialog:OnDestroy()
end

function DungeonTestSecondConfirmDialog:OnBackBtnClicked()
  self:Destroy()
end

function DungeonTestSecondConfirmDialog:OnClickConfirmBtn()
  local battleid = self._input:GetText()
  if battleid ~= "" and tonumber(battleid) then
    self:Destroy()
    NekoData.BehaviorManager.BM_Chat:SendMsg("//go " .. battleid)
  end
end

return DungeonTestSecondConfirmDialog
