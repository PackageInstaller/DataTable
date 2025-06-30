-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif408.lua 

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
local Createnewbattleaif408 = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Agent
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node4 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node5 = (Selector.Create)()
  local node6 = (Sequence.Create)()
  local node7 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201108)
  local node8 = ((Agent.UseSkill).Create)(behavior, 201108)
  node6:AddTask(node7)
  node6:AddTask(node8)
  local node9 = (Sequence.Create)()
  local node10 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201109)
  local node11 = ((Agent.UseSkill).Create)(behavior, 201109)
  node9:AddTask(node10)
  node9:AddTask(node11)
  local node12 = (Sequence.Create)()
  local node13 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201107)
  local node14 = ((Agent.UseSkill).Create)(behavior, 201107)
  node12:AddTask(node13)
  node12:AddTask(node14)
  node5:AddTask(node6)
  node5:AddTask(node9)
  node5:AddTask(node12)
  node2:AddTask(node3)
  node2:AddTask(node4)
  node2:AddTask(node5)
  node1:AddTask(node2)
  return node1
end

return Createnewbattleaif408

