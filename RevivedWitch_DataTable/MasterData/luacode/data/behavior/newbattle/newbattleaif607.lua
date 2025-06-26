-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif607.lua 

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
local Createnewbattleaif607 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node4 = (Selector.Create)()
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.MonsterHpPercentSection).Create)(behavior, 0, 0, 50)
  local node7 = (LoopUntil.Create)(behavior, 1, true)
  local node8 = ((Agent.UseSkill).Create)(behavior, 201240)
  node7:SetTask(node8)
  node5:AddTask(node6)
  node5:AddTask(node7)
  local node9 = (Sequence.Create)()
  local node10 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20416)
  local node11 = (LoopUntil.Create)(behavior, 1, true)
  local node12 = ((Agent.SummonMonster).Create)(behavior, 2, 21, 90006)
  node11:SetTask(node12)
  node9:AddTask(node10)
  node9:AddTask(node11)
  local node13 = (Selector.Create)()
  local node14 = (Sequence.Create)()
  local node15 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201239)
  local node16 = ((Agent.UseSkill).Create)(behavior, 201239)
  node14:AddTask(node15)
  node14:AddTask(node16)
  local node17 = (Sequence.Create)()
  local node18 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201238)
  local node19 = ((Agent.UseSkill).Create)(behavior, 201238)
  node17:AddTask(node18)
  node17:AddTask(node19)
  node13:AddTask(node14)
  node13:AddTask(node17)
  node4:AddTask(node5)
  node4:AddTask(node9)
  node4:AddTask(node13)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  return node1
end

return Createnewbattleaif607

