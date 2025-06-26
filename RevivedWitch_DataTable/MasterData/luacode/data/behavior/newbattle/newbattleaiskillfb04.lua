-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaiskillfb04.lua 

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
local CreateNewBattleAIskillfb04 = function(behavior)
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
  local node11 = ((Agent.UseSkill).Create)(behavior, 201472)
  node8:AddTask(node9)
  node8:AddTask(node11)
  local node12 = (IfElse.Create)()
  local node13 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20829)
  local node14 = (Selector.Create)()
  local node15 = (LoopUntil.Create)(behavior, 1, true)
  local node16 = ((Agent.UseSkill).Create)(behavior, 201455)
  node15:SetTask(node16)
  local node17 = ((Agent.UseSkill).Create)(behavior, 201471)
  node14:AddTask(node15)
  node14:AddTask(node17)
  local node18 = ((Agent.UseSkill).Create)(behavior, 201470)
  node12:AddTask(node13, node14, node18)
  node6:AddTask(node7, node8, node12)
  node3:AddTask(node4, node5, node6)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return CreateNewBattleAIskillfb04

