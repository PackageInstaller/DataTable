-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_dungeon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local ExploreAwardTypeEnum = (LuaNetManager.GetBeanDef)("protocol.battle.exploreawardrecord")
local BM_Dungeon = class("BM_Dungeon")
BM_Dungeon.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._dungeoninfo = (NekoData.Data).dungeoninfo
end

BM_Dungeon.GetDungeonInfo = function(self)
  -- function num : 0_1
  return self._dungeoninfo
end

BM_Dungeon.GetCurrentFloorId = function(self)
  -- function num : 0_2
  if (self._dungeoninfo).floorDetail then
    return ((self._dungeoninfo).floorDetail).floorid
  end
end

BM_Dungeon.GetCurrentFloorDetail = function(self)
  -- function num : 0_3
  return (self._dungeoninfo).floorDetail
end

BM_Dungeon.GetBattleAccountData = function(self)
  -- function num : 0_4
  return (self._dungeoninfo).awardList, (self._dungeoninfo).currency, (self._dungeoninfo).roleExp, (self._dungeoninfo).battleTime, (self._dungeoninfo).roleGoodExp, (self._dungeoninfo).rolesIndex, (self._dungeoninfo).playerExp
end

BM_Dungeon.GetActorGridPosition = function(self)
  -- function num : 0_5
  return (self._dungeoninfo).actor_x, (self._dungeoninfo).actor_y
end

BM_Dungeon.GetActorWorldPosition = function(self)
  -- function num : 0_6
  return (self._dungeoninfo).actor_world_x, (self._dungeoninfo).actor_world_z
end

BM_Dungeon.GetFreeActorGridPosition = function(self)
  -- function num : 0_7
  return (self._dungeoninfo).actor_world_x / 0.4, -(self._dungeoninfo).actor_world_z / 0.56
end

BM_Dungeon.GetActorPrevGridPos = function(self)
  -- function num : 0_8
  return (self._dungeoninfo).prev_x, (self._dungeoninfo).prev_y
end

BM_Dungeon.GetActorOrientation = function(self)
  -- function num : 0_9
  return (self._dungeoninfo).dir or 0
end

local PlayRandomItemPickEffect = function(self, data)
  -- function num : 0_10 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller then
    local sceneid = controller:GetSceneID()
    if sceneid == data.sceneId then
      (LuaNotificationCenter.PostNotification)(Common.n_RandomItemPicked, self, data)
      return (RandomItemManager.RemoveRandomItem)(data.key, controller)
    end
  end
end

BM_Dungeon.OnRandomItemPick = function(self, key)
  -- function num : 0_11 , upvalues : _ENV, PlayRandomItemPickEffect
  local item = (RandomItemManager.GetRandomItem)(key)
  if not item then
    LogError("BM_Dungeon", "try to pick invalid item, key " .. key)
    return 
  end
  local sceneId = ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):GetSceneID()
  print(item:GetType(), (RandomItemManager.Type).Mana, sceneId)
  local shouldSendProtocol = true
  if item:GetType() == (RandomItemManager.Type).Mana then
    local seqEffect = PlayRandomItemPickEffect(self, {sceneId = sceneId, key = key})
    if seqEffect then
      local sendProtocol = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_11_0 , upvalues : _ENV, sceneId, key
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.ctouchdungeonobject")
    req.sceneId = sceneId
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (req.keys)[#req.keys + 1] = key
    req:Send()
  end
)
      seqEffect:AddEffect(sendProtocol)
      seqEffect:Run()
      shouldSendProtocol = false
    end
  end
  do
    if shouldSendProtocol then
      local req = (LuaNetManager.CreateProtocol)("protocol.battle.ctouchdungeonobject")
      req.sceneId = sceneId
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (req.keys)[#req.keys + 1] = key
      req:Send()
    end
  end
end

BM_Dungeon.OnManaPick = function(self, keys)
  -- function num : 0_12 , upvalues : _ENV, PlayRandomItemPickEffect
  local root = (EffectFactory.CreateEffectList)()
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.ctouchdungeonobject")
  local sceneId = ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):GetSceneID()
  req.sceneId = sceneId
  for _,key in pairs(keys) do
    local seqEffect = PlayRandomItemPickEffect(self, {sceneId = sceneId, key = key})
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R11 in 'UnsetPending'

    if seqEffect then
      (req.keys)[#req.keys + 1] = key
      root:AddEffect(seqEffect)
    end
  end
  req:Send()
  root:Run()
end

BM_Dungeon.OnSGetDungeonRandomItem = function(self, protocol)
  -- function num : 0_13 , upvalues : _ENV, PlayRandomItemPickEffect
  print("randomitem got")
  local item = (RandomItemManager.GetRandomItem)(protocol.key)
  if item and item:GetType() ~= (RandomItemManager.Type).Mana then
    PlayRandomItemPickEffect(self, {sceneId = protocol.sceneId, key = protocol.key})
  end
end

BM_Dungeon.GetEnterDungenonNeedSpirit = function(self, sceneid)
  -- function num : 0_14 , upvalues : _ENV
  local recorder = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
  for _,i in ipairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.sceneid == sceneid then
      return record.spirit
    end
  end
  return 0
end

BM_Dungeon.OnActorGridPosUpdate = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if (self._dungeoninfo).prev_x ~= (self._dungeoninfo).actor_x or (self._dungeoninfo).prev_y ~= (self._dungeoninfo).actor_y then
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.crolemove")
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (req.position).x = (self._dungeoninfo).actor_x
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (req.position).y = (self._dungeoninfo).actor_y
    req.sceneid = ((self._dungeoninfo).floorDetail).floorid
    req:Send()
  end
end

BM_Dungeon.OnFixedUpdate = function(self)
  -- function num : 0_16 , upvalues : _ENV, BM_Dungeon
  if (self._dungeoninfo)._prevMoving and (self._dungeoninfo)._prevMoving ~= (self._dungeoninfo)._actorMoving then
    if (self._dungeoninfo)._actorMoving then
      (LuaNotificationCenter.PostNotification)(Common.n_ActorMovingStateChange, BM_Dungeon, {state = 1})
    else
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_ActorMovingStateChange, BM_Dungeon, {state = 0})
    end
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dungeoninfo)._prevMoving = (self._dungeoninfo)._actorMoving
end

BM_Dungeon.GetNewRandomItemsList = function(self, key)
  -- function num : 0_17
  return ((self._dungeoninfo).newRandomItemsList)[key]
end

BM_Dungeon.GetDungeonMoney = function(self)
  -- function num : 0_18
  return (self._dungeoninfo).getMoney
end

BM_Dungeon.BeginTransaction = function(self, eventid, type)
  -- function num : 0_19 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.ctransaction")
  req.value = eventid
  req.kind = type
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (req.eventInitPoint).x = (self._dungeoninfo).actor_x
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (req.eventInitPoint).y = (self._dungeoninfo).actor_y
  req:Send()
end

BM_Dungeon.CommitTransaction = function(self, eventid, type)
  -- function num : 0_20 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.ccommit")
  req.value = eventid
  req.kind = type
  req:Send()
end

BM_Dungeon.IsInTransaction = function(self)
  -- function num : 0_21
  return (self._dungeoninfo).intransaction
end

BM_Dungeon.GetMode = function(self)
  -- function num : 0_22
  return (self._dungeoninfo).mode
end

BM_Dungeon.GetDungeonConquestList = function(self)
  -- function num : 0_23
  return (self._dungeoninfo).dungeonConquestList
end

BM_Dungeon.ClearDungeonConquestList = function(self)
  -- function num : 0_24
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._dungeoninfo).dungeonConquestList = {}
end

BM_Dungeon.GetDungeonManaCollectorItemList = function(self)
  -- function num : 0_25 , upvalues : ExploreAwardTypeEnum, ItemTypeEnum
  local data = ((self._dungeoninfo).dungeonConquestList)[#(self._dungeoninfo).dungeonConquestList]
  if data and data.way == ExploreAwardTypeEnum.GROUND then
    return {
items = {
[1] = {itemtype = ItemTypeEnum.BASEITEM, id = data.id, number = data.num}
}
}
  end
end

BM_Dungeon.GetEquipRedData = function(self)
  -- function num : 0_26
  return (self._dungeoninfo).equipRedData
end

BM_Dungeon.ClearEquipRedDataWithRoleKeyAndEquipType = function(self, roleKey, equipType)
  -- function num : 0_27 , upvalues : _ENV
  for _,roleValue in ipairs((self._dungeoninfo).equipRedData) do
    if roleKey == roleValue.roleKey then
      for type,t in pairs(roleValue.canEquipList) do
        while 1 do
          if type == equipType then
            if t[#t] then
              local eK = t[#t]
              ;
              (table.remove)(t, #t)
              do
                local sendProtocol = (BattleClientProtocolManager.CreateProtocol)("dungeonreddot.cdeletedungeonequipreddotoneline")
                sendProtocol.clientId = DataCommon.SqlClientId
                sendProtocol.roleKey = roleKey
                sendProtocol.equipKey = eK
                LuaSqlProtocalManager:SendProtocolToRemoteThread(sendProtocol)
                -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_DungeonEquipRedDot, self, nil)
        do return  end
      end
    end
  end
end

BM_Dungeon.CheckEquipAttrib = function(self, role, key, roleValue)
  -- function num : 0_28 , upvalues : _ENV, EquipTypeEnum, CEquipItemTable
  local getEquip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(key)
  local sendProtocol = (BattleClientProtocolManager.CreateProtocol)("dungeonreddot.cstoredungeonequipreddot")
  sendProtocol.clientId = DataCommon.SqlClientId
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (sendProtocol.redDotData).roleKey = roleValue.roleKey
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (sendProtocol.redDotData).weaponKey = 0
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (sendProtocol.redDotData).armorKey = 0
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (sendProtocol.redDotData).jewelryKey = 0
  local currentEquipKey = nil
  if getEquip:GetEquipType() == EquipTypeEnum.WEAPON then
    currentEquipKey = role:GetWeapon()
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (sendProtocol.redDotData).weaponKey = key
  else
    if getEquip:GetEquipType() == EquipTypeEnum.ARMOR then
      currentEquipKey = role:GetArmor()
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (sendProtocol.redDotData).armorKey = key
    else
      if getEquip:GetEquipType() == EquipTypeEnum.JEWELRY then
        currentEquipKey = role:GetJewelry()
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (sendProtocol.redDotData).jewelryKey = key
      end
    end
  end
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R7 in 'UnsetPending'

  if not (roleValue.canEquipList)[getEquip:GetEquipType()] then
    (roleValue.canEquipList)[getEquip:GetEquipType()] = {}
    local curEquip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(currentEquipKey)
    local scoreFit = false
    if not curEquip or curEquip and curEquip:GetScore() < getEquip:GetScore() then
      scoreFit = true
    end
    local noCurrentEquip = currentEquipKey == 0
    local roleEquipTypeList = role:GetRoleEquipTypeList()
    local equipItemRecord = CEquipItemTable:GetRecorder(getEquip:GetID())
    for k,value in pairs(roleEquipTypeList) do
      if equipItemRecord.equipAttrib == tonumber(value) then
        local canProcess = false
        local str = equipItemRecord.roleLimit
        if str and str == "" then
          canProcess = true
        else
          local list = {}
          if str and str ~= "" then
            list = (string.split)(str, ";")
          end
          if (table.keyof)(list, tostring(role:GetId())) then
            canProcess = true
          end
        end
        if canProcess and (noCurrentEquip or noCurrentEquip or scoreFit) then
          (table.insert)((roleValue.canEquipList)[getEquip:GetEquipType()], key)
          LuaSqlProtocalManager:SendProtocolToRemoteThread(sendProtocol)
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_DungeonEquipRedDot, self, nil)
        end
      end
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

BM_Dungeon.RemoveKeyFromEquipRedData = function(self, equipKey)
  -- function num : 0_29 , upvalues : _ENV
  local sendProtocol = (BattleClientProtocolManager.CreateProtocol)("dungeonreddot.cdeletedungeonequipreddotoneline")
  sendProtocol.clientId = DataCommon.SqlClientId
  local flag = false
  for _,roleValue in ipairs((self._dungeoninfo).equipRedData) do
    for _,t in pairs(roleValue.canEquipList) do
      local indexList = {}
      for i,k in ipairs(t) do
        if k == equipKey then
          (table.insert)(indexList, i)
          break
        end
      end
      do
        for _,index in ipairs(indexList) do
          (table.remove)(t, index)
          sendProtocol.roleKey = roleValue.roleKey
          sendProtocol.equipKey = equipKey
          LuaSqlProtocalManager:SendProtocolToRemoteThread(sendProtocol)
          flag = true
        end
        do
          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  if flag then
    (LuaNotificationCenter.PostNotification)(Common.n_DungeonEquipRedDot, self, nil)
  end
end

BM_Dungeon.GetTowerNewPoint = function(self)
  -- function num : 0_30
  return (self._dungeoninfo).towernewpoint
end

BM_Dungeon.SaveAutoExploreBattleSceneId = function(self, battleSceneId)
  -- function num : 0_31
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._dungeoninfo).autoExploreBattleSceneId = battleSceneId
end

BM_Dungeon.GetAutoExploreBattleSceneId = function(self)
  -- function num : 0_32
  return (self._dungeoninfo).autoExploreBattleSceneId
end

return BM_Dungeon

