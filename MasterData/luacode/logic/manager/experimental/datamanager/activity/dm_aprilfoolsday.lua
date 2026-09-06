local CClownRole = BeanManager.GetTableByName("activity.cclownrole")
local DM_AprilFoolsDay = class("DM_AprilFoolsDay")
DM_AprilFoolsDay.TowerFloorStateType = {
  Going = 0,
  Finish = 1,
  Untraveled = 2
}

function DM_AprilFoolsDay:Ctor()
  self._data = NekoData.Data.activities.aprilfoolsday
  self._data.beatClownIsOpen = false
  self._data.shopIsOpen = false
  self._data.receiveAwardTimes = 0
  self._data.redDotShowList = {}
  self._data.gardenPartyIsOpen = false
  self._data.gardenPartyRoleList = {}
  self._data.gardenPartyDungeonBattle = {}
  self._data.gardenPartyGottenItemsList = {}
  self._data.gardenPartyFunctionUnlock = {}
end

function DM_AprilFoolsDay:Clear()
  self._data.beatClownIsOpen = false
  self._data.shopIsOpen = false
  self._data.redDotShowList = {}
  self._data.gardenPartyIsOpen = false
  self._data.gardenPartyRoleList = {}
  self._data.gardenPartyDungeonBattle = {}
  self._data.gardenPartyGottenItemsList = {}
  self._data.gardenPartyFunctionUnlock = {}
end

function DM_AprilFoolsDay:OnSSendBeatClownActivity(protocol)
  self._data.beatClownIsOpen = protocol.state == 1
  self._data.receiveAwardTimes = protocol.receiveTimes
  LogInfoFormat("DM_AprilFoolsDay", "receiveTimes %s", protocol.receiveTimes)
end

function DM_AprilFoolsDay:OnSSendFoolsShopActivity(protocol)
  self._data.shopIsOpen = protocol.state == 1
end

function DM_AprilFoolsDay:OnSSendFoolsRedPoint(protocol)
  for _, v in ipairs(protocol.redpoint) do
    self._data.redDotShowList[v] = true
  end
end

function DM_AprilFoolsDay:OnSOpenFoolsDayActivity(protocol)
  self._data.gardenPartyIsOpen = protocol.state == 1
  self._data.gardenPartyCurrentFloorId = protocol.floorId
  self._data.gardenPartyCurrentFloorState = protocol.floorState
  self._data.gardenPartyFunctionUnlock = protocol.functionId
  self._data.gardenPartyResetConfigTimes = protocol.resetConfigId
  self._data.gardenPartyTowerAndDungeonIsOpen = protocol.closeOthers == 0
end

function DM_AprilFoolsDay:OnSRefreshFoolsDayRoles(protocol)
  self._data.gardenPartyRoleList = {}
  local record
  for _, role in ipairs(protocol.roles) do
    record = CClownRole:GetRecorder(role.Id)
    if not record then
      LogErrorFormat("DM_AprilFoolsDay", "role configId %s not in cclownrole", role.Id)
    else
      table.insert(self._data.gardenPartyRoleList, {
        Id = role.Id,
        roleLv = role.roleLv,
        weaponLv = role.weaponLv,
        attack = role.attack,
        blood = role.blood,
        roleId = record.roleid,
        equipid = record.equipid,
        battlesort = record.battlesort,
        tipstextid = record.tipstextid,
        growATK = record.growATK,
        growHP = record.growHP
      })
    end
  end
end

function DM_AprilFoolsDay:OnSRefreshFoolsDaySingleRole(protocol)
  for _, role in ipairs(self._data.gardenPartyRoleList) do
    if role.Id == protocol.role.Id then
      role.roleLv = protocol.role.roleLv
      role.weaponLv = protocol.role.weaponLv
      role.attack = protocol.role.attack
      role.blood = protocol.role.blood
      return
    end
  end
  local record = CClownRole:GetRecorder(protocol.role.Id)
  if not record then
    LogErrorFormat("DM_AprilFoolsDay", "role configId %s not in cclownrole", protocol.role.Id)
  else
    table.insert(self._data.gardenPartyRoleList, {
      Id = protocol.role.Id,
      roleLv = protocol.role.roleLv,
      weaponLv = protocol.role.weaponLv,
      attack = protocol.role.attack,
      blood = protocol.role.blood,
      roleId = record.roleid,
      equipid = record.equipid,
      battlesort = record.battlesort,
      tipstextid = record.tipstextid,
      growATK = record.growATK,
      growHP = record.growHP
    })
  end
end

function DM_AprilFoolsDay:OnSEnterNextFloor(protocol)
  self._data.gardenPartyCurrentFloorId = protocol.floorId
  self._data.gardenPartyCurrentFloorState = self.TowerFloorStateType.Going
end

function DM_AprilFoolsDay:OnSCompeleteFloor(protocol)
  self._data.gardenPartyCurrentFloorId = protocol.floorId
  self._data.gardenPartyCurrentFloorState = self.TowerFloorStateType.Finish
end

function DM_AprilFoolsDay:OnSOpenFoolsCopyBattle(protocol)
  self._data.gardenPartyDungeonBattle = protocol.battleInfo
end

function DM_AprilFoolsDay:OnSUnlockFoolsDaysFunction(protocol)
  table.insert(self._data.gardenPartyFunctionUnlock, protocol.functionId)
end

function DM_AprilFoolsDay:OnSReceiveActivtyItem(protocol)
  self._data.gardenPartyGottenItemsList = protocol.itemlist
end

function DM_AprilFoolsDay:OnSRefreshBattlesTimes(protocol)
  self._data.gardenPartyResetConfigTimes = protocol.resetConfigId
end

return DM_AprilFoolsDay
