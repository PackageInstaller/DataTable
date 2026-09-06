local CBattleKill = dataclass("CBattleKill")
CBattleKill.ProtocolType = 27
CBattleKill.type = 0

function CBattleKill:Ctor(client)
end

function CBattleKill:Marshal(data)
  data.type = self.type
end

function CBattleKill:Unmarshal(data)
  self.type = data.type
  return true
end

function CBattleKill:CheckVariable()
  if type(self.type) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.type) = %s. number required.", type(self.type))
    return false
  end
  return true
end

return CBattleKill
