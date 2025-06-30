-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif518.lua 

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
local Createnewbattleaif518 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, IfElse, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = (IfElse.Create)()
  local node4 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20859)
  local node5 = (Selector.Create)()
  local node6 = (LoopUntil.Create)(behavior, 1, true)
  local node7 = ((Agent.ChangeName).Create)(behavior, 1400141)
  node6:SetTask(node7)
  local node8 = ((Agent.ChangeBehaviac).Create)(behavior, "newbattleaif519")
  node5:AddTask(node6)
  node5:AddTask(node8)
  local node9 = (LoopUntil.Create)(behavior, 1, true)
  local node10 = ((Agent.UseSkill).Create)(behavior, 201538)
  node9:SetTask(node10)
  node3:AddTask(node4, node5, node9)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return Createnewbattleaif518

