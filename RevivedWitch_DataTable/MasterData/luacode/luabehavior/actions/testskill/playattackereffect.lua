-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/testskill/playattackereffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local PlayAttackerEffect = class("PlayAttackerEffect", Task)
PlayAttackerEffect.Ctor = function(self, context, actionName)
  -- function num : 0_0 , upvalues : PlayAttackerEffect
  ((PlayAttackerEffect.super).Ctor)(self)
  self._context = context
  self._actionName = actionName
  self._time = 0
  self._totalTime = 200
  self._handle = 0
end

PlayAttackerEffect.OnStart = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._time = 0
  self._handle = (((BattleECS.Utilitys).FighterUtility).PlayAction)((self._context).world, ((self._context).attacker)._entityId, self._actionName)
end

PlayAttackerEffect.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  self._time = self._time + deltaTime
  if self._totalTime <= self._time then
    self._time = self._totalTime
    return TaskStatus.Success
  end
  return TaskStatus.Running
end

PlayAttackerEffect.OnEnd = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self._handle then
    (((BattleECS.Utilitys).FighterUtility).StopAction)((self._context).world, ((self._context).attacker)._entityId, self._handle)
  end
end

PlayAttackerEffect.GetCheckPoints = function(self)
  -- function num : 0_4
  return self._totalTime - self._time
end

return PlayAttackerEffect

