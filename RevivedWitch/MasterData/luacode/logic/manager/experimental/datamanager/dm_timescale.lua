-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_timescale.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Time = (CS.UnityEngine).Time
local SpeedType = {Pause = 0, Normal = 1, Accelerate = tonumber((((BeanManager.GetTableByName)("battle.cbattleconstcfg")):GetRecorder(85)).attr), BattleKillSlow = tonumber((((BeanManager.GetTableByName)("battle.cbattleconstcfg")):GetRecorder(98)).attr)}
local SettingType = {GuideBattle = 0, NormalBattle = 1, Timeline = 2, BattleKillSlow = 3, Game = 4}
local DM_TimeScale = class("DM_TimeScale")
DM_TimeScale.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._timeScale = (NekoData.Data).timeScale
end

DM_TimeScale.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  while (self._timeScale)[#self._timeScale] do
    (table.remove)(self._timeScale, #self._timeScale)
  end
  self:UpdateTimeScale()
end

DM_TimeScale.SetBattleNormalSpeed = function(self)
  -- function num : 0_2 , upvalues : _ENV, SettingType, SpeedType
  (table.insert)(self._timeScale, {settingType = SettingType.NormalBattle, speedType = SpeedType.Normal})
  self:UpdateTimeScale()
end

DM_TimeScale.SetBattleNTimesSpeed = function(self)
  -- function num : 0_3 , upvalues : _ENV, SettingType, SpeedType
  (table.insert)(self._timeScale, {settingType = SettingType.NormalBattle, speedType = SpeedType.Accelerate})
  self:UpdateTimeScale()
end

DM_TimeScale.CancelBattleNTimesSpeed = function(self)
  -- function num : 0_4 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.NormalBattle and value.speedType == SpeedType.Accelerate then
    (table.remove)(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelBattleNTimesSpeed:LastStateError")
  end
end

DM_TimeScale.SetBattlePause = function(self)
  -- function num : 0_5 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.NormalBattle and value.speedType == SpeedType.Pause then
    LogInfo("DM_TimeScale", "SetBattlePause:LastState is NormalBattle")
  else
    ;
    (table.insert)(self._timeScale, {settingType = SettingType.NormalBattle, speedType = SpeedType.Pause})
    self:UpdateTimeScale()
  end
end

DM_TimeScale.CancelBattlePause = function(self)
  -- function num : 0_6 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.NormalBattle and value.speedType == SpeedType.Pause then
    (table.remove)(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelBattlePause:LastStateError")
  end
end

DM_TimeScale.SetBattleGuidePause = function(self)
  -- function num : 0_7 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.GuideBattle and value.speedType == SpeedType.Pause then
    LogInfo("DM_TimeScale", "SetBattleGuidePause:LastState is GuideBattlePause")
  else
    ;
    (table.insert)(self._timeScale, {settingType = SettingType.GuideBattle, speedType = SpeedType.Pause})
    self:UpdateTimeScale()
  end
end

DM_TimeScale.CancelBattleGuidePause = function(self)
  -- function num : 0_8 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.GuideBattle and value.speedType == SpeedType.Pause then
    (table.remove)(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelBattleGuidePause:LastStateError")
  end
end

DM_TimeScale.SetTimelinePause = function(self)
  -- function num : 0_9 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.Timeline and value.speedType == SpeedType.Pause then
    LogInfo("DM_TimeScale", "SetTimelinePause:LastState is TimelinePause")
  else
    ;
    (table.insert)(self._timeScale, {settingType = SettingType.Timeline, speedType = SpeedType.Pause})
    self:UpdateTimeScale()
  end
end

DM_TimeScale.CancelTimelinePause = function(self)
  -- function num : 0_10 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.Timeline and value.speedType == SpeedType.Pause then
    (table.remove)(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelTimelinePause:LastStateError")
  end
end

DM_TimeScale.SetBattleKillSpeed = function(self)
  -- function num : 0_11 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.BattleKillSlow and value.speedType == SpeedType.BattleKillSlow then
    LogInfo("DM_TimeScale", "SetBattleKillSpeed:LastState is SetBattleKillSpeed")
  else
    ;
    (table.insert)(self._timeScale, {settingType = SettingType.BattleKillSlow, speedType = SpeedType.BattleKillSlow})
    self:UpdateTimeScale()
  end
end

DM_TimeScale.CancelBattleKillSpeed = function(self)
  -- function num : 0_12 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.BattleKillSlow and value.speedType == SpeedType.BattleKillSlow then
    (table.remove)(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelBattleKillSpeed:LastStateError")
  end
end

DM_TimeScale.SetGamePause = function(self)
  -- function num : 0_13 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.Game and value.speedType == SpeedType.Pause then
    LogInfo("DM_TimeScale", "SetGamePause:LastState is GamePause")
  else
    ;
    (table.insert)(self._timeScale, {settingType = SettingType.Game, speedType = SpeedType.Pause})
    self:UpdateTimeScale()
  end
end

DM_TimeScale.CancelGamePause = function(self)
  -- function num : 0_14 , upvalues : SettingType, SpeedType, _ENV
  local value = (self._timeScale)[#self._timeScale]
  if value and value.settingType == SettingType.Game and value.speedType == SpeedType.Pause then
    (table.remove)(self._timeScale, #self._timeScale)
    self:UpdateTimeScale()
  else
    LogInfo("DM_TimeScale", "CancelGamePause:LastStateError")
  end
end

DM_TimeScale.UpdateTimeScale = function(self)
  -- function num : 0_15 , upvalues : Time, _ENV, SpeedType
  local value = (self._timeScale)[#self._timeScale]
  if value then
    Time.timeScale = value.speedType
    LogInfoFormat("DM_TimeScale", "type = %s, Time.timeScale = %s", value.settingType, value.speedType)
  else
    Time.timeScale = SpeedType.Normal
    LogInfoFormat("DM_TimeScale", "Time.timeScale = %s", SpeedType.Normal)
  end
end

return DM_TimeScale

