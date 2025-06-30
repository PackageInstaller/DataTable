-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/system/skillsystem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = require("ecs.system")
local SkillSystem = strictclass("SkillSystem", System)
SkillSystem.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillSystem, _ENV
  ((SkillSystem.super).Ctor)(self, ...)
  self._utility = (BattleECS.Utility).Utility
  self._physicsUtility = (BattleECS.Utility).PhysicsUtility
end

SkillSystem.Destroy = function(self)
  -- function num : 0_1 , upvalues : SkillSystem
  ((SkillSystem.super).Destroy)(self)
end

SkillSystem.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local SkillComponent = (BattleECS.Components).SkillComponent
  local TypeComponent = (BattleECS.Components).TypeComponent
  for _,entity in ipairs((self._world)._leftPlayerList) do
    local skillCom = entity:GetComponent(SkillComponent)
    if skillCom then
      for _,v in ipairs(skillCom._skillList) do
        if not ((self._utility).IsRoleDead)(entity) and (((self._physicsUtility).IsEntityHittedAwake)(entity) or (entity:GetComponent(TypeComponent))._roleID == 20054 or (entity:GetComponent(TypeComponent))._isImaged) then
          if ((self._utility).IsUseSkill)(v.skillId) then
            local preCurrentTime = v.currentTime
            local currentTime = v.currentTime + 1
            if preCurrentTime <= v.cdTime and v.cdTime < currentTime then
              local StateType = {notInCD = 0, inCD = 1}
              ;
              (((BattleECS.Utility).ProtocolUtility).SendActiveSkillStateChange)(entity._entityId, v.skillId, StateType.notInCD, self._world)
            end
          end
          do
            do
              v.currentTime = v.currentTime + 1
              -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      skillCom._hittedEntityNumber = 0
    end
    ;
    ((self._utility).UseCoordinatedSkill)(entity, self._world)
  end
  for _,entity in ipairs((self._world)._leftPlayerSummonList) do
    local skillCom = entity:GetComponent(SkillComponent)
    if skillCom then
      for _,v in ipairs(skillCom._skillList) do
        v.currentTime = v.currentTime + 1
      end
      skillCom._hittedEntityNumber = 0
    end
  end
  for _,entity in ipairs((self._world)._leftPlayerPartnerList) do
    local skillCom = entity:GetComponent(SkillComponent)
    if skillCom then
      for _,v in ipairs(skillCom._skillList) do
        v.currentTime = v.currentTime + 1
      end
    end
  end
  for _,entity in ipairs((self._world)._rightPlayerList) do
    local skillCom = entity:GetComponent(SkillComponent)
    if skillCom then
      for _,v in ipairs(skillCom._skillList) do
        v.currentTime = v.currentTime + 1
      end
      skillCom._hittedEntityNumber = 0
    end
    ;
    ((self._utility).UseCoordinatedSkill)(entity, self._world)
  end
  for _,entity in ipairs((self._world)._rightPlayerSummonList) do
    local skillCom = entity:GetComponent(SkillComponent)
    if skillCom then
      for _,v in ipairs(skillCom._skillList) do
        v.currentTime = v.currentTime + 1
      end
      skillCom._hittedEntityNumber = 0
    end
  end
end

return SkillSystem

