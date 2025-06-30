-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleai1013.lua 

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
local WaitFrames = require("luabehavior.actions.waitframes")
local Agent = require("luabehavior.agent.battleai")
local CreateNewBattleAI1013 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node4 = (Selector.Create)()
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 6015101)
  local node7 = ((Agent.UseSkill).Create)(behavior, 6015101)
  node5:AddTask(node6)
  node5:AddTask(node7)
  local node8 = (Sequence.Create)()
  local node9 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 6015201)
  local node10 = ((Agent.UseSkill).Create)(behavior, 6015201)
  node8:AddTask(node9)
  node8:AddTask(node10)
  local node11 = (Sequence.Create)()
  local node12 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 10015)
  local node13 = ((Agent.UseSkill).Create)(behavior, 10015)
  node11:AddTask(node12)
  node11:AddTask(node13)
  node4:AddTask(node5)
  node4:AddTask(node8)
  node4:AddTask(node11)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  return node1
end

return CreateNewBattleAI1013

