local CBreakOutPower = dataclass("CBreakOutPower")
CBreakOutPower.ProtocolType = 10

function CBreakOutPower:Ctor(client)
end

function CBreakOutPower:Marshal(data)
end

function CBreakOutPower:Unmarshal(data)
  return true
end

function CBreakOutPower:CheckVariable()
  return true
end

return CBreakOutPower
