-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaifb31.lua 

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
local CreateNewBattleAIfb31 = function(behavior)
  -- function num : 0_0 , upvalues : Selector, Sequence, Not, Agent, LoopUntil
  local data = behavior._data
  local node1 = (Selector.Create)()
  local node2 = (Sequence.Create)()
  local node3 = (Not.Create)(behavior)
  local node4 = ((Agent.IsRoleDead).Create)(behavior)
  node3:SetTask(node4)
  local node5 = (LoopUntil.Create)(behavior, 1, true)
  local node6 = ((Agent.SkillToMaster).Create)(behavior, 201502)
  node5:SetTask(node6)
  node2:AddTask(node3)
  node2:AddTask(node5)
  local node7 = (Sequence.Create)()
  local node8 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node9 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 60)
  local node10 = (Sequence.Create)()
  local node11 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201440)
  local node12 = ((Agent.UseSkill).Create)(behavior, 201440)
  local node13 = ((Agent.ClearSkillCurrentTime).Create)(behavior, 201440)
  node10:AddTask(node11)
  node10:AddTask(node12)
  node10:AddTask(node13)
  node7:AddTask(node8)
  node7:AddTask(node9)
  node7:AddTask(node10)
  node1:AddTask(node2)
  node1:AddTask(node7)
  return node1
end

return CreateNewBattleAIfb31

