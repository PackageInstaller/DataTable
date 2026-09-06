local System = require("ecs.system")
local SkillSystem = strictclass("SkillSystem", System)

function SkillSystem:Ctor(...)
  SkillSystem.super.Ctor(self, ...)
  self._utility = BattleECS.Utility.Utility
  self._physicsUtility = BattleECS.Utility.PhysicsUtility
end

function SkillSystem:Destroy()
  SkillSystem.super.Destroy(self)
end

function SkillSystem:Update()
  local SkillComponent = BattleECS.Components.SkillComponent
  local TypeComponent = BattleECS.Components.TypeComponent
  for _, entity in ipairs(self._world._leftPlayerList) do
    local skillCom = entity:GetComponent(SkillComponent)
    if skillCom then
      for _, v in ipairs(skillCom._skillList) do
        if not self._utility.IsRoleDead(entity) and (self._physicsUtility.IsEntityHittedAwake(entity) or entity:GetComponent(TypeComponent)._roleID == 20054 or entity:GetComponent(TypeComponent)._isImaged) then
          if self._utility.IsUseSkill(v.skillId) then
            local preCurrentTime = v.currentTime
            local currentTime = v.currentTime + 1
            if preCurrentTime <= v.cdTime and currentTime > v.cdTime then
              local StateType = {notInCD = 0, inCD = 1}
              BattleECS.Utility.ProtocolUtility.SendActiveSkillStateChange(entity._entityId, v.skillId, StateType.notInCD, self._world)
            end
          end
          v.currentTime = v.currentTime + 1
        end
      end
      skillCom._hittedEntityNumber = 0
    end
    self._utility.UseCoordinatedSkill(entity, self._world)
  end
  for _, entity in ipairs(self._world._leftPlayerSummonList) do
    local skillCom = entity:GetComponent(SkillComponent)
    if skillCom then
      for _, v in ipairs(skillCom._skillList) do
        v.currentTime = v.currentTime + 1
      end
      skillCom._hittedEntityNumber = 0
    end
  end
  for _, entity in ipairs(self._world._leftPlayerPartnerList) do
    local skillCom = entity:GetComponent(SkillComponent)
    if skillCom then
      for _, v in ipairs(skillCom._skillList) do
        v.currentTime = v.currentTime + 1
      end
    end
  end
  for _, entity in ipairs(self._world._rightPlayerList) do
    local skillCom = entity:GetComponent(SkillComponent)
    if skillCom then
      for _, v in ipairs(skillCom._skillList) do
        v.currentTime = v.currentTime + 1
      end
      skillCom._hittedEntityNumber = 0
    end
    self._utility.UseCoordinatedSkill(entity, self._world)
  end
  for _, entity in ipairs(self._world._rightPlayerSummonList) do
    local skillCom = entity:GetComponent(SkillComponent)
    if skillCom then
      for _, v in ipairs(skillCom._skillList) do
        v.currentTime = v.currentTime + 1
      end
      skillCom._hittedEntityNumber = 0
    end
  end
end

return SkillSystem
