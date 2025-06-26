-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleai60020.lua 

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
local CreateNewBattleAI60020 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = (Selector.Create)()
  local node4 = (Sequence.Create)()
  local node5 = ((Agent.TimeCycle).Create)(behavior, 200)
  local node6 = (LoopUntil.Create)(behavior, 1, true)
  local node7 = ((Agent.UseSkill).Create)(behavior, 201553)
  node6:SetTask(node7)
  node4:AddTask(node5)
  node4:AddTask(node6)
  local node8 = (Sequence.Create)()
  local node9 = ((Agent.TimeCycle).Create)(behavior, 400)
  local node10 = (LoopUntil.Create)(behavior, 1, true)
  local node11 = ((Agent.UseSkill).Create)(behavior, 201554)
  node10:SetTask(node11)
  node8:AddTask(node9)
  node8:AddTask(node10)
  local node12 = (Sequence.Create)()
  local node13 = ((Agent.TimeCycle).Create)(behavior, 600)
  local node14 = (LoopUntil.Create)(behavior, 1, true)
  local node15 = ((Agent.UseSkill).Create)(behavior, 201555)
  node14:SetTask(node15)
  node12:AddTask(node13)
  node12:AddTask(node14)
  node3:AddTask(node4)
  node3:AddTask(node8)
  node3:AddTask(node12)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return CreateNewBattleAI60020

