-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/changebehaviac.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local ChangeBehaviac = class("ChangeBehaviac", Task)
ChangeBehaviac.Ctor = function(self, context, behaviacname)
  -- function num : 0_0 , upvalues : ChangeBehaviac, _ENV
  ((ChangeBehaviac.super).Ctor)(self)
  self._context = context
  self._behaviacName = behaviacname
  local entity = nil
  for i,e in ipairs(((self._context)._battleworld)._entitys) do
    if e._entityId == (self._context)._entityId then
      entity = e
      break
    end
  end
  do
    if entity then
      self._behaviorComponnet = entity:GetComponent((BattleECS.Components).BehaviorComponent)
    end
  end
end

ChangeBehaviac.OnStart = function(self)
  -- function num : 0_1
end

ChangeBehaviac.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV, TaskStatus
  if self._behaviorComponnet then
    local oldBehavior = (self._behaviorComponnet)._behavior
    local newBehavior = (BehaviorManager.NewBehavior)("newbattle/" .. self._behaviacName)
    newBehavior._behaviorSkillList = oldBehavior._behaviorSkillList
    newBehavior._data = oldBehavior._data
    newBehavior._entityId = oldBehavior._entityId
    newBehavior._battleworld = oldBehavior._battleworld
    newBehavior:SetTree()
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._behaviorComponnet)._behavior = newBehavior
    return TaskStatus.Success
  end
  do
    return TaskStatus.Failure
  end
end

ChangeBehaviac.OnEnd = function(self)
  -- function num : 0_3
end

return ChangeBehaviac

