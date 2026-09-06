local CCloseDataBase = dataclass("CCloseDataBase")
CCloseDataBase.ProtocolType = 302

function CCloseDataBase:Ctor(client)
end

function CCloseDataBase:Marshal(data)
end

function CCloseDataBase:Unmarshal(data)
  return true
end

function CCloseDataBase:CheckVariable()
  return true
end

return CCloseDataBase
