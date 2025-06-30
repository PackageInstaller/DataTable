-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_aprilfoolsday.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CClownRole = (BeanManager.GetTableByName)("activity.cclownrole")
local DM_AprilFoolsDay = class("DM_AprilFoolsDay")
DM_AprilFoolsDay.TowerFloorStateType = {Going = 0, Finish = 1, Untraveled = 2}
DM_AprilFoolsDay.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).aprilfoolsday
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).beatClownIsOpen = false
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).shopIsOpen = false
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).receiveAwardTimes = 0
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).redDotShowList = {}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).gardenPartyIsOpen = false
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).gardenPartyRoleList = {}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).gardenPartyDungeonBattle = {}
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).gardenPartyGottenItemsList = {}
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).gardenPartyFunctionUnlock = {}
end

DM_AprilFoolsDay.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).beatClownIsOpen = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).shopIsOpen = false
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).redDotShowList = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).gardenPartyIsOpen = false
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).gardenPartyRoleList = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).gardenPartyDungeonBattle = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).gardenPartyGottenItemsList = {}
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).gardenPartyFunctionUnlock = {}
end

DM_AprilFoolsDay.OnSSendBeatClownActivity = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).beatClownIsOpen = protocol.state == 1
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).receiveAwardTimes = protocol.receiveTimes
  LogInfoFormat("DM_AprilFoolsDay", "receiveTimes %s", protocol.receiveTimes)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_AprilFoolsDay.OnSSendFoolsShopActivity = function(self, protocol)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).shopIsOpen = protocol.state == 1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_AprilFoolsDay.OnSSendFoolsRedPoint = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  for _,v in ipairs(protocol.redpoint) do
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).redDotShowList)[v] = true
  end
end

DM_AprilFoolsDay.OnSOpenFoolsDayActivity = function(self, protocol)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).gardenPartyIsOpen = protocol.state == 1
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).gardenPartyCurrentFloorId = protocol.floorId
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).gardenPartyCurrentFloorState = protocol.floorState
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).gardenPartyFunctionUnlock = protocol.functionId
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).gardenPartyResetConfigTimes = protocol.resetConfigId
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).gardenPartyTowerAndDungeonIsOpen = protocol.closeOthers == 0
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DM_AprilFoolsDay.OnSRefreshFoolsDayRoles = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV, CClownRole
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).gardenPartyRoleList = {}
  local record = nil
  for _,role in ipairs(protocol.roles) do
    record = CClownRole:GetRecorder(role.Id)
    if not record then
      LogErrorFormat("DM_AprilFoolsDay", "role configId %s not in cclownrole", role.Id)
    else
      ;
      (table.insert)((self._data).gardenPartyRoleList, {Id = role.Id, roleLv = role.roleLv, weaponLv = role.weaponLv, attack = role.attack, blood = role.blood, roleId = record.roleid, equipid = record.equipid, battlesort = record.battlesort, tipstextid = record.tipstextid, growATK = record.growATK, growHP = record.growHP})
    end
  end
end

DM_AprilFoolsDay.OnSRefreshFoolsDaySingleRole = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV, CClownRole
  for _,role in ipairs((self._data).gardenPartyRoleList) do
    if role.Id == (protocol.role).Id then
      role.roleLv = (protocol.role).roleLv
      role.weaponLv = (protocol.role).weaponLv
      role.attack = (protocol.role).attack
      role.blood = (protocol.role).blood
      return 
    end
  end
  local record = CClownRole:GetRecorder((protocol.role).Id)
  if not record then
    LogErrorFormat("DM_AprilFoolsDay", "role configId %s not in cclownrole", (protocol.role).Id)
  else
    ;
    (table.insert)((self._data).gardenPartyRoleList, {Id = (protocol.role).Id, roleLv = (protocol.role).roleLv, weaponLv = (protocol.role).weaponLv, attack = (protocol.role).attack, blood = (protocol.role).blood, roleId = record.roleid, equipid = record.equipid, battlesort = record.battlesort, tipstextid = record.tipstextid, growATK = record.growATK, growHP = record.growHP})
  end
end

DM_AprilFoolsDay.OnSEnterNextFloor = function(self, protocol)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).gardenPartyCurrentFloorId = protocol.floorId
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).gardenPartyCurrentFloorState = (self.TowerFloorStateType).Going
end

DM_AprilFoolsDay.OnSCompeleteFloor = function(self, protocol)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).gardenPartyCurrentFloorId = protocol.floorId
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).gardenPartyCurrentFloorState = (self.TowerFloorStateType).Finish
end

DM_AprilFoolsDay.OnSOpenFoolsCopyBattle = function(self, protocol)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).gardenPartyDungeonBattle = protocol.battleInfo
end

DM_AprilFoolsDay.OnSUnlockFoolsDaysFunction = function(self, protocol)
  -- function num : 0_11 , upvalues : _ENV
  (table.insert)((self._data).gardenPartyFunctionUnlock, protocol.functionId)
end

DM_AprilFoolsDay.OnSReceiveActivtyItem = function(self, protocol)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).gardenPartyGottenItemsList = protocol.itemlist
end

DM_AprilFoolsDay.OnSRefreshBattlesTimes = function(self, protocol)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).gardenPartyResetConfigTimes = protocol.resetConfigId
end

return DM_AprilFoolsDay

