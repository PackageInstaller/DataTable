-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleaif418.lua 

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
local Createnewbattleaif418 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, Selector, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IsBattleEnd).Create)(behavior)
  local node3 = ((Agent.IsRoleDead).Create)(behavior)
  local node4 = ((Agent.IsRoleInOtherSkill).Create)(behavior)
  local node5 = (Selector.Create)()
  local node6 = (Sequence.Create)()
  local node7 = ((Agent.MonsterWithoutBuff).Create)(behavior, 421, -1, 20279)
  local node8 = (LoopUntil.Create)(behavior, 1, true)
  local node9 = ((Agent.UseSkill).Create)(behavior, 201211)
  node8:SetTask(node9)
  node6:AddTask(node7)
  node6:AddTask(node8)
  local node10 = (Sequence.Create)()
  local node11 = ((Agent.MonsterWithoutBuff).Create)(behavior, 421, -1, 20279)
  local node12 = ((Agent.MonsterWithoutBuff).Create)(behavior, 418, -1, 20283)
  local node13 = (LoopUntil.Create)(behavior, 1, true)
  local node14 = ((Agent.RunAway).Create)(behavior, "RunAway")
  node13:SetTask(node14)
  node10:AddTask(node11)
  node10:AddTask(node12)
  node10:AddTask(node13)
  node5:AddTask(node6)
  node5:AddTask(node10)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  node1:AddTask(node5)
  return node1
end

return Createnewbattleaif418

