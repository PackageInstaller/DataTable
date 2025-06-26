-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/dualstick.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local DualStick = class("DualStick", Switch)
DualStick.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DualStick
  ((DualStick.super).Ctor)(self, ...)
end

DualStick.Activate = function(self)
  -- function num : 0_1
  self:BuildStateEffects()
  self:BuildSceneObject()
end

DualStick.Deactivate = function(self)
  -- function num : 0_2 , upvalues : DualStick
  ((DualStick.super).Deactivate)(self)
end

return DualStick

