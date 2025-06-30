-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaifb14.lua 

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
local CreateNewBattleAIfb14 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, SelectorProbability, Weight
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 60)
  local node4 = (Selector.Create)()
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201352)
  local node7 = (SelectorProbability.Create)(data.RandomFunction)
  local node8 = (Weight.Create)(1)
  local node9 = ((Agent.UseSkill).Create)(behavior, 6018201)
  node8:SetTask(node9)
  local node10 = (Weight.Create)(2)
  local node11 = ((Agent.UseSkill).Create)(behavior, 6018101)
  node10:SetTask(node11)
  node7:AddTask(node8)
  node7:AddTask(node10)
  local node12 = ((Agent.ClearSkillCurrentTime).Create)(behavior, 201352)
  node5:AddTask(node6)
  node5:AddTask(node7)
  node5:AddTask(node12)
  local node13 = (Sequence.Create)()
  local node14 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 10018)
  local node15 = ((Agent.UseSkill).Create)(behavior, 10018)
  node13:AddTask(node14)
  node13:AddTask(node15)
  node4:AddTask(node5)
  node4:AddTask(node13)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  return node1
end

return CreateNewBattleAIfb14

