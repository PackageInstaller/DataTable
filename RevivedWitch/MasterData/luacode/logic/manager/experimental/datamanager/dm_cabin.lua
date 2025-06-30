-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_cabin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFurnitureItem = (BeanManager.GetTableByName)("item.cfurnitureitem")
local CDormComfortLv = (BeanManager.GetTableByName)("courtyard.cdormcomfortlv")
local CDormComfortRate = (BeanManager.GetTableByName)("courtyard.cdormcomfortrate")
local Rate = (CDormComfortRate:GetRecorder(1)).rate
local RateTimes = 60 / Rate
local DM_Cabin = class("DM_Cabin")
DM_Cabin.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CDormComfortLv
  self._cabin = (NekoData.Data).cabin
  self._comfortLvRecorderList = {}
  local allIds = CDormComfortLv:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormComfortLv:GetRecorder(allIds[i])
    ;
    (table.insert)(self._comfortLvRecorderList, recorder)
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._cabin).name = ""
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._cabin).level = 0
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._cabin).roomInfo = {}
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._cabin).themes = {}
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._cabin).roles = {}
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._cabin).energyFullRoleNum = 0
  self._timeCheck = 1
  self._timeCount = 0
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_Cabin.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._cabin).level = 0
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._cabin).name = ""
  for k,_ in pairs((self._cabin).roomInfo) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

    ((self._cabin).roomInfo)[k] = nil
  end
  do
    while ((self._cabin).themes)[#(self._cabin).themes] do
      (table.remove)((self._cabin).themes, #(self._cabin).themes)
    end
    for k,v in pairs((self._cabin).roles) do
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R6 in 'UnsetPending'

      ((self._cabin).roles)[k] = nil
    end
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._cabin).energyFullRoleNum = 0
  end
end

DM_Cabin.OnSYardInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, CFurnitureItem, RateTimes
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (self._cabin).name = (protocol.room).name
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._cabin).level = (protocol.room).level
  for k,v in pairs((protocol.room).floors) do
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

    ((self._cabin).roomInfo)[k] = {roomId = v.id, comfort = 0, 
furnitures = {}
, 
roles = {}
}
    local comfort = 0
    local roomFurnitures = (((self._cabin).roomInfo)[k]).furnitures
    for index,furnitureInfo in ipairs(v.furniture) do
      local furnitureId = furnitureInfo.itemId
      comfort = comfort + (CFurnitureItem:GetRecorder(furnitureId)).comfortPoint
      roomFurnitures[furnitureInfo.key] = furnitureInfo
    end
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self._cabin).roomInfo)[k]).comfort = comfort
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self._cabin).roomInfo)[k]).comfortLv = self:GetLevelByComfort(comfort)
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self._cabin).roomInfo)[k]).addRelation = v.good * RateTimes
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self._cabin).roomInfo)[k]).recoverySpeed = v.recovery / 1000 * RateTimes
    for roleKey,leftRecoveryTime in pairs(v.rolesLeftRecoveryTime) do
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R14 in 'UnsetPending'

      ((self._cabin).roles)[roleKey] = {roleKey = roleKey, leftRecoveryTime = leftRecoveryTime, roomId = v.id}
      ;
      (table.insert)((((self._cabin).roomInfo)[k]).roles, roleKey)
    end
  end
  for i,v in ipairs((protocol.room).defaultTheme) do
    (table.insert)((self._cabin).themes, v)
  end
end

DM_Cabin.OnSChangeRoomName = function(self, protocol)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._cabin).name = protocol.name
end

