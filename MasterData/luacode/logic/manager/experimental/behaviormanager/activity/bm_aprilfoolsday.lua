local PlayerPrefs = CS.UnityEngine.PlayerPrefs
local SUnlockFoolsDaysFunctionDef = LuaNetManager.GetProtocolDef("protocol.activity.sunlockfoolsdaysfunction")
local BM_AprilFoolsDay = class("BM_AprilFoolsDay")
local PlayerPrefPrefix = "AprilFoolsDay"
local PlayerPrefKey = "BeatClown"

function BM_AprilFoolsDay:Ctor()
  self._data = NekoData.Data.activities.aprilfoolsday
end

function BM_AprilFoolsDay:GetIsOpen()
  return self._data.beatClownIsOpen or self._data.shopIsOpen or self._data.gardenPartyIsOpen
end

function BM_AprilFoolsDay:IsBeatClownOpen()
  return self._data.beatClownIsOpen
end

function BM_AprilFoolsDay:IsShopOpen()
  return self._data.shopIsOpen
end

function BM_AprilFoolsDay:IsGardenPartyOpen()
  return self._data.gardenPartyIsOpen
end

function BM_AprilFoolsDay:IsGardenPartyTowerAndDungeonOpen()
  return self._data.gardenPartyTowerAndDungeonIsOpen
end

function BM_AprilFoolsDay:ShowRedDot()
  return NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenAprilFoolsDayDialog)
end

function BM_AprilFoolsDay:InitBeatClownNumber()
  local userid = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
  self._beatClownNumber = PlayerPrefs.GetInt(table.concat({
    userid,
    PlayerPrefPrefix,
    PlayerPrefKey
  }, "."), 0)
end

function BM_AprilFoolsDay:BeatClown()
  self._beatClownNumber = self._beatClownNumber + 1
end

function BM_AprilFoolsDay:SaveBeatClownNumber()
  local userid = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
  PlayerPrefs.SetInt(table.concat({
    userid,
    PlayerPrefPrefix,
    PlayerPrefKey
  }, "."), self._beatClownNumber)
end

function BM_AprilFoolsDay:GetBeatClownNumber()
  return self._beatClownNumber
end

function BM_AprilFoolsDay:ClearBeatClownNumber()
  self._beatClownNumber = 0
  local userid = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
  PlayerPrefs.SetInt(table.concat({
    userid,
    PlayerPrefPrefix,
    PlayerPrefKey
  }, "."), 0)
end

function BM_AprilFoolsDay:GetReceiveAwardTimes()
  return self._data.receiveAwardTimes
end

function BM_AprilFoolsDay:SetReceiveAwardTimes(times)
  self._data.receiveAwardTimes = times
end

function BM_AprilFoolsDay:GetRedDotStateWithType(t)
  return self._data.redDotShowList[t]
end

function BM_AprilFoolsDay:SetRedDotStateWithType(t, show)
  self._data.redDotShowList[t] = show
end

function BM_AprilFoolsDay:GetGardenPartyRoleList()
  return self._data.gardenPartyRoleList
end

function BM_AprilFoolsDay:GetGardenPartyCurrentFloorId()
  return self._data.gardenPartyCurrentFloorId
end

function BM_AprilFoolsDay:GetGardenPartyCurrentFloorState()
  return self._data.gardenPartyCurrentFloorState
end

function BM_AprilFoolsDay:GetGardenPartyDungeonBattle()
  return self._data.gardenPartyDungeonBattle
end

function BM_AprilFoolsDay:IfGardenPartyDungeonBattleUnlock()
  for _, t in ipairs(self._data.gardenPartyFunctionUnlock) do
    if t == SUnlockFoolsDaysFunctionDef.COPY_BATTLE then
      return true
    end
  end
end

function BM_AprilFoolsDay:IfGardenPartyShopUnlock()
  for _, t in ipairs(self._data.gardenPartyFunctionUnlock) do
    if t == SUnlockFoolsDaysFunctionDef.BLUE_CLOWN or t == SUnlockFoolsDaysFunctionDef.RED_CLOWN then
      return true
    end
  end
end

function BM_AprilFoolsDay:IfGardenPartyBlueShopUnlock()
  for _, t in ipairs(self._data.gardenPartyFunctionUnlock) do
    if t == SUnlockFoolsDaysFunctionDef.BLUE_CLOWN then
      return true
    end
  end
end

function BM_AprilFoolsDay:IfGardenPartyRedShopUnlock()
  for _, t in ipairs(self._data.gardenPartyFunctionUnlock) do
    if t == SUnlockFoolsDaysFunctionDef.RED_CLOWN then
      return true
    end
  end
end

function BM_AprilFoolsDay:GetGardenPartyGottenItemList()
  return self._data.gardenPartyGottenItemsList
end

function BM_AprilFoolsDay:GetGardenPartyResetConfigTimes()
  return self._data.gardenPartyResetConfigTimes
end

return BM_AprilFoolsDay
