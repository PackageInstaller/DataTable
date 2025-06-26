-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif201.lua 

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
local Createnewbattleaif201 = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Agent, LoopUntil
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node4 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node5 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201023)
  local node6 = ((Agent.UseSkill).Create)(behavior, 201023)
  node2:AddTask(node3)
  node2:AddTask(node4)
  node2:AddTask(node5)
  node2:AddTask(node6)
  local node7 = (Sequence.Create)()
  local node8 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20000)
  local node9 = (Selector.Create)()
  local node10 = (LoopUntil.Create)(behavior, 1, true)
  local node11 = ((Agent.SummonMonsterType).Create)(behavior, 2, 21, 214, 0)
  node10:SetTask(node11)
  local node12 = (LoopUntil.Create)(behavior, 1, true)
  local node13 = ((Agent.SummonMonsterType).Create)(behavior, 2, 25, 214, 0)
  node12:SetTask(node13)
  node9:AddTask(node10)
  node9:AddTask(node12)
  node7:AddTask(node8)
  node7:AddTask(node9)
  node1:AddTask(node2)
  node1:AddTask(node7)
  return node1
end

return Createnewbattleaif201

