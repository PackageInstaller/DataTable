local System = require("ecs.system")
local AnimationEventSystem = strictclass("AnimationEventSystem", System)

function AnimationEventSystem:Ctor(...)
  AnimationEventSystem.super.Ctor(self, ...)
  self._physicsUtility = BattleECS.Utility.PhysicsUtility
end

function AnimationEventSystem:Destroy()
  AnimationEventSystem.super.Destroy(self)
end

function AnimationEventSystem:Update()
  local TypeComponent = BattleECS.Components.TypeComponent
  local AnimationEventComponent = BattleECS.Components.AnimationEventComponent
  local PositionComponent = BattleECS.Components.PositionComponent
  for _, entity in ipairs(self._world._leftPlayerList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = component._roleIsInPositionChangeAnimationData[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = posComponent._position.x, posComponent._position.y
        local x = b1x + deltaPos.x
        local y = b1y + deltaPos.y
        posComponent._position.x, posComponent._position.y = x, y
        self._physicsUtility.SetEntityPosition(self._world._physicsWorld, entity, x, y)
      end
      if component._roleIsInPositionChangeAnimationTimeStamp >= table.nums(component._roleIsInPositionChangeAnimationData) then
        component._roleIsInPositionChangeAnimationState = false
        component._roleIsInPositionChangeAnimationTimeStamp = 0
        component._roleIsInPositionChangeAnimationData = {}
        component._roleIsInPositionChangeAnimationName = ""
      end
    end
    if component and component._roleIsInSkill then
      component._roleIsInSkillTimer = component._roleIsInSkillTimer + 1
      if component._roleIsInSkillTimer >= component._roleIsInSkillMaxTime then
        component._roleIsInSkill = false
        component._roleIsInSkillTimer = 0
        component._roleIsInSkillMaxTime = 0
      end
    end
    if component and component._roleIsInSkillWithEndTime then
      component._roleIsInSkillTimerWithEndTime = component._roleIsInSkillTimerWithEndTime + 1
      if component._roleIsInSkillTimerWithEndTime >= component._roleIsInSkillMaxTimeWithEndTime then
        component._roleIsInSkillWithEndTime = false
        component._roleIsInSkillTimerWithEndTime = 0
        component._roleIsInSkillMaxTimeWithEndTime = 0
      end
    end
  end
  for _, entity in ipairs(self._world._leftPlayerPartnerList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = component._roleIsInPositionChangeAnimationData[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = posComponent._position.x, posComponent._position.y
        local x = b1x + deltaPos.x
        local y = b1y + deltaPos.y
        posComponent._position.x, posComponent._position.y = x, y
        self._physicsUtility.SetEntityPosition(self._world._physicsWorld, entity, x, y)
      end
      if component._roleIsInPositionChangeAnimationTimeStamp >= table.nums(component._roleIsInPositionChangeAnimationData) then
        component._roleIsInPositionChangeAnimationState = false
        component._roleIsInPositionChangeAnimationTimeStamp = 0
        component._roleIsInPositionChangeAnimationData = {}
        component._roleIsInPositionChangeAnimationName = ""
      end
    end
    if component and component._roleIsInSkill then
      component._roleIsInSkillTimer = component._roleIsInSkillTimer + 1
      if component._roleIsInSkillTimer >= component._roleIsInSkillMaxTime then
        component._roleIsInSkill = false
        component._roleIsInSkillTimer = 0
        component._roleIsInSkillMaxTime = 0
      end
    end
    if component and component._roleIsInSkillWithEndTime then
      component._roleIsInSkillTimerWithEndTime = component._roleIsInSkillTimerWithEndTime + 1
      if component._roleIsInSkillTimerWithEndTime >= component._roleIsInSkillMaxTimeWithEndTime then
        component._roleIsInSkillWithEndTime = false
        component._roleIsInSkillTimerWithEndTime = 0
        component._roleIsInSkillMaxTimeWithEndTime = 0
      end
    end
  end
  for _, entity in ipairs(self._world._rightPlayerList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = component._roleIsInPositionChangeAnimationData[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = posComponent._position.x, posComponent._position.y
        local x = b1x - deltaPos.x
        local y = b1y + deltaPos.y
        posComponent._position.x, posComponent._position.y = x, y
        self._physicsUtility.SetEntityPosition(self._world._physicsWorld, entity, x, y)
      end
      if component._roleIsInPositionChangeAnimationTimeStamp >= table.nums(component._roleIsInPositionChangeAnimationData) then
        component._roleIsInPositionChangeAnimationState = false
        component._roleIsInPositionChangeAnimationTimeStamp = 0
        component._roleIsInPositionChangeAnimationData = {}
        component._roleIsInPositionChangeAnimationName = ""
      end
    end
    if component and component._roleIsInSkill then
      component._roleIsInSkillTimer = component._roleIsInSkillTimer + 1
      if component._roleIsInSkillTimer >= component._roleIsInSkillMaxTime then
        component._roleIsInSkill = false
        component._roleIsInSkillTimer = 0
        component._roleIsInSkillMaxTime = 0
      end
    end
    if component and component._roleIsInSkillWithEndTime then
      component._roleIsInSkillTimerWithEndTime = component._roleIsInSkillTimerWithEndTime + 1
      if component._roleIsInSkillTimerWithEndTime >= component._roleIsInSkillMaxTimeWithEndTime then
        component._roleIsInSkillWithEndTime = false
        component._roleIsInSkillTimerWithEndTime = 0
        component._roleIsInSkillMaxTimeWithEndTime = 0
      end
    end
  end
  for _, entity in ipairs(self._world._leftPlayerSummonList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = component._roleIsInPositionChangeAnimationData[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = posComponent._position.x, posComponent._position.y
        local x = b1x + deltaPos.x
        local y = b1y + deltaPos.y
        posComponent._position.x, posComponent._position.y = x, y
        self._physicsUtility.SetEntityPosition(self._world._physicsWorld, entity, x, y)
      end
      if component._roleIsInPositionChangeAnimationTimeStamp >= table.nums(component._roleIsInPositionChangeAnimationData) then
        component._roleIsInPositionChangeAnimationState = false
        component._roleIsInPositionChangeAnimationTimeStamp = 0
        component._roleIsInPositionChangeAnimationData = {}
        component._roleIsInPositionChangeAnimationName = ""
      end
    end
    if component and component._roleIsInSkill then
      component._roleIsInSkillTimer = component._roleIsInSkillTimer + 1
      if component._roleIsInSkillTimer >= component._roleIsInSkillMaxTime then
        component._roleIsInSkill = false
        component._roleIsInSkillTimer = 0
        component._roleIsInSkillMaxTime = 0
      end
    end
    if component and component._roleIsInSkillWithEndTime then
      component._roleIsInSkillTimerWithEndTime = component._roleIsInSkillTimerWithEndTime + 1
      if component._roleIsInSkillTimerWithEndTime >= component._roleIsInSkillMaxTimeWithEndTime then
        component._roleIsInSkillWithEndTime = false
        component._roleIsInSkillTimerWithEndTime = 0
        component._roleIsInSkillMaxTimeWithEndTime = 0
      end
    end
  end
  for _, entity in ipairs(self._world._rightPlayerSummonList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = component._roleIsInPositionChangeAnimationData[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = posComponent._position.x, posComponent._position.y
        local x = b1x - deltaPos.x
        local y = b1y + deltaPos.y
        posComponent._position.x, posComponent._position.y = x, y
        self._physicsUtility.SetEntityPosition(self._world._physicsWorld, entity, x, y)
      end
      if component._roleIsInPositionChangeAnimationTimeStamp >= table.nums(component._roleIsInPositionChangeAnimationData) then
        component._roleIsInPositionChangeAnimationState = false
        component._roleIsInPositionChangeAnimationTimeStamp = 0
        component._roleIsInPositionChangeAnimationData = {}
        component._roleIsInPositionChangeAnimationName = ""
      end
    end
    if component and component._roleIsInSkill then
      component._roleIsInSkillTimer = component._roleIsInSkillTimer + 1
      if component._roleIsInSkillTimer >= component._roleIsInSkillMaxTime then
        component._roleIsInSkill = false
        component._roleIsInSkillTimer = 0
        component._roleIsInSkillMaxTime = 0
      end
    end
    if component and component._roleIsInSkillWithEndTime then
      component._roleIsInSkillTimerWithEndTime = component._roleIsInSkillTimerWithEndTime + 1
      if component._roleIsInSkillTimerWithEndTime >= component._roleIsInSkillMaxTimeWithEndTime then
        component._roleIsInSkillWithEndTime = false
        component._roleIsInSkillTimerWithEndTime = 0
        component._roleIsInSkillMaxTimeWithEndTime = 0
      end
    end
  end
  for _, entity in ipairs(self._world._playerSkillEffectEntityList) do
    local component = entity:GetComponent(AnimationEventComponent)
    if component and component._roleIsInPositionChangeAnimationState then
      component._roleIsInPositionChangeAnimationTimeStamp = component._roleIsInPositionChangeAnimationTimeStamp + 1
      local deltaPos = component._roleIsInPositionChangeAnimationData[component._roleIsInPositionChangeAnimationTimeStamp]
      if deltaPos then
        local posComponent = entity:GetComponent(PositionComponent)
        local b1x, b1y = posComponent._position.x, posComponent._position.y
        local tempX = b1x + deltaPos.x
        if entity:GetComponent(TypeComponent)._camp == TypeComponent.CampType.Right then
          tempX = b1x - deltaPos.x
        end
        local x = tempX
        local y = b1y + deltaPos.y
        posComponent._position.x, posComponent._position.y = x, y
        self._physicsUtility.SetEntityPosition(self._world._physicsWorld, entity, x, y)
      end
      if component._roleIsInPositionChangeAnimationTimeStamp >= table.nums(component._roleIsInPositionChangeAnimationData) then
        component._roleIsInPositionChangeAnimationState = false
        component._roleIsInPositionChangeAnimationTimeStamp = 0
        component._roleIsInPositionChangeAnimationData = {}
        component._roleIsInPositionChangeAnimationName = ""
      end
    end
  end
end

return AnimationEventSystem
