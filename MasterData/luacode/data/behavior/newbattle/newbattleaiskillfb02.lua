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

local function CreateNewBattleAIskillfb02(behavior)
  local data = behavior._data
  local node1 = Sequence.Create()
  local node2 = Agent.IfHasEnoughConditionsUseSkill.Create(behavior)
  local node3 = IfElse.Create()
  local node4 = Agent.MonsterHasBuff.Create(behavior, 0, 20829)
  local node5 = Agent.ChangeBehaviac.Create(behavior, "NewBattleAIshadow2")
  local node6 = Agent.UseSkill.Create(behavior, 201470)
  node3:AddTask(node4, node5, node6)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return CreateNewBattleAIskillfb02
