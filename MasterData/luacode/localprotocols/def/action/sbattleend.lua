local SBattleEnd = dataclass("SBattleEnd")
SBattleEnd.ProtocolType = 12
SBattleEnd.type = 0
SBattleEnd.isjoin = 0

function SBattleEnd:Ctor(client)
end

function SBattleEnd:Marshal(data)
  data.type = self.type
  data.isjoin = self.isjoin
end

function SBattleEnd:Unmarshal(data)
  self.type = data.type
  self.isjoin = data.isjoin
  return true
end

function SBattleEnd:CheckVariable()
  if type(self.type) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.type) = %s. number required.", type(self.type))
    return false
  end
  if type(self.isjoin) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isjoin) = %s. number required.", type(self.isjoin))
    return false
  end
  return true
end

return SBattleEnd
