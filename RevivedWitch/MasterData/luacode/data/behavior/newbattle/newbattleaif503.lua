-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif503.lua 

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
local Createnewbattleaif503 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node4 = (Selector.Create)()
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.MonsterSelfCurrentHPLessEqual).Create)(behavior, 50)
  local node7 = ((Agent.MonsterOutBattle).Create)(behavior, 501, -1)
  local node8 = (LoopUntil.Create)(behavior, 1, true)
  local node9 = ((Agent.UseSkill).Create)(behavior, 201279)
  node8:SetTask(node9)
  node5:AddTask(node6)
  node5:AddTask(node7)
  node5:AddTask(node8)
  local node10 = (Sequence.Create)()
  local node11 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20415)
  local node12 = (LoopUntil.Create)(behavior, 1, true)
  local node13 = ((Agent.SummonMonsterType).Create)(behavior, 2, 23, 501, 0)
  node12:SetTask(node13)
  node10:AddTask(node11)
  node10:AddTask(node12)
  local node14 = (Sequence.Create)()
  local node15 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201220)
  local node16 = ((Agent.UseSkill).Create)(behavior, 201220)
  node14:AddTask(node15)
  node14:AddTask(node16)
  node4:AddTask(node5)
  node4:AddTask(node10)
  node4:AddTask(node14)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  return node1
end

return Createnewbattleaif503

