local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local JumpEffect = class("JumpEffect", EffectBase)

function JumpEffect:Ctor(mapid, jumppointid)
  self._mapid = mapid
  self._jumppointid = jumppointid
end

function JumpEffect:Run(args)
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  print("jump from", self._mapid, self._jumppointid, debug.traceback())
  local req = LuaNetManager.CreateProtocol("protocol.battle.centerjumppoint")
  req.id = self._mapid
  req.outpoint = self._jumppointid
  LogInfoFormat("JumpEffect", "-- centerjumppoint -- id = %s, outpoint = %s ---", req.id, req.outpoint)
  req:Send()
end

return JumpEffect
