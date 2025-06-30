-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/behavior/newskill/luaprojectileskill.lua 

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
local Agent = require("luabehavior.agent.skill")
local CreateLuaProjectileSkill = function(behavior)
  -- function num : 0_0 , upvalues : Sequence, Agent, LoopUntil
  local data = behavior._data
  local node1 = (Sequence.Create)()
  local node2 = ((Agent.Banner).Create)(behavior)
  local node3 = ((Agent.NextStage).Create)(behavior)
  local node4 = ((Agent.PlayAttackerAction).Create)(behavior, data.atkAction)
  local node5 = (LoopUntil.Create)(behavior, -1, false)
  local node6 = (Sequence.Create)()
  local node7 = ((Agent.ProjectileEffect).Create)(behavior, data.projectileEffectId)
  local node8 = ((Agent.PlayTargetEffect).Create)(behavior, data.hitEffectId)
  local node9 = ((Agent.Result).Create)(behavior)
  local node10 = ((Agent.NextStage).Create)(behavior)
  node6:AddTask(node7)
  node6:AddTask(node8)
  node6:AddTask(node9)
  node6:AddTask(node10)
  node5:SetTask(node6)
  node1:AddTask(node2)
  node1:AddTask(node3)
  node1:AddTask(node4)
  node1:AddTask(node5)
  return node1
end

return CreateLuaProjectileSkill

