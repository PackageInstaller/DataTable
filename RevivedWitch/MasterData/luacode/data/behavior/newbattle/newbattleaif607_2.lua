-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif607_2.lua 

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
local Createnewbattleaif607_2 = function(behavior)
  -- function num : 0_0 , upvalues : Selector, LoopUntil, Agent, Sequence
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (LoopUntil.Create)(behavior, 1, true)
  local node3 = ((Agent.TimeCycle).Create)(behavior, 70)
  node2:SetTask(node3)
  local node4 = (Sequence.Create)()
  local node5 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node6 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node7 = (Selector.Create)()
  local node8 = (Sequence.Create)()
  local node9 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201239)
  local node10 = ((Agent.UseSkill).Create)(behavior, 201239)
  node8:AddTask(node9)
  node8:AddTask(node10)
  local node11 = (Sequence.Create)()
  local node12 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201238)
  local node13 = ((Agent.UseSkill).Create)(behavior, 201238)
  node11:AddTask(node12)
  node11:AddTask(node13)
  local node14 = (Sequence.Create)()
  local node15 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201240)
  local node16 = ((Agent.UseSkill).Create)(behavior, 201240)
  node14:AddTask(node15)
  node14:AddTask(node16)
  node7:AddTask(node8)
  node7:AddTask(node11)
  node7:AddTask(node14)
  node4:AddTask(node5)
  node4:AddTask(node6)
  node4:AddTask(node7)
  node1:AddTask(node2)
  node1:AddTask(node4)
  return node1
end

return Createnewbattleaif607_2

