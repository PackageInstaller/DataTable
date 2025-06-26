-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/viewmovesystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local ViewMoveSystem = strictclass("ViewMoveSystem", System)
ViewMoveSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ViewMoveSystem, _ENV
  ((ViewMoveSystem.super).Ctor)(self, ...)
  self._utility = (BattleECS.Utility).Utility
  self._buffUtility = (BattleECS.Utility).BuffUtility
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).PhysicsComponent)
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).PositionComponent)
end

ViewMoveSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : ViewMoveSystem
  ((ViewMoveSystem.super).Destroy)(self)
end

ViewMoveSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local PhysicsComponent = (BattleECS.Components).PhysicsComponent
  local PositionComponent = (BattleECS.Components).PositionComponent
  local AnimationEventComponent = (BattleECS.Components).AnimationEventComponent
  local HpComponent = (BattleECS.Components).HpComponent
  local AttackComponent = (BattleECS.Components).AttackComponent
  local DefenseComponent = (BattleECS.Components).DefenseComponent
  for _,entity in ipairs(self._entitys) do
    local physics = entity:GetComponent(PhysicsComponent)
    if physics and not physics._isNeedReleaseBox then
      local position = entity:GetComponent(PositionComponent)
      if position then
        local protocol = (BattleClientProtocolManager.CreateProtocol)("action.srolepositionchange")
        protocol.entityId = entity._entityId
        protocol.posX = (fixedpoint.tonumber)((position._position).x)
        protocol.posY = (fixedpoint.tonumber)((position._position).y)
        ;
        (self._world):InsertViewProtocolData(protocol)
      end
    end
    do
      local belongBattleWorldLeftPlayerList = false
      for _,e in ipairs((self._world)._leftPlayerList) do
        if e._entityId == entity._entityId then
          belongBattleWorldLeftPlayerList = true
          break
        end
      end
      do
        if belongBattleWorldLeftPlayerList and (self._world):GetCampWinState() == "" and not ((self._utility).IsRoleDead)(entity) then
          local scanType = {canUse = 0, haveCanNotUseSkillBuff = 1, wrongPos = 2, roleIsInSkill = 3, canNotUseYingXiSkill = 4}
          local iscan = scanType.canUse
          local effectType = {AttackSkill = 1, UseSkill = 2, Both = 3}
          if ((self._buffUtility).IsRoleHasCanNotUseSkillBuff)(entity, effectType.UseSkill) then
            iscan = scanType.haveCanNotUseSkillBuff
          else
            if ((self._utility).IsToTargetXPoint)(entity) then
              if (entity:GetComponent(AnimationEventComponent))._roleIsInSkill then
                iscan = scanType.roleIsInSkill
              else
                if (entity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
                  iscan = scanType.canNotUseYingXiSkill
                end
              end
            else
              iscan = scanType.wrongPos
            end
          end
          local protocol = (BattleClientProtocolManager.CreateProtocol)("action.sroleiscanuseskill")
          protocol.entityid = entity._entityId
          protocol.iscan = iscan
          ;
          (self._world):InsertViewProtocolData(protocol)
          protocol = (BattleClientProtocolManager.CreateProtocol)("action.supdateroleattribute")
          protocol.entityid = entity._entityId
          local component = entity:GetComponent(HpComponent)
          -- DECOMPILER ERROR at PC155: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).hp = (fixedpoint.tonumber)(component._currentHp)
          -- DECOMPILER ERROR at PC161: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).hpmax = (fixedpoint.tonumber)(component._maxHp)
          component = entity:GetComponent(AttackComponent)
          -- DECOMPILER ERROR at PC171: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).atk = (fixedpoint.tonumber)(component._attack)
          -- DECOMPILER ERROR at PC178: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).physicalbonus = (fixedpoint.tonumber)(component._attackDamageAddition) * 1000
          -- DECOMPILER ERROR at PC185: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).magicbonus = (fixedpoint.tonumber)(component._magicDamageAddition) * 1000
          -- DECOMPILER ERROR at PC192: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).physicalcritrate = (fixedpoint.tonumber)(component._attackCritRate) * 1000
          -- DECOMPILER ERROR at PC199: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).physicalcritdegree = (fixedpoint.tonumber)(component._attackCritDegree) * 1000
          -- DECOMPILER ERROR at PC206: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).attackspeed = (fixedpoint.tonumber)(component._attackSpeed) * 1000
          -- DECOMPILER ERROR at PC213: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).magiclifesteal = (fixedpoint.tonumber)(component._magicSuckBlood) * 100
          -- DECOMPILER ERROR at PC220: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).physicallifesteal = (fixedpoint.tonumber)(component._attackSuckBlood) * 100
          -- DECOMPILER ERROR at PC226: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).physicaldefbreak = (fixedpoint.tonumber)(component._attackDefBreak)
          -- DECOMPILER ERROR at PC232: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).magicdefbreak = (fixedpoint.tonumber)(component._magicDefBreak)
          component = entity:GetComponent(DefenseComponent)
          -- DECOMPILER ERROR at PC242: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).def = (fixedpoint.tonumber)(component._attackDefense)
          -- DECOMPILER ERROR at PC248: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).mdef = (fixedpoint.tonumber)(component._magicDefense)
          -- DECOMPILER ERROR at PC255: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).physicalreduce = (fixedpoint.tonumber)(component._attackDefenseAddition) * 1000
          -- DECOMPILER ERROR at PC262: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).magicreduce = (fixedpoint.tonumber)(component._magicDefenseAddition) * 1000
          -- DECOMPILER ERROR at PC269: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).physicalevasion = (fixedpoint.tonumber)(component._attackMiss) * 1000
          -- DECOMPILER ERROR at PC275: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).physicalblock = (fixedpoint.tonumber)(component._attackInjuryReduceNumber)
          -- DECOMPILER ERROR at PC281: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).magicblock = (fixedpoint.tonumber)(component._magicInjuryReduceNumber)
          -- DECOMPILER ERROR at PC288: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).critrateresistance = (fixedpoint.tonumber)(component._attackCritDefense) * 1000
          -- DECOMPILER ERROR at PC295: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).critdegreeresistance = (fixedpoint.tonumber)(component._attackCritDegreeDefense) * 1000
          -- DECOMPILER ERROR at PC302: Confused about usage of register: R19 in 'UnsetPending'

          ;
          (protocol.attribute).damagereduce = (fixedpoint.tonumber)(component._damageReduce) * 1000
          ;
          (self._world):InsertViewProtocolData(protocol)
        end
        do
          local belongBattleWorldRightPlayerAndSummonList = false
          for _,e in ipairs((self._world)._rightPlayerList) do
            if e._entityId == entity._entityId then
              belongBattleWorldRightPlayerAndSummonList = true
              break
            end
          end
          do
            for _,e in ipairs((self._world)._rightPlayerSummonList) do
              if e._entityId == entity._entityId then
                belongBattleWorldRightPlayerAndSummonList = true
                break
              end
            end
            do
              if belongBattleWorldRightPlayerAndSummonList and (self._world):GetCampWinState() == "" and not ((self._utility).IsRoleDead)(entity) then
                protocol = (BattleClientProtocolManager.CreateProtocol)("action.supdateroleattribute")
                -- DECOMPILER ERROR at PC354: Confused about usage of register: R15 in 'UnsetPending'

                protocol.entityid = entity._entityId
                local component = entity:GetComponent(HpComponent)
                -- DECOMPILER ERROR at PC364: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).hp = (fixedpoint.tonumber)(component._currentHp)
                -- DECOMPILER ERROR at PC371: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).hpmax = (fixedpoint.tonumber)(component._maxHp)
                component = entity:GetComponent(AttackComponent)
                -- DECOMPILER ERROR at PC382: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).atk = (fixedpoint.tonumber)(component._attack)
                -- DECOMPILER ERROR at PC390: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).physicalbonus = (fixedpoint.tonumber)(component._attackDamageAddition) * 1000
                -- DECOMPILER ERROR at PC398: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).magicbonus = (fixedpoint.tonumber)(component._magicDamageAddition) * 1000
                -- DECOMPILER ERROR at PC406: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).physicalcritrate = (fixedpoint.tonumber)(component._attackCritRate) * 1000
                -- DECOMPILER ERROR at PC414: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).physicalcritdegree = (fixedpoint.tonumber)(component._attackCritDegree) * 1000
                -- DECOMPILER ERROR at PC422: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).attackspeed = (fixedpoint.tonumber)(component._attackSpeed) * 1000
                -- DECOMPILER ERROR at PC430: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).magiclifesteal = (fixedpoint.tonumber)(component._magicSuckBlood) * 100
                -- DECOMPILER ERROR at PC438: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).physicallifesteal = (fixedpoint.tonumber)(component._attackSuckBlood) * 100
                -- DECOMPILER ERROR at PC445: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).physicaldefbreak = (fixedpoint.tonumber)(component._attackDefBreak)
                -- DECOMPILER ERROR at PC452: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).magicdefbreak = (fixedpoint.tonumber)(component._magicDefBreak)
                component = entity:GetComponent(DefenseComponent)
                -- DECOMPILER ERROR at PC463: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).def = (fixedpoint.tonumber)(component._attackDefense)
                -- DECOMPILER ERROR at PC470: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).mdef = (fixedpoint.tonumber)(component._magicDefense)
                -- DECOMPILER ERROR at PC478: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).physicalreduce = (fixedpoint.tonumber)(component._attackDefenseAddition) * 1000
                -- DECOMPILER ERROR at PC486: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).magicreduce = (fixedpoint.tonumber)(component._magicDefenseAddition) * 1000
                -- DECOMPILER ERROR at PC494: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).physicalevasion = (fixedpoint.tonumber)(component._attackMiss) * 1000
                -- DECOMPILER ERROR at PC501: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).physicalblock = (fixedpoint.tonumber)(component._attackInjuryReduceNumber)
                -- DECOMPILER ERROR at PC508: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).magicblock = (fixedpoint.tonumber)(component._magicInjuryReduceNumber)
                -- DECOMPILER ERROR at PC516: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).critrateresistance = (fixedpoint.tonumber)(component._attackCritDefense) * 1000
                -- DECOMPILER ERROR at PC524: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).critdegreeresistance = (fixedpoint.tonumber)(component._attackCritDegreeDefense) * 1000
                -- DECOMPILER ERROR at PC532: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (protocol.attribute).damagereduce = (fixedpoint.tonumber)(component._damageReduce) * 1000
                ;
                (self._world):InsertViewProtocolData(protocol)
              end
              do
                -- DECOMPILER ERROR at PC537: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC537: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC537: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC537: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC537: LeaveBlock: unexpected jumping out DO_STMT

              end
            end
          end
        end
      end
    end
  end
end

return ViewMoveSystem

