local DM_SEnterDungeon = class("DM_SEnterDungeon")

function DM_SEnterDungeon:Ctor()
  self._senterdungeoninfo = NekoData.Data.senterdungeoninfo
  self._sceneID = nil
  self.npcObjects = {}
end

function DM_SEnterDungeon:Clear()
  for k, v in pairs(self._senterdungeoninfo) do
    self._senterdungeoninfo[k] = nil
  end
  self.npcObjects = {}
  self._sceneID = nil
  self._senterdungeoninfo.npcObjects = nil
end

local function trap_to_map(state)
  local result = {}
  for _, v in pairs(state) do
    result[v.instanceid] = result[v.instanceid] or {}
    result[v.instanceid][v.id] = {
      state = v.state
    }
  end
  return result
end

local function switch_to_map(state)
  local result = {}
  for _, v in pairs(state) do
    result[v.instanceid] = result[v.instanceid] or {}
    result[v.instanceid][v.id] = {
      state = v.state,
      touched = v.touch == 1
    }
  end
  return result
end

local function value_to_map(state)
  local result = {}
  for _, v in pairs(state) do
    result[v] = true
  end
  return result
end

function DM_SEnterDungeon:OnSEnterDungeon(protocol)
  local events = self._senterdungeoninfo.events
  local interactive = self._senterdungeoninfo.interactive
  for k, v in pairs(self._senterdungeoninfo) do
    self._senterdungeoninfo[k] = nil
  end
  self._senterdungeoninfo.id = protocol.id
  if self._sceneID ~= protocol.id then
    self.npcObjects = {}
  end
  self._sceneID = protocol.id
  self._senterdungeoninfo.point = protocol.point
  self._senterdungeoninfo.switches = switch_to_map(protocol.switches)
  self._senterdungeoninfo.traps = trap_to_map(protocol.traps)
  self._senterdungeoninfo.randomItems = protocol.objects.items
  self._senterdungeoninfo.sceneObjects = protocol.objects.objs
  self._senterdungeoninfo.chests = value_to_map(protocol.objects.box)
  self.npcObjects = self.npcObjects or {}
  for _, n in pairs(protocol.objects.npcs) do
    table.insert(self.npcObjects, n)
  end
  self._senterdungeoninfo.npcObjects = self.npcObjects
  self._senterdungeoninfo.disabledSceneObjects = protocol.activedOptionIds
  self._senterdungeoninfo.interactive = interactive
  self._senterdungeoninfo.monsters = {}
  for _, i in pairs(protocol.objects.monsterIds) do
    local data = {id = i}
    local pos = protocol.objects.movableMonstersPosition[i]
    if pos then
      data.x = pos.x
      data.z = pos.y
    end
    table.insert(self._senterdungeoninfo.monsters, data)
  end
  self._senterdungeoninfo.events = events
  self._senterdungeoninfo.battleResult = {
    battleid = protocol.lastbattleid,
    battleResult = protocol.battleresult
  }
  self._senterdungeoninfo.curBattleInfo = protocol.curBattleInfo
  self._senterdungeoninfo.topMessage = protocol.topMessage
  self._senterdungeoninfo.reconnect = {
    id = protocol.reconnect.value,
    type = protocol.reconnect.kind
  }
  self._senterdungeoninfo.modules = {}
  for _, v in pairs(protocol.modules) do
    self._senterdungeoninfo.modules[v.id] = v.statue
  end
  self._senterdungeoninfo.buffs = protocol.buffs
end

function DM_SEnterDungeon:OnSUnRemainEvents(protocol)
  self._senterdungeoninfo.events = protocol.events
end

function DM_SEnterDungeon:OnSNpcAppear(protocol)
  if self._sceneID ~= protocol.sceneId then
    self.npcObjects = {}
  end
  self._sceneID = protocol.sceneId
  self.npcObjects = self.npcObjects or {}
  for _, npc in pairs(protocol.npcs) do
    table.insert(self.npcObjects, npc)
  end
  self._senterdungeoninfo.npcObjects = self.npcObjects
end

function DM_SEnterDungeon:OnSNpcDisAppear(protocol)
  local index = {}
  for i, npc in ipairs(self._senterdungeoninfo.npcObjects) do
    for _, n in ipairs(protocol.npcs) do
      if npc.id == n.id then
        table.remove(self._senterdungeoninfo.npcObjects, i)
      end
    end
  end
end

function DM_SEnterDungeon:OnSEnterMainCity()
  self._senterdungeoninfo.curBattleInfo = nil
  self._senterdungeoninfo.topMessage = nil
  self.npcObjects = {}
  self._sceneID = nil
  self._senterdungeoninfo.npcObjects = nil
end

function DM_SEnterDungeon:OnSStartAutoExplore(protocol)
  for k, v in pairs(self._senterdungeoninfo) do
    self._senterdungeoninfo[k] = nil
  end
  self._senterdungeoninfo.id = protocol.id
  self._senterdungeoninfo.monsters = table.tolist(protocol.monsters)
  table.sort(self._senterdungeoninfo.monsters, function(lhs, rhs)
    return lhs.key < rhs.key
  end)
  self._senterdungeoninfo.battleResult = {
    battleid = protocol.lastBattleId,
    battleResult = protocol.battleResult
  }
  self._senterdungeoninfo.curBattleInfo = protocol.curBattleInfo
end

function DM_SEnterDungeon:OnSTriggleSuccess(protocol)
  self.striggleEventId = self.striggleEventId or {}
  table.insert(self.striggleEventId, protocol.eventId)
end

function DM_SEnterDungeon:OnSInteractive(protocol)
  self._senterdungeoninfo.interactive = self._senterdungeoninfo.interactive or {}
  table.insert(self._senterdungeoninfo.interactive, protocol.obj)
end

function DM_SEnterDungeon:OnSScrollSceneInfo(protocol)
  self._senterdungeoninfo.scrollinfo = protocol.scrollSceneInfo
end

return DM_SEnterDungeon
