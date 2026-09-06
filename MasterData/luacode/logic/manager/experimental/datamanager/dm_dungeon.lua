local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local DM_Dungeon = class("DM_Dungeon")

function DM_Dungeon:Ctor()
  self._dungeoninfo = NekoData.Data.dungeoninfo
  self._dungeoninfo.actor_x = 0
  self._dungeoninfo.actor_y = 0
  self._dungeoninfo.actor_world_x = 0
  self._dungeoninfo.actor_world_z = 0
  self._dungeoninfo._actorMoving = false
  self._dungeoninfo.dungeonConquestList = {}
  self._dungeoninfo.equipRedData = {}
  self._dungeoninfo.intransaction = false
  self._dungeoninfo.towernewpoint = 0
  self._dungeoninfo.autoExploreBattleSceneId = 0
end

function DM_Dungeon:Clear()
  self._dungeoninfo.dungeonConquestList = {}
  self._dungeoninfo.autoExploreBattleSceneId = 0
end

function DM_Dungeon:OnSEnterDungeon(protocol)
  self._dungeoninfo.floorDetail = {}
  self._dungeoninfo.floorDetail.floorid = protocol.id
  self._dungeoninfo.floorDetail.point = {}
  if protocol.point then
    self._dungeoninfo.floorDetail.point.x = protocol.point.x
    self._dungeoninfo.floorDetail.point.y = protocol.point.y
    self._dungeoninfo.actor_x = protocol.point.x
    self._dungeoninfo.actor_y = protocol.point.y
    self._dungeoninfo.actor_world_x = protocol.point.x * 0.4
    self._dungeoninfo.actor_world_z = protocol.point.y * -0.56
  end
  self._dungeoninfo.getMoney = protocol.gold
  self:OnSEnterDungeonSaveEquipRedData(protocol)
end

function DM_Dungeon:OnSStartAutoExplore(protocol)
  self._dungeoninfo.battleResult = nil
  self._dungeoninfo.floorDetail = {
    floorid = protocol.id
  }
  self._dungeoninfo.rangeInfo = {
    id = protocol.zoneId,
    type = protocol.dungeonType
  }
end

function DM_Dungeon:OnSFinishAutoExplore(protocol)
  self._dungeoninfo.battleResult = protocol.battleResult
  self._dungeoninfo.awardList = protocol.exploreAwards
  self._dungeoninfo.currency = protocol.money
end

function DM_Dungeon:SetBattleResult(result)
  self._dungeoninfo.battleResult = result
end

function DM_Dungeon:SetBattleAccountData(awardList, currency, roleExp, battleTime, roleGoodExp, rolesIndex, playerExp)
  self._dungeoninfo.awardList = awardList
  self._dungeoninfo.currency = currency
  self._dungeoninfo.roleExp = roleExp
  self._dungeoninfo.battleTime = battleTime
  self._dungeoninfo.roleGoodExp = roleGoodExp
  self._dungeoninfo.rolesIndex = rolesIndex
  self._dungeoninfo.playerExp = playerExp
end

function DM_Dungeon:SetLoseResultHasShow(flag)
  self._dungeoninfo.hasShow = flag
end

function DM_Dungeon:SetActorGridPosition(x, y)
  self._dungeoninfo.prev_x = self._dungeoninfo.actor_x
  self._dungeoninfo.prev_y = self._dungeoninfo.actor_y
  self._dungeoninfo.actor_x = x
  self._dungeoninfo.actor_y = y
end

function DM_Dungeon:SetActorWorldPosition(x, z)
  self._dungeoninfo.prev_world_x = self._dungeoninfo.actor_world_x
  self._dungeoninfo.prev_world_z = self._dungeoninfo.actor_world_z
  self._dungeoninfo.actor_world_x = x
  self._dungeoninfo.actor_world_z = z
  self._dungeoninfo._actorMoving = true
end

function DM_Dungeon:SetActorOrientation(dir)
  self._dungeoninfo.dir = dir
end

function DM_Dungeon:OnSTouchManaCollector(protocol)
  self._dungeoninfo.newRandomItemsList = self._dungeoninfo.newRandomItemsList or {}
  self._dungeoninfo.newRandomItemsList[protocol.key] = protocol.manas
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    local sceneid = controller:GetSceneID()
    if sceneid == protocol.sceneId then
      RandomItemManager.RemoveRandomItem(protocol.key, controller)
    else
      LogError("stouchmanacollector", "wrong scene id for this scene checking from server")
    end
  end
end

function DM_Dungeon:OnSDungeonMoney(protocol)
  self._dungeoninfo.getMoney = protocol.gold
end

function DM_Dungeon:SetMode(mode)
  self._dungeoninfo.mode = mode
end

function DM_Dungeon:OnSRecordExploreAward(protocol)
  for _, v in ipairs(protocol.records) do
    table.insert(self._dungeoninfo.dungeonConquestList, v)
  end
end

local function BuildEquipRedData(self)
  self._dungeoninfo.equipRedData = {}
  local roleList = NekoData.BehaviorManager.BM_Team:GetCurrentRoleKeys()
  for k, v in pairs(roleList) do
    LogInfoFormat("DM_Dungeon", [[
current team role index %s key %s
traceback:
%s]], k, v, debug.traceback())
    if v ~= 0 then
      table.insert(self._dungeoninfo.equipRedData, {
        roleKey = v,
        canEquipList = {
          [EquipTypeEnum.WEAPON] = {},
          [EquipTypeEnum.ARMOR] = {},
          [EquipTypeEnum.JEWELRY] = {}
        }
      })
    end
  end
