local SoundLevelTable = BeanManager.GetTableByName("setting.csoundlevel")
local BattleCountDownDialog = class("BattleCountDownDialog", Dialog)
BattleCountDownDialog.AssetBundleName = "ui/layouts.battlenew"
BattleCountDownDialog.AssetName = "BattleCountDown"

function BattleCountDownDialog:Ctor(...)
  BattleCountDownDialog.super.Ctor(self, ...)
  self._groupName = "ModalFrame"
end

function BattleCountDownDialog:OnCreate()
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

function BattleCountDownDialog:OnDestroy()
  NekoData.DataManager.DM_TimeScale:CancelBattlePause()
  local categoryRecord = SoundLevelTable:GetRecorder(4)
  if categoryRecord then
    LuaAudioManager.PauseCategory(tonumber(categoryRecord.categoryID), false)
  end
end

function BattleCountDownDialog:OnAnimationStateExit(handler, stateName, normalizedTime)
  self:Destroy()
end

return BattleCountDownDialog
