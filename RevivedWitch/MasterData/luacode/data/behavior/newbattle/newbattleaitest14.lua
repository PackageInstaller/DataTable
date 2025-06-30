-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaitest14.lua 

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
local CreateNewBattleAITest14 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node4 = (Selector.Create)()
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.MonsterHpLinePercentSection).Create)(behavior, 0, 1, 100)
  local node7 = ((Agent.PersonNum).Create)(behavior, 2, "eq", 1)
  local node8 = (LoopUntil.Create)(behavior, 1, true)
  local node9 = ((Agent.UseSkill).Create)(behavior, 201338)
  node8:SetTask(node9)
  node5:AddTask(node6)
  node5:AddTask(node7)
  node5:AddTask(node8)
  local node10 = (Sequence.Create)()
  local node11 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201277)
  local node12 = ((Agent.UseSkill).Create)(behavior, 201277)
  node10:AddTask(node11)
  node10:AddTask(node12)
  local node13 = (Sequence.Create)()
  local node14 = ((Agent.MonsterHpLinePercentSection).Create)(behavior, 0, 1, 100)
  local node15 = ((Agent.PersonNum).Create)(behavior, 2, "gt", 1)
  local node16 = (LoopUntil.Create)(behavior, 1, true)
  local node17 = ((Agent.UseSkill).Create)(behavior, 201276)
  node16:SetTask(node17)
  node13:AddTask(node14)
  node13:AddTask(node15)
  node13:AddTask(node16)
  node4:AddTask(node5)
  node4:AddTask(node10)
  node4:AddTask(node13)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  return node1
end

return CreateNewBattleAITest14

