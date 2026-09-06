local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRougeTowerInitialBuffChoose = dataclass("SRougeTowerInitialBuffChoose", require("framework.net.protocol"))
SRougeTowerInitialBuffChoose.ProtocolType = 2450
SRougeTowerInitialBuffChoose.MaxSize = 65535

function SRougeTowerInitialBuffChoose:Ctor(client)
  SRougeTowerInitialBuffChoose.super.Ctor(self, client)
  self.buff = {}
end

function SRougeTowerInitialBuffChoose:Marshal(buffer)
  local length = table.slen(self.buff)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.buff[i]) then
      return false
    end
  end
  return true
end

function SRougeTowerInitialBuffChoose:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.buff[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SRougeTowerInitialBuffChoose
