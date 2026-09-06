local DungeonFastMenuMainDialog = class("DungeonFastMenuMainDialog", Dialog)
DungeonFastMenuMainDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
DungeonFastMenuMainDialog.AssetName = "FastMenuMain"

function DungeonFastMenuMainDialog:Ctor(...)
  DungeonFastMenuMainDialog.super.Ctor(self, ...)
  self._groupName = "ModalFrame"
  self._dialogs = {}
end

function DungeonFastMenuMainDialog:OnCreate()
  self._menuBtn = self:GetChild("MenuBtn")
  self._menuBtn:SetActive(false)
  self._backBtn = self:GetChild("BackBtn")
  self._backBtnGuideEffect = self:GetChild("BackBtn/Effect")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnPointerClick, self)
end

function DungeonFastMenuMainDialog:OnDestroy()
  DialogManager.GetGroup("Modal"):CloseAllDialog()
end

function DungeonFastMenuMainDialog:AddNewDialog(dialog)
  table.insert(self._dialogs, dialog)
end

function DungeonFastMenuMainDialog:OnBackBtnPointerClick()
  if not DialogManager.GetGroup("Modal"):OnBackPointerClick() then
    self:Destroy()
  end
end

function DungeonFastMenuMainDialog:AddGuideDialogForReturn(guideId)
  local width, height = self._backBtnGuideEffect:GetRectSize()
  local screenPos = self._backBtnGuideEffect:GetLocalPointInUiRootPanel()
  local dialog = DialogManager.CreateSingletonDialog("guide.guidedialog")
  dialog:SetGuideId(guideId)
  dialog:SetGuidePoint(width, height, screenPos.x, screenPos.y)
  dialog = DialogManager.CreateSingletonDialog("guide.guidenextdialog")
  dialog:SetGuideId(guideId)
  dialog:SetTextPoint(width, height, screenPos.x, screenPos.y, "Left")
end

function DungeonFastMenuMainDialog:RemoveGuideDialogForReturn()
  DialogManager.DestroySingletonDialog("guide.guidenextdialog")
  DialogManager.DestroySingletonDialog("guide.guidedialog")
end

return DungeonFastMenuMainDialog
