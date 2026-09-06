local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CStartAlchemy = dataclass("CStartAlchemy", require("framework.net.protocol"))
CStartAlchemy.ProtocolType = 2350
CStartAlchemy.MaxSize = 65535
CStartAlchemy.formulaId = 0
CStartAlchemy.formulaNum = 0

function CStartAlchemy:Ctor(client)
  CStartAlchemy.super.Ctor(self, client)
end

function CStartAlchemy:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.formulaId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.formulaNum) then
    return false
  end
  return true
end

function CStartAlchemy:Unmarshal(buffer)
  local ret = true
  ret, self.formulaId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.formulaNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStartAlchemy
