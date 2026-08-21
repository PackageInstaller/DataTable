-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaitest37.lua 

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
local CreateNewBattleAITest37 = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Agent, LoopUntil
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20000)
  local node4 = ((Agent.PersonNum).Create)(behavior, 2, "eq", 0)
  local node5 = (LoopUntil.Create)(behavior, 1, true)
  local node6 = ((Agent.SummonMonster).Create)(behavior, 2, 29, 80067)
  node5:SetTask(node6)
  node2:AddTask(node3)
  node2:AddTask(node4)
  node2:AddTask(node5)
  local node7 = (Sequence.Create)()
  local node8 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node9 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node10 = (Selector.Create)()
  local node11 = (Sequence.Create)()
  local node12 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201652)
  local node13 = ((Agent.UseSkill).Create)(behavior, 201652)
  node11:AddTask(node12)
  node11:AddTask(node13)
  local node14 = (Sequence.Create)()
  local node15 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201653)
  local node16 = ((Agent.UseSkill).Create)(behavior, 201653)
  local node17 = ((Agent.ClearSkillCurrentTime).Create)(behavior, 201652)
  node14:AddTask(node15)
  node14:AddTask(node16)
  node14:AddTask(node17)
  node10:AddTask(node11)
  node10:AddTask(node14)
  node7:AddTask(node8)
  node7:AddTask(node9)
  node7:AddTask(node10)
  node1:AddTask(node2)
  node1:AddTask(node7)
  return node1
end

return CreateNewBattleAITest37

