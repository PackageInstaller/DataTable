-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_tower.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Tower = class("DM_SStartTowerExplore")
local Item = require("logic.manager.experimental.types.item")
local cislandtypeconfig = (BeanManager.GetTableByName)("dungeonselect.cislandtypeconfig")
local cmonster_handbook = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local cmonsterconfig = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local cbattleaward = ((BeanManager.GetTableByName)("dungeonselect.cbattleaward"))
local _cache = nil
DM_Tower.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._towerInfo = (NekoData.Data).tower
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._towerInfo).monsterInfo = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._towerInfo).hp = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._towerInfo).dialogfloor = 0
end

DM_Tower.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs(self._towerInfo) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._towerInfo)[k] = nil
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._towerInfo).dialogfloor = 0
end

local find_cfg_by_type_style = function(type, style)
  -- function num : 0_2 , upvalues : _cache, _ENV, cislandtypeconfig
  if not _cache then
    _cache = {}
    for _,i in pairs(cislandtypeconfig:GetAllIds()) do
      local record = cislandtypeconfig:GetRecorder(i)
      if not _cache[record.functionType] then
        do
          _cache[record.functionType] = {}
          -- DECOMPILER ERROR at PC25: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (_cache[record.functionType])[record.worldsType] = record
          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return (_cache[type])[style]
end

DM_Tower.OnSStartTowerExplore = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, find_cfg_by_type_style
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (self._towerInfo).pos = protocol.playerPos + 1
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).style = protocol.mapShowType
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).floor = {current = protocol.currentTowerFloor, total = protocol.totalFloors}
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).id = protocol.towerID
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).hp = {}
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._towerInfo).mapInfo = {}
  for id,v in ipairs(protocol.mapList) do
    local record = find_cfg_by_type_style(v.squreType, protocol.mapShowType)
    if not record then
      LogError("tower", "island config not found, " .. v.squreType .. "@" .. protocol.mapShowType)
    end
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self._towerInfo).mapInfo)[id] = {index = id, serverID = id - 1, cfgid = record.id, cfg = record, type = v.squreType, style = protocol.mapShowType, param = v.eventID, 
pos = {x = v.lPos, y = v.rPos}
, 
neighborID = {north = v.north + 1, south = v.sorth + 1, east = v.east + 1, west = v.west + 1}
, state = v.squreState, 
titleShowState = {north = false, south = false, east = false, west = false}
}
  end
  self:OnSRenewRolesHPinTower({status = protocol.linueupStatue})
end

DM_Tower.OnSOpenTowerList = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._towerInfo).dialogfloor = protocol.challengingFloor
end

DM_Tower.OnSTouchIslandEvent = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  (((self._towerInfo).mapInfo)[(self._towerInfo).pos]).state = 1
  for id,v in pairs((self._towerInfo).mapInfo) do
    if id == protocol.islandId + 1 then
      v.state = 1
    end
  end
end

DM_Tower.OnSOpenTowerIslandChest = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  (((self._towerInfo).mapInfo)[(self._towerInfo).pos]).state = 1
  for id,v in pairs((self._towerInfo).mapInfo) do
    if id == protocol.islandID + 1 then
      v.state = 1
    end
  end
end

DM_Tower.OnSTowerMove = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  if protocol.nextIsland == -1 then
    LogError("tower", "invalid tower move")
  end
  local info = ((self._towerInfo).mapInfo)[(self._towerInfo).pos]
  if info.state == 2 and info.type ~= 99 then
    info.state = 0
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).pos = protocol.nextIsland + 1
  info = ((self._towerInfo).mapInfo)[(self._towerInfo).pos]
  if info.state == 0 and info.type ~= 99 then
    info.state = 2
  end
end

DM_Tower.OnSMove2BattleIsland = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV, cmonsterconfig, cmonster_handbook, cbattleaward, Item
  if protocol.islandID == -1 then
    LogError("tower", "invalid monster tower move")
  end
  local target = protocol.islandID + 1
  print((self._towerInfo).pos, target, (((self._towerInfo).mapInfo)[target]).state)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  if (self._towerInfo).pos ~= target and (((self._towerInfo).mapInfo)[target]).state ~= 1 then
    (((self._towerInfo).mapInfo)[target]).state = 2
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._towerInfo).pos = target
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

  if not (self._towerInfo).monsterInfo then
    (self._towerInfo).monsterInfo = {}
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._towerInfo).monsterInfo)[(self._towerInfo).pos] = {}
    if (((self._towerInfo).mapInfo)[(self._towerInfo).pos]).state ~= 1 then
      for i,v in ipairs(protocol.enemy) do
        local monster = cmonsterconfig:GetRecorder(v.monserid)
        local typeinfo = cmonster_handbook:GetRecorder(monster.MonsterType)
        if not typeinfo then
          LogError("tower", v.monserid .. " not exist in handbook")
        end
        local info = {id = v.monserid, typeid = monster.MonsterType, hp = v.hppercent / 100, icon = typeinfo.miniIcon, level = monster.npcLevel}
        ;
        (table.insert)(((self._towerInfo).monsterInfo)[(self._towerInfo).pos], info)
      end
      -- DECOMPILER ERROR at PC104: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (((self._towerInfo).monsterInfo)[(self._towerInfo).pos]).awards = {}
      local battleid = tonumber((((self._towerInfo).mapInfo)[(self._towerInfo).pos]).param)
      local recorder = cbattleaward:GetRecorder(battleid)
      for i,v in ipairs(recorder.getitem) do
        local item = (Item.Create)(v)
        ;
        (table.insert)((((self._towerInfo).monsterInfo)[(self._towerInfo).pos]).awards, item)
      end
    end
  end
end

DM_Tower.OnSIslandTouchAltar = function(self, protocol)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  (((self._towerInfo).mapInfo)[(self._towerInfo).pos]).state = 1
  self:OnSRenewRolesHPinTower({status = protocol.hpInfo})
end

DM_Tower.OnSTowerBattleEnd = function(self, protocol)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if (protocol.battleResult).result == 1 then
    (((self._towerInfo).mapInfo)[(self._towerInfo).pos]).state = 1
  end
end

DM_Tower.OnSRenewRolesHPinTower = function(self, protocol)
  -- function num : 0_11 , upvalues : _ENV
  for rolekey,hp in pairs(protocol.status) do
    if hp > 100 or hp < 0 then
      LogError("tower", (string.format)("invalid hp: %d%% @ %s", hp, rolekey))
    end
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._towerInfo).hp)[rolekey] = hp / 100
  end
end

return DM_Tower

