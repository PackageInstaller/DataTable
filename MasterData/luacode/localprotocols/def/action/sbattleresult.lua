local SBattleResult = dataclass("SBattleResult")
SBattleResult.ProtocolType = 17
SBattleResult.type = 0
SBattleResult.isjoin = 0

function SBattleResult:Ctor(client)
end

function SBattleResult:Marshal(data)
  data.type = self.type
  data.isjoin = self.isjoin
end

function SBattleResult:Unmarshal(data)
  self.type = data.type
  self.isjoin = data.isjoin
  return true
end

function SBattleResult:CheckVariable()
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

return SBattleResult
