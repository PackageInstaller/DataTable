local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local BgmEffect = class("BgmEffect", EffectBase)

function BgmEffect:Ctor(state, bgm_id)
  self._state = state
  self._id = bgm_id
end

function BgmEffect:Run()
  if self._state == "play" then
    if LuaAudioManager.IfAudioIsVoice(self._id) then
      LuaAudioManager.PlayVoice(self._id)
    else
      LuaAudioManager.PlayBGM(self._id)
    end
  elseif self._state == "pause" then
    LuaAudioManager.PauseBGM(self._id)
  elseif self._state == "resume" then
    LuaAudioManager.ResumeBGM(self._id)
  elseif self._state == "stop" then
    LuaAudioManager.StopBGM(self._id)
  end
end

return BgmEffect
