-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/removeeventeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local RemoveEventEffect = class("RemoveEventEffect", EffectBase)
RemoveEventEffect.Ctor = function(self, id)
  -- function num : 0_0
  self._eventID = id
end

RemoveEventEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  local r = (EventManager.RemoveByConfigID)(self._eventID)
  print("remove event effect", r, self._eventID, (debug.traceback)())
end

return RemoveEventEffect

