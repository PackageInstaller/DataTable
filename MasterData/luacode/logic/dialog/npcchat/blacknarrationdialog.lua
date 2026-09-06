local BlackNarrationDialog = class("BlackNarrationDialog", Dialog)
BlackNarrationDialog.AssetBundleName = "ui/layouts.dramadialog"
BlackNarrationDialog.AssetName = "DramaNarratorDialogue"

function BlackNarrationDialog:Ctor(...)
  BlackNarrationDialog.super.Ctor(self, ...)
end

function BlackNarrationDialog:OnCreate()
  self._text = self:GetChild("UI/Back/Text")
  self._midText = self:GetChild("UI/BackTop/Text2")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimatorStateExit, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnRootWindowClick, self)
end

function BlackNarrationDialog:OnDestroy()
end

function BlackNarrationDialog:SetText(text, position)
  self._text:SetText(text)
  self._midText:SetText(text)
  self._text:SetActive(position ~= 1)
  self._midText:SetActive(position == 1)
end

function BlackNarrationDialog:OnRootWindowClick()
  local dialog = DialogManager.GetDialog("npcchat.newnpcchatdialog")
  if dialog then
    dialog:OnNextBtnClicked(nil, nil, true)
  end
end

function BlackNarrationDialog:Skip()
  if self._closing then
    return
  end
  self:GetRootWindow():SetAnimatorBool("onClose", true)
  self._closing = true
end

function BlackNarrationDialog:OnAnimatorStateExit(handle, stateName, normalizedTime)
  if stateName == "NarratorClose" then
    self:Destroy()
  end
end

return BlackNarrationDialog
