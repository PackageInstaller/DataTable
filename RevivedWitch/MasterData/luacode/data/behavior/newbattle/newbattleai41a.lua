-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleai41a.lua 

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
local CreateNewBattleAI41a = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, IfElse, Selector
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = (IfElse.Create)()
  local node4 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20447)
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201331)
  local node7 = ((Agent.UseSkill).Create)(behavior, 201331)
  node5:AddTask(node6)
  node5:AddTask(node7)
  local node8 = (Selector.Create)()
  local node9 = (Sequence.Create)()
  local node10 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201332)
  local node11 = ((Agent.UseSkill).Create)(behavior, 201332)
  node9:AddTask(node10)
  node9:AddTask(node11)
  local node12 = (Sequence.Create)()
  local node13 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201333)
  local node14 = ((Agent.UseSkill).Create)(behavior, 201333)
  node12:AddTask(node13)
  node12:AddTask(node14)
  node8:AddTask(node9)
  node8:AddTask(node12)
  node3:AddTask(node4, node5, node8)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return CreateNewBattleAI41a

