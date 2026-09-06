local CResetNotReadNum = dataclass("CResetNotReadNum")
CResetNotReadNum.ProtocolType = 109
CResetNotReadNum.userId = 0

function CResetNotReadNum:Ctor(client)
end

function CResetNotReadNum:Marshal(data)
  data.userId = self.userId
end

function CResetNotReadNum:Unmarshal(data)
  self.userId = data.userId
  return true
end

function CResetNotReadNum:CheckVariable()
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  return true
end

return CResetNotReadNum
