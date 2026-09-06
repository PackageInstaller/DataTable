local PhysicsUtility = {}

function PhysicsUtility.SetEntityPosition(worldID, entity, x, y)
  local bodyID = entity:GetComponent(BattleECS.Components.PhysicsComponent)._box2DBodyID
  box2d.bodySetPositionXY(worldID, bodyID, x, y)
  box2d.bodySetAwake(worldID, bodyID, true)
end

function PhysicsUtility.SetEntityAwake(worldID, entity, isAwake)
  local bodyID = entity:GetComponent(BattleECS.Components.PhysicsComponent)._box2DBodyID
  box2d.bodySetAwake(worldID, bodyID, isAwake)
end

function PhysicsUtility.SetEntityPhyscisComponentAwake(entity, isAwake)
  if isAwake then
    entity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwakeCount = entity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwakeCount + 1
  else
    entity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwakeCount = entity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwakeCount - 1
  end
  if entity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwakeCount >= 0 then
    entity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake = true
  else
    entity:GetComponent(BattleECS.Components.PhysicsComponent)._hittedAwake = false
  end
end

function PhysicsUtility.SetEnityPhysicsComponentCurrentSpeed(entity, xspeed, yspeed)
  if yspeed then
    entity:GetComponent(BattleECS.Components.PhysicsComponent)._toTargetCurrentSpeed.y = yspeed
  end
  if xspeed then
    entity:GetComponent(BattleECS.Components.PhysicsComponent)._toTargetCurrentSpeed.x = xspeed
  end
end

function PhysicsUtility.IsEntityHittedAwake(entity)
  local component = entity:GetComponent(BattleECS.Components.PhysicsComponent)
  if component then
    return component._hittedAwake
  end
  return false
end

return PhysicsUtility
