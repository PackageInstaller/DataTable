local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshInvestActInfo = dataclass("SRefreshInvestActInfo", require("framework.net.protocol"))
SRefreshInvestActInfo.ProtocolType = 2659
SRefreshInvestActInfo.MaxSize = 65535
SRefreshInvestActInfo.close = 0
SRefreshInvestActInfo.actId = 0
SRefreshInvestActInfo.currentChannel = 0
SRefreshInvestActInfo.leftTimes = 0
SRefreshInvestActInfo.actLeftTime = 0
SRefreshInvestActInfo.todayFetched = 0

function SRefreshInvestActInfo:Ctor(client)
  SRefreshInvestActInfo.super.Ctor(self, client)
  self.channel = {}
end

function SRefreshInvestActInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.close) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.actId) then
    return false
  end
  local length = table.slen(self.channel)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.channel[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.currentChannel) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftTimes) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.actLeftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.todayFetched) then
    return false
  end
  return true
end

function SRefreshInvestActInfo:Unmarshal(buffer)
  local ret = true
  ret, self.close = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.actId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.channel[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.currentChannel = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.actLeftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.todayFetched = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshInvestActInfo
