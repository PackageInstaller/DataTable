-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif212.lua 

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
local Createnewbattleaif212 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, SelectorProbability, Weight
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 60)
  local node4 = (Selector.Create)()
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.TimeCycle).Create)(behavior, 600)
  local node7 = ((Agent.MonsterOutBattle).Create)(behavior, 218, -1)
  local node8 = ((Agent.SummonMonsterType).Create)(behavior, 2, 21, 218, 0)
  node5:AddTask(node6)
  node5:AddTask(node7)
  node5:AddTask(node8)
  local node9 = (Sequence.Create)()
  local node10 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201030)
  local node11 = ((Agent.UseSkill).Create)(behavior, 201030)
  node9:AddTask(node10)
  node9:AddTask(node11)
  local node12 = (Sequence.Create)()
  local node13 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201231)
  local node14 = (SelectorProbability.Create)(data.RandomFunction)
  local node15 = (Weight.Create)(1)
  local node16 = ((Agent.UseSkill).Create)(behavior, 201231)
  node15:SetTask(node16)
  local node17 = (Weight.Create)(1)
  local node18 = ((Agent.ClearSkillCurrentTime).Create)(behavior, 201231)
  node17:SetTask(node18)
  node14:AddTask(node15)
  node14:AddTask(node17)
  node12:AddTask(node13)
  node12:AddTask(node14)
  node4:AddTask(node5)
  node4:AddTask(node9)
  node4:AddTask(node12)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  return node1
end

return Createnewbattleaif212

