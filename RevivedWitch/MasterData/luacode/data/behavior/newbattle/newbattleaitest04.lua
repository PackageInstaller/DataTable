-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaitest04.lua 

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
local CreateNewBattleAITest04 = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Agent, LoopUntil
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20415)
  local node4 = (LoopUntil.Create)(behavior, 1, true)
  local node5 = ((Agent.SummonMonsterType).Create)(behavior, 2, 23, 64, 0)
  node4:SetTask(node5)
  node2:AddTask(node3)
  node2:AddTask(node4)
  local node6 = (Sequence.Create)()
  local node7 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node8 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node9 = (Selector.Create)()
  local node10 = (Sequence.Create)()
  local node11 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201220)
  local node12 = ((Agent.UseSkill).Create)(behavior, 201220)
  node10:AddTask(node11)
  node10:AddTask(node12)
  local node13 = (Sequence.Create)()
  local node14 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201279)
  local node15 = (LoopUntil.Create)(behavior, 1, true)
  local node16 = ((Agent.UseSkill).Create)(behavior, 201279)
  node15:SetTask(node16)
  node13:AddTask(node14)
  node13:AddTask(node15)
  node9:AddTask(node10)
  node9:AddTask(node13)
  node6:AddTask(node7)
  node6:AddTask(node8)
  node6:AddTask(node9)
  node1:AddTask(node2)
  node1:AddTask(node6)
  return node1
end

return CreateNewBattleAITest04

