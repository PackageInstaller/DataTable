-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/splayaudio.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPlayAudio = dataclass("SPlayAudio")
SPlayAudio.ProtocolType = 38
SPlayAudio.audioid = 0
SPlayAudio.audiovalue = 0
SPlayAudio.Ctor = function(self, client)
  -- function num : 0_0
end

SPlayAudio.Marshal = function(self, data)
  -- function num : 0_1
  data.audioid = self.audioid
  data.audiovalue = self.audiovalue
end

SPlayAudio.Unmarshal = function(self, data)
  -- function num : 0_2
  self.audioid = data.audioid
  self.audiovalue = data.audiovalue
  return true
end

SPlayAudio.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.audioid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.audioid) = %s. number required.", type(self.audioid))
    return false
  end
  if type(self.audiovalue) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.audiovalue) = %s. number required.", type(self.audiovalue))
    return false
  end
  return true
end

return SPlayAudio

