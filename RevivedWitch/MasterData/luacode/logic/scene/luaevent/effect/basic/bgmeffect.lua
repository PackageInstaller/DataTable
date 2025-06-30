-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/bgmeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local BgmEffect = class("BgmEffect", EffectBase)
BgmEffect.Ctor = function(self, state, bgm_id)
  -- function num : 0_0
  self._state = state
  self._id = bgm_id
end

BgmEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._state == "play" then
    if (LuaAudioManager.IfAudioIsVoice)(self._id) then
      (LuaAudioManager.PlayVoice)(self._id)
    else
      ;
      (LuaAudioManager.PlayBGM)(self._id)
    end
  else
    if self._state == "pause" then
      (LuaAudioManager.PauseBGM)(self._id)
    else
      if self._state == "resume" then
        (LuaAudioManager.ResumeBGM)(self._id)
      else
        if self._state == "stop" then
          (LuaAudioManager.StopBGM)(self._id)
        end
      end
    end
  end
end

return BgmEffect

