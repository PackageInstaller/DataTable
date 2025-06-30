-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/buff/acceleratebuffdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AccelerateBuffDialog = class("AccelerateBuffDialog", Dialog)
local UIManager = ((CS.PixelNeko).UI).UIManager
AccelerateBuffDialog.AssetBundleName = "ui/layouts.dungeon"
AccelerateBuffDialog.AssetName = "DungeonBuff1"
AccelerateBuffDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AccelerateBuffDialog
  ((AccelerateBuffDialog.super).Ctor)(self, ...)
  self._groupName = "Operation"
end

AccelerateBuffDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._progress = self:GetChild("Progress")
  ;
  (self:GetRootWindow()):Subscribe_UpdateEvent(self.OnActorMove, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuffProgress, Common.n_SceneBuffProgress, nil)
end

AccelerateBuffDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

AccelerateBuffDialog.OnBuffProgress = function(self, notification)
  -- function num : 0_3
  self:SetProgress(1 - (notification.userInfo).current / (notification.userInfo).total)
end

AccelerateBuffDialog.OnActorMove = function(self)
  -- function num : 0_4 , upvalues : _ENV, UIManager
  local x, z = ((NekoData.BehaviorManager).BM_Dungeon):GetActorWorldPosition()
  local screenX, screenY = (UIManager.WorldToScreenPointInMargin)("Main", x, 0, z)
  local viewportX, viewportY = (UIManager.ScreenPointToLocalPointInRectangle)(self._textParentGO, screenX, screenY)
  ;
  (self:GetRootWindow()):SetAnchoredPosition(viewportX, viewportY)
end

AccelerateBuffDialog.SetProgress = function(self, progress)
  -- function num : 0_5
  (self._progress):SetFillAmount(progress)
end

return AccelerateBuffDialog

