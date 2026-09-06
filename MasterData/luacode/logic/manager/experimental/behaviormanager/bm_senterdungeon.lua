local BM_SEnterDungeon = class("BM_SEnterDungeon")

function BM_SEnterDungeon:Ctor()
  self._senterdungeoninfo = NekoData.Data.senterdungeoninfo
  self._dm = NekoData.DataManager.DM_SEnterDungeon
end

function BM_SEnterDungeon:GetId()
  return self._senterdungeoninfo.id
end

function BM_SEnterDungeon:GetPoint()
  return self._senterdungeoninfo.point
end

function BM_SEnterDungeon:GetSwitches()
  return self._senterdungeoninfo.switches
end

function BM_SEnterDungeon:GetTraps()
  return self._senterdungeoninfo.traps
end

function BM_SEnterDungeon:GetRandomItems()
  return self._senterdungeoninfo.randomItems
end

function BM_SEnterDungeon:GetSceneObjects()
  return self._senterdungeoninfo.sceneObjects
end

function BM_SEnterDungeon:GetNPCObjects()
  return self._senterdungeoninfo.npcObjects
end

function BM_SEnterDungeon:GetDisabledSceneObjects()
  return self._senterdungeoninfo.disabledSceneObjects
end

function BM_SEnterDungeon:GetReservedEvents()
  return self._senterdungeoninfo.events
end

function BM_SEnterDungeon:GetMonsters()
  return self._senterdungeoninfo.monsters
end

function BM_SEnterDungeon:GetChests()
  return self._senterdungeoninfo.chests
end

function BM_SEnterDungeon:GetLastBattleInfo()
  return self._senterdungeoninfo.battleResult
end

function BM_SEnterDungeon:GetCurBattleInfo()
  return self._senterdungeoninfo.curBattleInfo
end

function BM_SEnterDungeon:GetTopMessage()
  return self._senterdungeoninfo.topMessage
end

function BM_SEnterDungeon:GetRestoreEffectInfo()
  return self._senterdungeoninfo.reconnect
end

function BM_SEnterDungeon:GetModules()
  return self._senterdungeoninfo.modules
end

function BM_SEnterDungeon:GetSTriggleEventId()
  local eventIdList = self._dm.striggleEventId or {}
  self._dm.striggleEventId = {}
  return eventIdList
end

function BM_SEnterDungeon:GetInteractive()
  return self._senterdungeoninfo.interactive
end

function BM_SEnterDungeon:GetScrollInfo()
  return self._senterdungeoninfo.scrollinfo
end

function BM_SEnterDungeon:GetBuffs()
  return self._senterdungeoninfo.buffs
end

return BM_SEnterDungeon
