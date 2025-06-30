-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif814_1.lua 

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
local Createnewbattleaif814_1 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = (Selector.Create)()
  local node4 = (Sequence.Create)()
  local node5 = ((Agent.MonsterHpLinePercentSection).Create)(behavior, 0, 0, 60)
  local node6 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201508)
  local node7 = (LoopUntil.Create)(behavior, 1, true)
  local node8 = ((Agent.UseSkill).Create)(behavior, 201508)
  node7:SetTask(node8)
  node4:AddTask(node5)
  node4:AddTask(node6)
  node4:AddTask(node7)
  local node9 = (Sequence.Create)()
  local node10 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201507)
  local node11 = ((Agent.UseSkill).Create)(behavior, 201507)
  node9:AddTask(node10)
  node9:AddTask(node11)
  local node12 = (Sequence.Create)()
  local node13 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201506)
  local node14 = ((Agent.UseSkill).Create)(behavior, 201506)
  node12:AddTask(node13)
  node12:AddTask(node14)
  local node15 = (Sequence.Create)()
  local node16 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201505)
  local node17 = ((Agent.UseSkill).Create)(behavior, 201505)
  node15:AddTask(node16)
  node15:AddTask(node17)
  node3:AddTask(node4)
  node3:AddTask(node9)
  node3:AddTask(node12)
  node3:AddTask(node15)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return Createnewbattleaif814_1

