local System = require("ecs.system")
local ViewMoveSystem = strictclass("ViewMoveSystem", System)

function ViewMoveSystem:Ctor(...)
  ViewMoveSystem.super.Ctor(self, ...)
  self._utility = BattleECS.Utility.Utility
  self._buffUtility = BattleECS.Utility.BuffUtility
  table.insert(self._requiredComponents, BattleECS.Components.PhysicsComponent)
  table.insert(self._requiredComponents, BattleECS.Components.PositionComponent)
end

function ViewMoveSystem:Destroy()
  ViewMoveSystem.super.Destroy(self)
end

function ViewMoveSystem:Update()
  local PhysicsComponent = BattleECS.Components.PhysicsComponent
  local PositionComponent = BattleECS.Components.PositionComponent
  local AnimationEventComponent = BattleECS.Components.AnimationEventComponent
  local HpComponent = BattleECS.Components.HpComponent
  local AttackComponent = BattleECS.Components.AttackComponent
  local DefenseComponent = BattleECS.Components.DefenseComponent
  for _, entity in ipairs(self._entitys) do
    local physics = entity:GetComponent(PhysicsComponent)
    if physics and not physics._isNeedReleaseBox then
      local position = entity:GetComponent(PositionComponent)
      if position then
        local protocol = BattleClientProtocolManager.CreateProtocol("action.srolepositionchange")
        protocol.entityId = entity._entityId
        protocol.posX = fixedpoint.tonumber(position._position.x)
        protocol.posY = fixedpoint.tonumber(position._position.y)
        self._world:InsertViewProtocolData(protocol)
      end
    end
    local belongBattleWorldLeftPlayerList = false
    for _, e in ipairs(self._world._leftPlayerList) do
      if e._entityId == entity._entityId then
        belongBattleWorldLeftPlayerList = true
        break
      end
    end
    if belongBattleWorldLeftPlayerList and self._world:GetCampWinState() == "" and not self._utility.IsRoleDead(entity) then
      local scanType = {
        canUse = 0,
        haveCanNotUseSkillBuff = 1,
        wrongPos = 2,
        roleIsInSkill = 3,
        canNotUseYingXiSkill = 4
      }
      local iscan = scanType.canUse
      local effectType = {
        AttackSkill = 1,
        UseSkill = 2,
        Both = 3
      }
      if self._buffUtility.IsRoleHasCanNotUseSkillBuff(entity, effectType.UseSkill) then
        iscan = scanType.haveCanNotUseSkillBuff
      elseif self._utility.IsToTargetXPoint(entity) then
        if entity:GetComponent(AnimationEventComponent)._roleIsInSkill then
          iscan = scanType.roleIsInSkill
        elseif entity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
          iscan = scanType.canNotUseYingXiSkill
        end
      else
        iscan = scanType.wrongPos
      end
      local protocol = BattleClientProtocolManager.CreateProtocol("action.sroleiscanuseskill")
      protocol.entityid = entity._entityId
      protocol.iscan = iscan
      self._world:InsertViewProtocolData(protocol)
      protocol = BattleClientProtocolManager.CreateProtocol("action.supdateroleattribute")
      protocol.entityid = entity._entityId
      local component = entity:GetComponent(HpComponent)
      protocol.attribute.hp = fixedpoint.tonumber(component._currentHp)
      protocol.attribute.hpmax = fixedpoint.tonumber(component._maxHp)
      component = entity:GetComponent(AttackComponent)
      protocol.attribute.atk = fixedpoint.tonumber(component._attack)
      protocol.attribute.physicalbonus = fixedpoint.tonumber(component._attackDamageAddition) * 1000
      protocol.attribute.magicbonus = fixedpoint.tonumber(component._magicDamageAddition) * 1000
      protocol.attribute.physicalcritrate = fixedpoint.tonumber(component._attackCritRate) * 1000
      protocol.attribute.physicalcritdegree = fixedpoint.tonumber(component._attackCritDegree) * 1000
      protocol.attribute.attackspeed = fixedpoint.tonumber(component._attackSpeed) * 1000
      protocol.attribute.magiclifesteal = fixedpoint.tonumber(component._magicSuckBlood) * 100
      protocol.attribute.physicallifesteal = fixedpoint.tonumber(component._attackSuckBlood) * 100
      protocol.attribute.physicaldefbreak = fixedpoint.tonumber(component._attackDefBreak)
      protocol.attribute.magicdefbreak = fixedpoint.tonumber(component._magicDefBreak)
      component = entity:GetComponent(DefenseComponent)
      protocol.attribute.def = fixedpoint.tonumber(component._attackDefense)
      protocol.attribute.mdef = fixedpoint.tonumber(component._magicDefense)
      protocol.attribute.physicalreduce = fixedpoint.tonumber(component._attackDefenseAddition) * 1000
      protocol.attribute.magicreduce = fixedpoint.tonumber(component._magicDefenseAddition) * 1000
      protocol.attribute.physicalevasion = fixedpoint.tonumber(component._attackMiss) * 1000
      protocol.attribute.physicalblock = fixedpoint.tonumber(component._attackInjuryReduceNumber)
      protocol.attribute.magicblock = fixedpoint.tonumber(component._magicInjuryReduceNumber)
      protocol.attribute.critrateresistance = fixedpoint.tonumber(component._attackCritDefense) * 1000
      protocol.attribute.critdegreeresistance = fixedpoint.tonumber(component._attackCritDegreeDefense) * 1000
      protocol.attribute.damagereduce = fixedpoint.tonumber(component._damageReduce) * 1000
      self._world:InsertViewProtocolData(protocol)
    end
    local belongBattleWorldRightPlayerAndSummonList = false
    for _, e in ipairs(self._world._rightPlayerList) do
      if e._entityId == entity._entityId then
        belongBattleWorldRightPlayerAndSummonList = true
        break
      end
    end
    for _, e in ipairs(self._world._rightPlayerSummonList) do
      if e._entityId == entity._entityId then
        belongBattleWorldRightPlayerAndSummonList = true
        break
      end
    end
    if belongBattleWorldRightPlayerAndSummonList and self._world:GetCampWinState() == "" and not self._utility.IsRoleDead(entity) then
      protocol = BattleClientProtocolManager.CreateProtocol("action.supdateroleattribute")
      protocol.entityid = entity._entityId
      local component = entity:GetComponent(HpComponent)
      protocol.attribute.hp = fixedpoint.tonumber(component._currentHp)
      protocol.attribute.hpmax = fixedpoint.tonumber(component._maxHp)
      component = entity:GetComponent(AttackComponent)
      protocol.attribute.atk = fixedpoint.tonumber(component._attack)
      protocol.attribute.physicalbonus = fixedpoint.tonumber(component._attackDamageAddition) * 1000
      protocol.attribute.magicbonus = fixedpoint.tonumber(component._magicDamageAddition) * 1000
      protocol.attribute.physicalcritrate = fixedpoint.tonumber(component._attackCritRate) * 1000
      protocol.attribute.physicalcritdegree = fixedpoint.tonumber(component._attackCritDegree) * 1000
      protocol.attribute.attackspeed = fixedpoint.tonumber(component._attackSpeed) * 1000
      protocol.attribute.magiclifesteal = fixedpoint.tonumber(component._magicSuckBlood) * 100
      protocol.attribute.physicallifesteal = fixedpoint.tonumber(component._attackSuckBlood) * 100
      protocol.attribute.physicaldefbreak = fixedpoint.tonumber(component._attackDefBreak)
      protocol.attribute.magicdefbreak = fixedpoint.tonumber(component._magicDefBreak)
      component = entity:GetComponent(DefenseComponent)
      protocol.attribute.def = fixedpoint.tonumber(component._attackDefense)
      protocol.attribute.mdef = fixedpoint.tonumber(component._magicDefense)
      protocol.attribute.physicalreduce = fixedpoint.tonumber(component._attackDefenseAddition) * 1000
      protocol.attribute.magicreduce = fixedpoint.tonumber(component._magicDefenseAddition) * 1000
      protocol.attribute.physicalevasion = fixedpoint.tonumber(component._attackMiss) * 1000
      protocol.attribute.physicalblock = fixedpoint.tonumber(component._attackInjuryReduceNumber)
      protocol.attribute.magicblock = fixedpoint.tonumber(component._magicInjuryReduceNumber)
      protocol.attribute.critrateresistance = fixedpoint.tonumber(component._attackCritDefense) * 1000
      protocol.attribute.critdegreeresistance = fixedpoint.tonumber(component._attackCritDegreeDefense) * 1000
      protocol.attribute.damagereduce = fixedpoint.tonumber(component._damageReduce) * 1000
      self._world:InsertViewProtocolData(protocol)
    end
  end
end

return ViewMoveSystem
