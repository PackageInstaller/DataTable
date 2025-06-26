-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newbattle/newbattleai10019.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoopUntil = require("luabehavior.decorators.loopuntil")
local Not = require("luabehavior.decorators.not")
local IfElse = require("luabehavior.composites.ifelse")
local Parallel = require("luabehavior.composites.parallel")
local ReferencedBehavior = require("luabehavior.composites.referencedbehavior")
local Sequence = require("luabehavior.composites.sequence")
local Selector = require("luabehavior.composites.selector")
local Noop = require("luabehavior.actions.noop")
local Wait = require("luabehavior.actions.wait")
local Agent = require("luabehavior.agent.battleai")
local CreateNewBattleAI10019 = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.IsBattleEnd).Create)(behavior)
  local node3 = ((Agent.IsRoleDead).Create)(behavior)
  local node4 = ((Agent.IsRoleInOtherSkill).Create)(behavior)
  local node5 = ((Agent.TimeCycle).Create)(behavior, 30)
  local node6 = ((Agent.UseSkill).Create)(behavior, 201010)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  node1:AddTask(node5)
  node1:AddTask(node6)
  return node1
end

return CreateNewBattleAI10019

