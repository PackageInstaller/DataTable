-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/memory/memorydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MemoryDialog = class("MemoryDialog", Dialog)
MemoryDialog.AssetBundleName = "ui/layouts.memory"
MemoryDialog.AssetName = "Memory"
MemoryDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MemoryDialog
  ((MemoryDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._baseSceneController = nil
end

MemoryDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(true)
end

MemoryDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
  ;
  (UIBackManager.SetUIBackShow)(false)
end

MemoryDialog.Init = function(self, sceneController)
  -- function num : 0_3
  self._baseSceneController = sceneController
end

MemoryDialog.OnBackPressed = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("memory.memorydialog")
end

return MemoryDialog

