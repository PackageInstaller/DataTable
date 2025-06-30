-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif804.lua 

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
local Createnewbattleaif804 = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Agent, LoopUntil, IfElse
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = ((Agent.BattleStartFramesMoreEqual).Create)(behavior, 37)
  local node4 = (LoopUntil.Create)(behavior, 1, true)
  local node5 = ((Agent.ChangeName).Create)(behavior, 1400141)
  node4:SetTask(node5)
  node2:AddTask(node3)
  node2:AddTask(node4)
  local node6 = (Sequence.Create)()
  local node7 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node8 = (IfElse.Create)()
  local node9 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20859)
  local node10 = ((Agent.ChangeBehaviac).Create)(behavior, "newbattleaif519")
  local node11 = (LoopUntil.Create)(behavior, 1, true)
  local node12 = ((Agent.UseSkill).Create)(behavior, 201538)
  node11:SetTask(node12)
  node8:AddTask(node9, node10, node11)
  node6:AddTask(node7)
  node6:AddTask(node8)
  node1:AddTask(node2)
  node1:AddTask(node6)
  return node1
end

return Createnewbattleaif804