DM_Cabin.OnSRefreshRoom = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV, CFurnitureItem, RateTimes
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (self._cabin).name = (protocol.room).name
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._cabin).level = (protocol.room).level
  for k,v in pairs((self._cabin).roomInfo) do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    ((self._cabin).roomInfo)[k] = nil
  end
  for k,v in pairs((self._cabin).roles) do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

    ((self._cabin).roles)[k] = nil
  end
  for k,v in pairs((protocol.room).floors) do
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

    ((self._cabin).roomInfo)[k] = {roomId = v.id, comfort = 0, 
furnitures = {}
, 
roles = {}
}
    local comfort = 0
    local roomFurnitures = (((self._cabin).roomInfo)[k]).furnitures
    for index,furnitureInfo in ipairs(v.furniture) do
      local furnitureId = furnitureInfo.itemId
      comfort = comfort + (CFurnitureItem:GetRecorder(furnitureId)).comfortPoint
      roomFurnitures[furnitureInfo.key] = furnitureInfo
    end
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self._cabin).roomInfo)[k]).comfort = comfort
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self._cabin).roomInfo)[k]).comfortLv = self:GetLevelByComfort(comfort)
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self._cabin).roomInfo)[k]).addRelation = v.good * RateTimes
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self._cabin).roomInfo)[k]).recoverySpeed = v.recovery / 1000 * RateTimes
    for roleKey,leftRecoveryTime in pairs(v.rolesLeftRecoveryTime) do
      -- DECOMPILER ERROR at PC101: Confused about usage of register: R14 in 'UnsetPending'

      ((self._cabin).roles)[roleKey] = {roleKey = roleKey, leftRecoveryTime = leftRecoveryTime, roomId = v.id}
      ;
      (table.insert)((((self._cabin).roomInfo)[k]).roles, roleKey)
    end
  end
  do
    while ((self._cabin).themes)[#(self._cabin).themes] do
      (table.remove)((self._cabin).themes, #(self._cabin).themes)
    end
    for i,v in ipairs((protocol.room).defaultTheme) do
      (table.insert)((self._cabin).themes, v)
    end
  end
end

DM_Cabin.OnSPlaceFurniture = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, CFurnitureItem, RateTimes
  local map = ((self._cabin).roomInfo)[(protocol.floor).id]
  while 1 do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

    if map then
      if (map.roles)[#map.roles] then
        ((self._cabin).roles)[(map.roles)[#map.roles]] = nil
        ;
        (table.remove)(map.roles, #map.roles)
        -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for k,v in pairs(map.furnitures) do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

    (map.furnitures)[k] = nil
  end
  local comfort = 0
  local roomFurnitures = map.furnitures
  for index,furnitureInfo in ipairs((protocol.floor).furniture) do
    local furnitureId = furnitureInfo.itemId
    comfort = comfort + (CFurnitureItem:GetRecorder(furnitureId)).comfortPoint
    roomFurnitures[furnitureInfo.key] = furnitureInfo
  end
  map.comfort = comfort
  map.comfortLv = self:GetLevelByComfort(comfort)
  map.addRelation = (protocol.floor).good * RateTimes
  map.recoverySpeed = (protocol.floor).recovery / 1000 * RateTimes
  for roleKey,leftRecoveryTime in pairs((protocol.floor).rolesLeftRecoveryTime) do
    -- DECOMPILER ERROR at PC82: Confused about usage of register: R10 in 'UnsetPending'

    ((self._cabin).roles)[roleKey] = {roleKey = roleKey, leftRecoveryTime = leftRecoveryTime, roomId = (protocol.floor).id}
    ;
    (table.insert)(map.roles, roleKey)
  end
end

DM_Cabin.OnSRefreshFloor = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV, CFurnitureItem, RateTimes
  local map = ((self._cabin).roomInfo)[(protocol.floor).id]
  while 1 do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

    if map then
      if (map.roles)[#map.roles] then
        ((self._cabin).roles)[(map.roles)[#map.roles]] = nil
        ;
        (table.remove)(map.roles, #map.roles)
        -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for k,v in pairs(map.furnitures) do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

    (map.furnitures)[k] = nil
  end
  local comfort = 0
  local roomFurnitures = map.furnitures
  for index,furnitureInfo in ipairs((protocol.floor).furniture) do
    local furnitureId = furnitureInfo.itemId
    comfort = comfort + (CFurnitureItem:GetRecorder(furnitureId)).comfortPoint
    roomFurnitures[furnitureInfo.key] = furnitureInfo
  end
  map.comfort = comfort
  map.comfortLv = self:GetLevelByComfort(comfort)
  map.addRelation = (protocol.floor).good * RateTimes
  map.recoverySpeed = (protocol.floor).recovery / 1000 * RateTimes
  for roleKey,leftRecoveryTime in pairs((protocol.floor).rolesLeftRecoveryTime) do
    -- DECOMPILER ERROR at PC82: Confused about usage of register: R10 in 'UnsetPending'

    ((self._cabin).roles)[roleKey] = {roleKey = roleKey, leftRecoveryTime = leftRecoveryTime, roomId = (protocol.floor).id}
    ;
    (table.insert)(map.roles, roleKey)
  end
end

DM_Cabin.OnSAddTheme = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  (table.insert)((self._cabin).themes, protocol.theme)
end

DM_Cabin.OnSChangeThemeName = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV
  for i,v in ipairs((self._cabin).themes) do
    if v.key == protocol.key then
      v.name = protocol.name
    end
  end
end

DM_Cabin.OnSDeleteTheme = function(self, protocol)
  -- function num : 0_9 , upvalues : _ENV
  local index = nil
  for i,v in ipairs((self._cabin).themes) do
    if v.key == protocol.key then
      index = i
      break
    end
  end
  do
    if index then
      (table.remove)((self._cabin).themes, index)
    end
  end
end

DM_Cabin.GetLevelByComfort = function(self, num)
  -- function num : 0_10 , upvalues : _ENV
  local level = 0
  for i,v in ipairs(self._comfortLvRecorderList) do
    if v.confort <= num then
      level = v.id
    else
      break
    end
  end
  do
    return level
  end
end

DM_Cabin.OnUpdate = function(self, notification)
  -- function num : 0_11 , upvalues : _ENV
  if (self._cabin).level == 0 then
    return 
  end
  self._timeCount = self._timeCount + (notification.userInfo).unscaledDeltaTime
  if self._timeCount < self._timeCheck then
    return 
  end
  local check = self._timeCheck
  if self._timeCheck < (notification.userInfo).unscaledDeltaTime then
    check = (math.ceil)(self._timeCount)
  end
  self._timeCount = self._timeCount - check
  local energyFullRoleNum = 0
  local map = nil
  local num = 0
  for k,v in pairs((self._cabin).roles) do
    if v.leftRecoveryTime > 0 then
      v.leftRecoveryTime = v.leftRecoveryTime - check * 1000
      if v.leftRecoveryTime <= 0 then
        if not map then
          map = {}
        end
        if not map[v.roomId] then
          map[v.roomId] = {}
        end
        ;
        (table.insert)(map[v.roomId], v.roleKey)
        num = num + 1
      end
    else
      energyFullRoleNum = energyFullRoleNum + 1
    end
  end
  do
    if num > 0 then
      local crecoveryEnergy = (LuaNetManager.CreateProtocol)("protocol.yard.crecoveryenergy")
      crecoveryEnergy.roles = {}
      for k,v in pairs(map) do
        local roleToFloor = (LuaNetManager.CreateBean)("protocol.yard.roletofloor")
        roleToFloor.floorId = k
        roleToFloor.roles = v
        ;
        (table.insert)(crecoveryEnergy.roles, roleToFloor)
      end
      crecoveryEnergy:Send()
    end
    -- DECOMPILER ERROR at PC101: Confused about usage of register: R6 in 'UnsetPending'

    if (self._cabin).energyFullRoleNum ~= energyFullRoleNum then
      (self._cabin).energyFullRoleNum = energyFullRoleNum
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_BuildingPauseTaskNumChanged, nil, {buildingId = DataCommon.Cabin, pauseTaskNum = energyFullRoleNum})
    end
  end
end

return DM_Cabin

