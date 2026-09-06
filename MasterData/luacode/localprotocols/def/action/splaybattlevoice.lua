local SPlayBattleVoice = dataclass("SPlayBattleVoice")
SPlayBattleVoice.ProtocolType = 54
SPlayBattleVoice.roleId = 0
SPlayBattleVoice.voiceType = ""
SPlayBattleVoice.index = 0

function SPlayBattleVoice:Ctor(client)
end

function SPlayBattleVoice:Marshal(data)
  data.roleId = self.roleId
  data.voiceType = self.voiceType
  data.index = self.index
end

function SPlayBattleVoice:Unmarshal(data)
  self.roleId = data.roleId
  self.voiceType = data.voiceType
  self.index = data.index
  return true
end

function SPlayBattleVoice:CheckVariable()
  if type(self.roleId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.roleId) = %s. number required.", type(self.roleId))
    return false
  end
  if type(self.voiceType) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.voiceType) = %s. string required.", type(self.voiceType))
    return false
  end
  if type(self.index) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.index) = %s. number required.", type(self.index))
    return false
  end
  return true
end

return SPlayBattleVoice
