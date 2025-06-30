-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/deaddisappearcountsystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local DeadDisappearCountSystem = strictclass("DeadDisappearCountSystem", System)
DeadDisappearCountSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DeadDisappearCountSystem, _ENV
  ((DeadDisappearCountSystem.super).Ctor)(self, ...)
  self._utility = (BattleECS.Utility).Utility
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).DeadDisappearCountComponent)
end

DeadDisappearCountSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : DeadDisappearCountSystem
  ((DeadDisappearCountSystem.super).Destroy)(self)
end

DeadDisappearCountSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local DeadDisappearCountComponent = (BattleECS.Components).DeadDisappearCountComponent
  local TypeComponent = (BattleECS.Components).TypeComponent
  local PhysicsComponent = (BattleECS.Components).PhysicsComponent
  ;
  (self._world):SetIsMonsterAllDeadDisapper(true)
  ;
  (self._world):SetIsAllMonsterStateCanBeBattleEnd(true)
  for _,entity in ipairs((self._world)._rightPlayerList) do
    if ((self._utility).IsRoleDead)(entity) then
      local component = entity:GetComponent(DeadDisappearCountComponent)
      if not component._isDeadDisappear then
        component._deadCurrentCount = component._deadCurrentCount + 1
        if component._deadTotalCount <= component._deadCurrentCount then
          component._isDeadDisappear = true
          component._deadCurrentCount = 0
        else
          ;
          (self._world):SetIsMonsterAllDeadDisapper(false)
        end
      end
      if not component._isBattleEnd then
        component._battleEndCurrentCount = component._battleEndCurrentCount + 1
        if component._battleEndTotalCount <= component._battleEndCurrentCount then
          component._isBattleEnd = true
          component._battleEndCurrentCount = 0
        else
          ;
          (self._world):SetIsAllMonsterStateCanBeBattleEnd(false)
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._leftPlayerSummonList) do
    if ((self._utility).IsRoleDead)(entity) then
      local component = entity:GetComponent(DeadDisappearCountComponent)
      if not component._isDeadDisappear then
        component._deadCurrentCount = component._deadCurrentCount + 1
        if component._deadTotalCount <= component._deadCurrentCount then
          component._isDeadDisappear = true
          component._deadCurrentCount = 0
          ;
          (entity:GetComponent(TypeComponent))._isNeedDestroy = true
          ;
          (entity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
        end
      end
    end
  end
  for _,entity in ipairs((self._world)._rightPlayerSummonList) do
    if ((self._utility).IsRoleDead)(entity) then
      local component = entity:GetComponent(DeadDisappearCountComponent)
      if not component._isDeadDisappear then
        component._deadCurrentCount = component._deadCurrentCount + 1
        if component._deadTotalCount <= component._deadCurrentCount then
          component._isDeadDisappear = true
          component._deadCurrentCount = 0
          ;
          (entity:GetComponent(TypeComponent))._isNeedDestroy = true
          ;
          (entity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
        end
      end
    end
  end
end

return DeadDisappearCountSystem

