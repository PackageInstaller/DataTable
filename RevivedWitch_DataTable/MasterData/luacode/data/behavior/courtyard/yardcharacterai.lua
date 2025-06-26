-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/courtyard/yardcharacterai.lua 

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
local Agent = require("luabehavior.agent.yardcharacterai")
local CreateYardCharacterAI = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Agent, SelectorProbability, Weight
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = ((Agent.IsArriveBorder).Create)(behavior)
  local node4 = ((Agent.Walk).Create)(behavior, -1, 1000, 3000)
  node2:AddTask(node3)
  node2:AddTask(node4)
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.IsState).Create)(behavior, 1)
  local node7 = ((Agent.Stand).Create)(behavior, 1, 2000, 8000)
  node5:AddTask(node6)
  node5:AddTask(node7)
  local node8 = (SelectorProbability.Create)(data.RandomFunction)
  local node9 = (Weight.Create)(1)
  local node10 = ((Agent.WalkOrStand).Create)(behavior, 0, -1, 2000, 8000)
  node9:SetTask(node10)
  local node11 = (Weight.Create)(1)
  local node12 = ((Agent.WalkOrStand).Create)(behavior, 0, 1, 2000, 8000)
  node11:SetTask(node12)
  local node13 = (Weight.Create)(5)
  local node14 = ((Agent.WalkOrStand).Create)(behavior, 1, -1, 2000, 5000)
  node13:SetTask(node14)
  local node15 = (Weight.Create)(5)
  local node16 = ((Agent.WalkOrStand).Create)(behavior, 1, 1, 2000, 5000)
  node15:SetTask(node16)
  node8:AddTask(node9)
  node8:AddTask(node11)
  node8:AddTask(node13)
  node8:AddTask(node15)
  node1:AddTask(node2)
  node1:AddTask(node5)
  node1:AddTask(node8)
  return node1
end

return CreateYardCharacterAI

