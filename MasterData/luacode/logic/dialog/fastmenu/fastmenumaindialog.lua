local FastMenuMainDialog = class("FastMenuMainDialog", Dialog)
FastMenuMainDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
FastMenuMainDialog.AssetName = "FastMenuMain"

function FastMenuMainDialog:Ctor(...)
  FastMenuMainDialog.super.Ctor(self, ...)
  self._groupName = "ModalFrame"
  self._dialogs = {}
end

function FastMenuMainDialog:OnCreate()
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._backBtnGuideEffect = self:GetChild("BackBtn/Effect")
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnPointerClick, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnPointerClick, self)
end

function FastMenuMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.GetGroup("Modal"):CloseAllDialog()
  DialogManager.DestroySingletonDialog("fastmenu.fastmenudialog")
end

function FastMenuMainDialog:ChangeBackBtnStatus(status)
  self._backBtn:SetActive(status)
end

function FastMenuMainDialog:OnMenuBtnPointerClick()
  local dialog = DialogManager.GetDialog("fastmenu.fastmenudialog")
  if dialog then
    DialogManager.DestroySingletonDialog("fastmenu.fastmenudialog")
  else
    DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
  end
end

function FastMenuMainDialog:AddNewDialog(dialog)
  table.insert(self._dialogs, dialog)
end

function FastMenuMainDialog:OnBackBtnPointerClick()
  if not DialogManager.GetGroup("Modal"):OnBackPointerClick() then
    self:Destroy()
  end
end

function FastMenuMainDialog:DestroyAllDialogs()
  DialogManager.GetGroup("Modal"):CloseAllDialog()
  self:Destroy()
end

function FastMenuMainDialog:AddGuideDialogForReturn(guideId)
  local width, height = self._backBtnGuideEffect:GetRectSize()
  local screenPos = self._backBtnGuideEffect:GetLocalPointInUiRootPanel()
  local dialog = DialogManager.CreateSingletonDialog("guide.guidedialog")
  dialog:SetGuideId(guideId)
  dialog:SetGuidePoint(width, height, screenPos.x, screenPos.y)
  DialogManager.CreateSingletonDialog("guide.guidenextdialog"):SetTextPoint(width, height, screenPos.x, screenPos.y, "Left")
end

function FastMenuMainDialog:RemoveGuideDialogForReturn()
  DialogManager.DestroySingletonDialog("guide.guidenextdialog")
  DialogManager.DestroySingletonDialog("guide.guidedialog")
end

return FastMenuMainDialog
