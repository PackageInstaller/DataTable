-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newskill/luatestattack.lua 

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
local Agent = require("luabehavior.agent.testskill")
local CreateLuaTestAttack = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Parallel, IfElse
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.AttackerMove).Create)(behavior, 100)
  local node3 = (Parallel.Create)("FAIL_ON_ONE", "SUCCEED_ON_ALL", "CHILDFINISH_ONCE", "EXIT_ABORT_RUNNINGSIBLINGS")
  local node4 = ((Agent.PlayAttackerAction).Create)(behavior, "attack")
  local node5 = ((Agent.PlayAttackerEffect).Create)(behavior, 0)
  node3:AddTask(node4)
  node3:AddTask(node5)
  local node6 = (Parallel.Create)("FAIL_ON_ONE", "SUCCEED_ON_ALL", "CHILDFINISH_ONCE", "EXIT_ABORT_RUNNINGSIBLINGS")
  local node7 = ((Agent.PlayTargetEffect).Create)(behavior, 0)
  local node8 = ((Agent.Result).Create)(behavior)
  node6:AddTask(node7)
  node6:AddTask(node8)
  local node9 = (IfElse.Create)()
  local node10 = ((Agent.HasNextStage).Create)(behavior)
  local node11 = ((Agent.NextStage).Create)(behavior)
  local node12 = ((Agent.AttackerMoveBack).Create)(behavior)
  node9:AddTask(node10, node11, node12)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node6)
  node1:AddTask(node9)
  return node1
end

return CreateLuaTestAttack

