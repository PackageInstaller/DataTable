-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleai20128.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoopUntil = require("luabehavior.decorators.loopuntil")
local Not = require("luabehavior.decorators.not")
local IfElse = require("luabehavior.composites.ifelse")
local Parallel = require("luabehavior.composites.parallel")
local ReferencedBehavior = require("luabehavior.composites.referencedbehavior")
local Sequence = require("luabehavior.composites.sequence")
local Selector = require("luabehavior.composites.selector")
local Noop = require("luabehavior.actions.noop")
local Wait = require("luabehavior.actions.wait")
local Agent = require("luabehavior.agent.battleai")
local CreateNewBattleAI20128 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = (Sequence.Create)()
  local node4 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201053)
  local node5 = ((Agent.UseSkill).Create)(behavior, 201053)
  node3:AddTask(node4)
  node3:AddTask(node5)
  local node6 = (Sequence.Create)()
  local node7 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201054)
  local node8 = ((Agent.UseSkill).Create)(behavior, 201054)
  node6:AddTask(node7)
  node6:AddTask(node8)
  local node9 = (Sequence.Create)()
  local node10 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201055)
  local node11 = ((Agent.UseSkill).Create)(behavior, 201055)
  node9:AddTask(node10)
  node9:AddTask(node11)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node6)
  node1:AddTask(node9)
  return node1
end

return CreateNewBattleAI20128

