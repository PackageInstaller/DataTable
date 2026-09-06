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

local function CreateNewBattleAI10018(behavior)
  local data = behavior._data
  local node1 = Sequence.Create()
  local node2 = Agent.IsBattleEnd.Create(behavior)
  local node3 = Agent.IsRoleDead.Create(behavior)
  local node4 = Agent.IsRoleInOtherSkill.Create(behavior)
  local node5 = Agent.MonsterHpSection.Create(behavior, 10018, 0, 99800)
  local node6 = Agent.MonsterSkillIsInCD.Create(behavior, 201010)
  local node7 = Agent.UseSkill.Create(behavior, 201010)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  node1:AddTask(node5)
  node1:AddTask(node6)
  node1:AddTask(node7)
  return node1
end

return CreateNewBattleAI10018
