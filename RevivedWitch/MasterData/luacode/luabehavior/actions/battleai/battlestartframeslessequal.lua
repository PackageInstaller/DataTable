-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/battlestartframeslessequal.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local BattleStartFramesLessEqual = class("BattleStartFramesLessEqual", Task)
BattleStartFramesLessEqual.Ctor = function(self, context, frames)
  -- function num : 0_0 , upvalues : BattleStartFramesLessEqual
  ((BattleStartFramesLessEqual.super).Ctor)(self)
  self._context = context
  self._frames = frames
end

BattleStartFramesLessEqual.OnStart = function(self)
  -- function num : 0_1
end

BattleStartFramesLessEqual.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  local frames = ((self._context)._battleworld)._battleWorldStartFrames
  if frames <= self._frames then
    return TaskStatus.Success
  else
    return TaskStatus.Failure
  end
end

BattleStartFramesLessEqual.OnEnd = function(self)
  -- function num : 0_3
end

return BattleStartFramesLessEqual

