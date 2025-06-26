-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/animationeventsystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local AnimationEventSystem = strictclass("AnimationEventSystem", System)
AnimationEventSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AnimationEventSystem, _ENV
  ((AnimationEventSystem.super).Ctor)(self, ...)
  self._physicsUtility = (BattleECS.Utility).PhysicsUtility
end

AnimationEventSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : AnimationEventSystem
  ((AnimationEventSystem.super).Destroy)(self)
end

AnimationEventSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local TypeComponent = (BattleECS.Components).TypeComponent
  local AnimationEventComponent = (BattleECS.Components).AnimationEventComponent
  local PositionComponent = (BattleECS.Components).PositionComponent
  for _,entity in ipairs((self._world)._leftPlayerList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = (component._roleIsInPositionChangeAnimationData)[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = (posComponent._position).x, (posComponent._position).y
        local x = b1x + deltaPos.x
        local y = b1y + deltaPos.y
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R17 in 'UnsetPending'

        -- DECOMPILER ERROR at PC45: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (posComponent._position).x = x
        ;
        ((self._physicsUtility).SetEntityPosition)((self._world)._physicsWorld, entity, x, y)
      end
      do
        do
          do
            if (table.nums)(component._roleIsInPositionChangeAnimationData) <= component._roleIsInPositionChangeAnimationTimeStamp then
              component._roleIsInPositionChangeAnimationState = false
              component._roleIsInPositionChangeAnimationTimeStamp = 0
              component._roleIsInPositionChangeAnimationData = {}
              component._roleIsInPositionChangeAnimationName = ""
            end
            if component and component._roleIsInSkill then
              component._roleIsInSkillTimer = component._roleIsInSkillTimer + 1
              if component._roleIsInSkillMaxTime <= component._roleIsInSkillTimer then
                component._roleIsInSkill = false
                component._roleIsInSkillTimer = 0
                component._roleIsInSkillMaxTime = 0
              end
            end
            if component and component._roleIsInSkillWithEndTime then
              component._roleIsInSkillTimerWithEndTime = component._roleIsInSkillTimerWithEndTime + 1
              if component._roleIsInSkillMaxTimeWithEndTime <= component._roleIsInSkillTimerWithEndTime then
                component._roleIsInSkillWithEndTime = false
                component._roleIsInSkillTimerWithEndTime = 0
                component._roleIsInSkillMaxTimeWithEndTime = 0
              end
            end
            -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._leftPlayerPartnerList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = (component._roleIsInPositionChangeAnimationData)[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = (posComponent._position).x, (posComponent._position).y
        local x = b1x + deltaPos.x
        local y = b1y + deltaPos.y
        -- DECOMPILER ERROR at PC133: Confused about usage of register: R17 in 'UnsetPending'

        -- DECOMPILER ERROR at PC134: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (posComponent._position).x = x
        ;
        ((self._physicsUtility).SetEntityPosition)((self._world)._physicsWorld, entity, x, y)
      end
      do
        do
          do
            if (table.nums)(component._roleIsInPositionChangeAnimationData) <= component._roleIsInPositionChangeAnimationTimeStamp then
              component._roleIsInPositionChangeAnimationState = false
              component._roleIsInPositionChangeAnimationTimeStamp = 0
              component._roleIsInPositionChangeAnimationData = {}
              component._roleIsInPositionChangeAnimationName = ""
            end
            if component and component._roleIsInSkill then
              component._roleIsInSkillTimer = component._roleIsInSkillTimer + 1
              if component._roleIsInSkillMaxTime <= component._roleIsInSkillTimer then
                component._roleIsInSkill = false
                component._roleIsInSkillTimer = 0
                component._roleIsInSkillMaxTime = 0
              end
            end
            if component and component._roleIsInSkillWithEndTime then
              component._roleIsInSkillTimerWithEndTime = component._roleIsInSkillTimerWithEndTime + 1
              if component._roleIsInSkillMaxTimeWithEndTime <= component._roleIsInSkillTimerWithEndTime then
                component._roleIsInSkillWithEndTime = false
                component._roleIsInSkillTimerWithEndTime = 0
                component._roleIsInSkillMaxTimeWithEndTime = 0
              end
            end
            -- DECOMPILER ERROR at PC185: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC185: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC185: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC185: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._rightPlayerList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = (component._roleIsInPositionChangeAnimationData)[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = (posComponent._position).x, (posComponent._position).y
        local x = b1x - deltaPos.x
        local y = b1y + deltaPos.y
        -- DECOMPILER ERROR at PC222: Confused about usage of register: R17 in 'UnsetPending'

        -- DECOMPILER ERROR at PC223: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (posComponent._position).x = x
        ;
        ((self._physicsUtility).SetEntityPosition)((self._world)._physicsWorld, entity, x, y)
      end
      do
        do
          do
            if (table.nums)(component._roleIsInPositionChangeAnimationData) <= component._roleIsInPositionChangeAnimationTimeStamp then
              component._roleIsInPositionChangeAnimationState = false
              component._roleIsInPositionChangeAnimationTimeStamp = 0
              component._roleIsInPositionChangeAnimationData = {}
              component._roleIsInPositionChangeAnimationName = ""
            end
            if component and component._roleIsInSkill then
              component._roleIsInSkillTimer = component._roleIsInSkillTimer + 1
              if component._roleIsInSkillMaxTime <= component._roleIsInSkillTimer then
                component._roleIsInSkill = false
                component._roleIsInSkillTimer = 0
                component._roleIsInSkillMaxTime = 0
              end
            end
            if component and component._roleIsInSkillWithEndTime then
              component._roleIsInSkillTimerWithEndTime = component._roleIsInSkillTimerWithEndTime + 1
              if component._roleIsInSkillMaxTimeWithEndTime <= component._roleIsInSkillTimerWithEndTime then
                component._roleIsInSkillWithEndTime = false
                component._roleIsInSkillTimerWithEndTime = 0
                component._roleIsInSkillMaxTimeWithEndTime = 0
              end
            end
            -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC274: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._leftPlayerSummonList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = (component._roleIsInPositionChangeAnimationData)[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = (posComponent._position).x, (posComponent._position).y
        local x = b1x + deltaPos.x
        local y = b1y + deltaPos.y
        -- DECOMPILER ERROR at PC311: Confused about usage of register: R17 in 'UnsetPending'

        -- DECOMPILER ERROR at PC312: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (posComponent._position).x = x
        ;
        ((self._physicsUtility).SetEntityPosition)((self._world)._physicsWorld, entity, x, y)
      end
      do
        do
          do
            if (table.nums)(component._roleIsInPositionChangeAnimationData) <= component._roleIsInPositionChangeAnimationTimeStamp then
              component._roleIsInPositionChangeAnimationState = false
              component._roleIsInPositionChangeAnimationTimeStamp = 0
              component._roleIsInPositionChangeAnimationData = {}
              component._roleIsInPositionChangeAnimationName = ""
            end
            if component and component._roleIsInSkill then
              component._roleIsInSkillTimer = component._roleIsInSkillTimer + 1
              if component._roleIsInSkillMaxTime <= component._roleIsInSkillTimer then
                component._roleIsInSkill = false
                component._roleIsInSkillTimer = 0
                component._roleIsInSkillMaxTime = 0
              end
            end
            if component and component._roleIsInSkillWithEndTime then
              component._roleIsInSkillTimerWithEndTime = component._roleIsInSkillTimerWithEndTime + 1
              if component._roleIsInSkillMaxTimeWithEndTime <= component._roleIsInSkillTimerWithEndTime then
                component._roleIsInSkillWithEndTime = false
                component._roleIsInSkillTimerWithEndTime = 0
                component._roleIsInSkillMaxTimeWithEndTime = 0
              end
            end
            -- DECOMPILER ERROR at PC363: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC363: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC363: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC363: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._rightPlayerSummonList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = (component._roleIsInPositionChangeAnimationData)[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = (posComponent._position).x, (posComponent._position).y
        local x = b1x - deltaPos.x
        local y = b1y + deltaPos.y
        -- DECOMPILER ERROR at PC400: Confused about usage of register: R17 in 'UnsetPending'

        -- DECOMPILER ERROR at PC401: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (posComponent._position).x = x
        ;
        ((self._physicsUtility).SetEntityPosition)((self._world)._physicsWorld, entity, x, y)
      end
      do
        do
          do
            if (table.nums)(component._roleIsInPositionChangeAnimationData) <= component._roleIsInPositionChangeAnimationTimeStamp then
              component._roleIsInPositionChangeAnimationState = false
              component._roleIsInPositionChangeAnimationTimeStamp = 0
              component._roleIsInPositionChangeAnimationData = {}
              component._roleIsInPositionChangeAnimationName = ""
            end
            if component and component._roleIsInSkill then
              component._roleIsInSkillTimer = component._roleIsInSkillTimer + 1
              if component._roleIsInSkillMaxTime <= component._roleIsInSkillTimer then
                component._roleIsInSkill = false
                component._roleIsInSkillTimer = 0
                component._roleIsInSkillMaxTime = 0
              end
            end
            if component and component._roleIsInSkillWithEndTime then
              component._roleIsInSkillTimerWithEndTime = component._roleIsInSkillTimerWithEndTime + 1
              if component._roleIsInSkillMaxTimeWithEndTime <= component._roleIsInSkillTimerWithEndTime then
                component._roleIsInSkillWithEndTime = false
                component._roleIsInSkillTimerWithEndTime = 0
                component._roleIsInSkillMaxTimeWithEndTime = 0
              end
            end
            -- DECOMPILER ERROR at PC452: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC452: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC452: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC452: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._playerSkillEffectEntityList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = (component._roleIsInPositionChangeAnimationData)[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = (posComponent._position).x, (posComponent._position).y
        local tempX = b1x + deltaPos.x
        if (entity:GetComponent(TypeComponent))._camp == (TypeComponent.CampType).Right then
          tempX = b1x - deltaPos.x
        end
        local x = tempX
        local y = b1y + deltaPos.y
        -- DECOMPILER ERROR at PC500: Confused about usage of register: R18 in 'UnsetPending'

        -- DECOMPILER ERROR at PC501: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (posComponent._position).x = x
        ;
        ((self._physicsUtility).SetEntityPosition)((self._world)._physicsWorld, entity, x, y)
      end
      do
        do
          if (table.nums)(component._roleIsInPositionChangeAnimationData) <= component._roleIsInPositionChangeAnimationTimeStamp then
            component._roleIsInPositionChangeAnimationState = false
            component._roleIsInPositionChangeAnimationTimeStamp = 0
            component._roleIsInPositionChangeAnimationData = {}
            component._roleIsInPositionChangeAnimationName = ""
          end
          -- DECOMPILER ERROR at PC522: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC522: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC522: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

return AnimationEventSystem

