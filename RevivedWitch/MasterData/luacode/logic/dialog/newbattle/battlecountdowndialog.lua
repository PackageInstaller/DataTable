-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlecountdowndialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SoundLevelTable = (BeanManager.GetTableByName)("setting.csoundlevel")
local BattleCountDownDialog = class("BattleCountDownDialog", Dialog)
BattleCountDownDialog.AssetBundleName = "ui/layouts.battlenew"
BattleCountDownDialog.AssetName = "BattleCountDown"
BattleCountDownDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleCountDownDialog
  ((BattleCountDownDialog.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
end

BattleCountDownDialog.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

BattleCountDownDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV, SoundLevelTable
  ((NekoData.DataManager).DM_TimeScale):CancelBattlePause()
  local categoryRecord = SoundLevelTable:GetRecorder(4)
  if categoryRecord then
    (LuaAudioManager.PauseCategory)(tonumber(categoryRecord.categoryID), false)
  end
end

BattleCountDownDialog.OnAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_3
  self:Destroy()
end

return BattleCountDownDialog

