local CFurnitureItem = BeanManager.GetTableByName("item.cfurnitureitem")
local CDormComfortLv = BeanManager.GetTableByName("courtyard.cdormcomfortlv")
local CDormComfortRate = BeanManager.GetTableByName("courtyard.cdormcomfortrate")
local Rate = CDormComfortRate:GetRecorder(1).rate
local RateTimes = 60 / Rate
local DM_Cabin = class("DM_Cabin")

function DM_Cabin:Ctor()
  self._cabin = NekoData.Data.cabin
  self._comfortLvRecorderList = {}
  local allIds = CDormComfortLv:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormComfortLv:GetRecorder(allIds[i])
    table.insert(self._comfortLvRecorderList, recorder)
  end
  self._cabin.name = ""
  self._cabin.level = 0
  self._cabin.roomInfo = {}
  self._cabin.themes = {}
  self._cabin.roles = {}
  self._cabin.energyFullRoleNum = 0
  self._timeCheck = 1
  self._timeCount = 0
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_Cabin:Clear()
  self._cabin.level = 0
  self._cabin.name = ""
  for k, _ in pairs(self._cabin.roomInfo) do
    self._cabin.roomInfo[k] = nil
  end
  while self._cabin.themes[#self._cabin.themes] do
    table.remove(self._cabin.themes, #self._cabin.themes)
  end
  for k, v in pairs(self._cabin.roles) do
    self._cabin.roles[k] = nil
  end
  self._cabin.energyFullRoleNum = 0
end

function DM_Cabin:OnSYardInfo(protocol)
  self._cabin.name = protocol.room.name
  self._cabin.level = protocol.room.level
  for k, v in pairs(protocol.room.floors) do
    self._cabin.roomInfo[k] = {
      roomId = v.id,
      comfort = 0,
      furnitures = {},
      roles = {}
    }
    local comfort = 0
    local roomFurnitures = self._cabin.roomInfo[k].furnitures
    for index, furnitureInfo in ipairs(v.furniture) do
      local furnitureId = furnitureInfo.itemId
      comfort = comfort + CFurnitureItem:GetRecorder(furnitureId).comfortPoint
      roomFurnitures[furnitureInfo.key] = furnitureInfo
    end
    self._cabin.roomInfo[k].comfort = comfort
    self._cabin.roomInfo[k].comfortLv = self:GetLevelByComfort(comfort)
    self._cabin.roomInfo[k].addRelation = v.good * RateTimes
    self._cabin.roomInfo[k].recoverySpeed = v.recovery / 1000 * RateTimes
    for roleKey, leftRecoveryTime in pairs(v.rolesLeftRecoveryTime) do
      self._cabin.roles[roleKey] = {
        roleKey = roleKey,
        leftRecoveryTime = leftRecoveryTime,
        roomId = v.id
      }
      table.insert(self._cabin.roomInfo[k].roles, roleKey)
    end
  end
  for i, v in ipairs(protocol.room.defaultTheme) do
    table.insert(self._cabin.themes, v)
  end
end

function DM_Cabin:OnSChangeRoomName(protocol)
  self._cabin.name = protocol.name
end

function DM_Cabin:OnSRefreshRoom(protocol)
  self._cabin.name = protocol.room.name
  self._cabin.level = protocol.room.level
  for k, v in pairs(self._cabin.roomInfo) do
    self._cabin.roomInfo[k] = nil
  end
  for k, v in pairs(self._cabin.roles) do
    self._cabin.roles[k] = nil
  end
  for k, v in pairs(protocol.room.floors) do
    self._cabin.roomInfo[k] = {
      roomId = v.id,
      comfort = 0,
      furnitures = {},
      roles = {}
    }
    local comfort = 0
    local roomFurnitures = self._cabin.roomInfo[k].furnitures
    for index, furnitureInfo in ipairs(v.furniture) do
      local furnitureId = furnitureInfo.itemId
      comfort = comfort + CFurnitureItem:GetRecorder(furnitureId).comfortPoint
      roomFurnitures[furnitureInfo.key] = furnitureInfo
    end
    self._cabin.roomInfo[k].comfort = comfort
    self._cabin.roomInfo[k].comfortLv = self:GetLevelByComfort(comfort)
    self._cabin.roomInfo[k].addRelation = v.good * RateTimes
    self._cabin.roomInfo[k].recoverySpeed = v.recovery / 1000 * RateTimes
    for roleKey, leftRecoveryTime in pairs(v.rolesLeftRecoveryTime) do
      self._cabin.roles[roleKey] = {
        roleKey = roleKey,
        leftRecoveryTime = leftRecoveryTime,
        roomId = v.id
      }
      table.insert(self._cabin.roomInfo[k].roles, roleKey)
    end
  end
  while self._cabin.themes[#self._cabin.themes] do
    table.remove(self._cabin.themes, #self._cabin.themes)
  end
  for i, v in ipairs(protocol.room.defaultTheme) do
    table.insert(self._cabin.themes, v)
  end
end

function DM_Cabin:OnSPlaceFurniture(protocol)
  local map = self._cabin.roomInfo[protocol.floor.id]
  if map then
    while map.roles[#map.roles] do
      self._cabin.roles[map.roles[#map.roles]] = nil
      table.remove(map.roles, #map.roles)
    end
    for k, v in pairs(map.furnitures) do
      map.furnitures[k] = nil
    end
    local comfort = 0
    local roomFurnitures = map.furnitures
    for index, furnitureInfo in ipairs(protocol.floor.furniture) do
      local furnitureId = furnitureInfo.itemId
      comfort = comfort + CFurnitureItem:GetRecorder(furnitureId).comfortPoint
      roomFurnitures[furnitureInfo.key] = furnitureInfo
    end
    map.comfort = comfort
    map.comfortLv = self:GetLevelByComfort(comfort)
    map.addRelation = protocol.floor.good * RateTimes
    map.recoverySpeed = protocol.floor.recovery / 1000 * RateTimes
    for roleKey, leftRecoveryTime in pairs(protocol.floor.rolesLeftRecoveryTime) do
      self._cabin.roles[roleKey] = {
        roleKey = roleKey,
        leftRecoveryTime = leftRecoveryTime,
        roomId = protocol.floor.id
      }
      table.insert(map.roles, roleKey)
    end
  end
end

function DM_Cabin:OnSRefreshFloor(protocol)
  local map = self._cabin.roomInfo[protocol.floor.id]
  if map then
    while map.roles[#map.roles] do
      self._cabin.roles[map.roles[#map.roles]] = nil
      table.remove(map.roles, #map.roles)
    end
    for k, v in pairs(map.furnitures) do
      map.furnitures[k] = nil
    end
    local comfort = 0
    local roomFurnitures = map.furnitures
    for index, furnitureInfo in ipairs(protocol.floor.furniture) do
      local furnitureId = furnitureInfo.itemId
      comfort = comfort + CFurnitureItem:GetRecorder(furnitureId).comfortPoint
      roomFurnitures[furnitureInfo.key] = furnitureInfo
    end
    map.comfort = comfort
    map.comfortLv = self:GetLevelByComfort(comfort)
    map.addRelation = protocol.floor.good * RateTimes
    map.recoverySpeed = protocol.floor.recovery / 1000 * RateTimes
    for roleKey, leftRecoveryTime in pairs(protocol.floor.rolesLeftRecoveryTime) do
      self._cabin.roles[roleKey] = {
        roleKey = roleKey,
        leftRecoveryTime = leftRecoveryTime,
        roomId = protocol.floor.id
      }
      table.insert(map.roles, roleKey)
    end
  end
end

function DM_Cabin:OnSAddTheme(protocol)
  table.insert(self._cabin.themes, protocol.theme)
end

function DM_Cabin:OnSChangeThemeName(protocol)
  for i, v in ipairs(self._cabin.themes) do
    if v.key == protocol.key then
      v.name = protocol.name
    end
  end
end

function DM_Cabin:OnSDeleteTheme(protocol)
  local index
  for i, v in ipairs(self._cabin.themes) do
    if v.key == protocol.key then
      index = i
      break
    end
  end
  if index then
    table.remove(self._cabin.themes, index)
  end
end

function DM_Cabin:GetLevelByComfort(num)
  local level = 0
  for i, v in ipairs(self._comfortLvRecorderList) do
    if num >= v.confort then
      level = v.id
    else
      break
    end
  end
  return level
end

function DM_Cabin:OnUpdate(notification)
  if self._cabin.level == 0 then
    return
  end
  self._timeCount = self._timeCount + notification.userInfo.unscaledDeltaTime
  if self._timeCount < self._timeCheck then
    return
  end
  local check = self._timeCheck
  if notification.userInfo.unscaledDeltaTime > self._timeCheck then
    check = math.ceil(self._timeCount)
  end
  self._timeCount = self._timeCount - check
  local energyFullRoleNum = 0
  local map
  local num = 0
  for k, v in pairs(self._cabin.roles) do
    if 0 < v.leftRecoveryTime then
      v.leftRecoveryTime = v.leftRecoveryTime - check * 1000
      if 0 >= v.leftRecoveryTime then
        map = map or {}
        if not map[v.roomId] then
          map[v.roomId] = {}
        end
        table.insert(map[v.roomId], v.roleKey)
        num = num + 1
      end
    else
      energyFullRoleNum = energyFullRoleNum + 1
    end
  end
  if 0 < num then
    local crecoveryEnergy = LuaNetManager.CreateProtocol("protocol.yard.crecoveryenergy")
    crecoveryEnergy.roles = {}
    for k, v in pairs(map) do
      local roleToFloor = LuaNetManager.CreateBean("protocol.yard.roletofloor")
      roleToFloor.floorId = k
      roleToFloor.roles = v
      table.insert(crecoveryEnergy.roles, roleToFloor)
    end
    crecoveryEnergy:Send()
  end
  if self._cabin.energyFullRoleNum ~= energyFullRoleNum then
    self._cabin.energyFullRoleNum = energyFullRoleNum
    LuaNotificationCenter.PostNotification(Common.n_BuildingPauseTaskNumChanged, nil, {
      buildingId = DataCommon.Cabin,
      pauseTaskNum = energyFullRoleNum
    })
  end
end

return DM_Cabin
