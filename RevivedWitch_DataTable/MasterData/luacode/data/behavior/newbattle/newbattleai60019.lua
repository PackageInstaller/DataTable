-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleai60019.lua 

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
local CreateNewBattleAI60019 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, IfElse, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = (IfElse.Create)()
  local node4 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20831)
  local node5 = ((Agent.ChangeBehaviac).Create)(behavior, "NewBattleAIshadow4")
  local node6 = (IfElse.Create)()
  local node7 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20830)
  local node8 = (Selector.Create)()
  local node9 = (LoopUntil.Create)(behavior, 1, true)
  local node10 = ((Agent.UseSkill).Create)(behavior, 201459)
  node9:SetTask(node10)
  local node11 = (LoopUntil.Create)(behavior, 1, true)
  local node12 = ((Agent.UseSkill).Create)(behavior, 201472)
  node11:SetTask(node12)
  node8:AddTask(node9)
  node8:AddTask(node11)
  local node13 = (IfElse.Create)()
  local node14 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20829)
  local node15 = (Selector.Create)()
  local node16 = (LoopUntil.Create)(behavior, 1, true)
  local node17 = ((Agent.UseSkill).Create)(behavior, 201455)
  node16:SetTask(node17)
  local node18 = (LoopUntil.Create)(behavior, 1, true)
  local node19 = ((Agent.UseSkill).Create)(behavior, 201471)
  node18:SetTask(node19)
  node15:AddTask(node16)
  node15:AddTask(node18)
  local node20 = (LoopUntil.Create)(behavior, 1, true)
  local node21 = ((Agent.UseSkill).Create)(behavior, 201470)
  node20:SetTask(node21)
  node13:AddTask(node14, node15, node20)
  node6:AddTask(node7, node8, node13)
  node3:AddTask(node4, node5, node6)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return CreateNewBattleAI60019

