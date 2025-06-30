-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_dungeon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local DM_Dungeon = class("DM_Dungeon")
DM_Dungeon.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._dungeoninfo = (NekoData.Data).dungeoninfo
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo).actor_x = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo).actor_y = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo).actor_world_x = 0
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo).actor_world_z = 0
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo)._actorMoving = false
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo).dungeonConquestList = {}
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo).equipRedData = {}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo).intransaction = false
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo).towernewpoint = 0
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo).autoExploreBattleSceneId = 0
end

DM_Dungeon.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._dungeoninfo).dungeonConquestList = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo).autoExploreBattleSceneId = 0
end

DM_Dungeon.OnSEnterDungeon = function(self, protocol)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._dungeoninfo).floorDetail = {}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._dungeoninfo).floorDetail).floorid = protocol.id
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._dungeoninfo).floorDetail).point = {}
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.point then
    (((self._dungeoninfo).floorDetail).point).x = (protocol.point).x
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self._dungeoninfo).floorDetail).point).y = (protocol.point).y
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._dungeoninfo).actor_x = (protocol.point).x
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._dungeoninfo).actor_y = (protocol.point).y
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._dungeoninfo).actor_world_x = (protocol.point).x * 0.4
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._dungeoninfo).actor_world_z = (protocol.point).y * -0.56
  end
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dungeoninfo).getMoney = protocol.gold
  self:OnSEnterDungeonSaveEquipRedData(protocol)
end

DM_Dungeon.OnSStartAutoExplore = function(self, protocol)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._dungeoninfo).battleResult = nil
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dungeoninfo).floorDetail = {floorid = protocol.id}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dungeoninfo).rangeInfo = {id = protocol.zoneId, type = protocol.dungeonType}
end

DM_Dungeon.OnSFinishAutoExplore = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._dungeoninfo).battleResult = protocol.battleResult
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dungeoninfo).awardList = protocol.exploreAwards
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dungeoninfo).currency = protocol.money
end

DM_Dungeon.SetBattleResult = function(self, result)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._dungeoninfo).battleResult = result
end

DM_Dungeon.SetBattleAccountData = function(self, awardList, currency, roleExp, battleTime, roleGoodExp, rolesIndex, playerExp)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R8 in 'UnsetPending'

  (self._dungeoninfo).awardList = awardList
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._dungeoninfo).currency = currency
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._dungeoninfo).roleExp = roleExp
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._dungeoninfo).battleTime = battleTime
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._dungeoninfo).roleGoodExp = roleGoodExp
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._dungeoninfo).rolesIndex = rolesIndex
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._dungeoninfo).playerExp = playerExp
end

DM_Dungeon.SetLoseResultHasShow = function(self, flag)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._dungeoninfo).hasShow = flag
end

DM_Dungeon.SetActorGridPosition = function(self, x, y)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  (self._dungeoninfo).prev_x = (self._dungeoninfo).actor_x
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._dungeoninfo).prev_y = (self._dungeoninfo).actor_y
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._dungeoninfo).actor_x = x
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._dungeoninfo).actor_y = y
end

DM_Dungeon.SetActorWorldPosition = function(self, x, z)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  (self._dungeoninfo).prev_world_x = (self._dungeoninfo).actor_world_x
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._dungeoninfo).prev_world_z = (self._dungeoninfo).actor_world_z
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._dungeoninfo).actor_world_x = x
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._dungeoninfo).actor_world_z = z
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._dungeoninfo)._actorMoving = true
end

DM_Dungeon.SetActorOrientation = function(self, dir)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._dungeoninfo).dir = dir
end

DM_Dungeon.OnSTouchManaCollector = function(self, protocol)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._dungeoninfo).newRandomItemsList then
    (self._dungeoninfo).newRandomItemsList = {}
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._dungeoninfo).newRandomItemsList)[protocol.key] = protocol.manas
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller then
      local sceneid = controller:GetSceneID()
      if sceneid == protocol.sceneId then
        (RandomItemManager.RemoveRandomItem)(protocol.key, controller)
      else
        LogError("stouchmanacollector", "wrong scene id for this scene checking from server")
      end
    end
  end
end

DM_Dungeon.OnSDungeonMoney = function(self, protocol)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._dungeoninfo).getMoney = protocol.gold
end

DM_Dungeon.SetMode = function(self, mode)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._dungeoninfo).mode = mode
end

DM_Dungeon.OnSRecordExploreAward = function(self, protocol)
  -- function num : 0_14 , upvalues : _ENV
  for _,v in ipairs(protocol.records) do
    (table.insert)((self._dungeoninfo).dungeonConquestList, v)
  end
end

local BuildEquipRedData = function(self)
  -- function num : 0_15 , upvalues : _ENV, EquipTypeEnum
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._dungeoninfo).equipRedData = {}
  local roleList = ((NekoData.BehaviorManager).BM_Team):GetCurrentRoleKeys()
  for k,v in pairs(roleList) do
    LogInfoFormat("DM_Dungeon", "current team role index %s key %s\ntraceback:\n%s", k, v, (debug.traceback)())
    if v ~= 0 then
      (table.insert)((self._dungeoninfo).equipRedData, {roleKey = v, 
canEquipList = {
[EquipTypeEnum.WEAPON] = {}
, 
[EquipTypeEnum.ARMOR] = {}
, 
[EquipTypeEnum.JEWELRY] = {}
}
})
    end
  end
end

