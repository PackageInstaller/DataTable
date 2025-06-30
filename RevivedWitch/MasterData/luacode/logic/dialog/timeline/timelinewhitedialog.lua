-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/timeline/timelinewhitedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TimelineWhiteDialog = class("TimelineWhiteDialog", Dialog)
TimelineWhiteDialog.AssetBundleName = "ui/layouts.battlewin"
TimelineWhiteDialog.AssetName = "MemoryWhiteScreen"
TimelineWhiteDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TimelineWhiteDialog
  ((TimelineWhiteDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TimelineWhiteDialog.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_AnimationEvent("MemoryWhiteScreen", self.OnStateUpdate, self)
end

TimelineWhiteDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TimelineWhiteDialog.SetData = function(self, value)
  -- function num : 0_3 , upvalues : _ENV
  self._id = tonumber(value)
end

TimelineWhiteDialog.OnStateUpdate = function(self, handle, stateName, normalizedTime)
  -- function num : 0_4 , upvalues : _ENV
  self._dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
  ;
  (self._dialog):SetDialogLibraryId(self._id)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy)
end

TimelineWhiteDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  if (notification.userInfo)._dialogKey ~= (self._dialog)._dialogKey then
    return 
  end
  ;
  (DialogManager.DestroySingletonDialog)("timeline.timelinewhitedialog")
end

TimelineWhiteDialog.AddNewModal = function(self, dialog)
  -- function num : 0_6
end

return TimelineWhiteDialog

