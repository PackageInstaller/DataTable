-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_timescale.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Time = (CS.UnityEngine).Time
local SpeedType = {Pause = 0, Normal = 1, Accelerate = tonumber((((BeanManager.GetTableByName)("battle.cbattleconstcfg")):GetRecorder(85)).attr)}
local SettingType = {GuideBattle = 0, NormalBattle = 1, Timeline = 2}
local BM_TimeScale = class("BM_TimeScale")
BM_TimeScale.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._timeScale = (NekoData.Data).timeScale
end

BM_TimeScale.GetTimeScale = function(self)
  -- function num : 0_1 , upvalues : Time
  return Time.timeScale
end

BM_TimeScale.IsBattleGuidePause = function(self)
  -- function num : 0_2 , upvalues : SettingType, SpeedType
  local value = (self._timeScale)[#self._timeScale]
  do return not value or (value.settingType == SettingType.GuideBattle and value.speedType == SpeedType.Pause) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return BM_TimeScale

