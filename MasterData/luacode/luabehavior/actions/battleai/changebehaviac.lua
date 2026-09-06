local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local ChangeBehaviac = class("ChangeBehaviac", Task)

function ChangeBehaviac:Ctor(context, behaviacname)
  ChangeBehaviac.super.Ctor(self)
  self._context = context
  self._behaviacName = behaviacname
  local entity
  for i, e in ipairs(self._context._battleworld._entitys) do
    if e._entityId == self._context._entityId then
      entity = e
      break
    end
  end
  if entity then
    self._behaviorComponnet = entity:GetComponent(BattleECS.Components.BehaviorComponent)
  end
end

function ChangeBehaviac:OnStart()
end

function ChangeBehaviac:OnUpdate(deltaTime)
  if self._behaviorComponnet then
    local oldBehavior = self._behaviorComponnet._behavior
    local newBehavior = BehaviorManager.NewBehavior("newbattle/" .. self._behaviacName)
    newBehavior._behaviorSkillList = oldBehavior._behaviorSkillList
    newBehavior._data = oldBehavior._data
    newBehavior._entityId = oldBehavior._entityId
    newBehavior._battleworld = oldBehavior._battleworld
    newBehavior:SetTree()
    self._behaviorComponnet._behavior = newBehavior
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

function ChangeBehaviac:OnEnd()
end

return ChangeBehaviac
