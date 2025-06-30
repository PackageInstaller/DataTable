-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif525.lua 

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
local Createnewbattleaif525 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IfHasEnoughConditionsUseSkill).Create)(behavior)
  local node3 = (Selector.Create)()
  local node4 = (Sequence.Create)()
  local node5 = ((Agent.MonsterHpPercentSection).Create)(behavior, 0, 0, 30)
  local node6 = (LoopUntil.Create)(behavior, 1, true)
  local node7 = ((Agent.UseSkill).Create)(behavior, 201536)
  node6:SetTask(node7)
  local node8 = ((Agent.ClearSkillCurrentTime).Create)(behavior, 201535)
  node4:AddTask(node5)
  node4:AddTask(node6)
  node4:AddTask(node8)
  local node9 = (Sequence.Create)()
  local node10 = ((Agent.MonsterSkillIsInCD).Create)(behavior, 201535)
  local node11 = ((Agent.UseSkill).Create)(behavior, 201535)
  node9:AddTask(node10)
  node9:AddTask(node11)
  node3:AddTask(node4)
  node3:AddTask(node9)
  node1:AddTask(node2)
  node1:AddTask(node3)
  return node1
end

return Createnewbattleaif525

