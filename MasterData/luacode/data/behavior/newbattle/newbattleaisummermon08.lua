local LoopUntil = require("luabehavior.decorators.loopuntil")
local Not = require("luabehavior.decorators.not")
local Weight = require("luabehavior.decorators.weight")
local IfElse = require("luabehavior.composites.ifelse")
local Parallel = require("luabehavior.composites.parallel")
local ReferencedBehavior = require("luabehavior.composites.referencedbehavior")
local Sequence = require("luabehavior.composites.sequence")
local Selector = require("luabehavior.composites.selector")
local SelectorProbability = require("luabehavior.composites.selectorprobability")
local Noop = require("luabehavior.actions.noop")
local Wait = require("luabehavior.actions.wait")
local WaitFrames = require("luabehavior.actions.waitframes")
local Agent = require("luabehavior.agent.battleai")

local function CreateNewBattleAISummerMon08(behavior)
  local data = behavior._data
  local node1 = Sequence.Create()
  local node2 = Agent.IfHasEnoughConditionsUseSkill.Create(behavior)
  local node3 = LoopUntil.Create(behavior, 1, true)
  local node4 = Agent.UseSkill.Create(behavior, 201706)
  node3:SetTask(node4)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return CreateNewBattleAISummerMon08
