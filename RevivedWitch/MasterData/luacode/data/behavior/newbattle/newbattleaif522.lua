-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif522.lua 

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
local Createnewbattleaif522 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = (Selector.Create)()
  local node4 = (Sequence.Create)()
  local node5 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201513)
  local node6 = ((Agent.UseSkill).Create)(behavior, 201513)
  node4:AddTask(node5)
  node4:AddTask(node6)
  local node7 = (Sequence.Create)()
  local node8 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201512)
  local node9 = ((Agent.UseSkill).Create)(behavior, 201512)
  node7:AddTask(node8)
  node7:AddTask(node9)
  local node10 = (Sequence.Create)()
  local node11 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201511)
  local node12 = ((Agent.UseSkill).Create)(behavior, 201511)
  node10:AddTask(node11)
  node10:AddTask(node12)
  local node13 = (Sequence.Create)()
  local node14 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201510)
  local node15 = ((Agent.UseSkill).Create)(behavior, 201510)
  node13:AddTask(node14)
  node13:AddTask(node15)
  local node16 = (Sequence.Create)()
  local node17 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201509)
  local node18 = ((Agent.UseSkill).Create)(behavior, 201509)
  node16:AddTask(node17)
  node16:AddTask(node18)
  node3:AddTask(node4)
  node3:AddTask(node7)
  node3:AddTask(node10)
  node3:AddTask(node13)
  node3:AddTask(node16)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return Createnewbattleaif522

