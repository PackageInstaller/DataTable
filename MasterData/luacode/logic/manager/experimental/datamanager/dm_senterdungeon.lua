-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_senterdungeon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_SEnterDungeon = class("DM_SEnterDungeon")
DM_SEnterDungeon.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._senterdungeoninfo = (NekoData.Data).senterdungeoninfo
  self._sceneID = nil
  self.npcObjects = {}
end

DM_SEnterDungeon.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs(self._senterdungeoninfo) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._senterdungeoninfo)[k] = nil
  end
  self.npcObjects = {}
  self._sceneID = nil
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).npcObjects = nil
end

local trap_to_map = function(state)
  -- function num : 0_2 , upvalues : _ENV
  local result = {}
  for _,v in pairs(state) do
    if not result[v.instanceid] then
      do
        result[v.instanceid] = {}
        -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (result[v.instanceid])[v.id] = {state = v.state}
        -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return result
end

local switch_to_map = function(state)
  -- function num : 0_3 , upvalues : _ENV
  local result = {}
  for _,v in pairs(state) do
    if not result[v.instanceid] then
      do
        result[v.instanceid] = {}
        -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (result[v.instanceid])[v.id] = {state = v.state, touched = v.touch == 1}
        -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  do return result end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

local value_to_map = function(state)
  -- function num : 0_4 , upvalues : _ENV
  local result = {}
  for _,v in pairs(state) do
    result[v] = true
  end
  return result
end

DM_SEnterDungeon.OnSEnterDungeon = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, switch_to_map, trap_to_map, value_to_map
  local events = (self._senterdungeoninfo).events
  local interactive = (self._senterdungeoninfo).interactive
  for k,v in pairs(self._senterdungeoninfo) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R9 in 'UnsetPending'

    (self._senterdungeoninfo)[k] = nil
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).id = protocol.id
  if self._sceneID ~= protocol.id then
    self.npcObjects = {}
  end
  self._sceneID = protocol.id
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).point = protocol.point
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).switches = switch_to_map(protocol.switches)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).traps = trap_to_map(protocol.traps)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).randomItems = (protocol.objects).items
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).sceneObjects = (protocol.objects).objs
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).chests = value_to_map((protocol.objects).box)
  if not self.npcObjects then
    self.npcObjects = {}
    for _,n in pairs((protocol.objects).npcs) do
      (table.insert)(self.npcObjects, n)
    end
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).npcObjects = self.npcObjects
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).disabledSceneObjects = protocol.activedOptionIds
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).interactive = interactive
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).monsters = {}
    for _,i in pairs((protocol.objects).monsterIds) do
      local data = {id = i}
      local pos = ((protocol.objects).movableMonstersPosition)[i]
      if pos then
        data.x = pos.x
        data.z = pos.y
      end
      ;
      (table.insert)((self._senterdungeoninfo).monsters, data)
    end
    -- DECOMPILER ERROR at PC103: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).events = events
    -- DECOMPILER ERROR at PC110: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).battleResult = {battleid = protocol.lastbattleid, battleResult = protocol.battleresult}
    -- DECOMPILER ERROR at PC113: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).curBattleInfo = protocol.curBattleInfo
    -- DECOMPILER ERROR at PC116: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).topMessage = protocol.topMessage
    -- DECOMPILER ERROR at PC125: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).reconnect = {id = (protocol.reconnect).value, type = (protocol.reconnect).kind}
    -- DECOMPILER ERROR at PC128: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).modules = {}
    for _,v in pairs(protocol.modules) do
      -- DECOMPILER ERROR at PC137: Confused about usage of register: R9 in 'UnsetPending'

      ((self._senterdungeoninfo).modules)[v.id] = v.statue
    end
    -- DECOMPILER ERROR at PC142: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).buffs = protocol.buffs
  end
end

DM_SEnterDungeon.OnSUnRemainEvents = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._senterdungeoninfo).events = protocol.events
end

DM_SEnterDungeon.OnSNpcAppear = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  if self._sceneID ~= protocol.sceneId then
    self.npcObjects = {}
  end
  self._sceneID = protocol.sceneId
  if not self.npcObjects then
    self.npcObjects = {}
    for _,npc in pairs(protocol.npcs) do
      (table.insert)(self.npcObjects, npc)
    end
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._senterdungeoninfo).npcObjects = self.npcObjects
  end
end

DM_SEnterDungeon.OnSNpcDisAppear = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV
  local index = {}
  for i,npc in ipairs((self._senterdungeoninfo).npcObjects) do
    for _,n in ipairs(protocol.npcs) do
      if npc.id == n.id then
        (table.remove)((self._senterdungeoninfo).npcObjects, i)
      end
    end
  end
end

DM_SEnterDungeon.OnSEnterMainCity = function(self)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._senterdungeoninfo).curBattleInfo = nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).topMessage = nil
  self.npcObjects = {}
  self._sceneID = nil
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).npcObjects = nil
end

DM_SEnterDungeon.OnSStartAutoExplore = function(self, protocol)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in pairs(self._senterdungeoninfo) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

    (self._senterdungeoninfo)[k] = nil
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).id = protocol.id
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).monsters = (table.tolist)(protocol.monsters)
  ;
  (table.sort)((self._senterdungeoninfo).monsters, function(lhs, rhs)
    -- function num : 0_10_0
    do return lhs.key < rhs.key end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).battleResult = {battleid = protocol.lastBattleId, battleResult = protocol.battleResult}
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._senterdungeoninfo).curBattleInfo = protocol.curBattleInfo
end

DM_SEnterDungeon.OnSTriggleSuccess = function(self, protocol)
  -- function num : 0_11 , upvalues : _ENV
  if not self.striggleEventId then
    self.striggleEventId = {}
    ;
    (table.insert)(self.striggleEventId, protocol.eventId)
  end
end

DM_SEnterDungeon.OnSInteractive = function(self, protocol)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._senterdungeoninfo).interactive then
    (self._senterdungeoninfo).interactive = {}
    ;
    (table.insert)((self._senterdungeoninfo).interactive, protocol.obj)
  end
end

DM_SEnterDungeon.OnSScrollSceneInfo = function(self, protocol)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._senterdungeoninfo).scrollinfo = protocol.scrollSceneInfo
end

return DM_SEnterDungeon

