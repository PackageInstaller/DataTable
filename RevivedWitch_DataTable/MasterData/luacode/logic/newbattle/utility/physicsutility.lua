-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/utility/physicsutility.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PhysicsUtility = {}
PhysicsUtility.SetEntityPosition = function(worldID, entity, x, y)
  -- function num : 0_0 , upvalues : _ENV
  local bodyID = (entity:GetComponent((BattleECS.Components).PhysicsComponent))._box2DBodyID
  ;
  (box2d.bodySetPositionXY)(worldID, bodyID, x, y)
  ;
  (box2d.bodySetAwake)(worldID, bodyID, true)
end

PhysicsUtility.SetEntityAwake = function(worldID, entity, isAwake)
  -- function num : 0_1 , upvalues : _ENV
  local bodyID = (entity:GetComponent((BattleECS.Components).PhysicsComponent))._box2DBodyID
  ;
  (box2d.bodySetAwake)(worldID, bodyID, isAwake)
end

PhysicsUtility.SetEntityPhyscisComponentAwake = function(entity, isAwake)
  -- function num : 0_2 , upvalues : _ENV
  if isAwake then
    (entity:GetComponent((BattleECS.Components).PhysicsComponent))._hittedAwakeCount = (entity:GetComponent((BattleECS.Components).PhysicsComponent))._hittedAwakeCount + 1
  else
    ;
    (entity:GetComponent((BattleECS.Components).PhysicsComponent))._hittedAwakeCount = (entity:GetComponent((BattleECS.Components).PhysicsComponent))._hittedAwakeCount - 1
  end
  if (entity:GetComponent((BattleECS.Components).PhysicsComponent))._hittedAwakeCount >= 0 then
    (entity:GetComponent((BattleECS.Components).PhysicsComponent))._hittedAwake = true
  else
    ;
    (entity:GetComponent((BattleECS.Components).PhysicsComponent))._hittedAwake = false
  end
end

PhysicsUtility.SetEnityPhysicsComponentCurrentSpeed = function(entity, xspeed, yspeed)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  if yspeed then
    ((entity:GetComponent((BattleECS.Components).PhysicsComponent))._toTargetCurrentSpeed).y = yspeed
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  if xspeed then
    ((entity:GetComponent((BattleECS.Components).PhysicsComponent))._toTargetCurrentSpeed).x = xspeed
  end
end

PhysicsUtility.IsEntityHittedAwake = function(entity)
  -- function num : 0_4 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).PhysicsComponent)
  if component then
    return component._hittedAwake
  end
  return false
end

return PhysicsUtility

