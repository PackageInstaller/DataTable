-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif519.lua 

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
local Createnewbattleaif519 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, LoopUntil, IfElse
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = (Selector.Create)()
  local node4 = (LoopUntil.Create)(behavior, 1, true)
  local node5 = ((Agent.ChangeName).Create)(behavior, 1400141)
  node4:SetTask(node5)
  local node6 = (IfElse.Create)()
  local node7 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20766)
  local node8 = (Sequence.Create)()
  local node9 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201489)
  local node10 = ((Agent.UseSkill).Create)(behavior, 201489)
  node8:AddTask(node9)
  node8:AddTask(node10)
  local node11 = (Selector.Create)()
  local node12 = (Sequence.Create)()
  local node13 = ((Agent.MonsterHpPercentSection).Create)(behavior, 0, 0, 50)
  local node14 = ((Agent.UseSkill).Create)(behavior, 201488)
  local node15 = ((Agent.ClearSkillCurrentTime).Create)(behavior, 201489)
  node12:AddTask(node13)
  node12:AddTask(node14)
  node12:AddTask(node15)
  local node16 = (Sequence.Create)()
  local node17 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201487)
  local node18 = ((Agent.UseSkill).Create)(behavior, 201487)
  node16:AddTask(node17)
  node16:AddTask(node18)
  node11:AddTask(node12)
  node11:AddTask(node16)
  node6:AddTask(node7, node8, node11)
  node3:AddTask(node4)
  node3:AddTask(node6)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return Createnewbattleaif519

