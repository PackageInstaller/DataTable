local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local FunctionUnlockDialog = class("FunctionUnlockDialog", Dialog)
FunctionUnlockDialog.AssetBundleName = "ui/layouts.basemainhud"
FunctionUnlockDialog.AssetName = "FunctionUnlock"

function FunctionUnlockDialog:Ctor(...)
  FunctionUnlockDialog.super.Ctor(self, ...)
  self._groupName = "Loading"
end

function FunctionUnlockDialog:OnCreate()
  self._title = self:GetChild("Title")
  self._image = self:GetChild("Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
end

function FunctionUnlockDialog:OnDestroy()
end

function FunctionUnlockDialog:SetData(data)
  local str = TextManager.GetText(CStringRes:GetRecorder(data.textID).msgTextID)
  self._title:SetText(str)
  if data.tips ~= 0 then
    local imageRecord = CImagePath:GetRecorder(data.tips)
    self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

function FunctionUnlockDialog:OnRootWindowClicked()
  self:Destroy()
end

return FunctionUnlockDialog
