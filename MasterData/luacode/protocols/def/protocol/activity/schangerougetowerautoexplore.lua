local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeRougeTowerAutoExplore = dataclass("SChangeRougeTowerAutoExplore", require("framework.net.protocol"))
SChangeRougeTowerAutoExplore.ProtocolType = 2453
SChangeRougeTowerAutoExplore.MaxSize = 65535
SChangeRougeTowerAutoExplore.result = 0
SChangeRougeTowerAutoExplore.switchState = 0

function SChangeRougeTowerAutoExplore:Ctor(client)
  SChangeRougeTowerAutoExplore.super.Ctor(self, client)
end

function SChangeRougeTowerAutoExplore:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.switchState) then
    return false
  end
  return true
end

function SChangeRougeTowerAutoExplore:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.switchState = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeRougeTowerAutoExplore
