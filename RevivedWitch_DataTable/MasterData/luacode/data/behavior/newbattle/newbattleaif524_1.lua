-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif524_1.lua 

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
local Createnewbattleaif524_1 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = (Selector.Create)()
  local node4 = (Sequence.Create)()
  local node5 = ((Agent.MonsterHpPercentSection).Create)(behavior, 0, 0, 20)
  local node6 = (LoopUntil.Create)(behavior, 1, true)
  local node7 = ((Agent.UseSkill).Create)(behavior, 201592)
  node6:SetTask(node7)
  node4:AddTask(node5)
  node4:AddTask(node6)
  local node8 = (Sequence.Create)()
  local node9 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201528)
  local node10 = ((Agent.UseSkill).Create)(behavior, 201528)
  local node11 = ((Agent.ClearSkillCurrentTime).Create)(behavior, 201527)
  node8:AddTask(node9)
  node8:AddTask(node10)
  node8:AddTask(node11)
  local node12 = (Sequence.Create)()
  local node13 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201527)
  local node14 = ((Agent.UseSkill).Create)(behavior, 201527)
  node12:AddTask(node13)
  node12:AddTask(node14)
  node3:AddTask(node4)
  node3:AddTask(node8)
  node3:AddTask(node12)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return Createnewbattleaif524_1

