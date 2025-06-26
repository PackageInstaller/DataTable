-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_aprilfoolsday.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PlayerPrefs = (CS.UnityEngine).PlayerPrefs
local SUnlockFoolsDaysFunctionDef = (LuaNetManager.GetProtocolDef)("protocol.activity.sunlockfoolsdaysfunction")
local BM_AprilFoolsDay = class("BM_AprilFoolsDay")
local PlayerPrefPrefix = "AprilFoolsDay"
local PlayerPrefKey = "BeatClown"
BM_AprilFoolsDay.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).aprilfoolsday
end

BM_AprilFoolsDay.GetIsOpen = function(self)
  -- function num : 0_1
  if not (self._data).beatClownIsOpen and not (self._data).shopIsOpen then
    return (self._data).gardenPartyIsOpen
  end
end

BM_AprilFoolsDay.IsBeatClownOpen = function(self)
  -- function num : 0_2
  return (self._data).beatClownIsOpen
end

BM_AprilFoolsDay.IsShopOpen = function(self)
  -- function num : 0_3
  return (self._data).shopIsOpen
end

BM_AprilFoolsDay.IsGardenPartyOpen = function(self)
  -- function num : 0_4
  return (self._data).gardenPartyIsOpen
end

BM_AprilFoolsDay.IsGardenPartyTowerAndDungeonOpen = function(self)
  -- function num : 0_5
  return (self._data).gardenPartyTowerAndDungeonIsOpen
end

BM_AprilFoolsDay.ShowRedDot = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenAprilFoolsDayDialog)
end

BM_AprilFoolsDay.InitBeatClownNumber = function(self)
  -- function num : 0_7 , upvalues : _ENV, PlayerPrefs, PlayerPrefPrefix, PlayerPrefKey
  local userid = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
  self._beatClownNumber = (PlayerPrefs.GetInt)((table.concat)({userid, PlayerPrefPrefix, PlayerPrefKey}, "."), 0)
end

BM_AprilFoolsDay.BeatClown = function(self)
  -- function num : 0_8
  self._beatClownNumber = self._beatClownNumber + 1
end

BM_AprilFoolsDay.SaveBeatClownNumber = function(self)
  -- function num : 0_9 , upvalues : _ENV, PlayerPrefs, PlayerPrefPrefix, PlayerPrefKey
  local userid = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
  ;
  (PlayerPrefs.SetInt)((table.concat)({userid, PlayerPrefPrefix, PlayerPrefKey}, "."), self._beatClownNumber)
end

BM_AprilFoolsDay.GetBeatClownNumber = function(self)
  -- function num : 0_10
  return self._beatClownNumber
end

BM_AprilFoolsDay.ClearBeatClownNumber = function(self)
  -- function num : 0_11 , upvalues : _ENV, PlayerPrefs, PlayerPrefPrefix, PlayerPrefKey
  self._beatClownNumber = 0
  local userid = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
  ;
  (PlayerPrefs.SetInt)((table.concat)({userid, PlayerPrefPrefix, PlayerPrefKey}, "."), 0)
end

BM_AprilFoolsDay.GetReceiveAwardTimes = function(self)
  -- function num : 0_12
  return (self._data).receiveAwardTimes
end

BM_AprilFoolsDay.SetReceiveAwardTimes = function(self, times)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).receiveAwardTimes = times
end

BM_AprilFoolsDay.GetRedDotStateWithType = function(self, t)
  -- function num : 0_14
  return ((self._data).redDotShowList)[t]
end

BM_AprilFoolsDay.SetRedDotStateWithType = function(self, t, show)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self._data).redDotShowList)[t] = show
end

BM_AprilFoolsDay.GetGardenPartyRoleList = function(self)
  -- function num : 0_16
  return (self._data).gardenPartyRoleList
end

BM_AprilFoolsDay.GetGardenPartyCurrentFloorId = function(self)
  -- function num : 0_17
  return (self._data).gardenPartyCurrentFloorId
end

BM_AprilFoolsDay.GetGardenPartyCurrentFloorState = function(self)
  -- function num : 0_18
  return (self._data).gardenPartyCurrentFloorState
end

BM_AprilFoolsDay.GetGardenPartyDungeonBattle = function(self)
  -- function num : 0_19
  return (self._data).gardenPartyDungeonBattle
end

BM_AprilFoolsDay.IfGardenPartyDungeonBattleUnlock = function(self)
  -- function num : 0_20 , upvalues : _ENV, SUnlockFoolsDaysFunctionDef
  for _,t in ipairs((self._data).gardenPartyFunctionUnlock) do
    if t == SUnlockFoolsDaysFunctionDef.COPY_BATTLE then
      return true
    end
  end
end

BM_AprilFoolsDay.IfGardenPartyShopUnlock = function(self)
  -- function num : 0_21 , upvalues : _ENV, SUnlockFoolsDaysFunctionDef
  for _,t in ipairs((self._data).gardenPartyFunctionUnlock) do
    if t == SUnlockFoolsDaysFunctionDef.BLUE_CLOWN or t == SUnlockFoolsDaysFunctionDef.RED_CLOWN then
      return true
    end
  end
end

BM_AprilFoolsDay.IfGardenPartyBlueShopUnlock = function(self)
  -- function num : 0_22 , upvalues : _ENV, SUnlockFoolsDaysFunctionDef
  for _,t in ipairs((self._data).gardenPartyFunctionUnlock) do
    if t == SUnlockFoolsDaysFunctionDef.BLUE_CLOWN then
      return true
    end
  end
end

BM_AprilFoolsDay.IfGardenPartyRedShopUnlock = function(self)
  -- function num : 0_23 , upvalues : _ENV, SUnlockFoolsDaysFunctionDef
  for _,t in ipairs((self._data).gardenPartyFunctionUnlock) do
    if t == SUnlockFoolsDaysFunctionDef.RED_CLOWN then
      return true
    end
  end
end

BM_AprilFoolsDay.GetGardenPartyGottenItemList = function(self)
  -- function num : 0_24
  return (self._data).gardenPartyGottenItemsList
end

BM_AprilFoolsDay.GetGardenPartyResetConfigTimes = function(self)
  -- function num : 0_25
  return (self._data).gardenPartyResetConfigTimes
end

return BM_AprilFoolsDay

