local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOfflineSweepInfo = dataclass("SOfflineSweepInfo", require("framework.net.protocol"))
SOfflineSweepInfo.ProtocolType = 4135
SOfflineSweepInfo.MaxSize = 65535
SOfflineSweepInfo.status = 0
SOfflineSweepInfo.battleType = 0
SOfflineSweepInfo.id = 0
SOfflineSweepInfo.leftTime = 0
SOfflineSweepInfo.totalNum = 0
SOfflineSweepInfo.leftNum = 0
SOfflineSweepInfo.receivedNum = 0

function SOfflineSweepInfo:Ctor(client)
  SOfflineSweepInfo.super.Ctor(self, client)
end

function SOfflineSweepInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.receivedNum) then
    return false
  end
  return true
end

function SOfflineSweepInfo:Unmarshal(buffer)
  local ret = true
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.totalNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.receivedNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOfflineSweepInfo
