local System = require("ecs.system")
local BattleEndType = BattleClientProtocolManager.GetBeanDef("data.battleendtype")
local HpSystem = strictclass("HpSystem", System)

function HpSystem:Ctor(...)
  HpSystem.super.Ctor(self, ...)
  self._utility = BattleECS.Utility.Utility
  self._protocolUtility = BattleECS.Utility.ProtocolUtility
  self._buffUtility = BattleECS.Utility.BuffUtility
  self._animationUtility = BattleECS.Utility.AnimationUtility
  self._dataUtility = BattleECS.Utility.DataUtility
end

function HpSystem:Destroy()
  HpSystem.super.Destroy(self)
end

function HpSystem:Update()
  local CampType = BattleECS.Components.TypeComponent.CampType
  local HpComponent = BattleECS.Components.HpComponent
  local TypeComponent = BattleECS.Components.TypeComponent
  local PhysicsComponent = BattleECS.Components.PhysicsComponent
  local isJoin, data = self._utility.IsJoinBattleAndEnoughCondition(self._world._battleID)
  if isJoin and not self._world._isJoin then
    for _, v in ipairs(self._world._rightPlayerList) do
      local component = v:GetComponent(HpComponent)
      if component and component._currentHp / component._maxHp < data.num then
        self._world:SetIsJoin(true)
        local record
        for _, inV in ipairs(self._dataUtility.cJoinBattleInfoTable) do
          if inV.id == data.id then
            record = inV.record
            break
          end
        end
        if record then
          local camp = CampType.None
          if string.find(record.beginPoint, "L") then
            camp = CampType.Left
          elseif string.find(record.beginPoint, "R") then
            camp = CampType.Right
          end
          local posId = tonumber(string.match(record.beginPoint, "%d+"))
          local Enum_Camp = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
          local bean = BattleClientProtocolManager.CreateBean("data.attribute")
          bean.id = record.joinBattleNpcID
          bean.key = posId
          bean.camp = camp
          bean.pos = posId
          local config = self._dataUtility.cMonsterCfgTable[record.joinBattleNpcID]
          local entityLevelNum = 1
          local totalHp = 0
          local bosshpstage = {}
          local hpConstant = string.split(config.hpConstant, ";")
          for i, hp in ipairs(hpConstant) do
            local value = self._utility.CalculateConfigAttrFunc(hp, {lv = entityLevelNum})
            totalHp = totalHp + value
            bosshpstage[i] = value
          end
          bean.hp = totalHp
          bean.hpmax = totalHp
          bean.atk = self._utility.CalculateConfigAttrFunc(config.attackConstant, {lv = entityLevelNum})
          bean.def = self._utility.CalculateConfigAttrFunc(config.defConstant, {lv = entityLevelNum})
          bean.mdef = self._utility.CalculateConfigAttrFunc(config.magicDefConstant, {lv = entityLevelNum})
          bean.speed = self._utility.CalculateConfigAttrFunc(config.speedConstant, {lv = entityLevelNum})
          bean.damagereduce = self._utility.CalculateConfigAttrFunc(config.damagereduce, {lv = entityLevelNum})
          bean.bosshpstage = bosshpstage
          local shapeRecorder = self._dataUtility.cNPCShapeTable[config.shapeID]
          bean.assetbundlename = shapeRecorder.assetBundleName
          bean.prefabname = shapeRecorder.prefabName
          for _, v in ipairs(config.skillid) do
            table.insert(bean.skilllist, v)
          end
          if Enum_Camp.LeftFighter == camp then
            self._world:CreateLeftPlayer(bean)
          elseif Enum_Camp.RightFighter == camp then
            self._world:CreateRightPlayer(bean)
          end
        end
      end
    end
  end
  local IsHasACampEntitysAllDead = true
  local battleType = BattleEndType.RightWin
  for _, v in ipairs(self._world._leftPlayerList) do
    if not self._utility.IsRoleDead(v) and not self._utility.IsEntityEscape(v) then
      IsHasACampEntitysAllDead = false
      break
    end
  end
  if not IsHasACampEntitysAllDead then
    IsHasACampEntitysAllDead = true
    battleType = BattleEndType.LeftWin
    for _, v in ipairs(self._world._rightPlayerList) do
      if not self._utility.IsRoleDead(v) and not self._utility.IsEntityEscape(v) then
        IsHasACampEntitysAllDead = false
        break
      end
    end
  end
  IsHasACampEntitysAllDead = IsHasACampEntitysAllDead and self._world:IfNoCreatingPlayer()
  if IsHasACampEntitysAllDead and self._world._isAllMonsterStateCanBeBattleEnd and self._world:GetCampWinState() == "" then
    LogInfo("HpSystem", "localprotocol sbattleresult send")
    for _, v in ipairs(self._world._leftPlayerSummonList) do
      v:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
      v:GetComponent(TypeComponent)._isNeedDestroy = true
    end
    for _, v in ipairs(self._world._rightPlayerSummonList) do
      v:GetComponent(PhysicsComponent)._isNeedReleaseBox = true
      v:GetComponent(TypeComponent)._isNeedDestroy = true
    end
    for _, v in ipairs(self._world._entitys) do
      self._buffUtility.ClearBattleEndEntityBuff(v)
      self._utility.ClearAndDestroyTypeMineEffectAtkList(v, self._world)
    end
    if self._world:GetBattleCount() == 0 then
      if battleType == BattleEndType.LeftWin then
        self._world:SetCampWinState("left")
      elseif battleType == BattleEndType.RightWin then
        self._world:SetCampWinState("right")
      else
        self._world:SetCampWinState("wrong")
        LogError("HPSystem", "battleworld campwinstate is not set, state wrong")
      end
    end
    local isjoin = 0
    if 0 < self._world._partnerJoinCount then
      isjoin = 1
    end
    self._protocolUtility.SendBattleResult(battleType, isjoin, self._world)
    BattleECS.Utility.ProtocolUtility.SendPlayBattleVoice(self._world._lastDamageRoleId, BattleECS.Utility.DataUtility.VoiceType.BattleKill, nil, self._world)
    if self._world._battleID == 1122 and self._world:GetWorldState() ~= "end" then
      if battleType == BattleEndType.LeftWin then
        local entity
        for i, e in ipairs(self._world._entitys) do
          if e._entityId == 1 then
            entity = e
            break
          end
        end
        if entity then
          local ifIgnorePriority = {No = 0, Yes = 1}
          self._protocolUtility.SendBattlerPlayAnimationByNameProtocol(entity, "BattleIdle", ifIgnorePriority.No, self._world)
          self._world:SetWorldState("end")
          local isjoin = 0
          if 0 < self._world._partnerJoinCount then
            isjoin = 1
          end
          self._protocolUtility.SendBattleEnd(battleType, isjoin, self._world)
        end
      else
        self._world:SetWorldState("end")
        local isjoin = 0
        if 0 < self._world._partnerJoinCount then
          isjoin = 1
        end
        self._protocolUtility.SendBattleEnd(battleType, isjoin, self._world)
      end
    end
  end
  if self._world:GetCampWinState() ~= "" and self._world:GetWorldState() ~= "end" then
    if self._world._isMonsterAllDeadDisapper then
      LogInfo("HpSystem", "localprotocol sbattleend send")
      if self._world._battleID ~= 1122 then
        self._world:SetWorldState("end")
        local isjoin = 0
        if 0 < self._world._partnerJoinCount then
          isjoin = 1
        end
        self._protocolUtility.SendBattleEnd(battleType, isjoin, self._world)
      end
    end
    self._world:AddBattleCount()
    if battleType == BattleEndType.LeftWin then
      if self._world._isStopBattleWorldTimeCount > self._world._stopBattleWorldTimeCountTotalRight and self._world._battleID ~= 1122 then
        self._world:SetWorldState("end")
        local isjoin = 0
        if 0 < self._world._partnerJoinCount then
          isjoin = 1
        end
        self._protocolUtility.SendBattleEnd(battleType, isjoin, self._world)
      end
    elseif self._world._isStopBattleWorldTimeCount > self._world._stopBattleWorldTimeCountTotalLeft then
      self._world:SetWorldState("end")
      local isjoin = 0
      if 0 < self._world._partnerJoinCount then
        isjoin = 1
      end
      self._protocolUtility.SendBattleEnd(battleType, isjoin, self._world)
    end
  end
end

return HpSystem
