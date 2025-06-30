-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaiweidingmuzhuang.lua 

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
local CreateNewBattleAIWeidingMuzhuang = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Agent
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = ((Agent.IfHasCurrentBuffByBuffID).Create)(behavior, 21284)
  local node4 = ((Agent.BattleResult).Create)(behavior, 2)
  node2:AddTask(node3)
  node2:AddTask(node4)
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.IfHasCurrentBuffByBuffID).Create)(behavior, 21285)
  local node7 = ((Agent.BattleResult).Create)(behavior, 2)
  node5:AddTask(node6)
  node5:AddTask(node7)
  local node8 = (Sequence.Create)()
  local node9 = ((Agent.IfHasCurrentBuffByBuffID).Create)(behavior, 21286)
  local node10 = ((Agent.BattleResult).Create)(behavior, 2)
  node8:AddTask(node9)
  node8:AddTask(node10)
  local node11 = (Sequence.Create)()
  local node12 = ((Agent.PersonNum).Create)(behavior, 2, "eq", 1)
  local node13 = ((Agent.RunAway).Create)(behavior, "Hide")
  node11:AddTask(node12)
  node11:AddTask(node13)
  node1:AddTask(node2)
  node1:AddTask(node5)
  node1:AddTask(node8)
  node1:AddTask(node11)
  return node1
end

return CreateNewBattleAIWeidingMuzhuang

