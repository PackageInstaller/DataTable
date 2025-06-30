-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaitestlianzhan04.lua 

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
local CreateNewBattleAItestLianzhan04 = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Agent, LoopUntil
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = ((Agent.PersonNum).Create)(behavior, 2, "eq", 1)
  local node4 = (LoopUntil.Create)(behavior, 1, true)
  local node5 = ((Agent.SummonMonster).Create)(behavior, 2, 21, 66010)
  node4:SetTask(node5)
  local node6 = (LoopUntil.Create)(behavior, 1, true)
  local node7 = ((Agent.SummonMonster).Create)(behavior, 2, 25, 66010)
  node6:SetTask(node7)
  local node8 = (LoopUntil.Create)(behavior, 1, true)
  local node9 = ((Agent.SummonMonster).Create)(behavior, 2, 29, 66010)
  node8:SetTask(node9)
  local node10 = ((Agent.UseSkill).Create)(behavior, 201664)
  node2:AddTask(node3)
  node2:AddTask(node4)
  node2:AddTask(node6)
  node2:AddTask(node8)
  node2:AddTask(node10)
  local node11 = (Sequence.Create)()
  local node12 = ((Agent.PersonNum).Create)(behavior, 2, "eq", 1)
  local node13 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 21210)
  local node14 = (LoopUntil.Create)(behavior, 1, true)
  local node15 = ((Agent.SummonMonster).Create)(behavior, 2, 21, 66010)
  node14:SetTask(node15)
  local node16 = (LoopUntil.Create)(behavior, 1, true)
  local node17 = ((Agent.SummonMonster).Create)(behavior, 2, 29, 66011)
  node16:SetTask(node17)
  local node18 = ((Agent.RunAway).Create)(behavior, "Hide")
  node11:AddTask(node12)
  node11:AddTask(node13)
  node11:AddTask(node14)
  node11:AddTask(node16)
  node11:AddTask(node18)
  node1:AddTask(node2)
  node1:AddTask(node11)
  return node1
end

return CreateNewBattleAItestLianzhan04

