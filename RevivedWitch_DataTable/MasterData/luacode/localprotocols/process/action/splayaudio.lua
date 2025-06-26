-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/splayaudio.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPlayAudio = require("localprotocols.def.action.splayaudio")
SPlayAudio.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPlayAudio Process")
  end
  if controller.OnSPlayAudio then
    controller:OnSPlayAudio(self)
  end
end

return SPlayAudio

