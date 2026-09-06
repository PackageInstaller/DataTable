local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local ChancetoUseSkill = class("ChancetoUseSkill", Task)

function ChancetoUseSkill:Ctor(context, rate, skillid)
  ChancetoUseSkill.super.Ctor(self)
  self._context = context
  self._skillid = skillid
  self._rate = rate
  local entity
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      entity = e
      break
    end
  end
  if entity then
    self._skillComponnet = entity:GetComponent(BattleECS.Components.SkillComponent)
  end
end

function ChancetoUseSkill:OnStart()
end

function ChancetoUseSkill:OnUpdate(deltaTime)
  if self._skillComponnet then
    local skillTable
    for _, v in ipairs(self._skillComponnet._skillList) do
      if self._skillid == v.skillId then
        skillTable = v
        break
      end
    end
    if skillTable then
      local randomNum = self._context._battleworld._randomPcg(1, 100)
      if randomNum <= self._rate then
        return TaskStatus.Success
      else
        skillTable.currentTime = 0
      end
    end
  end
  return TaskStatus.Failure
end

function ChancetoUseSkill:OnEnd()
end

return ChancetoUseSkill
