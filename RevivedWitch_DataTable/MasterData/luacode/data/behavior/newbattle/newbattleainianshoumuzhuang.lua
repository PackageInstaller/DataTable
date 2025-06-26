-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleainianshoumuzhuang.lua 

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
local CreateNewBattleAINianshouMuzhuang = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Agent
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = ((Agent.IfHasCurrentBuffByBuffID).Create)(behavior, 21477)
  local node4 = ((Agent.BattleResult).Create)(behavior, 2)
  node2:AddTask(node3)
  node2:AddTask(node4)
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.PersonNum).Create)(behavior, 2, "eq", 1)
  local node7 = ((Agent.RunAway).Create)(behavior, "Hide")
  node5:AddTask(node6)
  node5:AddTask(node7)
  node1:AddTask(node2)
  node1:AddTask(node5)
  return node1
end

return CreateNewBattleAINianshouMuzhuang

