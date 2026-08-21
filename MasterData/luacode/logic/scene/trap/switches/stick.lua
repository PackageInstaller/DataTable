-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/stick.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local Stick = class("Stick", Switch)
Stick.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Stick
  ((Stick.super).Ctor)(self, ...)
end

Stick.Activate = function(self)
  -- function num : 0_1
  self:BuildStateEffects()
  self:BuildSceneObject()
end

Stick.Deactivate = function(self)
  -- function num : 0_2 , upvalues : Stick
  ((Stick.super).Deactivate)(self)
end

return Stick

