-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/jumpeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local JumpEffect = class("JumpEffect", EffectBase)
JumpEffect.Ctor = function(self, mapid, jumppointid)
  -- function num : 0_0
  self._mapid = mapid
  self._jumppointid = jumppointid
end

JumpEffect.Run = function(self, args)
  -- function num : 0_1 , upvalues : _ENV
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  print("jump from", self._mapid, self._jumppointid, (debug.traceback)())
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.centerjumppoint")
  req.id = self._mapid
  req.outpoint = self._jumppointid
  LogInfoFormat("JumpEffect", "-- centerjumppoint -- id = %s, outpoint = %s ---", req.id, req.outpoint)
  req:Send()
end

return JumpEffect

