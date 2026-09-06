local DM_Tower = class("DM_SStartTowerExplore")
local Item = require("logic.manager.experimental.types.item")
local cislandtypeconfig = BeanManager.GetTableByName("dungeonselect.cislandtypeconfig")
local cmonster_handbook = BeanManager.GetTableByName("handbook.cmonster_handbook")
local cmonsterconfig = BeanManager.GetTableByName("npc.cmonsterconfig")
local cbattleaward = BeanManager.GetTableByName("dungeonselect.cbattleaward")
local _cache

function DM_Tower:Ctor()
  self._towerInfo = NekoData.Data.tower
  self._towerInfo.monsterInfo = {}
  self._towerInfo.hp = {}
  self._towerInfo.dialogfloor = 0
end

function DM_Tower:Clear()
  for k, v in pairs(self._towerInfo) do
    self._towerInfo[k] = nil
  end
  self._towerInfo.dialogfloor = 0
end

local function find_cfg_by_type_style(type, style)
  if not _cache then
    _cache = {}
    for _, i in pairs(cislandtypeconfig:GetAllIds()) do
      local record = cislandtypeconfig:GetRecorder(i)
      _cache[record.functionType] = _cache[record.functionType] or {}
      _cache[record.functionType][record.worldsType] = record
    end
  end
  return _cache[type][style]
end

function DM_Tower:OnSStartTowerExplore(protocol)
  self._towerInfo.pos = protocol.playerPos + 1
  self._towerInfo.style = protocol.mapShowType
  self._towerInfo.floor = {
    current = protocol.currentTowerFloor,
    total = protocol.totalFloors
  }
  self._towerInfo.id = protocol.towerID
  self._towerInfo.hp = {}
  self._towerInfo.mapInfo = {}
  for id, v in ipairs(protocol.mapList) do
    local record = find_cfg_by_type_style(v.squreType, protocol.mapShowType)
    if not record then
      LogError("tower", "island config not found, " .. v.squreType .. "@" .. protocol.mapShowType)
    end
    self._towerInfo.mapInfo[id] = {
      index = id,
      serverID = id - 1,
      cfgid = record.id,
      cfg = record,
      type = v.squreType,
      style = protocol.mapShowType,
      param = v.eventID,
      pos = {
        x = v.lPos,
        y = v.rPos
      },
      neighborID = {
        north = v.north + 1,
        south = v.sorth + 1,
        east = v.east + 1,
        west = v.west + 1
      },
      state = v.squreState,
      titleShowState = {
        north = false,
        south = false,
        east = false,
        west = false
      }
    }
  end
  self:OnSRenewRolesHPinTower({
    status = protocol.linueupStatue
  })
end

function DM_Tower:OnSOpenTowerList(protocol)
  self._towerInfo.dialogfloor = protocol.challengingFloor
end

function DM_Tower:OnSTouchIslandEvent(protocol)
  self._towerInfo.mapInfo[self._towerInfo.pos].state = 1
  for id, v in pairs(self._towerInfo.mapInfo) do
    if id == protocol.islandId + 1 then
      v.state = 1
    end
  end
end

function DM_Tower:OnSOpenTowerIslandChest(protocol)
  self._towerInfo.mapInfo[self._towerInfo.pos].state = 1
  for id, v in pairs(self._towerInfo.mapInfo) do
    if id == protocol.islandID + 1 then
      v.state = 1
    end
  end
end

function DM_Tower:OnSTowerMove(protocol)
  if protocol.nextIsland == -1 then
    LogError("tower", "invalid tower move")
  end
  local info = self._towerInfo.mapInfo[self._towerInfo.pos]
  if info.state == 2 and info.type ~= 99 then
    info.state = 0
  end
  self._towerInfo.pos = protocol.nextIsland + 1
  info = self._towerInfo.mapInfo[self._towerInfo.pos]
  if info.state == 0 and info.type ~= 99 then
    info.state = 2
  end
end

function DM_Tower:OnSMove2BattleIsland(protocol)
  if protocol.islandID == -1 then
    LogError("tower", "invalid monster tower move")
  end
  local target = protocol.islandID + 1
  print(self._towerInfo.pos, target, self._towerInfo.mapInfo[target].state)
  if self._towerInfo.pos ~= target and self._towerInfo.mapInfo[target].state ~= 1 then
    self._towerInfo.mapInfo[target].state = 2
  end
  self._towerInfo.pos = target
  self._towerInfo.monsterInfo = self._towerInfo.monsterInfo or {}
  self._towerInfo.monsterInfo[self._towerInfo.pos] = {}
  if self._towerInfo.mapInfo[self._towerInfo.pos].state ~= 1 then
    for i, v in ipairs(protocol.enemy) do
      local monster = cmonsterconfig:GetRecorder(v.monserid)
      local typeinfo = cmonster_handbook:GetRecorder(monster.MonsterType)
      if not typeinfo then
        LogError("tower", v.monserid .. " not exist in handbook")
      end
      local info = {
        id = v.monserid,
        typeid = monster.MonsterType,
        hp = v.hppercent / 100,
        icon = typeinfo.miniIcon,
        level = monster.npcLevel
      }
      table.insert(self._towerInfo.monsterInfo[self._towerInfo.pos], info)
    end
    self._towerInfo.monsterInfo[self._towerInfo.pos].awards = {}
    local battleid = tonumber(self._towerInfo.mapInfo[self._towerInfo.pos].param)
    local recorder = cbattleaward:GetRecorder(battleid)
    for i, v in ipairs(recorder.getitem) do
      local item = Item.Create(v)
      table.insert(self._towerInfo.monsterInfo[self._towerInfo.pos].awards, item)
    end
  end
end

function DM_Tower:OnSIslandTouchAltar(protocol)
  self._towerInfo.mapInfo[self._towerInfo.pos].state = 1
  self:OnSRenewRolesHPinTower({
    status = protocol.hpInfo
  })
end

function DM_Tower:OnSTowerBattleEnd(protocol)
  if protocol.battleResult.result == 1 then
    self._towerInfo.mapInfo[self._towerInfo.pos].state = 1
  end
end

function DM_Tower:OnSRenewRolesHPinTower(protocol)
  for rolekey, hp in pairs(protocol.status) do
    if 100 < hp or hp < 0 then
      LogError("tower", string.format("invalid hp: %d%% @ %s", hp, rolekey))
    end
    self._towerInfo.hp[rolekey] = hp / 100
  end
end

return DM_Tower
