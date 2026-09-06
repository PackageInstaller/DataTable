local SBattlePause = dataclass("SBattlePause")
SBattlePause.ProtocolType = 41
SBattlePause.pauseType = 0
SBattlePause.param = ""

function SBattlePause:Ctor(client)
end

function SBattlePause:Marshal(data)
  data.pauseType = self.pauseType
  data.param = self.param
end

function SBattlePause:Unmarshal(data)
  self.pauseType = data.pauseType
  self.param = data.param
  return true
end

function SBattlePause:CheckVariable()
  if type(self.pauseType) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.pauseType) = %s. number required.", type(self.pauseType))
    return false
  end
  if type(self.param) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.param) = %s. string required.", type(self.param))
    return false
  end
  return true
end

return SBattlePause
