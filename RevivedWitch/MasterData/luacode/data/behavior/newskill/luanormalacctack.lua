-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newskill/luanormalacctack.lua 

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
local Agent = require("luabehavior.agent.skill")
local CreateLuaNormalAcctack = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.Banner).Create)(behavior)
  local node3 = ((Agent.NextStage).Create)(behavior)
  local node4 = ((Agent.Move).Create)(behavior, 100)
  local node5 = ((Agent.PlayAttackerAction).Create)(behavior, data.atkAction)
  local node6 = ((Agent.PlayAttackerEffect).Create)(behavior, data.atkEffectId)
  local node7 = (LoopUntil.Create)(behavior, -1, false)
  local node8 = (Sequence.Create)()
  local node9 = ((Agent.PlayTargetEffect).Create)(behavior, data.hitEffectId)
  local node10 = ((Agent.Result).Create)(behavior)
  local node11 = ((Agent.NextStage).Create)(behavior)
  node8:AddTask(node9)
  node8:AddTask(node10)
  node8:AddTask(node11)
  node7:SetTask(node8)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  node1:AddTask(node5)
  node1:AddTask(node6)
  node1:AddTask(node7)
  return node1
end

return CreateLuaNormalAcctack

