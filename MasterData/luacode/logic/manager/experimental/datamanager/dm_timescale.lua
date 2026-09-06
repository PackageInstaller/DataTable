local Time = CS.UnityEngine.Time
local SpeedType = {
  Pause = 0,
  Normal = 1,
  Accelerate = tonumber(BeanManager.GetTableByName("battle.cbattleconstcfg"):GetRecorder(85).attr),
  BattleKillSlow = tonumber(BeanManager.GetTableByName("battle.cbattleconstcfg"):GetRecorder(98).attr)
}
local SettingType = {
  GuideBattle = 0,
  NormalBattle = 1,
  Timeline = 2,
  BattleKillSlow = 3,
  Game = 4
}
local DM_TimeScale = class("DM_TimeScale")

function DM_TimeScale:Ctor()
  self._timeScale = NekoData.Data.timeScale
end

function DM_TimeScale:Clear()
  while self._timeScale[#self._timeScale] do
    table.remove(self._timeScale, #self._timeScale)
  end
  self:UpdateTimeScale()
end

function DM_TimeScale:SetBattleNormalSpeed()
  table.insert(self._timeScale, {
    settingType = SettingType.NormalBattle,
    speedType = SpeedType.Normal
  })
  self:UpdateTimeScale()
end

function DM_TimeScale:SetBattleNTimesSpeed()
  table.insert(self._timeScale, {
    settingType = SettingType.NormalBattle,
    speedType = SpeedType.Accelerate
  })
  self:UpdateTimeScale()
end

function DM_TimeScale:CancelBattleNTimesSpeed()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.NormalBattle and value.speedType == SpeedType.Accelerate then
    table.remove(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelBattleNTimesSpeed:LastStateError")
  end
end

function DM_TimeScale:SetBattlePause()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.NormalBattle and value.speedType == SpeedType.Pause then
    LogInfo("DM_TimeScale", "SetBattlePause:LastState is NormalBattle")
  else
    table.insert(self._timeScale, {
      settingType = SettingType.NormalBattle,
      speedType = SpeedType.Pause
    })
    self:UpdateTimeScale()
  end
end

function DM_TimeScale:CancelBattlePause()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.NormalBattle and value.speedType == SpeedType.Pause then
    table.remove(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelBattlePause:LastStateError")
  end
end

function DM_TimeScale:SetBattleGuidePause()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.GuideBattle and value.speedType == SpeedType.Pause then
    LogInfo("DM_TimeScale", "SetBattleGuidePause:LastState is GuideBattlePause")
  else
    table.insert(self._timeScale, {
      settingType = SettingType.GuideBattle,
      speedType = SpeedType.Pause
    })
    self:UpdateTimeScale()
  end
end

function DM_TimeScale:CancelBattleGuidePause()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.GuideBattle and value.speedType == SpeedType.Pause then
    table.remove(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelBattleGuidePause:LastStateError")
  end
end

function DM_TimeScale:SetTimelinePause()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.Timeline and value.speedType == SpeedType.Pause then
    LogInfo("DM_TimeScale", "SetTimelinePause:LastState is TimelinePause")
  else
    table.insert(self._timeScale, {
      settingType = SettingType.Timeline,
      speedType = SpeedType.Pause
    })
    self:UpdateTimeScale()
  end
end

function DM_TimeScale:CancelTimelinePause()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.Timeline and value.speedType == SpeedType.Pause then
    table.remove(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelTimelinePause:LastStateError")
  end
end

function DM_TimeScale:SetBattleKillSpeed()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.BattleKillSlow and value.speedType == SpeedType.BattleKillSlow then
    LogInfo("DM_TimeScale", "SetBattleKillSpeed:LastState is SetBattleKillSpeed")
  else
    table.insert(self._timeScale, {
      settingType = SettingType.BattleKillSlow,
      speedType = SpeedType.BattleKillSlow
    })
    self:UpdateTimeScale()
  end
end

function DM_TimeScale:CancelBattleKillSpeed()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.BattleKillSlow and value.speedType == SpeedType.BattleKillSlow then
    table.remove(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelBattleKillSpeed:LastStateError")
  end
end

function DM_TimeScale:SetGamePause()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.Game and value.speedType == SpeedType.Pause then
    LogInfo("DM_TimeScale", "SetGamePause:LastState is GamePause")
  else
    table.insert(self._timeScale, {
      settingType = SettingType.Game,
      speedType = SpeedType.Pause
    })
    self:UpdateTimeScale()
  end
end

function DM_TimeScale:CancelGamePause()
  local value = self._timeScale[#self._timeScale]
  if value and value.settingType == SettingType.Game and value.speedType == SpeedType.Pause then
    table.remove(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelGamePause:LastStateError")
  end
end

function DM_TimeScale:UpdateTimeScale()
  local value = self._timeScale[#self._timeScale]
  if value then
    Time.timeScale = value.speedType
    LogInfoFormat("DM_TimeScale", "type = %s, Time.timeScale = %s", value.settingType, value.speedType)
  else
    Time.timeScale = SpeedType.Normal
    LogInfoFormat("DM_TimeScale", "Time.timeScale = %s", SpeedType.Normal)
  end
end

return DM_TimeScale
