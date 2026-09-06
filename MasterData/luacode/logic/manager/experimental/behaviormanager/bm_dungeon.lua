local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local ExploreAwardTypeEnum = LuaNetManager.GetBeanDef("protocol.battle.exploreawardrecord")
local BM_Dungeon = class("BM_Dungeon")

function BM_Dungeon:Ctor()
  self._dungeoninfo = NekoData.Data.dungeoninfo
end

function BM_Dungeon:GetDungeonInfo()
  return self._dungeoninfo
end

function BM_Dungeon:GetCurrentFloorId()
  if self._dungeoninfo.floorDetail then
    return self._dungeoninfo.floorDetail.floorid
  end
end

function BM_Dungeon:GetCurrentFloorDetail()
  return self._dungeoninfo.floorDetail
end

function BM_Dungeon:GetBattleAccountData()
  return self._dungeoninfo.awardList, self._dungeoninfo.currency, self._dungeoninfo.roleExp, self._dungeoninfo.battleTime, self._dungeoninfo.roleGoodExp, self._dungeoninfo.rolesIndex, self._dungeoninfo.playerExp
end

function BM_Dungeon:GetActorGridPosition()
  return self._dungeoninfo.actor_x, self._dungeoninfo.actor_y
end

function BM_Dungeon:GetActorWorldPosition()
  return self._dungeoninfo.actor_world_x, self._dungeoninfo.actor_world_z
end

function BM_Dungeon:GetFreeActorGridPosition()
  return self._dungeoninfo.actor_world_x / 0.4, -self._dungeoninfo.actor_world_z / 0.56
end

function BM_Dungeon:GetActorPrevGridPos()
  return self._dungeoninfo.prev_x, self._dungeoninfo.prev_y
end

function BM_Dungeon:GetActorOrientation()
  return self._dungeoninfo.dir or 0
end

local function PlayRandomItemPickEffect(self, data)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    local sceneid = controller:GetSceneID()
    if sceneid == data.sceneId then
      LuaNotificationCenter.PostNotification(Common.n_RandomItemPicked, self, data)
      return RandomItemManager.RemoveRandomItem(data.key, controller)
    end
  end
end

