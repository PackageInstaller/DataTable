local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CStartTrain = dataclass("CStartTrain", require("framework.net.protocol"))
CStartTrain.ProtocolType = 2372
CStartTrain.MaxSize = 65535
CStartTrain.index = 0
CStartTrain.roleId = 0

function CStartTrain:Ctor(client)
  CStartTrain.super.Ctor(self, client)
end

function CStartTrain:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CStartTrain:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStartTrain
