-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/waitframes.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local WaitFrames = class("WaitFrames", Task)
WaitFrames.Ctor = function(self, totalFrames)
  -- function num : 0_0 , upvalues : WaitFrames
  ((WaitFrames.super).Ctor)(self)
  self._countFrame = 0
  self._totalFrames = totalFrames
end

WaitFrames.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : Behavior_Status
  self._countFrame = self._countFrame + 1
  if self._totalFrames <= self._countFrame then
    self._countFrame = self._totalFrames
    return Behavior_Status.Success
  end
  return Behavior_Status.Running
end

WaitFrames.GetCheckPoints = function(self)
  -- function num : 0_2
  return self._totalFrames - self._countFrame
end

return WaitFrames

