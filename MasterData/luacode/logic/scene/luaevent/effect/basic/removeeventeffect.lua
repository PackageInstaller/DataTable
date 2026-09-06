local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local RemoveEventEffect = class("RemoveEventEffect", EffectBase)

function RemoveEventEffect:Ctor(id)
  self._eventID = id
end

function RemoveEventEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local r = EventManager.RemoveByConfigID(self._eventID)
  print("remove event effect", r, self._eventID, debug.traceback())
end

return RemoveEventEffect
