-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_senterdungeon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_SEnterDungeon = class("BM_SEnterDungeon")
BM_SEnterDungeon.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._senterdungeoninfo = (NekoData.Data).senterdungeoninfo
  self._dm = (NekoData.DataManager).DM_SEnterDungeon
end

BM_SEnterDungeon.GetId = function(self)
  -- function num : 0_1
  return (self._senterdungeoninfo).id
end

BM_SEnterDungeon.GetPoint = function(self)
  -- function num : 0_2
  return (self._senterdungeoninfo).point
end

BM_SEnterDungeon.GetSwitches = function(self)
  -- function num : 0_3
  return (self._senterdungeoninfo).switches
end

BM_SEnterDungeon.GetTraps = function(self)
  -- function num : 0_4
  return (self._senterdungeoninfo).traps
end

BM_SEnterDungeon.GetRandomItems = function(self)
  -- function num : 0_5
  return (self._senterdungeoninfo).randomItems
end

BM_SEnterDungeon.GetSceneObjects = function(self)
  -- function num : 0_6
  return (self._senterdungeoninfo).sceneObjects
end

BM_SEnterDungeon.GetNPCObjects = function(self)
  -- function num : 0_7
  return (self._senterdungeoninfo).npcObjects
end

BM_SEnterDungeon.GetDisabledSceneObjects = function(self)
  -- function num : 0_8
  return (self._senterdungeoninfo).disabledSceneObjects
end

BM_SEnterDungeon.GetReservedEvents = function(self)
  -- function num : 0_9
  return (self._senterdungeoninfo).events
end

BM_SEnterDungeon.GetMonsters = function(self)
  -- function num : 0_10
  return (self._senterdungeoninfo).monsters
end

BM_SEnterDungeon.GetChests = function(self)
  -- function num : 0_11
  return (self._senterdungeoninfo).chests
end

BM_SEnterDungeon.GetLastBattleInfo = function(self)
  -- function num : 0_12
  return (self._senterdungeoninfo).battleResult
end

BM_SEnterDungeon.GetCurBattleInfo = function(self)
  -- function num : 0_13
  return (self._senterdungeoninfo).curBattleInfo
end

BM_SEnterDungeon.GetTopMessage = function(self)
  -- function num : 0_14
  return (self._senterdungeoninfo).topMessage
end

BM_SEnterDungeon.GetRestoreEffectInfo = function(self)
  -- function num : 0_15
  return (self._senterdungeoninfo).reconnect
end

BM_SEnterDungeon.GetModules = function(self)
  -- function num : 0_16
  return (self._senterdungeoninfo).modules
end

BM_SEnterDungeon.GetSTriggleEventId = function(self)
  -- function num : 0_17
  if not (self._dm).striggleEventId then
    local eventIdList = {}
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dm).striggleEventId = {}
  return eventIdList
end

BM_SEnterDungeon.GetInteractive = function(self)
  -- function num : 0_18
  return (self._senterdungeoninfo).interactive
end

BM_SEnterDungeon.GetScrollInfo = function(self)
  -- function num : 0_19
  return (self._senterdungeoninfo).scrollinfo
end

BM_SEnterDungeon.GetBuffs = function(self)
  -- function num : 0_20
  return (self._senterdungeoninfo).buffs
end

return BM_SEnterDungeon

