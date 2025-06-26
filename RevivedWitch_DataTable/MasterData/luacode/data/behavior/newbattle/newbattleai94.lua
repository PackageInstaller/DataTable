-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleai94.lua 

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
local CreateNewBattleAI94 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, IfElse, Selector
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 60)
  local node4 = (IfElse.Create)()
  local node5 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20623)
  local node6 = (Sequence.Create)()
  local node7 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201157)
  local node8 = ((Agent.UseSkill).Create)(behavior, 201157)
  local node9 = ((Agent.ClearSkillCurrentTime).Create)(behavior, 201251)
  node6:AddTask(node7)
  node6:AddTask(node8)
  node6:AddTask(node9)
  local node10 = (Selector.Create)()
  local node11 = (Sequence.Create)()
  local node12 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201251)
  local node13 = ((Agent.UseSkill).Create)(behavior, 201251)
  local node14 = ((Agent.ClearSkillCurrentTime).Create)(behavior, 201157)
  node11:AddTask(node12)
  node11:AddTask(node13)
  node11:AddTask(node14)
  local node15 = (Sequence.Create)()
  local node16 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201157)
  local node17 = ((Agent.UseSkill).Create)(behavior, 201157)
  node15:AddTask(node16)
  node15:AddTask(node17)
  node10:AddTask(node11)
  node10:AddTask(node15)
  node4:AddTask(node5, node6, node10)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  return node1
end

return CreateNewBattleAI94

