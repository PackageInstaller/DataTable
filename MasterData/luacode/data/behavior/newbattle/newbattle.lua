local LoopUntil = require("luabehavior.decorators.loopuntil")
local Not = require("luabehavior.decorators.not")
local IfElse = require("luabehavior.composites.ifelse")
local Parallel = require("luabehavior.composites.parallel")
local ReferencedBehavior = require("luabehavior.composites.referencedbehavior")
local Sequence = require("luabehavior.composites.sequence")
local Selector = require("luabehavior.composites.selector")
local Noop = require("luabehavior.actions.noop")
local Wait = require("luabehavior.actions.wait")
local Agent = require("luabehavior.agent.battleai")

local function CreateNewBattleA(behavior)
  local data = behavior._data
  local node1 = Sequence.Create()
  local node2 = Agent.CanUseSkill.Create(behavior)
  local node3 = Agent.SkillInCountDown.Create(behavior)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return CreateNewBattleA