DM_Dungeon.OnSEnterDungeonSaveEquipRedData = function(self, protocol)
  -- function num : 0_16 , upvalues : BuildEquipRedData, _ENV, EquipTypeEnum
  if not (self._dungeoninfo).equipRedData or #(self._dungeoninfo).equipRedData == 0 then
    BuildEquipRedData(self)
  else
    local roleList = ((NekoData.BehaviorManager).BM_Team):GetCurrentRoleKeys()
    for k,v in pairs(roleList) do
      LogInfoFormat("DM_Dungeon", "current team role index %s key %s\ntraceback:\n%s", k, v, (debug.traceback)())
      if v ~= 0 then
        local flag = true
        for _,roleValue in ipairs((self._dungeoninfo).equipRedData) do
          if roleValue.roleKey == v then
            flag = false
          end
        end
        if flag then
          (table.insert)((self._dungeoninfo).equipRedData, {roleKey = v, 
canEquipList = {
[EquipTypeEnum.WEAPON] = {}
, 
[EquipTypeEnum.ARMOR] = {}
, 
[EquipTypeEnum.JEWELRY] = {}
}
})
        end
      end
    end
  end
end

DM_Dungeon.OnSAddItem = function(self, protocol)
  -- function num : 0_17 , upvalues : _ENV, ItemTypeEnum
  local equipData = {}
  for i,itemValue in ipairs(protocol.data) do
    if itemValue.itemtype == ItemTypeEnum.EQUIP then
      (table.insert)(equipData, itemValue)
    end
  end
  for _,roleValue in ipairs((self._dungeoninfo).equipRedData) do
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleValue.roleKey)
    if role then
      for i,itemValue in ipairs(equipData) do
        ((NekoData.BehaviorManager).BM_Dungeon):CheckEquipAttrib(role, itemValue.key, roleValue)
      end
    else
      do
        LogErrorFormat("DM_Dungeon", "role key %s is not in roleList:", roleValue.roleKey)
        for _,role in ipairs(((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()) do
          LogInfoFormat("DM_Dungeon", " --role key %s", role:GetRoleId())
        end
        do
          -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

DM_Dungeon.OnSChangeEquipment = function(self, protocol)
  -- function num : 0_18 , upvalues : _ENV
  for equipKey,rK in pairs(protocol.equips) do
    if rK == 0 then
      for roleKey,eK in pairs(protocol.roles) do
        for _,roleValue in ipairs((self._dungeoninfo).equipRedData) do
          if roleKey ~= roleValue.roleKey then
            local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleValue.roleKey)
            if role then
              ((NekoData.BehaviorManager).BM_Dungeon):CheckEquipAttrib(role, equipKey, roleValue)
            else
              LogErrorFormat("DM_Dungeon", "role key %s is not in roleList:", roleValue.roleKey)
              for _,role in ipairs(((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()) do
                LogInfoFormat("DM_Dungeon", " --role key %s", role:GetRoleId())
              end
            end
          end
        end
      end
    else
      do
        do
          ;
          ((NekoData.BehaviorManager).BM_Dungeon):RemoveKeyFromEquipRedData(equipKey)
          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

DM_Dungeon.OnSRemoveItem = function(self, protocol)
  -- function num : 0_19 , upvalues : _ENV
  if protocol.bagType == ((LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")).EQUIPBAG then
    ((NekoData.BehaviorManager).BM_Dungeon):RemoveKeyFromEquipRedData(protocol.itemKey)
  end
end

DM_Dungeon.OnSGetDungeonEquipRedDot_LocalProtocol = function(self, protocol)
  -- function num : 0_20 , upvalues : _ENV, BuildEquipRedData, EquipTypeEnum
  if protocol.clientId ~= DataCommon.SqlClientId then
    return 
  end
  if not (self._dungeoninfo).equipRedData or #(self._dungeoninfo).equipRedData == 0 then
    BuildEquipRedData(self)
  end
  for _,roleValue in ipairs((self._dungeoninfo).equipRedData) do
    for _,v in ipairs(protocol.redDotData) do
      if v.roleKey == roleValue.roleKey then
        if v.weaponKey ~= 0 then
          (table.insert)((roleValue.canEquipList)[EquipTypeEnum.WEAPON], v.weaponKey)
        end
        if v.armorKey ~= 0 then
          (table.insert)((roleValue.canEquipList)[EquipTypeEnum.ARMOR], v.armorKey)
        end
        if v.jewelryKey ~= 0 then
          (table.insert)((roleValue.canEquipList)[EquipTypeEnum.JEWELRY], v.jewelryKey)
        end
      end
    end
  end
end

DM_Dungeon.OnSEnterMainCity = function(self)
  -- function num : 0_21 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._dungeoninfo).equipRedData = {}
  local sendProtocol = (BattleClientProtocolManager.CreateProtocol)("dungeonreddot.cdeletedungeonequipreddot")
  sendProtocol.clientId = DataCommon.SqlClientId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(sendProtocol)
end

DM_Dungeon.OnSTransaction = function(self)
  -- function num : 0_22
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._dungeoninfo).intransaction = true
end

DM_Dungeon.OnSCommit = function(self)
  -- function num : 0_23
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._dungeoninfo).intransaction = false
end

DM_Dungeon.OnSSLightTowerPanelRedpoint = function(self, protocol)
  -- function num : 0_24
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._dungeoninfo).towernewpoint = protocol.light
end

return DM_Dungeon

