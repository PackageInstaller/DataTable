-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/roledeadcountsystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local RoleDeadCountSystem = strictclass("RoleDeadCountSystem", System)
RoleDeadCountSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleDeadCountSystem, _ENV
  ((RoleDeadCountSystem.super).Ctor)(self, ...)
  self._utility = (BattleECS.Utility).Utility
  self._protocolUtility = (BattleECS.Utility).ProtocolUtility
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).RoleDeadCountComponent)
  ;
  (table.insert)(self._requiredComponents, (BattleECS.Components).TypeComponent)
end

RoleDeadCountSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : RoleDeadCountSystem
  ((RoleDeadCountSystem.super).Destroy)(self)
end

RoleDeadCountSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local RoleDeadCountComponent = (BattleECS.Components).RoleDeadCountComponent
  local PhysicsComponent = (BattleECS.Components).PhysicsComponent
  local TypeComponent = (BattleECS.Components).TypeComponent
  local PositionComponent = (BattleECS.Components).PositionComponent
  for _,entity in ipairs(self._entitys) do
    local component = entity:GetComponent(RoleDeadCountComponent)
    if not component._roleDeadDisappear then
      if (self._world):GetCampWinState() ~= "" then
        component._currentCount = component._maxCount
      end
      component._currentCount = component._currentCount + 1
      if component._maxCount <= component._currentCount then
        if (entity:GetComponent(TypeComponent))._summonName == "partner" then
          local SpriteShowType = {None = -1, Show = 1, Hide = 0, OnlyHideHitPoint = 2}
          ;
          ((self._protocolUtility).SendChangeEntityHpCellVisible)(entity._entityId, 0, SpriteShowType.Hide, self._world)
          local pos = entity:GetComponent(PositionComponent)
          local shapeRecorder = ((self._utility).GetEntityShapeRecorder)(entity)
          local delt = ((self._utility).GetSkillEffectSocketPoint)(shapeRecorder.prefabName, "HitPoint_Bottom")
          local x, y = (pos._position).x - delt.x, (pos._position).y + delt.y
          ;
          ((self._protocolUtility).SCreateSceneEffect)(3, x, y, 0, 1, self._world)
        else
          do
            do
              ;
              (entity:GetComponent(TypeComponent))._isNeedDestroy = true
              if entity:GetComponent(PhysicsComponent) then
                (entity:GetComponent(PhysicsComponent))._isNeedReleaseBox = true
              end
              component._currentCount = 0
              component._roleDeadDisappear = true
              -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

return RoleDeadCountSystem