end

function DM_Dungeon:OnSEnterDungeonSaveEquipRedData(protocol)
  if not self._dungeoninfo.equipRedData or #self._dungeoninfo.equipRedData == 0 then
    BuildEquipRedData(self)
  else
    local roleList = NekoData.BehaviorManager.BM_Team:GetCurrentRoleKeys()
    for k, v in pairs(roleList) do
      LogInfoFormat("DM_Dungeon", [[
current team role index %s key %s
traceback:
%s]], k, v, debug.traceback())
      if v ~= 0 then
        local flag = true
        for _, roleValue in ipairs(self._dungeoninfo.equipRedData) do
          if roleValue.roleKey == v then
            flag = false
          end
        end
        if flag then
          table.insert(self._dungeoninfo.equipRedData, {
            roleKey = v,
            canEquipList = {
              [EquipTypeEnum.WEAPON] = {},
              [EquipTypeEnum.ARMOR] = {},
              [EquipTypeEnum.JEWELRY] = {}
            }
          })
        end
      end
    end
  end
end

function DM_Dungeon:OnSAddItem(protocol)
  local equipData = {}
  for i, itemValue in ipairs(protocol.data) do
    if itemValue.itemtype == ItemTypeEnum.EQUIP then
      table.insert(equipData, itemValue)
    end
  end
  for _, roleValue in ipairs(self._dungeoninfo.equipRedData) do
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleValue.roleKey)
    if role then
      for i, itemValue in ipairs(equipData) do
        NekoData.BehaviorManager.BM_Dungeon:CheckEquipAttrib(role, itemValue.key, roleValue)
      end
    else
      LogErrorFormat("DM_Dungeon", "role key %s is not in roleList:", roleValue.roleKey)
      for _, role in ipairs(NekoData.BehaviorManager.BM_AllRoles:GetRoleList()) do
        LogInfoFormat("DM_Dungeon", " --role key %s", role:GetRoleId())
      end
    end
  end
end

function DM_Dungeon:OnSChangeEquipment(protocol)
  for equipKey, rK in pairs(protocol.equips) do
    if rK == 0 then
      for roleKey, eK in pairs(protocol.roles) do
        for _, roleValue in ipairs(self._dungeoninfo.equipRedData) do
          if roleKey ~= roleValue.roleKey then
            local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleValue.roleKey)
            if role then
              NekoData.BehaviorManager.BM_Dungeon:CheckEquipAttrib(role, equipKey, roleValue)
            else
              LogErrorFormat("DM_Dungeon", "role key %s is not in roleList:", roleValue.roleKey)
              for _, role in ipairs(NekoData.BehaviorManager.BM_AllRoles:GetRoleList()) do
                LogInfoFormat("DM_Dungeon", " --role key %s", role:GetRoleId())
              end
            end
          end
        end
      end
    else
      NekoData.BehaviorManager.BM_Dungeon:RemoveKeyFromEquipRedData(equipKey)
    end
  end
end

function DM_Dungeon:OnSRemoveItem(protocol)
  if protocol.bagType == LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes").EQUIPBAG then
    NekoData.BehaviorManager.BM_Dungeon:RemoveKeyFromEquipRedData(protocol.itemKey)
  end
end

function DM_Dungeon:OnSGetDungeonEquipRedDot_LocalProtocol(protocol)
  if protocol.clientId ~= DataCommon.SqlClientId then
    return
  end
  if not self._dungeoninfo.equipRedData or #self._dungeoninfo.equipRedData == 0 then
    BuildEquipRedData(self)
  end
  for _, roleValue in ipairs(self._dungeoninfo.equipRedData) do
    for _, v in ipairs(protocol.redDotData) do
      if v.roleKey == roleValue.roleKey then
        if v.weaponKey ~= 0 then
          table.insert(roleValue.canEquipList[EquipTypeEnum.WEAPON], v.weaponKey)
        end
        if v.armorKey ~= 0 then
          table.insert(roleValue.canEquipList[EquipTypeEnum.ARMOR], v.armorKey)
        end
        if v.jewelryKey ~= 0 then
          table.insert(roleValue.canEquipList[EquipTypeEnum.JEWELRY], v.jewelryKey)
        end
      end
    end
  end
end

function DM_Dungeon:OnSEnterMainCity()
  self._dungeoninfo.equipRedData = {}
  local sendProtocol = BattleClientProtocolManager.CreateProtocol("dungeonreddot.cdeletedungeonequipreddot")
  sendProtocol.clientId = DataCommon.SqlClientId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(sendProtocol)
end

function DM_Dungeon:OnSTransaction()
  self._dungeoninfo.intransaction = true
end

function DM_Dungeon:OnSCommit()
  self._dungeoninfo.intransaction = false
end

function DM_Dungeon:OnSSLightTowerPanelRedpoint(protocol)
  self._dungeoninfo.towernewpoint = protocol.light
end

return DM_Dungeon
