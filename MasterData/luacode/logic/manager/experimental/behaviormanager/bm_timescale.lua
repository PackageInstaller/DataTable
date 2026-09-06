local Time = CS.UnityEngine.Time
local SpeedType = {
  Pause = 0,
  Normal = 1,
  Accelerate = tonumber(BeanManager.GetTableByName("battle.cbattleconstcfg"):GetRecorder(85).attr)
}
local SettingType = {
  GuideBattle = 0,
  NormalBattle = 1,
  Timeline = 2
}
local BM_TimeScale = class("BM_TimeScale")

function BM_TimeScale:Ctor()
  self._timeScale = NekoData.Data.timeScale
end

function BM_TimeScale:GetTimeScale()
  return Time.timeScale
end

function BM_TimeScale:IsBattleGuidePause()
  local value = self._timeScale[#self._timeScale]
  return value and value.settingType == SettingType.GuideBattle and value.speedType == SpeedType.Pause
end

return BM_TimeScale
