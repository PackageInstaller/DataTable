-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif209.lua 

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
local Createnewbattleaif209 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = ((Agent.MonsterSkillCdRandom).Create)(behavior, 1, 30)
  local node4 = (Selector.Create)()
  local node5 = (Sequence.Create)()
  local node6 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201066)
  local node7 = ((Agent.UseSkill).Create)(behavior, 201066)
  node5:AddTask(node6)
  node5:AddTask(node7)
  local node8 = (Sequence.Create)()
  local node9 = ((Agent.MonsterHasBuff).Create)(behavior, 0, 20000)
  local node10 = (LoopUntil.Create)(behavior, 1, true)
  local node11 = ((Agent.UseSkill).Create)(behavior, 201158)
  node10:SetTask(node11)
  node8:AddTask(node9)
  node8:AddTask(node10)
  node4:AddTask(node5)
  node4:AddTask(node8)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  return node1
end

return Createnewbattleaif209

