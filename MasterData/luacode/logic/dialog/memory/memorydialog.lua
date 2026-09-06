local MemoryDialog = class("MemoryDialog", Dialog)
MemoryDialog.AssetBundleName = "ui/layouts.memory"
MemoryDialog.AssetName = "Memory"

function MemoryDialog:Ctor(...)
  MemoryDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._baseSceneController = nil
end

function MemoryDialog:OnCreate()
  UIBackManager.SetUIBackShow(true)
end

function MemoryDialog:OnDestroy()
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
  UIBackManager.SetUIBackShow(false)
end

function MemoryDialog:Init(sceneController)
  self._baseSceneController = sceneController
end

function MemoryDialog:OnBackPressed()
  DialogManager.DestroySingletonDialog("memory.memorydialog")
end

return MemoryDialog
