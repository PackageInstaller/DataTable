local SPlayAudio = dataclass("SPlayAudio")
SPlayAudio.ProtocolType = 38
SPlayAudio.audioid = 0
SPlayAudio.audiovalue = 0

function SPlayAudio:Ctor(client)
end

function SPlayAudio:Marshal(data)
  data.audioid = self.audioid
  data.audiovalue = self.audiovalue
end

function SPlayAudio:Unmarshal(data)
  self.audioid = data.audioid
  self.audiovalue = data.audiovalue
  return true
end

function SPlayAudio:CheckVariable()
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
