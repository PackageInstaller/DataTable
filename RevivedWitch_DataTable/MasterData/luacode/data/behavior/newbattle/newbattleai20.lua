-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleai20.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
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
local Agent = require("luabehavior.agent.battleai")
local CreateNewBattleAI20 = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Agent
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = ((Agent.TimeCycle).Create)(behavior, 600)
  local node4 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node5 = ((Agent.SummonMonsterType).Create)(behavior, 2, 21, 26, 0)
  node2:AddTask(node3)
  node2:AddTask(node4)
  node2:AddTask(node5)
  local node6 = (Sequence.Create)()
  local node7 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node8 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node9 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201021)
  local node10 = ((Agent.UseSkill).Create)(behavior, 201021)
  node6:AddTask(node7)
  node6:AddTask(node8)
  node6:AddTask(node9)
  node6:AddTask(node10)
  node1:AddTask(node2)
  node1:AddTask(node6)
  return node1
end

return CreateNewBattleAI20