function BM_Dungeon:OnRandomItemPick(key)
  local item = RandomItemManager.GetRandomItem(key)
  if not item then
    LogError("BM_Dungeon", "try to pick invalid item, key " .. key)
    return
  end
  local sceneId = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon):GetSceneID()
  print(item:GetType(), RandomItemManager.Type.Mana, sceneId)
  local shouldSendProtocol = true
  if item:GetType() == RandomItemManager.Type.Mana then
    local seqEffect = PlayRandomItemPickEffect(self, {sceneId = sceneId, key = key})
    if seqEffect then
      local sendProtocol = EffectFactory.CreateCustomEffect(function()
        local req = LuaNetManager.CreateProtocol("protocol.battle.ctouchdungeonobject")
        req.sceneId = sceneId
        req.keys[#req.keys + 1] = key
        req:Send()
      end)
      seqEffect:AddEffect(sendProtocol)
      seqEffect:Run()
      shouldSendProtocol = false
    end
  end
  if shouldSendProtocol then
    local req = LuaNetManager.CreateProtocol("protocol.battle.ctouchdungeonobject")
    req.sceneId = sceneId
    req.keys[#req.keys + 1] = key
    req:Send()
  end
end

function BM_Dungeon:OnManaPick(keys)
  local root = EffectFactory.CreateEffectList()
  local req = LuaNetManager.CreateProtocol("protocol.battle.ctouchdungeonobject")
  local sceneId = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon):GetSceneID()
  req.sceneId = sceneId
  for _, key in pairs(keys) do
    local seqEffect = PlayRandomItemPickEffect(self, {sceneId = sceneId, key = key})
    if seqEffect then
      req.keys[#req.keys + 1] = key
      root:AddEffect(seqEffect)
    end
  end
  req:Send()
  root:Run()
end

function BM_Dungeon:OnSGetDungeonRandomItem(protocol)
  print("randomitem got")
  local item = RandomItemManager.GetRandomItem(protocol.key)
  if item and item:GetType() ~= RandomItemManager.Type.Mana then
    PlayRandomItemPickEffect(self, {
      sceneId = protocol.sceneId,
      key = protocol.key
    })
  end
end

function BM_Dungeon:GetEnterDungenonNeedSpirit(sceneid)
  local recorder = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
  for _, i in ipairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.sceneid == sceneid then
      return record.spirit
    end
  end
  return 0
end

function BM_Dungeon:OnActorGridPosUpdate()
  if self._dungeoninfo.prev_x ~= self._dungeoninfo.actor_x or self._dungeoninfo.prev_y ~= self._dungeoninfo.actor_y then
    local req = LuaNetManager.CreateProtocol("protocol.battle.crolemove")
    req.position.x = self._dungeoninfo.actor_x
    req.position.y = self._dungeoninfo.actor_y
    req.sceneid = self._dungeoninfo.floorDetail.floorid
    req:Send()
  end
end

function BM_Dungeon:OnFixedUpdate()
  if self._dungeoninfo._prevMoving and self._dungeoninfo._prevMoving ~= self._dungeoninfo._actorMoving then
    if self._dungeoninfo._actorMoving then
      LuaNotificationCenter.PostNotification(Common.n_ActorMovingStateChange, BM_Dungeon, {state = 1})
    else
      LuaNotificationCenter.PostNotification(Common.n_ActorMovingStateChange, BM_Dungeon, {state = 0})
    end
  end
  self._dungeoninfo._prevMoving = self._dungeoninfo._actorMoving
end

function BM_Dungeon:GetNewRandomItemsList(key)
  return self._dungeoninfo.newRandomItemsList[key]
end

function BM_Dungeon:GetDungeonMoney()
  return self._dungeoninfo.getMoney
end

function BM_Dungeon:BeginTransaction(eventid, type)
  local req = LuaNetManager.CreateProtocol("protocol.battle.ctransaction")
  req.value = eventid
  req.kind = type
  req.eventInitPoint.x = self._dungeoninfo.actor_x
  req.eventInitPoint.y = self._dungeoninfo.actor_y
  req:Send()
end

function BM_Dungeon:CommitTransaction(eventid, type)
  local req = LuaNetManager.CreateProtocol("protocol.battle.ccommit")
  req.value = eventid
  req.kind = type
  req:Send()
end

function BM_Dungeon:IsInTransaction()
  return self._dungeoninfo.intransaction
end

function BM_Dungeon:GetMode()
  return self._dungeoninfo.mode
end

function BM_Dungeon:GetDungeonConquestList()
  return self._dungeoninfo.dungeonConquestList
end

function BM_Dungeon:ClearDungeonConquestList()
  self._dungeoninfo.dungeonConquestList = {}
end

function BM_Dungeon:GetDungeonManaCollectorItemList()
  local data = self._dungeoninfo.dungeonConquestList[#self._dungeoninfo.dungeonConquestList]
  if data and data.way == ExploreAwardTypeEnum.GROUND then
    return {
      items = {
        [1] = {
          itemtype = ItemTypeEnum.BASEITEM,
          id = data.id,
          number = data.num
        }
      }
    }
  end
end

function BM_Dungeon:GetEquipRedData()
  return self._dungeoninfo.equipRedData
end

function BM_Dungeon:ClearEquipRedDataWithRoleKeyAndEquipType(roleKey, equipType)
  for _, roleValue in ipairs(self._dungeoninfo.equipRedData) do
    if roleKey == roleValue.roleKey then
      for type, t in pairs(roleValue.canEquipList) do
        if type == equipType then
          while t[#t] do
            local eK = t[#t]
            table.remove(t, #t)
            local sendProtocol = BattleClientProtocolManager.CreateProtocol("dungeonreddot.cdeletedungeonequipreddotoneline")
            sendProtocol.clientId = DataCommon.SqlClientId
            sendProtocol.roleKey = roleKey
            sendProtocol.equipKey = eK
            LuaSqlProtocalManager:SendProtocolToRemoteThread(sendProtocol)
          end
          LuaNotificationCenter.PostNotification(Common.n_DungeonEquipRedDot, self, nil)
          return
        end
      end
    end
  end
end

function BM_Dungeon:CheckEquipAttrib(role, key, roleValue)
  local getEquip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(key)
  local sendProtocol = BattleClientProtocolManager.CreateProtocol("dungeonreddot.cstoredungeonequipreddot")
  sendProtocol.clientId = DataCommon.SqlClientId
  sendProtocol.redDotData.roleKey = roleValue.roleKey
  sendProtocol.redDotData.weaponKey = 0
  sendProtocol.redDotData.armorKey = 0
  sendProtocol.redDotData.jewelryKey = 0
  local currentEquipKey
  if getEquip:GetEquipType() == EquipTypeEnum.WEAPON then
    currentEquipKey = role:GetWeapon()
    sendProtocol.redDotData.weaponKey = key
  elseif getEquip:GetEquipType() == EquipTypeEnum.ARMOR then
    currentEquipKey = role:GetArmor()
    sendProtocol.redDotData.armorKey = key
  elseif getEquip:GetEquipType() == EquipTypeEnum.JEWELRY then
    currentEquipKey = role:GetJewelry()
    sendProtocol.redDotData.jewelryKey = key
  end
  roleValue.canEquipList[getEquip:GetEquipType()] = roleValue.canEquipList[getEquip:GetEquipType()] or {}
  local curEquip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(currentEquipKey)
  local scoreFit = false
  if not curEquip or curEquip and curEquip:GetScore() < getEquip:GetScore() then
    scoreFit = true
  end
  local noCurrentEquip = currentEquipKey == 0
  local roleEquipTypeList = role:GetRoleEquipTypeList()
  local equipItemRecord = CEquipItemTable:GetRecorder(getEquip:GetID())
  for k, value in pairs(roleEquipTypeList) do
    if equipItemRecord.equipAttrib == tonumber(value) then
      local canProcess = false
      local str = equipItemRecord.roleLimit
      if str and str == "" then
        canProcess = true
      else
        local list = {}
        if str and str ~= "" then
          list = string.split(str, ";")
        end
        if table.keyof(list, tostring(role:GetId())) then
          canProcess = true
        end
      end
      if canProcess and (noCurrentEquip or not noCurrentEquip and scoreFit) then
        table.insert(roleValue.canEquipList[getEquip:GetEquipType()], key)
        LuaSqlProtocalManager:SendProtocolToRemoteThread(sendProtocol)
        LuaNotificationCenter.PostNotification(Common.n_DungeonEquipRedDot, self, nil)
      end
    end
  end
end

function BM_Dungeon:RemoveKeyFromEquipRedData(equipKey)
  local sendProtocol = BattleClientProtocolManager.CreateProtocol("dungeonreddot.cdeletedungeonequipreddotoneline")
  sendProtocol.clientId = DataCommon.SqlClientId
  local flag = false
  for _, roleValue in ipairs(self._dungeoninfo.equipRedData) do
    for _, t in pairs(roleValue.canEquipList) do
      local indexList = {}
      for i, k in ipairs(t) do
        if k == equipKey then
          table.insert(indexList, i)
          break
        end
      end
      for _, index in ipairs(indexList) do
        table.remove(t, index)
        sendProtocol.roleKey = roleValue.roleKey
        sendProtocol.equipKey = equipKey
        LuaSqlProtocalManager:SendProtocolToRemoteThread(sendProtocol)
        flag = true
      end
    end
  end
  if flag then
    LuaNotificationCenter.PostNotification(Common.n_DungeonEquipRedDot, self, nil)
  end
end

function BM_Dungeon:GetTowerNewPoint()
  return self._dungeoninfo.towernewpoint
end

function BM_Dungeon:SaveAutoExploreBattleSceneId(battleSceneId)
  self._dungeoninfo.autoExploreBattleSceneId = battleSceneId
end

function BM_Dungeon:GetAutoExploreBattleSceneId()
  return self._dungeoninfo.autoExploreBattleSceneId
end

return BM_Dungeon
